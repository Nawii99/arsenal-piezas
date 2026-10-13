# Validador del feed de productos antes de que Google o M…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Revisa tu feed de productos con las mismas reglas que aplica Google Merchant y Meta, y te da la lista de fichas con error antes de que te suspendan la cuenta.

## Qué es y qué hace

Descarga cada mañana el feed XML o CSV de productos que envías a Google Merchant o al catálogo de Meta, aplica reglas habituales de validación como título, precio, imagen y disponibilidad, y envía una lista con el ID del producto y el error. Entrada: URL pública del feed; salida: listado de errores. Se monta en n8n.

## Cómo usarla

1. Obtén la URL pública del feed
2. Crea la hoja errores_feed
3. Define las reglas en el nodo Code
4. Programa el cron de las 6:00

## Cuándo usarla

Úsalo si vendes online con anuncios de Shopping o catálogo de Meta y de vez en cuando te llegan avisos de «productos desaprobados».

## Cómo ganar dinero con ella

Cada producto desaprobado son ventas que no se muestran. Revisar 500 fichas a mano son horas; esto son 30 segundos cada noche.

- Control de feed para una tienda con más de quinientos productos en Google Shopping.
- Revisión del catálogo de Meta antes de cada campaña de anuncios.
- Validación de fichas importadas para un negocio con catálogo de proveedor.

**Precio orientativo:** 100–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Descarga tu feed de productos (el XML o CSV que ya das a Google Merchant Center o al catálogo de Meta), aplica las reglas de validación más habituales y te manda un listado con el ID del producto y el error concreto.
Para tiendas online con catálogo mediano o grande donde revisar ficha a ficha es inviable.

## Lo que necesitas antes
- n8n.
- La URL pública de tu feed. En Shopify suele ser la del canal de Google o la de una app de feeds; en WooCommerce, la del plugin de feeds. Debe abrirse en el navegador sin contraseña.
- Credenciales de Google Sheets y Gmail.
- Una hoja `errores_feed` con columnas: `fecha`, `id`, `titulo`, `error`.

## Los nodos, en orden
1. **Schedule Trigger**. Cron `0 6 * * *` (todas las mañanas a las 6, antes de que Google rastree).
2. **HTTP Request**. `GET` a la URL del feed. Options > Response > Response Format: `Text`. Never Error activado.
3. **XML**. Modo `XML to JSON`, Property Name `data`. (Si tu feed es CSV, sustituye este nodo por **Extract From File** en modo `From CSV`.)
4. **Code** (`Run Once for All Items`):
```javascript
const canal = $input.first().json.rss ? $input.first().json.rss.channel : null;
let items = canal ? canal.item : ($input.first().json.feed ? $input.first().json.feed.entry : []);
if (!Array.isArray(items)) items = [items];
const errores = [];
const texto = v => (v === undefined || v === null) ? '' : (typeof v === 'object' ? (v._ || '') : String(v));
for (const p of items) {
  const id = texto(p['g:id'] || p.id) || '(sin id)';
  const t = texto(p.title);
  const d = texto(p.description);
  const precio = texto(p['g:price']);
  const img = texto(p['g:image_link']);
  const disp = texto(p['g:availability']);
  const marca = texto(p['g:brand']);
  if (!t) errores.push({ id, titulo: t, error: 'Sin titulo' });
  else if (t.length < 15 || t.length > 150) errores.push({ id, titulo: t, error: 'Titulo de ' + t.length + ' caracteres (usa entre 15 y 150)' });
  if (t === t.toUpperCase() && t.length > 10) errores.push({ id, titulo: t, error: 'Titulo TODO EN MAYUSCULAS: Google lo penaliza' });
  if (d.length < 40) errores.push({ id, titulo: t, error: 'Descripcion demasiado corta (' + d.length + ')' });
  if (!/^\d+([.,]\d{1,2})?\s?EUR$/.test(precio)) errores.push({ id, titulo: t, error: 'Precio mal formado: "' + precio + '" (debe ser 19.99 EUR)' });
  if (!img.startsWith('https://')) errores.push({ id, titulo: t, error: 'Imagen sin https o vacia' });
  if (!['in_stock', 'out_of_stock', 'preorder', 'backorder'].includes(disp)) errores.push({ id, titulo: t, error: 'Disponibilidad invalida: "' + disp + '"' });
  if (!marca) errores.push({ id, titulo: t, error: 'Falta marca (g:brand)' });
}
return errores.map(e => ({ json: { fecha: new Date().toISOString().slice(0, 10), ...e } }));
```
5. **Google Sheets** `Append Row` en `errores_feed`.
6. **Aggregate**. Modo `All Item Data` para poder contar y resumir.
7. **IF**. `{{ $json.data.length }}` *larger* `0`.
8. **Gmail** `Send`. Asunto: `{{ $json.data.length }} fichas con error en el feed`. En el cuerpo pega los 20 primeros y enlaza la hoja completa.

## Cómo probarla
- Ejecuta a mano y compara el número de errores con los que te reporta Google Merchant Center en Diagnóstico. Deben parecerse mucho.
- Edita un producto poniendo el precio sin moneda y vuelve a lanzar: debe aparecer.
- Si te salen cientos de errores del mismo tipo, revisa el nombre de la etiqueta: puede que tu feed use `price` en vez de `g:price`.

## Qué puede salir mal
- **Nombres de etiqueta distintos**: no todos los feeds usan el prefijo `g:`. Abre el XML en el navegador y ajusta los nombres en el Code.
- **Feed enorme**: si pasa de 10.000 productos, el nodo XML puede quedarse sin memoria. Divide el feed por categorías o sube la memoria de n8n (`NODE_OPTIONS=--max-old-space-size=2048`).
- **Feed protegido**: si necesita usuario y contraseña, en el HTTP Request usa Authentication `Basic Auth`.
- **Reglas que cambian**: Google actualiza sus requisitos. Revisa el Code cada seis meses.

## Cuánto cuesta
0 €. Solo lectura de tu propio feed y escritura en una hoja de cálculo.
