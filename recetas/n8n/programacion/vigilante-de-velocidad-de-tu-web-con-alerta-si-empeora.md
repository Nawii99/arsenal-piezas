# Vigilante de velocidad de tu web con alerta si empeora…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Mide cada día la velocidad real de tus páginas con la API de PageSpeed de Google y te avisa solo cuando la nota baja respecto a la semana anterior.

## Qué es y qué hace

Flujo de n8n que cada madrugada pide a la API de PageSpeed Insights la puntuación y las métricas Core Web Vitals de una lista de URLs. Guarda los resultados en una hoja, los compara con la media de los últimos siete días y envía un aviso por Telegram con la URL, la métrica y la caída cuando supera un umbral. Funciona en n8n auto-alojado o en n8n Cloud (de pago tras la prueba).

## Cómo usarla

1. Crea la clave de API de PageSpeed
2. Crea el bot de Telegram
3. Define URLs y umbrales en la hoja
4. Activa el disparador diario

## Cuándo usarla

Úsalo cuando tengas una web o tienda donde la velocidad afecta a las ventas y quieras enterarte de que un despliegue la ha ralentizado antes de que lo note Google o el cliente.

## Cómo ganar dinero con ella

Detectar en 24 horas una caída de rendimiento evita semanas de pérdida de posiciones y conversión: en una tienda pequeña, cientos de euros al mes.

- Vigilancia diaria del rendimiento de tiendas online tras cada actualización…
- Control de calidad web para agencias que entregan webs a clientes…
- Servicio de monitorización de Core Web Vitals con informe mensual…

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada madrugada pide a Google la puntuación de rendimiento y las métricas Core Web Vitals de una lista de URLs tuyas, las guarda en una hoja y compara con la media de los últimos siete días. Si algo empeora más de un umbral, te llega un mensaje de Telegram con la URL, la métrica y cuánto ha caído.
Para quien desarrolla y mantiene webs de clientes y necesita una prueba objetiva de que la web va bien, o de que dejó de ir bien justo cuando el cliente tocó algo.

## Lo que necesitas antes
- Cuenta de n8n (gratis si la auto-alojas con la Community Edition; n8n Cloud solo tiene una prueba gratuita temporal y después es de pago).
- Clave de la API de PageSpeed Insights: entra en console.cloud.google.com, crea un proyecto, ve a «APIs y servicios» → «Biblioteca», activa «PageSpeed Insights API», y luego en «Credenciales» → «Crear credenciales» → «Clave de API». Es gratuita, con 25.000 consultas al día.
- Un bot de Telegram: escribe a @BotFather, comando `/newbot`, te da un token. Luego escribe algo a tu bot y consulta `getUpdates` de la API de Telegram desde tu navegador o con curl en tu ordenador para ver tu `chat_id` (es la única vez que el token va en una URL; no la pegues en ningún nodo). El token se guarda solo en una credencial «Telegram API» de n8n.
- Una hoja de Google Sheets «Velocidad web» con columnas: fecha, url, dispositivo, puntuacion, lcp_ms, cls, inp_ms.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 4 * * *` (todos los días a las 4:00, zona `Europe/Madrid`). De madrugada porque la API va más desahogada.
2. **Set** («URLs a medir») — campo `urls` tipo Array, por ejemplo `["https://tudominio.es","https://tudominio.es/tienda","https://tudominio.es/contacto"]`.
3. **Item Lists** (Split Out, campo `urls`).
4. **Split In Batches** — Batch Size 1: la API de PageSpeed tarda entre 10 y 30 segundos por URL y no conviene paralelizar.
5. **HTTP Request** — GET a `https://www.googleapis.com/pagespeedonline/v5/runPagespeed?url={{ encodeURIComponent($json.urls) }}&strategy=mobile&category=performance`, con Authentication: Generic > Query Auth con una credencial de n8n (Name `key`, Value tu clave). En Settings sube el «Timeout» a 60000 ms y activa «Retry On Fail» (2 intentos, 5000 ms). No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él.
6. **Code** («Extraer métricas») — te quedas solo con lo que importa.
```javascript
const salida = [];
for (const item of $input.all()) {
  const r = item.json.lighthouseResult;
  const a = r.audits;
  salida.push({ json: {
    fecha: new Date().toISOString().slice(0, 10),
    url: r.finalUrl,
    dispositivo: 'movil',
    puntuacion: Math.round(r.categories.performance.score * 100),
    lcp_ms: Math.round(a['largest-contentful-paint'].numericValue),
    cls: Number(a['cumulative-layout-shift'].numericValue.toFixed(3)),
    inp_ms: a['interaction-to-next-paint'] ? Math.round(a['interaction-to-next-paint'].numericValue) : 0
  } });
}
return salida;
```
7. **Google Sheets** — Operation: Append, hoja «Velocidad web».
8. **Google Sheets** (segundo nodo, «Histórico») — Operation: Get Row(s), sin filtro, para traerte todas las filas y poder comparar.
9. **Code** («Comparar con la media») — decide si hay que alertar.
```javascript
const hoy = $('Extraer métricas').all().map(i => i.json);
const historico = $input.all().map(i => i.json);
const avisos = [];
for (const fila of hoy) {
  const previas = historico.filter(h => h.url === fila.url && h.fecha !== fila.fecha).slice(-7);
  if (previas.length < 3) continue;
  const media = previas.reduce((s, p) => s + Number(p.puntuacion), 0) / previas.length;
  if (fila.puntuacion < media - 8) {
    avisos.push({ json: { texto: 'Bajada en ' + fila.url + ': ' + fila.puntuacion + ' frente a media ' + Math.round(media) + '. LCP ' + fila.lcp_ms + ' ms, CLS ' + fila.cls } });
  }
}
return avisos;
```
10. **IF** — condición «Number of items» mayor que 0, o directamente deja que el Code no devuelva nada y el flujo se pare solo.
11. **Telegram** — Credencial «Telegram API» (el token no se escribe en el nodo). Operation: Send Message, Chat ID el tuyo, Text `{{ $json.texto }}`.

## Cómo probarla
Lanza el workflow a mano con una sola URL. Para forzar una alerta, edita en la hoja unas cuantas puntuaciones antiguas subiéndolas a 95 y vuelve a ejecutar: debe llegarte el mensaje. Comprueba también una URL con `strategy=desktop` para ver la diferencia.

## Qué puede salir mal
- **Error 429 o 500 de la API**: PageSpeed falla de vez en cuando sin motivo. El «Retry On Fail» resuelve el 90%; para el resto activa «Continue On Fail» en el HTTP Request y filtra después los elementos sin `lighthouseResult`.
- **Falsos positivos**: la medición de laboratorio oscila 5-10 puntos entre ejecuciones. Por eso se compara contra la media de siete días y con un margen de 8 puntos, no contra el día anterior.
- **URLs con redirección**: guarda `finalUrl`, no la que enviaste, o compararás manzanas con peras.
- **Ejecuciones largas**: con 20 URLs el flujo puede tardar 10 minutos; en n8n Cloud eso cuenta como una sola ejecución, no pasa nada, pero sube el timeout general del workflow en Settings.

## Cuánto cuesta
Cero euros. La API de PageSpeed es gratuita hasta 25.000 consultas diarias, Telegram es gratis, Google Sheets también. El único gasto posible es el alojamiento de n8n si no lo tienes ya (o un plan de pago de n8n Cloud si prefieres no alojarlo).
