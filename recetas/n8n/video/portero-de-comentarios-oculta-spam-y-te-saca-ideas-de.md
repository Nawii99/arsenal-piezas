# Portero de comentarios: oculta spam y te saca ideas de…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Revisa los comentarios nuevos de tus vídeos, marca como spam los de estafa y enlaces raros, y guarda aparte las preguntas reales para que las conviertas en próximos vídeos.

## Qué es y qué hace

Lee cada hora los comentarios nuevos de tu canal de YouTube, los clasifica en spam, pregunta útil o normal, oculta los de spam y guarda las preguntas en una hoja para convertirlas en ideas. Entra la API de comentarios con permiso de moderación y sale un registro, las ocultaciones y un aviso opcional por Telegram. Para canales activos que sufren estafas o buscan un banco de ideas.

## Cómo usarla

1. Pide credencial YouTube OAuth con permiso de moderación
2. Crea el bot de Telegram para avisos
3. Prepara la hoja de preguntas
4. Ajusta el filtro de spam antes de activar la ocultación

## Cuándo usarla

Cuando ya recibes suficientes comentarios como para no leerlos todos, o te llegan mensajes de «inversiones cripto» suplantándote en tu propio canal.

## Cómo ganar dinero con ella

Media hora diaria de moderación menos y un banco de ideas de contenido que sale gratis del propio público.

- Moderación de comentarios para canales de creadores con filtro de spam y resumen semanal…
- Gestión de comunidad en YouTube para negocios locales, con informe de preguntas del público…
- Investigación de temas para creadores a partir de las preguntas reales de su audiencia…

**Precio orientativo:** 50–150 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada hora lee los comentarios nuevos del canal, los clasifica en tres cubos (spam, pregunta útil, normal), esconde los de spam y apunta las preguntas en una hoja. Para creadores y negocios con canal activo que no quieren dedicar la mañana a moderar.

## Lo que necesitas antes
- Credencial **YouTube OAuth2 API** con permiso `youtube.force-ssl` (moderar comentarios lo exige).
- Clave de OpenAI o del modelo que uses, guardada como credencial en n8n.
- Hoja «Preguntas del público» con columnas: fecha, videoId, autor, pregunta, usada.
- Bot de Telegram si quieres el aviso: escribe a @BotFather, /newbot, guarda el token, y saca tu chat_id escribiendo al bot y mirando https://api.telegram.org/bot<TOKEN>/getUpdates.

## Los nodos, en orden
1. **Schedule Trigger** — cada 1 hora.
2. **HTTP Request** — GET https://www.googleapis.com/youtube/v3/commentThreads?part=snippet&allThreadsRelatedToChannelId=TU_CHANNEL_ID&maxResults=50&order=time, credencial YouTube OAuth2.
3. **Code** — se queda solo con los comentarios de las últimas 2 horas y aplana los campos que interesan.
4. **Split In Batches** — Batch Size 10, para no reventar el límite del modelo.
5. **HTTP Request** al modelo (o **AI Agent**) — prompt: «Clasifica cada comentario como SPAM, PREGUNTA o NORMAL. SPAM = promesas de dinero, enlaces a canales de trading, suplantación del creador, venta de seguidores. Devuelve JSON array con id y clase, sin texto extra.»
6. **Code** — parsea la respuesta y la une con los comentarios originales.
7. **Switch** — tres salidas por el campo `clase`.
8. Rama SPAM → **HTTP Request** POST https://www.googleapis.com/youtube/v3/comments/setModerationStatus?id={{ $json.id }}&moderationStatus=rejected&banAuthor=false.
9. Rama PREGUNTA → **Google Sheets** (Append) a «Preguntas del público».
10. Al final, **Telegram** (Send Message) con el resumen: «Hoy: 4 spam ocultos, 7 preguntas nuevas».

## El código del nodo 3
```js
const corte = Date.now() - 2*60*60*1000;
return $input.first().json.items
  .map(i => ({ json: {
    id: i.snippet.topLevelComment.id,
    videoId: i.snippet.videoId,
    autor: i.snippet.topLevelComment.snippet.authorDisplayName,
    texto: i.snippet.topLevelComment.snippet.textOriginal,
    fecha: i.snippet.topLevelComment.snippet.publishedAt } }))
  .filter(x => new Date(x.json.fecha).getTime() > corte);
```

## Cómo probarla
Deja desconectado el nodo 8 los primeros días y manda la lista de «spam detectado» a Telegram para revisarla tú. Cuando lleves una semana sin falsos positivos, conecta el borrado. Escribe tú mismo un comentario de prueba con una pregunta para ver que aterriza en la hoja.

## Qué puede salir mal
- **Falsos positivos**: usa `moderationStatus=heldForReview` en vez de `rejected` y los comentarios quedan pendientes, no borrados.
- **Solo modera lo tuyo**: la API solo deja moderar comentarios en tus vídeos, no en los de otros.
- **Repeticiones**: si el trigger se retrasa, un comentario puede procesarse dos veces. Guarda los id ya vistos en una hoja y filtra.
- **Coste del modelo**: por eso el Split In Batches; sin él, 300 comentarios en una sola llamada te la corta.

## Cuánto cuesta
Gratis salvo la IA: clasificar 1.000 comentarios al mes cuesta bastante menos de 1 €. Telegram y YouTube API, cero.
