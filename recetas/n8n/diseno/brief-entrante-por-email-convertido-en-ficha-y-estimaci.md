# Brief entrante por email convertido en ficha y estimaci…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Lee los correos de clientes nuevos, extrae el encargo en campos ordenados, estima horas y precio por partidas y te deja la ficha lista para presupuestar.

## Qué es y qué hace

Lee los correos que llegan a tu dirección de presupuestos, extrae con IA el tipo de encargo, el sector, los entregables, los plazos y el presupuesto que sugieren, calcula una estimación por partidas con tus tarifas y crea una ficha en Notion. Sirve para responder rápido y con criterio. Se monta con n8n, Make o Zapier y necesita una clave de API de un modelo de IA.

## Cómo usarla

1. Crea la etiqueta presupuestos en Gmail
2. Crea la base Encargos en Notion
3. Añade tu clave de Claude, Codex, Gemini o una IA local
4. Define tus tarifas por partida

## Cuándo usarla

Cuando recibes peticiones de diseño por correo en formato caos y pierdes media hora por consulta ordenando lo que te piden antes de poder responder.

## Cómo ganar dinero con ella

20-30 minutos por consulta entrante. Con 10 consultas al mes son 4 horas; además respondes el mismo día, lo que sube bastante la tasa de cierre.

- Filtro de encargos para estudios que reciben muchas peticiones por correo…
- Estimaciones previas en 24 horas como servicio para agencias pequeñas…
- Plantilla de brief para diseñadores freelance con presupuesto orientativo…

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Detecta los correos que llegan a tu dirección de presupuestos, saca con IA el tipo de encargo, el sector, los entregables, los plazos y el presupuesto que insinúan, calcula una estimación por partidas con tus tarifas y crea una ficha en Notion.
Es para diseñadores gráficos y de marca que reciben encargos por correo y quieren contestar rápido y con criterio.
## Lo que necesitas antes
Una etiqueta en Gmail llamada `presupuestos` y un filtro que meta ahí lo que llega a tu formulario de contacto o a `hola@tumarca.com`.
Una clave de API de Anthropic (console.anthropic.com > API Keys) o de OpenAI (platform.openai.com > API keys). Aquí se usa un «HTTP Request» genérico para no depender del nodo.
Una base de datos en Notion `Encargos` con propiedades: `Nombre` (título), `Cliente` (texto), `Email` (email), `Tipo` (selección: Identidad / Packaging / Editorial / Digital / Ilustración / Otro), `Entregables` (texto), `Plazo` (texto), `Presupuesto insinuado` (texto), `Estimación horas` (número), `Estimación €` (número), `Semáforo` (selección: Verde / Ámbar / Rojo).
Integración de Notion: notion.so/my-integrations > New integration, copia el token y comparte la base con la integración desde el botón «...» > Connections.
En n8n: credenciales «Gmail OAuth2», «Notion API» y una «Header Auth» para la IA.
## Los nodos, en orden
**1. «Gmail Trigger»** — Poll Times: Every 5 Minutes, Filters > Label IDs: `presupuestos`, Options > Download Attachments: off.
**2. «Code»** — limpia el correo: quita firmas, cadenas de respuestas y HTML sobrante (código abajo).
**3. «HTTP Request»** (nómbralo Extraer brief) — POST a `https://api.anthropic.com/v1/messages`, Headers: `x-api-key` desde una credencial de n8n (Generic Credential Type > Header Auth, Name `x-api-key`, Value tu clave; no la escribas en el nodo: un flujo exportado se la llevaría), `anthropic-version` = `2023-06-01`, `content-type` = `application/json`. Body JSON con `model` (por ejemplo un modelo Claude actual), `max_tokens` 1200 y un `messages` cuyo contenido sea: `Extrae del siguiente correo un JSON con las claves tipo, sector, entregables (array), plazo, presupuesto_insinuado, urgencia (alta/media/baja), dudas (array de lo que falta preguntar). Responde SOLO JSON válido, sin texto alrededor. Correo: {{ $json.texto_limpio }}`.
**4. «Code»** (nómbralo Estimar) — parsea el JSON y aplica tu tarifario para calcular horas y euros (código abajo).
**5. «Notion»** — Resource: Database Page, Operation: Create, Database ID el tuyo, mapeando todas las propiedades.
**6. «Gmail»** — Send, respuesta automática al cliente en 1 minuto: acuse de recibo con las dudas que ha detectado la IA, para que vaya contestándolas. Reply To Message ID `{{ $('Gmail Trigger').first().json.id }}` para que quede en el mismo hilo.
**7. «Slack»** o «Gmail» a ti — resumen con el semáforo y la estimación.
## El trozo de código (nodo «Estimar»)
```javascript
const raw = $input.first().json.content?.[0]?.text || $input.first().json.text || '{}';
const limpio = raw.replace(/```json|```/g, '').trim();
let b; try { b = JSON.parse(limpio); } catch(e) { b = { tipo: 'Otro', entregables: [], dudas: ['No se pudo interpretar el correo'] }; }
const TARIFA = 45; // euros por hora
const HORAS = { 'identidad': 40, 'packaging': 28, 'editorial': 22, 'digital': 18, 'ilustracion': 12, 'otro': 10 };
const tipo = String(b.tipo || 'otro').toLowerCase();
let horas = HORAS[tipo] || HORAS['otro'];
const n = Array.isArray(b.entregables) ? b.entregables.length : 1;
horas += Math.max(0, n - 3) * 3;
if (String(b.urgencia).toLowerCase() === 'alta') horas *= 1.25;
const euros = Math.round(horas * TARIFA / 50) * 50;
const presu = String(b.presupuesto_insinuado || '').replace(/[^0-9]/g, '');
let semaforo = 'Ámbar';
if (presu && Number(presu) >= euros) semaforo = 'Verde';
if (presu && Number(presu) < euros * 0.6) semaforo = 'Rojo';
return [{ json: { ...b, horas: Math.round(horas), euros, semaforo, entregables_txt: (b.entregables||[]).join(', '), dudas_txt: (b.dudas||[]).map(d => '- ' + d).join('\n') } }];
```
## El trozo de código (nodo «Code» de limpieza)
```javascript
const m = $input.first().json;
let t = (m.text || m.snippet || '').replace(/<[^>]+>/g, ' ');
t = t.split(/El .* escribió:|-----Mensaje original-----|On .* wrote:/)[0];
t = t.replace(/\s+/g, ' ').trim().slice(0, 6000);
return [{ json: { texto_limpio: t, remitente: m.from?.value?.[0]?.address || m.From || '', asunto: m.subject || '' } }];
```
## Cómo probarla
Mándate a ti mismo tres correos falsos: uno muy completo, uno vago de dos líneas y uno con presupuesto bajo. Comprueba que el semáforo sale Verde, Ámbar y Rojo respectivamente.
Ajusta `TARIFA` y `HORAS` a tus números reales antes de fiarte de la estimación.
## Qué puede salir mal
La IA a veces devuelve el JSON envuelto en explicaciones: el `replace` de las comillas triples lo cubre, y el try/catch evita que el flujo reviente.
Correos con firmas largas o cadenas de respuesta hinchan el coste: por eso se recorta a 6.000 caracteres.
No dejes que la respuesta automática al cliente prometa precios; que solo acuse recibo y pregunte dudas. El presupuesto lo mandas tú.
Si Gmail Trigger sondea cada minuto en n8n Cloud (de pago tras la prueba gratuita), te comes las ejecuciones: ponlo cada 15 minutos.
## Cuánto cuesta
n8n auto-alojado (gratis), Gmail y Notion gratis. La llamada a la IA cuesta céntimos por correo (unos 0,01-0,03 € con un modelo intermedio). Con 50 consultas al mes no llegas a 2 € de API.
