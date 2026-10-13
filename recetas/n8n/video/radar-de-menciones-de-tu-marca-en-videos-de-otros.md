# Radar de menciones de tu marca en vídeos de otros…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Busca cada día vídeos nuevos de YouTube que mencionen tu marca o producto, mira si hablan bien o mal y te avisa con el enlace y el resumen.

## Qué es y qué hace

Cada mañana busca en YouTube los vídeos publicados en las últimas 24 horas que mencionan tu marca y sus variantes, lee título, descripción y primeros comentarios, clasifica el tono y te manda el enlace con un resumen. Entra una clave de YouTube Data API y la lista de términos; sale una fila en Sheets y un aviso en Slack o Telegram. Útil para marcas de producto y negocios que aparecen en vídeos de terceros.

## Cómo usarla

1. Crea una clave de API restringida a YouTube Data
2. Define la lista de términos de búsqueda
3. Prepara la hoja Menciones y el canal de aviso
4. Activa el disparador diario a las 08:30

## Cuándo usarla

Cuando vendes un producto o servicio con nombre propio y quieres enterarte de reseñas, tutoriales o críticas en vídeo el mismo día, no tres meses después.

## Cómo ganar dinero con ella

Te ahorra una herramienta de escucha (Brand24 desde 79 €/mes) y te deja responder a una crítica cuando aún tiene 200 visitas.

- Monitorización de reseñas en vídeo para marcas de producto, con informe semanal…
- Escucha de YouTube para negocios locales que quieren responder críticas a tiempo…
- Configuración de radar de menciones para agencias con varios clientes…

**Precio orientativo:** 40–120 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lanza búsquedas en YouTube por tu marca y variantes, se queda con lo publicado en las últimas 24 horas, lee la descripción y los primeros comentarios, y clasifica el tono. Para marcas de producto, formadores y negocios locales que aparecen en vídeos de terceros.

## Lo que necesitas antes
- Clave de **YouTube Data API v3** simple (API key, no hace falta OAuth para buscar): Google Cloud → Credenciales → Crear clave de API. Restríngela a la YouTube Data API.
- Lista de términos: tu marca, tu marca + «opinión», tu marca + «review», nombre del producto estrella.
- Clave de OpenAI o del modelo que uses.
- Hoja «Menciones» con: fecha, canal, titulo, url, tono, resumen.
- Webhook de Slack (api.slack.com/apps → Incoming Webhooks) o bot de Telegram.

## Los nodos, en orden
1. **Schedule Trigger** — cada día a las 08:30, Europe/Madrid.
2. **Code** — devuelve un item por término de búsqueda.
3. **Split In Batches** — 1 a 1, para no disparar la cuota.
4. **HTTP Request** — GET https://www.googleapis.com/youtube/v3/search?part=snippet&q={{ $json.termino }}&type=video&order=date&publishedAfter={{ $json.desde }}&maxResults=10&relevanceLanguage=es&key=TU_API_KEY.
5. **Code** — aplana los resultados y filtra los que ya estén en la hoja (usa un Google Sheets «Get Many» previo y compara videoId).
6. **HTTP Request** — GET .../youtube/v3/videos?part=snippet,statistics&id={{ $json.videoId }}&key=... para tener descripción y visitas.
7. **AI Agent** — prompt: «Aquí tienes el título, la descripción y las visitas de un vídeo que menciona la marca X. Di si el tono es POSITIVO, NEUTRO o NEGATIVO y resume en una frase qué dice de la marca. Si en realidad no habla de la marca, responde IRRELEVANTE.»
8. **IF** — descarta los IRRELEVANTE.
9. **Google Sheets** (Append) — guarda la mención.
10. **Switch** — si el tono es NEGATIVO o el vídeo pasa de 5.000 visitas, aviso inmediato por Slack; si no, entra en un resumen diario.

## El código del nodo 2
```js
const desde = new Date(Date.now() - 26*60*60*1000).toISOString();
const terminos = ['"MiMarca"', 'MiMarca opinión', 'MiMarca review', 'MiProducto tutorial'];
return terminos.map(t => ({ json: { termino: t, desde } }));
```

## Cómo probarla
Sustituye tu marca por una conocida (por ejemplo «Filmora») y ejecuta: si no salen 5-10 vídeos, algo falla en el parámetro publishedAfter. Luego vuelve a la tuya. Si tu marca es una palabra común, usa comillas en la query.

## Qué puede salir mal
- **Cuota**: `search.list` cuesta 100 unidades de 10.000 diarias. Con 4 términos al día gastas 400: perfecto. No lo pongas cada hora.
- **Ruido**: marcas con nombre genérico devuelven basura. El filtro IRRELEVANTE del paso 7 es lo que salva el sistema.
- **Duplicados entre términos**: quita repetidos por videoId antes del paso 6.
- **Vídeos en otros idiomas**: quita `relevanceLanguage` si vendes fuera.

## Cuánto cuesta
YouTube API y Slack, gratis. La IA: unos 40 clasificaciones al día son menos de 1 €/mes. Comparado con una suite de escucha, ahorras cientos de euros al año.
