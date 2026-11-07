# Cola de reintentos para webhooks que fallan…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Recoge los webhooks de tus proveedores, los guarda antes de procesarlos y reintenta con espera creciente los que fallan, sin duplicar nada.

## Qué es y qué hace

Recibe el webhook, verifica su firma, lo guarda en una tabla PostgreSQL y solo entonces intenta entregarlo a tu backend. Si falla, un segundo flujo reintenta a los 1, 5, 30 y 120 minutos sin duplicar eventos. Entran avisos de pago o pedido con su secreto de firma; sale el evento entregado o en cola. Para quien cobra online o recibe pedidos por webhook.

## Cómo usarla

1. Crea la tabla cola_webhooks en PostgreSQL
2. Guarda el secreto de firma como variable de entorno de n8n (no en el nodo)
3. Configura el flujo de recepción y el de reintentos
4. Simula un fallo del backend y comprueba la cola

## Cuándo usarla

Cuando pierdes avisos de pago o de pedido porque tu servidor estaba caído o lento justo en ese momento y el proveedor no reintenta más.

## Cómo ganar dinero con ella

Cada webhook perdido es un pedido sin procesar o un cobro sin registrar. Recuperas el 100% en vez de descubrirlos cuadrando a fin de mes.

- Recepción fiable de pagos y pedidos para tiendas con backend propio…
- Configuración de colas de webhooks para SaaS pequeños con registro de errores…
- Mantenimiento de integraciones de pago con revisión mensual de eventos pendientes…

**Precio orientativo:** 150–400 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Pone a n8n delante de tu backend como buzón: recibe el webhook, verifica la firma, lo guarda en una tabla y solo entonces intenta entregarlo.
Si tu backend falla, el aviso queda en cola y un segundo flujo lo reintenta a los 1, 5, 30 y 120 minutos. Para quien cobra online o recibe pedidos por webhook.

## Lo que necesitas antes
- Una tabla en tu base PostgreSQL. Créala con: `CREATE TABLE cola_webhooks (id SERIAL PRIMARY KEY, evento_id TEXT UNIQUE, origen TEXT, cuerpo JSONB, intentos INT DEFAULT 0, proximo_intento TIMESTAMPTZ DEFAULT now(), estado TEXT DEFAULT 'pendiente', creado TIMESTAMPTZ DEFAULT now());`
- El secreto de firma del proveedor. En Stripe: Desarrolladores > Webhooks > tu endpoint > Clave secreta de firma (`whsec_...`). Guárdalo como variable de entorno de n8n (`STRIPE_WEBHOOK_SECRET`), nunca pegado en el nodo: un flujo exportado se llevaría la clave (si tu n8n bloquea `$env`, usa el nodo Stripe Trigger).
- La URL interna de tu backend que procesa el evento.

## Flujo 1: recepción
1. **Webhook** — Method POST, Path `entrada-stripe`, Respond: «Using Respond to Webhook node». Copia la URL de producción y ponla en el panel de Stripe.
2. **Code** — verifica la firma HMAC (código abajo).
3. **IF** — si la firma no es válida, corta.
4. **Postgres** — Operation: Execute Query, un INSERT con `ON CONFLICT (evento_id) DO NOTHING`. Esto es lo que mata los duplicados.
5. **Respond to Webhook** — Respond With: Text, código 200. Responde ya, aunque el procesado tarde: si tardas más de 10 segundos el proveedor reintenta y te duplica trabajo.
6. **HTTP Request** — POST a tu backend con el cuerpo original.
7. **Postgres** — marca `estado = 'ok'` si el backend devolvió 2xx.

## Flujo 2: reintentos
1. **Schedule Trigger** — Minutes, cada 5.
2. **Postgres** — `SELECT * FROM cola_webhooks WHERE estado='pendiente' AND intentos < 5 AND proximo_intento <= now() LIMIT 20;`
3. **Split In Batches** — Batch Size: 1.
4. **HTTP Request** — reenvío a tu backend, «Never Error» activado para poder mirar el código de respuesta.
5. **IF** — código entre 200 y 299.
6. **Postgres** — rama sí: `estado='ok'`. Rama no: `intentos = intentos + 1` y `proximo_intento = now() + (interval '1 minute' * POWER(5, intentos))`.
7. **IF** — si `intentos` llega a 5, **Slack** con el aviso de que ese evento necesita mano humana.

## El código de verificación de firma
```js
const crypto = require('crypto');
const secreto = $env.STRIPE_WEBHOOK_SECRET; // nunca escribas aquí el whsec_
const cabecera = $input.first().json.headers['stripe-signature'] || '';
const cuerpo = JSON.stringify($input.first().json.body);
const partes = Object.fromEntries(cabecera.split(',').map(p => p.split('=')));
const firmado = `${partes.t}.${cuerpo}`;
const esperada = crypto.createHmac('sha256', secreto).update(firmado).digest('hex');
const valida = partes.v1 === esperada;
return [{ json: { valida, evento_id: $input.first().json.body.id, cuerpo: $input.first().json.body } }];
```

## Cómo probarla
- Usa la CLI de Stripe: `stripe listen --forward-to https://tu-n8n/webhook/entrada-stripe` y `stripe trigger payment_intent.succeeded`.
- Apaga tu backend a propósito y manda un evento: debe quedar en `pendiente` y entregarse solo cuando lo enciendas.
- Manda el mismo evento dos veces: en la tabla debe haber una sola fila.

## Qué puede salir mal
- **JSON reordenado.** La firma se calcula sobre el cuerpo crudo. Si n8n te reordena las claves, activa en el Webhook la opción «Raw Body» y firma sobre ese texto.
- **Zonas horarias.** Usa `timestamptz` en la tabla y trabaja siempre en UTC; solo traduce a hora española al mostrarlo.
- **Cola atascada.** Pon un aviso diario si hay más de 50 filas pendientes.

## Cuánto cuesta
- n8n auto-alojado: gratis. En Cloud, ojo: cada reintento cuenta como ejecución; con 288 ejecuciones diarias del Schedule te comes buena parte del cupo de ejecuciones (Cloud solo tiene prueba gratuita temporal y después planes de pago), así que auto-alójalo.
- PostgreSQL: gratis en Supabase o Neon hasta medio giga.
