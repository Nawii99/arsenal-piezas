# Control de stock de material y pedido al proveedor…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Lleva el inventario de guantes, agujas, aceites o cremas descontando por consumo, avisa cuando bajas del mínimo y prepara el email de pedido.

## Qué es y qué hace

Descuenta material del inventario según las sesiones realizadas y su consumo estándar, avisa por Telegram cuando un artículo baja del mínimo y prepara el borrador del pedido agrupado por proveedor. Controla las fechas de caducidad de los lotes. Entrada: hojas de inventario, consumos y proveedores; salida: avisos y email de pedido. Se monta en n8n con Sheets, Telegram y Gmail.

## Cómo usarla

1. Crear las hojas Inventario, Consumos y Proveedores
2. Estimar el consumo por tipo de sesión
3. Probar con un pedido de prueba
4. Revisar el pedido antes de enviarlo

## Cuándo usarla

Cuando te quedes sin material a mitad de semana, hagas pedidos de urgencia caros o tengas cajas caducando en el armario sin que nadie mire.

## Cómo ganar dinero con ella

Evita pedidos urgentes con recargo y caducidades: en un centro medio son 80-150 € al mes tirados, más el sofocón de quedarte sin género.

- Controlar material fungible para clínicas de podología y estética, cobrando configuración y soporte.
- Ofrecer el control de caducidades y pedidos a gabinetes dentales pequeños.
- Montar el sistema de stock para un centro de fisioterapia con varias salas.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Descuenta material del inventario según las sesiones realizadas y su consumo estándar, avisa por Telegram cuando un artículo baja del mínimo, prepara el borrador del email de pedido agrupado por proveedor y controla las fechas de caducidad de los lotes.
Va bien para clínicas de fisioterapia y estética, centros de podología, gabinetes dentales pequeños y cualquier consulta con fungible.

## Lo que necesitas antes
- Google Sheets con tres hojas. Inventario: sku, articulo, unidad, stock_actual, minimo, pedido_optimo, proveedor, precio_unidad, caducidad_proxima, lote. Consumos: tipo_sesion, sku, cantidad_por_sesion. Proveedores: proveedor, email, condiciones.
- La hoja Consumos es la clave: apunta, por ejemplo, que una sesión de fisioterapia gasta 1 par de guantes, 0,3 rollos de papel y 5 ml de crema. No hace falta que sea exacto, con una estimación decente vale.
- Una fuente de sesiones del día: Google Calendar con el tipo de sesión en el título entre corchetes, tipo `[FISIO] Ana - Marta`.
- Un bot de Telegram: escribe a @BotFather, comando /newbot, copia el token; luego escribe al bot y saca tu chat ID abriendo `https://api.telegram.org/bot<TOKEN>/getUpdates`.
- Gmail y n8n.

## Los nodos, en orden
1. **Schedule Trigger**: `0 21 * * 1-6`.
2. **Google Calendar** (Get Many Events) del día de hoy.
3. **Google Sheets** (Get Rows) sobre Consumos.
4. **Google Sheets** (Get Rows) sobre Inventario.
5. **Code**: descuenta el consumo del día, calcula qué está bajo mínimo y qué caduca pronto. Código abajo.
6. **Google Sheets** (Update Row) sobre Inventario: escribe el nuevo stock_actual de cada sku.
7. **IF**: `{{ $json.bajo_minimo.length }}` mayor que 0.
8. **Telegram** (Send Message): al chat de la clínica, con la lista de artículos bajo mínimo y las unidades que faltan. Es el aviso rápido, para que alguien lo vea sin abrir el correo.
9. **Item Lists** (operación Summarize) o un **Code** que agrupe los artículos bajo mínimo por proveedor.
10. **Google Sheets** (Get Rows) sobre Proveedores para sacar el email de cada uno.
11. **Gmail** (operación Create Draft, no Send): un borrador por proveedor con asunto `Pedido {{ $json.proveedor }} - {{ $now.format('dd/MM/yyyy') }}` y el cuerpo con la tabla de artículo, cantidad y referencia. Deja que sea un humano quien lo revise y le dé a enviar: los pedidos automáticos sin supervisión acaban en 40 cajas de guantes.
12. **IF** aparte: artículos con caducidad a menos de 60 días, que van a otro **Telegram** con la lista y el lote, para colocarlos primero o devolverlos.

## El trozo de código del nodo 5
```javascript
const citas = $('Google Calendar').all().map(i => i.json);
const consumos = $('Consumos').all().map(i => i.json);
const inventario = $('Inventario').all().map(i => i.json);
const gasto = {};
for (const c of citas) {
  if (c.status === 'cancelled') continue;
  const t = String(c.summary || '');
  if (t.toUpperCase().includes('NO SHOW')) continue;
  const m = t.match(/\[([A-Z]+)\]/);
  const tipo = m ? m[1] : 'GENERAL';
  for (const co of consumos.filter(x => x.tipo_sesion === tipo)) {
    const cant = parseFloat(String(co.cantidad_por_sesion).replace(',', '.')) || 0;
    gasto[co.sku] = (gasto[co.sku] || 0) + cant;
  }
}
const hoy = new Date();
const actualizados = [];
const bajo_minimo = [];
const caducan = [];
for (const art of inventario) {
  const stock = (parseFloat(String(art.stock_actual).replace(',', '.')) || 0) - (gasto[art.sku] || 0);
  const minimo = parseFloat(String(art.minimo).replace(',', '.')) || 0;
  actualizados.push({ sku: art.sku, stock_actual: Math.max(stock, 0).toFixed(2), fila: art.row_number });
  if (stock <= minimo) {
    bajo_minimo.push({ sku: art.sku, articulo: art.articulo, faltan: art.pedido_optimo, proveedor: art.proveedor, precio: art.precio_unidad });
  }
  if (art.caducidad_proxima) {
    const dias = Math.ceil((new Date(art.caducidad_proxima) - hoy) / 86400000);
    if (dias <= 60) caducan.push({ articulo: art.articulo, lote: art.lote, dias });
  }
}
return [{ json: { actualizados, bajo_minimo, caducan, texto_alerta: bajo_minimo.map(b => `- ${b.articulo}: pedir ${b.faltan}`).join('\n') } }];
```
Para el paso 6, añade después un nodo **Split Out** sobre el campo `actualizados` para que el Google Sheets reciba una fila por artículo.

## Cómo probarla
1. Monta el inventario con cinco artículos reales y pon un stock bajo a propósito en uno.
2. Crea dos citas de hoy con `[FISIO]` en el título y ejecuta el flujo.
3. Comprueba a mano la resta: si una sesión gasta 1 par de guantes y hay dos citas, el stock debe bajar en 2.
4. Verifica que llega el mensaje de Telegram y que se crea el borrador en Gmail, sin enviarse.
5. Haz un recuento físico real a los 15 días y compara con la hoja: ahí verás si tus cantidades por sesión están bien calibradas.

## Qué puede salir mal
- **Deriva del stock**: el consumo estimado nunca cuadra al 100%. Haz un recuento físico mensual y corrige stock_actual a mano; la automatización sirve para avisarte entre recuentos, no para sustituirlos.
- **Sesiones sin etiqueta**: si alguien olvida poner `[FISIO]`, no se descuenta nada. El código lo manda a GENERAL; define un consumo para GENERAL o añade un aviso.
- **Pedidos duplicados**: si un artículo lleva tres días bajo mínimo, generarías tres borradores. Añade una columna pedido_solicitado con la fecha y salta los que ya tengan un pedido de menos de 7 días.
- **Precios desactualizados**: la columna precio_unidad se queda vieja rápido. Revísala cada trimestre; sirve para que el borrador de pedido lleve el importe estimado.
- **Material sanitario con trazabilidad**: si manejas lotes con requisitos de trazabilidad, esta hoja no sustituye el registro obligatorio, es un apoyo.

## Cuánto cuesta
- Google Sheets, Gmail y Telegram: gratis.
- n8n auto-alojado: gratis, aparte del VPS.
- Total: 0 € al mes.
