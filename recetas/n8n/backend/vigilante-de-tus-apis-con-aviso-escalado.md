# Vigilante de tus APIs con aviso escalado…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Cada cinco minutos llama a tus endpoints críticos, mide cuánto tardan y te avisa por Telegram solo cuando fallan de verdad, no al primer parpadeo.

## Qué es y qué hace

Cada cinco minutos llama a tus endpoints críticos, mide código de respuesta y tiempo de carga, y avisa por Telegram solo cuando un servicio falla dos veces seguidas, con un aviso también al recuperarse. Entran la lista de URLs en Sheets y el bot de Telegram; sale un aviso de caída o recuperación y el estado en la hoja. Para webs, APIs y pasarelas de pago en producción.

## Cómo usarla

1. Crea el bot de Telegram y saca tu chat_id
2. Rellena la hoja Monitor con una fila por servicio
3. Configura el disparador cada 5 minutos
4. Simula una caída para probar el aviso

## Cuándo usarla

Úsalo cuando tengas una web, una API o una pasarela de pago en producción y te enteres de las caídas porque te llama un cliente cabreado.

## Cómo ganar dinero con ella

Detectas caídas en 5 minutos en vez de en horas. Sustituye un plan de monitorización tipo Better Uptime o Pingdom de 20-50 € al mes.

- Monitorización de web y API para tiendas y SaaS pequeños con aviso al móvil…
- Vigilancia de servicios para agencias con varios clientes y resumen mensual…
- Configuración de alertas de disponibilidad para negocios que dependen de su web…

**Precio orientativo:** 30–100 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recorre una lista de URLs tuyas, comprueba código de respuesta y tiempo de carga, y avisa por Telegram cuando una falla dos veces seguidas (para no llenarte el móvil de falsas alarmas). También te avisa cuando vuelve a estar bien. Para cualquiera con servicios en producción.

## Lo que necesitas antes
- Un bot de Telegram: escribe a **@BotFather** en Telegram, `/newbot`, elige nombre y te da un token tipo `123456:AAF...`.
- Tu chat ID: escribe algo a tu bot y abre `https://api.telegram.org/bot<TU_TOKEN>/getUpdates`; el número de `chat.id` es el tuyo.
- En n8n: Credentials → New → «Telegram API» y pega el token.
- Una hoja de Google Sheets «Monitor» con columnas: nombre, url, metodo, texto_esperado, fallos_seguidos, estado. Rellena una fila por servicio, con `fallos_seguidos` a 0 y `estado` a `OK`.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: Minutes, Minutes Between Triggers: 5.
2. **Google Sheets** — Operation: Get Row(s), hoja «Monitor». Devuelve un item por servicio.
3. **Split In Batches** (en versiones nuevas se llama **Loop Over Items**) — Batch Size: 1. Así compruebas de uno en uno y un fallo no tumba el resto.
4. **HTTP Request** — Method: `={{ $json.metodo || 'GET' }}`, URL: `={{ $json.url }}`. En Options activa: Timeout 10000, «Response → Never Error» (Never Error on HTTP Status) y «Response → Include Response Headers and Status». Desactiva reintentos automáticos: quieres saber el primer resultado.
5. **Code** (renómbralo «Evaluar») — Mode: Run Once for Each Item:
```javascript
const fila = $('Split In Batches').first().json;
const resp = $input.item.json;
const codigo = resp.statusCode || 0;
const cuerpo = typeof resp.body === 'string' ? resp.body : JSON.stringify(resp.body || {});
const esperado = (fila.texto_esperado || '').trim();
const okCodigo = codigo >= 200 && codigo < 400;
const okTexto = esperado === '' || cuerpo.includes(esperado);
const ok = okCodigo && okTexto;
const previos = parseInt(fila.fallos_seguidos || '0', 10);
const fallos = ok ? 0 : previos + 1;
return { json: {
  nombre: fila.nombre, url: fila.url, codigo, ok, fallos_seguidos: fallos,
  estado_nuevo: fallos >= 2 ? 'CAIDO' : 'OK',
  estado_previo: fila.estado || 'OK',
  avisar_caida: fallos === 2,
  avisar_recuperado: ok && fila.estado === 'CAIDO',
  hora: new Date().toLocaleString('es-ES', { timeZone: 'Europe/Madrid' })
} };
```
6. **Google Sheets** — Operation: Update Row, Matching Column: `nombre`, actualiza `fallos_seguidos` y `estado` con `estado_nuevo`.
7. **IF** — Condition (Boolean, combinador OR): `{{ $json.avisar_caida }}` is true **OR** `{{ $json.avisar_recuperado }}` is true.
8. Rama **true** → **Telegram** — Operation: Send Message, Chat ID: el tuyo, Text:
```
{{ $json.avisar_caida ? '🔴 CAÍDA' : '🟢 RECUPERADO' }} {{ $json.nombre }}\nCódigo: {{ $json.codigo }}\n{{ $json.url }}\n{{ $json.hora }}
```
9. Conecta la salida del IF (y la rama false) de vuelta a la entrada de **Split In Batches** para que siga con el siguiente servicio.

## Cómo probarla
- Mete en la hoja una URL que no exista (`https://noexiste.midominio.com`). A los dos ciclos (10 min) debe llegarte el aviso rojo.
- Quítala y comprueba que llega el verde de recuperado.
- Mete una URL buena pero con `texto_esperado` = «Iniciar sesión» para verificar que también detecta páginas que responden 200 pero muestran un error.

## Qué puede salir mal
- **Falsas alarmas por red**: por eso avisamos al segundo fallo. Si tu conexión es mala, súbelo a 3 cambiando `fallos >= 2`.
- **Rate limit de Telegram**: máximo unos 30 mensajes por segundo; con 20 servicios ni te acercas.
- **Cuotas de Google Sheets**: 300 lecturas por minuto y proyecto. Con un ciclo de 5 minutos y menos de 30 servicios vas sobrado; si tienes más, cambia la hoja por el nodo **Redis** o por un fichero JSON con Read/Write Files from Disk.
- **Se cae el propio servidor de n8n**: entonces no te avisa nadie. Pon este flujo en un servidor distinto al que vigilas, o duplica el chequeo con un cron gratuito externo.
- **Certificado caducado**: HTTP Request dará error de TLS, no un código. El campo `codigo` saldrá 0 y se contará como fallo, que es lo que quieres.

## Cuánto cuesta
Todo gratis: n8n auto-alojado 0 €, Telegram 0 €, Sheets 0 €. En n8n Cloud, 288 ejecuciones al día se comen el plan gratuito, así que aquí el auto-alojado gana claramente.
