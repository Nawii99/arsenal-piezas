# Registro automático de facturas recibidas en Google Sheets…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Receta de n8n que, cada vez que llega una factura por Gmail, la registra sola en una hoja de cálculo, para no tener que apuntar cada gasto a mano de cara al trimestre.

## Qué es y qué hace

Receta de n8n que, cada vez que llega una factura por Gmail con la etiqueta de facturas, la registra sola en una hoja de cálculo de gastos del trimestre. Entran el correo con el PDF, la etiqueta de Gmail y la hoja de Google Sheets; sale una fila nueva por factura lista para el cierre. Requiere Gmail y Google Sheets, gratuitos, y una API de IA de pago por uso (Claude, Codex, Gemini o una IA local) para leer la factura, con un coste de céntimos por factura.

## Cómo usarla

1. Crea la etiqueta en Gmail y el filtro
2. Lee el PDF y extrae los datos
3. Escribe la fila en Google Sheets
4. Que lo revise un profesional

## Cuándo usarla

Te llegan facturas de proveedores por Gmail casi a diario y no quieres copiar cada una a la hoja de gastos del trimestre.

## Cómo ganar dinero con ella

Impláncala en el negocio de un autónomo o una pyme como servicio de gastos al día, con alta y mantenimiento mensual a [TU PRECIO]. Un gestor o asesor fiscal revisa los datos antes de declarar nada.

- Hoja de gastos al día para autónomos que reciben facturas de proveedores a diario.
- Registro automático de facturas para una pyme con un buzón compartido de compras.
- Servicio de mantenimiento del registro de gastos cobrado como cuota mensual.

**Precio orientativo:** 50–120 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

# Registro automático de facturas recibidas por email

## Qué ahorra
El rato diario de abrir cada factura que llega por email y copiar sus datos a mano en la hoja de gastos del trimestre.

## Cuentas necesarias
- Gmail o Google Workspace: gratis para uso normal, sin coste añadido en n8n.
- Google Sheets: gratis.
- Un proveedor de IA para leer la factura (por ejemplo OpenAI): de pago por uso, unos céntimos por factura, no tiene tier gratis permanente. Revisa el gasto acumulado en su panel de vez en cuando.

## Nodos, en orden
1. Gmail Trigger: se activa con correos nuevos que tengan la etiqueta 'Facturas-autonomo'. Crea antes esa etiqueta en Gmail y ponla como filtro manual sobre los correos de proveedores.
2. Nodo Filter: comprueba que el correo trae un adjunto PDF. Si no lo trae, corta el flujo aquí para no procesar correos sin factura.
3. Nodo Extract from File: saca el texto del PDF adjunto.
4. Nodo de IA (por ejemplo OpenAI): usa como instrucción la pieza 'Extracción de datos de factura española' para convertir ese texto en los campos estructurados (número, fecha, emisor, base, IVA, total).
5. Nodo Google Sheets - Append Row: añade una fila nueva en una hoja llamada 'Registro de facturas [AÑO]' con esos campos.
6. Nodo Gmail - Add Label: marca el correo original como 'procesado' para que no se vuelva a registrar si el flujo se ejecuta otra vez.

## Cómo probarla sin liarla
Antes de activar el disparador en automático, ejecuta el flujo a mano ('test workflow') con dos o tres facturas reales de ejemplo y revisa fila por fila que los datos en la hoja de cálculo coinciden con la factura original.
Las primeras dos semanas revisa la hoja una vez por semana: si la IA extrae mal un importe y no te das cuenta, ese error se queda metido en tu contabilidad del trimestre.
No conectes este flujo directamente a la presentación de ningún modelo fiscal: es solo un registro de apoyo, la declaración la revisa siempre una persona.
