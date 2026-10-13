# Zapier: pedidos de Shopify a Google Sheets con aviso…

**Tipo:** Receta de automatización · **Área:** Tienda por internet · **Licencia:** CC BY 4.0

Un Zap de Zapier que apunta cada pedido pagado de Shopify en Google Sheets y te avisa por Gmail solo de los que conviene revisar a mano: importe alto, envío fuera o nota.

## Qué es y qué hace

Zap de Zapier que apunta cada pedido pagado de Shopify en una hoja de Google Sheets y te avisa por Gmail solo de los que conviene revisar: importe alto, envío fuera de España o nota del cliente. Entran pedidos pagados; salen una fila y, si procede, un correo de aviso. No cambia estados, no reembolsa y no toca el stock.

## Cómo usarla

1. Crea la hoja Pedidos y define los umbrales
2. Conecta Shopify con permisos de lectura
3. Prueba con un pedido de prueba y comprueba el aviso
4. Que lo revise un profesional

## Cuándo usarla

Cuando vendes online y llevas los pedidos en la cabeza o en varias pestañas, y quieres que los casos raros no pasen desapercibidos.

## Cómo ganar dinero con ella

Móntala a tiendas online pequeñas: [TU PRECIO] de montaje y [TU PRECIO] al mes por mantener la hoja, los filtros y las reglas de aviso.

- Registro y alertas de pedidos para tiendas online pequeñas que llevan los pedidos en varias pestañas.
- Mantenimiento mensual de filtros y reglas de aviso, con revisión de pedidos sin registrar.
- Panel semanal de pedidos destacados para el responsable de atención al cliente.

**Precio orientativo:** 150–350 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

RECETA DE ZAPIER: pedidos de Shopify a Google Sheets con aviso
QUÉ HACE
Cada vez que entra un pedido pagado en tu tienda de Shopify, el Zap lo apunta en una hoja de Google Sheets.
Solo te manda un correo de aviso cuando el pedido tiene algo que conviene mirar: importe alto, envío fuera de España o nota del cliente.
El Zap solo lee pedidos. No cambia estados, no reembolsa y no toca el stock.
QUÉ NECESITAS
Una cuenta de Zapier.
Una tienda de Shopify y una cuenta con permiso para conectar aplicaciones.
Una cuenta de Google con Google Sheets y Gmail.
Una hoja llamada Pedidos con las columnas Fecha, Nº pedido, Productos, Importe, Moneda, País, Ciudad, Estado y Notas.
PASOS (un Trigger y varias Action, en este orden)
Paso 1 · Trigger · Shopify · New Paid Order
- Account: conecta tu tienda. Zapier te enseñará qué permisos pide. Léelos antes de aceptar.
- Si no ves New Paid Order, usa New Order y añade un Filter con el campo del estado de pago, (Text) Exactly matches, paid. Mira en Test cómo se llama el campo y qué texto trae.
- Pulsa Test trigger. Zapier traerá un pedido real reciente. Úsalo solo para la prueba.
- Mira en Test cómo se llaman los campos de fecha, número de pedido, importe, moneda, país, ciudad, productos y nota.
Paso 2 · Action · Google Sheets · Create Spreadsheet Row
- Drive, Spreadsheet y Worksheet: tu hoja Pedidos.
- Fecha, Nº pedido, Importe, Moneda, País y Ciudad: sus campos del Paso 1.
- Productos: el campo con los nombres de los artículos del pedido. Si el pedido tiene varios, mira en Test cómo llegan.
- Estado: escribe Por preparar.
- No copies el nombre completo, el teléfono, el email ni la dirección completa del comprador.
Paso 3 · Action · Filter by Zapier · Only continue if
- Primer grupo: el importe total, (Number) Greater than, el número que decidas, por ejemplo 150.
- Segundo grupo, con OR: el código de país de envío, (Text) Does not exactly match, ES.
- Tercer grupo, con OR: la nota del pedido, (Text) Exists.
- Así solo pasan al aviso los pedidos que cumplen alguna de las tres condiciones.
- Si vendes en más de una moneda, el importe no es comparable entre monedas. Ajusta la regla.
- Un pedido sin envío (producto digital) puede no traer país y saltar el aviso. Mira cómo te llega.
Paso 4 · Action · Gmail · Send Email
- To: tu correo.
- Subject: Pedido por revisar, seguido del número.
- Body: número de pedido, importe, país, la nota si la hay y el enlace a tu hoja Pedidos.
- No pongas en el correo datos personales del comprador.
CÓMO PROBARLA
Haz Test en cada paso con el pedido que Zapier te trae. No hace falta crear pedidos de prueba.
Ese pedido ya es real. Deja su fila en la hoja como válida o márcala como Prueba en Notas, para no contarla dos veces.
Paso 2: comprueba que hay UNA fila y que no guarda datos personales de más.
Paso 3: mira si el pedido pasa o se detiene según tus reglas. Cambia el importe de la regla para ver las dos salidas y déjalo como estaba.
Paso 4: comprueba que el correo te llega solo cuando el pedido pasa el filtro.
CUÁNTO CUESTA
Mira en la web de Zapier si hay plan gratuito para probar, cuántas tareas incluye tu plan y qué pasos cuentan como tarea.
Mira también si la app de Shopify exige un plan concreto.
Cada pedido ejecuta al menos un par de pasos y alguno más si pasa el filtro. Con muchos pedidos al día, calcula el total mensual y compáralo con el límite de tu plan.
QUÉ NO HACER
No añadas acciones que cambien algo en Shopify (reembolsos, stock, estados, precios) sin probarlas mucho en una tienda de pruebas.
No uses los correos de compradores para mandar promociones desde este Zap. Necesitas su permiso aparte.
No guardes dirección completa, teléfono ni email si no los necesitas. Menos datos, menos riesgo.
Aunque no los guardes en la hoja, Zapier puede recibir esos datos del pedido. Mira en su web su acuerdo de tratamiento de datos y recoge en tu política de privacidad que usas herramientas externas.
No conectes una tienda que no es tuya sin permiso por escrito de su dueño. No pidas ni guardes su contraseña.
QUÉ REVISAR A MANO ANTES DE ACTIVARLA
Que Zapier está conectado a la tienda correcta, no a una de pruebas.
Que los umbrales del filtro (importe, país) son los que quieres.
Que la hoja Pedidos no se comparte con enlace público.
Que una persona revisa a mano los pedidos con aviso antes de prepararlos. El Zap solo señala, no decide.
Cuánto tiempo guardas la hoja y quién la borra.
Si un comprador pide borrar sus datos, quítalos también de la hoja y de Gmail.
