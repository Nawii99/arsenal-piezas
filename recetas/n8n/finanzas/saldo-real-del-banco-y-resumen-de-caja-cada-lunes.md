# Saldo real del banco y resumen de caja cada lunes…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Conecta tu banco por open banking gratuito, descarga los movimientos de la semana, los clasifica por categoría y te manda un resumen a Telegram con saldo, entradas y salidas.

## Qué es y qué hace

Cada lunes se conecta al banco mediante GoCardless Bank Account Data, descarga los movimientos de los últimos 7 días, los guarda en Google Sheets sin duplicar y envía a Telegram el saldo, las entradas, las salidas y los cinco mayores gastos. Funciona con bancos de la UE como Santander, BBVA o CaixaBank, según cobertura.

## Cómo usarla

1. Crear cuenta y vincular el banco en GoCardless
2. Preparar la hoja de movimientos
3. Montar el flujo semanal en n8n con Telegram
4. Que lo revise un profesional

## Cuándo usarla

Cuando no sabes cuánto dinero tienes de verdad hasta que entras en la app del banco, y descubres los gastos raros un mes tarde. Vale para autónomos y micropymes con 1 o 2 cuentas.

## Cómo ganar dinero con ella

Te quita el «¿cuánto tengo?» diario y evita descubiertos y devoluciones de recibo (30-40 € cada una). Sustituye a agregadores de pago de 15-30 €/mes.

- Resumen semanal de caja para autónomos con una o dos cuentas bancarias.
- Mantenimiento mensual de la conexión bancaria y revisión de movimientos para una micropyme.
- Panel de caja semanal que el gestor entrega a sus clientes como parte del servicio contable.

**Precio orientativo:** 120–250 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada lunes a las 8:00 se conecta a tu banco a través de la API gratuita de open banking de GoCardless (antes Nordigen), descarga los movimientos de los últimos 7 días, los guarda en una hoja de cálculo sin duplicar y te manda a Telegram el saldo actual, cuánto ha entrado, cuánto ha salido y los 5 mayores gastos.
Para cualquier negocio pequeño español con cuenta en un banco de la UE (Santander, BBVA, CaixaBank, Sabadell, ING, Revolut Business, N26, Openbank y demás están soportados).

## Lo que necesitas antes
- Cuenta gratuita en `bankaccountdata.gocardless.com`. En «User Secrets» creas un `secret_id` y un `secret_key`. Gratis hasta 50 cuentas conectadas, es la vía legal PSD2.
- La vinculación con el banco se hace UNA VEZ a mano (no en el flujo): con Postman o con un flujo n8n de un solo uso llamas a `POST /api/v2/token/new/` con tus secretos, luego `GET /api/v2/institutions/?country=es` para sacar el `institution_id` de tu banco, luego `POST /api/v2/agreements/enduser/` y `POST /api/v2/requisitions/` con ese id y un `redirect`. La respuesta trae un `link`: lo abres en el navegador, te logueas en tu banco y autorizas. Después `GET /api/v2/requisitions/{id}/` te devuelve el `account_id`. Guarda ese `account_id`, es lo único que necesita el flujo.
- Una hoja de Google `Movimientos` con columnas: `id`, `fecha`, `concepto`, `importe`, `categoria`, `saldo`.
- Un bot de Telegram: escribe a `@BotFather`, `/newbot`, te da un token. Escribe algo a tu bot y saca tu `chat_id` abriendo `https://api.telegram.org/bot<TOKEN>/getUpdates`.
- En n8n: credenciales **Google Sheets OAuth2** y **Telegram API** (con el token del bot).

## Los nodos, en orden
1. **Schedule Trigger** — Interval: `Weeks`, Trigger on Weekdays: `Monday`, Hour: `8`. Timezone del workflow: `Europe/Madrid`.
2. **HTTP Request** («Token») — Method: `POST`, URL: `https://bankaccountdata.gocardless.com/api/v2/token/new/`, Body Content Type: `JSON`, Specify Body: `Using Fields Below` con `secret_id` y `secret_key`. Headers: `accept: application/json`. Devuelve un campo `access`.
3. **HTTP Request** («Movimientos») — Method: `GET`, URL: `https://bankaccountdata.gocardless.com/api/v2/accounts/TU_ACCOUNT_ID/transactions/`. En Options > Query Parameters añade `date_from` = `{{ $now.minus(8, 'days').toFormat('yyyy-MM-dd') }}`. En Headers añade `Authorization` = `Bearer {{ $json.access }}`.
4. **HTTP Request** («Saldo») — Method: `GET`, URL: `https://bankaccountdata.gocardless.com/api/v2/accounts/TU_ACCOUNT_ID/balances/`, mismo header Authorization pero apuntando al nodo Token: `Bearer {{ $('Token').item.json.access }}`.
5. **Code** («Normalizar») — Mode: `Run Once for All Items`. Código abajo: aplana los movimientos, los categoriza por palabras clave y calcula totales.
6. **Google Sheets** («Guardar») — Operation: `Append or Update Row`, Matching Columns: `id`. Así, si un movimiento ya está guardado, lo actualiza en vez de duplicarlo.
7. **Telegram** («Resumen») — conéctalo desde el Code. Resource: `Message`, Operation: `Send Message`, Chat ID: el tuyo, Text: `{{ $json.resumen }}`, y en Options activa `Parse Mode: HTML`.

## El código del nodo Code
```javascript
const bal = $('Saldo').first().json;
const saldo = bal.balances?.[0]?.balanceAmount?.amount ?? 'n/d';
const raw = $('Movimientos').first().json.transactions || {};
const lista = [...(raw.booked || []), ...(raw.pending || [])];
const reglas = [
  ['nomina|salario|seguridad social|tgss', 'Personal'],
  ['agencia tributaria|aeat|modelo 3|modelo 1', 'Impuestos'],
  ['alquiler|arrendamiento', 'Local'],
  ['endesa|iberdrola|naturgy|movistar|vodafone|orange', 'Suministros'],
  ['amazon|leroy|makro|proveedor|compra', 'Compras'],
  ['stripe|paypal|redsys|transferencia recibida|abono', 'Ingresos']
];
const filas = [];
let entradas = 0, salidas = 0;
for (const t of lista) {
  const imp = Number(t.transactionAmount.amount);
  const concepto = (t.remittanceInformationUnstructured || t.creditorName || t.debtorName || 'sin concepto').slice(0,120);
  const low = concepto.toLowerCase();
  let cat = imp > 0 ? 'Ingresos' : 'Otros';
  for (const [pat, c] of reglas) if (new RegExp(pat).test(low)) { cat = c; break; }
  if (imp > 0) entradas += imp; else salidas += Math.abs(imp);
  filas.push({ json: {
    id: t.internalTransactionId || `${t.bookingDate}-${imp}-${concepto.slice(0,20)}`,
    fecha: t.bookingDate || t.valueDate, concepto, importe: imp, categoria: cat, saldo
  }});
}
const top = filas.filter(f => f.json.importe < 0).sort((a,b) => a.json.importe - b.json.importe).slice(0,5)
  .map(f => `• ${f.json.concepto}: ${f.json.importe.toFixed(2)} €`).join('\n');
filas[0] = filas[0] || { json: {} };
filas[0].json.resumen = `<b>Caja semanal</b>\nSaldo: ${saldo} €\nEntradas: ${entradas.toFixed(2)} €\nSalidas: ${salidas.toFixed(2)} €\nNeto: ${(entradas - salidas).toFixed(2)} €\n\n<b>Mayores gastos</b>\n${top || 'ninguno'}`;
return filas;
```

## Cómo probarla
- Ejecuta primero solo el nodo Token (clic en el nodo > Execute step): debe devolver `access` y `refresh`. Si da 401, tus secretos están mal.
- Ejecuta «Movimientos» y mira que el JSON traiga `transactions.booked` con datos reales.
- Ejecuta el Code y revisa que las categorías tengan sentido; ajusta las palabras clave del array `reglas` a los nombres que usa tu banco.
- Lanza el flujo entero y comprueba la hoja: no debe haber filas repetidas si lo ejecutas dos veces seguidas.

## Qué puede salir mal
- **La conexión caduca**: las autorizaciones PSD2 duran 90 días. Cuando caduque, la API devuelve error y hay que repetir el paso de vinculación en el navegador. Añade un nodo **IF** que compruebe si la respuesta trae `status_code` y te avise por Telegram.
- **Límite de peticiones**: GoCardless permite 4 llamadas por cuenta y día en el plan gratuito. Por eso el flujo es semanal o, como mucho, diario. No lo pongas cada hora.
- **Duplicados**: algunos bancos no devuelven `internalTransactionId`; por eso el código construye un id de repuesto con fecha+importe+concepto. Si aun así se duplica algo, revisa la Matching Column del nodo Sheets.
- **Movimientos pendientes**: los `pending` cambian de importe o desaparecen al consolidarse. Como se guardan con Append or Update, se corrigen solos a la semana siguiente.
- **Cuentas de varios bancos**: duplica los nodos «Movimientos» y «Saldo» con otro `account_id` y únelos con un nodo **Merge** en modo `Append`.

## Cuánto cuesta
- GoCardless Bank Account Data: gratis (plan de desarrollador, hasta 50 cuentas). No hace falta tarjeta.
- n8n auto-alojado: gratis. Telegram: gratis. Google Sheets: gratis.
- Total real: 0 € si ya tienes dónde correr n8n. Un agregador comercial equivalente cuesta entre 15 y 30 € al mes.
- En Make se puede replicar con módulos HTTP, pero cada ejecución consume 4-5 operaciones; con una vez a la semana cabe de sobra en el plan gratuito.
