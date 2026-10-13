# Auditoría automática de títulos, descripciones y H1 dup…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Recorre las URLs del sitemap, descarga el HTML de cada una y extrae title, meta description, h1, canonical y robots.

## Qué es y qué hace

Recorre las URLs del sitemap, descarga el HTML de cada una y extrae title, meta description, h1, canonical y robots. Marca lo que falta, lo duplicado y lo que se sale de la longitud recomendada, y escribe todo en una hoja con una columna de problemas ordenable. Entrada: URL del sitemap. Salida: una fila por página. Se monta en n8n; procesa las páginas por lotes para no saturar el servidor.

## Cómo usarla

1. Pega la URL del sitemap
2. Crea la hoja SEO on-page
3. Ajusta los límites de longitud
4. Reparte los problemas por orden de tráfico

## Cuándo usarla

Cuando tienes una web con muchas páginas o fichas de producto y quieres saber cuáles están mal etiquetadas sin pagar una herramienta SEO ni revisarlas a mano.

## Cómo ganar dinero con ella

Una auditoría on-page de 300 URLs cuesta entre 150 y 400 € en una agencia. Aquí se hace sola cada mes por 0 €.

- Auditoría on-page para tiendas con fichas de producto mal etiquetadas.
- Revisión de metadatos de blogs antes de una campaña de posicionamiento.
- Mantenimiento SEO mensual con informe de problemas para agencias con varios clientes.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Descarga el HTML de cada URL del sitemap, extrae `title`, `meta description`, los `h1`, el `canonical` y el `robots`, y detecta los problemas típicos.
Escribe todo en una hoja de cálculo con una columna de `problemas` que puedes ordenar y repartir al redactor o al cliente.

## Lo que necesitas antes
- n8n.
- La URL del sitemap de la web.
- Hoja `SEO on-page` en Google Sheets con columnas: `fecha`, `url`, `titulo`, `largo_titulo`, `descripcion`, `largo_desc`, `h1`, `canonical`, `problemas`.
- Credenciales de Google Sheets y Gmail en n8n.

## Los nodos, en orden
1. **Schedule Trigger** — `Months`, día 2, 04:00, timezone `Europe/Madrid`.
2. **HTTP Request** — GET al sitemap, `Response Format: Text`.
3. **XML** — `XML to JSON`.
4. **Code** — aplana a una lista de URLs.
5. **Split In Batches** — Batch Size `3`.
6. **HTTP Request** — GET a `{{ $json.loc }}`, `Response Format: Text`, header `User-Agent: Mozilla/5.0 (compatible; auditor-seo/1.0)`, `On Error: Continue`, `Timeout 20000`.
7. **Code** — extrae las etiquetas con expresiones regulares (código abajo).
8. Realimenta al **Split In Batches** hasta terminar; al salir del bucle, un segundo **Code** detecta duplicados comparando todos los títulos y descripciones entre sí.
9. **Google Sheets** — `Append or Update Row`, columna clave `url`, para que el informe se actualice en vez de crecer sin fin.
10. **IF** — `{{ $json.total_problemas }}` mayor que `0`.
11. **Gmail** — `Send` con el resumen: cuántas páginas sin descripción, cuántos títulos duplicados y el enlace a la hoja.

## El nodo Code de extracción
```js
const salida = [];
const limpia = (s) => (s || '').replace(/\s+/g, ' ').trim();
for (const item of $input.all()) {
  const html = item.json.data || '';
  const url = $('Split In Batches').item.json.loc;
  const t = limpia((html.match(/<title[^>]*>([\s\S]*?)<\/title>/i) || [])[1]);
  const d = limpia((html.match(/<meta[^>]+name=["']description["'][^>]+content=["']([^"']*)["']/i) || [])[1]);
  const h1s = [...html.matchAll(/<h1[^>]*>([\s\S]*?)<\/h1>/gi)].map(x => limpia(x[1].replace(/<[^>]+>/g, '')));
  const canon = limpia((html.match(/<link[^>]+rel=["']canonical["'][^>]+href=["']([^"']*)["']/i) || [])[1]);
  const robots = limpia((html.match(/<meta[^>]+name=["']robots["'][^>]+content=["']([^"']*)["']/i) || [])[1]);
  const p = [];
  if (!t) p.push('sin titulo'); else if (t.length < 30) p.push('titulo corto'); else if (t.length > 60) p.push('titulo largo');
  if (!d) p.push('sin descripcion'); else if (d.length > 155) p.push('descripcion larga');
  if (h1s.length === 0) p.push('sin H1'); else if (h1s.length > 1) p.push('varios H1');
  if (!canon) p.push('sin canonical');
  if (/noindex/i.test(robots)) p.push('NOINDEX');
  salida.push({ json: { fecha: new Date().toISOString().slice(0,10), url, titulo: t, largo_titulo: t.length, descripcion: d, largo_desc: d.length, h1: h1s.join(' || '), canonical: canon, problemas: p.join(', '), total_problemas: p.length } });
}
return salida;
```

## Cómo probarla
- Ejecútala sobre 10 URLs y compara a mano el título de dos de ellas con lo que ves en el navegador (botón derecho, Ver código fuente).
- Publica una página de prueba sin meta description: debe aparecer con `sin descripcion`.
- Comprueba que las páginas con `noindex` salen marcadas: es el error más caro y el que más se cuela.

## Qué puede salir mal
- **Webs hechas con React o Vue sin renderizado en servidor**: el HTML llega vacío y todo sale como problema. Comprueba primero si el `title` aparece en el código fuente; si no, este método no sirve y necesitas un renderizador.
- **Caracteres escapados**: `&amp;` o `&#8211;` aparecerán tal cual en la hoja; si molesta, añade un reemplazo en el Code.
- **Longitud en píxeles vs caracteres**: Google corta por anchura, no por letras. Los umbrales 60/155 son una guía, no una ley.
- **Sitemaps enormes**: por encima de 1.000 URLs, parte el trabajo por sub-sitemap y ejecuta uno por semana.

## Cuánto cuesta
0 €. Solo consume ancho de banda de tu propia web. En n8n Cloud vigila el número de ejecuciones de nodo si la web supera las 300 páginas.
