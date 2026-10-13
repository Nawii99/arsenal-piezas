# Rastreador de convocatorias y ayudas a la formación…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Vigila cada día los boletines oficiales y las webs de convocatorias, filtra por tus palabras clave y te manda solo lo que te afecta, con el plazo y el enlace directo.

## Qué es y qué hace

Revisa cada mañana el sumario del BOE y los boletines autonómicos por RSS, más las páginas de convocatorias que le indiques. Filtra por palabras clave de formación y empleo, pide a una IA que juzgue si te afecta y envía a Telegram solo lo relevante, con plazo y enlace. Guarda un histórico para no repetir avisos.

## Cómo usarla

1. Define palabras clave y fuentes RSS
2. Elige el modelo de IA (Claude, Codex, Gemini o una IA local)
3. Conecta Telegram y revisa los avisos una semana
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando te enteras tarde de las convocatorias de formación bonificada, planes de empleo o becas y pierdes el plazo por no leer boletines.

## Cómo ganar dinero con ella

Una sola convocatoria captada a tiempo puede valer varios miles de euros. Y te quita la media hora diaria de rastrear boletines a mano.

- Montaje de un radar de convocatorias para centros de formación, con palabras clave y fuentes propias del sector.
- Suscripción mensual de vigilancia de ayudas y becas para academias que no quieren perder plazos.
- Informe semanal de convocatorias para gestorías o consultoras que preparan solicitudes para sus clientes.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Cada mañana lee el sumario del BOE y los boletines autonómicos que le indiques por RSS, más las páginas de convocatorias que le pongas. Filtra por palabras clave (formación, certificado de profesionalidad, FP dual, becas, empleo), pide a la IA que juzgue si te afecta de verdad y te manda un mensaje a Telegram solo con lo relevante.
Guarda un histórico para que no te repita lo mismo y para que puedas revisar convocatorias pasadas.

## Lo que necesitas antes
- n8n auto-alojado (este flujo hace muchas peticiones y en planes gratuitos de cloud se queda corto).
- Las URLs RSS que quieras vigilar: el sumario diario del BOE tiene feed público, y casi todos los boletines autonómicos ofrecen RSS o al menos una página de últimas convocatorias.
- Clave de OpenAI.
- Un bot de Telegram: escribe a @BotFather, comando `/newbot`, te da el token. Luego escribe algo a tu bot y saca tu chat_id con `https://api.telegram.org/bot<TOKEN>/getUpdates`.
- Hoja `Convocatorias` con: `id`, `titulo`, `fuente`, `fecha`, `enlace`, `relevante`, `motivo`, `plazo`.

## Los nodos, en orden
1) **Schedule Trigger** — Cron `0 7 * * 1-5`, Timezone `Europe/Madrid`.
2) **RSS Read** — URL del primer boletín. Duplica el nodo para cada fuente, o mete un nodo **Code** con la lista de URLs y un **HTTP Request** en bucle.
3) **Merge** (Mode: Append, Number of Inputs: el número de fuentes).
4) **Code** — filtro grueso por palabras clave y creación de un id único. Código abajo.
5) **Google Sheets** (Get Rows) — hoja `Convocatorias`, para saber qué ya viste.
6) **Code** — descarta los ids ya guardados. Código abajo.
7) **Split In Batches** (Batch Size 1).
8) **OpenAI** (Message a Model) — Model `gpt-4o-mini`, Response Format JSON. System: «Eres el responsable de un centro de formación en España. Te paso el título y el resumen de una publicación oficial. Di si le interesa a un centro que imparte cursos de [pon aquí tus áreas] y opera en [tu comunidad]. Devuelve JSON: {relevante: true/false, motivo: string de 20 palabras, tipo: subvencion|licitacion|normativa|otro, urgencia: alta|media|baja}» User: `{{ $json.title }} — {{ $json.contentSnippet }}`.
9) **IF** — `{{ $json.relevante }}` is true.
10) **Telegram** (Operation: Send Message) — Chat ID el tuyo, Text: `*{{ $json.tipo }}* ({{ $json.urgencia }})%0A{{ $json.titulo }}%0A{{ $json.motivo }}%0A{{ $json.enlace }}`, Parse Mode Markdown.
11) **Google Sheets** (Append Row) — guarda todo, relevante o no, para no repetir.

## El código del nodo 4
```js
const claves = ['formación','formacion','certificado de profesionalidad','FP','empleo','beca','cualificación','docente','academia','curso'];
const crypto = require('crypto');
const out = [];
for (const it of items) {
  const t = (it.json.title || '') + ' ' + (it.json.contentSnippet || '');
  const tl = t.toLowerCase();
  if (!claves.some(k => tl.includes(k.toLowerCase()))) continue;
  const id = crypto.createHash('md5').update(it.json.link || t).digest('hex').slice(0, 12);
  out.push({ json: { id, titulo: it.json.title, enlace: it.json.link, contentSnippet: (it.json.contentSnippet || '').slice(0, 800), fecha: it.json.isoDate || new Date().toISOString() } });
}
return out;
```

## El código del nodo 6
```js
const vistos = new Set($('Google Sheets').all().map(i => String(i.json.id)));
return items.filter(i => !vistos.has(String(i.json.id)));
```

## Cómo probarla
- Ejecuta a mano con un solo feed y sin el nodo de Telegram: mira en la salida del Code cuántos items pasan el filtro. Si pasan cientos, afina las palabras clave; si pasan cero, amplíalas.
- Ejecútalo dos veces seguidas: la segunda no debería mandarte nada, porque ya está todo en la hoja.
- Comprueba el juicio de la IA con 10 resultados a mano antes de fiarte del filtro.

## Qué puede salir mal
- **Feeds que cambian o caen**: envuelve los RSS Read con Settings > On Error: Continue (using error output) para que un feed roto no tumbe el flujo.
- **Avalancha el primer día**: la primera ejecución te mandará todo el historial del feed. Ejecútala una vez con el nodo de Telegram desconectado para llenar la hoja.
- **Bloqueo por scraping**: si en vez de RSS haces HTTP Request a una web, pon un User-Agent normal en Headers y no bajes de 1 petición cada pocos segundos.
- **El plazo no aparece en el resumen**: el flujo te da el enlace; la fecha límite hay que leerla en el documento. Añade un recordatorio manual en Calendar cuando una te interese.

## Cuánto cuesta
- RSS, Telegram y Sheets: gratis.
- OpenAI: con 30 publicaciones filtradas al día son unos 0,60 € al mes.
- n8n auto-alojado en un VPS de 5 €/mes.
