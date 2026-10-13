# De clase grabada a resumen, minutado y ficha de repaso…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Flujo de n8n que coge una grabación de clase de una carpeta de Drive, la transcribe con Whisper y devuelve un resumen con puntos clave, un minutado por temas con el minuto exacto, los deberes detectados y ocho preguntas de repaso.

## Qué es y qué hace

Flujo de n8n que coge una grabación de clase de una carpeta de Drive, la transcribe con Whisper y devuelve un resumen con puntos clave, un minutado por temas con el minuto exacto, los deberes detectados y ocho preguntas de repaso. Guarda todo en un Google Doc y envía el enlace a la lista de la clase. Entra el vídeo o audio; sale el documento.

## Cómo usarla

1. Crea la carpeta de grabaciones en Drive
2. Transcribe con Whisper y genera el resumen con Claude, Codex, Gemini o una IA local
3. Revisa el minutado con una clase de prueba
4. Envía el enlace a la lista de alumnos

## Cuándo usarla

Úsalo cuando grabas las clases pero nadie se las vuelve a ver porque son de 90 minutos y no hay por dónde entrar.

## Cómo ganar dinero con ella

Ahorra la hora larga que cuesta resumir y minutar cada sesión, y reduce las preguntas repetidas por privado. Con 8 clases al mes son 8 horas recuperadas.

- Ficha de repaso para bootcamps y clases de idiomas con sesiones largas y alumnos ausentes.
- Resúmenes de sesiones para formación de empresa que quiere dejar memoria de cada clase.
- Minutado y apuntes para creadores de cursos que graban sesiones de hora y media.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Dejas el vídeo o el audio de la clase en una carpeta de Drive. El flujo lo transcribe con Whisper, saca un resumen estructurado, el minutado por bloques (con el minuto exacto para saltar), los deberes o tareas que mencionaste y 8 preguntas de repaso. Lo guarda en un Google Doc y manda el enlace a la lista de la clase.
Ideal para bootcamps, clases de idiomas y formación de empresa donde siempre falta alguien.

## Lo que necesitas antes
- Carpeta de Drive `Clases grabadas` (Zoom y Meet pueden guardar ahí automáticamente).
- Credenciales de Google Drive, Google Docs y Gmail en n8n.
- Clave de OpenAI (Whisper para transcribir, `gpt-4o-mini` para resumir).
- Una hoja `Listas` con los emails por grupo, o un alias de correo por clase.
- Si tus vídeos pesan más de 25 MB (casi todos), necesitas `ffmpeg` instalado en el servidor de n8n para extraer el audio y comprimirlo.

## Los nodos, en orden
1) **Google Drive Trigger** — Event: File Created, Folder `Clases grabadas`, Poll Every Hour.
2) **Google Drive** (Download File).
3) **Execute Command** — Command: `ffmpeg -i /tmp/entrada -vn -ac 1 -ar 16000 -b:a 32k /tmp/salida.mp3`. Antes, con un nodo **Read/Write Files from Disk** (Operation: Write) guardas el binario en `/tmp/entrada`. Con 32 kbps mono, 90 minutos ocupan unos 21 MB y entran en el límite de Whisper.
4) **Read/Write Files from Disk** (Operation: Read) — File `/tmp/salida.mp3`.
5) **OpenAI** (Resource: Audio, Operation: Transcribe a Recording) — Model `whisper-1`, Language `es`, Input Binary Field `data`.
6) **OpenAI** (Message a Model) — Model `gpt-4o-mini`, Max Tokens 2000. System: «Eres el ayudante de un formador español. Con la transcripción de una clase devuelve en Markdown: 1) Resumen en 8 líneas. 2) Índice con marcas de tiempo aproximadas por bloque temático. 3) Conceptos clave con una definición de una línea. 4) Tareas o deberes mencionados. 5) Ocho preguntas de repaso con su respuesta. Tutea y usa español de España.» User: `{{ $json.text }}`.
7) **Google Docs** (Operation: Create) — Title `Clase {{ $('Google Drive Trigger').item.json.name }}`, Folder la del curso. Luego un segundo **Google Docs** (Operation: Update, Action: Insert) con el texto generado.
8) **Google Drive** (Operation: Share) — File el Doc, Permissions: Role Reader, Type Anyone with the link.
9) **Google Sheets** (Get Rows) — hoja `Listas`, filtrando por el grupo.
10) **Gmail** (Send Message) — Bcc con todos los emails (`{{ $json.emails.join(',') }}`), Subject `Resumen y repaso de la clase de hoy`, con el enlace al Doc y el resumen pegado en el cuerpo.

## El código si prefieres montar tú la lista de correos
```js
const correos = items.map(i => i.json.email).filter(e => e && e.includes('@'));
return [{ json: { emails: [...new Set(correos)] } }];
```

## Cómo probarla
- Empieza con un audio de 5 minutos grabado con el móvil. Si la transcripción sale en inglés, es que faltó el campo Language.
- Comprueba el comando de ffmpeg a mano en el terminal del servidor antes de meterlo en n8n; el 90% de los fallos están ahí.
- Antes de mandarlo a los alumnos, revisa un par de minutados: Whisper no da marcas de tiempo exactas salvo que pidas formato `verbose_json`, así que el índice es orientativo.

## Qué puede salir mal
- **Archivo mayor de 25 MB**: es el límite de Whisper. La compresión del paso 3 lo resuelve; si aun así te pasas, parte el audio con `ffmpeg -f segment -segment_time 1800`.
- **Falta ffmpeg**: en n8n Cloud no puedes usar Execute Command. Solución: auto-alojado, o comprime el audio con la propia grabadora de Zoom (guardar solo audio).
- **Nombres propios mal transcritos**: pásale un glosario en el prompt del paso 6 («Estos términos se escriben así: ...»).
- **Privacidad**: si en clase se oyen nombres y dudas de alumnos, avisa al grupo de que la sesión se transcribe.

## Cuánto cuesta
- Whisper: 0,006 $ por minuto, unos 0,50 € por clase de 90 minutos.
- Resumen con `gpt-4o-mini`: 2 o 3 céntimos.
- Drive, Docs y Gmail: gratis. n8n auto-alojado: gratis. Total, menos de 5 € al mes con 8 clases.
