# Vigía de caídas: avisa en 5 minutos si tu web se cae…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Comprueba tu web cada 5 minutos y te avisa por Telegram cuando deja de responder y cuando vuelve. Para cualquiera que venda por su web y no quiera enterarse por un cliente cabreado.

## Qué es y qué hace

Llama a tu web cada 5 minutos, revisa el código de respuesta y el tiempo de carga y, si falla dos veces seguidas, te manda un aviso a Telegram con la hora y el error. Cuando vuelve, envía un mensaje de recuperación con los minutos caída y lo apunta en Google Sheets para reclamar al hosting. Sirve a webs de venta o captación en hosting compartido o WordPress.

## Cómo usarla

1. Crear el bot de Telegram y el chat ID
2. Preparar la hoja Caídas web
3. Montar el flujo de 5 minutos en n8n
4. Probar apagando una URL de prueba

## Cuándo usarla

Úsalo cuando tu web sea el canal de ventas o de captación y una caída de una hora te cueste dinero o reputación. Ideal si tienes hosting compartido o WordPress.

## Cómo ganar dinero con ella

Una caída detectada a los 10 minutos en vez de a las 8 horas. Sustituye a un plan de monitorización de 15-25 € al mes y evita perder un día entero de pedidos.

- Monitorización de web para tiendas y negocios locales que dependen de la web para vender.
- Informe mensual de disponibilidad para reclamar al hosting por caídas.
- Servicio de vigilancia de webs de clientes para agencias y freelances de WordPress.

**Precio orientativo:** 60–150 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Llama a tu web cada 5 minutos, mira el código de respuesta y el tiempo que tarda, y si falla dos veces seguidas te manda un aviso a Telegram con la hora y el error.
Cuando la web vuelve, te manda un segundo mensaje de «recuperada» con los minutos que estuvo caída, y deja todo apuntado en una hoja de cálculo para reclamar al hosting.

## Lo que necesitas antes
- n8n funcionando: plan gratuito de n8n Cloud o auto-alojado (una VPS de 5 €/mes o un Docker en tu ordenador que esté siempre encendido).
- Un bot de Telegram: escribe a @BotFather en Telegram, comando `/newbot`, te da un token tipo `123456:AAxx...`. Copia ese token.
- Tu chat ID: escribe algo a tu bot y abre `https://api.telegram.org/bot<TU_TOKEN>/getUpdates` en el navegador; el número que sale en `chat.id` es el tuyo.
- Una hoja de Google llamada «Caídas web» con las columnas: fecha, url, evento, codigo, ms, mensaje.
- Credencial de Google Sheets en n8n (OAuth2, se conecta con dos clics desde el propio nodo).

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: Minutes, Minutes Between Triggers: 5.
2. **HTTP Request** (renómbralo «Ping web») — Method: GET; URL: `https://tudominio.com/`; en Options activa `Response > Include Response Headers and Status` y `Response > Never Error` (para que un 500 no rompa el flujo); `Timeout`: 10000 ms; `Redirects > Follow`: activado. En Settings del nodo: `On Error: Continue (using error output)` y `Retry On Fail`: desactivado (ya lo repetimos nosotros).
3. **Code** (renómbralo «Decidir aviso») — Mode: Run Once for All Items. Pega el código de abajo. Guarda memoria entre ejecuciones para no spamearte cada 5 minutos.
4. **Switch** — Mode: Rules, campo `{{ $json.accion }}`; salida 1 si es igual a `caida`, salida 2 si es igual a `recuperada`, salida 3 (fallback) a nada.
5. **Telegram** (salida 1) — Resource: Message, Operation: Send; Chat ID: el tuyo; Text: `🔴 CAÍDA en tudominio.com\nCódigo: {{ $json.codigo }}\nHora: {{ $json.fecha }}\nDetalle: {{ $json.mensaje }}`.
6. **Telegram** (salida 2) — Text: `🟢 tudominio.com vuelve a responder. Estuvo caída {{ $json.minutos }} minutos.`
7. **Google Sheets** (conectado a las dos salidas de Telegram) — Resource: Sheet Within Document, Operation: Append Row; Document: «Caídas web»; Mapping Column Mode: Map Each Column Manually; fecha `={{ $json.fecha }}`, url `tudominio.com`, evento `={{ $json.accion }}`, codigo `={{ $json.codigo }}`, ms `={{ $json.ms }}`, mensaje `={{ $json.mensaje }}`.

## El código del nodo Code
```js
const s = $getWorkflowStaticData('global');
const item = $input.first().json;
const codigo = item.statusCode || item.error?.statusCode || 0;
const ok = codigo >= 200 && codigo < 400;
const ahora = new Date();
const fecha = ahora.toLocaleString('es-ES', { timeZone: 'Europe/Madrid' });
s.fallos = ok ? 0 : (s.fallos || 0) + 1;
let accion = 'nada';
let minutos = 0;
if (!ok && s.fallos >= 2 && !s.avisado) { accion = 'caida'; s.avisado = true; s.desde = ahora.getTime(); }
if (ok && s.avisado) { accion = 'recuperada'; s.avisado = false; minutos = Math.round((ahora.getTime() - (s.desde || ahora.getTime())) / 60000); }
const mensaje = ok ? 'OK' : (item.error?.message || 'Sin respuesta o código de error');
return [{ json: { accion, codigo, fecha, minutos, ms: item.headers ? 0 : 0, mensaje } }];
```

## Cómo probarla
- Cambia temporalmente la URL a `https://tudominio.com/pagina-que-no-existe-123` y ejecuta el flujo a mano dos veces con «Test workflow»: en la segunda debe llegarte el Telegram rojo.
- Devuelve la URL buena y ejecútalo otra vez: debe llegarte el verde con los minutos.
- Solo entonces activa el interruptor «Active» arriba a la derecha.

## Qué puede salir mal
- **Te llegan avisos falsos**: sube el umbral en el código de `>= 2` a `>= 3`, o sube el Timeout a 20000 ms si tu hosting es lento.
- **Detecta la web «viva» pero sale error de PHP**: añade un nodo IF extra que compruebe `{{ $json.data.includes('Mi título') }}` sobre el HTML.
- **Se pierde la memoria**: los datos estáticos se borran si duplicas o reimportas el flujo; el peor caso es un aviso repetido, nada grave.
- **Zona horaria**: si tu n8n está en UTC verás una hora menos; el código ya fuerza `Europe/Madrid`, no toques la del servidor.
- **Telegram bloquea el envío**: tienes que haber escrito tú primero al bot; si no, devuelve «chat not found».

## Cuánto cuesta
- Gratis del todo si te auto-alojas n8n (Docker) o usas n8n Cloud gratuito. Telegram y Google Sheets, gratis.
- Ojo con el plan gratuito de n8n Cloud: cada 5 minutos son unas 8.600 ejecuciones al mes y te comerás el límite. Con auto-alojado no hay límite; si estás en la nube, pon 15 minutos o pasa a su plan de pago (~20 €/mes).
