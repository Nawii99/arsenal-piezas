# Notas de voz del móvil convertidas en tareas y notas or…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Grabas un audio andando por la calle, se lo mandas al bot de Telegram y aparece transcrito, resumido y repartido entre tus tareas, tus notas o tu lista de la compra.

## Qué es y qué hace

Receta de n8n que recibe una nota de voz en un bot de Telegram y la transcribe con Whisper. Una IA decide si es una tarea, una idea, una nota de reunión o una cita, la guarda en la base de Notion que corresponde y, si hay una fecha, crea el evento en Google Calendar. Entrada: audio. Salida: entrada clasificada y confirmación en el chat para corregirla. Útil para comerciales, instaladores o consultores fuera de la oficina.

## Cómo usarla

1. Crea el bot y conecta Whisper, Notion y Calendar
2. Graba una nota de prueba y corrige la clasificación
3. Usa el flujo a diario

## Cuándo usarla

Úsalo cuando se te ocurren cosas fuera de la oficina y las pierdes, o cuando acabas una reunión o una visita y no te apetece escribir el resumen.

## Cómo ganar dinero con ella

Recupera las ideas y los compromisos que se olvidaban. Sustituye 20-30 minutos diarios de pasar notas a limpio por hablar 40 segundos.

- Resumen de visitas para un comercial que hace rutas por la zona…
- Notas de obra para un instalador o un reformista…
- Captura de ideas para un consultor que va de cliente en cliente…

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Mandas una nota de voz al bot. n8n la transcribe con Whisper, la IA decide si es una tarea, una idea, una nota de reunión o una cita, y la guarda en la base de Notion que corresponde. Si detecta una fecha, además crea el evento en Google Calendar.
Te responde en el chat con lo que ha entendido para que puedas corregirlo al momento.
Es para cualquiera que trabaje fuera de un escritorio: comerciales, instaladores, gente de obra, consultores.

## Lo que necesitas antes
n8n.
Bot de Telegram con su token.
Clave de OpenAI (usa Whisper para transcribir y gpt-4o-mini para clasificar).
Cuenta de Notion con una base de datos «Capturas» con propiedades: Titulo (title), Tipo (select: tarea, idea, reunion, compra), Texto (rich text), Fecha (date), Estado (select).
La integración de Notion: notion.so/my-integrations, crea una integración interna, copia el Internal Integration Token y en la base de datos pulsa los tres puntos, Conexiones, y añádela.
Google Calendar conectado con OAuth (opcional).

## Los nodos, en orden
1. «Telegram Trigger». Updates: message. Activa Download File en Options.
2. «IF». Condición: {{ $json.message.voice }} existe o {{ $json.message.audio }} existe.
3. «OpenAI» (Transcribe a Recording). Modelo whisper-1. Input: los datos binarios del trigger. Language: es.
4. «OpenAI» (Message a model), gpt-4o-mini, salida JSON. Prompt: «Analiza esta nota de voz de un profesional. Devuelve JSON con: tipo (tarea|idea|reunion|compra), titulo (máximo 8 palabras), texto (el contenido reescrito con puntuación y ordenado, sin muletillas), fecha (AAAA-MM-DD si se menciona una fecha o un día de la semana, si no cadena vacía), hora (HH:MM o vacío), personas (array de nombres citados). Hoy es {{ $now.format('yyyy-MM-dd') }} y es {{ $now.format('cccc') }}. Transcripción: {{ $json.text }}».
5. «Code» (arreglar el JSON y las fechas). Código completo:
```js
let raw = $input.first().json.content || '{}';
raw = raw.replace(/```json/g, '').replace(/```/g, '').trim();
let d;
try { d = JSON.parse(raw); } catch (e) { d = { tipo: 'idea', titulo: 'Nota sin clasificar', texto: raw, fecha: '', hora: '', personas: [] }; }
if (d.fecha && !/^\d{4}-\d{2}-\d{2}$/.test(d.fecha)) d.fecha = '';
d.tieneCita = Boolean(d.fecha && d.hora);
d.inicioISO = d.tieneCita ? d.fecha + 'T' + d.hora + ':00' : '';
return [{ json: d }];
```
6. «Notion» (Create a database page). Base «Capturas». Titulo, Tipo, Texto y Fecha mapeados desde el Code. Estado: «pendiente».
7. «IF» (tieneCita es true) → «Google Calendar» (Create Event). Start {{ $json.inicioISO }}, duración 60 minutos, título {{ $json.titulo }}, descripción {{ $json.texto }}. En el nodo pon Timezone Europe/Madrid.
8. «Telegram» (Send Message): «📝 {{ $json.tipo }} · {{ $json.titulo }} — guardado en Notion{{ $json.tieneCita ? ' y en el calendario el ' + $json.fecha + ' a las ' + $json.hora : '' }}».

## Cómo probarla
Grábate diciendo tres cosas distintas: «recuérdame llamar a Marta el jueves a las diez», «se me ha ocurrido una idea para la web» y «comprar folios y tinta». Comprueba que cada una cae en su tipo y que solo la primera crea evento.
Prueba también un audio largo de dos minutos hablando rápido, para ver si la transcripción aguanta.

## Qué puede salir mal
Whisper transcribe mal los nombres propios y las marcas. Puedes pasarle un «prompt» con tu vocabulario habitual en las opciones del nodo.
Los audios de más de 25 MB los rechaza la API. Una nota de voz normal pesa mucho menos, pero si grabas media hora tendrás que trocearla.
«El jueves» se interpreta mal si el workflow tiene otra zona horaria. Fija Europe/Madrid en Settings del workflow y pásale la fecha de hoy en el prompt, como hace la receta.
Si Notion devuelve error 404 es que no has conectado la integración a esa base concreta: es el fallo número uno.
No mandes por aquí datos sensibles de clientes sin pensarlo: el audio pasa por OpenAI.

## Cuánto cuesta
n8n autoalojado (Community Edition), Telegram y Notion: gratis. Google Calendar: gratis. n8n Cloud solo tiene prueba gratuita temporal y después es de pago.
Whisper: 0,006 $ por minuto de audio, o sea unos 0,20 € al mes si grabas 30 minutos. gpt-4o-mini: céntimos.
