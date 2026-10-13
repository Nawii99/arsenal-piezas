---
name: stock-coherente-zoho-inventory
description: Compara el stock de Zoho Inventory con tus canales de venta, localiza descuadres por SKU y prepara los ajustes para que los apruebes. Úsala cuando haya ventas sin stock, devoluciones sin reponer o cifras que no cuadran entre canales.
---

# Stock coherente en Zoho Inventory

Instalación: guarda este texto como SKILL.md dentro de la carpeta .claude/skills/stock-coherente-zoho-inventory/ de tu proyecto. Claude Code la activa cuando hablas de stock, inventario o descuadres; también puedes nombrarla tú.

## Qué hace
- Compara el stock de Zoho Inventory con el de cada canal de venta.
- Empareja por SKU (el código único de cada producto) y localiza descuadres, productos que faltan en un lado y stocks negativos.
- Propone las causas más probables, siempre como hipótesis.
- Prepara los ajustes en una tabla que apruebas tú. No los aplica solo.
- Esta skill no vigila sola: revisa cuando se lo pides. Para vigilar sin ti usa la sincronización propia del canal o una automatización aparte, por ejemplo en n8n.

## Cómo se conecta (dos formas)
- Con conector (MCP): es un enlace que deja a Claude Code hablar con Zoho. Escribe /mcp para ver los que tienes. Si no hay ninguno, pídele a Claude Code que te guíe para añadirlo [COMPRUEBA EN LA DOCUMENTACIÓN DE ZOHO SI HAY CONECTOR OFICIAL Y QUÉ PERMISOS PIDE].
- Sin conector: exportas el stock de Zoho Inventory y el de cada canal a CSV; Claude los compara y te devuelve una hoja con los descuadres. Los ajustes los haces tú en Zoho. Empieza por aquí.
- Tu cuenta vive en un centro de datos de Zoho (en España suele ser el europeo, con direcciones zoho.eu). El conector debe apuntar al mismo.
- Crea el acceso con permisos mínimos y, si puedes, de solo lectura para la revisión.

## Antes de empezar, pregunta
1. ¿Qué canales vendes y desde cuál se gestiona el stock real? Zoho Inventory suele ser el maestro, pero confírmalo.
2. ¿Qué almacenes hay? Compara cada almacén por separado.
3. ¿Los productos tienen SKU o código de barras (EAN) en todos los canales?
4. ¿Hay packs o kits cuyo stock depende de otros productos?
5. ¿Hay productos con lote, caducidad o número de serie?
6. ¿Qué diferencia consideras pequeña y cuál grande? [UMBRAL]
7. ¿Quieres un stock de seguridad por canal (unidades que no se ofrecen para evitar vender de más)? [UNIDADES]

## Paso a paso
1. Reúne las exportaciones o lee los datos por conector. Anota la fecha y hora de cada una: un stock de hace tres días no se compara con uno de hoy.
2. Normaliza los SKU: mayúsculas, sin espacios, sin ceros perdidos. Empareja por SKU o EAN, nunca por nombre.
3. Comprueba lo básico: SKU duplicados, productos sin SKU, stock negativo, variantes (talla, color) y packs.
4. Compara la misma medida en todos los sitios: stock físico, stock comprometido en pedidos pendientes y stock disponible. Mezclarlas es la causa más común de falsos descuadres.
5. Calcula las diferencias y clasifica: Cuadra, Diferencia pequeña, Diferencia grande y Falta en un lado.
6. Para cada diferencia grande, busca pistas: pedido pendiente sin sincronizar, devolución sin reponer, SKU renombrado, error de recuento. Preséntalo como hipótesis con la evidencia que la apoya.
7. Prepara la propuesta de ajuste: SKU, almacén, cantidad actual, cantidad propuesta, motivo y quién lo aprueba.
8. Espera la aprobación escrita. Después, aplica por lotes pequeños (si tienes conector) o entrega la hoja para que lo hagas tú. Guarda un registro con valor anterior y valor nuevo.
9. Propón el stock de seguridad por canal, pero no lo apliques sin que lo apruebes.

## Qué devolver
- Un resumen de cinco líneas: SKU revisados, que cuadran, con diferencia pequeña, con diferencia grande y sin pareja.
- Una tabla de descuadres ordenada de mayor a menor impacto, con la causa probable y la evidencia.
- La propuesta de ajustes lista para aprobar.
- La lista de SKU con problemas de datos (duplicados, sin código, negativos).
- Lo que no se ha podido comprobar, con la fecha y hora de cada fuente.

## Qué NO hacer
- No apliques ajustes de stock sin aprobación escrita. Un ajuste cambia el valor del almacén y, si tienes contabilidad conectada, puede generar un apunte.
- No borres productos. Si ya no se venden, propón marcarlos como inactivos y que lo apruebe una persona.
- No cambies precios, costes, impuestos ni proveedores.
- No toques lotes, caducidades ni números de serie sin una persona delante: en alimentación, cosmética o material sanitario hay obligaciones de trazabilidad.
- No empareles productos por nombre.
- No cuentes como disponible el stock reservado para pedidos pendientes.
- No canceles pedidos ni escribas a clientes para disculparte: eso lo decide una persona.
- No prometas tiempo real ni cifras de ventas recuperadas.
- No pegues contraseñas, tokens ni claves en el chat.

## Cuándo pedir a una persona
- Antes de aplicar cualquier ajuste: lo aprueba quien responde del almacén.
- Si el descuadre apunta a pérdida, rotura o robo: lo revisa el responsable del negocio, no un asistente.
- Para ajustes que afecten a la valoración del stock o a la contabilidad: tu gestor o contable.
- Si vendes en marketplaces: lee sus condiciones, porque suelen penalizar las cancelaciones por falta de stock [COMPRUEBA LAS NORMAS DE CADA MARKETPLACE].
- Si vendes productos con lote, caducidad o trazabilidad obligatoria: una persona con conocimiento del sector.
