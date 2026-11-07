# Conciliación banco-facturas: quién te ha pagado de verd…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Cruza cada ingreso de tu banco con tus facturas emitidas, marca las cobradas, detecta pagos parciales y te lista solo lo que no cuadra para que lo revises tú.

## Qué es y qué hace

Cada lunes lee los ingresos de la semana en tu cuenta y los casa con las facturas pendientes de tu hoja: primero por número de factura en el concepto, luego por importe exacto y después por importe aproximado. Marca las cobradas y envía solo la lista dudosa. Se monta con n8n, Make o Zapier y usa GoCardless y Google Sheets.

## Cómo usarla

1. Obtén las credenciales de GoCardless y el ID de tu cuenta
2. Crea la hoja Facturas con sus columnas
3. Pide a tus clientes el número de factura en la transferencia
4. Revisa la primera lista dudosa
5. Que lo revise un profesional

## Cuándo usarla

Cuando cada mes pierdes una hora repasando el extracto para saber qué facturas están cobradas, o has reclamado a alguien que ya te había pagado.

## Cómo ganar dinero con ella

Ahorra 2-4 horas al mes de conciliación manual (60-140 € de tu tiempo) y evita reclamar a clientes que ya pagaron, que es la forma más rápida de quedar mal.

- Conciliación semanal de cobros como servicio para negocios con muchas facturas…
- Control de cobros parciales para proveedores con clientes que pagan a plazos…
- Configuración de conciliación para pymes que no usan programa contable…

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

**Qué hace y para quién**
Cada lunes lee los ingresos de la semana anterior en tu cuenta y los intenta casar con las facturas pendientes de tu hoja: primero por número de factura dentro del concepto, luego por importe exacto, luego por importe aproximado (diferencias de comisión bancaria). Marca las cobradas y te manda solo la lista de lo dudoso.
Para quien factura entre 10 y 200 facturas al mes y no tiene un programa contable con conciliación.

**Lo que necesitas antes**
- n8n y GoCardless Bank Account Data (`secret_id`, `secret_key`, y el ID de tu cuenta).
- Una hoja `Facturas` en Google Sheets con columnas: `numero`, `cliente`, `fecha_emision`, `total`, `estado` (pendiente/cobrada/parcial), `fecha_cobro`, `cobrado`.
- Gmail conectado.
- Buena práctica previa: pon en tus facturas «indica el número de factura en el concepto de la transferencia». Eso sube el acierto del 60 % al 90 %.

**Los nodos, en orden**
1. **Schedule Trigger** — lunes a las 8:00 (cron `0 8 * * 1`), zona `Europe/Madrid`.
2. **HTTP Request** (Token) — POST a `https://bankaccountdata.gocardless.com/api/v2/token/new/`.
3. **HTTP Request** (Movimientos) — GET `/api/v2/accounts/{ID}/transactions/?date_from={{ $now.minus(10,'days').toFormat('yyyy-MM-dd') }}`.
4. **Google Sheets** (Leer facturas) — `Get Row(s)` de la hoja `Facturas`.
5. **Code** (Conciliar) — casa ingresos con facturas (código abajo).
6. **Split In Batches** — tamaño 1, para actualizar fila a fila y no chocar con el límite de escritura de Sheets.
7. **IF** — `{{ $json.match }}` es igual a `true`.
8. **Google Sheets** (rama true) — «Update» buscando por columna `numero`: pone `estado` = cobrada (o parcial), `fecha_cobro` y `cobrado`.
9. **Gmail** (al final) — resumen: X facturas conciliadas, Y ingresos sin identificar, Z pagos parciales.

**El trozo de código (nodo Code)**
```javascript
const movs = $('Movimientos').first().json.transactions.booked.filter(t => Number(t.transactionAmount.amount) > 0);
const facturas = $('Leer facturas').all().map(i => i.json).filter(f => String(f.estado).toLowerCase() !== 'cobrada');
const out = [];
const usadas = new Set();
for (const m of movs) {
  const imp = Number(m.transactionAmount.amount);
  const texto = `${m.remittanceInformationUnstructured || ''} ${m.debtorName || ''}`.toUpperCase();
  let f = facturas.find(x => x.numero && texto.includes(String(x.numero).toUpperCase()) && !usadas.has(x.numero));
  if (!f) f = facturas.find(x => Math.abs(Number(x.total) - imp) < 0.01 && !usadas.has(x.numero));
  if (!f) f = facturas.find(x => Math.abs(Number(x.total) - imp) <= Number(x.total) * 0.02 && !usadas.has(x.numero));
  if (f) {
    usadas.add(f.numero);
    const parcial = imp < Number(f.total) - 0.5;
    out.push({ json: { match: true, numero: f.numero, cliente: f.cliente, total: f.total, cobrado: imp.toFixed(2), estado: parcial ? 'parcial' : 'cobrada', fecha_cobro: String(m.bookingDate).slice(0,10) } });
  } else {
    out.push({ json: { match: false, importe: imp.toFixed(2), concepto: texto.slice(0, 80), fecha: m.bookingDate } });
  }
}
return out.length ? out : [{ json: { match: false, importe: 0, concepto: 'Sin ingresos esta semana' } }];
```

**Cómo probarla**
- Ejecútala en modo manual con la escritura desactivada (desconecta el nodo Update) y revisa la tabla de resultados: ¿casa lo que casarías tú?
- Prueba adrede un ingreso con el número de factura en el concepto y otro sin él: el primero debe casar por número, el segundo por importe.
- Verifica un pago parcial (transferencia de 500 € sobre factura de 605 €): debe salir `estado: parcial`.

**Qué puede salir mal**
- Dos facturas con el mismo importe: el `Set usadas` evita casar dos veces la misma, pero puede asignarla al cliente equivocado. Por eso solo se marca automáticamente lo que casa por número; si quieres ser estricto, añade un **IF** que solo actualice cuando el match sea por número.
- Comisiones de plataforma (Stripe, PayPal) hacen que el ingreso sea menor: el margen del 2 % lo cubre; súbelo si trabajas con marketplaces.
- Pagos agrupados (un cliente paga 3 facturas juntas): no casan; saldrán en la lista de revisión, que es lo correcto.
- Límite de la API de Sheets: 60 escrituras por minuto y usuario. El **Split In Batches** con un **Wait** de 1 segundo lo resuelve si tienes muchas facturas.

**Cuánto cuesta**
Gratis con GoCardless, Sheets y Gmail. n8n auto-alojado sin límite; en n8n Cloud (de pago tras la prueba gratuita) son solo 4-5 ejecuciones al mes.
