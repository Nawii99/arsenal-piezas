# Margen real por pedido de tu tienda online…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Por cada pedido nuevo de tu tienda calcula el margen de verdad: precio menos coste del producto, envío, comisión de la pasarela e IVA, y lo guarda en una hoja.

## Qué es y qué hace

Cada vez que entra un pedido en Shopify o WooCommerce, lee sus líneas, busca el coste unitario de cada producto en la hoja Costes de Google Sheets, resta envío real, comisión de pasarela e IVA, y escribe una fila con el margen en euros y porcentaje. Si el margen baja de un umbral que tú fijas, avisa por Telegram al momento.

## Cómo usarla

1. Crear la app privada en Shopify o la clave en WooCommerce
2. Preparar la hoja Costes con sku y peso
3. Montar el webhook de pedidos en n8n
4. Que lo revise un profesional

## Cuándo usarla

Cuando vendes online y no sabes qué productos te dan dinero de verdad, porque el envío gratis y la comisión de Stripe se comen el margen sin que lo veas.

## Cómo ganar dinero con ella

Descubre productos que vendes a pérdida. Ajustar el precio o el envío de dos referencias mal calculadas suele valer cientos de euros al mes.

- Análisis de margen por pedido para tiendas pequeñas que no tienen contabilidad analítica.
- Revisión mensual de productos que venden a pérdida con propuesta de nuevo precio.
- Panel de margen por producto que el consultor de e-commerce entrega al cliente cada trimestre.

**Precio orientativo:** 200–400 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada vez que entra un pedido, coge las líneas del pedido, busca el coste unitario de cada producto en tu hoja de costes, resta el coste de envío real, la comisión de la pasarela y el IVA, y escribe una fila con el margen en euros y en porcentaje. Si el margen baja de un umbral que tú fijas, te avisa por Telegram al momento.
Para tiendas online pequeñas de producto físico o digital que ya venden pero no tienen contabilidad analítica.

## Lo que necesitas antes
- Tienda en Shopify (credencial: en tu admin, Settings > Apps > Develop apps > crea una app, scopes `read_orders` y `read_products`, y copia el Admin API access token) o en WooCommerce (WooCommerce > Ajustes > Avanzado > REST API > crear clave con permiso de lectura; te da Consumer Key y Secret).
- Hoja `Costes` con columnas: `sku`, `nombre`, `coste_unitario`, `peso_g`. El coste es lo que te cuesta a ti el producto puesto en tu almacén, sin IVA.
- Hoja `Margenes` con: `pedido`, `fecha`, `cliente`, `ingreso_sin_iva`, `coste_productos`, `coste_envio`, `comision`, `margen`, `margen_pct`, `productos`.
- Un bot de Telegram (BotFather) y tu chat_id.
- Credenciales en n8n: **Shopify Access Token** (o **WooCommerce API**), **Google Sheets OAuth2**, **Telegram API**.

## Los nodos, en orden
1. **Shopify Trigger** — Topic: `orders/create`. (Si usas WooCommerce: **Webhook** en n8n con Method `POST`, copias la URL de producción y la das de alta en WooCommerce > Ajustes > Avanzado > Webhooks, tema `Pedido creado`.) El Shopify Trigger verifica la firma por ti; con el Webhook de WooCommerce rellena el campo «Secreto» y verifica la cabecera `X-WC-Webhook-Signature` (HMAC-SHA256 del cuerpo, en base64) antes de fiarte del pedido.
2. **Google Sheets** («Costes») — Operation: `Get Row(s)`, Sheet: `Costes`. Sin filtro, traemos toda la tabla de costes (si tienes más de 500 SKUs, filtra por lote o usa un nodo por SKU).
3. **Code** («Calcular margen») — Mode: `Run Once for All Items`. Código abajo. Ajusta arriba las constantes de comisión y de coste de envío según tu transportista.
4. **Google Sheets** («Guardar») — Operation: `Append or Update Row` (columna de coincidencia `pedido`, para no duplicar si el webhook llega dos veces), Sheet: `Margenes`. Mapea todos los campos.
5. **IF** («¿Margen bajo?») — Condition `Number`, izquierda `{{ $json.margen_pct }}`, operación `smaller`, derecha `20`.
6. **Telegram** («Alerta») — Chat ID: el tuyo. Text: `⚠️ Pedido {{ $json.pedido }} con margen de solo {{ $json.margen_pct }}% ({{ $json.margen }} €). Productos: {{ $json.productos }}`.

## El código del nodo Code
```javascript
// Ajusta estos números a tu realidad
const COMISION_PCT = 0.014;   // Stripe/Redsys tarjeta europea
const COMISION_FIJA = 0.25;   // por transacción
const IVA = 0.21;
const ENVIO_BASE = 3.90;      // lo que te cobra a TI el transportista
const ENVIO_POR_KG = 0.60;
const cost = {};
for (const it of $('Costes').all()) {
  const c = it.json;
  if (!c.sku) continue;
  cost[String(c.sku).trim()] = { coste: Number(String(c.coste_unitario).replace(',','.')) || 0, peso: Number(c.peso_g) || 300 };
}
const salida = [];
for (const it of $input.all()) {
  const o = it.json;
  const lineas = o.line_items || o.line_items_data || [];
  let ingresoBruto = 0, costeProd = 0, pesoTotal = 0;
  const nombres = [];
  for (const l of lineas) {
    const sku = String(l.sku || '').trim();
    const cant = Number(l.quantity) || 1;
    const precio = Number(l.price) * cant;
    ingresoBruto += precio;
    const c = cost[sku];
    costeProd += (c ? c.coste : Number(l.price) * 0.5) * cant;  // si falta el SKU, asume 50% y avisa
    pesoTotal += (c ? c.peso : 300) * cant;
    nombres.push(`${cant}x ${l.title || l.name || sku}${c ? '' : ' (SIN COSTE)'}`);
  }
  const envioCobrado = Number(o.total_shipping_price_set?.shop_money?.amount ?? o.shipping_total ?? 0);
  ingresoBruto += envioCobrado;
  const ingresoSinIva = +(ingresoBruto / (1 + IVA)).toFixed(2);
  const costeEnvio = +(ENVIO_BASE + (pesoTotal / 1000) * ENVIO_POR_KG).toFixed(2);
  const comision = +(ingresoBruto * COMISION_PCT + COMISION_FIJA).toFixed(2);
  const margen = +(ingresoSinIva - costeProd - costeEnvio - comision).toFixed(2);
  salida.push({ json: {
    pedido: o.name || o.number || o.id,
    fecha: (o.created_at || o.date_created || new Date().toISOString()).slice(0,10),
    cliente: `${o.customer?.first_name || o.billing?.first_name || ''} ${o.customer?.last_name || o.billing?.last_name || ''}`.trim(),
    ingreso_sin_iva: ingresoSinIva, coste_productos: +costeProd.toFixed(2),
    coste_envio: costeEnvio, comision, margen,
    margen_pct: ingresoSinIva ? +((margen / ingresoSinIva) * 100).toFixed(1) : 0,
    productos: nombres.join(' | ')
  }});
}
return salida;
```

## Cómo probarla
- En Shopify, crea un pedido de prueba con el modo test de la pasarela o haz un pedido real de 1 € a ti mismo. Comprueba fila a fila en la hoja: ingreso, coste, comisión y margen.
- Coge la factura real de tu transportista del mes pasado y divide por número de envíos: ese es tu `ENVIO_BASE` verdadero. La mayoría de tiendas lo tiene mal puesto.
- Busca en la hoja los pedidos con «SIN COSTE» en la columna `productos`: son SKUs que faltan en tu tabla de costes.
- Al final del primer mes, haz una tabla dinámica por producto y ordena por margen. Ahí verás qué vender y qué no.

## Qué puede salir mal
- **SKUs que no cuadran**: si en la tienda el SKU tiene espacios o mayúsculas distintas, no encuentra el coste. Por eso el código hace `trim()` y marca «SIN COSTE» en vez de fallar en silencio.
- **Devoluciones**: este flujo no las descuenta. Añade un segundo **Shopify Trigger** con topic `refunds/create` que escriba una fila con margen negativo.
- **Descuentos**: si usas cupones, el `price` de la línea puede ser el precio sin descuento. Usa `l.discounted_price` o resta `o.total_discounts` del ingreso bruto.
- **Comisiones reales**: PayPal cobra más que Stripe, y las tarjetas de fuera de la UE llevan recargo. Si vendes internacional, añade un condicional por país en la constante de comisión.
- **Reintentos y webhooks perdidos**: si n8n está apagado cuando entra un pedido, el webhook se pierde. Añade un **Schedule Trigger** semanal que repase los pedidos de los últimos 7 días vía API y rellene los huecos con Append or Update usando `pedido` como Matching Column.

## Cuánto cuesta
- n8n auto-alojado y Google Sheets: gratis. Telegram: gratis.
- Shopify y WooCommerce: sus APIs no cuestan extra sobre lo que ya pagas.
- Si vendes más de 400-500 pedidos al mes, n8n Cloud solo ofrece una prueba gratuita temporal y después planes de pago con un número limitado de ejecuciones; con n8n auto-alojado (gratis) no tienes ese límite.
- En Make cada pedido consume 3-4 operaciones: con 250 pedidos al mes te pasas del plan gratuito (1.000 ops) y necesitarías el plan Core, unos 9 €/mes.
