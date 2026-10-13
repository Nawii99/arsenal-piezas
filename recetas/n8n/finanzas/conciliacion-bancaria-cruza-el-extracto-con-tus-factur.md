# Conciliación bancaria: cruza el extracto con tus factur…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Subes el CSV del banco a una carpeta de Drive y el sistema cruza cada ingreso con tus facturas pendientes, marca las cobradas y te dice qué movimientos no ha sabido casar.

## Qué es y qué hace

Lee el CSV de movimientos que descargas del banco desde una carpeta de Drive, compara cada ingreso con tus facturas pendientes por importe y fecha, marca como cobradas las que casan y envía un correo con los movimientos que no ha sabido conciliar. Se monta con n8n, Make o Zapier y necesita una hoja de facturas.

## Cómo usarla

1. Crea la carpeta Extractos banco
2. Prepara la hoja de facturas con sus columnas
3. Exporta un CSV de prueba de tu banco
4. Revisa las conciliaciones dudosas
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando cada mes te sientas con el extracto del banco al lado de tu Excel de facturas a ir tachando líneas una por una.

## Cómo ganar dinero con ella

Sustituye 2-4 horas mensuales de picar el extracto. A 30 €/hora son 60-120 € al mes de tu tiempo, y detecta cobros que dabas por perdidos.

- Conciliación mensual de cobros como servicio para negocios que llevan Excel…
- Limpieza de la hoja de facturas antes de cerrar el ejercicio…
- Informe de cobros pendientes para reuniones con el gestor…

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cuando dejas caer el CSV que te descargas del banco en una carpeta de Drive, el flujo lee todos los movimientos, los compara con tus facturas en estado pendiente y marca como cobradas las que casan por importe y fecha.
Después te manda un correo con dos listas: lo que ha conciliado solo y lo que necesita que mires tú.
Para cualquier negocio pequeño que lleva la facturación en una hoja de cálculo y no en un ERP.

## Lo que necesitas antes
La hoja «Facturas emitidas» de la receta del cobrador, con las columnas NumFactura, Cliente, Total, Estado, FechaCobro.
Una carpeta en Drive llamada «Extractos banco» (copia su ID de la URL).
Saber exportar el CSV de tu banco: casi todos tienen «Descargar movimientos» en formato CSV o Excel. Mira qué columnas trae (normalmente Fecha, Concepto, Importe).
Credencial de Google en n8n con permisos de Drive, Sheets y Gmail.

## Los nodos, en orden
**Google Drive Trigger**: Event «File Created», Watch «Specific Folder», la carpeta «Extractos banco». Poll cada minuto.
**Google Drive**: Operation «Download File», File ID `={{ $json.id }}`.
**Extract from File**: Operation «From CSV», Input Binary Field `data`. En Options pon Delimiter `;` si tu banco usa punto y coma (los bancos españoles suelen), y Encoding `latin1` si ves acentos rotos.
**Google Sheets**: Operation «Get Row(s)», hoja «Facturas emitidas», Return All, Filters > `Estado` igual a `pendiente`.
**Code** (el cruce): modo «Run Once for All Items». Ojo: renombra el nodo del CSV a `Movimientos` y el de Sheets a `Pendientes` para que las referencias funcionen.
```javascript
const movs = $('Movimientos').all().map(i => i.json);
const facturas = $('Pendientes').all().map(i => i.json);
const num = (v) => Number(String(v ?? '0').replace(/\./g, '').replace(',', '.')) || 0;
const casadas = []; const sinCasar = [];
for (const m of movs) {
  const imp = num(m.Importe);
  if (imp <= 0) continue;
  const concepto = String(m.Concepto || '').toUpperCase();
  let match = facturas.find(f => f.Estado === 'pendiente' && concepto.includes(String(f.NumFactura).toUpperCase()));
  if (!match) { match = facturas.find(f => f.Estado === 'pendiente' && Math.abs(num(f.Total) - imp) < 0.02); }
  if (!match) { match = facturas.find(f => f.Estado === 'pendiente' && concepto.includes(String(f.Cliente || '').toUpperCase().split(' ')[0]) && Math.abs(num(f.Total) - imp) < 5); }
  if (match) { match.Estado = 'cobrada'; casadas.push({ json: { NumFactura: match.NumFactura, Cliente: match.Cliente, Total: match.Total, Estado: 'cobrada', FechaCobro: m.Fecha } }); }
  else { sinCasar.push(`${m.Fecha} — ${imp.toFixed(2)} € — ${m.Concepto}`); }
}
const pendientesAun = facturas.filter(f => f.Estado === 'pendiente').map(f => `${f.NumFactura} — ${f.Cliente} — ${f.Total} €`);
return [...casadas.map(c => ({ json: { ...c.json, _tipo: 'casada' } })), { json: { _tipo: 'informe', sinCasar: sinCasar.join('\n') || 'ninguno', pendientesAun: pendientesAun.join('\n') || 'ninguna', totalCasadas: casadas.length } }];
```
**IF**: condición `={{ $json._tipo }}` igual a `casada`.
**Google Sheets** (rama true): Operation «Update Row», Matching Column `NumFactura`, actualiza Estado y FechaCobro.
**Gmail** (rama false): Operation «Send», To tu email, Subject `Conciliación bancaria del {{ $now.format('dd/MM/yyyy') }}`, Message: `=Facturas conciliadas: {{ $json.totalCasadas }}\n\nMOVIMIENTOS QUE NO HE SABIDO CASAR:\n{{ $json.sinCasar }}\n\nFACTURAS QUE SIGUEN SIN COBRAR:\n{{ $json.pendientesAun }}`

## Cómo probarla
Descarga un extracto real de un mes ya cerrado y sube el CSV a la carpeta.
Antes de dejar que escriba, desconecta el nodo de «Update Row» y ejecuta: mira en el Code qué casaría. Si el porcentaje de aciertos te convence, reconecta.
Prueba a propósito con un ingreso de un cliente que te paga siempre el mismo importe redondo: es el caso donde más falla el cruce por importe.

## Qué puede salir mal
Dos facturas del mismo importe: casará con la primera. Por eso el primer criterio es buscar el número de factura en el concepto; pídele a tus clientes que lo pongan en la transferencia.
Cobros agrupados (el cliente paga tres facturas de golpe): no los casará y saldrán en «sin casar». Es lo correcto, revísalos tú.
Separadores y decimales: los bancos españoles usan `;` como separador y coma decimal. El `num()` del código ya limpia los puntos de millar.
Importes negativos: se ignoran a propósito, aquí solo conciliamos cobros. Para gastos, otra receta.
Si tu banco exporta XLS en vez de CSV, cambia «From CSV» por «From XLS» en el nodo Extract from File.

## Cuánto cuesta
Cero euros: Drive, Sheets y Gmail entran en la cuenta gratuita.
Si más adelante quieres que el extracto llegue solo, hace falta un agregador bancario (mira la receta de alertas de saldo con GoCardless, que tiene capa gratuita).
