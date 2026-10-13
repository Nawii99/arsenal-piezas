# Espía a los canales de tu sector sin abrir YouTube…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Vigila los canales de tu competencia, guarda cada vídeo nuevo en una hoja con su tema y ángulo, y te avisa cuando alguno se dispara en vistas.

## Qué es y qué hace

Consulta cada mañana el RSS de los canales competidores que indiques, detecta vídeos nuevos, pide sus estadísticas a la API de YouTube, clasifica el tema y el tipo de gancho con IA y guarda todo en una hoja. Cada semana avisa por Telegram de los que superan la media del canal. Entran los IDs de canal; sale un registro de vídeos y avisos. Para creadores, marcas y agencias que buscan ideas con demanda.

## Cómo usarla

1. Saca los IDs de 5-15 competidores desde su código fuente
2. Configura la API de YouTube y la clave del modelo
3. Crea la hoja de registro y el bot de Telegram
4. Ajusta la media de referencia tras una semana

## Cuándo usarla

Cuando quieres saber qué está funcionando en tu nicho sin perder una hora al día en YouTube, o cuando buscas ideas de vídeo con demanda demostrada.

## Cómo ganar dinero con ella

Sustituye 3-4 horas al mes de investigación manual y evita grabar vídeos que nadie busca, que es el gasto más caro de todos.

- Análisis mensual de competencia en YouTube para marcas, con temas que funcionan…
- Radar de ideas de vídeo para creadores con demanda demostrada…
- Seguimiento de canales de sector para agencias, con avisos de vídeos que despuntan…

**Precio orientativo:** 60–200 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Cada mañana consulta el RSS de los canales que le indiques, detecta los vídeos nuevos, pide sus estadísticas a la API, la IA clasifica el tema y el tipo de gancho, y todo se guarda en una hoja. Además, cada semana revisa los vídeos guardados hace 7 días y te avisa por Telegram de los que han superado la media del canal. Para creadores, marcas y agencias que necesitan ideas con demanda real.

## Lo que necesitas antes
- n8n.
- Los IDs de canal de tus 5-15 competidores. Para sacarlos: abre el canal, botón derecho «Ver código fuente», busca `channelId` y copia el valor que empieza por `UC`. O usa la web `commentpicker.com/youtube-channel-id.php`.
- Credencial de Google con YouTube Data API v3.
- Clave de OpenAI.
- Bot de Telegram: escribe a `@BotFather`, `/newbot`, copia el token; escribe algo a tu bot y saca tu `chat_id` en `https://api.telegram.org/botTU_TOKEN/getUpdates`.
- Hoja `Competencia` con columnas: `fecha`, `canal`, `titulo`, `url`, `vistas`, `tema`, `gancho`, `revisado`.

## Los nodos, en orden
1. **Schedule Trigger** — Interval `Days`, hora 07:30, timezone `Europe/Madrid`.
2. **Code** — Devuelve un item por competidor con su URL de RSS (ver código).
3. **RSS Read** — URL: `{{ $json.feed }}`. Este nodo, a diferencia del trigger, sí acepta la URL por expresión y procesa varios canales.
4. **Code1** — Filtra los publicados en las últimas 24 horas y extrae el `videoId` del campo `link`.
5. **Google Sheets** — Operation: `Lookup` sobre la columna `url`. Sirve para descartar los ya guardados.
6. **IF** — Sigue solo si no se encontró coincidencia (`{{ $json.url === undefined }}`).
7. **HTTP Request** — GET a `https://www.googleapis.com/youtube/v3/videos` con Google OAuth2. Query: `part` = `snippet,statistics`, `id` = `{{ $json.videoId }}`.
8. **OpenAI** — `gpt-4.1-mini`. System: `Clasificas vídeos de YouTube. Devuelves SOLO JSON.` User: `Título: {{ $json.titulo }}. Descripción: {{ $json.descripcion }}. Devuelve {"tema":"3 palabras","gancho":"tutorial|opinión|lista|caso real|noticia|reto","idea_para_mi":"una frase con cómo adaptaría este tema a mi canal"}`. Activa Output as JSON.
9. **Google Sheets1** — Append con todos los campos.
10. **Schedule Trigger1** (segundo flujo, viernes 09:00) — **Google Sheets** `Read` de las filas con `revisado` vacío y fecha de hace más de 7 días → **HTTP Request** para volver a pedir las vistas → **IF** con `vistas` mayor que 20000 (ajústalo a tu nicho) → **Telegram** Operation `Send Message` con el título, las vistas y la idea que propuso la IA.

## El código del nodo Code (paso 2)
```javascript
const canales = [
  { nombre: 'Competidor A', id: 'UCxxxxxxxxxxxxxxxxxxxxxx' },
  { nombre: 'Competidor B', id: 'UCyyyyyyyyyyyyyyyyyyyyyy' }
];
return canales.map(c => ({ json: {
  canal: c.nombre,
  feed: 'https://www.youtube.com/feeds/videos.xml?channel_id=' + c.id
}}));
```

## El código del nodo Code1 (paso 4)
```javascript
const limite = Date.now() - 26 * 60 * 60 * 1000;
const salida = [];
for (const item of $input.all()) {
  const j = item.json;
  const pub = new Date(j.pubDate || j.isoDate).getTime();
  if (pub < limite) continue;
  const m = (j.link || '').match(/v=([\w-]{11})/);
  if (!m) continue;
  salida.push({ json: {
    videoId: m[1],
    titulo: j.title,
    url: j.link,
    canal: j.author || 'desconocido',
    fecha: new Date(pub).toISOString().slice(0, 10)
  }});
}
return salida;
```

## Cómo probarla
1. Empieza con dos canales. Ejecuta a mano y mira que el RSS devuelve los 15 últimos vídeos.
2. Amplía el filtro de 26 horas a 30 días solo para la prueba y comprueba que la hoja se rellena sin duplicados.
3. Baja el umbral de vistas del aviso de Telegram a 100 para verificar que llega el mensaje, y luego súbelo al número real.

## Qué puede salir mal
- **El RSS de YouTube solo devuelve los 15 vídeos más recientes** y no incluye Shorts de forma fiable. Para Shorts hay que usar la API con `search.list`, que gasta 100 unidades por llamada.
- **Duplicados**: sin el Lookup del paso 5 acabas con la misma fila 30 veces. No lo saltes.
- **Cuota de la API**: `videos.list` cuesta 1 unidad, así que con 15 canales vas sobradísimo dentro de las 10.000 diarias.
- **Canales que cambian de nombre**: el ID no cambia, tranquilo.
- **Retraso del RSS**: puede tardar hasta 1 hora en reflejar un vídeo nuevo. Si necesitas inmediatez, ejecuta cada 2 horas en vez de una vez al día.

## Cuánto cuesta
Gratis salvo OpenAI, que con 15 canales y unos 60 vídeos al mes sale por menos de 0,50 €. YouTube API, RSS, Sheets, Telegram y n8n gratuito no cuestan nada.
