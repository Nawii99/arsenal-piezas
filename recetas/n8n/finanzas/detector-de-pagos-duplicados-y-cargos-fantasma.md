# Detector de pagos duplicados y cargos fantasma…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Revisa cada día los movimientos del banco buscando cobros repetidos el mismo día por el mismo importe, cargos de proveedores que ya no trabajan contigo y micro-cargos raros de tarjeta.

## Qué es y qué hace

Cada día revisa los movimientos bancarios de los últimos 30 días, obtenidos por open banking, y marca tres casos: importes idénticos al mismo beneficiario en menos de 5 días, cargos de proveedores dados de baja en una hoja de Google Sheets y micro-cargos de origen desconocido. Envía un mensaje diario por Telegram y guarda un registro para no repetir avisos.

## Cómo usarla

1. Vincular el banco en GoCardless
2. Preparar la hoja Vigilancia con Proveedores y Revisados
3. Montar el flujo diario en n8n con Telegram
4. Que lo revise un profesional

## Cuándo usarla

Cuando pagas facturas de proveedor a mano o por transferencia y temes haber pagado dos veces la misma.

## Cómo ganar dinero con ella

Un pago duplicado de 400 euros no reclamado a tiempo es dinero perdido. Los cargos fantasma de tarjeta suelen ser pequeños pero mensuales y eternos.

- Vigilancia de pagos para pymes que pagan a muchos proveedores por transferencia.
- Revisión mensual de cargos sospechosos para un gestor que lleva varias cuentas de clientes.
- Informe de pagos duplicados recuperables para una oficina contable que reclama a bancos y proveedores.

**Precio orientativo:** 120–250 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Descarga los movimientos bancarios de los últimos 30 días y aplica tres reglas: importes idénticos al mismo beneficiario en menos de 5 días, cargos de proveedores marcados como dados de baja en tu hoja, y cargos pequeños de origen desconocido.
Te manda un solo mensaje al día con lo sospechoso y guarda un registro para que no te avise dos veces del mismo movimiento. Para cualquier negocio con pagos frecuentes a proveedores.

## Lo que necesitas antes
GoCardless Bank Account Data (gratis) con tu cuenta vinculada: `secret_id`, `secret_key` y `account_id`.
Hoja de Google Sheets `Vigilancia` con pestaña `Proveedores`: `nombre_en_banco`, `estado` (activo/baja). Y pestaña `Revisados`: `id_movimiento`, `fecha`, `motivo`.
Bot de Telegram con token y `chat_id`.

## Los nodos, en orden
**1. Schedule Trigger** — Cada día a las 20:00, `Europe/Madrid`.
**2. HTTP Request** (`Token`) — `POST` a `https://bankaccountdata.gocardless.com/api/v2/token/new/`, body JSON con `secret_id` y `secret_key`.
**3. HTTP Request** (`Movimientos`) — `GET` a `https://bankaccountdata.gocardless.com/api/v2/accounts/TU_ACCOUNT_ID/transactions/`, header `Authorization` = `=Bearer {{ $json.access }}`, query `date_from` = `={{ $now.minus(30,'days').toFormat('yyyy-MM-dd') }}`.
**4. Google Sheets** (`Proveedores`) — `Get Row(s)`, pestaña `Proveedores`.
**5. Google Sheets** (`Revisados`) — `Get Row(s)`, pestaña `Revisados`.
**6. Code** (`Detectar`) — `Run Once for All Items`. Código abajo.
**7. Google Sheets** (`Marcar revisados`) — `Append`, pestaña `Revisados`.
**8. Telegram** — `Send Message` con `={{ $json.aviso }}`. Ponlo detrás de un **Filter** con `{{ $json.aviso }}` `is not empty`.

## El código del nodo Detectar
```javascript
const tx = $('Movimientos').first().json.transactions.booked || [];
const bajas = new Set($('Proveedores').all().map(i => i.json).filter(p => String(p.estado).toLowerCase() === 'baja').map(p => String(p.nombre_en_banco).toUpperCase().trim()));
const vistos = new Set($('Revisados').all().map(i => String(i.json.id_movimiento)));
const clave = t => `${t.creditorName || t.remittanceInformationUnstructured || ''}`.toUpperCase().trim();
const salidas = [];
const pagos = tx.filter(t => Number(t.transactionAmount.amount) < 0).map(t => ({ id: t.internalTransactionId || t.transactionId || `${t.bookingDate}-${t.transactionAmount.amount}-${clave(t)}`, fecha: t.bookingDate, nombre: clave(t), importe: Math.abs(Number(t.transactionAmount.amount)) }));
for (let i = 0; i < pagos.length; i++) {
  const a = pagos[i];
  if (vistos.has(a.id)) continue;
  let motivo = '';
  for (let j = 0; j < pagos.length; j++) {
    if (i === j) continue;
    const b = pagos[j];
    const dif = Math.abs(new Date(a.fecha) - new Date(b.fecha)) / 86400000;
    if (b.nombre === a.nombre && Math.abs(b.importe - a.importe) < 0.01 && dif <= 5) { motivo = 'POSIBLE DUPLICADO'; break; }
  }
  if (!motivo && [...bajas].some(b => b && a.nombre.includes(b))) motivo = 'PROVEEDOR DADO DE BAJA';
  if (!motivo && a.importe > 0 && a.importe < 3) motivo = 'MICROCARGO SOSPECHOSO';
  if (!motivo) continue;
  salidas.push({ json: { id_movimiento: a.id, fecha: a.fecha, motivo, aviso: `🕵️ ${motivo}: ${a.nombre} — ${a.importe.toFixed(2)} € el ${a.fecha}` } });
}
return salidas.length ? salidas : [{ json: { aviso: '' } }];
```

## Cómo probarla
Ejecuta a mano sobre tus últimos 30 días. Si sale mucho ruido (nóminas iguales, cuotas repetidas), añade esos nombres a la pestaña `Proveedores` con estado `activo` y amplía el código para excluirlos.
Marca un proveedor real como `baja` para comprobar que salta la regla.

## Qué puede salir mal
Falsos positivos clásicos: pagos fraccionados al mismo proveedor el mismo día. Sube el umbral a `dif <= 2` o añade una lista blanca de conceptos.
Algunos bancos no dan `internalTransactionId`: por eso el código genera una clave alternativa. Si tu banco cambia el concepto entre días, un mismo movimiento puede avisarte dos veces.
Límite de 4 llamadas por cuenta y día en el plan gratuito de GoCardless: no lo pongas más de una vez al día.
Si el flujo se cae después de avisar pero antes de escribir en `Revisados`, mañana repetirá. Pon el nodo de escritura antes del Telegram para curarte en salud.

## Cuánto cuesta
Gratis: GoCardless plan gratuito, Sheets, Telegram y n8n auto-alojado.
