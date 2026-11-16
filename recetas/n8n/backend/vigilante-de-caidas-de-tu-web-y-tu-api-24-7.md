# Vigilante de caídas de tu web y tu API 24/7

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Comprueba cada 5 minutos que tu web y tus endpoints responden bien y rápido, y te avisa por Telegram en cuanto algo falla y cuando vuelve. Para quien tiene una web, una tienda o una API.

## Qué es y qué hace

Pide cada 5 minutos a una lista de URLs (web, login, API, pasarela de pago) y comprueba código de estado, tiempo de respuesta y que aparezca el texto esperado. Si falla dos veces seguidas te avisa por Telegram, y cuando vuelve te dice cuánto duró la caída. Entrada: lista de URLs en una hoja; salida: alertas y registro histórico. Se monta en n8n sin pagar un monitor externo.

## Cómo usarla

1. Crea el bot de Telegram y saca tu chat ID
2. Rellena la hoja monitor con tus URLs
3. Activa el flujo cada 5 minutos
4. Revisa el histórico una vez por semana

## Cuándo usarla

Úsalo cuando tengas cualquier cosa en producción (web, API, panel de clientes) y no pagues una herramienta de monitorización, o quieras vigilar rutas concretas que los servicios estándar no miran.

## Cómo ganar dinero con ella

Sustituye a un plan de monitorización tipo UptimeRobot Pro o Better Stack (20-50 euros al mes) y recorta las caídas de horas a minutos, que es lo que cuesta dinero.

- Monitorización para tiendas online con alertas inmediatas si cae la pasarela de pago.
- Vigilancia de APIs para startups que dependen de un proveedor externo.
- Panel de disponibilidad mensual para clientes con web propia.

**Precio orientativo:** 30–90 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lanza peticiones HTTP cada 5 minutos contra una lista de URLs tuyas (portada, login, un endpoint de API, la pasarela de pago) y comprueba código de estado, tiempo de respuesta y que el contenido esperado esté ahí.
Si algo falla dos veces seguidas te manda un mensaje a Telegram, y cuando se recupera te manda otro con cuánto duró la caída; todo queda registrado en una hoja de cálculo para tener histórico.

## Lo que necesitas antes
- n8n funcionando (n8n.cloud en su prueba gratuita temporal, o auto-alojado con Docker en un VPS de 5 euros al mes).
- Una cuenta de Telegram y un bot: escribe a @BotFather, comando /newbot, te da un token tipo 123456:AAF... Guárdalo.
- Tu chat ID: escribe algo a tu bot y consulta `getUpdates` de la API de Telegram desde tu navegador o con curl en tu ordenador (es la única vez que el token va en una URL; no la pegues en ningún nodo ni la compartas); el número que ves en "chat":{"id": es tu chat ID. El token se guarda solo en una credencial «Telegram API» de n8n: un flujo exportado con el token escrito en un nodo se llevaría la clave.
- Una hoja de Google Sheets llamada "monitor" con dos pestañas: "estado" (columnas: url, estado, desde, fallos_seguidos) y "historial" (columnas: fecha, url, evento, codigo, ms, mensaje).
- Credenciales de Google en n8n: Credentials, Google Sheets OAuth2, seguir el asistente.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: Minutes, Minutes Between Triggers: 5.
2. **Code** (nombre: Lista de URLs) — modo "Run Once for All Items". Devuelve un item por URL a vigilar. Código más abajo.
3. **Loop Over Items** (antes Split In Batches) — Batch Size: 1. Así una URL lenta no bloquea a las demás. Su salida «loop» (la segunda) va al nodo siguiente; la «done» queda sin conectar. La salida del nodo del paso 11 vuelve a la entrada de este nodo.
3 bis. **Set** (Edit Fields, nombre exacto: Marcar inicio, porque el código de «Evaluar» lo cita) — activa que conserve los demás campos y añade un campo numérico `inicio` con `={{ Date.now() }}`. Va justo antes del HTTP Request.
4. **HTTP Request** — Method: GET, URL: `={{ $json.url }}`, Response: Include Response Headers and Status, Never Error (activa "Always Output Data" y en Settings pon "On Error: Continue (using error output)"), Timeout: 10000 ms. En Options activa Full Response. Las dos salidas del nodo (la normal y la de error) se conectan al nodo del paso 5.
5. **Code** (nombre: Evaluar) — decide si la respuesta es buena o mala comparando código de estado, milisegundos y texto esperado.
6. **Google Sheets** (nombre: Leer estado) — Operation: Get Row(s), Document: monitor, Sheet: estado, Filter: url igual a `={{ $json.url }}`. Activa «Always Output Data» para que, si la URL aún no está en la hoja, el flujo siga.
7. **Code** (nombre: Decidir aviso) — compara el estado nuevo con el guardado y marca `avisar: true` solo en el cambio (dos fallos seguidos para entrar en caída, un OK para salir).
8. **Google Sheets** (nombre: Guardar estado) — Operation: Append or Update Row, columna clave: url.
9. **IF** (va después de «Guardar estado») — Condition: Boolean, Value 1 `={{ $('Decidir aviso').item.json.avisar }}` (aquí `$json` ya es la respuesta de Google Sheets, no el aviso), is true. La salida true va al paso 10; la false va directa al paso 11.
10. **Telegram** — Credencial «Telegram API» (el token no se escribe en el nodo). Operation: Send Message, Chat ID: el tuyo, Text: `={{ $('Decidir aviso').item.json.mensaje }}`, Parse Mode: HTML. En Settings activa Retry On Fail y On Error: Continue (regular output), para que aunque Telegram falle se anote en el historial. Su salida va al paso 11.
11. **Google Sheets** (nombre: Historial) — Operation: Append Row en la pestaña historial, con cada columna (fecha, url, evento, codigo, ms, mensaje) tomada de `$('Decidir aviso').item.json.<campo>`. Recibe la salida de Telegram y también la salida false del IF.

## El código del nodo "Lista de URLs"
```javascript
const urls = [
  { url: 'https://tudominio.com', espera: 'Iniciar sesión', maxMs: 3000 },
  { url: 'https://tudominio.com/api/health', espera: 'ok', maxMs: 1500 },
  { url: 'https://tudominio.com/checkout', espera: 'Pagar', maxMs: 4000 }
];
return urls.map(u => ({ json: u }));
```

## El código del nodo "Evaluar"
```javascript
// la URL que se acaba de pedir (url, espera, maxMs, inicio), emparejada con ESTE resultado y no con 'la primera'
let cfg;
try { cfg = $('Marcar inicio').itemMatching(0).json; } catch (e) { cfg = $('Marcar inicio').first().json; }
const status = Number($json.statusCode || ($json.error && ($json.error.status || $json.error.httpCode)) || 0);
// con «respuesta completa», el nodo HTTP Request deja el texto en «data» (o en «body», según la versión): se miran los dos
const _b = $json.body ?? $json.data;
const cuerpo = typeof _b === 'string' ? _b : JSON.stringify(_b || '');
const ms = Date.now() - Number(cfg.inicio || Date.now());
let ok = status >= 200 && status < 400;
let motivo = ok ? 'OK' : ('estado ' + status + ' o texto ausente');
if (ok && cfg.espera && !cuerpo.includes(cfg.espera)) { ok = false; motivo = 'estado ' + status + ' o texto ausente'; }
if (ok && cfg.maxMs && ms > cfg.maxMs) { ok = false; motivo = 'lenta: ' + ms + ' ms (máximo ' + cfg.maxMs + ')'; }
return [{ json: { url: cfg.url, ok, codigo: status, ms, motivo } }];
```

## El código del nodo "Decidir aviso"
```javascript
// resultado de esta vuelta, emparejado con el estado leído (la entrada de este nodo)
let ev;
try { ev = $('Evaluar').itemMatching(0).json; } catch (e) { ev = $('Evaluar').first().json; }
const prev = $input.all()[0]?.json || {};
const fallos = Number(prev.fallos_seguidos || 0);
const estadoPrev = prev.estado || 'ok';
const ahora = new Date().toISOString();
let estado = estadoPrev, avisar = false, mensaje = '';
const nuevosFallos = ev.ok ? 0 : fallos + 1;
if (!ev.ok && nuevosFallos >= 2 && estadoPrev !== 'caida') { estado = 'caida'; avisar = true; mensaje = '🔴 <b>CAÍDA</b> ' + ev.url + ' — ' + ev.motivo; }
if (ev.ok && estadoPrev === 'caida') { const mins = Math.round((Date.now() - new Date(prev.desde || ahora).getTime())/60000); estado = 'ok'; avisar = true; mensaje = '🟢 <b>RECUPERADA</b> ' + ev.url + ' tras ' + mins + ' min'; }
return [{ json: { url: ev.url, estado, fallos_seguidos: nuevosFallos, desde: estado !== estadoPrev ? ahora : (prev.desde || ahora), avisar, mensaje, codigo: ev.codigo, ms: ev.ms, fecha: ahora, evento: estado } }];
```

## Cómo probarla
- Añade a la lista una URL falsa tipo https://tudominio.com/no-existe-999 y ejecuta el flujo a mano con Execute Workflow dos veces seguidas: a la segunda debe llegarte el Telegram de caída.
- Quita esa URL y ejecuta otra vez: debe llegarte el mensaje de recuperada.
- Revisa que la pestaña historial se está rellenando y que los tiempos tienen sentido.

## Qué puede salir mal
- **Te avisa cuando no toca (falsos positivos)**: por eso hay dos fallos seguidos antes de avisar. Si tu servidor es lento, sube el Timeout a 15000 y el maxMs.
- **Telegram deja de responder**: los bots tienen límite de 30 mensajes por segundo, no lo vas a tocar; si el nodo falla, activa Retry On Fail con 3 intentos y 5 segundos de espera.
- **Zona horaria**: pon la del workflow en Settings, Timezone: Europe/Madrid, o las horas del historial saldrán en UTC (dos horas menos en verano).
- **Se te acaban las ejecuciones**: cada 5 minutos son 8.640 ejecuciones al mes. En la prueba gratuita de n8n Cloud no cabe: o lo pones a 15 minutos, o lo auto-alojas (ejecuciones ilimitadas).

## Cuánto cuesta
- n8n auto-alojado: gratis, salvo el VPS (5-6 euros al mes en Hetzner o Contabo).
- n8n Cloud: el plan de pago empieza en unos 20 euros al mes por el volumen de ejecuciones.
- Telegram y Google Sheets: gratis.
