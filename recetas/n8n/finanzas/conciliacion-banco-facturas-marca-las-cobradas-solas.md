# Conciliación banco-facturas: marca las cobradas solas…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Cruza los ingresos de tu cuenta bancaria con tus facturas emitidas pendientes, marca como cobradas las que cuadran por importe y referencia, y te lista las dudosas.

## Qué es y qué hace

Cada día lee la hoja Movimientos, con los apuntes del banco, y la hoja Facturas con las emitidas pendientes. Empareja cada ingreso por número de factura en el concepto, importe exacto o importe exacto más nombre del cliente. Las que cuadran se marcan como cobradas con su fecha; las dudosas se listan en un mensaje de Slack para revisión manual.

## Cómo usarla

1. Preparar las hojas Movimientos y Facturas con sus columnas
2. Crear la app de Slack y el bot
3. Montar el emparejado en n8n
4. Que lo revise un profesional

## Cuándo usarla

Cuando tienes que ir movimiento a movimiento del banco buscando a qué factura corresponde cada ingreso, y por eso reclamas facturas que ya te habían pagado.

## Cómo ganar dinero con ella

Ahorra 3-5 horas al mes de punteo y evita el ridículo de reclamar a un cliente que ya pagó. También detecta cobros parciales que se te pasarían.

- Punteo automático de cobros para negocios que cobran por transferencia y llevan facturas en hoja.
- Revisión semanal de cobros dudosos con el cliente para pymes con muchas facturas abiertas.
- Montaje del emparejado de cobros para una gestoría que lleva la contabilidad de varios clientes.

**Precio orientativo:** 200–400 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada día lee la hoja `Movimientos` (los apuntes del banco, que puedes alimentar con la receta de open banking o subiendo el CSV del banco) y la hoja `Facturas` con las emitidas pendientes. Empareja ingreso con factura por tres criterios: número de factura en el concepto, importe exacto, o importe exacto más nombre del cliente. Las que cuadran se marcan como cobradas con su fecha; las que no, se listan en un mensaje de Slack para que las mires tú.
Para negocios que cobran por transferencia y llevan las facturas en hoja de cálculo.

## Lo que necesitas antes
- Hoja `Movimientos` con columnas `id`, `fecha`, `concepto`, `importe` (positivo si entra).
- Hoja `Facturas` con `numero`, `cliente`, `importe`, `fecha_emision`, `estado`, `fecha_cobro`, `movimiento_id`.
- Un espacio de Slack gratuito y una app de Slack: en `api.slack.com/apps` creas una app, en OAuth & Permissions le das el scope `chat:write`, la instalas en tu espacio y copias el Bot Token (`xoxb-...`). Invita al bot al canal con `/invite @tubot`.
- Credenciales **Google Sheets OAuth2** y **Slack API** en n8n. Si prefieres Telegram o email, cambia el último nodo y listo.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: `Days`, Hour: `9`, Minute: `30`. Timezone `Europe/Madrid`.
2. **Google Sheets** («Movs») — Operation: `Get Row(s)`, Sheet: `Movimientos`.
3. **Google Sheets** («Pendientes») — Operation: `Get Row(s)`, Sheet: `Facturas`. En Options > Filters puedes poner Lookup Column `estado`, Lookup Value `pendiente` para traer menos filas.
4. **Code** («Emparejar») — Mode: `Run Once for All Items`. Código abajo. Devuelve dos tipos de item: los que llevan `tipo: 'match'` y uno final con `tipo: 'informe'`.
5. **Switch** — Mode: `Rules`, Routing Rules: regla 1 `{{ $json.tipo }}` equals `match` (salida 0), regla 2 `{{ $json.tipo }}` equals `informe` (salida 1).
6. **Google Sheets** («Marcar cobrada») — desde la salida 0. Operation: `Update Row`, Matching Columns: `numero`. Values: `numero`, `estado` = `cobrada`, `fecha_cobro` = `{{ $json.fecha_cobro }}`, `movimiento_id` = `{{ $json.movimiento_id }}`.
7. **Slack** («Aviso») — desde la salida 1. Resource: `Message`, Operation: `Send`, Send Message To: `Channel`, Channel: `#finanzas`, Message Text: `{{ $json.texto }}`.

## El código del nodo Code
```javascript
const norm = s => String(s || '').toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/[^a-z0-9]/g, '');
const num = v => Number(String(v ?? 0).replace(/\./g,'').replace(',','.')) || 0;
const movs = $('Movs').all().map(i => i.json).filter(m => num(m.importe) > 0 && !m.conciliado);
const facs = $('Pendientes').all().map(i => i.json).filter(f => String(f.estado).toLowerCase() === 'pendiente');
const usados = new Set();
const matches = [];
const dudosas = [];
for (const f of facs) {
  const impF = num(f.importe);
  const numFac = norm(f.numero);
  const cli = norm(f.cliente).slice(0, 10);
  let elegido = null, motivo = '';
  for (const m of movs) {
    if (usados.has(m.id)) continue;
    const conc = norm(m.concepto);
    if (numFac && conc.includes(numFac)) { elegido = m; motivo = 'nº de factura en el concepto'; break; }
  }
  if (!elegido) {
    const candidatos = movs.filter(m => !usados.has(m.id) && Math.abs(num(m.importe) - impF) < 0.02);
    if (candidatos.length === 1) { elegido = candidatos[0]; motivo = 'importe exacto único'; }
    else if (candidatos.length > 1) {
      const porCliente = candidatos.filter(m => cli && norm(m.concepto).includes(cli));
      if (porCliente.length === 1) { elegido = porCliente[0]; motivo = 'importe + nombre del cliente'; }
      else dudosas.push(`${f.numero} (${impF.toFixed(2)} €): ${candidatos.length} ingresos con ese importe`);
    }
  }
  if (elegido) {
    usados.add(elegido.id);
    matches.push({ json: { tipo: 'match', numero: f.numero, cliente: f.cliente, importe: impF,
      fecha_cobro: elegido.fecha, movimiento_id: elegido.id, motivo } });
  } else if (!dudosas.some(d => d.startsWith(String(f.numero)))) {
    const parcial = movs.find(m => !usados.has(m.id) && cli && norm(m.concepto).includes(cli) && num(m.importe) < impF);
    if (parcial) dudosas.push(`${f.numero}: posible cobro PARCIAL de ${num(parcial.importe).toFixed(2)} € sobre ${impF.toFixed(2)} €`);
  }
}
const huerfanos = movs.filter(m => !usados.has(m.id)).map(m => `${m.fecha} ${num(m.importe).toFixed(2)} € — ${String(m.concepto).slice(0,60)}`);
const texto = [
  `*Conciliación del ${new Date().toISOString().slice(0,10)}*`,
  `Facturas marcadas como cobradas: ${matches.length}`,
  matches.map(m => `• ${m.json.numero} ${m.json.importe.toFixed(2)} € (${m.json.motivo})`).join('\n'),
  dudosas.length ? `\n*Revisar a mano:*\n${dudosas.join('\n')}` : '',
  huerfanos.length ? `\n*Ingresos sin factura asignada:*\n${huerfanos.slice(0,10).join('\n')}` : ''
].filter(Boolean).join('\n');
return [...matches, { json: { tipo: 'informe', texto } }];
```

## Cómo probarla
- Copia tus hojas reales a un documento de pruebas y apunta el flujo ahí. Nunca estrenes esto sobre tus datos buenos.
- Prepara casos a propósito: una factura con su número en el concepto, dos facturas del mismo importe el mismo día, un cobro parcial. Comprueba que el flujo acierta en el primero y manda los otros dos a revisión.
- Ejecuta dos veces seguidas: la segunda no debe volver a marcar nada, porque las facturas ya están en estado `cobrada`.

## Qué puede salir mal
- **Cobros agrupados**: un cliente que paga tres facturas en una transferencia no cuadra por importe. Aparecerá como ingreso huérfano; añade el caso a mano. Se puede ampliar el código para buscar sumas de 2 o 3 facturas, pero empieza simple.
- **Comisiones**: si el banco descuenta 0,35 €, el importe no coincide exactamente. Sube la tolerancia de `0.02` a `0.5` en la comparación si te pasa a menudo.
- **Falsos positivos**: dos facturas de 121,00 € el mismo día pueden intercambiarse. Por eso solo se marca cuando el candidato es único; el resto va a revisión. No bajes esa cautela.
- **Orden de las facturas**: el código procesa en el orden de la hoja y reserva movimientos ya usados. Ordena la hoja por fecha de emisión ascendente para que las más antiguas se cobren primero.
- **Reintentos**: si el nodo Sheets falla a mitad, algunas facturas quedan marcadas y otras no. No pasa nada, la ejecución siguiente retoma. Activa Retry On Fail con 2 intentos.

## Cuánto cuesta
- 0 € con n8n auto-alojado, Sheets y Slack gratuito.
- Si alimentas la hoja `Movimientos` con la receta de open banking, sigue siendo gratis. Si subes el CSV del banco a mano una vez por semana, también.
- Un software de conciliación comercial cuesta entre 20 y 50 € al mes.
