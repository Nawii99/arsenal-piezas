# Del formulario de briefing al proyecto montado…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

El cliente rellena un formulario de briefing y recibes un resumen ordenado, la carpeta de trabajo creada en Drive y la tarjeta del proyecto en tu tablero.

## Qué es y qué hace

Recibe el formulario de briefing por webhook, pide a una IA de texto (Claude, Codex, Gemini o una IA local) un resumen con objetivos, tono, referencias y preguntas pendientes, crea la carpeta de trabajo en Drive y la tarjeta del proyecto en Notion. Entrada: respuestas del formulario; salida: brief, carpeta y tarjeta. Funciona en n8n con la clave de la IA que elijas.

## Cómo usarla

1. Crea el formulario en Tally
2. Conecta Drive y Notion en n8n
3. Define el prompt del resumen
4. Revisa el brief generado antes de enviarlo al cliente

## Cuándo usarla

Úsalo cuando cada encargo empieza con un briefing incompleto por WhatsApp y tú acabas montando a mano carpetas, tarjeta y resumen antes de poder dibujar nada.

## Cómo ganar dinero con ella

Ahorra 30 minutos de arranque por proyecto y, sobre todo, evita rehacer un diseño por un briefing mal entendido, que son horas perdidas.

- Arranque de proyectos para diseñadores que quieren briefs completos desde el día uno.
- Onboarding de clientes para estudios con encargos repetidos y mucho ida y vuelta.
- Plantilla de briefing para agencias con varios equipos creativos.

**Precio orientativo:** 80–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recibe el formulario de briefing, pide a un modelo de IA que lo resuma en un brief de trabajo con objetivos, tono, referencias y lo que falta por preguntar, crea la estructura de carpetas y abre la tarjeta del proyecto. Para diseñadores que quieren empezar cada encargo con la información ordenada.

## Lo que necesitas antes
- n8n con URL pública para el webhook.
- Un formulario en tally.so (gratis) con campos: nombre, empresa, email, qué necesita, a quién se dirige, tono deseado, referencias que le gustan, presupuesto, fecha límite.
- Clave de API de Anthropic en console.anthropic.com (o de OpenAI, el nodo es equivalente).
- Google Drive y Notion conectados en n8n. En Notion crea una integración en notion.so/my-integrations, copia el token y comparte tu base de datos con esa integración.

## Los nodos, en orden
1. **Webhook** — HTTP Method: POST, Path: `briefing`, Respond: Immediately. Copia la Production URL y pégala en Tally, en Integrations > Webhooks.
2. **Code** — Mode: Run Once for Each Item. Aplana la respuesta de Tally, que llega como array de campos. Código abajo.
3. **Anthropic Chat Model** + **Basic LLM Chain** (o el nodo **HTTP Request** contra la API si prefieres) — Prompt: `Eres director de arte. A partir de este briefing en bruto escribe: 1) resumen del encargo en 3 líneas, 2) objetivo de negocio, 3) público, 4) tono y territorio visual en 5 adjetivos, 5) entregables concretos, 6) las 3 preguntas clave que faltan por resolver. Briefing: {{ $json.texto_plano }}`.
4. **Google Drive** — Resource: Folder, Operation: Create. Folder Name `={{ $('Code').item.json.empresa }} - {{ $('Code').item.json.necesita }}`, dentro de tu carpeta «Proyectos».
5. **Google Drive** — Folder > Create, cuatro veces (o con un Code que devuelva cuatro items, como en la receta de entrega): `01 Briefing`, `02 Referencias`, `03 Trabajo`, `04 Entrega`.
6. **Notion** — Resource: Database Page, Operation: Create. Database: tu tablero de proyectos. Properties: Name = `={{ $('Code').item.json.empresa }}`, Estado = `Briefing`, Fecha límite = `={{ $('Code').item.json.fecha_limite }}`, URL carpeta = el webViewLink de Drive. En Blocks añade un bloque de texto con la respuesta de la IA.
7. **Gmail** — Send al cliente: `Recibido tu briefing, te escribo en 24-48 h con la propuesta de enfoque.`
8. **Gmail** — Send a ti: el resumen de la IA en el cuerpo, para leerlo desde el móvil.

## El nodo Code
```javascript
const campos = $json.data?.fields || [];
const val = etiqueta => {
  const c = campos.find(f => (f.label || '').toLowerCase().includes(etiqueta));
  return Array.isArray(c?.value) ? c.value.join(', ') : (c?.value ?? '');
};
const texto_plano = campos
  .map(f => `${f.label}: ${Array.isArray(f.value) ? f.value.join(', ') : f.value}`)
  .join('\n');
return { json: {
  empresa: val('empresa') || val('nombre'),
  email: val('email'),
  necesita: val('necesita'),
  fecha_limite: val('fecha'),
  texto_plano,
}};
```

## Cómo probarla
Con el workflow en modo test («Listen for test event»), rellena tú mismo el formulario. Revisa que el Code extrae bien los campos: Tally cambia las etiquetas si editas las preguntas, así que ajusta las palabras clave del `val()`. Después activa el workflow para que use la URL de producción.

## Qué puede salir mal
- **El webhook no recibe nada**: en test solo escucha una vez; para funcionamiento real el workflow debe estar activo y Tally apuntando a la URL de producción, que termina en `/webhook/briefing` y no en `/webhook-test/`.
- **La IA se inventa datos**: añade al prompt `Si un dato no está en el briefing, escribe PENDIENTE en vez de suponerlo`.
- **Notion da error de propiedad**: los nombres de las propiedades tienen que coincidir letra a letra, mayúsculas incluidas.
- **Nombres de carpeta con barras o dos puntos**: límpialos en el Code con `.replace(/[\/:]/g, '-')`.

## Cuánto cuesta
n8n, Tally (plan gratuito con formularios ilimitados), Drive y Notion: gratis. La llamada a la IA cuesta céntimos por briefing; con 20 briefings al mes no llegas a 1 €.
