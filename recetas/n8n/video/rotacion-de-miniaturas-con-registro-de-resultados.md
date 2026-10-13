# Rotación de miniaturas con registro de resultados…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Cambia sola la miniatura de un vídeo cada siete días entre dos versiones y apunta las impresiones y el CTR de cada tanda para que compares con datos.

## Qué es y qué hace

Cada semana cambia la miniatura de un vídeo entre dos versiones mediante la API de YouTube y guarda en una hoja las impresiones, el CTR y las visitas de cada tanda. Entrada: dos imágenes 1280x720 por vídeo en Drive y la hoja Miniaturas; salida: registro comparativo tras cuatro semanas. Se monta en n8n. Requiere canal verificado y acceso a los datos de Analytics.

## Cómo usarla

1. Crea las dos miniaturas por vídeo con nombres VIDEOID_A y VIDEOID_B
2. Conecta YouTube y Drive
3. Activa el ciclo semanal
4. Compara el CTR al cabo de cuatro semanas

## Cuándo usarla

Cuando tienes vídeos con buen contenido y pocas visitas y quieres saber si es la miniatura, en vez de decidir a ojo o por gusto personal.

## Cómo ganar dinero con ella

Una miniatura mejor sube el CTR de un 3 % a un 6 %: duplica las visitas del mismo vídeo sin volver a grabar ni pagar publicidad.

- Test de miniaturas para canales con muchas impresiones que quieren subir el CTR con datos.
- Servicio de optimización de miniaturas: dos variantes y un informe mensual por canal.
- Plantilla de experimento para marcas que publican vídeos de producto.

**Precio orientativo:** 50–150 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada domingo cambia la miniatura del vídeo en pruebas por la otra versión y guarda en una hoja las impresiones, el CTR y las visitas de la semana que acaba. Al cabo de cuatro semanas tienes dos tandas de cada miniatura y sabes cuál gana. Es para canales que ya tienen suficientes impresiones (a partir de unas 2.000 semanales por vídeo).

## Lo que necesitas antes
- n8n con credencial «YouTube OAuth2 API», permisos `youtube.force-ssl` y `yt-analytics.readonly`.
- Credencial «Google Drive OAuth2 API».
- Dos imágenes 1280x720 JPG (menos de 2 MB) por vídeo, en una carpeta de Drive, nombradas `VIDEOID_A.jpg` y `VIDEOID_B.jpg`.
- Cuenta de YouTube verificada (sin verificar no puedes subir miniaturas personalizadas).
- Hoja «Miniaturas» con columnas: videoId, titulo, version_activa, fileId_A, fileId_B, semana, impresiones, ctr, visitas.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 20 * * 0`, domingos a las 20:00, Europe/Madrid.
2. **Google Sheets** — Get Row(s) de «Miniaturas» (una fila por vídeo en prueba, máximo 3 o 4 a la vez).
3. **HTTP Request** («Resultados de la semana») — GET `https://youtubeanalytics.googleapis.com/v2/reports`, credencial YouTube OAuth2. Query: `ids=channel==MINE`, `startDate={{ $now.minus(7,'days').toFormat('yyyy-MM-dd') }}`, `endDate={{ $now.toFormat('yyyy-MM-dd') }}`, `metrics=views,impressions,impressionClickThroughRate`, `filters=video=={{ $json.videoId }}`. Activa **Continue On Fail**.
4. **Google Sheets** — Append a «Miniaturas» (una fila de histórico con la versión que estaba activa y sus números).
5. **Code** («Cambiar de versión») — decide cuál toca ahora.
6. **Google Drive** — operación Download, File ID `{{ $json.fileIdSiguiente }}`.
7. **HTTP Request** («Subir miniatura») — POST a `https://www.googleapis.com/upload/youtube/v3/thumbnails/set?videoId={{ $json.videoId }}`, credencial YouTube OAuth2, Body Content Type «n8n Binary File», campo `data`, y en Headers `Content-Type: image/jpeg`.
8. **Google Sheets** — Update de la fila principal: version_activa = la nueva.

## El código de «Cambiar de versión»
```js
return items.map(i => {
  const f = $('Google Sheets').all().find(r => r.json.videoId === i.json.videoId)?.json || i.json;
  const actual = (f.version_activa || 'A').toUpperCase();
  const siguiente = actual === 'A' ? 'B' : 'A';
  const r = i.json.rows && i.json.rows[0] ? i.json.rows[0] : [0, 0, 0];
  return { json: {
    videoId: f.videoId,
    titulo: f.titulo,
    semana: new Date().toISOString().slice(0, 10),
    version_medida: actual,
    visitas: r[0],
    impresiones: r[1],
    ctr: r[2],
    version_activa: siguiente,
    fileIdSiguiente: siguiente === 'A' ? f.fileId_A : f.fileId_B
  }};
});
```

## Cómo probarla
- Ejecuta el flujo a mano un martes cualquiera con un solo vídeo: entra en YouTube y comprueba que la miniatura ha cambiado (tarda unos minutos en refrescarse en el buscador).
- Mira la hoja: si impresiones y ctr salen vacíos, tu canal aún no expone esas métricas por API; en ese caso quédate solo con `views` y compara visitas semanales.
- No toques nada más del vídeo esa semana (ni título ni descripción) o el experimento no vale.

## Qué puede salir mal
- **Error 403 uploadLimitExceeded**: hay un tope diario de subidas de miniatura por canal; no pongas más de 4 vídeos en prueba.
- **La imagen pesa más de 2 MB**: exporta a JPG calidad 80 en 1280x720.
- **Semanas no comparables**: si el vídeo sale en Home un día concreto, la tanda se contamina. Por eso se hacen cuatro semanas (A, B, A, B) y se comparan las medias, no una sola semana.
- **Miniatura cacheada**: la vista previa antigua puede seguir un rato; no rehagas la subida por eso.
- **Analytics con retraso**: mide siempre la semana ya cerrada, nunca los últimos dos días.

## Cuánto cuesta
Gratis: subir una miniatura gasta 50 unidades de cuota de 10.000 diarias, Analytics no cobra y Drive y Sheets tampoco. Solo pagarías el diseño de las miniaturas si lo encargas fuera.
