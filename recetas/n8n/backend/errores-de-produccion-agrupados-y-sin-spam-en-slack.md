# Errores de producción agrupados y sin spam en Slack…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Recoge los errores de tu aplicación, los agrupa por huella para que 500 errores iguales sean un solo aviso, y te manda a Slack solo lo nuevo o lo que se dispara.

## Qué es y qué hace

Recibe cada excepción de tu aplicación por un POST, calcula una huella normalizada del error, cuenta repeticiones y avisa solo la primera vez o al superar un umbral. Cada mañana envía a Slack el top 5 del día anterior con los usuarios afectados. Entrada: JSON de error; salida: mensaje de Slack y tabla de errores. Se monta en n8n con PostgreSQL y un webhook entrante de Slack.

## Cómo usarla

1. Crea las tablas de errores
2. Añade el envío en tu backend
3. Configura el webhook de Slack
4. Ajusta el umbral tras una semana

## Cuándo usarla

Cuando tu servidor ya escribe logs de error pero no los mira nadie, o cuando una herramienta como Sentry se te ha ido de precio y solo necesitas lo básico.

## Cómo ganar dinero con ella

Sustituye el plan de pago de Sentry o Rollbar (26-80 euros al mes) y reduce el tiempo entre que un cliente choca con un error y tú te enteras, de días a minutos.

- Monitorización de errores para apps pequeñas que no quieren pagar un servicio de tracking.
- Configuración de alertas para agencias que mantienen varios proyectos web.
- Informe diario de errores para equipos de desarrollo de dos a cinco personas.

**Precio orientativo:** 200–600 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Expone un endpoint al que tu aplicación manda cada excepción (una línea de código en tu backend). n8n calcula una huella del error (mensaje normalizado + fichero + línea), la guarda con un contador y solo te avisa la primera vez que aparece o cuando pasa un umbral (por ejemplo 50 veces en una hora).
Cada mañana a las 9 te manda a Slack el top 5 de errores del día anterior con cuántas veces ha pasado y a cuántos usuarios distintos ha afectado.

## Lo que necesitas antes
- n8n con una URL pública (auto-alojado o Cloud).
- PostgreSQL (Supabase gratis vale).
- Un canal de Slack y un webhook entrante: api.slack.com/apps, Create New App, Incoming Webhooks, Add New Webhook to Workspace. Copia la URL https://hooks.slack.com/services/...
- Poder tocar tu backend para añadir el envío. En cualquier lenguaje son 5 líneas: un POST con JSON.

## Las tablas
```sql
CREATE TABLE errores (
  huella TEXT PRIMARY KEY,
  mensaje TEXT, fichero TEXT, linea INT, entorno TEXT,
  veces INT DEFAULT 0, usuarios TEXT[] DEFAULT '{}',
  primera TIMESTAMPTZ DEFAULT now(), ultima TIMESTAMPTZ DEFAULT now(),
  avisado_en TIMESTAMPTZ
);
CREATE TABLE errores_eventos (huella TEXT, usuario TEXT, ts TIMESTAMPTZ DEFAULT now(), contexto JSONB);
```

## El envío desde tu backend (ejemplo en Node)
```javascript
process.on('uncaughtException', enviar);
async function enviar(err, ctx = {}) {
  await fetch('https://tu-n8n.com/webhook/error', {
    method: 'POST', headers: { 'Content-Type': 'application/json', 'X-Token': 'TU_TOKEN_SECRETO' },
    body: JSON.stringify({ mensaje: err.message, stack: err.stack, entorno: process.env.NODE_ENV, usuario: ctx.userId || 'anonimo', url: ctx.url || '' })
  }).catch(() => {});
}
```

## Flujo 1: recepción (los nodos, en orden)
1. **Webhook** — POST, Path: `error`, Authentication: Header Auth (crea una credencial Header Auth con Name `X-Token` y Value tu token), Respond: Immediately con código 202.
2. **Code** (nombre: Huella) — normaliza el mensaje y saca fichero y línea del stack.
3. **Postgres** (nombre: Upsert) — Execute Query con el UPSERT de abajo.
4. **Postgres** (nombre: Evento) — `INSERT INTO errores_eventos (huella, usuario, contexto) VALUES ($1,$2,$3::jsonb);`
5. **IF** (nombre: ¿Aviso?) — `={{ $json.veces === 1 || ($json.veces % 50 === 0) }}` is true.
6. **Slack** — Resource: Message, Operation: Send, Channel: #errores, Text con formato de abajo.

## El código del nodo "Huella"
```javascript
const crypto = require('crypto');
const b = $json.body || $json;
const msg = String(b.mensaje || 'sin mensaje');
// quitamos números, UUIDs, emails y rutas variables para que errores iguales tengan la misma huella
const norm = msg.replace(/[0-9a-f]{8}-[0-9a-f-]{27}/gi, '<id>').replace(/\b\d+\b/g, '<n>').replace(/[\w.]+@[\w.]+/g, '<email>').slice(0, 300);
const linea = (String(b.stack || '').split('\n')[1] || '').trim();
const m = linea.match(/\(?(.+?):(\d+):\d+\)?$/) || [];
const fichero = (m[1] || 'desconocido').split('/').slice(-2).join('/');
const huella = crypto.createHash('md5').update(norm + '|' + fichero).digest('hex').slice(0, 16);
return [{ json: { huella, mensaje: norm, fichero, linea: Number(m[2] || 0), entorno: b.entorno || 'produccion', usuario: b.usuario || 'anonimo', contexto: { url: b.url || '', stack: String(b.stack || '').slice(0, 2000) } } }];
```

## La consulta del nodo "Upsert"
```sql
INSERT INTO errores (huella, mensaje, fichero, linea, entorno, veces, usuarios)
VALUES ($1,$2,$3,$4,$5,1,ARRAY[$6])
ON CONFLICT (huella) DO UPDATE SET
  veces = errores.veces + 1, ultima = now(),
  usuarios = (SELECT ARRAY(SELECT DISTINCT unnest(errores.usuarios || ARRAY[$6])))
RETURNING huella, mensaje, fichero, linea, veces, array_length(usuarios,1) AS afectados;
```

## Flujo 2: resumen diario
1. **Schedule Trigger** — Cron: `0 9 * * 1-5`, Timezone Europe/Madrid.
2. **Postgres** — `SELECT mensaje, fichero, linea, veces, array_length(usuarios,1) afectados FROM errores WHERE ultima > now() - interval '24 hours' ORDER BY veces DESC LIMIT 5;`
3. **Aggregate** — Aggregate: All Item Data, para juntarlo en un solo item.
4. **Code** — monta el texto con viñetas.
5. **Slack** — Send Message al canal #errores.

## Cómo probarla
- Con curl: `curl -X POST https://tu-n8n.com/webhook/error -H 'X-Token: TU_TOKEN' -H 'Content-Type: application/json' -d '{"mensaje":"Cannot read property id of undefined","stack":"Error\n  at /app/src/pedidos.js:42:10","usuario":"u1"}'`
- Mándalo 3 veces cambiando solo el usuario: debe llegarte un único aviso a Slack y la fila debe marcar veces=3, afectados=3.
- Cambia el número de la línea del stack y comprueba que se crea una huella distinta.

## Qué puede salir mal
- **Te llenan la base de datos**: pon un límite en tu backend (no mandes más de X errores por minuto) y un borrado programado: `DELETE FROM errores_eventos WHERE ts < now() - interval '30 days';`
- **La huella agrupa demasiado o demasiado poco**: ajusta la normalización. Si un error de validación con distintos campos se agrupa como uno, añade el campo a la huella.
- **Datos personales en los logs**: no mandes el cuerpo completo de las peticiones. La normalización ya tapa emails, pero revísalo tú.
- **Si n8n se cae, pierdes errores**: es un aviso, no un sistema crítico. Envía siempre con `.catch(() => {})` para que un fallo del monitor nunca tumbe tu app.

## Cuánto cuesta
- Gratis entero: n8n auto-alojado, Postgres gratuito de Supabase, Slack plan gratuito.
- Si superas los 500 MB de Supabase, su plan Pro son 25 dólares al mes, o te lo montas en tu propio VPS.
