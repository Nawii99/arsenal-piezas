# Banco de pruebas de tu chatbot o tus respuestas automát…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Cada semana lanza 30 preguntas reales de clientes contra tu chatbot y puntúa si contesta bien, avisándote si su calidad baja.

## Qué es y qué hace

Flujo de n8n que cada semana envía 30 preguntas de un banco de pruebas a tu chatbot o asistente, y un modelo juez puntúa cada respuesta de 0 a 2 frente a la respuesta esperada. Entra la URL del webhook del bot, la hoja de casos y la clave del juez; sale una media semanal y un aviso si la calidad baja. Sirve para detectar regresiones tras cambiar prompts, precios o catálogo.

## Cómo usarla

1. Crea la hoja Banco de pruebas con preguntas y respuestas esperadas
2. Conecta el webhook de tu bot
3. Elige el juez entre Claude, Codex, Gemini o una IA local
4. Recibe el aviso si la media baja

## Cuándo usarla

Úsalo cuando tengas un chatbot, un asistente de WhatsApp o respuestas automáticas y no sepas si siguen contestando bien después de cambiar el prompt, los precios o el catálogo.

## Cómo ganar dinero con ella

Un bot que inventa precios o promete lo que no das genera reclamaciones y devoluciones. Detectar la regresión antes que el cliente vale más que la propia herramienta.

- Auditoría de calidad de chatbots para empresas que atienden clientes por web o WhatsApp.
- Mantenimiento mensual de asistentes con revisión de respuestas y propuesta de mejoras.
- Configuración de un banco de pruebas para agencias que entregan bots a sus clientes.

**Precio orientativo:** 250–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**: mantiene un banco de preguntas con la respuesta correcta esperada, se las hace a tu bot, y una IA juez puntúa cada respuesta de 0 a 2 comparándola con lo que debería decir. Si la nota media cae, te avisa. Para quien tenga chatbot en la web, en WhatsApp o un asistente de atención al cliente.
**Para quién no es**: si aún no tienes bot; monta primero el bot.

### Lo que necesitas antes
- **La forma de hablar con tu bot desde fuera**: casi todos tienen una API o un webhook. Si el tuyo es un flujo de n8n, apunta directamente a la URL del nodo Webhook. Si es Chatbase, Voiceflow, ManyChat o similar, busca «API» en su documentación y saca la clave.
- **Una clave de API de un modelo de lenguaje para el juez**: en `console.anthropic.com` (Claude) o el proveedor que uses. Cuesta céntimos por ejecución.
- **Hoja «Banco de pruebas»** con pestaña `casos`: `id`, `pregunta`, `respuesta_esperada`, `debe_contener`, `no_debe_contener`, `activo`. Y pestaña `resultados`: `fecha`, `id`, `pregunta`, `respuesta_bot`, `nota`, `motivo`.
- **Las 30 preguntas**: sácalas de tus conversaciones reales. Incluye 10 fáciles (horario, precio, envío), 10 difíciles (devoluciones, casos límite, dos preguntas a la vez) y 10 trampa (cosas que NO vendes, descuentos que no existen, consejos médicos o legales que no debes dar). Las trampa son las que de verdad te salvan.

### Los nodos, en orden
**1. Schedule Trigger** — Weeks, miércoles a las 5:00. Timezone `Europe/Madrid`.
**2. Google Sheets** — Get Row(s) de `casos`. En Filters añade Lookup Column `activo`, Lookup Value `si`.
**3. Loop Over Items** — Batch Size 1, con un **Wait** de 3 segundos dentro para no saturar el bot.
**4. HTTP Request** («Preguntar al bot») — POST a la URL de tu bot. Body JSON: `{"message": "{{ $json.pregunta }}", "session_id": "qa-{{ $now.toMillis() }}"}`. Importante: usa un `session_id` distinto en cada pregunta para que no arrastre contexto de la anterior. Never Error, Timeout `30000`.
**5. HTTP Request** («Juez») — POST `https://api.anthropic.com/v1/messages`. Headers: `x-api-key` (guárdala como credencial), `anthropic-version` = `2023-06-01`, `content-type` = `application/json`. Body JSON:
```json
{
  "model": "claude-sonnet-5-5",
  "max_tokens": 300,
  "messages": [{ "role": "user", "content": "Eres un evaluador de calidad de atencion al cliente. PREGUNTA DEL CLIENTE: {{ $('Loop Over Items').first().json.pregunta }}\n\nRESPUESTA IDEAL: {{ $('Loop Over Items').first().json.respuesta_esperada }}\n\nRESPUESTA DEL BOT: {{ $json.reply }}\n\nPuntua de 0 a 2: 0 si la respuesta es incorrecta, inventada o promete algo falso; 1 si es incompleta o vaga pero no danina; 2 si es correcta y util. Responde SOLO con un JSON asi: {\"nota\": 0, \"motivo\": \"...\"}" }]
}
```
**6. Code** («Leer veredicto»):
```js
let bruto = '';
try { bruto = $json.content[0].text; } catch (e) { bruto = '{}'; }
let v = { nota: 0, motivo: 'No se pudo evaluar' };
try { v = JSON.parse(bruto.match(/\{[\s\S]*\}/)[0]); } catch (e) {}
const caso = $('Loop Over Items').first().json;
const respuesta = String($('Preguntar al bot').first().json.reply || '');
const extra = [];
for (const t of String(caso.debe_contener || '').split(';')) { const s = t.trim(); if (s && !respuesta.toLowerCase().includes(s.toLowerCase())) extra.push('No menciona "' + s + '"'); }
for (const t of String(caso.no_debe_contener || '').split(';')) { const s = t.trim(); if (s && respuesta.toLowerCase().includes(s.toLowerCase())) { extra.push('DICE LO QUE NO DEBE: "' + s + '"'); v.nota = 0; } }
return [{ json: { id: caso.id, pregunta: caso.pregunta, respuesta_bot: respuesta, nota: v.nota, motivo: [v.motivo, ...extra].join(' | ') } }];
```
**7. Google Sheets** — Append Row en `resultados` con la fecha. Conecta de vuelta al Loop.
**8. Code** («Nota media») desde la salida `done`: `const r = $('Leer veredicto').all().map(i => i.json); const media = r.reduce((a, b) => a + Number(b.nota), 0) / r.length; const ceros = r.filter(x => Number(x.nota) === 0); return [{ json: { media: Math.round(media * 100) / 100, ceros: ceros.length, listaCeros: ceros.map(x => x.id + ': ' + x.motivo).join(' // ') } }];`
**9. IF** — si `{{ $json.media }}` es menor que `1.6` o `{{ $json.ceros }}` mayor que `2`.
**10. Telegram** — `🤖 El bot ha bajado de calidad. Nota media {{ $json.media }} sobre 2, con {{ $json.ceros }} respuestas malas. Fallos: {{ $json.listaCeros }}`.

### Cómo probarla
- Ejecuta con 3 casos primero. Mira en la hoja `resultados` si las notas te parecen justas; si el juez es muy blando, endurece la instrucción del nodo 5.
- Rompe el bot a propósito: quítale el precio de su base de conocimiento y ejecuta. Las preguntas de precio deben sacar 0.
- Guarda la nota media de la primera semana: esa es tu referencia. Lo que importa es la caída, no el número absoluto.

### Qué puede salir mal
- **El juez responde con texto alrededor del JSON**: por eso el Code busca el bloque con expresión regular. Si aun así falla, verás nota 0 y motivo «No se pudo evaluar»: no lo confundas con un fallo del bot.
- **El campo de la respuesta no se llama `reply`**: abre la salida del nodo 4 y usa el nombre real (`answer`, `text`, `output`, `messages[0].content`).
- **Sesiones contaminadas**: si no cambias el `session_id`, el bot arrastra el contexto y las notas suben artificialmente.
- **Coste descontrolado**: 30 preguntas por semana son unas 130 llamadas al mes; céntimos. No lo pongas a diario ni con 300 casos sin mirar la factura.
- **El bot tiene rate limit**: sube el Wait a 10 segundos si te devuelve 429.

### Cuánto cuesta
- Juez con Claude Sonnet: alrededor de **0,01-0,03 € por ejecución completa** de 30 casos, unos 0,10 €/mes.
- n8n auto-alojado, Sheets y Telegram: **0 €**.
- Alternativa a coste cero: sustituye el juez por comprobaciones de `debe_contener`/`no_debe_contener` únicamente; pierdes matiz pero no cuesta nada.
