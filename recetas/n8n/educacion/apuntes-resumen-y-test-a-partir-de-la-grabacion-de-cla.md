# Apuntes, resumen y test a partir de la grabación de cla…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Sube la grabación de tu clase a una carpeta de Drive y en unos minutos tienes la transcripción, un resumen con marcas de tiempo, los apuntes en documento y un test de 10 preguntas.

## Qué es y qué hace

Flujo de n8n que vigila una carpeta de Google Drive y transcribe cada grabación nueva de clase. Con la transcripción genera un resumen por bloques, unos apuntes en documento y un cuestionario de diez preguntas, lo guarda en Drive y avisa por email. Entra el audio o vídeo y la carpeta de salida; sale el material de estudio.

## Cómo usarla

1. Crea las carpetas de entrada y de material en Drive
2. Conecta la transcripción y el modelo de texto (Claude, Codex, Gemini o una IA local)
3. Prueba con una grabación de diez minutos
4. Revisa el resumen antes de compartirlo

## Cuándo usarla

Cuando grabas clases o webinars y no tienes tiempo de convertirlos en material de estudio.

## Cómo ganar dinero con ella

Sustituye 3-4 horas de trabajo por cada clase de una hora. Con 4 clases al mes recuperas más de media jornada semanal.

- Material de repaso para academias que graban clases y quieren reaprovecharlas.
- Conversión de webinars en apuntes y tests para formadores que venden cursos grabados.
- Producción de resúmenes para empresas que documentan formaciones internas.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Vigila una carpeta de Drive, transcribe cada grabación nueva, y con esa transcripción genera un resumen por bloques, unos apuntes en formato documento y un cuestionario de repaso, todo guardado en Drive y avisado por email.
Es para profesores, formadores y creadores de cursos que ya graban pero no reaprovechan.

## Lo que necesitas antes
n8n (mejor auto-alojado: los archivos de audio pesan, y n8n Cloud solo tiene una prueba gratuita temporal y después es de pago, con límites de ejecuciones y memoria).
Carpeta en Drive «Grabaciones entrada» y otra «Material generado». Anota los dos IDs.
Credencial Google OAuth2 con Drive, Docs y Gmail. Activa la API de Google Docs en tu proyecto de Google Cloud.
API key de OpenAI (platform.openai.com) para Whisper y para el modelo de texto.
Recomendado: ffmpeg instalado en el servidor de n8n para extraer el audio del vídeo y bajar el peso.

## Los nodos, en orden
**1. Google Drive Trigger**. Evento: «File Created» en la carpeta «Grabaciones entrada». Poll: cada 15 minutos.
**2. Google Drive** «Descargar». Operación: «Download», File ID: `{{ $json.id }}`.
**3. Execute Command** (opcional pero recomendable). Comando: `ffmpeg -y -i /tmp/entrada.mp4 -vn -ac 1 -ar 16000 -b:a 32k /tmp/salida.mp3`. Antes escribe el binario a disco con un nodo **Read/Write Files from Disk**. Esto convierte una clase de 800 MB en un audio de 15 MB.
**4. Code** «Trocear si hace falta». Whisper acepta hasta 25 MB por petición. Si el audio es mayor, usa ffmpeg con `-f segment -segment_time 900` para partirlo en trozos de 15 minutos y luego un **Loop Over Items**.
**5. OpenAI** «Transcribe a Recording». Resource: Audio, Operation: Transcribe. Model: `whisper-1`. Language: `es`. Input Data Field Name: `data`.
**6. Aggregate**. Une los trozos de transcripción en un único campo `transcripcion` con `Concatenate`.
**7. OpenAI** «Message a Model» (resumen). Model: `gpt-4o-mini`. Sistema: «Eres el ayudante de un profesor. A partir de la transcripción de una clase, devuelve: 1) un resumen ejecutivo de 150 palabras, 2) los 6 bloques temáticos con su minuto aproximado de inicio, 3) los 10 conceptos clave con su definición en una línea, 4) tres ejercicios prácticos. Escribe en español de España, tuteando, en Markdown.» Usuario: `{{ $json.transcripcion }}`.
**8. OpenAI** «Message a Model» (test). Sistema: «Genera 10 preguntas tipo test de 4 opciones sobre esta clase, con la respuesta correcta marcada y una explicación de una línea. Devuelve solo Markdown.» Usuario: la misma transcripción.
**9. Google Docs** «Crear apuntes». Operación: «Create», Title: `Apuntes - {{ $('Google Drive Trigger').item.json.name }}`, Folder: «Material generado». Después un segundo nodo **Google Docs** con «Update» e insertText para volcar el contenido.
**10. Google Docs** «Crear test». Igual que el anterior con el resultado del nodo 8.
**11. Google Drive** «Guardar transcripción». Sube la transcripción completa como archivo .txt en la misma carpeta.
**12. Gmail**. To: tu email y el del grupo de alumnos. Subject: `Material de la clase {{ $json.name }} listo`. Cuerpo con los tres enlaces.

## El trozo de código
Nodo **Code** para limpiar la transcripción antes de mandarla al modelo, modo «Run Once for Each Item»:
```javascript
let t = $input.item.json.text || '';
t = t.replace(/\b(eh|em|o sea|¿vale\?|vale)\b/gi, '');
t = t.replace(/\s{2,}/g, ' ').trim();
const palabras = t.split(' ').length;
return { json: { transcripcion: t, palabras, minutos_aprox: Math.round(palabras / 130) } };
```

## Cómo probarla
Empieza con una grabación corta, de 10 minutos. Comprueba que la transcripción reconoce bien los términos técnicos de tu materia.
Si el vocabulario específico sale mal, añade en el nodo de Whisper el campo «Prompt» con una lista de tus términos: eso guía al modelo.
Lee el test generado antes de dárselo a nadie: la IA a veces inventa una opción correcta ambigua.

## Qué puede salir mal
Archivos de más de 25 MB: Whisper los rechaza. De ahí el paso de ffmpeg y el troceo.
Si no puedes instalar ffmpeg (n8n.cloud), graba directamente en audio o usa la grabación de audio de Zoom, que ya viene en M4A ligero.
Whisper mezcla voces cuando hablan alumnos y profesor a la vez; avisa en el resumen de que es una transcripción automática.
Ojo con la privacidad: si en la clase se oyen nombres o datos de alumnos, no publiques la transcripción en abierto.
La API de Docs falla si el texto supera cierto tamaño en una sola petición; parte el volcado en bloques de 10.000 caracteres con un **Loop Over Items**.

## Cuánto cuesta
Whisper: 0,006 $ por minuto de audio, unos 0,33 $ por clase de una hora.
gpt-4o-mini para resumen y test: menos de 0,05 $ por clase.
n8n auto-alojado, Drive, Docs y Gmail: 0 €.
Cuatro clases al mes salen por menos de 1,5 €.
