# Banco de ideas sacado de los comentarios de tus vídeos…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Cada semana recoge los comentarios nuevos de tu canal, separa las preguntas reales y te entrega una lista de temas agrupados para tus próximos vídeos.

## Qué es y qué hace

Descarga los comentarios de tus vídeos de los últimos 30 días con la API de YouTube, filtra los que son preguntas o peticiones, los agrupa por tema con una IA de texto y te envía por email un top de 10 ideas ordenadas por cuánta gente las pide. Entrada: comentarios del canal; salida: email y fila en la hoja Ideas. Se monta en n8n y el gasto en llamadas a la IA es bajo.

## Cómo usarla

1. Crea la credencial de YouTube OAuth2
2. Ajusta el filtro de preguntas
3. Programa el envío semanal
4. Usa el top 10 para planificar rodajes

## Cuándo usarla

Cuando ya tienes comentarios entrando y se te va la vida pensando de qué grabar, mientras tu audiencia te está diciendo exactamente lo que quiere.

## Cómo ganar dinero con ella

Elimina el bloqueo de ideas y aumenta la retención: grabas lo que ya han pedido. Ahorra una sesión mensual de brainstorming de 2 horas.

- Informe mensual de temas para canales pequeños con comunidad activa.
- Consultoría de contenidos que convierte comentarios en calendario editorial para creadores.
- Panel de ideas para academias que lanzan cursos según lo que piden sus alumnos.

**Precio orientativo:** 40–120 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Descarga los comentarios de tus vídeos de los últimos 30 días, se queda solo con los que son preguntas o peticiones, los agrupa por tema con IA y te manda un email con 10 ideas de vídeo ordenadas por cuánta gente las pide. Es para cualquier canal con comunidad activa, aunque sea pequeña.

## Lo que necesitas antes
- n8n con credencial «YouTube OAuth2 API» (permiso `youtube.force-ssl` para leer comentarios de tu canal).
- Clave de API de OpenAI.
- Tu Channel ID.
- Hoja «Ideas» con columnas: semana, tema, cuantos, ejemplo, videos_relacionados.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 9 * * 5`, viernes a las 9:00, Europe/Madrid.
2. **HTTP Request** («Comentarios del canal») — GET `https://www.googleapis.com/youtube/v3/commentThreads` con `part=snippet`, `allThreadsRelatedToChannelId=TU_CHANNEL_ID`, `maxResults=100`, `order=time`, `textFormat=plainText`. En Options activa **Pagination**: Response Contains Next Page, parámetro `pageToken` = `{{ $response.body.nextPageToken }}`, límite 5 páginas.
3. **Code** («Quedarme con preguntas») — filtra por fecha y por señales de pregunta.
4. **IF** — `{{ $json.hay }}` is true (si no hay preguntas esa semana, no gastes IA).
5. **Aggregate** — modo All Item Data, para juntar todo en un solo item.
6. **HTTP Request** («Agrupar temas») — POST a chat/completions, `gpt-4o-mini`, `response_format: json_object`, mensaje: «Aquí tienes preguntas de mi audiencia. Agrúpalas en máximo 10 temas de vídeo. Devuelve {"temas":[{"tema":"...","cuantos":n,"ejemplo":"pregunta literal","titulo_sugerido":"..."}]} ordenado de más a menos peticiones. Preguntas: {{ $json.data }}».
7. **Code** («Desglosar») — convierte el JSON en una fila por tema.
8. **Google Sheets** — Append a «Ideas».
9. **Gmail** — Send Message con las 10 ideas en el cuerpo, asunto «Tu audiencia pide esto (semana {{ $now.weekNumber }})».

## El código de «Quedarme con preguntas»
```js
const DIAS = 30;
const limite = Date.now() - DIAS * 86400000;
const señales = ['?', 'como ', 'cómo ', 'podrias', 'podrías', 'puedes hacer', 'y si ', 'duda', 'no entiendo', 'recomiendas'];
const out = [];
for (const it of items) {
  const c = it.json.snippet?.topLevelComment?.snippet;
  if (!c) continue;
  if (new Date(c.publishedAt).getTime() < limite) continue;
  const t = (c.textDisplay || '').trim();
  if (t.length < 15 || t.length > 500) continue;
  const bajo = t.toLowerCase();
  if (!señales.some(s => bajo.includes(s))) continue;
  out.push({ json: { texto: t, autor: c.authorDisplayName, videoId: c.videoId } });
}
return out.length ? out : [{ json: { hay: false } }];
```

## El código de «Desglosar»
```js
const temas = JSON.parse(items[0].json.choices[0].message.content).temas || [];
const semana = new Date().toISOString().slice(0, 10);
return temas.map(t => ({ json: {
  semana,
  tema: t.tema,
  cuantos: t.cuantos,
  ejemplo: t.ejemplo,
  titulo_sugerido: t.titulo_sugerido
}}));
```

## Cómo probarla
- Ejecuta a mano y mira cuántos items salen del paso 3: si son cero, amplía DIAS a 90 o quita alguna señal.
- Contrasta dos o tres preguntas de la lista con los comentarios reales del vídeo para asegurarte de que no está mezclando spam.
- Añade a la lista negra las frases típicas de bots («gana dinero», «telegram», enlaces) si te cuelan basura.

## Qué puede salir mal
- **Solo trae 100 comentarios**: activa la paginación del paso 2 tal cual está descrita, si no te quedas con la primera página.
- **Comentarios desactivados** en algún vídeo: la API responde 403 en ese hilo; activa Always Output Data y Continue On Fail en el nodo.
- **El texto pesa demasiado para la IA**: recorta a las 300 preguntas más recientes antes del paso 6 con un `slice(0,300)`.
- **Spam**: los bots repiten patrones; el filtro de longitud mínima y las señales de pregunta se llevan la mayoría.

## Cuánto cuesta
La API de YouTube es gratis (commentThreads gasta 1 unidad por página). gpt-4o-mini para agrupar: menos de 0,02 € por semana. Sheets y Gmail, gratis. Total real: menos de 1 € al año en IA.
