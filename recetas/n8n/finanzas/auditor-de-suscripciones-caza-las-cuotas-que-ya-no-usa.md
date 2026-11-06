# Auditor de suscripciones: caza las cuotas que ya no usa…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Una vez al mes rastrea tu correo buscando recibos de suscripciones, compara los importes con los del mes anterior y te enseña una lista con lo que pagas, lo que ha subido y lo que sobra.

## Qué es y qué hace

Cada día 1 busca en tu Gmail los recibos de suscripción del mes anterior, extrae el servicio y el importe con IA, los compara con el histórico y te envía un informe con el gasto recurrente, las subidas de precio y las suscripciones sin movimiento. Se monta con n8n, Make o Zapier y necesita Gmail, una hoja y una clave de API de un modelo de IA.

## Cómo usarla

1. Crea la hoja Suscripciones
2. Conecta Gmail y Sheets en n8n
3. Añade tu clave de Claude, Codex, Gemini o una IA local
4. Revisa el primer informe con tu lista
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando sospechas que estás pagando herramientas, dominios y apps que ya no abres, pero te da pereza reconstruir la lista.

## Cómo ganar dinero con ella

Un negocio pequeño suele arrastrar entre 30 y 150 € al mes en suscripciones zombis. Cancelarlas es dinero puro, 350-1.800 € al año.

- Auditoría de gasto recurrente como servicio trimestral para pymes con muchos SaaS…
- Informe de suscripciones para autónomos que quieren reducir gastos fijos…
- Limpieza de suscripciones zombis en la primera sesión de consultoría…

**Precio orientativo:** 60–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
El día 1 de cada mes busca en tu correo todos los recibos y facturas de suscripción del mes anterior, extrae el nombre del servicio y el importe, los guarda y los compara con el histórico.
Te manda un informe con el gasto total recurrente, cuáles han subido de precio, cuáles son nuevas y cuáles llevan más de dos meses cobrando sin que tú las hayas tocado.
Para autónomos y pymes que acumulan SaaS, dominios, hostings, plantillas y apps.

## Lo que necesitas antes
Gmail (o Google Workspace) donde te lleguen los recibos.
Una hoja «Suscripciones» con columnas: Mes, Servicio, Importe, Moneda, FechaRecibo, Asunto.
Clave de API de Claude en console.anthropic.com. Se usa para leer los asuntos de correo y sacar servicio e importe sin volverte loco con expresiones regulares.
Credencial de Google en n8n con Gmail y Sheets.

## Los nodos, en orden
**Schedule Trigger**: Cron Expression `0 9 1 * *` (día 1 de cada mes a las 9:00). Timezone Europe/Madrid.
**Gmail**: Operation «Get Many Messages», Return All activado, Simplify desactivado. Filters > Search: `(subject:(recibo OR factura OR invoice OR receipt OR "payment received" OR "your subscription")) newer_than:35d`.
**Code** (prepara el texto para la IA): modo «Run Once for All Items».
```javascript
const correos = $input.all().map(i => {
  const h = i.json.payload?.headers || [];
  const get = (n) => (h.find(x => x.name.toLowerCase() === n) || {}).value || '';
  return { asunto: get('subject'), de: get('from'), fecha: get('date'), extracto: (i.json.snippet || '').slice(0, 200) };
});
const texto = correos.map((c, n) => `${n+1}. De: ${c.de} | Asunto: ${c.asunto} | ${c.extracto}`).join('\n');
return [{ json: { texto, cuantos: correos.length } }];
```
**HTTP Request** (la IA identifica suscripciones): POST a `https://api.anthropic.com/v1/messages`. Header Auth con `x-api-key` y también `anthropic-version: 2023-06-01`. Body JSON con expresión:
`={{ JSON.stringify({ model: "claude-sonnet-5-5", max_tokens: 3000, messages: [{ role: "user", content: "De esta lista de correos, quédate SOLO con los que son cobros recurrentes de servicios o suscripciones (no compras puntuales, no facturas a clientes). Devuelve SOLO un array JSON con objetos {servicio, importe, moneda, fecha}. importe como número. Si no hay ninguno devuelve []. Lista:\n" + $json.texto }] }) }}`
**Code** (limpia y compara con el histórico): antes conecta un nodo **Google Sheets** «Get Row(s)» sobre la hoja «Suscripciones» y renómbralo `Historico`.
```javascript
const bruto = $input.first().json.content[0].text.replace(/```json/g,'').replace(/```/g,'').trim();
let lista = [];
try { lista = JSON.parse(bruto); } catch(e) { lista = []; }
const hist = $('Historico').all().map(i => i.json);
const mesActual = new Date().toISOString().slice(0,7);
const mesAnterior = new Date(Date.now() - 32*86400000).toISOString().slice(0,7);
const num = (v) => Number(String(v ?? 0).replace(',', '.')) || 0;
const previos = {};
hist.filter(h => h.Mes === mesAnterior).forEach(h => { previos[String(h.Servicio).toLowerCase()] = num(h.Importe); });
const subidas = []; const nuevas = []; const filas = [];
let total = 0;
for (const s of lista) {
  const clave = String(s.servicio).toLowerCase();
  const imp = num(s.importe);
  total += imp;
  filas.push({ json: { Mes: mesActual, Servicio: s.servicio, Importe: imp.toFixed(2), Moneda: s.moneda || 'EUR', FechaRecibo: s.fecha || '', Asunto: '' } });
  if (previos[clave] === undefined) nuevas.push(`${s.servicio}: ${imp.toFixed(2)} €`);
  else if (imp > previos[clave] * 1.02) subidas.push(`${s.servicio}: de ${previos[clave].toFixed(2)} € a ${imp.toFixed(2)} € (+${((imp/previos[clave]-1)*100).toFixed(0)}%)`);
}
const desaparecidas = Object.keys(previos).filter(k => !lista.some(s => String(s.servicio).toLowerCase() === k));
const informe = `AUDITORÍA DE SUSCRIPCIONES — ${mesActual}\n\nGasto recurrente del mes: ${total.toFixed(2)} € (${(total*12).toFixed(2)} € al año)\nServicios detectados: ${lista.length}\n\nHAN SUBIDO DE PRECIO:\n${subidas.join('\n') || 'ninguno'}\n\nNUEVOS ESTE MES:\n${nuevas.join('\n') || 'ninguno'}\n\nYA NO APARECEN (¿los cancelaste?):\n${desaparecidas.join(', ') || 'ninguno'}\n\nTODOS:\n${lista.map(s => `• ${s.servicio}: ${num(s.importe).toFixed(2)} €`).join('\n')}`;
return [{ json: { _informe: true, informe } }, ...filas];
```
**IF**: `={{ $json._informe }}` es verdadero.
**Gmail** (rama true): Send a tu correo, Subject `Auditoría de suscripciones`, Message `={{ $json.informe }}`.
**Google Sheets** (rama false): Append Row en «Suscripciones».

## Cómo probarla
Ejecútala a mano el primer mes: no tendrá histórico, así que solo verás la lista. Revísala y borra a mano de la hoja lo que no sea una suscripción real.
Al segundo mes ya tendrás comparación. Ahí es donde empieza a valer.
Prueba a cambiar `newer_than:35d` por `newer_than:400d` una sola vez para hacer una foto grande del año y llevarte el susto de golpe.

## Qué puede salir mal
La IA se inventa importes si el asunto es ambiguo: por eso mandamos también el `snippet`. Revisa la primera hoja a mano.
Servicios que facturan en dólares: guarda la moneda y conviértela con la receta de divisas si quieres el total exacto.
Recibos que llegan a otra cuenta de correo o en papel: no los verá. Añade esas suscripciones a mano a la hoja con el mes correspondiente.
Coste de la IA: con 100 correos por ejecución, unos 0,02 € al mes. Nada.
Gmail limita a 500 resultados por búsqueda; con `newer_than:35d` no llegarás.

## Cuánto cuesta
Gmail y Sheets: gratis.
Claude: céntimos al mes.
n8n autoalojado: gratis.
