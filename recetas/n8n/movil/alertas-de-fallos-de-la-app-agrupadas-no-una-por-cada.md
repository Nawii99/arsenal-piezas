# Alertas de fallos de la app agrupadas, no una por cada…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Recibe los errores de Sentry o Crashlytics, los agrupa en ventanas de 15 minutos y solo te avisa cuando un fallo nuevo afecta a más usuarios de la cuenta.

## Qué es y qué hace

Flujo de n8n que recibe por webhook los avisos de fallo de Sentry o Crashlytics, los agrupa en ventanas de 15 minutos por tipo de error y solo avisa cuando un fallo nuevo supera el umbral de usuarios afectados que tú fijas. Entra el JSON del error; sale un mensaje en Slack o Telegram y una fila en la hoja Fallos. Requiere n8n con URL pública y un canal de Slack o un bot de Telegram.

## Cómo usarla

1. 1. Crea el webhook y pégalo en Sentry
2. 2. Define el umbral de usuarios afectados
3. 3. Silencia en Sentry los errores que ya conoces

## Cuándo usarla

Cuando tu móvil se llena de avisos de errores y acabas silenciándolos todos, o cuando te enteras de un fallo grave por una reseña en vez de por una alerta.

## Cómo ganar dinero con ella

Evita que un fallo se coma un día entero de instalaciones. Detectarlo en 15 minutos en vez de en 24 horas puede salvar cientos de usuarios y varias reseñas de 1 estrella.

- Alertas de fallos sin ruido para apps con usuarios reales que han dejado de mirar sus avisos.
- Vigilancia de estabilidad para agencias que mantienen apps de varios clientes en producción.
- Triaje de errores con resumen en Slack para equipos pequeños de desarrollo móvil.

**Precio orientativo:** 150–350 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recoge los avisos de fallo de tu app móvil, los junta por tipo de error durante 15 minutos y solo te manda un mensaje cuando pasan de un umbral que tú decides.
Para el que ya tiene alertas pero las ha silenciado porque le llegan cincuenta al día.

## Lo que necesitas antes
- Sentry (plan gratis, 5.000 errores/mes) con el SDK ya en tu app, o Crashlytics con Firebase Cloud Functions que reenvíen a un webhook.
- n8n con URL pública (si es auto-alojado, con un dominio o un túnel tipo Cloudflare Tunnel).
- Un canal de Slack y su webhook entrante (api.slack.com/apps → tu app → Incoming Webhooks), o un bot de Telegram.
- Una hoja `Fallos` con columnas: `huella`, `titulo`, `plataforma`, `version`, `contador`, `primer_visto`, `ultimo_aviso`.

## Los nodos, en orden
1. **Webhook** — método POST, ruta `crash`. Copia la URL Production y pégala en Sentry: Settings → Alerts → nueva regla → Action `Send a notification via webhook`, y en Integrations → WebHooks pon la URL.
2. **Code** («Extraer datos») — saca del payload el tipo de error, el mensaje, la plataforma y la versión, y calcula una «huella» para agrupar.
3. **Google Sheets** — `Get Row(s)` filtrando `huella` igual a la calculada.
4. **IF** — ¿existe fila? Si no existe, rama false.
5. **Google Sheets** (rama false) — `Append` con `contador` 1 y `ultimo_aviso` vacío.
6. **Google Sheets** (rama true) — `Update` sumando 1 al contador.
7. **IF** («¿Merece aviso?») — condición: `{{ $json.contador }}` mayor o igual a `5` **Y** hace más de 15 minutos del `ultimo_aviso`.
8. **Slack** — Send Message con: `🔥 {{$json.titulo}} — {{$json.contador}} veces en {{$json.plataforma}} v{{$json.version}}` y el enlace directo al error en Sentry.
9. **Google Sheets** — `Update` de `ultimo_aviso` con la hora actual.

## El código del nodo «Extraer datos»
```javascript
const b = $input.first().json;
const d = b.data && b.data.event ? b.data.event : b;
const titulo = (d.title || d.message || 'Error sin título').slice(0, 120);
const plataforma = (d.platform || 'desconocida');
let version = '';
if (d.release) version = String(d.release).split('@').pop();
const huella = (titulo + '|' + plataforma + '|' + version).toLowerCase().replace(/[^a-z0-9|.]/g, '');
return [{ json: {
  huella, titulo, plataforma, version,
  url: d.web_url || (b.url || ''),
  ahora: new Date().toISOString()
}}];
```

## Cómo probarla
- En Sentry, Settings → Integrations → WebHooks tiene un botón para enviar un evento de prueba. Dispáralo y mira la ejecución en n8n.
- Envía 6 veces el mismo evento de prueba: debe llegar un único mensaje a Slack, al llegar a 5.
- Provoca un fallo real en una build de pruebas (por ejemplo, un botón que lance una excepción a propósito) y comprueba el circuito completo.

## Qué puede salir mal
- Si el webhook de n8n está caído, Sentry no reintenta. Ten el workflow siempre activo y, si es auto-alojado, con reinicio automático (`restart: unless-stopped` en Docker).
- Cuidado con el bucle: si el aviso de Slack fallara y reintentara, podrías duplicar mensajes. Deja `Retry On Fail` en 2 intentos como mucho.
- La «huella» agrupa por texto; si tus mensajes de error llevan IDs de usuario dentro, agruparán mal. Quítalos con un `replace` en el Code.
- Las horas: guarda todo en ISO/UTC y compara en UTC, y muestra la hora local solo en el mensaje.

## Cuánto cuesta
Sentry gratis hasta 5.000 errores al mes (suficiente para una app pequeña); a partir de ahí unos 26 $/mes. Crashlytics es gratis sin límite. Slack gratis. n8n auto-alojado gratis.
