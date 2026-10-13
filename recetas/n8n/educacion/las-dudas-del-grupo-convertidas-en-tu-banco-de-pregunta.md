# Las dudas del grupo convertidas en tu banco de pregunta…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Recoge lo que preguntan tus alumnos en el grupo de Telegram, agrupa las dudas que se repiten y te dice cuáles merecen una lección nueva o una FAQ en la web.

## Qué es y qué hace

Escucha un grupo de Telegram de alumnos, guarda los mensajes que son preguntas y cada domingo los agrupa por tema con una IA de texto (Claude, Codex, Gemini o una IA local). Envía un informe con las cinco dudas más repetidas y una respuesta propuesta para la FAQ o un vídeo. Si una pregunta ya está en la FAQ, el bot responde con el enlace. Entran mensajes y salen informes semanales, con n8n y un bot de Telegram.

## Cómo usarla

1. Crea el bot con BotFather y añádelo al grupo
2. Desactiva el modo privacidad del bot
3. Programa el informe dominical en n8n
4. Que lo revise un profesional

## Cuándo usarla

Úsalo si contestas la misma pregunta cada semana en el grupo y no tienes forma de saber cuáles son las tres que más se repiten en todo el año.

## Cómo ganar dinero con ella

Cada duda repetida convertida en FAQ o en vídeo corto quita entre 10 y 20 mensajes al mes de soporte, y te da material de contenido gratis.

- Análisis de dudas del grupo para academias que quieren saber qué lección reforzar, entregado como informe mensual.
- Bot de FAQ para grupos de alumnos que responde preguntas repetidas, cobrado por instalación.
- Paquete de análisis de comunidad para creadores de cursos, cobrado por cuota.

**Precio orientativo:** 150–300 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Escucha el grupo de alumnos, guarda solo los mensajes que son preguntas y cada domingo los agrupa por tema con IA. Te manda un informe con las 5 dudas más repetidas de la semana, cuántas veces salió cada una, y una propuesta de respuesta que puedes pegar en tu FAQ o convertir en vídeo. Además, si una pregunta ya está en tu FAQ, el bot responde en el grupo con el enlace al momento.

## Lo que necesitas antes
- n8n instalado.
- Bot de Telegram creado con @BotFather, añadido a tu grupo como administrador y con **Group Privacy desactivado** (`/setprivacy` en BotFather > Disable), o el bot no ve los mensajes.
- Credencial Telegram en n8n con el token.
- Google Sheet `Dudas` con: `fecha`, `usuario`, `mensaje`, `tema`.
- Google Sheet `FAQ` con: `pregunta`, `respuesta`, `url`, `palabras_clave`.
- Clave de OpenAI.

## Los nodos, en orden
1. **Telegram Trigger** — evento `Message`. En Additional Fields, activa que reciba mensajes de grupo.
2. **Code** — filtra: solo mensajes que acaben en `?` o empiecen por qué, cómo, cuándo, dónde, por qué, se puede, alguien sabe. Código abajo.
3. **Google Sheets** (`Append Row`) — hoja `Dudas`.
4. **Google Sheets** (`Get Row(s)`) sobre `FAQ` y **Code** que busca coincidencia de palabras clave.
5. **IF** — si hay coincidencia > **Telegram** (`Send Message`) respondiendo en el hilo: `Esto lo tienes resuelto aquí: {{ $json.url }}`, con `Reply To Message ID`.
6. Flujo B semanal: **Schedule Trigger** `0 18 * * 0`, timezone `Europe/Madrid`.
7. **Google Sheets** (`Get Row(s)`) sobre `Dudas`, **Filter** por fecha de los últimos 7 días.
8. **Code** — junta todos los mensajes en un solo texto numerado.
9. **OpenAI** (`Message a Model`) — modelo `gpt-4.1-mini`, prompt abajo, Output as JSON.
10. **Telegram** (`Send Message`) a tu chat privado con el informe formateado, y **Google Sheets** (`Append Row`) en una hoja `Informes` para el histórico.

## El código del nodo Code (paso 2)
```javascript
const m = $json.message || {};
const texto = (m.text || '').trim();
if (!texto) return [];
const arranques = /^(que|qué|como|cómo|cuando|cuándo|donde|dónde|por que|por qué|se puede|alguien sabe|duda|hay alguna forma)/i;
const esPregunta = texto.endsWith('?') || arranques.test(texto.normalize('NFD').replace(/[̀-ͯ]/g,''));
if (!esPregunta || texto.length < 15) return [];
return [{ json: {
  fecha: $now.format('yyyy-MM-dd HH:mm'),
  usuario: m.from ? (m.from.first_name || m.from.username || 'anon') : 'anon',
  mensaje: texto,
  chat_id: m.chat.id,
  message_id: m.message_id
} }];
```

## El prompt del nodo OpenAI
```
Te paso las preguntas que han hecho esta semana los alumnos de un curso. Agrúpalas por tema real (aunque estén escritas de forma distinta) y devuelve JSON:
{"temas":[{"tema":"nombre corto","veces":n,"ejemplos":["cita 1","cita 2"],"respuesta_propuesta":"3-5 frases claras","accion":"faq|video|arreglar leccion"}]}
Ordena de más repetido a menos y devuelve como mucho 5 temas. Español de España, tuteando. No inventes preguntas que no estén.
```

## Cómo probarla
- Escribe cuatro mensajes en el grupo: dos preguntas y dos comentarios normales. Solo las preguntas deben aparecer en la hoja.
- Mete en `FAQ` una entrada con la palabra clave `factura` y pregunta en el grupo `¿me podéis dar factura?`: el bot debe responder con el enlace.
- Ejecuta el flujo semanal a mano con datos de una semana real y comprueba que los temas tienen sentido.

## Qué puede salir mal
- **El bot no ve nada**: casi siempre es el Group Privacy activado. Desactívalo en BotFather y saca y vuelve a meter el bot en el grupo.
- **Bot pesado**: si responde a todo, molesta. Exige coincidencia de dos palabras clave, no una, y limita a una respuesta automática por usuario y día.
- **Privacidad**: avisa en las normas del grupo de que las dudas se recopilan para mejorar el curso. Guarda el nombre, no el teléfono.
- **Mensajes largos de Telegram**: el límite es 4.096 caracteres. Trocea el informe si te pasas.

## Cuánto cuesta
- Telegram: gratis y sin límites prácticos.
- OpenAI: una llamada semanal, unos 0,02 euros. Menos de 1 euro al año.
- Sheets y n8n auto-alojado: 0 euros.
