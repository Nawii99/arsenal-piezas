# Banco de inspiración visual etiquetado automáticamente…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Recoge cada día lo nuevo de tus fuentes de referencia, lo etiqueta por estilo y sector con IA y lo guarda en tu base de datos de inspiración buscable.

## Qué es y qué hace

Lee feeds RSS de fuentes de diseño, descarta lo que ya tienes y pide a una IA de texto (Claude, Codex, Gemini o una IA local) que clasifique cada pieza por estilo, sector y técnica. Lo guarda en una base de Airtable y, los viernes, envía un resumen con lo mejor. Entrada: URLs RSS; salida: registros etiquetados y email. Se monta en n8n.

## Cómo usarla

1. Elige cinco fuentes RSS
2. Crea la base en Airtable con sus campos
3. Define las etiquetas de estilo
4. Revisa el resumen de los viernes

## Cuándo usarla

Úsalo cuando guardas referencias en cuarenta sitios distintos (capturas, favoritos, tableros) y cuando de verdad las necesitas para un proyecto no encuentras nada.

## Cómo ganar dinero con ella

Ahorra 2-3 horas al mes de búsqueda de referencias y hace que llegues a las reuniones de concepto con un moodboard ya montado.

- Biblioteca de referencias para estudios que trabajan por conceptos y moodboards.
- Investigación visual para agencias que presentan propuestas creativas cada semana.
- Curaduría de tendencias para directores de arte de marcas medianas.

**Precio orientativo:** 60–200 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee los feeds RSS de tus fuentes de diseño favoritas, descarta lo que ya tienes, pide a un modelo de IA que clasifique cada pieza por estilo visual, sector y técnica, y lo guarda en Airtable. Los viernes te manda un resumen con lo mejor. Para diseñadores y directores de arte que trabajan por conceptos.

## Lo que necesitas antes
- n8n.
- URLs de feeds RSS. Sirven, por ejemplo, `https://dribbble.com/shots/popular.rss`, los feeds de blogs de diseño como It's Nice That o Brand New, y cualquier web con `/feed`. Si una fuente no tiene RSS, prueba a generarlo con RSS.app (plan gratuito limitado).
- Clave de API de Anthropic (console.anthropic.com) u OpenAI.
- Cuenta gratuita en airtable.com. Crea una base «Inspiración» con campos: `titulo` (texto), `url` (URL), `fuente` (texto), `estilo` (texto), `sector` (texto), `tecnica` (texto), `fecha` (fecha).
- El token de Airtable se saca en airtable.com/create/tokens con permisos `data.records:read` y `data.records:write`.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Days, Trigger at Hour 9.
2. **Code** — Mode: Run Once for All Items. Devuelve la lista de feeds: `return ['https://dribbble.com/shots/popular.rss','https://www.itsnicethat.com/rss'].map(url => ({ json: { url } }));`
3. **RSS Read** — URL: `={{ $json.url }}`. Marca Execute Once: off, para que corra por cada feed.
4. **Airtable** — Operation: Search, tabla Inspiración, Filter By Formula: `{url} = "{{ $json.link }}"`. Options > Always Output Data: on.
5. **IF** — Condición: `{{ $json.id }}` is empty. La rama true significa que aún no lo tienes.
6. **Limit** — Max Items: 15. Para no gastar de más en IA ni llenar la base de ruido.
7. **Anthropic Chat Model** + **Basic LLM Chain** — Prompt: `Clasifica esta pieza de diseño. Devuelve SOLO un JSON con las claves estilo, sector y tecnica. estilo: máximo 3 palabras (ej. minimalista suizo, maximalista retro). sector: el sector del cliente. tecnica: ilustración, 3D, tipográfico, fotográfico o mixto. Título: {{ $json.title }}. Descripción: {{ $json.contentSnippet }}`.
8. **Code** — Mode: Run Once for Each Item. Parsea el JSON de la IA con `JSON.parse($json.text.match(/\{[\s\S]*\}/)[0])` y lo une al item original.
9. **Airtable** — Operation: Create. Rellena titulo, url, fuente, estilo, sector, tecnica y fecha.
10. Segundo workflow para el resumen: **Schedule Trigger** (viernes 17:00, cron `0 17 * * 5`) + **Airtable** Search con Filter By Formula `IS_AFTER({fecha}, DATEADD(TODAY(), -7, 'days'))` + **Code** que monte un HTML con la lista + **Gmail** Send a ti mismo.

## El nodo Code de parseo
```javascript
let etiquetas = { estilo: 'sin clasificar', sector: '', tecnica: '' };
try {
  const bruto = $json.text || $json.output || '';
  etiquetas = JSON.parse(bruto.match(/\{[\s\S]*\}/)[0]);
} catch (e) {}
const origen = $('Limit').item.json;
return { json: {
  titulo: origen.title,
  url: origen.link,
  fuente: (origen.link || '').split('/')[2],
  fecha: new Date().toISOString().slice(0, 10),
  ...etiquetas,
}};
```

## Cómo probarla
Empieza con un solo feed y el Limit en 3. Ejecuta en test y mira que Airtable recibe las tres fichas con etiquetas coherentes. Vuelve a ejecutar: no debe crear duplicados, porque el paso 4 y el IF los filtran.

## Qué puede salir mal
- **Feeds caídos o que cambian**: pon en Settings del nodo RSS Read la opción Continue On Fail, para que un feed roto no tumbe la ejecución entera.
- **Duplicados**: la comparación por URL es sensible a los parámetros `?utm_...`. Límpialos en el Code con `origen.link.split('?')[0]`.
- **La IA devuelve texto suelto**: el `try/catch` te salva; si pasa mucho, añade al prompt `No escribas nada fuera del JSON`.
- **Base saturada**: 15 piezas al día son 450 al mes. Airtable gratis admite 1.000 registros por base, así que archiva o baja el Limit a 5.

## Cuánto cuesta
n8n y RSS gratis. Airtable plan gratuito hasta 1.000 registros. La IA, con un modelo pequeño y 15 piezas al día, unos 0,50-2 € al mes.
