# Devlog: una publicación, cinco redes…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Dejas un texto y una imagen o clip en una carpeta y lo publica solo en X, Bluesky, Discord y Reddit con el formato de cada sitio.

## Qué es y qué hace

Flujo de n8n que vigila una carpeta de Google Drive. Cuando aparece una imagen o un vídeo junto a un archivo de texto con el mismo nombre, adapta el texto al límite de cada red y lo publica en Bluesky, Discord, Reddit y X, y después mueve el archivo a la carpeta de publicados. Entran el archivo multimedia y el texto; sale una publicación en cada red. Requiere cuentas de desarrollador en Bluesky, Reddit y X.

## Cómo usarla

1. 1. Crea las credenciales de Bluesky, Reddit y X
2. 2. Conecta Drive y el webhook de Discord
3. 3. Prueba con una imagen antes de dejarlo en automático

## Cuándo usarla

Úsalo cuando publicas avances del juego varias veces por semana y pierdes media hora recortando textos y subiendo el mismo GIF a cuatro sitios distintos.

## Cómo ganar dinero con ella

Ahorra 30-40 minutos por publicación. Con tres devlogs a la semana son unas 8 horas al mes y publicas aunque estés a tope de trabajo.

- Publicación automática de devlogs para estudios indie que avanzan en público y no tienen community manager.
- Distribución de avances en varias redes para desarrolladores solitarios que publican tres veces por semana.
- Configuración de publicación en redes para estudios que quieren mantener comunidad sin dedicar horas.

**Precio orientativo:** 150–300 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una carpeta de Drive llamada «devlog_pendientes». Cuando dejas ahí una imagen o vídeo junto a un archivo de texto con el mismo nombre, coge el texto, lo adapta al límite de cada red y publica en Bluesky, Discord, Reddit y X, y luego mueve el archivo a «devlog_publicados» para no repetir.
Para desarrolladores solitarios que saben que tienen que publicar avances pero odian el trámite.

## Lo que necesitas antes
- n8n (nube o auto-alojado).
- Credencial de Google Drive.
- **Bluesky**: tu handle y una «App Password» que se crea en Ajustes → Privacidad y seguridad → Contraseñas de aplicación. La API es gratis.
- **Discord**: webhook del canal #devlog.
- **Reddit**: crea una app en reddit.com/prefs/apps tipo «script», te da client id y secret. n8n trae nodo Reddit con OAuth2.
- **X**: cuenta de desarrollador en developer.x.com. El plan gratuito permite unas 500 publicaciones al mes; si te parece un lío, deja X fuera y publica solo en las otras tres.

## Los nodos, en orden
1. **Google Drive Trigger** — «File Created» en la carpeta «devlog_pendientes», cada 5 minutos.
2. **IF** — Solo sigue si el archivo es imagen o vídeo (`image/` o `video/` en `mimeType`).
3. **Google Drive** («Search Files/Folders») — Busca en la misma carpeta el `.txt` con el mismo nombre base.
4. **Google Drive** («Download File») x2 — Uno para el media, otro para el texto.
5. **Extract from File** («Text») — Convierte el .txt en texto plano en el campo `data`.
6. **Code** — Trocea el texto para cada red (código abajo).
7. **HTTP Request** «Bluesky login» — POST a `https://bsky.social/xrpc/com.atproto.server.createSession` con `{ "identifier": "tuhandle.bsky.social", "password": "tu-app-password" }`.
8. **HTTP Request** «Bluesky subir imagen» — POST a `com.atproto.repo.uploadBlob` con el binario y cabecera `Authorization: Bearer {{ $json.accessJwt }}`.
9. **HTTP Request** «Bluesky publicar» — POST a `com.atproto.repo.createRecord` con el texto de 300 caracteres y el blob adjunto.
10. **Discord** — Mensaje con el texto largo entero y el archivo adjunto.
11. **Reddit** («Create a post») — Subreddit `r/IndieDev` o `r/gamedev`, título de la primera línea del .txt, cuerpo el resto.
12. **Google Drive** («Move File») x2 — Mueve media y .txt a «devlog_publicados».

## El nodo Code
```javascript
const texto = $('Extract from File').first().json.data.trim();
const lineas = texto.split('\n').filter(Boolean);
const titulo = lineas[0];
const cuerpo = lineas.slice(1).join('\n');
const hashtags = '#indiedev #gamedev #screenshotsaturday';
const corta = (s, n) => s.length <= n ? s : s.slice(0, n - 1).trimEnd() + '…';
return [{ json: {
  titulo,
  cuerpo,
  bluesky: corta(titulo + '\n\n' + cuerpo, 300 - hashtags.length - 2) + '\n' + hashtags,
  x: corta(titulo + ' ' + cuerpo, 275) + ' ' + hashtags,
  discord: '**' + titulo + '**\n' + cuerpo,
  reddit_titulo: corta(titulo, 300),
  reddit_cuerpo: cuerpo
}}];
```

## Cómo probarla
- Empieza activando solo Discord: es la red más indulgente. Deja un PNG y un TXT en la carpeta y mira que llega.
- Añade Bluesky después: si el login falla es casi seguro que has puesto tu contraseña normal en vez de una App Password.
- Prueba con un texto de 800 caracteres para ver que los recortes salen bien y no cortan a mitad de palabra.

## Qué puede salir mal
- **Publicaciones dobles**: si el «Move File» falla, el trigger volverá a verlo. Pon el Move como primer nodo tras la descarga y publica después.
- **Reddit y el autopromo**: muchos subreddits banean cuentas nuevas que solo publican su juego. Publica en r/IndieDev y en los hilos de autopromo, y participa a mano de vez en cuando.
- **Vídeos**: Bluesky admite MP4 de hasta 50 MB y 60 segundos; para clips más largos publica solo un GIF o una imagen.
- **Límite de X**: el plan gratuito es corto. Si lo superas, el nodo devolverá 429; envuélvelo en «Continue On Fail» para que no rompa el resto.

## Cuánto cuesta
Bluesky, Discord, Reddit y Drive: 0 €. X gratuito llega a unas 500 publicaciones al mes; su plan Basic son unos 100 $/mes y casi nunca compensa para un indie. n8n auto-alojado gratis.
