---
name: especificacion-edi-odoo
description: Prepara la especificación de una integración EDI (EDIFACT o X12) con Odoo a partir de la guía del cliente, con tablas de mapeo, validaciones, casos de prueba y plan de puesta en marcha. Úsala cuando pidan conectar Odoo con pedidos, avisos de envío o facturas por EDI.
---

# Especificación de EDI con Odoo para pymes

## Qué hace
Prepara el plano del proyecto: qué mensaje EDI llega o sale, qué significa cada dato y dónde va en Odoo.
No instala nada ni toca tu Odoo. Entrega un documento que un integrador de Odoo o un operador EDI puede implementar.
EDI es el intercambio de documentos entre empresas en formatos fijos: pedido, confirmación, aviso de envío y factura. En Europa se usa mucho EDIFACT (en España, las guías EANCOM de AECOC). X12 es más habitual en EE. UU.
| Documento | EDIFACT | X12 |
| --- | --- | --- |
| Pedido | ORDERS | 850 |
| Confirmación de pedido | ORDRSP | 855 |
| Aviso de envío | DESADV | 856 |
| Factura | INVOIC | 810 |
Riesgo real: un aviso de envío o una factura erróneos pueden acarrear devoluciones, retrasos de cobro o penalizaciones del cliente. Mira tu contrato: [PENALIZACIONES].

## Qué preguntar antes de empezar
Pregunta todo junto, en lista, y espera. Sin la guía del cliente no hay especificación fiable: pídela primero.
1. Quién es el socio comercial, qué mensajes exige, en qué formato y versión (por ejemplo, una versión de directorio EDIFACT o de X12). Pide el PDF de su guía de implementación y archivos de ejemplo.
2. Cómo viajan los mensajes: operador EDI, AS2, SFTP o correo. Si ya tienes operador y quién lo paga.
3. Versión de Odoo, si es Community o Enterprise, dónde está alojado, qué módulos usas (ventas, inventario, facturación, localización española) y quién es tu integrador.
4. Cómo identificas hoy a clientes y productos: códigos de localización (GLN), códigos de barras (GTIN o EAN) o referencias propias. Si hay tabla de equivalencias.
5. Volumen: pedidos por día o semana, picos y líneas por pedido.
6. Quién resuelve los errores cuando un pedido no entra, y en qué horario.
7. Plazos de certificación que exige el cliente.
8. Cómo emites hoy las facturas y si cumplen la normativa española de facturación electrónica y de sistemas de facturación: [CONFIRMA FECHAS Y OBLIGACIONES VIGENTES CON TU GESTOR].

## Paso a paso
1. Lee la guía del socio y resume en una página: mensajes, datos obligatorios y opcionales, códigos que usa y plazos de respuesta. Marca las dudas con [PREGUNTAR AL SOCIO].
2. Haz una tabla de mapeo por mensaje con estas columnas: segmento o campo del mensaje, qué significa en lenguaje normal, dónde va en Odoo, regla de transformación, obligatorio sí o no, ejemplo y duda.
3. Ejemplo de mapeo de un pedido EDIFACT: BGM es el número de pedido del cliente y va a la referencia del cliente del pedido de venta. DTM trae la fecha del pedido y la de entrega pedida. NAD distingue comprador, lugar de entrega y quien recibe la factura. LIN, PIA e IMD identifican el producto. QTY es la cantidad y PRI el precio. En X12 850 hacen lo mismo BEG, N1, PO1 y sus compañeros. Confirma siempre cada uno con la guía.
4. Escribe las reglas de validación de entrada: el cliente existe y está activo, el código de producto existe, la cantidad es válida, el precio coincide con la tarifa pactada (con la tolerancia acordada), la fecha de entrega es posible, el pedido no está duplicado y no se supera el crédito. De cada regla di qué pasa si falla: rechazar con motivo o enviar a revisión humana.
5. Describe el flujo del pedido. Entra el mensaje, se crea el pedido en borrador, se validan las reglas y solo si pasa todo se confirma y se devuelve la confirmación. Si algo falla, va a una bandeja de excepciones con una persona asignada. Durante las primeras [X] semanas, todo pasa por revisión humana (funcionamiento en paralelo).
6. Describe las salidas. El aviso de envío se genera desde el albarán de Odoo, con bultos o palés si el cliente lo exige. La factura sale de la factura confirmada, con importes, IVA y totales que cuadren con el pedido.
7. Define excepciones y reintentos: duplicados, mensajes mal formados y acuses técnicos (CONTRL en EDIFACT; 997 o 999 en X12).
8. Crea casos de prueba con datos inventados, nunca reales: pedido normal, producto desconocido, cantidad cero, precio distinto, pedido duplicado, dirección nueva y mensaje corrupto. De cada uno, el resultado esperado.
9. Plan de puesta en marcha: pruebas internas, pruebas en el entorno de test del socio, certificación, funcionamiento en paralelo y producción. Quién aprueba cada paso.
10. Lista de preguntas abiertas para el integrador y el operador, con [PRESUPUESTO] y plazos por confirmar.

## Qué devolver y con qué formato
- Un documento `especificacion-edi-odoo.md` con: resumen, tablas de mapeo por mensaje, reglas de validación, flujos en lista de pasos (sin diagramas complicados), casos de prueba, plan y preguntas abiertas.
- Los casos de prueba también en CSV con punto y coma, para abrir en Excel.
- Cada término técnico, explicado entre paréntesis la primera vez.
- Cada dato con su origen: página de la guía o ejemplo del socio. Si no consta, escribe [NO CONSTA EN LA GUÍA].

## Qué revisa una persona antes de implementar
- Tu responsable de operaciones o logística: que el flujo coincide con cómo trabajáis de verdad.
- El integrador de Odoo o un desarrollador: que es viable y cuáles son los nombres exactos de los campos en tu versión.
- Tu gestor o administración: la parte de facturas e impuestos.
- El socio comercial: que confirma tu interpretación de su guía en su entorno de pruebas. Claude puede equivocarse con códigos y versiones. Todo se contrasta con la guía.

## Qué NO hacer
- No inventes segmentos, códigos ni campos que no estén en la guía.
- No des por hecho que dos clientes usan el mismo formato aunque el mensaje se llame igual.
- No pegues en el chat pedidos reales con datos de personas de contacto (nombres, teléfonos, correos). Aplica el RGPD. Para pruebas, datos inventados.
- No toques la base de datos de producción de Odoo ni instales módulos en ella. Todo se prueba en una copia.
- No actives la confirmación automática de pedidos ni el envío de facturas por EDI sin un periodo en paralelo y la firma de la persona responsable.
- No prometas que quedará «homologado». La certificación la da el socio comercial.
- No des por hecho que existe un módulo de Odoo que lo resuelve todo. Antes de recomendar uno, comprueba qué cubre, para qué versión y quién lo mantiene: [MÓDULO Y VERSIÓN].
- No guardes usuarios, contraseñas ni claves (SFTP, AS2, Odoo) en la especificación ni en el chat.

## Dónde guardarla
Guarda este archivo como `.claude/skills/especificacion-edi-odoo/SKILL.md` en tu proyecto. Claude la usa cuando le pides algo parecido, o la llamas con `/especificacion-edi-odoo`.
Texto revisado en octubre de 2026. Las versiones de Odoo y las obligaciones de facturación cambian: confírmalas antes de cerrar el proyecto.
