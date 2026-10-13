# Auditor de comisiones: cuánto se llevan de verdad tus c…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Calcula el porcentaje efectivo que te cobran Stripe, PayPal, el TPV y los marketplaces sobre lo que facturas por cada canal, y te enseña qué canal te está saliendo caro.

## Qué es y qué hace

Una vez al mes descarga los movimientos de Stripe y PayPal con sus claves de API, separa el importe bruto de la comisión y calcula el porcentaje efectivo por plataforma. Suma lo que apuntas a mano del TPV y de los marketplaces en una hoja de Google Sheets y genera un cuadro mensual con el coste total de cobrar por canal.

## Cómo usarla

1. Crear clave restringida en Stripe y app en PayPal
2. Preparar la hoja Comisiones con Resumen y Manual
3. Montar el flujo mensual en n8n
4. Que lo revise un profesional

## Cuándo usarla

Cuando cobras por varios sitios a la vez y nunca has sumado cuánto se llevan entre todos en un año.

## Cómo ganar dinero con ella

Un punto de comisión sobre 120.000 euros al año son 1.200 euros. Ver el coste real por canal te da argumentos para negociar tarifa o empujar al cliente al canal barato.

- Auditoría de comisiones de cobro para negocios con varios canales de venta.
- Informe anual de coste de pagos que el autónomo usa para negociar tarifas con su pasarela.
- Análisis de canal barato frente a caro para una tienda con TPV físico y marketplaces.

**Precio orientativo:** 200–400 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Una vez al mes descarga los movimientos de balance de Stripe y de PayPal, separa el importe bruto de la comisión y calcula el porcentaje efectivo real de cada plataforma.
Añade los datos que tú metes a mano del TPV físico y de los marketplaces y monta un cuadro mensual con el coste total de cobrar. Para cualquier negocio que cobre por más de un canal.

## Lo que necesitas antes
Clave restringida de Stripe con permiso `Read` sobre `Balance transactions` (Desarrolladores > Claves de API > Crear clave restringida).
Credenciales de la API de PayPal: developer.paypal.com > My Apps & Credentials > Live > Create App. Te da `Client ID` y `Secret`.
Hoja de Google Sheets `Comisiones` con pestaña `Resumen`: `mes`, `canal`, `bruto`, `comision`, `pct_efectivo`. Y pestaña `Manual` donde apuntas TPV y marketplaces: `mes`, `canal`, `bruto`, `comision`.

## Los nodos, en orden
**1. Schedule Trigger** — `Months`, día 2, 07:00, `Europe/Madrid` (día 2 para que el mes anterior esté cerrado).
**2. HTTP Request** (`Stripe balance`) — `GET` a `https://api.stripe.com/v1/balance_transactions`. Header Auth: `Authorization` = `Bearer rk_live_...`. Query: `limit` = `100`, `created[gte]` = `={{ Math.floor($now.minus(1,'month').startOf('month').toSeconds()) }}`, `created[lt]` = `={{ Math.floor($now.startOf('month').toSeconds()) }}`.
**3. HTTP Request** (`PayPal token`) — `POST` a `https://api-m.paypal.com/v1/oauth2/token`. Authentication `Basic Auth` con Client ID y Secret. Body Content Type `Form Urlencoded`, campo `grant_type` = `client_credentials`.
**4. HTTP Request** (`PayPal movimientos`) — `GET` a `https://api-m.paypal.com/v1/reporting/transactions`. Header `Authorization` = `=Bearer {{ $json.access_token }}`. Query: `start_date` = `={{ $now.minus(1,'month').startOf('month').toISO() }}`, `end_date` = `={{ $now.startOf('month').toISO() }}`, `fields` = `transaction_info`, `page_size` = `100`.
**5. Google Sheets** (`Manual`) — `Get Row(s)`, pestaña `Manual`.
**6. Code** (`Sumar comisiones`) — `Run Once for All Items`. Código abajo.
**7. Google Sheets** (`Resumen`) — `Append or Update`, pestaña `Resumen`, columnas de comparación `mes` y `canal`.
**8. Gmail** — te manda el cuadro por email con `={{ $json.informe }}` del último item.

## El código del nodo Sumar comisiones
```javascript
const mes = new Date(new Date().getFullYear(), new Date().getMonth() - 1, 1).toISOString().slice(0, 7);
const filas = [];
let sBruto = 0, sCom = 0;
for (const t of ($('Stripe balance').first().json.data || [])) {
  if (t.type !== 'charge' && t.type !== 'payment') continue;
  sBruto += t.amount / 100;
  sCom += t.fee / 100;
}
filas.push({ canal: 'Stripe', bruto: sBruto, comision: sCom });
let pBruto = 0, pCom = 0;
for (const t of ($('PayPal movimientos').first().json.transaction_details || [])) {
  const info = t.transaction_info || {};
  const importe = Number(info.transaction_amount?.value || 0);
  const fee = Math.abs(Number(info.fee_amount?.value || 0));
  if (importe <= 0) continue;
  pBruto += importe; pCom += fee;
}
filas.push({ canal: 'PayPal', bruto: pBruto, comision: pCom });
for (const m of $('Manual').all().map(i => i.json)) {
  if (String(m.mes).slice(0, 7) !== mes) continue;
  filas.push({ canal: m.canal, bruto: Number(m.bruto || 0), comision: Number(m.comision || 0) });
}
let totB = 0, totC = 0;
const out = filas.filter(f => f.bruto > 0).map(f => {
  totB += f.bruto; totC += f.comision;
  return { json: { mes, canal: f.canal, bruto: Number(f.bruto.toFixed(2)), comision: Number(f.comision.toFixed(2)), pct_efectivo: Number((f.comision / f.bruto * 100).toFixed(2)) } };
});
const informe = out.map(o => `${o.json.canal}: ${o.json.bruto} € brutos, ${o.json.comision} € de comisión (${o.json.pct_efectivo} %)`).join('\n') + `\nTOTAL ${mes}: ${totC.toFixed(2)} € de comisiones sobre ${totB.toFixed(2)} € (${(totC / totB * 100).toFixed(2)} %). Al año, aprox. ${(totC * 12).toFixed(0)} €.`;
out.forEach(o => o.json.informe = informe);
return out;
```

## Cómo probarla
Ejecuta a mano con el mes pasado ya cerrado y compara el número de Stripe con el informe mensual que Stripe te manda por email. Deben cuadrar al céntimo o casi.
Si PayPal devuelve vacío, prueba con un rango de 7 días: su API de reporting solo cubre los últimos 3 años y a veces tarda 3 horas en consolidar.

## Qué puede salir mal
PayPal exige que la app tenga activado `Transaction Search` en el panel de developer. Si no, da error 403.
Stripe corta a 100 movimientos: si haces más de 100 cobros al mes usa `starting_after` en bucle o baja a ejecución semanal.
Devoluciones y disputas: aparecen como `refund` o `adjustment` y este código las ignora, así que el porcentaje sale algo optimista. Si tienes muchas, añádelas al bruto en negativo.
Cambios de divisa: filtra por `currency === 'eur'` o mezclarás monedas y el porcentaje no significará nada.

## Cuánto cuesta
APIs de Stripe y PayPal: gratis. Sheets y n8n auto-alojado: gratis.
