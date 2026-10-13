# Capítulos automáticos en la descripción desde los subtí…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Coge los subtítulos automáticos de un vídeo de YouTube, los agrupa en temas con IA y actualiza la descripción del vídeo con los capítulos con marca de tiempo.

## Qué es y qué hace

Descarga los subtítulos automáticos de tus vídeos de YouTube con marcas de tiempo, los envía a un modelo de IA que los agrupa en 6-10 capítulos y actualiza la descripción con la lista de tiempos. Entran el ID de canal y credenciales OAuth con permiso de edición; sale la descripción actualizada y una hoja de control para no repetir. Pensado para vídeos largos de formación o entrevistas en n8n.

## Cómo usarla

1. Crea credencial YouTube OAuth con youtube.force-ssl
2. Añade la clave del modelo en n8n
3. Prepara la hoja de control
4. Programa el ciclo de 6 horas y revisa los primeros capítulos

## Cuándo usarla

Úsalo cuando subes vídeos de más de 8 minutos (formaciones, entrevistas, podcast en vídeo) y nunca te da la vida para poner los capítulos a mano.

## Cómo ganar dinero con ella

Los capítulos suben la retención y hacen que Google muestre «momentos clave». Ahorra 15-20 minutos por vídeo largo.

- Optimización de metadatos para canales de formación, con capítulos y descripciones por lote…
- Revisión mensual de descripciones de YouTube para clientes con vídeos largos…
- Plantilla de capítulos y SEO de vídeo para academias online…

**Precio orientativo:** 40–120 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Descarga la transcripción con tiempos de un vídeo tuyo, se la pasa a un modelo de IA para que la divida en 6-10 capítulos y reescribe la descripción del vídeo añadiendo la lista de tiempos. Para quien publica vídeo largo y quiere el trabajo de edición de metadatos hecho.

## Lo que necesitas antes
- Canal de YouTube propio y credencial **YouTube OAuth2 API** en n8n con el permiso `youtube.force-ssl` (necesario para editar la descripción).
- Clave de API de un modelo de IA: platform.openai.com → API keys, o console.anthropic.com. Guárdala en n8n como credencial, nunca en el código del nodo.
- Los subtítulos automáticos del vídeo tienen que estar generados (espera 1-2 horas tras subirlo).
- Una hoja «Capítulos hechos» con columna videoId, para no repetir.

## Los nodos, en orden
1. **Schedule Trigger** — cada 6 horas.
2. **YouTube** (Video → Get Many, My Videos, Limit 5).
3. **Google Sheets** (Get Many) sobre «Capítulos hechos» y luego **Code** que descarta los videoId ya procesados.
4. **HTTP Request** — GET https://www.googleapis.com/youtube/v3/captions?part=snippet&videoId={{ $json.videoId }} con credencial YouTube OAuth2. Quédate con el `id` de la pista en español.
5. **HTTP Request** — GET https://www.googleapis.com/youtube/v3/captions/{{ $json.captionId }}?tfmt=srt, misma credencial. Response Format: «String». Devuelve el SRT.
6. **AI Agent** o **HTTP Request** al modelo — prompt: «Te doy un SRT. Devuelve solo una lista de capítulos en formato mm:ss Título, entre 6 y 10, el primero siempre 00:00, títulos de máximo 45 caracteres, en español de España. SRT: {{ $json.data }}».
7. **YouTube** (Video → Get) para leer la descripción actual y no perderla.
8. **Code** — pega los capítulos al principio de la descripción existente.
9. **YouTube** (Video → Update) — Title: el mismo, Description: {{ $json.descripcion_nueva }}, Category ID: el mismo que tenía.
10. **Google Sheets** (Append) — marca el videoId como hecho.

## El código del nodo 8
```js
const cap = $('AI Agent').first().json.output.trim();
const desc = $('YouTube').last().json.snippet.description || '';
const limpia = desc.replace(/^[\s\S]*?(?=\n\n)/, m => m.match(/^\d{2}:\d{2}/) ? '' : m);
return [{ json: { descripcion_nueva: `Capítulos:\n${cap}\n\n${limpia}` } }];
```

## Cómo probarla
Prueba primero con un vídeo puesto «No listado». Ejecuta hasta el nodo 6 y lee la salida: si los tiempos no son crecientes o pasan del final del vídeo, aprieta el prompt. Solo cuando la lista sea buena, activa los nodos 9 y 10.

## Qué puede salir mal
- **Sin pista de subtítulos**: la API solo lista subtítulos automáticos del propietario; si devuelve vacío, espera más o sube tú un SRT.
- **La IA se inventa tiempos**: pídele explícitamente que use solo marcas que aparezcan en el SRT y revisa el primer mes.
- **Descripción machacada**: el nodo Update sustituye TODO el snippet. Si no le pasas el categoryId, el vídeo cambia de categoría. Léelo siempre antes (nodo 7).
- **Cuota de YouTube**: cada `videos.update` cuesta 50 unidades de las 10.000 diarias. Sobra, pero no lo pongas cada 5 minutos.

## Cuánto cuesta
n8n y YouTube, gratis. La IA: un SRT de 20 minutos son unos 6.000 tokens, menos de 0,02 € por vídeo. Con 5 € tienes para meses.
