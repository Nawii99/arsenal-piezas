# Auditoría de imágenes pesadas en tu web…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Rastrea las páginas de tu web, mide cuánto pesa cada imagen y te manda un informe con las que frenan la carga y hay que reexportar.

## Qué es y qué hace

Lee el sitemap de una web, entra en cada página, saca las etiquetas de imagen y pide el peso de cada una con una petición HEAD. Genera un informe ordenado de mayor a menor peso, marca las que pasan de 300 KB y avisa de las que no tienen texto alternativo. Entran URLs y salen filas en una hoja con veredicto, con n8n. Para fotógrafos que mantienen webs y para vender la auditoría como servicio.

## Cómo usarla

1. Localiza el sitemap de la web
2. Crea la hoja de auditoría
3. Programa el rastreo semanal en n8n
4. Revisa las veinte imágenes más pesadas

## Cuándo usarla

Úsalo cuando tu web o la de un cliente vaya lenta en móvil, cuando Google te avise de Core Web Vitals, o antes de entregar una web con tus fotos dentro.

## Cómo ganar dinero con ella

Un segundo más de carga tumba conversiones de forma medible. Detectar las 15 imágenes gordas de una web es una hora de trabajo que vale cientos de euros al cliente.

- Auditoría puntual de imágenes para webs de clientes, entregada como informe con prioridades, cobrada por web.
- Seguimiento mensual de peso y rendimiento de imágenes para tiendas y portfolios, por cuota.
- Plantilla de informe vendida a diseñadores que quieren añadir un servicio de optimización.

**Precio orientativo:** 100–250 € por auditoría. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee el sitemap de una web, entra en cada página, saca todas las etiquetas `<img>` con expresiones regulares, pide el peso de cada imagen con una petición HEAD y elabora un informe ordenado de mayor a menor.
Marca en rojo las que pasan de 300 KB y avisa de las que no llevan atributo `alt`. Es para fotógrafos que además montan o mantienen webs, y para quien quiera vender esto como servicio.

## Lo que necesitas antes
- La URL del sitemap de la web, normalmente `https://tuweb.com/sitemap.xml` o `/sitemap_index.xml`. Si no lo sabes, míralo en `https://tuweb.com/robots.txt`.
- Una hoja de Google Sheets `auditoria_imagenes` con columnas: `fecha`, `pagina`, `url_imagen`, `kb`, `tiene_alt`, `veredicto`.
- Credenciales de Google Sheets y Gmail en n8n. Nada de pago.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: `Weeks`, `Monday` a las `7`.
2. **HTTP Request** (renómbralo «Sitemap») — Method: `GET`, URL: `https://tuweb.com/sitemap.xml`, Response Format: `Text`.
3. **XML** — Mode: `XML to JSON`, Property Name: `data`.
4. **Code** — Mode: `Run Once for All Items`. Saca la lista de URLs del sitemap y la limita a 40 páginas para no eternizarse: ver primer bloque de código.
5. **Split In Batches** — Batch Size: `1`.
6. **HTTP Request** (renómbralo «Página») — URL: `{{ $json.url }}`, Response Format: `Text`. En Options activa `Ignore SSL Issues` si auditas una web en pruebas, y `Retry On Fail` con 2 intentos.
7. **Code** — Mode: `Run Once for Each Item`. Extrae las imágenes del HTML: segundo bloque de código.
8. **Split Out** — Field to Split Out: `imagenes`. Así cada imagen se convierte en un item.
9. **HTTP Request** (renómbralo «Peso») — Method: `HEAD`, URL: `{{ $json.src }}`, en Options activa «Include Response Headers and Status» y «Never Error» para que un 404 no tumbe el flujo.
10. **Code** — arma la fila final con el peso en KB y el veredicto.
11. **Google Sheets** — Operation: `Append Row`. Conecta la salida de vuelta al **Split In Batches** del paso 5.
12. **Gmail** (desde «done») — informe con el top 15 más pesadas.

## El código (nodo 4, sacar URLs del sitemap)
```javascript
const raiz = $json.data || {};
let urls = [];
if (raiz.urlset && raiz.urlset.url) {
  const lista = Array.isArray(raiz.urlset.url) ? raiz.urlset.url : [raiz.urlset.url];
  urls = lista.map(u => (typeof u.loc === 'string' ? u.loc : u.loc && u.loc['#text']) || '').filter(Boolean);
}
return urls.slice(0, 40).map(u => ({ json: { url: u } }));
```

## El código (nodo 7, extraer imágenes del HTML)
```javascript
const html = String($json.data || $json.body || '');
const pagina = $('Split In Batches').item.json.url;
const base = new URL(pagina);
const imagenes = [];
const re = /<img\b[^>]*>/gi;
let m;
while ((m = re.exec(html)) !== null) {
  const tag = m[0];
  const src = (tag.match(/\ssrc=["']([^"']+)["']/i) || [])[1];
  if (!src || src.startsWith('data:')) continue;
  const alt = (tag.match(/\salt=["']([^"']*)["']/i) || [])[1];
  let absoluta;
  try { absoluta = new URL(src, base).href; } catch (e) { continue; }
  imagenes.push({ src: absoluta, tiene_alt: alt !== undefined && alt.trim() !== '' ? 'si' : 'NO', pagina });
}
return { json: { pagina, imagenes } };
```

## Cómo probarla
- Lanza primero con `slice(0, 3)` en vez de 40 y mira la hoja: deben salir las imágenes de tres páginas con su peso real. Compáralo con lo que ves en el navegador (F12 › pestaña Red › columna Tamaño).
- Prueba con una web que uses de referencia para calibrar: una foto de portada de 1.800 px de ancho bien exportada debería quedar entre 120 y 250 KB.
- Comprueba que una imagen que devuelve 404 no rompe el flujo (por eso «Never Error»).

## Qué puede salir mal
- **Webs hechas con JavaScript**: si el HTML no trae las `<img>` porque las pinta React o similar, este método no las ve. Solución: audita el sitemap de imágenes (`/sitemap-image.xml`) si el CMS lo genera, o usa la API de PageSpeed Insights.
- **Carga diferida**: muchas plantillas ponen un pixel transparente en `src` y la foto real en `data-src` o `srcset`. Añade al código la búsqueda de `data-src` y quédate con la primera URL de `srcset`.
- **Sin cabecera de tamaño**: algunos servidores no mandan `content-length` en las respuestas HEAD. En ese caso cambia el método a `GET` con Response Format `File` y mide el binario; es más lento, hazlo solo con las dudosas.
- **Demasiadas peticiones**: si auditas una web ajena, no la martillees. Con Batch Size 1 y un **Wait** de 1 segundo vas fino y nadie te bloquea.
- **Sitemap índice**: si `sitemap.xml` solo contiene enlaces a otros sitemaps (`sitemapindex`), hay que hacer una vuelta más. Detéctalo en el código y lanza otra petición.

## Cuánto cuesta
- Todo gratis: n8n auto-alojado, Sheets y Gmail.
- Si lo vendes como servicio, una auditoría de este tipo se cobra sin problema entre 150 y 400 € y a ti te cuesta 10 minutos.
