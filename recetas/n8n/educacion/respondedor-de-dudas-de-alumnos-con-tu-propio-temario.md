# Respondedor de dudas de alumnos con tu propio temario…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Las preguntas que llegan por email o Telegram se responden solas usando tu temario y tus FAQ; lo que la IA no sabe con seguridad te llega a ti clasificado.

## Qué es y qué hace

Flujo de n8n que recibe la duda de un alumno por Telegram o email, busca la respuesta en una base de conocimiento con tu temario y FAQ, y responde si la tiene clara. Si no, la escala marcando tema y urgencia para que la revises tú. Entra la pregunta y la hoja Base conocimiento; sale la respuesta o el escalado registrado.

## Cómo usarla

1. Crea el bot de Telegram y la hoja Base conocimiento
2. Elige el modelo entre Claude, Codex, Gemini o una IA local y fija la regla de escalar
3. Prueba treinta dudas reales antes de publicar
4. Revisa las escaladas cada semana

## Cuándo usarla

Cuando pasas el día contestando las mismas cinco dudas y las importantes se te pierden entre ellas.

## Cómo ganar dinero con ella

Contesta el 60-70% de las dudas al instante y te deja solo las que de verdad requieren profesor. Ahorra 1-2 horas diarias en cursos con muchos alumnos.

- Soporte automático para academias y cursos online con muchas dudas repetidas.
- Chatbot de atención al alumno para mentorías con grupos de treinta o más personas.
- Base de conocimiento y respuestas automáticas para formadores que venden cursos por plataforma.

**Precio orientativo:** 300–600 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Recibe la duda del alumno por Telegram o por email, busca la respuesta en tu base de conocimiento (temario, FAQ, condiciones del curso), responde si la tiene clara y, si no, te la escala marcando el tema y la urgencia. Todo queda registrado para que veas qué se pregunta más.
Es para academias, cursos online y mentorías con soporte al alumno.

## Lo que necesitas antes
n8n.
Un bot de Telegram: escribe a @BotFather, `/newbot`, guarda el token. En n8n lo pegas en la credencial «Telegram API».
Una hoja «Base conocimiento» con dos columnas: pregunta y respuesta. Rellena 30-50 filas con tus dudas habituales: cómo acceder, plazos, devoluciones, requisitos, dónde está cada módulo.
Una hoja «Dudas» con columnas: fecha, canal, alumno, pregunta, respondida_por, tema, respuesta.
API key de OpenAI.
Credencial Google OAuth2 para Sheets y Gmail.

## Los nodos, en orden
**1. Telegram Trigger**. Updates: `message`. En paralelo, un **Gmail Trigger** con etiqueta `dudas` para el canal de correo. Ambos entran a un nodo **Merge** en modo «Append».
**2. Set** «Normalizar entrada». Campos: `canal` (telegram o email), `alumno` (username o remitente), `chat_id`, `pregunta` (texto del mensaje o cuerpo del correo).
**3. Google Sheets** «Cargar base». Get Row(s) de la hoja «Base conocimiento».
**4. Code** «Empaquetar base». Convierte todas las filas en un solo texto con formato `P: ... R: ...` para meterlo en el prompt (código abajo).
**5. OpenAI** «Message a Model». Model: `gpt-4o-mini`. Sistema: el prompt de abajo. Usuario: `BASE:\n{{ $json.base }}\n\nPREGUNTA DEL ALUMNO:\n{{ $json.pregunta }}`. Activa salida en JSON.
**6. Code** «Parsear». Extrae `confianza`, `respuesta`, `tema` y `urgencia` del JSON.
**7. IF** «¿Responde sola?». Condición: `{{ $json.confianza }}` mayor o igual que 0.7.
**8a. Switch** (rama TRUE). Por `canal`: si es telegram, nodo **Telegram** «Send Message» al `chat_id` con la respuesta más la coletilla «Si no te vale, responde AYUDA y te contesto yo»; si es email, nodo **Gmail** «Reply to Message».
**8b. Gmail** (rama FALSE, para ti). Subject: `[{{ $json.urgencia }}] Duda de {{ $json.alumno }} sobre {{ $json.tema }}`. Cuerpo con la pregunta literal, el borrador de la IA y el enlace al chat.
**9. Google Sheets** «Registrar». Append Row en «Dudas» con todos los campos, incluida la confianza.
**10. Schedule Trigger** aparte, semanal: lee la hoja «Dudas», agrupa por tema con un **Code** y te manda por Gmail el top 10 de preguntas para que amplíes la base de conocimiento.

## El prompt del nodo 5 (mensaje de sistema)
Eres el asistente de soporte de un curso online. Respondes SOLO con la información de la BASE que te dan. Si la base no cubre la pregunta, no inventes. Devuelve un JSON con: confianza (0 a 1, cuánto cubre la base la pregunta), respuesta (máximo 120 palabras, español de España, tuteando, tono cercano), tema (una de estas categorías: acceso, contenido, pagos, certificado, tecnico, otros) y urgencia (baja, media, alta; alta si menciona reembolso, queja o problema de pago). Nunca prometas plazos ni descuentos que no estén en la base.

## El trozo de código
Nodo **Code** número 4, modo «Run Once for All Items»:
```javascript
const filas = $('Cargar base').all();
const base = filas.map(f => 'P: ' + f.json.pregunta + '\nR: ' + f.json.respuesta).join('\n---\n');
const entrada = $('Normalizar entrada').first().json;
return [{ json: { ...entrada, base } }];
```

## Cómo probarla
Escribe al bot cinco preguntas: tres que estén claramente en la base, una a medias y una totalmente fuera. Comprueba que solo las tres primeras se responden solas.
Baja el umbral de confianza a 0.9 la primera semana: mejor escalarte de más que soltar una respuesta inventada.

## Qué puede salir mal
Si la base es muy larga (más de 200 filas), el prompt se dispara de precio y el modelo se despista. A partir de ahí conviene un almacén vectorial: en n8n usa el nodo **Simple Vector Store** o Qdrant con embeddings, y solo pasas las 5 respuestas más parecidas.
Telegram corta los mensajes a 4096 caracteres: recorta la respuesta con `.slice(0, 3800)`.
Si un alumno escribe muy seguido, el trigger dispara varias ejecuciones. Añade un **Wait** de 5 segundos o agrupa por chat_id.
No dejes que el bot hable de reembolsos ni de notas: eso siempre a ti, por eso la urgencia alta fuerza la escalada.
Deja claro al alumno que habla con un asistente automático supervisado por una persona.

## Cuánto cuesta
n8n, Telegram, Sheets y Gmail: 0 €.
OpenAI: unos 0,002 € por duda con base de 40 filas. 1.000 dudas al mes son 2 €.
Con Groq o con el nodo de Ollama sobre un modelo local el coste de IA baja a 0 €.
