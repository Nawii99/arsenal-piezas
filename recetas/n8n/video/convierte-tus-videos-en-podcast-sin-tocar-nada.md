# Convierte tus vídeos en podcast sin tocar nada…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Cada vídeo nuevo se convierte en MP3 con las etiquetas puestas, se guarda en Drive y se actualiza el feed RSS para que salga en Spotify y Apple Podcasts.

## Qué es y qué hace

Cada vídeo nuevo se convierte en MP3 con bitrate de voz y etiquetas, se sube a un almacenamiento público, se añade a una hoja de episodios y se regenera el RSS que leen Spotify, Apple Podcasts e iVoox. Entran el vídeo de Drive y tu hosting con URL pública; sale el audio y el feed actualizado. Pensado para creadores de vídeo largo que quieren un canal de audio.

## Cómo usarla

1. Crea un token de CloudConvert con task.read y task.write
2. Prepara un bucket público en Cloudflare R2
3. Sube la portada 3000x3000
4. Crea la hoja Episodios y prueba el feed con un episodio

## Cuándo usarla

Cuando ya grabas vídeo largo o entrevistas y estás dejando escapar toda la audiencia que consume en audio mientras conduce o entrena.

## Cómo ganar dinero con ella

Un canal de audio nuevo con cero horas extra de producción. Externalizar esta conversión y publicación cuesta 30-60 € al mes.

- Publicación de podcast a partir de vídeos de empresas o formadores, con feed gestionado…
- Conversión de entrevistas en vídeo a podcast para creadores…
- Mantenimiento mensual del feed para negocios con presencia en audio…

**Precio orientativo:** 50–150 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Detecta el vídeo nuevo, lo convierte a MP3 con bitrate de voz, lo sube a un almacenamiento público, añade la fila al catálogo en Sheets y regenera el archivo RSS del podcast que leen Spotify, Apple Podcasts y iVoox. Para creadores de vídeo largo, entrevistadores y formadores que quieren un canal de audio sin trabajo extra.

## Lo que necesitas antes
- n8n.
- Carpeta de Drive `VIDEOS-PODCAST`.
- Cuenta gratuita de CloudConvert con token de API (permisos `task.read` y `task.write`).
- Un sitio público donde alojar los MP3 y el RSS. Lo más barato: **Cloudflare R2** (10 GB gratis) con un bucket público, o cualquier hosting con FTP. Necesitas la URL pública base, por ejemplo `https://podcast.tudominio.com/`.
- Una portada cuadrada de 3000x3000 px subida a ese mismo sitio (Apple lo exige).
- Hoja `Episodios` con columnas: `numero`, `titulo`, `descripcion`, `fecha`, `duracion_seg`, `tamano_bytes`, `url_mp3`.

## Los nodos, en orden
1. **Google Drive Trigger** — File Created en `VIDEOS-PODCAST`, cada 15 minutos.
2. **Google Drive** — `Share` con Role `reader`, Type `anyone`, para que CloudConvert pueda descargarlo.
3. **HTTP Request** — POST a `https://api.cloudconvert.com/v2/jobs` con Header `Authorization: Bearer TU_TOKEN`. Body: tareas `import/url` (la URL de descarga de Drive), `convert` a `mp3` con `audio_bitrate` 96 y `audio_codec` `mp3`, y `export/url`.
4. **Wait** — 120 segundos.
5. **HTTP Request1** — GET del job para recoger la URL y los metadatos (tamaño y duración vienen en el resultado de la tarea de conversión).
6. **HTTP Request2** — GET de esa URL con Response Format `File` para tener el MP3 como binario.
7. **HTTP Request3** (subir a R2) — Method: PUT. URL: `https://TU_ENDPOINT_R2/podcast/{{ $json.nombre_archivo }}`. Authentication: Generic → según la configuración de tu bucket (con R2 lo más simple es un token de API en cabecera o una URL prefirmada). Body: Binary File, campo `data`. Content-Type: `audio/mpeg`.
8. **Google Sheets** — Append con todos los datos del episodio.
9. **Google Sheets1** — `Read` de todas las filas, ordenadas por número descendente.
10. **Code** — Genera el XML completo del feed RSS con todos los episodios (ver código).
11. **HTTP Request4** — PUT del XML a `https://TU_ENDPOINT_R2/podcast/feed.xml` con Content-Type `application/rss+xml`.
12. **Google Drive1** — Quita el permiso público del vídeo original con `Delete Permission`.
13. **Gmail** — Aviso de que el episodio está publicado.

## El código del nodo Code (paso 10)
```javascript
const base = 'https://podcast.tudominio.com/';
const filas = $input.all().map(i => i.json).filter(f => f.url_mp3);
const esc = (t) => String(t || '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
const NL = String.fromCharCode(10);
let items = '';
filas.forEach(f => {
  items += '<item>' + NL;
  items += '<title>' + esc(f.titulo) + '</title>' + NL;
  items += '<description><![CDATA[' + (f.descripcion || '') + ']]></description>' + NL;
  items += '<pubDate>' + new Date(f.fecha).toUTCString() + '</pubDate>' + NL;
  items += '<guid isPermaLink="false">' + esc(f.url_mp3) + '</guid>' + NL;
  items += '<enclosure url="' + esc(f.url_mp3) + '" length="' + (f.tamano_bytes || 0) + '" type="audio/mpeg"/>' + NL;
  items += '<itunes:duration>' + (f.duracion_seg || 0) + '</itunes:duration>' + NL;
  items += '</item>' + NL;
});
const xml = '<?xml version="1.0" encoding="UTF-8"?>' + NL +
'<rss version="2.0" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd">' + NL +
'<channel>' + NL +
'<title>El podcast de TU MARCA</title>' + NL +
'<link>' + base + '</link>' + NL +
'<language>es-es</language>' + NL +
'<description>Descripción de tu podcast en dos frases.</description>' + NL +
'<itunes:author>Tu Nombre</itunes:author>' + NL +
'<itunes:explicit>false</itunes:explicit>' + NL +
'<itunes:category text="Business"/>' + NL +
'<itunes:image href="' + base + 'portada.jpg"/>' + NL +
items + '</channel></rss>';
return { json: { xml } };
```

## Cómo probarla
1. Antes de dar de alta el podcast en ningún sitio, abre `feed.xml` en el navegador: no debe dar error de XML.
2. Pásalo por el validador gratuito `podba.se/validate` o `castfeedvalidator.com`.
3. Suscríbete a tu propio feed desde una app tipo Pocket Casts introduciendo la URL a mano. Si se ve bien ahí, se verá bien en todas.
4. Solo entonces da de alta el feed en Spotify for Podcasters y Apple Podcasts Connect.

## Qué puede salir mal
- **Apple rechaza el feed** si falta la portada de 3000x3000, la categoría o el `explicit`. Todo eso está en el código, no lo quites.
- **El `guid` debe ser único y estable**: si cambias la URL de un MP3, las apps duplican el episodio.
- **Tamaño en bytes obligatorio** en el `enclosure`: si lo dejas en 0, algunas apps no reproducen. Sácalo de la respuesta de CloudConvert.
- **Fechas mal formadas**: `toUTCString()` da el formato RFC 822 que exige el RSS. No lo cambies por otro.
- **Los 25 conversiones diarias gratis de CloudConvert** llegan de sobra para un podcast semanal.
- **Cloudflare R2 cobra por egreso cero**, pero si usas otro hosting revisa el coste de tráfico: un podcast que crece es mucho ancho de banda.

## Cuánto cuesta
CloudConvert gratis hasta 25 conversiones al día. Cloudflare R2: 10 GB de almacenamiento gratis y salida de datos sin coste (unos 300 episodios de 1 hora). Dar de alta el podcast en Spotify y Apple es gratis. Total realista: 0 €/mes hasta que crezcas mucho.
