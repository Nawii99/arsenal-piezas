# Make (make.com): pedidos de Shopify a Google Sheets con avis…

**Tipo:** Receta de automatización · **Área:** Tienda por internet · **Licencia:** CC BY 4.0

Un escenario de Make (make.com) que copia cada pedido pagado de tu tienda Shopify a una hoja de Google Sheets y te avisa por correo cuando el pedido es grande o se envía fuera de España.

## Qué es y qué hace

Escenario de Make (make.com) que copia cada pedido pagado de tu tienda Shopify a una hoja de Google Sheets y te avisa por correo si el importe supera un umbral o el envío es fuera de España. Entran pedidos pagados con permisos de solo lectura; salen una fila por pedido y avisos. No cancela, no reembolsa ni marca envíos.

## Cómo usarla

1. Crea la hoja Pedidos y define los umbrales con el cliente
2. Conecta Shopify con permisos de solo lectura de pedidos
3. Prueba con un pedido de prueba
4. Que lo revise un profesional

## Cuándo usarla

Úsala si tienes una tienda en Shopify y llevas a mano un registro de pedidos o quieres enterarte pronto de los pedidos que conviene mirar.

## Cómo ganar dinero con ella

Cobra [TU PRECIO] por montarla con la tienda del cliente y definir con él los umbrales de aviso.

- Registro automático de pedidos para tiendas online que llevan el control a mano en hojas.
- Mantenimiento mensual de la integración con revisión de pedidos que no llegaron a la hoja.
- Panel de pedidos fuera de España y de importes altos, con revisión semanal del responsable.

**Precio orientativo:** 200–400 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

QUÉ HACE
Cada vez que entra un pedido pagado en Shopify, el escenario añade una fila a una hoja de Google Sheets con los datos básicos del pedido.
Si el importe supera un umbral que fijas tú, o si el envío es fuera de España, te manda un correo para que lo mires.
Solo copia y avisa. No cancela, no reembolsa y no marca pedidos como enviados.
QUÉ NECESITAS
Una cuenta de Make (make.com). Mira en su web cuántas operaciones o créditos incluye tu plan.
Una tienda Shopify y permiso para conectar apps. Make te guiará al conectarla. Si creas la conexión con una app personalizada de Shopify, marca solo los permisos de lectura de pedidos.
Una cuenta de Google con Google Sheets y Gmail.
Una hoja llamada «Pedidos» con estas columnas: Fecha, Número de pedido, Importe, Moneda, País de envío, Estado de pago.
Shopify tiene sus propias automatizaciones y notificaciones. Si solo necesitas un aviso sencillo, mira si te basta con eso antes de montar este escenario.
LOS MÓDULOS, EN ORDEN
Módulo 1 · Shopify › Watch Orders.
- Connection: pulsa Add, escribe el nombre de la tienda y sigue los pasos de Make.
- Financial status: Paid. Status: Any. Limit: 10. Si alguno de esos campos no aparece con ese nombre, busca el equivalente.
- Si el módulo tiene reloj, elige cada cuánto mirar, por ejemplo cada 15 minutos.
- Un pedido que entra como pendiente (transferencia, contra reembolso) y se paga después puede no llegar a la hoja. Compruébalo con un pedido de ese tipo y apunta los casos a mano si hace falta.
Módulo 2 · Tools › Set multiple variables.
- fecha: {{formatDate(now; "DD/MM/YYYY HH:mm"; "Europe/Madrid")}}
- pais: el código de país de la dirección de envío del pedido (Country code). Si el pedido no tiene dirección de envío, quedará vacío.
- importe: el precio total del pedido (Total price).
Módulo 3 · Google Sheets › Add a Row.
- Spreadsheet ID: «Select from My Drive». Sheet name: Pedidos. Table contains headers: Yes.
- Fecha: la variable fecha. Número de pedido: el número o nombre del pedido (Order number o Name). Importe: la variable importe. Moneda: la moneda del pedido. País de envío: la variable pais. Estado de pago: el estado financiero del pedido.
- No añadas nombre, dirección, teléfono ni email del cliente. No hacen falta para llevar el registro.
Módulo 4 · Router (Flow Control › Router). Dos rutas, que pueden activarse las dos a la vez para un mismo pedido.
Ruta A, pedido grande. Filtro: importe «Greater than or equal to» tu umbral (por ejemplo, el importe a partir del cual quieres mirarlo tú, con punto como separador decimal). Módulo: Gmail › Send an Email.
- To: pulsa Add item y escribe tu correo. Subject: «Pedido grande: » y el número. Content: número, importe y el enlace al pedido en el administrador de Shopify.
- Enlace: https://TU-TIENDA.myshopify.com/admin/orders/ y detrás el ID del pedido (el campo ID, no el número).
Ruta B, envío fuera de España. Filtro, las dos condiciones a la vez: pais «Exists» y pais «Not equal to» ES. Módulo: Gmail › Send an Email.
- To: tu correo. Subject: «Pedido con envío internacional: » y el número. Content: número, país e importe. Añade «Revisa método de envío, plazos e impuestos antes de preparar el paquete».
CÓMO PROBARLA
Usa UN pedido ya existente: en el módulo 1, en «Choose where to start», elige un pedido antiguo y pulsa Run once. Con permiso solo de lectura, Shopify puede limitar los pedidos visibles a los más recientes.
Si prefieres un pedido nuevo, hazlo con el modo de pruebas de pagos de Shopify, sin cobrar de verdad.
Comprueba una fila nueva en la hoja y, si el pedido cumple una condición del Router, un correo en tu bandeja.
Marca esa fila como prueba en una columna de notas, y cuando acabes cambia el punto de partida a «From now on».
Activa Scheduling y pulsa Save.
CUÁNTO CUESTA
Cada pedido pasa por 4 o 5 módulos: Watch, Set variables, Add a Row y los de Gmail que se activen. Compruébalo en el historial tras la prueba.
Mira en su web cuántas operaciones o créditos incluye tu plan y calcula cuántos pedidos esperas al mes.
QUÉ NO HACER
No guardes direcciones, teléfonos ni emails de clientes en la hoja. Son datos personales.
No automatices cancelaciones, reembolsos ni cambios de estado del pedido con este escenario.
No des permisos de escritura a la conexión si solo lees pedidos.
No compartas la hoja con edición abierta.
QUÉ REVISAR A MANO ANTES DE ACTIVARLA
Que el umbral de pedido grande es el que quiere el cliente. Si la tienda vende en varias monedas, el umbral solo vale para una: mira la columna Moneda.
Que los pedidos sospechosos los mira una persona. Revisa las señales de riesgo que Shopify muestre en cada pedido, y que decida la persona, no el escenario.
Que los envíos internacionales, aduanas e impuestos los confirma quien lleve la parte fiscal de la tienda. Canarias, Ceuta y Melilla llevan código ES pero pueden tener impuestos y aduanas distintos.
Que los números de pedido de la hoja coinciden con los de Shopify.
Que la conexión con Shopify sigue activa tras cambios en la tienda o en los permisos.
Que el cliente sabe que los datos de sus pedidos pasan por Make y Google. Mira en su web cuánto tiempo guarda Make el historial de ejecuciones.
