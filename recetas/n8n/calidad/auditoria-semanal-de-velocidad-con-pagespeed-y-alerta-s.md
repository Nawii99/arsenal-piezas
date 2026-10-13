# Auditoría semanal de velocidad con PageSpeed y alerta s…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Cada lunes mide la velocidad real de tus páginas clave en móvil con la API de Google y te avisa solo si la nota baja respecto a la semana pasada.

## Qué es y qué hace

Cada lunes llama a la API de PageSpeed Insights para tus URLs importantes en móvil, guarda la nota y las métricas Core Web Vitals en una hoja y avisa si la nota cae más de 8 puntos respecto a la semana anterior. Entrada: lista de URLs y clave gratuita de la API; salida: histórico y alerta. Se monta en n8n con HTTP Request, Sheets y Gmail.

## Cómo usarla

1. Crear la clave de PageSpeed en Google Cloud
2. Listar tus URLs clave
3. Probar una medición manual
4. Activar el aviso semanal

## Cuándo usarla

Úsalo cuando instales plugins o cambies la plantilla con frecuencia, o cuando notes que la gente entra a la web pero se va sin hacer nada.

## Cómo ganar dinero con ella

Cada segundo de más en móvil se lleva alrededor de un 7-10% de las conversiones. Ver la caída la semana que ocurre evita meses vendiendo menos sin saber por qué.

- Medir la velocidad de tiendas y webs de pymes con un informe mensual.
- Ofrecer vigilancia de Core Web Vitals tras cambios de plantilla o plugins.
- Montar un tablero de velocidad para una agencia con varios clientes.

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Llama a la API de PageSpeed Insights para tus URLs importantes, guarda la nota y las métricas Core Web Vitals en una hoja y te avisa si la nota cae más de 8 puntos respecto a la medición anterior. Para dueños de tienda o web que van tocando plugins sin saber qué rompen.

## Lo que necesitas antes
- n8n.
- Clave de API de PageSpeed: entra en Google Cloud Console, crea un proyecto, ve a APIs y servicios > Biblioteca, busca «PageSpeed Insights API», dale a Habilitar, y luego en Credenciales > Crear credenciales > Clave de API. Es gratis (25.000 consultas al día).
- Hoja «Velocidad web» con columnas: fecha, url, nota, lcp, cls, inp.

## Los nodos, en orden
1. **Schedule Trigger** — Days, Day of Week: Monday, Hour: 5.
2. **Code** (nombre: «URLs»). `return ['https://tudominio.es/','https://tudominio.es/producto/estrella','https://tudominio.es/contacto'].map(u => ({ json: { url: u } }));`
3. **HTTP Request** — GET `=https://www.googleapis.com/pagespeedonline/v5/runPagespeed`. En Options > Query Parameters añade: `url` = `={{ $json.url }}`, `strategy` = `mobile`, `category` = `performance`, `key` = tu clave. Timeout: 120000 (tarda de verdad). Never Error: on. En Settings del nodo activa Retry On Fail: 3 intentos, Wait Between Tries 5000 ms.
4. **Code** (nombre: «Extraer métricas»). Run Once for Each Item.
```js
const lr = $json.lighthouseResult || {};
const a = lr.audits || {};
return { json: {
  fecha: new Date().toISOString().slice(0,10),
  url: lr.finalUrl || $('URLs').item.json.url,
  nota: Math.round((lr.categories?.performance?.score ?? 0) * 100),
  lcp: a['largest-contentful-paint']?.numericValue ? +(a['largest-contentful-paint'].numericValue/1000).toFixed(2) : null,
  cls: a['cumulative-layout-shift']?.numericValue ?? null,
  inp: a['total-blocking-time']?.numericValue ?? null
} };
```
5. **Google Sheets** (nombre: «Histórico») — Operation: Get Rows de «Velocidad web» para leer la última nota de esa URL. Filters > Lookup Column: url, Lookup Value: `={{ $json.url }}`.
6. **Code** (nombre: «Comparar»).
```js
const actual = $('Extraer métricas').item.json;
const filas = $input.all().map(i => i.json).filter(f => f.url === actual.url);
const previa = filas.length ? Number(filas[filas.length-1].nota) : null;
const caida = previa !== null ? previa - actual.nota : 0;
return { json: { ...actual, previa, caida, alerta: caida >= 8 || actual.nota < 40 } };
```
7. **Google Sheets** — Append Row con la fila nueva.
8. **IF** — Boolean `={{ $json.alerta }}` is true.
9. **Telegram** — `=🐌 {{ $json.url }} ha bajado de {{ $json.previa }} a {{ $json.nota }} puntos. LCP {{ $json.lcp }}s. Mira qué instalaste esta semana.`

## Cómo probarla
Ejecútalo dos lunes seguidos, o dos veces el mismo día a mano: la segunda vez ya tiene con qué comparar. Para forzar la alerta, edita a mano la nota de la hoja poniendo 95 y vuelve a lanzarlo.

## Qué puede salir mal
- **Error 429 (demasiadas peticiones)**: sin clave el límite es ridículo. Asegúrate de que el parámetro `key` está puesto y no vayas más de una vez por semana y URL.
- **La medición varía sola ±5 puntos**: es normal, por eso el umbral es 8 y no 2.
- **Timeout**: PageSpeed puede tardar más de un minuto por URL; sube el Timeout y activa los reintentos.
- **Solo mides móvil**: es lo correcto para la mayoría de negocios en España, pero puedes duplicar el HTTP Request con `strategy=desktop` si vendes B2B.

## Cuánto cuesta
Gratis: la API de PageSpeed no se cobra en estos volúmenes y Sheets tampoco. Solo pagarías el hosting de n8n (5 €/mes de VPS) si no lo tienes ya.
