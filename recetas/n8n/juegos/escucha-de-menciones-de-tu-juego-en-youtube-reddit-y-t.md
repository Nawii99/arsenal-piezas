# Escucha de menciones de tu juego en YouTube, Reddit y T…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Busca cada día vídeos, hilos y directos que hablen de tu juego, los guarda en una hoja y te avisa de los que tienen tirón.

## Qué es y qué hace

Flujo de n8n que cada mañana busca el nombre de tu juego en vídeos de YouTube de las últimas 24 horas, en los subreddits que elijas y en directos de Twitch de tu categoría. Guarda cada mención sin repetir en Google Sheets y avisa por Telegram solo de las que superan un umbral de visitas o votos. Entran el nombre del juego y las fuentes; sale una hoja y los avisos. Necesita claves de YouTube Data API y de Twitch.

## Cómo usarla

1. 1. Crea la clave de YouTube y la app de Twitch
2. 2. Elige subreddits y el umbral de avisos
3. 3. Revisa la hoja y responde a los creadores que te mencionan

## Cuándo usarla

Úsalo cuando ya hay gente jugando tu juego y quieres enterarte de quién habla de él para agradecérselo, compartirlo o detectar una queja que se está extendiendo.

## Cómo ganar dinero con ella

Ahorra la búsqueda diaria a mano (unas 5 h al mes) y te permite aprovechar el vídeo de un creador el mismo día en que sale, no una semana después.

- Monitor de menciones para estudios indie que quieren agradecer a los creadores que hablan de su juego.
- Alerta de quejas que se extienden en Reddit para desarrolladores con comunidad en redes.
- Informe semanal de menciones para editoras pequeñas que preparan campañas con creadores.

**Precio orientativo:** 120–300 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada mañana busca el nombre de tu juego en YouTube (vídeos de las últimas 24 h), en Reddit (últimos posts de los subreddits que te interesen) y en los directos de Twitch de tu categoría. Guarda todo en una hoja sin repetir y te manda por Telegram solo lo que supera un umbral de visitas o votos.
Para estudios indie con el juego ya publicado que quieren gestionar la comunidad sin dedicarle la mañana entera.

## Lo que necesitas antes
- n8n.
- Clave de API de YouTube Data v3 (console.cloud.google.com → habilitar «YouTube Data API v3» → Credenciales → Clave de API). Gratis, 10.000 unidades/día; cada búsqueda cuesta 100.
- Reddit no necesita clave para leer si usas la URL pública `.json`.
- Twitch: crea una app en dev.twitch.tv/console/apps → Client ID y Secret. Gratis.
- Hoja de Google «menciones» con columnas: fecha, plataforma, titulo, autor, enlace, metrica, avisado.
- Bot de Telegram (@BotFather) y tu chat_id (@userinfobot).

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 9 * * *` (todos los días a las 9:00, zona Europe/Madrid).
2. **HTTP Request** «YouTube» — GET `https://www.googleapis.com/youtube/v3/search?part=snippet&q=%22NOMBRE DEL JUEGO%22&type=video&order=date&publishedAfter={{ $now.minus(1, 'days').toISO() }}&maxResults=25`, con Authentication: Generic > Query Auth con una credencial de n8n (Name `key`, Value tu clave). No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él.
3. **HTTP Request** «YouTube stats» — GET `https://www.googleapis.com/youtube/v3/videos?part=statistics&id={{ lista de ids separada por comas }}` con la misma credencial Query Auth, para saber las visitas.
4. **HTTP Request** «Reddit» — GET `https://www.reddit.com/search.json?q=%22NOMBRE DEL JUEGO%22&sort=new&t=day&limit=25`. En Options → Headers añade `User-Agent: n8n-menciones-tujuego` o Reddit te devolverá 429.
5. **HTTP Request** «Twitch token» — POST `https://id.twitch.tv/oauth2/token` con `grant_type=client_credentials`, y `client_id` y `client_secret` leídos de variables de entorno de n8n (`{{ $env.TWITCH_CLIENT_ID }}`, `{{ $env.TWITCH_CLIENT_SECRET }}`) o de una credencial, no escritos en el nodo. No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él.
6. **HTTP Request** «Twitch directos» — GET `https://api.twitch.tv/helix/streams?game_id=TU_GAME_ID` con cabeceras `Client-Id` y `Authorization: Bearer {{ token }}`. El game_id lo sacas con `/helix/games?name=NOMBRE`.
7. **Merge** — Modo «Append», 3 entradas, para juntar las tres fuentes.
8. **Code** — Normaliza al mismo formato y quita lo que ya está en la hoja (código abajo).
9. **Google Sheets** («Append Row») — Guarda todo lo nuevo.
10. **Filter** — Deja pasar solo `metrica` mayor que 500.
11. **Telegram** — `📺 {{ $json.plataforma }} — {{ $json.titulo }} ({{ $json.metrica }}) por {{ $json.autor }}: {{ $json.enlace }}`.

## El nodo Code
```javascript
const previos = new Set($('Google Sheets').all().map(i => String(i.json.enlace)));
const salida = [];
for (const item of $input.all()) {
  const j = item.json;
  let fila = null;
  if (j.id && j.id.videoId) {
    fila = { plataforma: 'YouTube', titulo: j.snippet.title, autor: j.snippet.channelTitle,
             enlace: 'https://youtu.be/' + j.id.videoId, metrica: Number(j.visitas || 0) };
  } else if (j.data && j.data.permalink) {
    fila = { plataforma: 'Reddit', titulo: j.data.title, autor: j.data.author,
             enlace: 'https://reddit.com' + j.data.permalink, metrica: Number(j.data.ups || 0) };
  } else if (j.user_name) {
    fila = { plataforma: 'Twitch', titulo: j.title, autor: j.user_name,
             enlace: 'https://twitch.tv/' + j.user_login, metrica: Number(j.viewer_count || 0) };
  }
  if (fila && !previos.has(fila.enlace)) {
    fila.fecha = new Date().toISOString().slice(0, 16);
    salida.push({ json: fila });
  }
}
return salida;
```

## Cómo probarla
- Prueba cada HTTP Request por separado con «Execute step» y mira la salida antes de conectar el Merge.
- Si tu juego tiene un nombre común (por ejemplo «Rift»), añade una palabra al buscador: `"Rift Valley game"`. Si no, te llegará ruido a montones.
- Baja el umbral del Filter a 0 el primer día para ver que Telegram recibe algo.

## Qué puede salir mal
- **Cuota de YouTube agotada**: cada búsqueda son 100 unidades de las 10.000 diarias. Una búsqueda al día no la agota; no lo pongas cada hora.
- **429 de Reddit**: casi siempre es por no poner User-Agent propio. Ponlo.
- **Directos que empiezan y acaban**: Twitch solo muestra los directos en curso. Si quieres pillarlos todos, ejecuta el flujo tres veces al día en vez de una.
- **Zonas horarias**: `publishedAfter` va en UTC. Con la expresión `$now.minus(1,'days').toISO()` te sale correcta.

## Cuánto cuesta
0 €. Las tres APIs tienen nivel gratuito suficiente para uso diario, y Sheets y Telegram no cuestan nada.
