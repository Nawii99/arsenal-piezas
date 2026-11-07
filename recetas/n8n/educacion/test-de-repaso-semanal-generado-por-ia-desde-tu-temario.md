# Test de repaso semanal generado por IA desde tu temario…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Cada semana genera un cuestionario nuevo a partir del tema que toca, lo publica y lo manda a los alumnos, sin que tengas que escribir preguntas nunca más.

## Qué es y qué hace

Cada lunes toma el tema de la semana desde una hoja de calendario, pide a una IA de texto (Claude, Codex, Gemini o una IA local) diez preguntas tipo test con cuatro opciones, respuesta y explicación, las guarda en un banco de preguntas y envía el enlace a los alumnos. Entran temarios de Google Docs y salen cuestionarios y correos. Para academias de oposiciones, idiomas y formación continua, con n8n.

## Cómo usarla

1. Organiza el temario por semanas en Docs y en una hoja
2. Conecta la IA de texto en n8n
3. Revisa las preguntas del primer mes
4. Envía el enlace a la lista de alumnos

## Cuándo usarla

Úsalo cuando quieras que tus alumnos repasen sin que te cueste horas preparar preguntas: oposiciones, idiomas, certificaciones o formación continua.

## Cómo ganar dinero con ella

Escribir 20 preguntas buenas cuesta unas 2 horas semanales. Al año son 100 horas. El coste en IA no llega a 5 € al año.

- Montaje de repaso semanal con preguntas generadas desde el temario de academias de oposiciones, por temario.
- Mantenimiento mensual del banco de preguntas y revisión de cada lote para formadores, por cuota.
- Plantilla de test semanal vendida a escuelas de idiomas que quieren un producto de repaso.

**Precio orientativo:** 150–300 € por temario. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Los lunes coge el tema de la semana desde tu documento de temario, pide a la IA 10 preguntas tipo test con cuatro opciones, respuesta correcta y explicación, las guarda en una hoja y manda el enlace a los alumnos.
Para academias de oposiciones, escuelas de idiomas, formación de certificaciones y profesores de refuerzo.

## Lo que necesitas antes
- El temario en Google Docs, un documento por tema, dentro de una carpeta «Temario».
- Una hoja «Calendario» con: semana | tema | doc_id | enviado
- Una hoja «Banco preguntas» con: fecha | tema | pregunta | a | b | c | d | correcta | explicacion
- Clave de API de Anthropic (console.anthropic.com) u OpenAI, guardada en una credencial de n8n.
- Una lista de emails de alumnos en una hoja «Alumnos».

## Los nodos, en orden
1) **Schedule Trigger**. Cron `0 7 * * 1`. Timezone Europe/Madrid.
2) **Google Sheets** (Get Row(s)) sobre «Calendario» con filtro `enviado` igual a vacío. Añade después un **Limit** con Max Items 1 para coger solo el tema de esta semana.
3) **Google Docs** (operación: Get). Doc ID: `{{ $json.doc_id }}`. Devuelve el contenido del tema.
4) **Code** (Run Once for Each Item) que limpia y recorta el texto:
```js
const c = $input.item.json.content || [];
let txt = JSON.stringify(c).replace(/\\n/g, ' ');
txt = txt.replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').slice(0, 20000);
return { json: { tema: $('Google Sheets').item.json.tema, texto: txt } };
```
5) **HTTP Request** a la IA. Method POST. URL `https://api.anthropic.com/v1/messages`. Authentication: Generic Credential Type > Header Auth, con una credencial cuyo Name es `x-api-key` y cuyo Value es tu clave de Anthropic (la clave va en la credencial; no la escribas en el nodo: un flujo exportado se llevaría la clave). Headers: `anthropic-version: 2023-06-01`, `content-type: application/json`. Body:
```json
{"model":"claude-sonnet-5-5","max_tokens":3000,"messages":[{"role":"user","content":"Eres profesor de oposiciones en España. A partir del texto, escribe 10 preguntas tipo test de dificultad media-alta. Devuelve SOLO un array JSON, sin texto alrededor, con objetos {pregunta, a, b, c, d, correcta, explicacion}. La correcta es la letra. La explicación, dos frases. Texto: {{ $json.texto }}"}]}
```
6) **Code** que parsea la respuesta y la convierte en filas:
```js
const raw = $input.first().json.content[0].text;
const limpio = raw.slice(raw.indexOf('['), raw.lastIndexOf(']') + 1);
const arr = JSON.parse(limpio);
const tema = $('Code').first().json.tema;
const hoy = new Date().toISOString().slice(0,10);
return arr.map(p => ({ json: { fecha: hoy, tema, ...p } }));
```
7) **Google Sheets** (Append Row) en «Banco preguntas», mapeando todos los campos.
8) **Code** que arma un HTML con las 10 preguntas para el email (sin las respuestas) y otro bloque con el solucionario que va al final, plegado.
9) **Google Sheets** (Get Row(s)) sobre «Alumnos» y **Gmail** (Send) con Bcc a la lista, asunto `Test de repaso: {{ $json.tema }}`.
10) **Google Sheets** (Update Row) en «Calendario» poniendo `enviado` = `{{ $now.format('yyyy-MM-dd') }}`.

## Cómo probarla
- Ejecuta a mano un lunes cualquiera con un tema corto.
- Mira la salida del nodo 6: si peta el `JSON.parse`, es que la IA ha metido texto de más. Añade al prompt «responde únicamente con el array, sin ```json ni explicaciones».
- Contesta tú el test y verifica dos o tres preguntas contra el temario antes de mandarlo a nadie la primera vez.

## Qué puede salir mal
- **Preguntas inventadas**: la IA puede salirse del temario. En el prompt exige «solo con información contenida en el texto». Revisa el primer mes.
- **Documento muy largo**: recorta a 20.000 caracteres o parte el tema en dos llamadas.
- **JSON roto**: envuelve el `JSON.parse` en un try/catch y manda un email de aviso si falla, en vez de que el flujo muera en silencio.
- **Preguntas repetidas semana a semana**: pásale en el prompt las últimas 20 preguntas del banco para que no repita.
- **Límite de tokens**: si usas un modelo pequeño, baja a 5 preguntas por llamada y encadena dos.

## Cuánto cuesta
- Claude Sonnet: unos 0,05 € por test de 10 preguntas. 52 semanas al año son menos de 3 €.
- Con Claude, Codex, Gemini o una IA local baja a céntimos, con algo menos de calidad.
- Google y n8n auto-alojado: gratis.
