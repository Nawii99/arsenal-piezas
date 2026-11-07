# Aviso automático de venta con Stripe Payment Links…

**Tipo:** Receta de automatización · **Área:** Tienda por internet · **Licencia:** CC BY 4.0

Cada venta por Stripe se apunta automáticamente y te avisa por email y Telegram.

## Qué es y qué hace

Es una receta de n8n que, al pagar alguien con un enlace de pago de Stripe, guarda la venta en una hoja de cálculo y te avisa por email y Telegram. No necesita montar una tienda. Entran el enlace de pago y un webhook de Stripe, cuya firma y estado de pago se comprueban; salen el registro de ventas y el aviso en el momento del cobro. Stripe cobra comisión por cada pago, y las tarifas se consultan en su web.

## Cómo usarla

1. Crea el Payment Link en Stripe
2. Añade el webhook de n8n y marca checkout.session.completed
3. Prueba con un pago de cero euros o de prueba
4. Verifica la firma de Stripe y evita duplicados

## Cuándo usarla

Vendes con enlaces de pago de Stripe y quieres enterarte al momento de cada cobro y tener las ventas anotadas, sin montar una tienda.

## Cómo ganar dinero con ella

Ofrécelo como extra a infoproductores y artesanos que cobran con enlace: les montas el aviso y el registro de ventas por un pago único [TU PRECIO].

- Aviso de ventas para artesanos y creadores que cobran con enlace y no quieren tienda.
- Registro de cobros para infoproductores que venden pocas unidades al mes.
- Montaje del aviso como extra en servicios de tienda pequeña, con mantenimiento opcional.

**Precio orientativo:** 60–150 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

Objetivo: cada vez que alguien paga con un enlace de pago de Stripe (Payment Link), n8n guarda la venta en una hoja de cálculo y te avisa por email y Telegram, sin montar una tienda completa.
Cuentas necesarias y límite gratuito: Stripe (cuenta gratis, sin cuota mensual, cobra una comisión por cada cobro, ver tarifa actual en la web de Stripe), n8n (plan gratuito self-hosted, o el plan de prueba de n8n Cloud), Google account con Google Sheets (gratis), Telegram (gratis, necesitas crear un bot con @BotFather).
1. En Stripe, crea un Payment Link para tu producto (Panel de Stripe > Payment Links > Crear). No hace falta programar nada para esto.
2. En n8n, añade un nodo Webhook como disparador. Copia la URL que genera.
3. En Stripe, ve a Desarrolladores > Webhooks, añade un endpoint con esa URL y marca el evento 'checkout.session.completed'.
4. Vuelve a n8n y añade un nodo IF después del Webhook: comprueba que el campo 'type' del evento sea igual a 'checkout.session.completed' y que el estado del pago ('payment_status') sea 'paid'. Antes del IF, verifica que el aviso viene de Stripe: calcula la firma de la cabecera `Stripe-Signature` con el «signing secret» (whsec_...) del endpoint, guardado en las credenciales de n8n o en una variable de entorno y nunca pegado en un nodo (o usa directamente el nodo Stripe Trigger, que ya la comprueba). Guarda también el id del evento y, si ya está en la hoja, no repitas nada: Stripe puede enviar el mismo evento dos veces.
5. Añade un nodo Google Sheets (operación Append Row) conectado a la salida positiva del IF: guarda fecha, email del comprador, importe y producto, leyendo esos datos del cuerpo del webhook.
6. Añade un nodo Gmail (Send Email) para confirmar la compra al email del cliente, usando el campo de email del webhook.
7. Añade un nodo Telegram (Send Message) apuntando a tu propio chat, para que te avise a ti a cada venta, con el importe y el producto.
8. Guarda y activa el workflow en n8n antes de probarlo: un Webhook no funciona en modo prueba sin activar.
Cómo probarlo sin liarla: activa el modo de prueba (Test mode) en Stripe, paga tu propio Payment Link con una tarjeta de prueba de Stripe (número 4242 4242 4242 4242, cualquier fecha futura y CVC), y comprueba que llega la fila a la hoja de cálculo y los avisos por email y Telegram.
Solo cuando veas que el flujo de prueba funciona entero, cambia el Payment Link y el Webhook a modo real (Live mode) en Stripe.
Aviso importante: en modo real, Stripe cobra una comisión por cada venta real; revisa la tarifa vigente en tu país antes de fijar tus precios.
