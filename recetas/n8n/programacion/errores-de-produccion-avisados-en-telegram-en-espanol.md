# Errores de producción avisados en Telegram en español…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Cada error nuevo que Sentry detecta en tu web o app llega a tu Telegram explicado en llano: qué falló, en qué archivo y a cuánta gente afecta.

## Qué es y qué hace

Sentry envía por webhook cada error nuevo de tu web o app a n8n, que lo traduce a lenguaje llano con un modelo de IA y lo manda a tu chat de Telegram con el archivo afectado, el número de usuarios y un enlace al detalle. Se monta con n8n, Make o Zapier y necesita una cuenta de Sentry y una clave de API de un modelo de IA.

## Cómo usarla

1. Crea la cuenta de Sentry y añade su SDK al proyecto
2. Configura el webhook de alertas hacia n8n
3. Añade el bot de Telegram
4. Provoca un error de prueba y revisa el aviso

## Cuándo usarla

Úsalo cuando tengas proyectos en producción y te enteres de los fallos porque te llama el cliente, no porque mires el panel de Sentry.

## Cómo ganar dinero con ella

Detectar un fallo en 2 minutos en vez de 2 días evita reembolsos y ventas perdidas. Sentry gratis hasta 5.000 errores/mes; n8n auto-alojado, 0 €.

- Monitorización de errores como servicio mensual para webs de clientes…
- Alertas de fallos en tiempo real para tiendas online…
- Configuración de Sentry con avisos traducidos para equipos no técnicos…

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Sentry te avisa por webhook cada vez que aparece un error NUEVO en tu proyecto; la automatización lo limpia, lo traduce a lenguaje llano y te lo manda a un chat de Telegram con enlace directo al detalle.
Para el programador freelance o la agencia que mantiene webs y apps de clientes y necesita enterarse antes que el cliente.
## Lo que necesitas antes
- Cuenta de Sentry (plan Developer gratis: 5.000 errores al mes). El SDK ya instalado en tu proyecto.
- n8n: auto-alojado con Docker (gratis) o n8n Cloud (prueba gratuita). Necesitas que tu n8n sea accesible desde internet para recibir el webhook.
- Bot de Telegram: escribe a @BotFather en Telegram, comando /newbot, te da el token. Luego escribe algo a tu bot y abre https://api.telegram.org/bot<TU_TOKEN>/getUpdates para ver tu chat id. Esa URL se abre solo en el navegador: en n8n el token va en la credencial de Telegram, nunca escrito en un nodo, porque un flujo exportado se llevaría la clave.
- Opcional: clave de API de OpenAI (platform.openai.com > API keys) para el resumen en español. Sin ella, el aviso va igual pero más técnico.
## Los nodos, en orden
1) **Webhook**: método POST, path `sentry-errores`, Respond: `Immediately`. Copia la Production URL. Protégelo: verifica la cabecera `Sentry-Hook-Signature` (HMAC-SHA256 del cuerpo con el Client Secret de la integración, leído de una variable de entorno) en un nodo Code y descarta lo que no cuadre.
2) En Sentry, ve a Settings > tu proyecto > Alerts > Create Alert > Issues, condición «A new issue is created», acción «Send a notification via an integration > Webhook» y pega la URL del paso 1.
3) **IF**: condición String, valor 1 `{{ $json.body.action }}`, operación «is equal to», valor 2 `created`. Así ignoras eventos de resolución o asignación.
4) **Code** (rama true): normaliza los datos del error. Código completo abajo.
5) **HTTP Request** (opcional, para el resumen en español): método POST, URL `https://api.openai.com/v1/chat/completions`, autenticación «Generic Credential Type > Header Auth», nombre `Authorization`, valor `Bearer TU_CLAVE`. Body JSON:
```json
{ "model": "gpt-4o-mini", "messages": [{"role": "user", "content": "Explica este error de programación en dos frases, en español de España, para un desarrollador con prisa. No repitas el stacktrace: {{ $json.titulo }} | {{ $json.cultura }}"}] }
```
6) **Telegram**: Resource `Message`, Operation `Send Message`, Chat ID tu id, Text con este contenido y «Parse Mode» en `HTML`:
`<b>🔴 {{ $('Code').item.json.proyecto }}</b>\n{{ $('Code').item.json.titulo }}\n<i>{{ $json.choices[0].message.content }}</i>\n👥 {{ $('Code').item.json.usuarios }} usuarios · {{ $('Code').item.json.entorno }}\n<a href="{{ $('Code').item.json.url }}">Ver en Sentry</a>`
## El nodo Code
```javascript
const d = $input.first().json.body.data?.issue || $input.first().json.body;
const meta = d.metadata || {};
return [{ json: {
  proyecto: d.project?.name || d.project || 'proyecto',
  titulo: `${meta.type || d.title || 'Error'}: ${(meta.value || '').slice(0, 200)}`,
  cultura: meta.filename || d.culprit || 'sin ubicación',
  usuarios: d.userCount ?? 0,
  entorno: (d.tags || []).find(t => t[0] === 'environment')?.[1] || 'production',
  url: d.web_url || d.permalink || 'https://sentry.io'
}}];
```
## Cómo probarla
- En n8n pulsa «Listen for test event» en el Webhook y, en Sentry, usa el botón «Send Test Notification» de la alerta.
- Provoca un error de verdad en un entorno de staging (por ejemplo una división por cero) y comprueba que el mensaje llega en menos de un minuto.
- Antes de activarla, revisa que la rama IF false no haga nada: no quieres notificar cada cambio de estado.
## Qué puede salir mal
- **Telegram te ignora**: si no has escrito tú primero al bot, no puede mandarte nada. Escríbele /start.
- **Avalancha de mensajes**: si un error se repite 5.000 veces recibes spam. En Sentry, en la alerta, activa «Only send a notification for an issue's first occurrence» y añade un intervalo de 30 minutos.
- **El formato de Sentry cambia**: por eso el Code usa `?.` y valores por defecto; si ves «undefined», abre la ejecución en n8n y mira el JSON real de entrada.
- **Timeouts de OpenAI**: en el HTTP Request, pestaña Settings, activa «Retry On Fail» con 2 intentos y «Continue On Fail» para que el aviso llegue aunque falle el resumen.
## Cuánto cuesta
- n8n auto-alojado en un VPS de 5 €/mes: gratis el software. n8n Cloud arranca en unos 20 €/mes.
- Sentry: gratis hasta 5.000 errores/mes; el plan Team son unos 26 €/mes.
- Telegram: gratis. OpenAI: con gpt-4o-mini, unos 0,02 € al mes con 200 errores.
