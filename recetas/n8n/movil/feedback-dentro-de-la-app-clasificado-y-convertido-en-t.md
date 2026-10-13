# Feedback dentro de la app clasificado y convertido en t…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Recoge el formulario de sugerencias de tu app, la IA lo clasifica en fallo, idea o queja, y crea la tarjeta en tu gestor de tareas con prioridad y sin duplicados.

## Qué es y qué hace

Receta de n8n que recoge el feedback de tu app, desde un formulario de sugerencias o de Tally, y lo envía por webhook. La IA lo etiqueta como fallo, idea, queja o elogio y le asigna una gravedad de 1 a 5. Crea una tarjeta en Trello o en tu gestor de tareas y, si el texto ya existe, suma un voto en lugar de duplicarla. Los fallos graves avisan a Slack. Entrada: texto, email y versión. Salida: tareas clasificadas sin duplicados.

## Cómo usarla

1. Crea el formulario y conecta el webhook
2. Elige la IA y el gestor de tareas
3. Prueba con tres mensajes reales
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando recibes feedback de usuarios por varios sitios y acaba en un correo que nadie lee, o cuando pides ideas y no sabes cuál se repite más.

## Cómo ganar dinero con ella

Evita las 3-4 horas semanales de triaje manual y hace que las quejas que se repiten salgan solas a la superficie en vez de perderse.

- Triaje de feedback para pequeños estudios de software…
- Buzón de ideas y quejas para una app de un gimnasio o una academia…
- Priorización mensual de tareas de producto con votos de usuarios…

**Precio orientativo:** 250–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Dentro de tu app pones un enlace «Enviar sugerencia» que abre un formulario de Tally. Cada envío entra en n8n, la IA lo etiqueta (fallo, idea, queja, elogio), le pone gravedad de 1 a 5 y crea una tarjeta en Trello en la lista que toca.
Si el mismo texto ya existe, en vez de crear otra tarjeta suma un voto a la existente. Los fallos graves saltan además a Slack.
Es para cualquier app o SaaS pequeño que quiera escuchar a sus usuarios sin ahogarse.

## Lo que necesitas antes
n8n.
Cuenta de Tally (gratis, formularios ilimitados). Crea un formulario con campos: tipo libre «Cuéntanos», email opcional, versión de la app y sistema (que puedes rellenar tú desde la app pasándolos por la URL como parámetros ocultos).
Clave de OpenAI.
Cuenta de Trello con un tablero «Feedback app» y listas: Fallos, Ideas, Quejas, Archivo. La API key y el token se sacan en trello.com/power-ups/admin o en trello.com/app-key.
Webhook de Slack (api.slack.com, Incoming Webhooks) o el nodo Slack con OAuth.

## Los nodos, en orden
1. «Webhook». Method POST, ruta /feedback-app. Copia la Production URL.
2. En Tally, en Integrations, Webhooks, pega esa URL. Así cada respuesta llega sola.
3. «Set» (limpiar campos). Crea texto, email, version, sistema leyendo del cuerpo de Tally: {{ $json.body.data.fields }}. Ojo, Tally manda los campos como array, mira la estructura real en la primera ejecución.
4. «OpenAI» (Message a model). Modelo gpt-4o-mini, «Output Content as JSON» activado. Prompt: «Clasifica este mensaje de un usuario de app. Devuelve JSON con: tipo (fallo|idea|queja|elogio), gravedad (1 a 5), titulo (máximo 8 palabras), resumen (1 frase). Mensaje: {{ $json.texto }}».
5. «Trello» (Search, o «HTTP Request» a https://api.trello.com/1/search?query={{ $json.titulo }}&idBoards=TU_BOARD) para ver si ya existe algo parecido.
6. «IF». Si hay coincidencia con más del 80% de parecido, rama duplicado; si no, rama nueva.
7. Rama duplicado: «Trello» (Add comment to card) con «+1 · {{ $json.texto }}». Así ves cuántas veces lo han pedido.
8. Rama nueva: «Switch» por {{ $json.tipo }} con cuatro salidas hacia las cuatro listas.
9. «Trello» (Create Card). Nombre {{ $json.titulo }}. Descripción: resumen, texto original, email, versión y sistema. Etiqueta según gravedad.
10. «IF» (gravedad mayor o igual a 4 y tipo igual a fallo) → «Slack» (Send Message) al canal de desarrollo con el enlace de la tarjeta.
11. «Gmail» (Send) al usuario si dejó email: «Gracias, lo hemos apuntado». Solo si tipo no es elogio.

## Cómo probarla
Rellena tú el formulario tres veces: un fallo grave, una idea y un elogio. Comprueba que cada uno cae en su lista y que solo el fallo grave llega a Slack.
Manda el mismo fallo dos veces para ver que la segunda añade comentario en vez de crear tarjeta.

## Qué puede salir mal
La estructura del JSON de Tally cambia según los tipos de campo. Ejecuta una vez, mira la salida del Webhook y ajusta el Set con los nombres reales.
Si el webhook no dispara, comprueba que el workflow está activo: la URL de test solo funciona mientras pulsas «Listen for test event».
La búsqueda de duplicados en Trello es literal, no entiende sinónimos. Si quieres afinar, pásale a la IA la lista de títulos existentes y que ella decida.
La IA puede devolver un JSON roto. Pon detrás un nodo «Code» con try/catch o activa el modo JSON estricto del nodo OpenAI.

## Cuánto cuesta
n8n, Tally, Trello y Slack: gratis en sus planes básicos.
OpenAI: alrededor de 1 € al mes con 500 mensajes de feedback.
