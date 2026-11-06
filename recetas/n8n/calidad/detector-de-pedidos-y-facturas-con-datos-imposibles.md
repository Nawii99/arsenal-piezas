# Detector de pedidos y facturas con datos imposibles…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Revisa cada noche los pedidos y facturas del día buscando importes raros, IVA mal calculado, descuentos excesivos o direcciones incompletas antes de que lleguen al cliente.

## Qué es y qué hace

Flujo de n8n que cada noche descarga los pedidos y facturas del día desde tu tienda o facturador y aplica comprobaciones de IVA, márgenes, descuentos y datos fiscales o de dirección. Entra la API de pedidos y tus reglas; sale una hoja de alertas con la gravedad de cada caso. Sirve para detectar cupones mal configurados o facturas con IVA erróneo antes del cierre.

## Cómo usarla

1. Crea el acceso a la API de tu tienda o facturador
2. Define las reglas de IVA, descuentos y direcciones
3. Prueba con los pedidos de la última semana
4. Que lo revise un profesional (fiscal y contable)

## Cuándo usarla

Úsalo cuando factures a diario y ya te haya pasado enviar una factura con el IVA mal, un pedido con 0 € por un cupón mal configurado o un envío a una dirección sin código postal.

## Cómo ganar dinero con ella

Un cupón mal puesto puede regalarte el catálogo en una noche. Detectarlo a las pocas horas, y no en el cierre del mes, evita pérdidas directas y correcciones fiscales.

- Control diario de facturación para tiendas online que emiten muchas facturas al mes.
- Revisión mensual de pedidos y cupones para negocios con promociones frecuentes.
- Auditoría de IVA y datos fiscales para pymes antes de cerrar cada trimestre.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**: baja los pedidos y facturas del día, aplica una batería de comprobaciones aritméticas y de coherencia (IVA, márgenes, descuentos, datos fiscales, direcciones) y te avisa solo de lo que huele mal. Para tiendas online y negocios que emiten muchas facturas.
**Para quién no es**: si emites 5 facturas al mes y las miras una a una.

### Lo que necesitas antes
- **Acceso a tus pedidos por API**: en Shopify, Settings > Apps > Develop apps > crea una app privada con permiso `read_orders` y copia el Admin API access token. En WooCommerce, WooCommerce > Ajustes > Avanzado > REST API, generas Consumer Key y Secret. En Holded, Quaderno o Facturascripts, busca «API» en ajustes.
- **n8n** con credencial Header Auth (Shopify: cabecera `X-Shopify-Access-Token`).
- **Hoja «Control facturación»** con pestaña `alertas`: `fecha`, `pedido`, `cliente`, `importe`, `problema`, `gravedad`.
- **Tus reglas escritas antes de programar**: IVA que aplicas (21%, 10%, 4%, 0% intracomunitario), descuento máximo autorizado (por ejemplo 30%), ticket medio y ticket máximo razonable, y si vendes a empresas de la UE (entonces necesitas el NIF-IVA).

### Los nodos, en orden
**1. Schedule Trigger** — Days, cada 1 día a las 23:30. Timezone `Europe/Madrid`.
**2. HTTP Request** («Bajar pedidos») — Shopify: GET `https://TUTIENDA.myshopify.com/admin/api/2024-10/orders.json?status=any&created_at_min={{ $now.minus(1, 'day').toISO() }}&limit=250`. Authentication: Generic > Header Auth con `X-Shopify-Access-Token`. Options: Never Error, Full Response.
**3. Split Out** — Field to Split Out: `body.orders`. Así tratas un pedido por item.
**4. Code** («Auditar pedidos»):
```js
const DESCUENTO_MAX = 0.30;
const TICKET_MAX = 2000;
const IVAS_VALIDOS = [0, 4, 10, 21];
const salida = [];
for (const item of $input.all()) {
  const o = item.json;
  const p = [];
  const total = Number(o.total_price || 0);
  const subtotal = Number(o.subtotal_price || 0);
  const impuestos = Number(o.total_tax || 0);
  const descuento = Number(o.total_discounts || 0);
  if (total === 0) p.push({ t: 'Pedido de 0 euros', g: 'GRAVE' });
  if (total < 0) p.push({ t: 'Pedido con importe negativo', g: 'GRAVE' });
  if (total > TICKET_MAX) p.push({ t: 'Ticket de ' + total + ' euros, muy por encima de lo normal. Puede ser fraude o un error de cantidad', g: 'GRAVE' });
  if (subtotal > 0 && descuento / subtotal > DESCUENTO_MAX) p.push({ t: 'Descuento del ' + Math.round(descuento / subtotal * 100) + '%, por encima del maximo autorizado', g: 'GRAVE' });
  if (subtotal > 0 && impuestos > 0) {
    const tipo = Math.round(impuestos / (subtotal - descuento) * 100);
    if (!IVAS_VALIDOS.includes(tipo)) p.push({ t: 'El IVA sale al ' + tipo + '%, que no es un tipo valido en Espana', g: 'GRAVE' });
  }
  if (subtotal > 0 && impuestos === 0) {
    const pais = o.shipping_address ? o.shipping_address.country_code : '';
    const nifIva = (o.note_attributes || []).find(n => /vat|nif|cif/i.test(n.name));
    if (pais === 'ES') p.push({ t: 'Venta en Espana sin IVA', g: 'GRAVE' });
    else if (!nifIva) p.push({ t: 'Venta exenta a ' + pais + ' sin NIF-IVA registrado', g: 'GRAVE' });
  }
  const dir = o.shipping_address;
  if (o.shipping_lines && o.shipping_lines.length && dir) {
    if (!dir.zip || String(dir.zip).length < 4) p.push({ t: 'Direccion sin codigo postal valido', g: 'AVISO' });
    if (!dir.phone && !o.phone) p.push({ t: 'Envio sin telefono de contacto, la agencia lo devolvera', g: 'AVISO' });
    if (!dir.address1 || dir.address1.length < 6) p.push({ t: 'Direccion demasiado corta', g: 'AVISO' });
  }
  if (o.email && !/^[^\s@]+@[^\s@]+\.[a-z]{2,}$/i.test(o.email)) p.push({ t: 'Email del cliente invalido, no recibira la confirmacion', g: 'AVISO' });
  for (const li of (o.line_items || [])) {
    if (Number(li.price) === 0) p.push({ t: 'Linea gratis: ' + li.title, g: 'AVISO' });
    if (Number(li.quantity) > 20) p.push({ t: 'Cantidad rara: ' + li.quantity + ' unidades de ' + li.title, g: 'AVISO' });
  }
  for (const x of p) salida.push({ json: { pedido: o.name || o.id, cliente: (o.customer ? (o.customer.first_name + ' ' + o.customer.last_name) : o.email), importe: total, problema: x.t, gravedad: x.g } });
}
return salida;
```
**5. Google Sheets** — Append Row en `alertas` con la fecha.
**6. Code** («Contar graves») — `const g = $input.all().filter(i => i.json.gravedad === 'GRAVE'); return [{ json: { graves: g.length, detalle: g.slice(0, 5).map(i => i.json.pedido + ': ' + i.json.problema).join(' // ') } }];`
**7. IF** — si `{{ $json.graves }}` mayor que 0.
**8. Telegram** — `💶 {{ $json.graves }} pedidos con problemas graves hoy. {{ $json.detalle }}. Revisa antes de facturar.`
**9. (Opcional) Gmail** — envío diario del resumen aunque no haya graves, para que te acostumbres a mirarlo 30 segundos.

### Cómo probarla
- Crea un pedido de prueba en tu tienda con un cupón del 90%: debe saltar como GRAVE.
- Crea otro con dirección sin código postal: debe salir como AVISO.
- Ejecuta contra los últimos 30 días cambiando `minus(1, 'day')` por `minus(30, 'days')` una sola vez: verás si tus reglas generan demasiado ruido y podrás afinar los umbrales antes de dejarlo diario.

### Qué puede salir mal
- **Demasiadas alertas los primeros días**: es normal, tus reglas son demasiado estrictas. Sube TICKET_MAX y DESCUENTO_MAX hasta que solo salte lo que de verdad te preocuparía.
- **El IVA calculado no cuadra por los gastos de envío**: si tu tienda aplica IVA al envío, el cálculo del tipo se desvía. Resta `total_shipping_price_set` del subtotal o usa `tax_lines[0].rate` directamente, que Shopify te da ya calculado.
- **Paginación**: con más de 250 pedidos al día, la API devuelve una cabecera `Link` con la siguiente página. Añade un bucle o baja la ventana a 12 horas y ejecuta dos veces al día.
- **Zonas horarias**: `created_at_min` va en ISO con zona. Si te faltan los pedidos de última hora, es que el servidor de n8n está en UTC y tu tienda en Madrid: usa `$now.setZone('Europe/Madrid').minus(1, 'day').toISO()`.
- **Pedidos de prueba propios**: fíltralos por email o por la etiqueta `test` para que no ensucien el informe.

### Cuánto cuesta
- API de Shopify o WooCommerce: **0 €**, va incluida en tu plan.
- n8n auto-alojado, Sheets y Telegram: **0 €**. Total **0 €/mes**.
