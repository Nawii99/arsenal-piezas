# Un Short publicado a la vez en TikTok, Reels y YouTube…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Subes el vídeo vertical y su texto a Drive y el flujo lo publica en TikTok, Instagram Reels y YouTube Shorts, adaptando el título y los hashtags a cada red.

## Qué es y qué hace

Detecta un vídeo vertical nuevo en Drive junto a un archivo de texto con el mismo nombre que contiene título, descripción y hashtags, y lo publica en TikTok, Instagram Reels y YouTube Shorts con el formato de cada red. Entran el vídeo, el .txt y los tokens de cada plataforma; salen tres publicaciones. Para creadores y negocios que producen vídeo corto de forma constante.

## Cómo usarla

1. Crea apps de desarrollador en TikTok, Meta y Google
2. Obtén tokens con permiso de publicación
3. Organiza los pares vídeo y txt en Drive
4. Publica una pieza de prueba en cada red

## Cuándo usarla

Cuando haces vídeo vertical y publicas a mano en tres apps distintas, o cuando quieres mantener presencia en las tres sin triplicar el trabajo.

## Cómo ganar dinero con ella

Publicar en tres redes a mano son 20-25 minutos por pieza. Con 12 piezas al mes, 4-5 horas recuperadas cada mes.

- Publicación multired de vídeos cortos para tiendas y negocios locales cada semana…
- Gestión de Shorts para creadores con calendario y textos por plataforma…
- Configuración de publicación automática para agencias con varias cuentas de cliente…

**Precio orientativo:** 100–300 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Detecta un vídeo vertical nuevo en Drive junto a un archivo de texto con el mismo nombre que contiene el copy, y lo publica en las tres redes con el formato de cada una. Para creadores, negocios locales y ecommerce que producen vídeo corto de forma constante.

## Lo que necesitas antes
- n8n.
- Carpeta de Drive `SHORTS-A-PUBLICAR`. Por cada pieza, dos archivos con el mismo nombre: `pieza-01.mp4` y `pieza-01.txt` (el txt con tres líneas: título, descripción, hashtags separados por comas).
- **TikTok**: cuenta de developers.tiktok.com, crear una app, pedir el producto «Content Posting API» y obtener un access token con el scope `video.publish`. Ojo: TikTok exige revisión de la app, tarda unos días.
- **Instagram**: cuenta de Instagram profesional vinculada a una página de Facebook, app en developers.facebook.com con «Instagram Graph API», token de larga duración y el `ig_user_id`.
- **YouTube**: credencial de Google OAuth con YouTube Data API v3.

## Los nodos, en orden
1. **Google Drive Trigger** — File Created en `SHORTS-A-PUBLICAR`, cada 15 minutos.
2. **IF** — Solo sigue si `{{ $json.name }}` termina en `.mp4`. El `.txt` se lee después, no dispara nada.
3. **Google Drive** — Operation: `Search`. Query String: el mismo nombre pero con `.txt`, dentro de la carpeta. Así encuentras el copy.
4. **Google Drive1** — `Download` del `.txt`. Output Binary Field: `data`.
5. **Extract From File** — Operation: `Text File`. Binary Property: `data`, Destination Key: `copy`.
6. **Code** — Parte el texto en título, descripción y hashtags y arma la versión de cada red.
7. **Google Drive2** — Operation: `Share` sobre el MP4, Role `reader`, Type `anyone`. Necesitas URL pública porque TikTok e Instagram descargan el vídeo ellos.
8. **HTTP Request** (TikTok) — POST a `https://open.tiktokapis.com/v2/post/publish/video/init/`. Header `Authorization: Bearer TU_TOKEN`. Body JSON: `{"post_info":{"title":"{{ $json.tiktok }}","privacy_level":"SELF_ONLY"},"source_info":{"source":"PULL_FROM_URL","video_url":"{{ $json.url_publica }}"}}`. Empieza con `SELF_ONLY` (solo tú) hasta que confíes; luego cámbialo a `PUBLIC_TO_EVERYONE`.
9. **HTTP Request1** (Instagram, crear contenedor) — POST a `https://graph.facebook.com/v21.0/{{ $json.ig_user_id }}/media` con query `media_type` = `REELS`, `video_url` = `{{ $json.url_publica }}`, `caption` = `{{ $json.instagram }}`, `access_token` = tu token.
10. **Wait** — 60 segundos. Instagram necesita procesar el vídeo antes de publicarlo.
11. **HTTP Request2** (Instagram, publicar) — POST a `https://graph.facebook.com/v21.0/{{ ig_user_id }}/media_publish` con `creation_id` = `{{ $('HTTP Request1').item.json.id }}`.
12. **Google Drive3** — `Download` del MP4 para tenerlo como binario.
13. **YouTube** — `Video: Upload`. Title: `{{ $('Code').item.json.youtube }}`. Privacy Status: `private` al principio. Tags desde el Code.
14. **Google Drive4** — `Move` del MP4 y del TXT a la carpeta `PUBLICADOS`, y quita el permiso público con Operation `Delete Permission`.
15. **Gmail** — Resumen con los tres enlaces.

## El código del nodo Code (paso 6)
```javascript
const bruto = $json.copy || '';
const lineas = bruto.split(String.fromCharCode(10)).map(l => l.trim()).filter(Boolean);
const titulo = (lineas[0] || 'Sin título').slice(0, 90);
const descripcion = lineas[1] || titulo;
const tags = (lineas[2] || '').split(',').map(t => t.trim().replace('#','')).filter(Boolean);
const hashtags = tags.map(t => '#' + t).join(' ');
const archivo = $('Google Drive Trigger').first().json;
return { json: {
  tiktok: (titulo + ' ' + hashtags).slice(0, 150),
  instagram: (descripcion + String.fromCharCode(10) + String.fromCharCode(10) + hashtags).slice(0, 2200),
  youtube: (titulo + ' #Shorts').slice(0, 100),
  tags,
  ig_user_id: 'TU_IG_USER_ID',
  url_publica: 'https://drive.google.com/uc?export=download&id=' + archivo.id
}};
```

## Cómo probarla
1. Prueba red por red: desconecta dos ramas y deja solo una activa.
2. Publica primero en privado en las tres (`SELF_ONLY`, borrador, `private`) y comprueba formato, encuadre y que no se corta el texto.
3. Verifica que el vídeo es vertical 9:16, menos de 60 segundos y menos de 100 MB antes de dar por bueno el flujo.

## Qué puede salir mal
- **La revisión de la app de TikTok** es el cuello de botella: sin aprobar, la API solo publica en modo privado en tu propia cuenta.
- **Instagram exige URL pública accesible sin login**: el enlace `uc?export=download` de Drive a veces devuelve una página intermedia con vídeos grandes. Si falla, guarda el vídeo en un bucket público (Cloudflare R2, capa gratuita) en vez de en Drive.
- **El Wait de 60 segundos puede quedarse corto**: sustitúyelo por un bucle que consulte `https://graph.facebook.com/v21.0/{creation_id}?fields=status_code` hasta que devuelva `FINISHED`.
- **Tokens caducados**: el de Instagram dura 60 días y hay que renovarlo. Monta un flujo aparte mensual que llame al endpoint de refresco.
- **Vídeo público olvidado en Drive**: el paso 14 quita el permiso, no lo elimines.

## Cuánto cuesta
Gratis: las tres APIs no cobran por publicar. n8n y Drive, también. Si mueves los vídeos a Cloudflare R2, su capa gratuita cubre 10 GB. El único gasto realista es pasar a n8n de pago si superas las ejecuciones.
