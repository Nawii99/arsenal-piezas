# Vigilante de caídas de tu web y tu API 24/7…

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
- n8n funcionando (plan Starter gratuito en n8n.cloud, o auto-alojado con Docker en un VPS de 5 euros al mes).
- Una cuenta de Telegram y un bot: escribe a @BotFather, comando /newbot, te da un token tipo 123456:AAF... Guárdalo.
- Tu chat ID: escribe algo a tu bot y abre https://api.telegram.org/bot<TU_TOKEN>/getUpdates en el navegador; el número que ves en "chat":{"id": es tu chat ID.
- Una hoja de Google Sheets llamada "monitor" con dos pestañas: "estado" (columnas: url, estado, desde, fallos_seguidos) y "historial" (columnas: fecha, url, evento, codigo, ms, mensaje).
- Credenciales de Google en n8n: Credentials, Google Sheets OAuth2, seguir el asistente.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: Minutes, Minutes Between Triggers: 5.
2. **Code** (nombre: Lista de URLs) — modo "Run Once for All Items". Devuelve un item por URL a vigilar. Código más abajo.
3. **Loop Over Items** (antes Split In Batches) — Batch Size: 1. Así una URL lenta no bloquea a las demás.
4. **HTTP Request** — Method: GET, URL: `={{ $json.url }}`, Response: Include Response Headers and Status, Never Error (activa "Always Output Data" y en Settings pon "On Error: Continue (using error output)"), Timeout: 10000 ms. En Options activa Full Response.
5. **Code** (nombre: Evaluar) — decide si la respuesta es buena o mala comparando código de estado, milisegundos y texto esperado.
6. **Google Sheets** (nombre: Leer estado) — Operation: Get Row(s), Document: monitor, Sheet: estado, Filter: url igual a `={{ $json.url }}`.
7. **Code** (nombre: Decidir aviso) — compara el estado nuevo con el guardado y marca `avisar: true` solo en el cambio (dos fallos seguidos para entrar en caída, un OK para salir).
8. **Google Sheets** (nombre: Guardar estado) — Operation: Append or Update Row, columna clave: url.
9. **IF** — Condition: Boolean, Value 1 `={{ $json.avisar }}`, is true.
10. **Telegram** — Operation: Send Message, Chat ID: el tuyo, Text: `={{ $json.mensaje }}`, Parse Mode: HTML.
11. **Google Sheets** (nombre: Historial) — Operation: Append Row en la pestaña historial.

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
const req = $('Lista de URLs').all().find(i => i.json.url === $json.url) || { json: {} };
const cfg = req.json;
const status = $json.statusCode || $json.error?.status || 0;
const cuerpo = typeof $json.body === 'string' ? $json.body : JSON.stringify($json.body || '');
const ms = Date.now() - new Date($execution.startedAt || Date.now()).getTime();
let ok = status >= 200 && status < 400;
if (ok && cfg.espera && !cuerpo.includes(cfg.espera)) ok = false;
return [{ json: { url: cfg.url, ok, codigo: status, ms, motivo: ok ? 'OK' : ('estado ' + status + ' o texto ausente') } }];
```

## El código del nodo "Decidir aviso"
```javascript
const prev = $('Leer estado').all()[0]?.json || {};
const fallos = Number(prev.fallos_seguidos || 0);
const estadoPrev = prev.estado || 'ok';
const ahora = new Date().toISOString();
let estado = estadoPrev, avisar = false, mensaje = '';
const nuevosFallos = $json.ok ? 0 : fallos + 1;
if (!$json.ok && nuevosFallos >= 2 && estadoPrev !== 'caida') { estado = 'caida'; avisar = true; mensaje = '🔴 <b>CAÍDA</b> ' + $json.url + ' — ' + $json.motivo; }
if ($json.ok && estadoPrev === 'caida') { const mins = Math.round((Date.now() - new Date(prev.desde || ahora).getTime())/60000); estado = 'ok'; avisar = true; mensaje = '🟢 <b>RECUPERADA</b> ' + $json.url + ' tras ' + mins + ' min'; }
return [{ json: { url: $json.url, estado, fallos_seguidos: nuevosFallos, desde: estado !== estadoPrev ? ahora : (prev.desde || ahora), avisar, mensaje, codigo: $json.codigo, ms: $json.ms, fecha: ahora, evento: estado } }];
```

## Cómo probarla
- Añade a la lista una URL falsa tipo https://tudominio.com/no-existe-999 y ejecuta el flujo a mano con Execute Workflow dos veces seguidas: a la segunda debe llegarte el Telegram de caída.
- Quita esa URL y ejecuta otra vez: debe llegarte el mensaje de recuperada.
- Revisa que la pestaña historial se está rellenando y que los tiempos tienen sentido.

## Qué puede salir mal
- **Te avisa cuando no toca (falsos positivos)**: por eso hay dos fallos seguidos antes de avisar. Si tu servidor es lento, sube el Timeout a 15000 y el maxMs.
- **Telegram deja de responder**: los bots tienen límite de 30 mensajes por segundo, no lo vas a tocar; si el nodo falla, activa Retry On Fail con 3 intentos y 5 segundos de espera.
- **Zona horaria**: pon la del workflow en Settings, Timezone: Europe/Madrid, o las horas del historial saldrán en UTC (dos horas menos en verano).
- **Se te acaban las ejecuciones**: cada 5 minutos son 8.640 ejecuciones al mes. En n8n Cloud gratuito no cabe: o lo pones a 15 minutos, o lo auto-alojas (ejecuciones ilimitadas).

## Cuánto cuesta
- n8n auto-alojado: gratis, salvo el VPS (5-6 euros al mes en Hetzner o Contabo).
- n8n Cloud: el plan de pago empieza en unos 20 euros al mes por el volumen de ejecuciones.
- Telegram y Google Sheets: gratis.
