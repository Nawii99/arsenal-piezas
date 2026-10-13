# Prueba diaria del cobro real: Stripe en modo test y una…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Cada mañana simula un pago en modo prueba y, una vez por semana, hace un cobro real de 0,50 € que devuelve al momento. Si el checkout está roto, te enteras tú antes que nadie.

## Qué es y qué hace

Cada mañana hace un cobro de prueba en el modo test de Stripe y una vez por semana un cobro real de 0,50 € que se devuelve al momento, y comprueba que el evento llega a tu webhook. Registra el resultado en una hoja y avisa si algo falla. Entrada: claves sk_test y sk_live de Stripe; salida: registro y aviso. Se monta en n8n con HTTP Request.

## Cómo usarla

1. Guarda las claves de prueba y real en n8n como Header Auth
2. Prepara la hoja pruebas_pago
3. Que lo revise un profesional

## Cuándo usarla

Úsalo si vendes con pago online y una actualización del tema, del plugin o de las claves podría romper el cobro sin dar error visible.

## Cómo ganar dinero con ella

Un checkout roto un sábado son todas las ventas del fin de semana. Detectarlo en horas se paga solo la primera vez.

- Control del checkout para una tienda que cobra con Stripe también los fines de semana.
- Pruebas de pago para un infoproductor con membresías o reservas online.
- Revisión mensual de cobros tras actualizar el tema o los plugins de la web.

**Precio orientativo:** 100–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Comprueba dos cosas: que la pasarela de pago acepta cobros (modo prueba, todos los días) y que el circuito completo funciona de verdad (cobro real mínimo con devolución inmediata, una vez a la semana). Además verifica que el evento llegó a tu webhook, que es donde suele romperse todo.
Para cualquier negocio que cobre por internet: tienda, membresías, reservas o infoproductos.

## Lo que necesitas antes
- Cuenta de Stripe. En dashboard.stripe.com > Desarrolladores > Claves API copia la clave secreta de prueba (`sk_test_...`) y la real (`sk_live_...`). Guarda cada una como credencial `Header Auth` en n8n con nombre `Authorization` y valor `Bearer sk_test_...`.
- n8n, Gmail y Google Sheets.
- Hoja `pruebas_pago` con columnas: `fecha`, `modo`, `estado`, `id_pago`, `detalle`.

## Los nodos, en orden
1. **Schedule Trigger**. Cron `0 7 * * *`.
2. **HTTP Request** (pago de prueba). `POST` a `https://api.stripe.com/v1/payment_intents`. Credencial: la de test. Body Content Type: `Form Urlencoded`. Parámetros: `amount` = `1000`, `currency` = `eur`, `payment_method` = `pm_card_visa`, `confirm` = `true`, `automatic_payment_methods[enabled]` = `true`, `automatic_payment_methods[allow_redirects]` = `never`, `description` = `Prueba QA diaria`. Never Error activado.
3. **IF**. `{{ $json.status }}` *equals* `succeeded`.
4. Rama **false** > **Gmail** `Send` con asunto `LA PASARELA DE PAGO FALLA` y en el cuerpo `{{ $json.error.message }}` y el código de estado. Marca este correo como importante.
5. **HTTP Request** (comprueba el webhook). `GET` a `https://api.stripe.com/v1/events?type=payment_intent.succeeded&limit=1`. Luego un **Code** que verifique que el evento existe y que `pending_webhooks` es `0`:
```javascript
const ev = ($input.first().json.data || [])[0];
if (!ev) return [{ json: { webhook_ok: false, motivo: 'Sin eventos recientes' } }];
const pendientes = ev.pending_webhooks || 0;
return [{ json: { webhook_ok: pendientes === 0, pendientes, evento: ev.id } }];
```
6. **Google Sheets** `Append Row` en `pruebas_pago`.

## La prueba real semanal (segundo flujo)
1. **Schedule Trigger**. Cron `0 7 * * 1` (lunes).
2. **HTTP Request**. `POST` a `https://api.stripe.com/v1/checkout/sessions` con la credencial **real**. Parámetros: `mode` = `payment`, `line_items[0][price_data][currency]` = `eur`, `line_items[0][price_data][unit_amount]` = `50`, `line_items[0][price_data][product_data][name]` = `Prueba interna`, `line_items[0][quantity]` = `1`, `success_url` = `https://tuweb.com/gracias`, `cancel_url` = `https://tuweb.com`.
3. **Gmail** `Send` a ti mismo con el enlace `{{ $json.url }}` y el texto «paga estos 0,50 € desde el móvil y confirma que llega el correo de pedido». Esto es la parte manual de dos minutos que ninguna automatización sustituye.
4. **Wait** de 2 horas > **HTTP Request** `GET` a `https://api.stripe.com/v1/charges?limit=5` > **Code** que localice el cargo de 50 céntimos y, si existe, un **HTTP Request** `POST` a `https://api.stripe.com/v1/refunds` con `charge` = el id. Así te devuelves el dinero solo.

## Cómo probarla
- Usa primero las claves de test con la tarjeta `pm_card_visa` (siempre acepta) y luego con `pm_card_visa_chargeDeclined` (siempre rechaza): debe saltar la alerta.
- Desactiva a propósito el endpoint del webhook en Stripe y comprueba que `pending_webhooks` deja de ser 0.
- Haz la prueba real una vez a mano antes de automatizar la devolución.

## Qué puede salir mal
- **Confundir claves**: `sk_test_` y `sk_live_` en credenciales distintas y con nombres muy claros. Un cobro real de 1.000 € por error se arregla, pero el susto no.
- **SCA y 3D Secure**: en real, algunas tarjetas piden confirmación en el móvil. Por eso la prueba real es semi-manual.
- **Comisión de Stripe**: cobrar 0,50 € cuesta unos 0,27 € de comisión que NO se devuelve al hacer refund. Son unos 14 € al año, el precio de dormir tranquilo.
- **Reintentos duplicados**: pon `Idempotency-Key` como header con un valor fijo por día (`qa-{{ $now.toFormat('yyyyLLdd') }}`) para que un reintento no cree dos cobros.

## Cuánto cuesta
n8n, Sheets y Gmail: 0 €. Stripe en modo test: 0 €. La prueba real semanal: unos 0,27 € de comisión por semana, unos 14 € al año.
