# Capítulos y descripción SEO automáticos en YouTube…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Coge la transcripción de tu vídeo, genera con IA los capítulos con sus minutos, una descripción optimizada y las etiquetas, y actualiza el vídeo directamente en YouTube.

## Qué es y qué hace

Es una automatización de n8n que toma la transcripción con marcas de tiempo de un vídeo tuyo ya subido, pide a un modelo de IA (Claude, Codex, Gemini o una IA local) capítulos, descripción y etiquetas, y actualiza el vídeo en YouTube por API. Entra el ID del vídeo y sale el texto nuevo aplicado al canal. Requiere la credencial YouTube OAuth2 y la clave del modelo que elijas.

## Cómo usarla

1. Elige el modelo y pon su clave en n8n
2. Conecta YouTube OAuth2
3. Revisa capítulos y descripción en un vídeo de prueba
4. Activa el flujo para los vídeos largos

## Cuándo usarla

Úsalo cuando publiques vídeos de más de 8 minutos y no te apetezca ver el vídeo otra vez para poner los capítulos y escribir una descripción decente.

## Cómo ganar dinero con ella

Ahorra 20-25 min por vídeo y mejora la retención y el posicionamiento, que es tráfico gratis que ya estabas dejando escapar.

- Capítulos y descripciones para canales de formación con vídeos largos.
- Optimización de descripciones como servicio para creadores con una biblioteca antigua.
- Revisión SEO mensual de los vídeos publicados para negocios que viven de YouTube.

**Precio orientativo:** 120–300 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Toma el ID de un vídeo tuyo ya subido (aunque esté en privado), consigue la transcripción con marcas de tiempo, se la pasa a un modelo de IA y le pide capítulos, descripción y etiquetas; después actualiza el vídeo por API.
Para canales de formación, entrevistas o podcast en vídeo, donde los capítulos marcan la diferencia en retención.

## Lo que necesitas antes
- n8n con **ffmpeg** si vas a transcribir desde el archivo (o reutiliza el .srt de la receta de subtítulos).
- Clave de API de OpenAI.
- Credencial **YouTube OAuth2** en n8n con permiso de escritura (`youtube.force-ssl`).
- Una hoja `Vídeos` con columnas `video_id`, `estado`, `capitulos`, `descripcion_generada`.

## Los nodos, en orden
1. **Schedule Trigger** — cada 30 minutos.
2. **Google Sheets** (Get Row(s)) — Filters: `estado` = `pendiente`.
3. **Split In Batches** — Batch Size `1`.
4. **HTTP Request** (transcripción con tiempos) — POST `https://api.openai.com/v1/audio/transcriptions`, Header Auth con tu clave, Body multipart: `file` (el audio del vídeo, sacado como en la receta de subtítulos), `model` = `whisper-1`, `response_format` = `verbose_json`, `timestamp_granularities[]` = `segment`.
5. **Code** (comprimir la transcripción para que quepa en el prompt):
```javascript
const segs = $json.segments || [];
const linea = s => {
  const m = Math.floor(s.start / 60).toString().padStart(2, '0');
  const seg = Math.floor(s.start % 60).toString().padStart(2, '0');
  return `${m}:${seg} ${s.text.trim()}`;
};
const texto = segs.map(linea).join('\n');
return [{ json: { transcripcion: texto.slice(0, 60000) } }];
```
6. **OpenAI** (Message a Model) — Model `gpt-4.1-mini` o similar. System: «Eres editor de YouTube en España. Respondes solo con JSON válido.» User:
```text
A partir de esta transcripción con minutos, devuelve un JSON con las claves: capitulos (array de objetos {tiempo, titulo}, el primero SIEMPRE 00:00, entre 6 y 12 capítulos, títulos de máximo 45 caracteres, sin numerar), descripcion (2 párrafos, 500-800 caracteres, tono cercano, tuteando, con la palabra clave principal en la primera frase), etiquetas (array de 12 términos de búsqueda reales). Transcripción: {{ $json.transcripcion }}
```
En *Options* activa `Output Content as JSON`.
7. **Code** (montar el texto final de la descripción):
```javascript
const d = $json.message?.content ? JSON.parse($json.message.content) : $json;
const caps = d.capitulos.map(c => `${c.tiempo} ${c.titulo}`).join('\n');
const desc = `${d.descripcion}\n\n⏱️ Capítulos:\n${caps}\n\n👉 Más en mi web.`;
return [{ json: { descripcion: desc, etiquetas: d.etiquetas, capitulos: caps } }];
```
8. **HTTP Request** (leer el vídeo actual) — GET `https://www.googleapis.com/youtube/v3/videos?part=snippet&id={{ $('Split In Batches').item.json.video_id }}`, Authentication: Predefined → YouTube OAuth2. Hace falta porque la actualización pisa todo el `snippet`.
9. **HTTP Request** (actualizar) — PUT `https://www.googleapis.com/youtube/v3/videos?part=snippet`, Body JSON:
```json
{"id":"={{ $('Split In Batches').item.json.video_id }}","snippet":{"title":"={{ $('HTTP Request1').item.json.items[0].snippet.title }}","categoryId":"={{ $('HTTP Request1').item.json.items[0].snippet.categoryId }}","description":"={{ $('Code1').item.json.descripcion }}","tags":{{ JSON.stringify($('Code1').item.json.etiquetas) }},"defaultLanguage":"es"}}
```
10. **Google Sheets** (Update Row) — `estado` = `hecho` y guarda los capítulos por si quieres revisarlos.

## Cómo probarla
- Prueba primero con un vídeo en `unlisted` tuyo. Mira que los capítulos empiecen en `00:00` (si no, YouTube no los muestra) y que haya al menos tres, cada uno de 10 segundos o más.
- Antes de dejarlo solo, mete un **IF** que exija revisión manual: escribe la descripción en la hoja y publícala en un segundo flujo cuando marques `aprobado`.

## Qué puede salir mal
- **YouTube borra el título si no lo mandas**: el PUT reemplaza el `snippet` entero, por eso el paso 8 es obligatorio.
- **Capítulos que no salen**: hacen falta 3 mínimo, el primero en 00:00 y orden ascendente. Valida en el Code y descarta los mal formados.
- **JSON roto de la IA**: envuelve el `JSON.parse` en try/catch y manda el fallo a una rama de aviso.
- **Descripción de más de 5.000 caracteres**: recórtala en el Code o la API devuelve error 400.

## Cuánto cuesta
- OpenAI: transcripción 0,006 $/min más unos 0,01-0,03 € de texto por vídeo. Un vídeo de 20 minutos, unos 0,12 €.
- YouTube API: gratis (un `videos.update` gasta 50 unidades de 10.000 diarias).
- n8n: 0 € auto-alojado.
