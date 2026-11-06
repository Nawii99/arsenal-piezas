# Informe semanal de velocidad con PageSpeed en una hoja…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Cada lunes mide tus páginas clave con la API oficial de Google PageSpeed, guarda las puntuaciones en una hoja y te avisa si alguna cae por debajo de 70. Para quien cuida la velocidad.

## Qué es y qué hace

Cada lunes pide a la API de PageSpeed Insights la puntuación móvil y las métricas Core Web Vitals (LCP, CLS, INP) de 5 a 15 URLs que tú elijas, y añade una fila por página y semana en Google Sheets. Si una página baja de 70 puntos o empeora más de 10 respecto a la semana anterior, te envía un correo con las páginas y la métrica afectada. Es gratis con clave de API.

## Cómo usarla

1. Crear la clave de PageSpeed Insights API
2. Preparar la hoja Velocidad con pestañas urls y medidas
3. Montar el flujo semanal en n8n
4. Revisar el primer informe

## Cuándo usarla

Úsalo cuando dependas del SEO o de campañas de pago, después de rediseñar la web, o si sospechas que un plugin nuevo te ha ralentizado la tienda.

## Cómo ganar dinero con ella

Cada segundo de carga extra hunde la conversión. Detectar la caída en días en vez de meses evita quemar presupuesto de anuncios y sustituye herramientas de 40-90 €/mes.

- Vigilancia de velocidad para tiendas online que invierten en anuncios y necesitan páginas rápidas.
- Informe mensual de Core Web Vitals para agencias con varios clientes.
- Auditoría de rendimiento tras un rediseño, con seguimiento semanal durante tres meses.

**Precio orientativo:** 100–200 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recorre una lista de URLs tuyas, pide a Google la puntuación de rendimiento en móvil y las métricas Core Web Vitals (LCP, CLS, INP), y añade una fila por página y semana a una hoja de cálculo.
Si alguna página baja de 70 puntos o empeora más de 10 puntos respecto a la semana anterior, te llega un correo con la lista de páginas afectadas y qué métrica se ha estropeado.

## Lo que necesitas antes
- Clave de API de PageSpeed: entra en `console.cloud.google.com`, crea un proyecto, ve a «APIs y servicios > Biblioteca», activa «PageSpeed Insights API», y en «Credenciales > Crear credenciales > Clave de API» copia la clave. Es gratis.
- Hoja de Google llamada «Velocidad web» con dos pestañas: `urls` (columna `url`) y `medidas` (columnas: fecha, url, score, lcp, cls, inp).
- En la pestaña `urls` mete entre 5 y 15 páginas: portada, categoría principal, ficha de producto, artículo top, página de contacto.
- Credencial Google Sheets OAuth2 en n8n y una credencial Gmail OAuth2 (o usa el nodo Send Email con tu SMTP).

## Los nodos, en orden
1. **Schedule Trigger** — Weeks, Trigger on Weekdays: Monday, Hour: 7, Minute: 0.
2. **Google Sheets** (renómbralo «Leer URLs») — Operation: Get Row(s); Document: «Velocidad web»; Sheet: `urls`.
3. **Split In Batches** (en n8n nuevo se llama **Loop Over Items**) — Batch Size: 1. La salida «loop» va al paso 4; la salida «done» va al paso 8.
4. **HTTP Request** (renómbralo «PageSpeed») — Method: GET; URL: `https://www.googleapis.com/pagespeedonline/v5/runPagespeed`; Send Query Parameters: activado, con `url` = `={{ $json.url }}`, `strategy` = `mobile`, `category` = `performance`, `key` = TU_CLAVE. Options: Timeout 120000 ms; Settings del nodo: `On Error: Continue`, `Retry On Fail`: 2 intentos, `Wait Between Tries`: 5000.
5. **Code** (renómbralo «Extraer métricas») — ver código abajo.
6. **Google Sheets** (renómbralo «Guardar») — Operation: Append Row; Sheet: `medidas`; mapeo manual de fecha, url, score, lcp, cls, inp.
7. **Wait** — Amount: 8, Unit: Seconds. Su salida vuelve al nodo Loop Over Items (paso 3).
8. **Code** (renómbralo «Buscar suspensos») — filtra las filas con `score < 70` a partir de `$('Extraer métricas').all()`.
9. **IF** — Condition: Number, `={{ $json.total }}` is greater than 0.
10. **Gmail** — To: tu correo; Subject: `Velocidad web: {{ $json.total }} páginas por debajo de 70`; Message Type: HTML; Message: `={{ $json.html }}`.

## El código del nodo «Extraer métricas»
```js
const r = $json.lighthouseResult;
if (!r) { return [{ json: { fecha: new Date().toISOString().slice(0,10), url: $('Loop Over Items').item.json.url, score: 0, lcp: 0, cls: 0, inp: 0, error: true } }]; }
const a = r.audits;
return [{ json: {
  fecha: new Date().toISOString().slice(0, 10),
  url: r.finalUrl,
  score: Math.round((r.categories.performance.score || 0) * 100),
  lcp: a['largest-contentful-paint']?.numericValue ? Math.round(a['largest-contentful-paint'].numericValue) / 1000 : 0,
  cls: a['cumulative-layout-shift']?.numericValue || 0,
  inp: a['interaction-to-next-paint']?.numericValue || a['total-blocking-time']?.numericValue || 0
} }];
```

## El código del nodo «Buscar suspensos»
```js
const filas = $('Extraer métricas').all().map(i => i.json);
const malas = filas.filter(f => f.score < 70);
const html = malas.map(f => `<li><b>${f.url}</b> — ${f.score}/100 · LCP ${f.lcp}s · CLS ${f.cls.toFixed(3)}</li>`).join('');
return [{ json: { total: malas.length, html: `<p>Páginas lentas esta semana:</p><ul>${html}</ul>` } }];
```

## Cómo probarla
- Pon una sola URL en la pestaña `urls` y ejecuta con «Test workflow». Comprueba que la fila aparece en `medidas` con un score entre 0 y 100.
- Compara ese número con el que da `pagespeed.web.dev` a mano: deben parecerse (±5 puntos, la medición varía).
- Añade el resto de URLs y lánzalo entero antes de activarlo.

## Qué puede salir mal
- **Error 429 «rate limit»**: la API gratuita permite 25.000 consultas al día pero solo 240 por minuto; el nodo Wait de 8 segundos lo evita. No lo quites.
- **Timeout**: analizar una página tarda 20-60 s. Si falla, sube Timeout a 180000 ms.
- **La puntuación baila 10 puntos entre semanas**: es normal, PageSpeed simula un móvil de gama media. Fíjate en la tendencia, no en el número suelto.
- **Fila vacía**: normalmente la URL redirige o está protegida por contraseña; usa la URL final con `https://` y sin parámetros.
- **Quieres escritorio también**: duplica el nodo HTTP Request con `strategy=desktop` y una pestaña `medidas_desktop`.

## Cuánto cuesta
- API de PageSpeed: gratis, sin tarjeta.
- Google Sheets y Gmail: gratis.
- n8n: entra de sobra en el plan gratuito (unas 60 ejecuciones al mes).
