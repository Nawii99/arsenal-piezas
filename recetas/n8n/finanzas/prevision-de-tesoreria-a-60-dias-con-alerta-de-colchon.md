# Previsión de tesorería a 60 días con alerta de colchón…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Cada mañana lee el saldo de tu banco por open banking, suma las facturas pendientes en su fecha prevista y resta gastos fijos y variables de una hoja de Google Sheets.

## Qué es y qué hace

Cada mañana lee el saldo de tu banco por open banking, suma las facturas pendientes en su fecha prevista y resta gastos fijos y variables de una hoja de Google Sheets. Dibuja el saldo día a día durante 60 días y avisa si algún día baja de tu colchón mínimo, indicando qué cobro lo evitaría. Para negocios que facturan a plazo.

## Cómo usarla

1. Vincular el banco en GoCardless
2. Preparar la hoja Tesoreria con Cobros, Gastos y Config
3. Montar el cálculo diario en n8n
4. Que lo revise un profesional

## Cuándo usarla

Cuando cobras a 30-60 días y no sabes si llegarás a la nómina, al alquiler o al pago de impuestos del trimestre.

## Cómo ganar dinero con ella

Ver un agujero con tres semanas de margen te permite adelantar un cobro o retrasar una compra en vez de pagar intereses de descubierto o un préstamo rápido.

- Previsión de caja a 60 días para agencias y talleres que cobran a 30-60 días y pagan nóminas a fecha fija.
- Revisión mensual de la previsión con ajuste de cobros y gastos para una pyme.
- Plantilla de tesorería que el asesor financiero personaliza y entrega como servicio de consultoría.

**Precio orientativo:** 250–500 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada mañana lee el saldo real de tu banco, suma las facturas que tienes pendientes de cobrar en su fecha prevista, resta los gastos fijos y variables que has apuntado y dibuja el saldo día a día de los próximos 60 días.
Si algún día proyectado cae por debajo de tu colchón mínimo, te manda un mensaje diciendo qué día es, cuánto falta y qué cobro pendiente lo arreglaría. Para cualquier negocio que facture a plazo.

## Lo que necesitas antes
GoCardless Bank Account Data con tu banco vinculado (registro gratuito en bankaccountdata.gocardless.com; `secret_id`, `secret_key` y el `account_id` de tu cuenta).
Hoja de Google Sheets `Tesoreria` con tres pestañas. `Cobros`: `cliente`, `importe`, `fecha_prevista`, `estado` (pendiente/cobrado). `Gastos`: `concepto`, `importe`, `dia_del_mes`, `frecuencia` (mensual/trimestral), `mes_inicio`. `Config`: una fila con `colchon` (por ejemplo 3000).
Bot de Telegram con token y tu `chat_id`.

## Los nodos, en orden
**1. Schedule Trigger** — Cada día a las 08:15, zona horaria `Europe/Madrid`.
**2. HTTP Request** (`Token`) — `POST` a `https://bankaccountdata.gocardless.com/api/v2/token/new/` con body JSON `{"secret_id":"...","secret_key":"..."}`.
**3. HTTP Request** (`Saldo`) — `GET` a `https://bankaccountdata.gocardless.com/api/v2/accounts/TU_ACCOUNT_ID/balances/`, header `Authorization` = `=Bearer {{ $json.access }}`.
**4. Google Sheets** (`Cobros`) — `Get Row(s)`, pestaña `Cobros`. Filtro: columna `estado` igual a `pendiente`.
**5. Google Sheets** (`Gastos`) — `Get Row(s)`, pestaña `Gastos`.
**6. Code** (`Proyectar`) — `Run Once for All Items`. Código abajo.
**7. IF** — Condición `{{ $json.alerta }}` `is true`.
**8. Telegram** — `Send Message` con el texto que arma el Code en `mensaje`.
**9. Google Sheets** (`Guardar curva`) opcional — `Append`, pestaña `Historico`, para poder graficar la previsión después.

## El código del nodo Proyectar
```javascript
const bal = $('Saldo').first().json.balances;
const saldoIni = Number((bal.find(b => b.balanceType === 'interimAvailable') || bal[0]).balanceAmount.amount);
const cobros = $('Cobros').all().map(i => i.json);
const gastos = $('Gastos').all().map(i => i.json);
const colchon = 3000;
const hoy = new Date(); hoy.setHours(0, 0, 0, 0);
let saldo = saldoIni;
let peor = { saldo: saldoIni, fecha: null };
const curva = [];
for (let d = 0; d < 60; d++) {
  const dia = new Date(hoy.getTime() + d * 86400000);
  const iso = dia.toISOString().slice(0, 10);
  for (const c of cobros) { if (String(c.fecha_prevista).slice(0, 10) === iso) saldo += Number(c.importe); }
  for (const g of gastos) {
    if (Number(g.dia_del_mes) !== dia.getDate()) continue;
    if (g.frecuencia === 'trimestral' && (dia.getMonth() % 3) !== (Number(g.mes_inicio || 1) - 1) % 3) continue;
    saldo -= Number(g.importe);
  }
  curva.push({ fecha: iso, saldo: Number(saldo.toFixed(2)) });
  if (saldo < peor.saldo) peor = { saldo, fecha: iso };
}
const alerta = peor.saldo < colchon;
const ayuda = cobros.slice().sort((a, b) => Number(b.importe) - Number(a.importe))[0];
const mensaje = alerta
  ? `🔴 Tesorería: el ${peor.fecha} bajas a ${peor.saldo.toFixed(2)} €, por debajo del colchón de ${colchon} €. Faltan ${(colchon - peor.saldo).toFixed(2)} €. Cobro más grande pendiente: ${ayuda ? ayuda.cliente + ' ' + ayuda.importe + ' €' : 'ninguno'}.`
  : `🟢 Tesorería OK. Mínimo previsto ${peor.saldo.toFixed(2)} € el ${peor.fecha}.`;
return [{ json: { alerta, mensaje, peor_fecha: peor.fecha, peor_saldo: peor.saldo, curva } }];
```

## Cómo probarla
Mete tres cobros ficticios y dos gastos y ejecuta a mano. Comprueba que el saldo mínimo coincide con lo que sale si lo haces con lápiz y papel.
Baja el colchón a un número altísimo (por ejemplo 999999) para forzar la alerta y ver que Telegram llega.

## Qué puede salir mal
Fechas: si Google Sheets te devuelve la fecha en formato `dd/mm/yyyy` el `slice(0,10)` no cuadrará. Formatea la columna como texto `yyyy-mm-dd` en Sheets (Formato > Número > Texto sin formato) y escríbelas así.
Cobros que ya han entrado pero siguen marcados como `pendiente` te inflan la previsión. Añade la costumbre de marcar `cobrado`, o cruza con el flujo de conciliación bancaria.
Gastos con día 31 en meses de 30 días no se aplican: usa día 28 como máximo para gastos fijos.
El saldo `interimAvailable` puede incluir tarjetas de crédito no liquidadas. Si tu banco lo da raro, prueba con `balanceType === 'closingBooked'`.

## Cuánto cuesta
Todo gratis: GoCardless plan gratuito, Sheets, Telegram y n8n auto-alojado. Solo el servidor si lo alojas fuera de tu ordenador (unos 5 euros al mes).
