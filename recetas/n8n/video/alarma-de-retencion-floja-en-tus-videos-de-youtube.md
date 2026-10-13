# Alarma de retención floja en tus vídeos de YouTube…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Cada lunes compara la retención media de tus últimos vídeos con la media histórica del canal y te avisa de cuáles pierden público antes de lo normal.

## Qué es y qué hace

Es una automatización de n8n que cada lunes calcula el porcentaje medio visto de tus vídeos de los últimos 30 días y lo compara con la media histórica del canal, avisándote de los que caen por debajo. Entra el ID de tu canal con la API de YouTube Analytics; sale un aviso con el enlace y el dato exacto por cada vídeo flojo. Requiere activar YouTube Data API y YouTube Analytics API con permisos de solo lectura.

## Cómo usarla

1. Activa las dos APIs de YouTube en Google Cloud
2. Conecta la credencial OAuth2 con tu ID de canal
3. Revisa el primer aviso con los últimos 30 días
4. Ajusta el umbral

## Cuándo usarla

Úsalo cuando ya publicas con cierta regularidad en YouTube y no te da la vida para entrar cada semana a mirar las gráficas de retención vídeo por vídeo.

## Cómo ganar dinero con ella

Te ahorra la revisión manual semanal (1-2 h) y detecta el vídeo flojo a los pocos días, cuando aún puedes cambiar gancho, título o miniatura.

- Seguimiento de retención para creadores que publican dos veces al mes.
- Alerta de rendimiento para agencias que entregan informes de canales de clientes.
- Revisión semanal de vídeos para academias con cursos en YouTube.

**Precio orientativo:** 100–250 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Revisa cada lunes tus vídeos publicados en los últimos 30 días y calcula el porcentaje medio visto de cada uno. Si alguno está por debajo de la media del canal, te manda un aviso con el enlace y el dato exacto; es para creadores o negocios con canal propio que publican al menos dos veces al mes.

## Lo que necesitas antes
- Cuenta de n8n (n8n.cloud plan gratuito de prueba, o auto-alojado con Docker en tu ordenador o un VPS de 5 €/mes).
- Un proyecto en Google Cloud Console (console.cloud.google.com) con **YouTube Data API v3** y **YouTube Analytics API** activadas en «APIs y servicios > Biblioteca».
- Credenciales OAuth 2.0 de tipo «Aplicación web» con la URL de redirección que te muestra n8n al crear la credencial «YouTube OAuth2 API».
- Al autorizar, marca los permisos `youtube.readonly` y `yt-analytics.readonly`.
- Tu Channel ID (lo ves en YouTube Studio > Configuración > Configuración avanzada).
- Una hoja de Google Sheets vacía llamada «Retención» con las columnas: fecha, videoId, titulo, retencion, media_canal, aviso.

## Los nodos, en orden
1. **Schedule Trigger** — modo «Custom (Cron)», expresión `0 8 * * 1`, zona horaria Europe/Madrid en Settings del workflow. Lanza los lunes a las 8:00.
2. **HTTP Request** (renómbralo «Vídeos recientes») — GET a `https://www.googleapis.com/youtube/v3/search`. Authentication: Predefined Credential Type > YouTube OAuth2 API. Query parameters: `part=snippet`, `channelId=TU_CHANNEL_ID`, `order=date`, `type=video`, `maxResults=20`, `publishedAfter={{ $now.minus(30,'days').toISO() }}`.
3. **Code** («Sacar IDs») — deja una fila por vídeo con id y título (código abajo).
4. **HTTP Request** («Retención por vídeo») — GET a `https://youtubeanalytics.googleapis.com/v2/reports`. Misma credencial. Query: `ids=channel==MINE`, `startDate={{ $json.fecha }}`, `endDate={{ $now.toFormat('yyyy-MM-dd') }}`, `metrics=views,averageViewPercentage`, `filters=video=={{ $json.videoId }}`. En Settings del nodo activa **Retry On Fail** (3 intentos, 5000 ms) y **Always Output Data**.
5. **Code** («Comparar con la media») — calcula la media del canal con todos los vídeos de la tanda y marca los que están 15 puntos o más por debajo.
6. **IF** — condición Boolean: `{{ $json.aviso }}` is true.
7. **Google Sheets** (rama true y false) — operación Append, tu hoja «Retención», mapea las columnas.
8. **Telegram** (rama true) — operación Send Message. Texto: `⚠️ Retención baja: {{ $json.titulo }} — {{ $json.retencion }}% frente a {{ $json.media_canal }}% de media. https://youtu.be/{{ $json.videoId }}`.

## El código del nodo «Sacar IDs»
```js
return items.map(i => {
  const s = i.json.snippet;
  return { json: {
    videoId: i.json.id.videoId,
    titulo: s.title,
    fecha: s.publishedAt.slice(0, 10)
  }};
});
```

## El código del nodo «Comparar con la media»
```js
const filas = items.map((i, idx) => {
  const r = i.json.rows && i.json.rows[0] ? i.json.rows[0] : [0, 0];
  const prev = $('Sacar IDs').all()[idx].json;
  return { videoId: prev.videoId, titulo: prev.titulo, views: r[0], retencion: r[1] };
});
const validos = filas.filter(f => f.views >= 100);
const media = validos.length
  ? Math.round(validos.reduce((a, f) => a + f.retencion, 0) / validos.length * 10) / 10
  : 0;
return filas.map(f => ({ json: {
  ...f,
  media_canal: media,
  aviso: f.views >= 100 && f.retencion < media - 15
}}));
```

## Cómo probarla
- Pulsa **Execute Workflow** con el Telegram desconectado (clic derecho > Deactivate) y mira la salida del Code: la retención debe parecerse a la de YouTube Studio > Contenido > columna «Duración media de visualización».
- Baja el umbral de 15 a 1 punto para forzar un aviso y comprobar que llega el mensaje. Luego devuélvelo a 15.
- Activa el workflow solo cuando el resultado cuadre dos semanas seguidas.

## Qué puede salir mal
- **Datos a cero en vídeos muy nuevos**: Analytics tarda hasta 72 h. Por eso el código ignora los vídeos con menos de 100 visualizaciones.
- **Error 403 «insufficient permissions»**: te faltó marcar `yt-analytics.readonly`; borra la credencial en n8n y vuelve a autorizar desde cero.
- **Cuota agotada** (error 403 quotaExceeded): search.list gasta 100 unidades de las 10.000 diarias gratuitas. Con una ejecución semanal no llegas ni de lejos.
- **Horas raras**: si no fijas Europe/Madrid en Settings > Timezone, n8n usa UTC y en verano te llega a las 10:00.

## Cuánto cuesta
Gratis del todo: las dos APIs de YouTube no se pagan (solo tienen cuota diaria), Google Sheets y Telegram son gratis, y n8n auto-alojado también. Si usas n8n Cloud, el plan de pago arranca sobre 20-24 €/mes, pero para este flujo (4 ejecuciones al mes) te sobra con el nivel gratuito o con Docker en casa.
