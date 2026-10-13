# Reciclaje de cada clase grabada en cinco piezas de cont…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Coge la grabación de tu clase o webinar, saca la transcripción y te devuelve resumen con minutajes, apuntes en PDF para los alumnos y cinco publicaciones para redes.

## Qué es y qué hace

Detecta una grabación nueva en la carpeta, extrae el audio, la transcribe con Whisper y pide a una IA de texto (Claude, Codex, Gemini o una IA local) un índice con minutos, un resumen de apuntes, cinco publicaciones para redes y tres dudas de clase. Entran vídeos y salen textos en una página de Notion. Para formadores y creadores que graban webinars y quieren reutilizar cada clase, con n8n y ffmpeg.

## Cómo usarla

1. Carga las grabaciones en la carpeta de entrada
2. Configura la transcripción y la IA de texto en n8n
3. Define el tono de cada red
4. Revisa las publicaciones antes de programarlas

## Cuándo usarla

Úsalo si ya grabas clases o directos y ese vídeo se queda muerto en Drive, cuando podría estar dándote contenido y material de apoyo cada semana.

## Cómo ganar dinero con ella

Sustituye entre 3 y 4 horas semanales de edición, resumen y redacción de posts. A 30 euros la hora son unos 400 euros al mes.

- Reciclaje de grabaciones en contenido para formadores y creadores, cobrado por clase procesada.
- Paquete mensual de publicaciones y apuntes para academias que graban cada semana, por cuota.
- Plantilla de reutilización vendida a profesionales que hablan en webinars y necesitan presencia en redes.

**Precio orientativo:** 50–150 € por clase. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Detecta un vídeo nuevo en la carpeta de grabaciones, extrae el audio, lo transcribe con Whisper y con esa transcripción genera cuatro cosas de una tacada: un índice con minutos y temas, un resumen de apuntes para los alumnos, cinco posts (dos LinkedIn, dos Instagram, uno X) y las tres dudas que salieron en clase. Todo aterriza en una página de Notion.

## Lo que necesitas antes
- n8n instalado, preferiblemente auto-alojado con `ffmpeg` disponible en el contenedor (imagen `n8nio/n8n` más `apk add ffmpeg`, o un contenedor aparte).
- Credencial Google Drive OAuth2.
- Clave de OpenAI (Whisper para transcribir, `gpt-4.1-mini` para redactar).
- Integración de Notion: notion.so/my-integrations > New integration > copia el token interno, y comparte tu base de datos `Clases` con esa integración.
- Base de Notion `Clases` con propiedades: `Título`, `Fecha`, `Curso`, `Estado`.

## Los nodos, en orden
1. **Google Drive Trigger** — `File Created` en la carpeta `Grabaciones`, cada hora.
2. **Google Drive** (`Download`) — el vídeo.
3. **Execute Command** — `ffmpeg -i /tmp/{{ $json.fileName }} -vn -ac 1 -ar 16000 -b:a 32k /tmp/audio.mp3`. Si tu n8n no permite comandos, sáltatelo y sube directamente audios en vez de vídeos.
4. **Read/Write Files from Disk** (operación `Read`) — `/tmp/audio.mp3`.
5. **OpenAI** (recurso `Audio`, operación `Transcribe a Recording`) — modelo `whisper-1`, idioma `es`.
6. **Code** — trocea la transcripción si pasa de 40.000 caracteres y añade marcas de tiempo aproximadas. Código abajo.
7. **OpenAI** (`Message a Model`) — modelo `gpt-4.1-mini`, prompt abajo, Output as JSON.
8. **Notion** (operación `Create Database Page`) — base `Clases`, título `{{ $json.titulo }}`, y en el cuerpo bloques con el índice, los apuntes y los posts.
9. **Google Drive** (`Upload`) opcional — guarda la transcripción en `.txt` junto al vídeo.

## El prompt del nodo OpenAI (paso 7)
```
Eres el ayudante de un formador. A partir de esta transcripción de una clase en español devuelve JSON:
{
 "titulo": "título claro de la clase",
 "indice": [{"minuto": "MM:SS", "tema": "..."}],
 "apuntes": "resumen en markdown de 500-700 palabras con los conceptos, ejemplos y pasos, en el orden de la clase",
 "dudas": ["las 3 preguntas que hicieron o que se quedaron en el aire"],
 "posts": [{"red": "linkedin|instagram|x", "texto": "..."}]
}
Usa solo lo que aparece en la transcripción. No inventes datos ni cifras. Tono directo, tuteando, español de España.
```

## El código del nodo Code (paso 6)
```javascript
const t = $json.text || '';
const limite = 40000;
const texto = t.length > limite ? t.slice(0, limite) + '\n[...transcripción recortada...]' : t;
return [{ json: { texto, caracteres: t.length, minutos_aprox: Math.round(t.split(' ').length / 130) } }];
```

## Cómo probarla
- Empieza con un vídeo de 5 minutos, no con uno de dos horas: verás el resultado en un minuto y ajustas el prompt barato.
- Comprueba que la transcripción respeta el vocabulario de tu sector; si no, añade al prompt de Whisper un campo `prompt` con tus 10 palabras técnicas.
- Lee los apuntes antes de publicarlos: la IA a veces se inventa un ejemplo que tú no diste.

## Qué puede salir mal
- **Whisper y el límite de 25 MB por archivo**: por eso el audio se comprime a mono 32 kbps. Una clase de 2 horas cabe. Si no, córtalo con ffmpeg en trozos de 20 minutos y concatena las transcripciones.
- **Sin ffmpeg**: usa n8n Cloud con audios ya extraídos, o graba directamente en audio.
- **Minutajes inventados**: Whisper devuelve segmentos con tiempo si pides `verbose_json`; si usas texto plano, el índice será aproximado. Dilo a tus alumnos o pide el formato con timestamps.
- **Notion y bloques largos**: cada bloque de texto admite 2.000 caracteres. Trocea los apuntes en párrafos antes de enviarlos.

## Cuánto cuesta
- Whisper: unos 0,006 dólares por minuto de audio. Una clase de 90 minutos, unos 0,50 euros.
- `gpt-4.1-mini` para la redacción: menos de 0,05 euros por clase.
- Notion: gratis en plan personal. n8n auto-alojado: 0 euros.
- Cuatro clases al mes: unos 2,50 euros.
