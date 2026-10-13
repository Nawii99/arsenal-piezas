# Alta de cliente y presupuesto del servicio legal en n8n…

**Tipo:** Receta de automatización · **Área:** Tienda por internet · **Licencia:** CC BY 4.0

Receta de n8n: un formulario de diagnóstico rellena el cliente, el flujo calcula qué le falta, envía el presupuesto por email y lo registra en una hoja para facturar.

## Qué es y qué hace

Receta de n8n que funciona como embudo de un servicio de textos legales: el dueño de una tienda rellena un diagnóstico, el flujo comprueba qué textos le faltan, envía por email un mini-diagnóstico con tu presupuesto y registra el contacto en una hoja para facturar lo que cierres. Usa un formulario, un nodo de cálculo, Gmail y Google Sheets.

## Cómo usarla

1. Crea el formulario de diagnóstico y la hoja
2. Define tu precio y los textos de cada caso en n8n
3. Prueba con una tienda de ejemplo
4. Que lo revise un profesional

## Cuándo usarla

Captas tiendas para tu servicio de textos legales y quieres contestar al diagnóstico con un presupuesto en minutos, no al día siguiente, cuando el interés ya se enfrió.

## Cómo ganar dinero con ella

Es el embudo de tu servicio legal para tiendas: el diagnóstico gratis atrae al cliente y el presupuesto sale con tu precio por texto, [TU PRECIO]. Lo que luego cobres por redactar lo revisa un profesional del derecho.

- Captación de tiendas para un servicio de textos legales con presupuesto automático.
- Diagnóstico gratuito de textos legales como puerta de entrada de una auditoría de pago.
- Montaje del embudo para una gestoría o abogado que atiende a tiendas online pequeñas.

**Precio orientativo:** 200–400 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

Qué hace: el dueño de una tienda rellena un formulario de diagnóstico legal (¿tienes aviso legal?, ¿política de devoluciones?, etc.). El flujo calcula qué le falta, le manda un email con el mini-diagnóstico y tu presupuesto, y apunta el contacto en una hoja para que luego factures lo que cierre.

Cuentas que necesitas:
- n8n (autoalojado gratis, o n8n Cloud de pago con prueba gratuita).
- Tally para el formulario (el plan gratuito permite formularios y respuestas ilimitadas con webhooks).
- Una cuenta de Google (Sheets y Gmail, gratis con los límites normales de Gmail).

Antes de montarla: crea el formulario en Tally con estos campos: nombre, email, URL de la tienda, y cinco preguntas Sí/No: ¿tienes aviso legal con NIF y dirección?, ¿condiciones de venta publicadas?, ¿política de devoluciones con los 14 días?, ¿política de privacidad?, ¿banner de cookies con botón de rechazar? Crea también una hoja de Google Sheets llamada "Leads legal" con columnas: fecha, nombre, email, tienda, fallos, presupuesto, estado.

Nodos, en orden:
1. **Webhook** (disparador): copia la URL de producción del nodo y pégala en Tally, en Integrations > Webhooks del formulario. Cada envío del formulario dispara el flujo.
2. **Code**: recorre las cinco respuestas Sí/No y monta dos cosas: la lista de fallos (cada "No") y el presupuesto, sumando tu precio por pieza. Pon tus precios en variables al principio del código, por ejemplo precioPorTexto = [TU PRECIO] euros más IVA, para cambiarlos sin tocar el resto.
3. **IF**: si la lista de fallos está vacía, rama A; si tiene algo, rama B.
4. **Gmail** (rama A, todo Sí): email corto felicitando y ofreciendo una revisión anual por [TU PRECIO]. No prometas que "cumple la ley": di que sus respuestas no muestran fallos evidentes.
5. **Gmail** (rama B, hay fallos): email con la lista de lo que le falta explicada en una frase por punto, el presupuesto desglosado por pieza con el total más IVA, y tu enlace de Calendly o tu teléfono para cerrar. Firma con tu nombre y tu NIF si ya operas como autónomo.
6. **Google Sheets** (Append Row, en ambas ramas): añade fila a "Leads legal" con fecha, datos, fallos, presupuesto y estado "enviado".

Avisos que van dentro de la receta:
- Ese formulario recoge datos personales: pon debajo del botón de envío una cláusula breve de privacidad tuya (quién eres, para qué usas el email, cómo borrarse). Vender cumplimiento sin cumplir tú queda fatal y es un riesgo real.
- El email del presupuesto no es la factura. La factura la emites al cerrar la venta, con numeración correlativa y su IVA; la hoja "Leads legal" te sirve de registro de a quién debes facturar, no de libro de facturas.
- No añadas al lead a ninguna lista de newsletter: ha pedido un diagnóstico, no suscribirse.

Cómo probarla sin liarla: desactiva el flujo en producción y usa "Listen for test event" en el Webhook. Rellena el formulario tú mismo con tu propio email dos veces: una con todo Sí y otra con dos No, y comprueba que llega el email correcto de cada rama, que el presupuesto suma bien y que la fila aparece en la hoja. Solo entonces activa el flujo y publica el enlace del formulario.
