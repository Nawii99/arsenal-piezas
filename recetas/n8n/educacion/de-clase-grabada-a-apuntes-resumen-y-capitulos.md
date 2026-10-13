# De clase grabada a apuntes, resumen y capítulos…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Coges la grabación de la clase, la transcribe, y genera resumen, apuntes con los puntos clave, capítulos con minutos y tres preguntas de repaso, todo guardado en Drive.

## Qué es y qué hace

Vigila una carpeta de Drive donde sueltas la grabación de una clase, la transcribe con Whisper y pide a una IA de texto (Claude, Codex, Gemini o una IA local) un resumen, apuntes con los puntos clave, capítulos con minutos y tres preguntas de repaso. Entran audios o vídeos y sale un documento de Google Docs listo para compartir. Para formadores online y academias que graban clases, con n8n y ffmpeg.

## Cómo usarla

1. Crea las carpetas Grabaciones y Apuntes en Drive
2. Consigue la clave de transcripción y la de la IA de texto
3. Monta el flujo en n8n con ffmpeg para el audio
4. Revisa los apuntes antes de compartirlos

## Cuándo usarla

Úsalo cuando grabes clases en Zoom, Meet o con el móvil y no tengas tiempo de sacar material escrito, que es lo que de verdad valoran los alumnos.

## Cómo ganar dinero con ella

Sacar apuntes de una clase de una hora cuesta 2 horas de trabajo. Aquí sale por unos 0,30 € de transcripción y IA, y multiplica el valor percibido del curso.

- Conversión de grabaciones en apuntes para academias y formadores online, cobrada por clase procesada.
- Paquete mensual de material de apoyo para creadores de cursos que graban sesiones semanales, por cuota.
- Plantilla de apuntes automáticos vendida a escuelas que quieren dar material escrito sin tiempo extra.

**Precio orientativo:** 40–120 € por clase grabada. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una carpeta de Drive donde sueltas las grabaciones, transcribe el audio, pide a la IA que redacte resumen, apuntes estructurados, capítulos con marcas de tiempo y preguntas de repaso, y crea un documento en Google Docs listo para compartir.
Para formadores online, academias que graban clases y creadores de contenido educativo.

## Lo que necesitas antes
- Una carpeta en Drive llamada «Grabaciones» y otra «Apuntes».
- Clave de API de OpenAI (platform.openai.com > API keys) para Whisper, o de Deepgram si prefieres.
- Clave de API de Anthropic (console.anthropic.com) o la misma de OpenAI para el nodo de IA.
- `ffmpeg` instalado si tu n8n es auto-alojado (para extraer el audio del vídeo y reducir peso). Con Docker: usa la imagen `n8nio/n8n` y añade ffmpeg, o sube directamente el audio en m4a.
- Credenciales de Google Drive y Google Docs en n8n.

## Los nodos, en orden
1) **Google Drive Trigger**. Event: File Created. Folder: «Grabaciones». Poll: cada 5 minutos.
2) **Google Drive** (File > Download). File ID: `{{ $json.id }}`. Property: `data`.
3) **Execute Command** (solo si es vídeo y tienes ffmpeg). Command: `ffmpeg -i /tmp/{{ $json.name }} -vn -ac 1 -ar 16000 -b:a 32k /tmp/audio.mp3`. Si subes ya el audio, sáltate este nodo.
4) **HTTP Request** para Whisper. Method: POST. URL `https://api.openai.com/v1/audio/transcriptions`. Authentication: Header Auth `Authorization: Bearer TU_CLAVE`. Body Content Type: `multipart/form-data`, con el campo `file` de tipo binario apuntando a `data`, el campo `model` con valor `whisper-1` y el campo `language` con valor `es`.
5) **Code** (Run Once for Each Item) para partir transcripciones muy largas:
```js
const t = $input.item.json.text || '';
const trozos = [];
const max = 12000;
for (let i = 0; i < t.length; i += max) trozos.push(t.slice(i, i + max));
return trozos.map((c, n) => ({ json: { parte: n + 1, total: trozos.length, texto: c } }));
```
6) **Basic LLM Chain** (o **HTTP Request** a la API de Claude). Prompt: «Eres profesor. A partir de esta transcripción de una clase, devuelve en Markdown: 1) Resumen en 5 líneas. 2) Apuntes con títulos y viñetas, en español de España. 3) Glosario de términos. 4) Capítulos con minuto aproximado. 5) Tres preguntas de repaso con su respuesta. Transcripción: {{ $json.texto }}».
7) **Code** que junta las partes en un solo texto si hubo troceo: `return [{ json: { doc: items.map(i => i.json.text).join('\n\n') } }];`
8) **Google Docs** (operación: Create). Title: `Apuntes - {{ $('Google Drive Trigger').item.json.name }}`. Folder: «Apuntes». Luego **Google Docs** (Update) con la acción «Insert» y el contenido `{{ $json.doc }}`.
9) **Gmail** (Send) a la lista de alumnos del curso con el enlace al documento, o **Google Sheets** (Append Row) en un registro «Materiales» si prefieres publicarlo tú.

## Cómo probarla
- Sube un audio corto de 2 minutos a «Grabaciones».
- Ejecuta y revisa la salida del nodo Whisper: si el texto viene en inglés, es que no pusiste `language=es`.
- Revisa el documento generado y ajusta el prompt del paso 6 hasta que el tono sea el tuyo. Ahí está el 80% de la calidad.

## Qué puede salir mal
- **Archivo demasiado grande**: Whisper acepta hasta 25 MB. Baja la calidad del audio con ffmpeg (`-b:a 32k` ya lo hace) o parte el archivo.
- **Nombres propios mal transcritos**: añade en el prompt una lista de términos de tu materia para que la IA los corrija.
- **Se dispara dos veces**: Drive Trigger a veces repite. Guarda el ID del archivo en una hoja y salta si ya está.
- **Alucinaciones**: pide en el prompt «no inventes nada que no esté en la transcripción; si algo no queda claro, escribe [revisar]».
- **Privacidad**: si grabas a alumnos, avisa de que se transcribe y no subas datos personales sensibles.

## Cuánto cuesta
- Whisper: unos 0,006 $ por minuto de audio. Una clase de 60 minutos, 0,36 $.
- Claude, Codex, Gemini o una IA local para el resumen: céntimos por clase.
- Drive y Docs: gratis. n8n auto-alojado: gratis.
- Alternativa gratis: transcribe con la función de subtítulos de YouTube subiendo el vídeo como oculto y descarga el .srt.
