# Cazador de enlaces rotos (404) en toda tu web…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Rastrea tu sitemap, extrae todos los enlaces de cada página y comprueba uno a uno cuáles dan error, apuntando en qué página está cada enlace roto.

## Qué es y qué hace

Lee el sitemap.xml de tu web, descarga cada página, extrae todos los enlaces internos y externos y comprueba su estado. Los que devuelven 404, 410, 500 o no responden se guardan en Google Sheets con la página donde aparecen, y te llega un correo resumen el primer día del mes. Para webs con blog o catálogo y muchos años de contenido.

## Cómo usarla

1. Localizar la URL del sitemap
2. Preparar la hoja Enlaces rotos
3. Montar el flujo mensual en n8n
4. Usar n8n auto-alojado si la web tiene más de 300 páginas

## Cuándo usarla

Úsalo cuando lleves años publicando, hayas migrado la web, cambiado URLs de productos o enlaces a proveedores y colaboradores que pueden haber cerrado.

## Cómo ganar dinero con ella

Los 404 se comen presupuesto de rastreo de Google y espantan clientes. Ahorra 2-3 horas mensuales de revisión manual y sustituye herramientas SEO de 20-100 €/mes.

- Revisión mensual de enlaces rotos para webs de clientes con blog o catálogo grande.
- Limpieza de enlaces tras una migración o cambio de URLs de producto.
- Servicio de mantenimiento SEO técnico con informe de errores 404 incluido.

**Precio orientativo:** 80–200 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee tu `sitemap.xml`, descarga cada página, saca todos los `href` del HTML, quita duplicados y comprueba el estado de cada enlace (interno y externo).
Los que devuelven 404, 410, 500 o no responden se guardan en una hoja indicando el enlace roto y la página donde aparece, y te llega un correo resumen el primer día del mes.

## Lo que necesitas antes
- La URL de tu sitemap: casi siempre `https://tudominio.com/sitemap.xml` o `/sitemap_index.xml` (Yoast y Rank Math usan el segundo). Ábrela en el navegador para confirmarlo.
- Hoja de Google «Enlaces rotos» con columnas: fecha, enlace_roto, codigo, pagina_origen, texto_ancla.
- n8n (nube gratuita o auto-alojado) y credencial de Google Sheets.
- Si tu web es grande (más de 300 páginas), auto-alojado: la nube gratuita se queda corta de tiempo de ejecución.

## Los nodos, en orden
1. **Schedule Trigger** — Months, Trigger at Day of Month: 1, Hour: 4.
2. **HTTP Request** (renómbralo «Sitemap») — GET a tu sitemap. Options > Response > Response Format: `Text`, Output Field Name: `xml`.
3. **Code** (renómbralo «URLs del sitemap») — extrae las `<loc>` y, si es un índice, no pasa nada: el código detecta sub-sitemaps y los marca. Ver código.
4. **Split In Batches / Loop Over Items** — Batch Size: 1 (salida loop → paso 5; salida done → paso 9).
5. **HTTP Request** (renómbralo «Bajar página») — GET `={{ $json.url }}`; Response Format: `Text`, Output Field: `html`; Timeout 20000; Settings: `On Error: Continue`.
6. **Code** (renómbralo «Extraer enlaces») — saca href y texto del enlace. Ver código.
7. **HTTP Request** (renómbralo «Comprobar enlace») — Method: GET; URL `={{ $json.enlace }}`; Options > Response > Never Error: activado, Include Response Headers and Status: activado; Timeout 15000; Header `User-Agent`: `Mozilla/5.0 (compatible; RevisorEnlaces/1.0)`; Settings: `On Error: Continue`, Execute Once: desactivado.
8. **IF** — Number: `={{ $json.statusCode }}` is greater than or equal to 400 → salida true a **Google Sheets** (Append Row en «Enlaces rotos»); la salida del Sheets vuelve al Loop del paso 4.
9. **Gmail** — Subject: `Enlaces rotos en tudominio.com`; Message: resumen con `={{ $items().length }}` o el HTML que montes en un Code final.

## El código de «URLs del sitemap»
```js
const xml = $json.xml || '';
const locs = [...xml.matchAll(/<loc>\s*([^<]+?)\s*<\/loc>/g)].map(m => m[1]);
const paginas = locs.filter(u => !u.endsWith('.xml'));
const subsitemaps = locs.filter(u => u.endsWith('.xml'));
if (paginas.length === 0 && subsitemaps.length > 0) { throw new Error('Es un índice de sitemaps. Usa uno de estos: ' + subsitemaps.join(', ')); }
return paginas.slice(0, 500).map(url => ({ json: { url } }));
```

## El código de «Extraer enlaces»
```js
const html = $json.html || '';
const origen = $('Loop Over Items').item.json.url;
const base = new URL(origen);
const vistos = new Set();
const salida = [];
for (const m of html.matchAll(/<a\s[^>]*href=["']([^"'#]+)["'][^>]*>(.*?)<\/a>/gis)) {
  let href = m[1].trim();
  if (href.startsWith('mailto:') || href.startsWith('tel:') || href.startsWith('javascript:')) continue;
  try { href = new URL(href, base).toString(); } catch (e) { continue; }
  if (vistos.has(href)) continue;
  vistos.add(href);
  const ancla = m[2].replace(/<[^>]+>/g, '').trim().slice(0, 80);
  salida.push({ json: { enlace: href, pagina_origen: origen, texto_ancla: ancla, fecha: new Date().toISOString().slice(0, 10) } });
}
return salida;
```

## Cómo probarla
- Sustituye el Schedule Trigger por «Execute Workflow Trigger» o pulsa «Test workflow» con el `.slice(0, 500)` bajado a `.slice(0, 3)` para probar con tres páginas.
- Mete a propósito en una página un enlace a `https://tudominio.com/esto-no-existe` y comprueba que aparece en la hoja con código 404.
- Cuando funcione, sube el slice al número real de páginas.

## Qué puede salir mal
- **Muchos falsos positivos con enlaces externos**: LinkedIn, Amazon o Instagram devuelven 403 a los robots. Filtra en el IF con `statusCode` distinto de 403 y 999, o comprueba solo los internos añadiendo `if (!href.startsWith(base.origin)) continue;`.
- **Tarda una eternidad**: reduce a las 100 páginas más visitadas o parte el flujo en dos (primero recoger enlaces en una hoja, luego comprobarlos otro día).
- **Tu propio hosting te bloquea por exceso de peticiones**: añade un nodo Wait de 1 segundo dentro del bucle.
- **Web hecha con JavaScript (React, Vue) sin server-side rendering**: el HTML llega vacío; esta receta no sirve, necesitarás el sitemap y comprobar solo esas URLs.
- **Duplicados en la hoja**: antes del Append, usa Operation `Append or Update` con columna de coincidencia `enlace_roto`.

## Cuánto cuesta
- Todo gratis: n8n auto-alojado, Google Sheets y Gmail.
- Si lo pones en n8n Cloud gratuito, cada enlace comprobado no cuenta como ejecución (solo el flujo entero), pero sí el límite de 5 minutos de ejecución del plan gratuito: ahí conviene auto-alojar.
