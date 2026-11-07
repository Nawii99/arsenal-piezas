# Vigilante del banco: aviso de saldo bajo y gastos raros…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Se conecta a tu banco por la vía oficial de open banking, mira el saldo y los movimientos cada mañana y te avisa por Telegram si bajas de tu colchón mínimo o si hay un cargo raro.

## Qué es y qué hace

Lee el saldo y los movimientos de tu cuenta cada mañana con la API de open banking de GoCardless Bank Account Data, compara el saldo con el colchón mínimo que fijes y revisa los cargos del día frente a tu media. Si algo se sale, avisa por Telegram. Sirve para detectar cargos raros. Se monta con n8n, Make o Zapier y es de solo lectura.

## Cómo usarla

1. Crea la cuenta gratuita y genera secret_id y secret_key
2. Vincula tu banco con la autorización de GoCardless
3. Guarda el account_id en n8n
4. Fija tu colchón y tu umbral de aviso
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando no miras el banco a diario y te enteras tarde de una domiciliación duplicada, una suscripción que no recordabas o un saldo peligroso.

## Cómo ganar dinero con ella

Detectar a tiempo un cargo duplicado o un cobro fraudulento vale entre 50 y 500 € por incidente, y evitar un descubierto ahorra 30-40 € de comisión cada vez.

- Vigilancia bancaria diaria como servicio para autónomos sin tiempo de mirar la cuenta…
- Alertas de cargos inusuales para pymes con varias domiciliaciones…
- Configuración de open banking con colchón de seguridad para negocios pequeños…

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Usa la API gratuita de open banking de GoCardless (antes Nordigen), que conecta con más de 2.000 bancos europeos incluidos los españoles, para leer en solo lectura el saldo y los movimientos de tu cuenta de negocio.
Cada mañana compara el saldo con el colchón que tú fijes y revisa los cargos del día anterior contra tu media histórica. Si algo se sale, te lo cuenta por Telegram.
Para autónomos y pymes con una o dos cuentas y sin sistema de alertas decente en su banco.

## Lo que necesitas antes
Cuenta gratuita en bankaccountdata.gocardless.com. En «User Secrets» generas un `secret_id` y un `secret_key`. La capa gratuita da 50 conexiones de cuenta al mes, de sobra.
Vincular tu banco una vez: se hace con tres llamadas a su API (crear requisition, abrir el enlace, autorizar con tus claves del banco). Te devuelven un `account_id`. Guárdalo.
Importante: es acceso de solo lectura y caduca a los 90 días por normativa PSD2; tendrás que volver a autorizar cada trimestre.
Bot de Telegram con token y chat ID.
Una hoja «Movimientos banco» en Sheets para llevar histórico.

## Los nodos, en orden
**Schedule Trigger**: cada día a las 8:00, Europe/Madrid.
**HTTP Request** (renombra a `Token`): POST a `https://bankaccountdata.gocardless.com/api/v2/token/new/`, Body JSON en modo expresión: `{"secret_id":"{{ $env.GOCARDLESS_SECRET_ID }}","secret_key":"{{ $env.GOCARDLESS_SECRET_KEY }}"}`, con los dos valores guardados como variables de entorno de n8n y no escritos en el nodo: un flujo exportado se llevaría la clave. Devuelve un campo `access`.
**HTTP Request** (renombra a `Saldo`): GET a `https://bankaccountdata.gocardless.com/api/v2/accounts/TU_ACCOUNT_ID/balances/`. En Headers añade `Authorization` con valor `=Bearer {{ $('Token').item.json.access }}`.
**HTTP Request** (renombra a `Movimientos`): GET a `https://bankaccountdata.gocardless.com/api/v2/accounts/TU_ACCOUNT_ID/transactions/`, mismo header de Authorization.
**Code**: modo «Run Once for All Items».
```javascript
const COLCHON = 3000; // pon aquí tu mínimo de tranquilidad en euros
const bal = $('Saldo').first().json.balances;
const saldo = Number(bal[0].balanceAmount.amount);
const tx = $('Movimientos').first().json.transactions.booked || [];
const ayer = new Date(Date.now() - 86400000).toISOString().slice(0,10);
const deAyer = tx.filter(t => (t.bookingDate || '').startsWith(ayer));
const gastos = tx.filter(t => Number(t.transactionAmount.amount) < 0).map(t => Math.abs(Number(t.transactionAmount.amount)));
const media = gastos.length ? gastos.reduce((a,b)=>a+b,0) / gastos.length : 0;
const umbral = Math.max(media * 3, 200);
const avisos = [];
if (saldo < COLCHON) avisos.push(`SALDO BAJO: ${saldo.toFixed(2)} € (tu colchón son ${COLCHON} €)`);
for (const t of deAyer) {
  const imp = Number(t.transactionAmount.amount);
  const conc = t.remittanceInformationUnstructured || t.creditorName || 'sin concepto';
  if (imp < 0 && Math.abs(imp) > umbral) avisos.push(`CARGO GRANDE: ${Math.abs(imp).toFixed(2)} € — ${conc}`);
}
const claves = deAyer.filter(t => Number(t.transactionAmount.amount) < 0).map(t => `${t.transactionAmount.amount}|${t.creditorName || ''}`);
const dups = claves.filter((c, i) => claves.indexOf(c) !== i);
if (dups.length) avisos.push(`POSIBLE CARGO DUPLICADO: ${[...new Set(dups)].join(', ')}`);
const filas = deAyer.map(t => ({ json: { Fecha: t.bookingDate, Concepto: t.remittanceInformationUnstructured || t.creditorName || '', Importe: t.transactionAmount.amount } }));
const cabecera = { json: { _aviso: true, texto: avisos.length ? `BANCO — ${ayer}\nSaldo: ${saldo.toFixed(2)} €\n\n` + avisos.join('\n') : '' } };
return [cabecera, ...filas];
```
**IF**: `={{ $json._aviso }}` es verdadero Y `={{ $json.texto }}` no está vacío.
**Telegram** (rama true): Send Message con `={{ $json.texto }}`.
**Google Sheets** (rama false): Append Row en «Movimientos banco» con Fecha, Concepto e Importe. Así te construyes el histórico para la conciliación.

## Cómo probarla
Primero prueba solo el nodo `Token`: si devuelve un `access`, tus claves están bien.
Luego `Saldo`: si da 401, el token caducó (dura 24 horas, por eso se pide en cada ejecución). Si da 403, la autorización del banco expiró y hay que rehacer la requisition.
Baja el COLCHON a un número altísimo (por ejemplo 999999) y ejecuta: debe llegarte el aviso de saldo bajo. Luego pon tu cifra real.

## Qué puede salir mal
La autorización caduca cada 90 días por ley: apúntatelo en el calendario o monta un aviso con esta misma herramienta.
Muchos bancos solo devuelven 90 días de histórico, así que la media de gastos es de ese periodo.
Falsos positivos los primeros días: el umbral de «cargo grande» se calcula sobre la media; súbelo a mano si te satura.
Cuentas con muchos movimientos: la API pagina; con una cuenta de negocio pequeña no llegarás al límite, pero si ves movimientos que faltan revisa la paginación.
No metas nunca las claves en el campo Body a la vista: usa las Credentials de n8n o variables de entorno.

## Cuánto cuesta
GoCardless Bank Account Data: gratis hasta 50 cuentas conectadas, más que suficiente.
Telegram y Sheets: gratis. n8n autoalojado: gratis.
