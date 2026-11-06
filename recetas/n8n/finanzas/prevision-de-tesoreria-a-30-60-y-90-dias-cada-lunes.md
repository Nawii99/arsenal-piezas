# Previsión de tesorería a 30, 60 y 90 días cada lunes…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Todos los lunes recibes un correo que te dice cuánto dinero tendrás dentro de un mes, dos y tres, sumando cobros previstos y restando gastos fijos e impuestos. Para dormir tranquilo.

## Qué es y qué hace

Cada lunes lee tres pestañas de una hoja (saldo actual, cobros previstos y pagos previstos), proyecta semana a semana los próximos 90 días y envía un correo con la tabla y un aviso si el saldo llega a negativo. Sirve para adelantar cobros o retrasar gastos a tiempo. Se monta con n8n, Make o Zapier y solo requiere una hoja de cálculo.

## Cómo usarla

1. Crea la hoja Tesorería con sus tres pestañas
2. Rellena los cobros y pagos previstos
3. Conecta Sheets y Gmail
4. Compara la proyección con el banco durante un mes
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tienes ingresos irregulares y nunca sabes si el mes que viene llegas a pagar nóminas, cuota de autónomos o el IVA.

## Cómo ganar dinero con ella

Ver un agujero con 6 semanas de margen te permite adelantar cobros o retrasar compras en vez de pedir un descubierto al 12% TAE. Evita 300-1.000 € al año en intereses.

- Previsión de caja mensual como servicio para pymes con ingresos irregulares…
- Panel de tesorería para autónomos que preparan una financiación…
- Configuración de seguimiento de caja para negocios de proyectos…

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada lunes por la mañana lee tres pestañas de tu hoja (saldo actual, cobros previstos y pagos previstos), proyecta semana a semana los próximos 90 días y te manda un email con la tabla, un gráfico y un aviso claro si en algún momento te pones en negativo.
Es para cualquier negocio pequeño con ingresos por proyectos o estacionales, donde la media mensual no sirve de nada.

## Lo que necesitas antes
Una hoja de Google Sheets «Tesorería» con tres pestañas.
Pestaña `Saldo`: dos columnas, Fecha y Importe. Una sola fila que actualizas tú el lunes con lo que tienes en el banco.
Pestaña `Cobros`: Concepto, Cliente, Importe, FechaPrevista, Probabilidad (un número de 0 a 100).
Pestaña `Pagos`: Concepto, Importe, FechaPrevista, Tipo (`fijo` o `puntual`).
Credencial de Google en n8n con Sheets y Gmail.

## Los nodos, en orden
**Schedule Trigger**: cada semana, día lunes, hora 8. Timezone del workflow: Europe/Madrid.
**Google Sheets** (renombra el nodo a `Saldo`): Get Row(s), pestaña Saldo, Return All.
**Google Sheets** (renombra a `Cobros`): Get Row(s), pestaña Cobros, Return All.
**Google Sheets** (renombra a `Pagos`): Get Row(s), pestaña Pagos, Return All. Conecta los tres en cadena, uno detrás de otro.
**Code** (la proyección): modo «Run Once for All Items».
```javascript
const num = (v) => Number(String(v ?? '0').replace(/\./g, '').replace(',', '.')) || 0;
let saldo = num($('Saldo').first().json.Importe);
const cobros = $('Cobros').all().map(i => i.json);
const pagos = $('Pagos').all().map(i => i.json);
const hoy = new Date(); hoy.setHours(0,0,0,0);
const semanas = [];
for (let s = 1; s <= 13; s++) {
  const desde = new Date(hoy.getTime() + (s-1)*7*86400000);
  const hasta = new Date(hoy.getTime() + s*7*86400000);
  const entra = cobros.filter(c => { const f = new Date(c.FechaPrevista); return f >= desde && f < hasta; })
    .reduce((t, c) => t + num(c.Importe) * (num(c.Probabilidad || 100) / 100), 0);
  const sale = pagos.filter(p => { const f = new Date(p.FechaPrevista); return f >= desde && f < hasta; })
    .reduce((t, p) => t + num(p.Importe), 0);
  saldo = saldo + entra - sale;
  semanas.push({ semana: s, fecha: hasta.toISOString().slice(0,10), entra: entra.toFixed(2), sale: sale.toFixed(2), saldo: saldo.toFixed(2) });
}
const minimo = semanas.reduce((m, s) => Number(s.saldo) < Number(m.saldo) ? s : m, semanas[0]);
const alerta = Number(minimo.saldo) < 0 ? `AVISO: te quedas en ${minimo.saldo} € la semana del ${minimo.fecha}. Tienes ${minimo.semana * 7} días para arreglarlo.` : `Todo en verde. El punto más bajo son ${minimo.saldo} € el ${minimo.fecha}.`;
const filas = semanas.map(s => `<tr><td>${s.fecha}</td><td style="text-align:right">+${s.entra}</td><td style="text-align:right">-${s.sale}</td><td style="text-align:right;font-weight:bold;color:${Number(s.saldo)<0?'red':'black'}">${s.saldo} €</td></tr>`).join('');
const datos = semanas.map(s => s.saldo).join(',');
const etiquetas = semanas.map(s => s.fecha.slice(5)).join(',');
const grafico = `https://quickchart.io/chart?w=600&h=250&c={type:'line',data:{labels:[${etiquetas.split(',').map(e=>`'${e}'`).join(',')}],datasets:[{label:'Saldo',data:[${datos}],fill:false}]}}`;
return [{ json: { alerta, html: `<h2>Tesorería a 90 días</h2><p><b>${alerta}</b></p><img src="${encodeURI(grafico)}"><table border=1 cellpadding=6 style="border-collapse:collapse"><tr><th>Semana hasta</th><th>Cobros</th><th>Pagos</th><th>Saldo</th></tr>${filas}</table>` } }];
```
**Gmail**: Send, To tu correo, Subject `=Tesorería: {{ $json.alerta.slice(0,60) }}`, Email Type «HTML», Message `={{ $json.html }}`.

## Cómo probarla
Rellena las tres pestañas con datos reales de las próximas 8 semanas: tu saldo de hoy, las facturas que esperas cobrar y tus gastos fijos (alquiler, cuota de autónomos, nóminas, préstamos, IVA trimestral).
Ejecuta a mano y contrasta la primera semana con lo que tú calcularías a ojo. Si no cuadra, casi siempre es una fecha mal puesta o un gasto fijo que olvidaste.
Mete a propósito un gasto grande dentro de tres semanas y comprueba que el aviso rojo aparece.

## Qué puede salir mal
Olvidar gastos recurrentes: es el error número uno. Apunta en `Pagos` todos los meses de golpe (12 filas de alquiler, 12 de cuota) para no tener que acordarte.
Optimismo en la probabilidad de cobro: pon 60-70% a clientes nuevos y 90% a los de siempre, no 100% a todo.
Fechas como texto: formatea las columnas de fecha en Sheets como fecha; si no, `new Date()` devolverá «Invalid Date» y los importes no entrarán en ninguna semana.
QuickChart tiene un límite generoso en su capa gratuita; si el gráfico no carga, quítalo, la tabla es lo importante.
Algunos clientes de correo bloquean imágenes externas: pulsa «mostrar imágenes» o quédate con la tabla.

## Cuánto cuesta
Gratis del todo: Sheets, Gmail y la API pública de QuickChart no cobran a este volumen.
