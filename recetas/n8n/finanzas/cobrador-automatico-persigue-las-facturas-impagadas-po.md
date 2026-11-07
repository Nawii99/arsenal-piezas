# Cobrador automático: persigue las facturas impagadas po…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Cada mañana mira qué facturas tuyas han vencido y manda al cliente un recordatorio distinto según los días de retraso, subiendo el tono de forma educada.

## Qué es y qué hace

Cada día laborable revisa tu hoja de facturas emitidas, calcula los días de retraso de las no cobradas y envía al cliente un correo distinto según el retraso, con un tono cada vez más firme. Además te manda un resumen por Telegram de quién debe qué. Se monta con n8n, Make o Zapier y necesita una hoja de facturas y un bot de Telegram.

## Cómo usarla

1. Crea la hoja Facturas emitidas con sus columnas
2. Conecta Google Sheets, Gmail y Telegram
3. Redacta los cuatro avisos
4. Prueba con una factura propia
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tienes clientes que pagan tarde y te da pereza o vergüenza reclamar, y acabas cobrando a 90 días lo que era a 30.

## Cómo ganar dinero con ella

Reclamar sin fallar reduce el plazo medio de cobro entre 10 y 25 días. Con 30.000 € facturados al año, es tener 1.500-2.500 € más en el banco de forma permanente.

- Gestión de cobros como servicio mensual para autónomos con clientes lentos…
- Plantillas de reclamación amables para agencias que facturan a empresas…
- Revisión mensual de la cartera de impagos con informe para el cliente…

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada día laborable a las 9:00 revisa tu hoja de facturas emitidas, calcula los días de retraso de las que no están cobradas y envía al cliente un email distinto a los 3, 10, 20 y 35 días, cada uno un punto más firme.
A ti te manda un resumen por Telegram con quién debe qué, para que no te enteres por sorpresa.
Es para autónomos y pymes que facturan a otras empresas y no tienen un departamento de administración.

## Lo que necesitas antes
Una hoja de Google Sheets «Facturas emitidas» con columnas: NumFactura, Cliente, EmailCliente, FechaFactura, FechaVencimiento, Total, Estado, UltimoAvisoDias.
El Estado se rellena a mano con `pendiente` o `cobrada`. UltimoAvisoDias déjalo vacío.
Credencial de Google (Sheets y Gmail) en n8n, igual que en cualquier receta con Google.
Un bot de Telegram: habla con @BotFather, `/newbot`, te da un token. Guarda el token solo en la credencial de Telegram de n8n; no lo pegues en URLs ni en nodos. Para sacar tu chat ID, escríbele algo a tu bot y mira `message.chat.id` en la salida de un **Telegram Trigger** en modo test (o pídeselo a un bot como @userinfobot).

## Los nodos, en orden
**Schedule Trigger**: Trigger Interval «Days», Days Between Triggers 1, Trigger at Hour 9. En Settings del workflow pon Timezone «Europe/Madrid».
**Google Sheets**: Operation «Get Row(s)», documento «Facturas emitidas», Return All activado. Filters > Column `Estado` igual a `pendiente`.
**Code** (decide a quién se escribe y qué se le dice): modo «Run Once for All Items».
```javascript
const hoy = new Date(); hoy.setHours(0,0,0,0);
const salida = [];
for (const item of $input.all()) {
  const f = item.json;
  const venc = new Date(f.FechaVencimiento);
  const dias = Math.floor((hoy - venc) / 86400000);
  const ya = Number(f.UltimoAvisoDias || 0);
  let tramo = 0, asunto = '', cuerpo = '';
  if (dias >= 35) { tramo = 35; asunto = `Factura ${f.NumFactura} vencida hace ${dias} días`; cuerpo = `Hola,\n\nLa factura ${f.NumFactura}, de ${f.Total} €, venció el ${f.FechaVencimiento} y sigue sin abonarse (${dias} días).\n\nTe agradecería que me confirmes hoy una fecha concreta de pago. Si no recibo noticias, tendré que pasar el asunto a reclamación formal, cosa que preferiría evitar.\n\nUn saludo`; }
  else if (dias >= 20) { tramo = 20; asunto = `Segundo aviso: factura ${f.NumFactura} pendiente`; cuerpo = `Hola,\n\nSigo sin ver el pago de la factura ${f.NumFactura} (${f.Total} €), vencida el ${f.FechaVencimiento}.\n\n¿Puedes decirme en qué fecha está prevista? Si hay algún problema con la factura, dímelo y lo resolvemos.\n\nGracias`; }
  else if (dias >= 10) { tramo = 10; asunto = `Recordatorio: factura ${f.NumFactura}`; cuerpo = `Hola,\n\nTe recuerdo que la factura ${f.NumFactura} por ${f.Total} € venció el ${f.FechaVencimiento}. Te dejo de nuevo los datos por si se traspapeló.\n\nSi ya está pagada, ignora este mensaje y perdona la insistencia.\n\nUn saludo`; }
  else if (dias >= 3) { tramo = 3; asunto = `Factura ${f.NumFactura} vencida`; cuerpo = `Hola,\n\nUn aviso rápido: la factura ${f.NumFactura} (${f.Total} €) venció el ${f.FechaVencimiento}. ¿Puedes revisarlo cuando tengas un momento?\n\nGracias`; }
  if (tramo > 0 && tramo > ya) { salida.push({ json: { ...f, dias, tramo, asunto, cuerpo, fila: item.json.row_number } }); }
}
return salida;
```
**Gmail**: Operation «Send», To `={{ $json.EmailCliente }}`, Subject `={{ $json.asunto }}`, Email Type «Text», Message `={{ $json.cuerpo }}`.
**Google Sheets** (marca el aviso): Operation «Update Row», Matching Column `NumFactura`, y en el campo UltimoAvisoDias pon `={{ $json.tramo }}`. Así no repite el mismo aviso.
**Code** (resumen para ti):
```javascript
const items = $('Code').all();
if (!items.length) return [{ json: { texto: 'Hoy no hay avisos de cobro que mandar.' } }];
const total = items.reduce((s, i) => s + Number(String(i.json.Total).replace(',', '.')), 0);
const lineas = items.map(i => `• ${i.json.Cliente} — ${i.json.NumFactura} — ${i.json.Total} € — ${i.json.dias} días`);
return [{ json: { texto: `Avisos de cobro enviados hoy: ${items.length}\nImporte perseguido: ${total.toFixed(2)} €\n\n${lineas.join('\n')}` } }];
```
**Telegram**: Operation «Send Message», Chat ID el tuyo, Text `={{ $json.texto }}`.

## Cómo probarla
Mete tres facturas de prueba con tu propio email como cliente y fechas de vencimiento de hace 4, 12 y 40 días.
Ejecuta a mano con «Test workflow» y comprueba que recibes tres correos con tonos distintos y que la columna UltimoAvisoDias se rellena con 3, 10 y 35.
Vuelve a ejecutar: no debe salir ningún correo. Eso confirma que no duplica.

## Qué puede salir mal
Fechas mal leídas: en Sheets pon la columna FechaVencimiento con formato de fecha AAAA-MM-DD, no como texto suelto.
Zona horaria: si no fijas Europe/Madrid en los ajustes del workflow, se ejecutará en UTC y verás desfases de un día en verano.
Enviar avisos en festivo o fin de semana: añade un **IF** después del Schedule con la condición `={{ [0,6].includes(new Date().getDay()) }}` es falso.
Cliente que ya pagó pero no actualizaste el Estado: quedas fatal. Costumbre: marcar `cobrada` el mismo día que ves el ingreso, o combínalo con la receta de conciliación bancaria.
Gmail limita a 500 envíos diarios en cuentas gratuitas; con esto ni te acercas.

## Cuánto cuesta
Todo gratis: Sheets, Gmail y Telegram no cobran nada por este uso.
Solo pagas n8n si usas su nube; autoalojado es 0 €.
