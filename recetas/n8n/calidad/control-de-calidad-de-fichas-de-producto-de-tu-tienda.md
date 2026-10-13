# Control de calidad de fichas de producto de tu tienda…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Revisa todo tu catálogo buscando fichas sin foto, sin descripción, con precio a cero o stock imposible, y te manda cada lunes la lista de lo que hay que arreglar.

## Qué es y qué hace

Baja todos los productos de tu tienda WooCommerce o Shopify, aplica una lista de reglas de calidad (foto, descripción, precio a cero, stock imposible) y escribe en una hoja solo los que fallan, con el motivo y el enlace para editarlos. Entrada: catálogo de la tienda; salida: hoja de incidencias semanal. Se monta en n8n con la API de WooCommerce o Shopify y Google Sheets.

## Cómo usarla

1. Crear la clave de API de WooCommerce o la app de Shopify
2. Crear la hoja QA catálogo
3. Probar con diez productos
4. Activar la revisión del lunes

## Cuándo usarla

Úsalo cuando tengas más de 30 productos, subas catálogos desde Excel o de un proveedor, o vendas también en Google Shopping y Meta, donde una ficha mala te tumba el anuncio.

## Cómo ganar dinero con ella

Un producto sin foto o sin descripción no vende y encima es rechazado por Google Merchant. Revisar 400 fichas a mano son 6 horas; esto son 0 minutos.

- Revisar catálogos de tiendas con cientos de fichas antes de campañas de Google Shopping.
- Ofrecer limpieza de catálogo a tiendas que suben productos desde Excel.
- Montar un control semanal de calidad para una tienda con varios proveedores.

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Baja todos los productos de tu tienda, les aplica una lista de reglas de calidad y escribe en una hoja solo los que fallan, con el motivo y el enlace para editarlos. Para tiendas WooCommerce o Shopify con catálogo que crece más rápido que tu tiempo.

## Lo que necesitas antes
- n8n.
- **WooCommerce**: en WordPress ve a WooCommerce > Ajustes > Avanzado > REST API > Añadir clave, permisos «Lectura», copia Consumer Key y Consumer Secret. En n8n crea la credencial «WooCommerce API» con la URL de tu tienda.
- **Si usas Shopify**: en Configuración > Aplicaciones > Desarrollar apps, crea una app con permiso `read_products` y usa la credencial «Shopify Access Token» de n8n; el resto del flujo es idéntico cambiando el nodo del paso 2.
- Hoja «QA catálogo» con columnas: fecha, sku, nombre, problemas, enlace.

## Los nodos, en orden
1. **Schedule Trigger** — Days, Day of Week: Monday, Hour: 7.
2. **WooCommerce** — Resource: Product, Operation: Get Many, Return All: on. En Options > Status: publish.
3. **Code** (nombre: «Reglas de calidad»). Run Once for Each Item.
```js
const p = $json;
const problemas = [];
const desc = (p.description || '').replace(/<[^>]*>/g,'').trim();
const corta = (p.short_description || '').replace(/<[^>]*>/g,'').trim();
if (!p.images || p.images.length === 0) problemas.push('sin foto');
if (p.images && p.images.length === 1) problemas.push('solo 1 foto');
if (!p.price || Number(p.price) <= 0) problemas.push('precio 0 o vacío');
if (p.regular_price && p.sale_price && Number(p.sale_price) >= Number(p.regular_price)) problemas.push('oferta que no es oferta');
if (desc.length < 200) problemas.push('descripción corta (' + desc.length + ' caracteres)');
if (!corta) problemas.push('sin descripción corta');
if (!p.sku) problemas.push('sin SKU');
if (p.manage_stock && Number(p.stock_quantity) < 0) problemas.push('stock negativo');
if (p.manage_stock && Number(p.stock_quantity) === 0 && p.stock_status === 'instock') problemas.push('stock 0 pero marcado disponible');
if (!p.categories || p.categories.length === 0) problemas.push('sin categoría');
if ((p.weight === '' || p.weight === '0') && p.shipping_required) problemas.push('sin peso para el envío');
if (p.name && p.name === p.name.toUpperCase()) problemas.push('título todo en mayúsculas');
return { json: { sku: p.sku || '-', nombre: p.name, problemas: problemas.join(' | '), enlace: p.permalink, fallos: problemas.length } };
```
4. **Filter** — Condition: Number `={{ $json.fallos }}` larger than 0.
5. **Sort** — Field: fallos, Order: Descending. Así arriba están los peores.
6. **Google Sheets** — Operation: Append or Update, Column to Match On: sku, mapeando fecha `={{ $now.format('yyyy-LL-dd') }}`, nombre, problemas y enlace.
7. **Code** (nombre: «Resumen») — Run Once for All Items: `const n = $input.all().length; const top = $input.all().slice(0,10).map(i => '- ' + i.json.nombre + ': ' + i.json.problemas).join('\n'); return [{ json: { n, top } }];`
8. **Gmail** — Send, Subject: `=QA catálogo: {{ $json.n }} fichas con fallos`, Message: `={{ $json.top }}`, y el enlace a la hoja.

## Cómo probarla
Antes de nada, edita un producto y quítale la foto o pon el precio a 0: al ejecutar debe salir el primero de la lista. Ejecuta con Return All desactivado y Limit 20 la primera vez para ver que las reglas no dan falsos positivos con tu forma de trabajar (por ejemplo, si vendes servicios sin peso, quita esa regla).

## Qué puede salir mal
- **Timeout con catálogos grandes**: si tienes más de 1.000 productos, cambia el paso 2 por Get Many con Limit 100 y mete un **Loop Over Items** paginando con el parámetro `page`.
- **Variaciones**: en Woo, las variaciones son productos aparte; si el precio está en la variación, el padre te saldrá como «precio 0». Añade `if (p.type === 'variable') return [];` al principio del Code o comprueba las variaciones por separado.
- **Clave de API con permisos de escritura**: no hace falta, usa solo lectura para no romper nada.
- **Se llena la hoja**: usa Append or Update con SKU como clave, así cada producto ocupa una fila y ves si sigue roto la semana siguiente.

## Cuánto cuesta
Gratis: la REST API de WooCommerce va incluida, Sheets y Gmail gratis. En Shopify también entra en cualquier plan. Solo pagas el sitio donde corre n8n.
