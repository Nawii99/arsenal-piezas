# Un vídeo, cinco piezas de contenido para otras redes…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

A partir de la transcripción de cada vídeo genera automáticamente un post de LinkedIn, un carrusel de Instagram, un hilo, un email para tu lista y tres ideas de Short.

## Qué es y qué hace

Es una automatización de n8n que toma la transcripción de cada vídeo y pide a un modelo de IA (Claude, Codex, Gemini o una IA local) que la reescriba como post de LinkedIn, carrusel de Instagram, hilo, email y tres ideas de Short, dejándolo todo en una hoja lista para publicar. Entra una transcripción y sale una fila con cinco textos. Requiere credenciales de Drive y Sheets y la clave del modelo elegido.

## Cómo usarla

1. Crea la carpeta de transcripciones y la hoja de salida
2. Elige el modelo de IA y su clave
3. Revisa el tono con dos transcripciones
4. Activa el flujo para cada vídeo nuevo

## Cuándo usarla

Úsalo cuando grabes contenido bueno y luego no lo aproveches en el resto de redes porque reescribirlo te da pereza.

## Cómo ganar dinero con ella

Multiplica por cinco el alcance de cada grabación sin grabar más, y sustituye 2-3 horas de redacción semanales o los 300-500 €/mes de un copy.

- Reaprovechamiento de contenido para creadores que graban pero no publican en todas las redes.
- Pack mensual de textos para consultores que tienen vídeos sin usar.
- Automatización de contenido para agencias con clientes de formación.

**Precio orientativo:** 150–350 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Vigila una carpeta de transcripciones (los .srt o .txt que te dejó la receta de subtítulos), le pide a un modelo de IA que reescriba el contenido en cinco formatos con la estructura propia de cada red, y lo escribe todo en una hoja de cálculo lista para copiar y pegar o programar.
Para creadores, consultores y negocios que ya graban vídeo y quieren estar en más sitios sin duplicar el trabajo.

## Lo que necesitas antes
- n8n, credenciales de Google Drive y Google Sheets, clave de OpenAI.
- Una carpeta de Drive `Transcripciones` y una hoja `Reutilización` con columnas: `video`, `linkedin`, `instagram`, `hilo`, `email`, `shorts`, `estado`.
- Diez minutos para escribir tu ficha de marca (a quién te diriges, cómo hablas, qué vendes): es lo que separa un texto genérico de uno que suena a ti.

## Los nodos, en orden
1. **Google Drive Trigger** — Event `File Created`, carpeta `Transcripciones`.
2. **Google Drive** (Download File) — binario `data`.
3. **Extract from File** (Extract from Text File) — Destination Key: `texto`.
4. **Code** (limpiar el SRT y recortar):
```javascript
const bruto = $json.texto || '';
const limpio = bruto
  .replace(/^\d+$/gm, '')
  .replace(/\d{2}:\d{2}:\d{2},\d{3} --> .*$/gm, '')
  .replace(/\n{2,}/g, ' ')
  .replace(/\s+/g, ' ')
  .trim();
return [{ json: { texto: limpio.slice(0, 40000), archivo: $('Google Drive Trigger').first().json.name } }];
```
5. **OpenAI** (Message a Model) — Model `gpt-4.1` (aquí sí compensa el modelo bueno). System: pega tu ficha de marca y añade «Escribes en español de España, tuteando, sin palabras de relleno ni emojis decorativos». User:
```text
Con esta transcripción de un vídeo mío, devuelve un JSON con las claves: linkedin (post de 900-1300 caracteres, primera línea de gancho de menos de 12 palabras, párrafos de 1-2 líneas, cierre con pregunta), instagram (array de 8 objetos {diapositiva, texto} para un carrusel, máximo 20 palabras cada uno), hilo (array de 6 tuits de máximo 270 caracteres), email (asunto y cuerpo de 200-300 palabras que lleve a ver el vídeo), shorts (array de 3 objetos {titulo, gancho, minuto_aproximado}). Transcripción: {{ $json.texto }}
```
Activa `Output Content as JSON`.
6. **Code** (aplanar para la hoja):
```javascript
const d = JSON.parse($json.message.content);
return [{ json: {
  video: $('Code').first().json.archivo,
  linkedin: d.linkedin,
  instagram: d.instagram.map(s => `${s.diapositiva}. ${s.texto}`).join('\n'),
  hilo: d.hilo.join('\n\n'),
  email: `ASUNTO: ${d.email.asunto}\n\n${d.email.cuerpo}`,
  shorts: d.shorts.map(s => `${s.minuto_aproximado} — ${s.titulo}: ${s.gancho}`).join('\n'),
  estado: 'para revisar'
} }];
```
7. **Google Sheets** (Append Row) — mapea cada columna.
8. **Gmail** (Send Message) — te avisa con el enlace a la hoja: «Tienes 5 piezas nuevas para revisar».

## Cómo probarla
- Prueba con una transcripción tuya real, no con un texto inventado: solo así ves si el tono suena a ti.
- Si suena a folleto, el fallo casi siempre está en el System: añade tres frases tuyas de ejemplo y prohíbe expresiones («en el mundo actual», «desbloquea», «potenciar»).

## Qué puede salir mal
- **Textos larguísimos**: si la transcripción pasa de 40.000 caracteres, el corte del Code lo resuelve, pero pierdes el final; mejor divide el vídeo en dos.
- **JSON inválido**: pon el `JSON.parse` en try/catch y, si falla, guarda la respuesta cruda en la hoja para no perder el trabajo.
- **Celdas de Sheets**: el límite es 50.000 caracteres por celda, no lo vas a tocar, pero los saltos de línea sí requieren que el valor vaya entre comillas (n8n lo hace solo).
- **Publicación automática**: no la actives. Revisa siempre antes de publicar; un dato inventado en LinkedIn te cuesta la reputación.

## Cuánto cuesta
- Unos 0,05-0,15 € por vídeo con un modelo grande, menos de 0,03 € con uno pequeño.
- Drive, Sheets, Gmail y n8n auto-alojado: 0 €.
