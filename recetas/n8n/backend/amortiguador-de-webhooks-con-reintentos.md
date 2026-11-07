# Amortiguador de webhooks con reintentos…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Recibe los webhooks de Stripe, Shopify o quien sea, los guarda al instante y los va entregando a tu sistema con reintentos si está caído, sin perder ninguno.

## Qué es y qué hace

Recibe webhooks de proveedores como Stripe o Shopify, responde al instante, verifica la firma, los guarda en una hoja cola y los entrega a tu backend con reintentos crecientes si está caído. Entran el webhook con su secreto de firma y la URL interna de tu backend; sale el evento entregado o registrado con su error. Para tiendas y SaaS pequeños que no pueden perder pedidos ni pagos.

## Cómo usarla

1. Pon n8n con HTTPS delante de tu backend
2. Guarda el secreto whsec de Stripe como variable de entorno de n8n (no en el nodo)
3. Crea la hoja Cola webhooks
4. Simula un fallo del backend para comprobar los reintentos

## Cuándo usarla

Úsalo cuando pierdas pedidos o pagos porque tu backend estaba caído o lento en el momento en que llegó el aviso del proveedor.

## Cómo ganar dinero con ella

Un pedido perdido cuesta más que todo el montaje. Evita reconciliaciones manuales de horas al mes y devoluciones por pedidos no procesados.

- Configuración de webhooks fiables para tiendas online que cobran con pasarela…
- Gestión de colas de eventos para SaaS pequeños con reintentos y registro…
- Mantenimiento mensual de integraciones de pago con revisión de eventos fallidos…

**Precio orientativo:** 150–400 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Hace de buzón: acepta el webhook en menos de un segundo, responde 200 al proveedor para que no lo reintente él, lo guarda en una cola y luego lo entrega a tu backend con reintentos crecientes. Para tiendas y SaaS pequeños que reciben avisos de Stripe, Shopify, Holded o similares.

## Lo que necesitas antes
- n8n accesible desde internet con HTTPS (con un dominio y Caddy o Nginx delante, o n8n Cloud).
- El secreto de firma del proveedor: en Stripe, Developers → Webhooks → tu endpoint → Signing secret (`whsec_...`). Guárdalo como variable de entorno de n8n (`STRIPE_WEBHOOK_SECRET`) y léelo con `$env.STRIPE_WEBHOOK_SECRET`; no lo pegues en el nodo Code ni en un nodo Set: un flujo exportado se llevaría la clave. Si tu n8n bloquea `$env` en los nodos, usa el nodo Stripe Trigger, que comprueba la firma con una credencial.
- Una hoja «Cola webhooks» con columnas: id, recibido, evento, payload, intentos, estado, ultimo_error.
- La URL interna de tu backend que procesa el evento.

## Los nodos, en orden — Flujo A (recepción)
1. **Webhook** — HTTP Method: POST, Path: `entrada-pagos`, Authentication: None, Respond: «Using Respond to Webhook node». En Options activa «Raw Body» (necesario para validar la firma).
2. **Code** (renómbralo «Validar firma») — Mode: Run Once for Each Item:
```javascript
const crypto = require('crypto');
const secreto = $env.STRIPE_WEBHOOK_SECRET; // nunca escribas aquí el whsec_
const cabeceras = $input.item.json.headers || {};
const firma = cabeceras['stripe-signature'] || '';
const bruto = $input.item.json.body ? $input.item.json.body.toString() : '';
const partes = Object.fromEntries(firma.split(',').map(p => p.split('=')));
const base = partes.t + '.' + bruto;
const esperado = crypto.createHmac('sha256', secreto).update(base).digest('hex');
const valida = partes.v1 && crypto.timingSafeEqual(Buffer.from(esperado), Buffer.from(partes.v1));
let datos = {};
try { datos = JSON.parse(bruto); } catch (e) { datos = {}; }
return { json: {
  valida: !!valida,
  id: datos.id || ('evt_' + Date.now()),
  evento: datos.type || 'desconocido',
  payload: bruto,
  recibido: new Date().toISOString()
} };
```
3. **IF** — `{{ $json.valida }}` is true.
4. Rama true → **Google Sheets** (Append Row en «Cola webhooks», intentos 0, estado `PENDIENTE`).
5. → **Respond to Webhook** — Respond With: Text, Response Code 200, Body: `ok`.
6. Rama false → **Respond to Webhook** con Response Code 400 y body `firma invalida`.

## Los nodos, en orden — Flujo B (entrega con reintentos)
7. **Schedule Trigger** — cada 2 minutos.
8. **Google Sheets** — Get Row(s) con Filter: columna `estado` igual a `PENDIENTE`. Options → Return All: off, Limit: 20.
9. **Split In Batches** — Batch Size 1.
10. **HTTP Request** — Method POST, URL de tu backend, Body Content Type: JSON, Specify Body: Using JSON, JSON: `={{ $json.payload }}`. Options → Timeout 15000, Never Error on HTTP Status: on. Añade una cabecera `X-Idempotency-Key: {{ $json.id }}` para que tu backend no procese dos veces el mismo evento.
11. **Code** (renómbralo «Resultado»):
```javascript
const fila = $('Split In Batches').first().json;
const r = $input.item.json;
const codigo = r.statusCode || 0;
const ok = codigo >= 200 && codigo < 300;
const intentos = parseInt(fila.intentos || '0', 10) + 1;
return { json: {
  id: fila.id,
  intentos,
  estado: ok ? 'ENTREGADO' : (intentos >= 6 ? 'FALLIDO' : 'PENDIENTE'),
  ultimo_error: ok ? '' : ('HTTP ' + codigo),
  alertar: !ok && intentos >= 6
} };
```
12. **Google Sheets** — Update Row, Matching Column `id`.
13. **IF** `{{ $json.alertar }}` is true → **Telegram** avisándote de que un evento se ha rendido tras 6 intentos.
14. Vuelve a conectar a **Split In Batches**.

## Cómo probarla
- Desde tu ordenador: `curl -X POST https://tu-n8n/webhook/entrada-pagos -d '{"id":"evt_1","type":"prueba"}'`. Debe responder 400 por firma inválida: eso confirma que la validación funciona.
- Usa el CLI de Stripe: `stripe listen --forward-to https://tu-n8n/webhook/entrada-pagos` y `stripe trigger payment_intent.succeeded`.
- Apaga tu backend a propósito y comprueba que la fila se queda en PENDIENTE y sube `intentos` cada 2 minutos.

## Qué puede salir mal
- **Duplicados**: los proveedores reenvían eventos. Antes del Append, añade un **Google Sheets → Get Row(s)** filtrando por ese `id`; si existe, no lo insertes.
- **Reintento infinito**: el corte a 6 intentos evita el bucle. 6 intentos cada 2 minutos son 12 minutos de margen; sube el Schedule a 10 minutos si tu backend tarda más en volver.
- **Payload gigante**: una celda de Sheets aguanta 50.000 caracteres. Si tus eventos son mayores, guarda el JSON como fichero en disco y en la hoja solo la ruta.
- **Producción/pruebas**: la URL `/webhook-test/` solo funciona mientras pulsas «Listen». La buena, la que das al proveedor, es `/webhook/`.

## Cuánto cuesta
n8n auto-alojado 0 €. Un VPS mínimo para tenerlo público: 4-6 €/mes. Sheets y Telegram gratis. En Make o Zapier este patrón consume una operación por evento y por reintento, así que auto-alojar sale mucho más barato.
