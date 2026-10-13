# Publicar el mismo vertical en TikTok, Reels y Shorts…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Dejas un vídeo vertical en una carpeta de Drive con el pie de foto en el nombre del archivo y se publica solo en TikTok, Instagram Reels y YouTube Shorts.

## Qué es y qué hace

Es una automatización de n8n que detecta un vídeo vertical nuevo en una carpeta de Drive y lo publica en TikTok, Instagram Reels y YouTube Shorts mediante sus APIs oficiales, tomando el pie de foto del nombre del archivo. Entra un vídeo vertical y sale la publicación en las tres redes. Requiere apps aprobadas en TikTok y Meta con permisos de publicación, y credenciales de Drive y YouTube.

## Cómo usarla

1. Crea las apps en TikTok y Meta y pide los permisos
2. Conecta Drive y YouTube
3. Prueba en modo privado
4. Activa la publicación en las cuentas reales

## Cuándo usarla

Úsalo cuando publiques verticales a diario en tres redes y estés perdiendo 20 minutos subiendo el mismo archivo tres veces desde el móvil.

## Cómo ganar dinero con ella

Ahorra 15-20 min por pieza; con 20 piezas al mes son 6 horas recuperadas, y publicas en las tres redes aunque ese día no te dé la vida.

- Publicación multired para negocios que suben verticales cada día.
- Programación de contenido para creadores que delegan la subida a un editor.
- Gestión de redes verticales como servicio mensual con informe de publicaciones.

**Precio orientativo:** 150–400 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Detecta un vídeo nuevo en una carpeta, lo hace accesible por enlace, y lo envía a las tres plataformas usando sus APIs oficiales: TikTok por URL, Instagram por contenedor de Reels y YouTube por subida directa.
Para negocios y creadores que hacen contenido vertical de forma constante.

## Lo que necesitas antes
- n8n (mejor auto-alojado, así puedes servir el archivo si hace falta).
- Credenciales Google Drive OAuth2 y YouTube OAuth2.
- **TikTok**: cuenta en developers.tiktok.com, una app con el producto *Content Posting API* aprobado y el permiso `video.publish`. Ojo: hasta que TikTok apruebe la app, solo puedes publicar en modo privado y en cuentas de prueba.
- **Instagram**: cuenta profesional vinculada a una página de Facebook, app en developers.facebook.com con *Instagram Graph API*, permisos `instagram_content_publish` y `pages_read_engagement`, y un token de larga duración con el `ig_user_id`.
- Carpeta de Drive `Verticales` y hoja `Publicaciones` para el registro.

## Los nodos, en orden
1. **Google Drive Trigger** — Event `File Created`, carpeta `Verticales`.
2. **Code** (sacar el texto del nombre del archivo, formato `20260908_Como-ahorrar-en-la-luz.mp4`):
```javascript
const nombre = $json.name.replace(/\.mp4$/i, '');
const partes = nombre.split('_');
const titulo = (partes[1] || nombre).replace(/-/g, ' ');
return [{ json: { id: $json.id, titulo, pie: `${titulo} #ahorro #hogar` } }];
```
3. **Google Drive** (Share File) — File: `{{ $json.id }}`, Permissions: Role `reader`, Type `anyone`. Así consigues una URL pública temporal.
4. **Code** (URL de descarga directa):
```javascript
return [{ json: { ...$json, url: `https://drive.google.com/uc?export=download&id=${$json.id}` } }];
```
5. **HTTP Request** (TikTok) — POST `https://open.tiktokapis.com/v2/post/publish/video/init/`, Header Auth `Authorization: Bearer TU_TOKEN`, Body JSON:
```json
{"post_info":{"title":"={{ $json.pie }}","privacy_level":"SELF_ONLY","disable_comment":false},"source_info":{"source":"PULL_FROM_URL","video_url":"={{ $json.url }}"}}
```
Cuando esté todo probado, cambia `SELF_ONLY` por `PUBLIC_TO_EVERYONE`.
6. **HTTP Request** (Instagram, crear contenedor) — POST `https://graph.facebook.com/v21.0/{IG_USER_ID}/media` con Query: `media_type` = `REELS`, `video_url` = `{{ $json.url }}`, `caption` = `{{ $json.pie }}`, `access_token` = tu token.
7. **Wait** — 60 segundos (Instagram necesita procesar el vídeo).
8. **HTTP Request** (Instagram, publicar) — POST `https://graph.facebook.com/v21.0/{IG_USER_ID}/media_publish` con `creation_id` = `{{ $('HTTP Request1').item.json.id }}` y el token.
9. **Google Drive** (Download File) + **YouTube** (Upload) — Title `{{ $json.titulo }}`, Options → Description con el pie y `#Shorts`, Privacy `public`. Un vídeo vertical de menos de 3 minutos entra solo como Short.
10. **Google Drive** (Share File) — vuelve a poner el permiso restringido: Operation `Share`, Permissions → borra el acceso público. Alternativa: mueve el archivo a una carpeta `Publicados` no compartida.
11. **Google Sheets** (Append Row) — registra qué red aceptó y qué red falló.

## Cómo probarla
- Publica primero en privado en las tres (`SELF_ONLY` en TikTok, `unlisted` en YouTube; en Instagram publica y borra a mano).
- Comprueba que el vídeo cumple los requisitos: 9:16, entre 3 y 60 segundos para ir sobre seguro, mp4 con códec H.264 y audio AAC.

## Qué puede salir mal
- **El enlace de Drive**: para archivos grandes Google mete una pantalla de aviso de antivirus y la API externa recibe HTML en vez del vídeo. Si te pasa, sube el archivo a un bucket (Cloudflare R2 tiene plan gratis) y usa esa URL.
- **Aprobación de TikTok**: sin la revisión de la app, solo publicarás en privado. Es la parte más lenta de montar esto: pídela con tiempo.
- **Token de Instagram caducado**: los de larga duración duran 60 días. Monta un flujo mensual que llame a `oauth/access_token?grant_type=fb_exchange_token` y guarde el nuevo.
- **Cuota de YouTube**: 6 subidas al día con la cuota gratuita.
- **Publicación doble**: si el trigger se repite, la hoja de registro con un **IF** previo lo corta.

## Cuánto cuesta
- Todas las APIs son gratis; el gasto es de tiempo de configuración (cuenta 2-3 horas la primera vez, sobre todo Meta).
- n8n auto-alojado: 0 €, más el VPS si lo necesitas.
