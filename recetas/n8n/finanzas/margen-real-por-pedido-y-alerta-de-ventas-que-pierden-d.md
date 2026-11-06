# Margen real por pedido y alerta de ventas que pierden d…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Calcula el margen verdadero de cada pedido restando coste del producto, comisión de la pasarela, envío, embalaje y descuentos, y te avisa de los pedidos que te dejan menos de lo que crees.

## Qué es y qué hace

Cada noche descarga los pedidos del día de tu tienda con la API de WooCommerce o Shopify, busca el coste de cada producto en Google Sheets y resta comisión de pasarela, envío y embalaje. Calcula el margen en euros y porcentaje, guarda una fila por pedido y avisa de los que quedan por debajo del margen mínimo. Para tiendas online pequeñas y dropshipping.

## Cómo usarla

1. Crear las claves de API en WooCommerce o Shopify
2. Preparar las hojas Costes y Parametros
3. Montar el flujo nocturno en n8n
4. Que lo revise un profesional

## Cuándo usarla

Cuando vendes online con envíos y descuentos y no sabes si el pedido de 25 euros con envío gratis te está costando dinero.

## Cómo ganar dinero con ella

Descubrir que una referencia o un tramo de precio pierde dinero y corregirlo puede mover el margen del negocio varios puntos sin vender más.

- Análisis de rentabilidad por pedido para tiendas online que venden con envío gratis.
- Revisión semanal de márgenes con ajuste de precios y envío para dropshippers.
- Panel de margen por referencia que el consultor de e-commerce entrega al cliente cada mes.

**Precio orientativo:** 200–400 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada noche descarga los pedidos del día de tu tienda, busca el coste de cada producto en una hoja de costes, aplica la comisión de la pasarela y el coste de envío y embalaje, y calcula el margen euro a euro y en porcentaje.
Guarda una fila por pedido y te manda un aviso con los que quedan por debajo de tu margen mínimo. Para tiendas online pequeñas, dropshipping y venta con envío.

## Lo que necesitas antes
Tienda WooCommerce con claves de API (WooCommerce > Ajustes > Avanzado > REST API > Añadir clave, permisos `Lectura`; te da `Consumer key` y `Consumer secret`). Con Shopify sería un token de app privada con permiso `read_orders`.
Hoja de Google Sheets `Costes` con pestaña `Productos`: `sku`, `coste_unitario`, `coste_embalaje`. Y pestaña `Parametros` con una fila: `comision_pct` (por ejemplo 1.5), `comision_fija` (0.25), `coste_envio_medio` (4.90), `margen_minimo_pct` (20).
Pestaña `Margenes` vacía con: `fecha`, `pedido`, `ingreso`, `coste_producto`, `comision`, `envio`, `margen_eur`, `margen_pct`.
Bot de Telegram.

## Los nodos, en orden
**1. Schedule Trigger** — Cada día a las 23:30, `Europe/Madrid`.
**2. HTTP Request** (`Pedidos`) — `GET` a `https://tutienda.com/wp-json/wc/v3/orders`. Authentication `Generic` > `Basic Auth` con usuario = consumer key y contraseña = consumer secret. Query Parameters: `after` = `={{ $now.startOf('day').toISO() }}`, `status` = `completed,processing`, `per_page` = `100`.
**3. Google Sheets** (`Costes`) — `Get Row(s)`, pestaña `Productos`.
**4. Code** (`Calcular margen`) — `Run Once for All Items`. Código abajo.
**5. Google Sheets** (`Guardar`) — `Append`, pestaña `Margenes`.
**6. Filter** — Condición `{{ $json.margen_pct }}` `is less than` `20`.
**7. Telegram** — `Send Message`: `⚠️ Pedido {{ $json.pedido }}: margen {{ $json.margen_pct }} % ({{ $json.margen_eur }} €) sobre {{ $json.ingreso }} €. Productos: {{ $json.detalle }}`.

## El código del nodo Calcular margen
```javascript
const pedidos = $('Pedidos').all().map(i => i.json);
const costes = {};
for (const c of $('Costes').all()) costes[String(c.json.sku).trim()] = c.json;
const COM_PCT = 1.5, COM_FIJA = 0.25, ENVIO = 4.90;
const out = [];
for (const p of pedidos) {
  const ingreso = Number(p.total);
  let costeProd = 0, detalle = [];
  for (const li of p.line_items || []) {
    const c = costes[String(li.sku || '').trim()];
    const unit = c ? Number(c.coste_unitario || 0) + Number(c.coste_embalaje || 0) : 0;
    costeProd += unit * Number(li.quantity);
    detalle.push(`${li.name} x${li.quantity}${c ? '' : ' (SIN COSTE)'}`);
  }
  const comision = ingreso * COM_PCT / 100 + COM_FIJA;
  const envio = Number(p.shipping_total || 0) > 0 ? 0 : ENVIO;
  const margen = ingreso - costeProd - comision - envio;
  out.push({ json: { fecha: String(p.date_created).slice(0, 10), pedido: p.number, ingreso: Number(ingreso.toFixed(2)), coste_producto: Number(costeProd.toFixed(2)), comision: Number(comision.toFixed(2)), envio, margen_eur: Number(margen.toFixed(2)), margen_pct: ingreso ? Number((margen / ingreso * 100).toFixed(1)) : 0, detalle: detalle.join(', ') } });
}
return out;
```

## Cómo probarla
Haz un pedido de prueba en tu tienda con un producto cuyo coste conozcas y ejecuta a mano. Comprueba el margen a mano con calculadora.
Si en `detalle` te aparece `(SIN COSTE)`, es que ese SKU no está en la hoja: complétalo antes de fiarte de los números.

## Qué puede salir mal
SKUs que no coinciden entre tienda y hoja: es el fallo número uno. Exporta los SKUs de la tienda y pégalos tal cual en la hoja.
El total del pedido incluye IVA: si quieres margen sobre base imponible, divide `ingreso` entre 1.21 antes de restar costes, y usa costes también sin IVA. No mezcles.
Devoluciones: el pedido se contabiliza al crearse. Añade una ejecución mensual que relea pedidos con estado `refunded` y reste esas filas.
WooCommerce devuelve 100 pedidos por página: si vendes más al día, añade el parámetro `page` y un bucle con **Loop Over Items**.
Comisión real: Stripe en España cobra 1,5 % + 0,25 € en tarjetas europeas, pero las de fuera cuestan más. Si vendes internacional, sube la constante.

## Cuánto cuesta
API de WooCommerce y Shopify: incluidas en tu tienda. Sheets, Telegram y n8n auto-alojado: gratis.
