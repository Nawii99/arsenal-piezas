# Detector de precios y stocks imposibles antes de que se…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Guarda cada noche una foto de tu catálogo y la compara con la del día anterior: si un precio cae un 70% o un stock se dispara, te avisa antes que los cazagangas.

## Qué es y qué hace

Flujo de n8n que cada madrugada lee el precio y el stock de tus productos en WooCommerce o Shopify y guarda una foto en Google Sheets. La compara con la del día anterior y genera una hoja de alertas con variaciones bruscas, precios por debajo de coste o productos desaparecidos. Entra la API de lectura de tu tienda y una hoja de costes opcional; sale el aviso. Pensado para tiendas que importan datos de proveedores.

## Cómo usarla

1. Crea la credencial de solo lectura de tu tienda
2. Prepara las hojas Foto de hoy y Alertas
3. Programa el disparador a las 3:00
4. Revisa las alertas a mano durante una semana

## Cuándo usarla

Úsalo cuando sincronices catálogo con un proveedor o un Excel, cambies precios a menudo o hayas tenido ya algún susto con una promoción mal puesta.

## Cómo ganar dinero con ella

Un precio con la coma mal puesta puede irse en 40 pedidos en una hora. Una sola vez que lo pilles a tiempo paga años de esta automatización.

- Auditoría mensual de catálogo para tiendas online: revisas precios y stock y entregas un informe de errores y riesgos.
- Mantenimiento de catálogo para distribuidores que importan Excel de proveedores cada semana.
- Puesta en marcha del control de precios y stock para tiendas pequeñas, con formación al equipo.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada madrugada baja todos los productos con su precio y su stock, los guarda en una hoja y compara con la foto del día anterior. Marca variaciones bruscas de precio, precios por debajo de tu coste, productos que han desaparecido del catálogo y stocks que cambian de forma imposible. Para tiendas que importan datos de proveedores o tocan precios a mano.

## Lo que necesitas antes
- n8n.
- Credencial de lectura de tu tienda: WooCommerce REST API (WooCommerce > Ajustes > Avanzado > REST API) o Shopify Admin API con `read_products`.
- Dos hojas en el mismo documento de Google Sheets: «Foto de hoy» (sku, nombre, precio, stock) y «Alertas» (fecha, sku, nombre, aviso).
- Opcional pero muy recomendable: una hoja «Costes» con sku y tu precio de coste, para detectar ventas a pérdida.

## Los nodos, en orden
1. **Schedule Trigger** — Days, Hour: 3, Minute: 0. Timezone Europe/Madrid.
2. **WooCommerce** — Product > Get Many, Return All: on.
3. **Code** (nombre: «Normalizar»). Run Once for Each Item: `return { json: { sku: $json.sku || String($json.id), nombre: $json.name, precio: Number($json.price || 0), stock: Number($json.stock_quantity ?? -1) } };`
4. **Google Sheets** (nombre: «Foto de ayer») — Get Rows de la hoja «Foto de hoy» (todavía tiene los datos de ayer, porque aún no la hemos sobrescrito). Return All.
5. **Google Sheets** (nombre: «Costes») — Get Rows de la hoja «Costes».
6. **Code** (nombre: «Comparar»). Run Once for All Items.
```js
const hoy = $('Normalizar').all().map(i => i.json);
const ayer = $('Foto de ayer').all().map(i => i.json);
const costes = {}; $('Costes').all().forEach(i => costes[i.json.sku] = Number(i.json.coste));
const mapaAyer = {}; ayer.forEach(a => mapaAyer[a.sku] = a);
const alertas = [];
hoy.forEach(p => {
  const a = mapaAyer[p.sku];
  if (a) {
    const pa = Number(a.precio);
    if (pa > 0 && p.precio > 0) {
      const var_ = (p.precio - pa) / pa;
      if (var_ <= -0.4) alertas.push({ sku: p.sku, nombre: p.nombre, aviso: `Precio baja ${Math.round(var_*-100)}%: de ${pa} a ${p.precio} €` });
      if (var_ >= 0.5) alertas.push({ sku: p.sku, nombre: p.nombre, aviso: `Precio sube ${Math.round(var_*100)}%: de ${pa} a ${p.precio} €` });
    }
    if (p.precio === 0) alertas.push({ sku: p.sku, nombre: p.nombre, aviso: 'Precio a 0 €' });
    const sa = Number(a.stock);
    if (sa >= 0 && p.stock >= 0 && p.stock - sa > 500) alertas.push({ sku: p.sku, nombre: p.nombre, aviso: `Stock salta de ${sa} a ${p.stock}` });
  } else {
    alertas.push({ sku: p.sku, nombre: p.nombre, aviso: 'Producto NUEVO en el catálogo' });
  }
  const c = costes[p.sku];
  if (c && p.precio > 0 && p.precio < c * 1.05) alertas.push({ sku: p.sku, nombre: p.nombre, aviso: `Vendes a ${p.precio} € con coste ${c} €` });
});
const skusHoy = new Set(hoy.map(p => p.sku));
ayer.filter(a => !skusHoy.has(a.sku)).forEach(a => alertas.push({ sku: a.sku, nombre: a.nombre, aviso: 'Producto DESAPARECIDO del catálogo' }));
return alertas.map(x => ({ json: { fecha: new Date().toISOString().slice(0,10), ...x } }));
```
7. **Google Sheets** — Append Row a «Alertas».
8. **Code** (nombre: «Mensaje») — Run Once for All Items: `const a = $input.all().map(i => i.json); return a.length ? [{ json: { texto: '🚨 ' + a.length + ' avisos de catálogo:\n' + a.slice(0,15).map(x => '- ' + x.nombre + ': ' + x.aviso).join('\n') } }] : [];`
9. **Telegram** — `={{ $json.texto }}`.
10. **Google Sheets** (nombre: «Guardar foto nueva») — Operation: Delete Rows (o Clear) sobre «Foto de hoy» y después Append de los items de «Normalizar». Conéctalo AL FINAL, después de comparar, o perderás la referencia.

## Cómo probarla
Ejecuta una vez para llenar la foto inicial (saldrá todo como «producto NUEVO», es normal). Al día siguiente, baja el precio de un producto a la mitad en tu tienda y ejecuta a mano: debe llegarte el Telegram con ese producto.

## Qué puede salir mal
- **El orden de los nodos**: si guardas la foto nueva antes de comparar, no detectas nada. Es el error más típico.
- **Rebajas legítimas**: en Black Friday te llegará una avalancha. Añade en la hoja «Costes» una columna `ignorar` y filtra esos SKU, o sube el umbral esos días.
- **Productos variables**: los precios suelen estar en las variaciones; usa el endpoint de variaciones si vendes tallas o formatos.
- **Límite de celdas de Sheets**: con más de 2.000 productos ve a Airtable, Baserow o una base de datos; una hoja de 5 millones de celdas se atraganta.
- **Hora de ejecución**: ponla después de la sincronización nocturna de tu proveedor, no antes.

## Cuánto cuesta
Gratis con n8n auto-alojado, Sheets y Telegram. Si migras a Airtable, su plan gratuito llega a 1.000 registros por base.
