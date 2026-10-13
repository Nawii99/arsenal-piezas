---
name: webhook-stripe
description: Crea, protege y prueba en local el endpoint de webhooks de Stripe (firma, idempotencia, eventos de pago y suscripción). Úsalo cuando haya que reaccionar a un pago, un impago o una cancelación.
argument-hint: qué tiene que pasar en tu app cuando alguien paga, deja de pagar o cancela
---
Actúa como programador backend que ha puesto webhooks de Stripe en producción muchas veces y sabe dónde fallan.

Lo que tiene que pasar en mi app con cada evento: $ARGUMENTS

Si no lo he dicho, pregúntame antes de escribir nada: qué framework usa el proyecto (míralo en el código), dónde se guardan los usuarios y cómo se llama el campo que dice si un usuario tiene acceso. No me preguntes nada que puedas leer del proyecto.

Haz esto en orden y dime qué haces en cada paso en una frase:

1. **Endpoint** `POST /webhooks/stripe`. Debe leer el cuerpo en crudo (sin parsear a JSON antes), porque si no la firma nunca cuadra. Es el fallo número uno. Adáptalo al framework del proyecto.
2. **Verificación de firma** con `STRIPE_WEBHOOK_SECRET` (empieza por `whsec_`). Si la firma no vale, responde 400 y no hagas nada más.
3. **Idempotencia**: guarda el `event.id` en una tabla `stripe_eventos` antes de procesar. Si ya existe, responde 200 y sal. Stripe reenvía eventos; sin esto duplicas accesos o emails.
4. **Responder 200 rápido**. El trabajo pesado (emails, PDFs, llamadas a otras APIs) va a una cola o a un proceso aparte. Si tardas más de unos segundos, Stripe lo cuenta como fallo y reintenta.
5. **Eventos** que se manejan, con lo que hace cada uno según lo que te he pedido:
   - `checkout.session.completed`: crear o enlazar el usuario con `customer` y `subscription`.
   - `invoice.paid`: marcar activo y guardar `fin_periodo_actual`.
   - `invoice.payment_failed`: marcar impagado. No quitar el acceso al primer fallo; Stripe reintenta el cobro solo. Avisar al cliente.
   - `customer.subscription.updated`: actualizar plan y estado.
   - `customer.subscription.deleted`: quitar el acceso.
   Cualquier otro evento: responder 200 y registrarlo, sin hacer nada.
6. **Registro**: cada evento procesado deja una línea en el log con `event.id`, tipo y resultado.

Cuando el código esté, dame la guía de prueba en local, con los comandos exactos para copiar:

1. Instalar Stripe CLI (dime cómo en mi sistema operativo, mira cuál es).
2. `stripe login` y `stripe listen --forward-to localhost:[PUERTO]/webhooks/stripe`. Dime que el `whsec_` que imprime es el que va en `.env` mientras pruebo en local, distinto del de producción.
3. `stripe trigger checkout.session.completed`, `stripe trigger invoice.payment_failed`, `stripe trigger customer.subscription.deleted`. Para cada uno, qué tengo que ver en la terminal y qué tiene que haber cambiado en la base de datos.
4. Lanzar dos veces el mismo evento y comprobar que la segunda vez no cambia nada.
5. Mandar un POST con `curl` sin firma y comprobar que devuelve 400.

Termina con una tabla: evento, qué cambia en la base de datos, cómo lo compruebo.

Qué NO hacer:
- No parsear el cuerpo antes de verificar la firma.
- No dar acceso desde la página de éxito del pago; solo desde `invoice.paid` o `checkout.session.completed`.
- No quitar el acceso al primer `invoice.payment_failed`.
- No hacer trabajo lento dentro del endpoint.
- No poner el `whsec_` en el código. Va en `.env` y `.env` está en `.gitignore`. Compruébalo.
- No inventarte campos de la base de datos: usa los que existen o propón la migración y espera a que la apruebe.
