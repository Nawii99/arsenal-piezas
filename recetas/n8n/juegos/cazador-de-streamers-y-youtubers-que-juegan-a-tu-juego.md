# Cazador de streamers y youtubers que juegan a tu juego…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Cada día busca quién ha jugado a tu juego en Twitch y YouTube, lo apunta en una lista con sus datos de audiencia y te prepara el email de contacto ya escrito.

## Qué es y qué hace

Consulta cada día la API de Twitch y la de YouTube para ver quién emite o publica vídeos de tu juego, guarda cada creador nuevo con su audiencia en una hoja y prepara un borrador de email personalizado. Entrada: nombre del juego y claves de API; salida: lista de creadores y borradores. Se monta en n8n con Google Sheets y Gmail.

## Cómo usarla

1. Registrar la app de Twitch y la clave de YouTube
2. Crear la hoja creadores
3. Probar la búsqueda con tu juego
4. Revisar los borradores antes de enviarlos

## Cuándo usarla

Cuando tu juego ya está publicado y quieres detectar a los creadores que lo prueban por su cuenta, para agradecérselo, mandarles claves o proponerles colaboración.

## Cómo ganar dinero con ella

Las plataformas de influencer marketing para videojuegos cuestan de 100 a 500 €/mes; esto hace el 80 % del trabajo por 0 €.

- Hacer prospección de creadores para lanzamientos indie, cobrando por campaña con lista entregada.
- Ofrecer a agencias de marketing de videojuegos una búsqueda diaria de creadores por cliente.
- Montar el flujo para una editora pequeña y enseñar al equipo a gestionar las respuestas.

**Precio orientativo:** 200–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Consulta a diario la API de Twitch para ver quién está o ha estado emitiendo tu juego y busca vídeos nuevos en YouTube con el nombre del juego, guarda cada creador nuevo con su audiencia y te deja un borrador de email personalizado. Para responsables de marketing de estudios pequeños.

## Lo que necesitas antes
- Cuenta de desarrollador de Twitch: entra en `dev.twitch.tv/console/apps`, registra una aplicación (OAuth Redirect: `http://localhost`), y guarda **Client ID** y **Client Secret**. Es gratis.
- El `game_id` de tu juego en Twitch: lo sacas con una llamada a `https://api.twitch.tv/helix/games?name=Nombre%20Del%20Juego`.
- Clave de la API de YouTube Data v3: en `console.cloud.google.com`, crea proyecto, habilita *YouTube Data API v3*, Credentials > API key. Cuota gratuita de 10.000 unidades al día (una búsqueda cuesta 100).
- Google Sheet `creadores` con columnas: `plataforma`, `canal`, `id_canal`, `url`, `seguidores`, `visitas_video`, `idioma`, `fecha_detectado`, `contactado`.
- Credenciales de Gmail en n8n.

## Los nodos, en orden
1. **Schedule Trigger** — Cron: `0 9,21 * * *` (dos veces al día; los directos son efímeros y si solo miras una vez te pierdes la mitad).
2. **HTTP Request** (`Token Twitch`) — POST a `https://id.twitch.tv/oauth2/token`, Body Content Type `Form-Urlencoded`, campos `grant_type=client_credentials`, `client_id` y `client_secret`; estos dos últimos se leen de variables de entorno de n8n (`{{ $env.TWITCH_CLIENT_ID }}`, `{{ $env.TWITCH_CLIENT_SECRET }}`) o de una credencial de n8n, no se escriben en el nodo. Devuelve `access_token` válido 60 días. No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él.
3. **HTTP Request** (`Directos Twitch`) — GET `https://api.twitch.tv/helix/streams?game_id=TU_GAME_ID&first=100`. Headers: `Client-Id: TU_CLIENT_ID` y `Authorization: Bearer {{ $json.access_token }}`.
4. **Split Out** — Field to Split Out: `data`. Así cada directo es un item.
5. **HTTP Request** (`Datos del canal`) — GET `https://api.twitch.tv/helix/channels/followers?broadcaster_id={{ $json.user_id }}` con las mismas cabeceras, para saber cuántos seguidores tiene.
6. **HTTP Request** (`YouTube`) — GET `https://www.googleapis.com/youtube/v3/search?part=snippet&q=%22Nombre+Del+Juego%22&type=video&order=date&publishedAfter={{ $now.minus(1,'days').toISO() }}&maxResults=25`, con Authentication: Generic > Query Auth con una credencial de n8n (Name `key`, Value tu clave). No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él.
7. **Code** (`Unificar y limpiar`) — junta ambas fuentes en un formato común y descarta canales minúsculos o que solo mencionan el juego de pasada. Código abajo.
8. **Google Sheets** (`Leer conocidos`) + **Merge** en modo `Keep Non-Matches` por `id_canal`, igual que en el flujo de reseñas, para quedarte solo con creadores nuevos.
9. **Google Sheets** (`Guardar`) — Append Row.
10. **IF** (`¿Merece contacto?`) — `{{ $json.seguidores }}` mayor o igual que `500`.
11. **Gmail** — Operation: `Create Draft` (borrador, no envío: la primera versión siempre hay que repasarla). To: vacío o el correo del canal si lo tienes. Subject: `Gracias por jugar a Nombre Del Juego`. Message: texto personalizado con `{{ $json.canal }}` y el enlace a su vídeo o directo.
12. **Telegram / Discord** (opcional) — aviso si aparece alguien con más de 50.000 seguidores: eso sí quieres verlo el mismo día.

## El código de `Unificar y limpiar`
```javascript
const salida = [];
const nombreJuego = 'nombre del juego';
for (const item of $input.all()) {
  const j = item.json;
  if (j.user_login) {
    salida.push({ json: {
      plataforma: 'Twitch',
      canal: j.user_name,
      id_canal: 'tw_' + j.user_id,
      url: 'https://twitch.tv/' + j.user_login,
      seguidores: j.total || 0,
      visitas_video: j.viewer_count || 0,
      idioma: j.language,
      fecha_detectado: $now.toFormat('yyyy-MM-dd'),
      contactado: 'no'
    } });
  } else if (j.id && j.id.videoId) {
    const titulo = (j.snippet.title || '').toLowerCase();
    if (!titulo.includes(nombreJuego)) continue;
    salida.push({ json: {
      plataforma: 'YouTube',
      canal: j.snippet.channelTitle,
      id_canal: 'yt_' + j.snippet.channelId,
      url: 'https://youtube.com/watch?v=' + j.id.videoId,
      seguidores: 0,
      visitas_video: 0,
      idioma: '',
      fecha_detectado: $now.toFormat('yyyy-MM-dd'),
      contactado: 'no'
    } });
  }
}
return salida;
```

## Cómo probarla
- Prueba primero el nodo de token de Twitch solo: si devuelve 400, casi seguro has puesto el secret en el sitio del id.
- Si tu juego es muy pequeño y no hay directos ahora mismo, prueba con el `game_id` de un juego popular para ver que el flujo funciona, y luego cámbialo.
- Deja los borradores de Gmail sin enviar durante la primera semana y léelos: si suenan a plantilla fría, no sirven.

## Qué puede salir mal
- **Token caducado**: el token de aplicación de Twitch dura ~60 días, pero el flujo lo pide en cada ejecución, así que no te afecta.
- **Cuota de YouTube**: cada búsqueda cuesta 100 unidades de las 10.000 diarias. Dos ejecuciones al día son 200: sobra. No caigas en la tentación de buscar cada 10 minutos.
- **Falsos positivos en YouTube**: si tu juego se llama «Bloom» te saldrá de todo. Busca con comillas y añade filtros extra en el Code (palabras como `gameplay`, `let's play`, tu nombre de estudio).
- **Duplicados de directos**: el mismo streamer aparece cada vez que emite. El Merge por `id_canal` lo resuelve, pero si quieres detectar reincidentes, añade una columna `veces` y actualízala.
- **Escribir a todo el mundo**: es la forma más rápida de que te ignoren. Filtra por idioma y por tamaño, y personaliza de verdad la primera frase.

## Cuánto cuesta
- API de Twitch: **gratis**. API de YouTube: **gratis** dentro de la cuota diaria.
- Sheets y Gmail: gratis. n8n auto-alojado: gratis.
- Si quisieras enviar los correos en masa, cuidado: Gmail personal limita a 500 al día y hacer envío frío masivo desde tu dominio te quema la reputación. Mejor pocos y buenos.
