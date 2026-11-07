# De vídeo a artículo de blog con capturas incrustadas…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Coge un vídeo que ya has publicado, lo transcribe, lo convierte en un artículo de blog estructurado y saca capturas del propio vídeo para ilustrarlo.

## Qué es y qué hace

Descarga un vídeo ya publicado y su transcripción, pide a la IA un artículo con encabezados H2 y, en los puntos que marca, extrae un fotograma con ffmpeg y lo sube como imagen. Entran la URL del vídeo y una palabra clave; sale un borrador en WordPress mediante su API REST. Requiere n8n auto-alojado con ffmpeg y yt-dlp, útil para formadores y tiendas con canal de YouTube.

## Cómo usarla

1. Instala ffmpeg y yt-dlp en el servidor
2. Crea una contraseña de aplicación en WordPress
3. Lanza el webhook con URL y palabra clave
4. Revisa y publica el borrador a mano

## Cuándo usarla

Úsalo cuando tienes vídeos buenos que Google no encuentra y quieres que cada uno trabaje también como artículo, sin volver a escribirlo desde cero.

## Cómo ganar dinero con ella

Un redactor SEO cobra 60-150 € por artículo. Aquí sale por menos de 0,50 € y aprovechas contenido que ya has pagado.

- Conversión de vídeos de formación en artículos de blog para academias y consultoras…
- Reaprovechamiento de contenido para tiendas con canal de YouTube y web propia…
- Redacción SEO a partir de vídeos de clientes, con entrega de borrador revisado…

**Precio orientativo:** 30–80 € por artículo. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Descarga el vídeo y su transcripción, pide a la IA un artículo con encabezados H2, y en los puntos que la IA marca extrae un fotograma con ffmpeg y lo sube como imagen del artículo, dejando el borrador en WordPress. Para formadores, tiendas y negocios de servicios con canal de YouTube.

## Lo que necesitas antes
- n8n **auto-alojado** con ffmpeg y yt-dlp instalados.
- WordPress con la REST API activa y una **contraseña de aplicación**: Usuarios → Perfil → «Contraseñas de aplicación» → genera una y guárdala en la credencial «WordPress» de n8n.
- Clave de OpenAI.
- Una carpeta de trabajo /data/blog.

## Los nodos, en orden
1. **Webhook** — POST con `{"url":"https://youtu.be/...", "keyword":"como hacer X"}`. Lo lanzas desde el móvil cuando quieras. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
2. **Code** (renómbralo «Validar URL») — Mode: Run Once for Each Item. Saca el ID de 11 caracteres de la URL de YouTube y para el flujo si no lo encuentra; el comando usa una URL rehecha con ese ID. Código abajo.
3. **Execute Command** — `yt-dlp -f "bv*[height<=720]+ba/b" -o /data/blog/v.mp4 "https://www.youtube.com/watch?v={{ $json.videoId }}"`.
4. **Execute Command** — extrae el audio: `ffmpeg -y -i /data/blog/v.mp4 -vn -ar 16000 -ac 1 -b:a 32k /data/blog/v.mp3`.
5. **Read/Write Files from Disk** (Read) — carga v.mp3.
6. **OpenAI** (Audio → Transcribe) — whisper-1, idioma es.
7. **AI Agent** — prompt largo: «Convierte esta transcripción en un artículo de blog en español de España, tuteando, de 900-1200 palabras, con un H1, 5 H2, párrafos cortos y la palabra clave {{ keyword }} en el H1, en el primer párrafo y en dos H2. Devuelve JSON: {titulo, meta_descripcion, html, capturas:[{segundo, pie}]} con 3 capturas propuestas en segundos del vídeo donde se vea algo relevante.»
8. **Code** — parsea el JSON, separa las capturas y guarda `videoId` de «Validar URL». Descarta las capturas cuyo `segundo` no sea un entero de 1 a 5 cifras (`/^\d{1,5}$/.test(String(c.segundo))`) y guarda `segundo: Number(c.segundo)` ya convertido, porque ese valor va al comando de ffmpeg.
9. **Split In Batches** — 1 a 1 sobre las capturas.
10. **Execute Command** — `ffmpeg -y -ss {{ $json.segundo }} -i /data/blog/v.mp4 -frames:v 1 -q:v 2 /data/blog/cap_{{ $json.segundo }}.jpg`.
11. **HTTP Request** — antes lee `/data/blog/cap_{{ $('Split In Batches').item.json.segundo }}.jpg` con **Read/Write Files from Disk** (Read), porque Execute Command no devuelve el archivo. Luego POST a https://tuweb.com/wp-json/wp/v2/media con el JPG como binario, autenticación Basic con usuario y contraseña de aplicación. Devuelve el id y la URL de la imagen.
12. **Code** — sustituye en el HTML los marcadores `[CAPTURA_1]` por las etiquetas img reales.
13. **WordPress** (Post → Create) — Status «draft», Title, Content, y en Options el excerpt con la meta descripción. Nunca lo publiques directo.

## El código de «Validar URL»
```js
const url = String($json.body?.url || '');
const m = url.match(/^https:\/\/(?:www\.|m\.)?(?:youtube\.com\/(?:watch\?v=|shorts\/)|youtu\.be\/)([A-Za-z0-9_-]{11})(?:[?&#].*)?$/);
if (!m) throw new Error('URL de YouTube no válida: ' + url.slice(0, 100));
return { json: { videoId: m[1], keyword: $json.body?.keyword || '' } };
```

## El código del nodo 12
```js
const art = $('Code').first().json;
let html = art.html;
const imgs = $input.all();
imgs.forEach((im, i) => {
  const tag = `<figure><img src="${im.json.source_url}" alt="${art.capturas[i].pie}"><figcaption>${art.capturas[i].pie}</figcaption></figure>`;
  html = html.replace(`[CAPTURA_${i+1}]`, tag);
});
html += `<p><iframe width="560" height="315" src="https://www.youtube.com/embed/${art.videoId}" frameborder="0" allowfullscreen></iframe></p>`;
return [{ json: { ...art, html } }];
```

## Cómo probarla
Lanza con un vídeo tuyo corto. Abre el borrador en WordPress y léelo entero: la IA suele inventarse datos concretos (cifras, nombres). Corrige el prompt para que solo use lo que aparece en la transcripción. Comprueba que las capturas no salgan en negro (transiciones).

## Qué puede salir mal
- **Capturas feas**: si el segundo cae en un fundido, sale negro. Pide a la IA segundos «en medio de una explicación» y desplaza +2 segundos en el comando.
- **yt-dlp roto**: YouTube cambia cosas; actualízalo con `pip install -U yt-dlp` de vez en cuando. Descarga solo tus propios vídeos.
- **HTML sucio**: si la IA devuelve markdown en vez de HTML, fuerza en el prompt «solo HTML, sin bloques de código».
- **Publicación accidental**: deja siempre status draft.
- **URL del webhook dentro del comando**: quien conozca el webhook puede mandar cualquier texto y, con un `"` o un `$( )`, ejecutar órdenes; por eso «Validar URL» solo deja pasar el ID de YouTube y el comando usa una URL rehecha con él.
- **`segundo` raro de la IA**: `Number()` acepta `" 12"` o `0x1f`; por eso solo pasan de 1 a 5 cifras y al comando va el número ya convertido.
- **WordPress sin imagen**: Execute Command no devuelve archivos; la captura se lee del disco antes de subirla.

## Cuánto cuesta
VPS 6-10 €/mes. Whisper unos 0,10 € por vídeo de 15 minutos y el artículo unos 0,10-0,30 €. WordPress y n8n autoalojado, gratis (n8n Cloud solo tiene una prueba gratuita temporal y después es de pago).
