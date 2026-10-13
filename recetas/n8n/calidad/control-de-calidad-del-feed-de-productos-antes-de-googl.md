# Control de calidad del feed de productos antes de Googl…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Revisa tu feed de productos cada noche y detecta los que Google o Meta van a rechazar: sin GTIN, sin imagen, con títulos largos o precios que no cuadran.

## Qué es y qué hace

Flujo de n8n que cada noche descarga tu feed de productos en XML o CSV y aplica las reglas de Google y Meta: GTIN, imagen que carga, longitud del título y coherencia de precios. Entra la URL del feed y tus reglas de margen y marcas; sale una hoja con los productos rechazados probables y qué les falta. Sirve para tiendas que anuncian en Google Shopping o Meta.

## Cómo usarla

1. Pasa la URL del feed a n8n
2. Define tus reglas de margen, precio mínimo y marcas
3. Crea la hoja Calidad feed
4. Revisa el informe de errores cada mañana

## Cuándo usarla

Úsalo cuando anuncies productos en Google Shopping o en Meta y estés harto de ver «productos rechazados» en el panel sin saber cuáles ni por qué, perdiendo visibilidad y dinero.

## Cómo ganar dinero con ella

Cada producto rechazado es un anuncio que no se muestra. Recuperar 40 fichas rechazadas puede valer cientos de euros de tráfico al mes, sin pagar agencia.

- Revisión de feeds de producto para tiendas que anuncian en Google Shopping y Meta sin catálogo limpio.
- Servicio de corrección de fichas rechazadas para tiendas con cientos de productos.
- Auditoría inicial de feed antes de contratar campañas de anuncios de un nuevo cliente.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**: descarga tu feed de productos (XML o CSV), aplica las reglas de calidad que Google y Meta exigen, comprueba que cada imagen carga de verdad y te deja un informe con los productos a arreglar y qué les falta. Para tiendas online que anuncian catálogo.
**Para quién no es**: si vendes 5 productos o solo por redes sin catálogo.

### Lo que necesitas antes
- **La URL de tu feed**: en WooCommerce te la da un plugin de feeds; en Shopify, la app de Google & YouTube o un exportador; en PrestaShop, el módulo de exportación. Ábrela en el navegador y confirma que ves los productos.
- **n8n** con credenciales de **Google Sheets** y **Gmail**.
- **Hoja «Calidad feed»** con pestaña `errores`: `fecha`, `id`, `titulo`, `problema`, `gravedad`.
- **Tus reglas de negocio**: margen mínimo, precio mínimo aceptable, marcas obligatorias. Ténlas claras antes de programar.

### Los nodos, en orden
**1. Schedule Trigger** — Days, cada 1 día a las 3:00 (de madrugada el feed ya está regenerado). Timezone `Europe/Madrid`.
**2. HTTP Request** («Bajar feed») — GET la URL del feed, Response Format `Text`, Timeout `60000`.
**3. XML** — XML to JSON, Property Name `data`. (Si tu feed es CSV, sustituye este nodo por **Extract From File** con Operation `Extract From CSV`.)
**4. Code** («Normalizar»):
```js
const raiz = $input.first().json.data;
const items = raiz.rss ? raiz.rss.channel.item : (raiz.feed ? raiz.feed.entry : []);
const lista = Array.isArray(items) ? items : [items];
return lista.map(p => ({ json: {
  id: p['g:id'] || p.id,
  titulo: p.title || '',
  descripcion: p.description || '',
  precio: String(p['g:price'] || ''),
  imagen: p['g:image_link'] || '',
  gtin: p['g:gtin'] || '',
  marca: p['g:brand'] || '',
  disponibilidad: p['g:availability'] || '',
  enlace: p.link || ''
} }));
```
**5. Code** («Auditar») — aquí están las reglas de verdad:
```js
const salida = [];
for (const item of $input.all()) {
  const p = item.json;
  const fallos = [];
  if (!p.id) fallos.push('GRAVE: sin id');
  if (!p.titulo) fallos.push('GRAVE: sin titulo');
  if (p.titulo.length > 150) fallos.push('GRAVE: titulo de mas de 150 caracteres');
  if (p.titulo.length < 20) fallos.push('AVISO: titulo demasiado corto, pierdes busquedas');
  if (/[A-Z]{6,}/.test(p.titulo)) fallos.push('AVISO: hay MAYUSCULAS seguidas, Google lo penaliza');
  if (!p.descripcion || p.descripcion.length < 60) fallos.push('AVISO: descripcion muy corta');
  if (!p.imagen) fallos.push('GRAVE: sin imagen');
  if (!p.marca) fallos.push('GRAVE: sin marca');
  if (!p.gtin && !/personalizado|artesan/i.test(p.titulo)) fallos.push('AVISO: sin codigo GTIN o EAN');
  if (!/^\d+([.,]\d{1,2})? ?EUR$/i.test(p.precio.trim())) fallos.push('GRAVE: precio mal formateado, debe ser 39.90 EUR');
  const num = parseFloat(p.precio.replace(',', '.'));
  if (num && num < 1) fallos.push('GRAVE: precio sospechoso, menos de 1 euro');
  if (!['in stock', 'out of stock', 'preorder', 'backorder'].includes(String(p.disponibilidad).toLowerCase())) fallos.push('GRAVE: disponibilidad no valida');
  if (!/^https:\/\//.test(p.enlace)) fallos.push('GRAVE: el enlace no es https');
  if (fallos.length) salida.push({ json: { id: p.id, titulo: p.titulo, imagen: p.imagen, problema: fallos.join(' | '), gravedad: fallos.some(f => f.startsWith('GRAVE')) ? 'GRAVE' : 'AVISO' } });
}
return salida;
```
**6. Loop Over Items** — Batch Size 10, solo para comprobar imágenes sin saturar.
**7. HTTP Request** («Probar imagen») — Method HEAD, URL `{{ $json.imagen }}`, Never Error, Full Response, Timeout `10000`. Después un **IF**: si `{{ $json.statusCode }}` es mayor o igual a 400, añade al problema «GRAVE: la imagen no carga».
**8. Google Sheets** — Append Row en `errores` con fecha, id, titulo, problema, gravedad.
**9. Code** («Contar») — `const todos = $('Auditar').all(); const graves = todos.filter(i => i.json.gravedad === 'GRAVE').length; return [{ json: { total: todos.length, graves } }];`
**10. IF** — si `{{ $json.total }}` mayor que 0, sigue.
**11. Gmail** — Subject: `Feed: {{ $json.graves }} productos rechazables de {{ $json.total }} con incidencias`. Message con el enlace a la hoja y la instrucción de filtrar por GRAVE primero.

### Cómo probarla
- Ejecuta con el feed real y compara el número de «GRAVE» con los productos rechazados que ya te marca Google Merchant Center. Deberían parecerse mucho.
- Mete a mano un producto de prueba en tu tienda sin imagen y con el título en mayúsculas; regenera el feed y ejecuta: debe salir con las dos incidencias.
- Empieza mirando solo los GRAVE. Los AVISO son mejoras de conversión, no rechazos.

### Qué puede salir mal
- **Cada plataforma nombra los campos distinto**: si el nodo Normalizar devuelve campos vacíos, abre la salida del nodo XML, mira cómo se llaman de verdad (`g:price`, `price`, `product:price:amount`) y ajusta el Code.
- **Feeds enormes (más de 5.000 productos)**: en n8n cloud te puede dar problemas de memoria. Divide el feed por categorías o auto-aloja n8n con más RAM.
- **Comprobar todas las imágenes tarda mucho**: limita a los productos que ya tienen otros fallos, o comprueba solo 200 al azar cada noche con `.sort(() => Math.random() - 0.5).slice(0, 200)`.
- **Duplicados en la hoja**: cada noche vuelve a escribir los mismos errores. Añade una columna con la fecha y filtra por la última, o borra la pestaña al empezar con un nodo Google Sheets en Operation `Clear`.

### Cuánto cuesta
- **0 €**: n8n auto-alojado, Sheets y Gmail. Herramientas comerciales de auditoría de feeds cuestan desde 50 €/mes.
