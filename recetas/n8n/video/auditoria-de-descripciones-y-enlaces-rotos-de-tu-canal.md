# Auditoría de descripciones y enlaces rotos de tu canal…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Recorre todos tus vídeos publicados, comprueba los enlaces de la descripción y te lista los que están rotos o apuntan a ofertas antiguas.

## Qué es y qué hace

Descarga la descripción de todos tus vídeos de YouTube, extrae cada URL, la comprueba y apunta en una hoja las que devuelven error o van a dominios antiguos. También marca las descripciones sin llamada a la acción. Entrada: canal y lista de dominios caducados; salida: hoja Auditoría con estado HTTP y sugerencia. Se monta en n8n con la API de YouTube, con permisos de solo lectura.

## Cómo usarla

1. Conecta YouTube con permiso de lectura
2. Pon tus dominios antiguos en la lista
3. Ejecuta la auditoría una vez al mes
4. Corrige los enlaces desde la hoja

## Cuándo usarla

Cuando llevas años publicando y tus vídeos viejos siguen trayendo visitas hacia enlaces caídos, promociones cerradas o una web que ya cambiaste.

## Cómo ganar dinero con ella

Recupera tráfico y ventas que ya tenías pagadas: un catálogo de 200 vídeos con enlaces vivos manda visitas a tu web todos los meses, gratis.

- Auditoría de canal para creadores con más de 30 vídeos que llevan tráfico a su web.
- Limpieza de enlaces para academias tras cambiar de dominio o cerrar ofertas.
- Revisión trimestral de descripciones para marcas con catálogo de vídeos de producto.

**Precio orientativo:** 50–150 € por auditoría. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Una vez al mes descarga la descripción de todos tus vídeos, extrae cada URL, la comprueba una a una y apunta en una hoja las que devuelven error o pertenecen a dominios que ya no usas. Además marca las descripciones sin ninguna llamada a la acción. Es para canales con catálogo (más de 30 vídeos) y negocios que llevan tráfico a su web.

## Lo que necesitas antes
- n8n con credencial «YouTube OAuth2 API» (permisos `youtube.readonly` y, si quieres corregir en masa, `youtube.force-ssl`).
- Tu Channel ID y tu playlist de subidas: es tu Channel ID cambiando `UC` por `UU` al principio (si tu canal es `UCabc123`, la playlist es `UUabc123`).
- Hoja «Auditoría» con columnas: videoId, titulo, url, estado_http, problema, sugerencia, corregir.
- Una lista de dominios caducados o antiguos tuyos (tu web vieja, un enlace de afiliado que ya no usas, un curso cerrado).

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 6 1 * *`, el día 1 de cada mes a las 6:00.
2. **HTTP Request** («Todos mis vídeos») — GET `https://www.googleapis.com/youtube/v3/playlistItems` con `part=snippet`, `playlistId=UUtuid`, `maxResults=50`, credencial YouTube OAuth2. En Options activa **Pagination**: Response Contains Next Page, `pageToken` = `{{ $response.body.nextPageToken }}`, Complete Expression `{{ !$response.body.nextPageToken }}`.
3. **Code** («Sacar enlaces») — extrae las URLs de cada descripción, una fila por enlace.
4. **Split In Batches** — Batch Size 1.
5. **HTTP Request** («Comprobar enlace») — método GET a `{{ $json.url }}`, en Options: **Redirect > Follow Redirects** activado, **Timeout** 10000 ms, **Response > Never Error** activado y Full Response activado, y en Headers `User-Agent: Mozilla/5.0`. Activa Continue On Fail.
6. **Code** («Diagnóstico») — clasifica según el código de estado y los dominios viejos.
7. **IF** — `{{ $json.problema }}` is not empty.
8. **Google Sheets** — Append a «Auditoría».
9. **Wait** — 1 segundo, y de vuelta al Split In Batches.
10. **Gmail** — al terminar, resumen: `{{ $json.total }} enlaces revisados, {{ $json.rotos }} con problema. Revisa la hoja.`

## El código de «Sacar enlaces»
```js
const VIEJOS = ['mi-web-antigua.com', 'promo2021', 'bit.ly/curso-cerrado'];
const out = [];
for (const it of items) {
  const s = it.json.snippet;
  if (!s) continue;
  const desc = s.description || '';
  const urls = [...new Set((desc.match(/https?:\/\/[^\s)\]]+/g) || []))];
  const vid = s.resourceId?.videoId;
  if (!urls.length) {
    out.push({ json: { videoId: vid, titulo: s.title, url: '', problema: 'Descripción sin ningún enlace' } });
    continue;
  }
  for (const u of urls) {
    out.push({ json: {
      videoId: vid,
      titulo: s.title,
      url: u.replace(/[.,;]$/, ''),
      viejo: VIEJOS.some(v => u.includes(v))
    }});
  }
}
return out;
```

## El código de «Diagnóstico»
```js
const prev = $('Split In Batches').first().json;
const code = items[0].json.statusCode || 0;
let problema = '';
if (prev.viejo) problema = 'Dominio o promoción antigua';
else if (code === 0) problema = 'No responde (timeout o dominio caído)';
else if (code >= 400) problema = 'Error HTTP ' + code;
return [{ json: {
  videoId: prev.videoId,
  titulo: prev.titulo,
  url: prev.url,
  estado_http: code,
  problema,
  sugerencia: problema ? 'Sustituir por tu enlace actual' : '',
  corregir: ''
}}];
```

## Cómo probarla
- Mete a mano en la descripción de un vídeo oculto un enlace roto tipo `https://ejemplo-que-no-existe-123.com` y comprueba que sale marcado.
- Revisa la cifra total de vídeos: si te salen exactamente 50, la paginación del paso 2 no está bien configurada.
- Antes de corregir nada, ordena la hoja por «problema» y decide a mano; hay dominios que devuelven 403 a los bots aunque funcionen (Amazon, LinkedIn), y no están rotos de verdad.

## Qué puede salir mal
- **Falsos rotos**: muchas webs bloquean peticiones automáticas y devuelven 403 o 999. Por eso se manda el User-Agent de navegador; aun así, comprueba a mano cualquier 403 antes de tocar el vídeo.
- **Acortadores**: bit.ly con enlace caducado responde 404 o redirige a su home; míralos uno a uno.
- **Tardanza**: con 300 vídeos y 3 enlaces cada uno son 900 comprobaciones con espera de 1 segundo, unos 20 minutos de ejecución. Normal, déjalo corriendo de madrugada.
- **Cuota**: playlistItems gasta 1 unidad por página; ni te acercas al límite.
- **Si además quieres corregir en masa**: añade una columna `corregir` en la hoja, pon a mano la URL nueva y monta un segundo flujo con `videos.list` + `videos.update` que sustituya la cadena en la descripción, reenviando siempre title, categoryId y tags (si no, los borras). Hazlo primero con un solo vídeo.

## Cuánto cuesta
Gratis: la API de YouTube no cobra, Sheets y Gmail tampoco, y las comprobaciones HTTP son peticiones normales. Si usas n8n Cloud, ojo: cada comprobación puede contar como ejecución según el plan; para esto compensa el auto-alojado.
