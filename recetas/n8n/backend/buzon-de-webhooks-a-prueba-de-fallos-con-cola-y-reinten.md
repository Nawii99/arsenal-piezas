# Buzón de webhooks a prueba de fallos con cola y reinten…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Recoge los webhooks que te mandan Stripe, Shopify o cualquier proveedor, los guarda al instante, responde 200 y luego los procesa uno a uno reintentando los que fallan.

## Qué es y qué hace

Recibe webhooks de Stripe, Shopify u otro proveedor, guarda cada evento en una tabla webhooks_cola y responde 200 en menos de 100 ms. Otro flujo procesa la cola cada minuto, reintenta con espera creciente y, tras cinco fallos, avisa por Slack. Entrada: POST del proveedor; salida: evento procesado o marcado como error. Usa n8n con PostgreSQL y verificación de firma del emisor.

## Cómo usarla

1. Crea la tabla webhooks_cola
2. Configura la URL en el panel del proveedor
3. Verifica la firma del evento
4. Prueba reintentos con un evento de ensayo

## Cuándo usarla

Cuando dependas de webhooks de terceros (pagos, pedidos, formularios) y no puedas permitirte perder ni uno, o cuando tu proceso interno sea lento y el proveedor te esté dando timeouts.

## Cómo ganar dinero con ella

Un solo pedido o pago perdido ya paga el montaje. Sustituye servicios de cola gestionada tipo Hookdeck o Svix, que empiezan en 30-50 dólares al mes.

- Recepción fiable de pedidos para tiendas que reciben pagos por webhook.
- Cola de integraciones para agencias que conectan CRM, pasarela y formularios.
- Monitor de eventos con reintentos para startups con procesos internos lentos.

**Precio orientativo:** 150–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Monta dos flujos: uno que recibe el webhook, lo mete en una tabla `webhooks_cola` y responde 200 en menos de 100 ms (el proveedor se queda contento y no reintenta), y otro que cada minuto coge lo pendiente y lo procesa de verdad.
Si el procesado falla, el registro queda como `error` con el número de intentos, y vuelve a intentarse con espera creciente (1, 5, 15, 60 minutos). Tras 5 intentos te avisa por Slack y lo marca como muerto.

## Lo que necesitas antes
- n8n (auto-alojado recomendado, porque el webhook tiene que estar siempre despierto).
- Una base de datos PostgreSQL (la del propio n8n vale, o una gratis en Supabase o Neon).
- La URL de webhook de producción que te dará n8n, para pegarla en el panel del proveedor (Stripe: Developers, Webhooks, Add endpoint).
- El secreto de firma del proveedor (Stripe te da uno tipo whsec_...) para verificar que el webhook es auténtico.
- Un webhook entrante de Slack (api.slack.com, Incoming Webhooks) o un bot de Telegram.

## La tabla
```sql
CREATE TABLE webhooks_cola (
  id BIGSERIAL PRIMARY KEY,
  fuente TEXT NOT NULL,
  evento TEXT,
  idempotencia TEXT UNIQUE,
  payload JSONB NOT NULL,
  estado TEXT NOT NULL DEFAULT 'pendiente',
  intentos INT NOT NULL DEFAULT 0,
  proximo_intento TIMESTAMPTZ NOT NULL DEFAULT now(),
  ultimo_error TEXT,
  creado TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_cola_pend ON webhooks_cola (estado, proximo_intento);
```

## Flujo 1: recepción (los nodos, en orden)
1. **Webhook** — HTTP Method: POST, Path: `entrada/stripe`, Authentication: None, Respond: Using 'Respond to Webhook' node, y en Options activa Raw Body (lo necesitas para verificar la firma).
2. **Code** (nombre: Verificar firma) — comprueba la cabecera de firma; si no cuadra, marca `valido: false`.
3. **IF** — `={{ $json.valido }}` is true.
4. **Postgres** (nombre: Encolar) — Operation: Execute Query, con la consulta INSERT de abajo. Marca "Always Output Data".
5. **Respond to Webhook** — Respond With: Text, Response Code: 200, Response Body: `ok`. En la rama falsa del IF, otro Respond to Webhook con código 401.

## Flujo 2: procesado (los nodos, en orden)
1. **Schedule Trigger** — Minutes Between Triggers: 1.
2. **Postgres** (nombre: Coger lote) — Execute Query: `UPDATE webhooks_cola SET estado='procesando' WHERE id IN (SELECT id FROM webhooks_cola WHERE estado IN ('pendiente','error') AND proximo_intento <= now() ORDER BY id LIMIT 20 FOR UPDATE SKIP LOCKED) RETURNING *;`
3. **Loop Over Items** — Batch Size: 1.
4. **Switch** — Mode: Rules, Value: `={{ $json.evento }}`, con salidas para `payment_intent.succeeded`, `charge.refunded`, etc., y una salida por defecto.
5. **HTTP Request** / **Gmail** / lo que tenga que hacer cada rama (dar de alta al cliente, mandar la factura, actualizar tu CRM). Settings: On Error, Continue (using error output).
6. **Postgres** (rama de éxito, nombre: Marcar hecho) — `UPDATE webhooks_cola SET estado='hecho' WHERE id = {{ $json.id }};`
7. **Code** (rama de error, nombre: Calcular espera) — código de abajo.
8. **Postgres** (nombre: Reprogramar) — `UPDATE webhooks_cola SET estado = '{{ $json.estado }}', intentos = {{ $json.intentos }}, proximo_intento = now() + interval '{{ $json.minutos }} minutes', ultimo_error = '{{ $json.error }}' WHERE id = {{ $json.id }};`
9. **IF** — intentos mayor o igual que 5, y si sí, **Slack** con el aviso.

## El código del nodo "Verificar firma" (Stripe)
```javascript
const crypto = require('crypto');
const secreto = 'whsec_PON_AQUI_EL_TUYO';
const cabecera = $json.headers['stripe-signature'] || '';
const raw = $json.body.toString();
const partes = Object.fromEntries(cabecera.split(',').map(p => p.split('=')));
const firmado = partes.t + '.' + raw;
const esperada = crypto.createHmac('sha256', secreto).update(firmado).digest('hex');
const valido = partes.v1 && crypto.timingSafeEqual(Buffer.from(esperada), Buffer.from(partes.v1));
const cuerpo = valido ? JSON.parse(raw) : {};
return [{ json: { valido, evento: cuerpo.type || '', idempotencia: cuerpo.id || '', payload: cuerpo } }];
```

## La consulta del nodo "Encolar"
```sql
INSERT INTO webhooks_cola (fuente, evento, idempotencia, payload)
VALUES ('stripe', $1, $2, $3::jsonb)
ON CONFLICT (idempotencia) DO NOTHING
RETURNING id;
```
Query Parameters: `={{ $json.evento }}`, `={{ $json.idempotencia }}`, `={{ JSON.stringify($json.payload) }}`.

## El código del nodo "Calcular espera"
```javascript
const esperas = [1, 5, 15, 60, 240];
const item = $('Coger lote').all().find(i => i.json.id === $json.id)?.json || $json;
const intentos = Number(item.intentos || 0) + 1;
const minutos = esperas[Math.min(intentos - 1, esperas.length - 1)];
const estado = intentos >= 5 ? 'muerto' : 'error';
const error = String($json.error?.message || 'fallo desconocido').replace(/'/g, '').slice(0, 400);
return [{ json: { id: item.id, intentos, minutos, estado, error } }];
```

## Cómo probarla
- Usa la CLI de Stripe: `stripe listen --forward-to https://tu-n8n.com/webhook/entrada/stripe` y luego `stripe trigger payment_intent.succeeded`.
- Manda el mismo evento dos veces: en la tabla debe quedar una sola fila (eso lo hace el UNIQUE en idempotencia).
- Rompe a propósito el nodo de procesado (URL falsa) y comprueba que la fila pasa a `error`, que `intentos` sube y que `proximo_intento` se va alejando.

## Qué puede salir mal
- **Responder tarde**: si tardas más de 10 segundos en devolver el 200, Stripe reintenta y te duplica trabajo. Por eso el 200 va antes de procesar nada.
- **Duplicados**: el campo `idempotencia` con UNIQUE es la única defensa fiable; no te fíes de comparar timestamps.
- **Dos ejecuciones a la vez**: el `FOR UPDATE SKIP LOCKED` evita que dos ejecuciones cojan el mismo registro.
- **Comillas en el mensaje de error**: rompen el UPDATE. Por eso el código las quita antes.
- **Firma inválida siempre**: casi siempre es que el body llega ya parseado. Activa Raw Body en el nodo Webhook.

## Cuánto cuesta
- n8n auto-alojado: gratis (VPS 5 euros al mes).
- Postgres: gratis en Supabase (500 MB) o Neon.
- Slack y Stripe: gratis lo que aquí usas.
