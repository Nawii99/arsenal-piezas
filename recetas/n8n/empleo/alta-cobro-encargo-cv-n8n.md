# Alta y cobro de un encargo de CV en n8n…

**Tipo:** Receta de automatización · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

Recoge el pedido de un cliente, cobra con Stripe, avisa a quien presta el servicio y confirma al cliente, todo automático hasta que empieza el trabajo humano.

## Qué es y qué hace

Automatización de n8n que recoge el pedido de un cliente, genera el cobro en Stripe, avisa del pedido pagado y confirma al cliente, hasta que empieza el trabajo humano. Entra un formulario con los datos y el pago, y sale una confirmación al cliente y un aviso interno. Las cuentas de Google y Stripe tienen comisiones y límites; confirma las tarifas vigentes antes de cobrar. El aviso de pago solo se acepta si el webhook de Stripe está verificado.

## Cómo usarla

1. Crea el formulario de pedido en Google Forms o Tally
2. Enlaza el cobro de Stripe
3. Prueba con un pago de prueba
4. Que lo revise un profesional (cobro y datos del cliente)

## Cuándo usarla

Cuando alguien quiere contratar tu servicio de CV y carta, esta automatización recoge sus datos y genera el cobro, para que no tengas que perseguir pagos ni formularios a mano.

## Cómo ganar dinero con ella

Convierte tu servicio de CV en un proceso de pedido con cobro: cada encargo se paga por adelantado ([TU PRECIO]) y el trabajo empieza cuando llega el pago. Una persona revisa el CV y la carta antes de que lleguen al cliente.

- Alta y cobro de pedidos de CV para un servicio pequeño que recibe encargos por formulario.
- Confirmación automática de pedido y pago para consultores de empleo que cobran por adelantado.
- Mantenimiento mensual de la automatización de pedidos y revisión de avisos fallidos.

**Precio orientativo:** 120–200 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Automatización: alta y cobro de un encargo de CV en n8n

## Qué resuelve
Cuando alguien quiere contratar el servicio de CV y carta de presentación, esta automatización recoge sus datos, genera el cobro, avisa a quien presta el servicio del pedido pagado y confirma al cliente, sin que tenga que estar pendiente del móvil todo el día.

## Cuentas necesarias
- n8n (n8n Cloud ofrece una prueba gratuita temporal y después planes de pago; la opción gratis es n8n autoalojado, que tienes que mantener tú).
- Google, para Drive y Sheets, gratis con una cuenta normal de Gmail.
- Stripe, gratis crear la cuenta, cobra comisión por cada cobro (revisa la tarifa vigente para España en su web antes de fijar precios).
- Telegram (bot gratis) o Gmail para las notificaciones.

## Nodos, en orden
1. Disparador: Webhook que recibe el envío de un formulario (Typeform, Google Forms con Apps Script, o un formulario propio) con nombre, email, CV adjunto, enlace a la oferta y qué servicio quiere contratar.
2. Nodo Google Drive: crea una carpeta con el nombre del cliente y sube el CV recibido dentro.
3. Nodo HTTP Request a la API de Stripe (o el nodo Stripe si está disponible): crea un enlace de pago con el importe según el servicio elegido.
4. Nodo Gmail: envía al cliente el enlace de pago y le explica el siguiente paso.
5. Segundo disparador, en un workflow aparte: un nodo Stripe Trigger (comprueba la firma del webhook) con el evento checkout.session.completed. Si usas un Webhook genérico, verifica antes la cabecera Stripe-Signature con el «signing secret» del endpoint. Comprueba que payment_status sea paid y guarda el id del evento para no repetir el trabajo si llega dos veces.
6. Nodo Google Sheets: añade una fila con cliente, servicio contratado, importe, fecha y estado "pagado".
7. Nodo Telegram (o Gmail): manda un aviso a quien presta el servicio con el nombre del cliente, qué ha comprado y el enlace a la carpeta de Drive, para que empiece el encargo.
8. Nodo Gmail: envía al cliente un email de confirmación con el plazo de entrega y qué va a recibir.

## Cómo probarla sin liarla
Activa el modo de pruebas de Stripe antes de tocar nada real: genera pagos falsos con las tarjetas de prueba de su documentación. Rellena el formulario con datos inventados y comprueba que se crea bien la carpeta en Drive, que llega el aviso a Telegram y que la fila en Sheets tiene los datos correctos. Solo cuando todo eso funcione sin errores, cambia las claves de Stripe de test a las reales.

## Qué NO hacer
No des un pago por bueno si el aviso de Stripe no está verificado: sin firma, cualquiera podría simular un pago y disparar el trabajo.
No actives las claves reales de Stripe hasta haber probado el flujo completo con las claves de prueba.
No guardes los datos de tarjeta del cliente en ningún nodo: de eso se encarga Stripe, n8n nunca debe verlos.
No prometas al cliente una entrega automática inmediata: el aviso a quien presta el servicio es lo que dispara el trabajo humano de verdad.
