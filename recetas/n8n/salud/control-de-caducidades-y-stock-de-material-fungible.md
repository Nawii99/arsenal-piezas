# Control de caducidades y stock de material fungible…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Vigila tu inventario de guantes, geles, agujas, cremas o suplementos, avisa de lo que caduca en 60 días y prepara el pedido cuando algo baja del mínimo.

## Qué es y qué hace

Lleva el inventario de material fungible con un formulario de móvil para cada consumo. Cada lunes calcula el consumo medio semanal, estima los días de stock que quedan y avisa de lo que hay que pedir. Cada día revisa los lotes y avisa con 60 y 15 días de antelación a la caducidad. Entrada: formulario de movimientos y hojas de lotes; salida: avisos de pedido y de caducidad. Se monta en n8n con Google Forms, Sheets y Gmail.

## Cómo usarla

1. Crear el formulario de movimientos y las hojas Inventario y Lotes
2. Conectar Sheets y Gmail
3. Probar con tres consumos
4. Activar los avisos de caducidad

## Cuándo usarla

Cuando descubres que se te ha acabado el material a mitad de sesión, o tiras producto caducado que compraste hace seis meses.

## Cómo ganar dinero con ella

Una clínica pequeña tira entre 300 y 900 € al año en caducados y paga portes urgentes por compras de última hora; esto lo elimina casi entero.

- Controlar material de clínicas de estética y gimnasios, cobrando instalación y soporte.
- Ofrecer alertas de caducidad a gabinetes de podología.
- Montar un inventario compartido para varias salas de un mismo centro.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Mantiene una hoja de inventario donde cada consumo se apunta desde un formulario de móvil en dos toques; cada lunes calcula el consumo medio semanal, estima cuántos días de stock quedan y avisa de lo que hay que pedir.
Aparte, cada día revisa lotes con fecha de caducidad y avisa a 60 y a 15 días para que los uses primero o los devuelvas.
Para clínicas, centros de estética, gabinetes de podología y gimnasios con material fungible.

## Lo que necesitas antes
Google Sheet `Inventario` con `sku`, `producto`, `unidad`, `stock_actual`, `minimo`, `proveedor_email`, `precio_unidad`.
Google Sheet `Lotes` con `sku`, `lote`, `cantidad`, `caducidad`, `avisado_60`, `avisado_15`.
Google Sheet `Movimientos` con `fecha`, `sku`, `cantidad`, `tipo` (`consumo` o `entrada`), alimentado por un Google Form corto que dejas como acceso directo en el móvil del mostrador.
Credenciales `Google Sheets OAuth2` y `Gmail OAuth2`; bot de Telegram para los avisos rápidos.

## Los nodos, en orden
1. Workflow 1, **Google Sheets Trigger** — Event `Row Added` sobre la hoja de respuestas del Form, poll cada minuto.
2. **Google Sheets** — `Get Row(s)` de `Inventario` filtrando por `sku`.
3. **Code** — suma o resta según `tipo` y devuelve el nuevo `stock_actual`.
4. **Google Sheets** — `Update Row`, Matching Column `sku`.
5. **IF** — `{{$json.stock_actual}}` menor o igual que `{{$json.minimo}}` → **Telegram** aviso inmediato `Queda poco: {{$json.producto}}`.
6. Workflow 2, **Schedule Trigger** — `0 8 * * 1`.
7. **Google Sheets** — lee `Movimientos` (`Return All`) y `Inventario`.
8. **Code** — calcula consumo medio de las últimas 4 semanas por sku y los días de cobertura restantes; marca para pedido lo que baje de 14 días (código abajo).
9. **Google Sheets** — `Append Row` en una hoja `Pedidos` con lo propuesto.
10. **Gmail** — email a ti con la propuesta de pedido en tabla y el importe estimado; tú confirmas y reenvías al proveedor. No automatices el envío directo al proveedor hasta que lleves un mes viendo que los números cuadran.
11. Workflow 3, **Schedule Trigger** `0 9 * * *` — lee `Lotes`, **Code** que compara `caducidad` con hoy, **IF** por 60 o 15 días, **Telegram** y `Update Row` de la columna de avisado.

## El nodo Code de cobertura
```js
const movimientos = $('Google Sheets').all().map(i => i.json);
const inventario = $('Google Sheets1').all().map(i => i.json);
const hoy = new Date();
const desde = new Date(hoy.getTime() - 28 * 86400000);
const out = [];
for (const p of inventario) {
  const consumos = movimientos.filter(m => m.sku === p.sku && m.tipo === 'consumo' && new Date(m.fecha) >= desde);
  const total = consumos.reduce((s, m) => s + Number(m.cantidad || 0), 0);
  const diario = total / 28;
  const cobertura = diario > 0 ? Math.floor(Number(p.stock_actual) / diario) : 999;
  if (cobertura > 14) continue;
  const objetivo = Math.ceil(diario * 45);
  const pedir = Math.max(objetivo - Number(p.stock_actual), 0);
  out.push({ json: { sku: p.sku, producto: p.producto, stock_actual: p.stock_actual, consumo_diario: diario.toFixed(2), dias_cobertura: cobertura, pedir, importe: (pedir * Number(p.precio_unidad || 0)).toFixed(2) } });
}
return out;
```

## Cómo probarla
Registra cinco consumos falsos de un producto con fechas de las últimas tres semanas y comprueba que el consumo diario y la cobertura salen coherentes.
Mete un lote con caducidad dentro de 59 días y verifica que salta el aviso de 60.

## Qué puede salir mal
Si el mostrador no apunta los consumos, el sistema no sirve: haz el formulario de tres campos como mucho y ponlo como icono en la pantalla de inicio del móvil.
Productos nuevos sin histórico dan cobertura 999; es correcto, ya se corregirá al mes.
Fechas de caducidad en formato distinto rompen la comparación: fija el formato de la columna a fecha en el propio Sheet.
Google Sheets Trigger consume una ejecución por sondeo en n8n Cloud; en n8n Cloud, que tras la prueba gratuita temporal es de pago, pon el poll cada 5 minutos para gastar menos.

## Cuánto cuesta
Todo gratis con n8n auto-alojado y cuenta de Google normal.
n8n Cloud Starter unos 20 €/mes si no quieres montar servidor.
