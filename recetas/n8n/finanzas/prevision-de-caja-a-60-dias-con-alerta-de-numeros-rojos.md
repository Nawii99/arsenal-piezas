# Previsión de caja a 60 días con alerta de números rojos…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Proyecta día a día lo que va a entrar y salir de tu cuenta en los próximos 60 días y te avisa si en algún momento el saldo se pone por debajo de tu colchón mínimo.

## Qué es y qué hace

Cada lunes construye una previsión diaria de 60 días con el saldo actual, las facturas emitidas pendientes en su fecha de vencimiento, los gastos fijos y los pagos puntuales de Google Sheets. Te envía a Telegram el saldo mínimo previsto, el día en que ocurre y, si baja del colchón, una alerta con las opciones. Para negocios con cobros aplazados y gastos fijos altos.

## Cómo usarla

1. Preparar las hojas Config, Facturas y Fijos
2. Credenciales de Google Sheets y Telegram en n8n
3. Probar con un mes real
4. Que lo revise un profesional

## Cuándo usarla

Cuando cobras a 30-60 días pero pagas nóminas, alquiler y proveedores a fecha fija, y te asustas al ver el saldo sin saber si es un bache o un problema real.

## Cómo ganar dinero con ella

Ver un agujero con 6 semanas de antelación te deja negociar con el banco o adelantar un cobro en vez de pagar un descubierto al 12% o un confirming urgente.

- Previsión de caja a 60 días para empresas con nóminas y alquiler a fecha fija.
- Revisión quincenal de la previsión con ajustes de cobros para pymes con tensión de tesorería.
- Plantilla de tesorería que el consultor financiero entrega y mantiene como servicio mensual.

**Precio orientativo:** 250–500 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada lunes coge tu saldo actual, tus facturas emitidas pendientes con su fecha de cobro prevista, tus gastos fijos recurrentes y los pagos puntuales que tengas apuntados, y construye una previsión día a día de 60 días. Te manda a Telegram el saldo mínimo previsto, el día en que ocurre y, si baja de tu colchón, una alerta con lo que puedes hacer.
Para negocios con cobros aplazados y gastos fijos altos: agencias, talleres, distribuidoras, empresas con empleados.

## Lo que necesitas antes
- Hoja `Config` con dos celdas nombradas o dos columnas: `saldo_actual` y `colchon_minimo` (por ejemplo 5000). Puedes alimentar `saldo_actual` con la receta de open banking o escribirlo tú cada lunes.
- Hoja `Facturas` (emitidas) con `numero`, `cliente`, `importe`, `fecha_vencimiento`, `estado`.
- Hoja `Fijos` con `concepto`, `importe`, `dia_mes` (el día del mes en que se paga, por ejemplo 5 para el alquiler, 1 para nóminas, 20 para la cuota de autónomos) y `tipo` (`gasto` o `ingreso`).
- Hoja `Puntuales` con `fecha`, `concepto`, `importe` (negativo si es pago) para cosas concretas: el IVA del trimestre, una compra de maquinaria, la paga extra.
- Bot de Telegram y chat_id. Credenciales **Google Sheets OAuth2** y **Telegram API**.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: `Weeks`, Trigger on Weekdays: `Monday`, Hour: `8`, Minute: `30`. Timezone `Europe/Madrid`.
2. **Google Sheets** («Config») — Get Row(s), Sheet: `Config`.
3. **Google Sheets** («Facturas») — Get Row(s), Sheet: `Facturas`.
4. **Google Sheets** («Fijos») — Get Row(s), Sheet: `Fijos`.
5. **Google Sheets** («Puntuales») — Get Row(s), Sheet: `Puntuales`. Encadena los cuatro nodos de Sheets uno detrás de otro (no en paralelo) para que el Code pueda referenciarlos todos por nombre.
6. **Code** («Proyectar caja») — Mode: `Run Once for All Items`. Código abajo.
7. **Google Sheets** («Guardar previsión») — Operation: `Append or Update Row`, Sheet: `Prevision`, Matching Columns: `fecha`. Así tienes el histórico y puedes hacer un gráfico dentro de la propia hoja (Insertar > Gráfico > línea).
8. **IF** («¿Riesgo?») — Condition `Boolean`, `{{ $json.riesgo }}` is true.
9. **Telegram** («Alerta») — Text: `{{ $json.mensaje }}`, Parse Mode: `HTML`.

## El código del nodo Code
```javascript
const num = v => Number(String(v ?? 0).replace(/\./g,'').replace(',','.')) || 0;
const cfg = $('Config').first().json;
let saldo = num(cfg.saldo_actual);
const colchon = num(cfg.colchon_minimo) || 0;
const hoy = new Date(); hoy.setHours(0,0,0,0);
const dias = 60;
// Construimos el mapa de movimientos previstos por día
const mov = {};
const add = (fecha, imp, concepto) => {
  const k = fecha.toISOString().slice(0,10);
  (mov[k] = mov[k] || []).push({ imp, concepto });
};
for (const it of $('Facturas').all()) {
  const f = it.json;
  if (String(f.estado || '').toLowerCase() !== 'pendiente' || !f.fecha_vencimiento) continue;
  let d = new Date(f.fecha_vencimiento + 'T00:00:00');
  if (d < hoy) d = new Date(hoy.getTime() + 7 * 86400000); // vencida: la esperamos en 7 días
  add(d, num(f.importe), `cobro ${f.cliente}`);
}
for (const it of $('Puntuales').all()) {
  const p = it.json;
  if (!p.fecha) continue;
  add(new Date(p.fecha + 'T00:00:00'), num(p.importe), p.concepto);
}
for (let i = 0; i <= dias; i++) {
  const d = new Date(hoy.getTime() + i * 86400000);
  for (const it of $('Fijos').all()) {
    const g = it.json;
    if (Number(g.dia_mes) !== d.getDate()) continue;
    const signo = String(g.tipo).toLowerCase() === 'ingreso' ? 1 : -1;
    add(d, signo * Math.abs(num(g.importe)), g.concepto);
  }
}
const filas = [];
let minSaldo = saldo, minFecha = hoy.toISOString().slice(0,10), primerRojo = null;
for (let i = 0; i <= dias; i++) {
  const d = new Date(hoy.getTime() + i * 86400000);
  const k = d.toISOString().slice(0,10);
  const hoyMov = mov[k] || [];
  const neto = hoyMov.reduce((a,m) => a + m.imp, 0);
  saldo += neto;
  if (saldo < minSaldo) { minSaldo = saldo; minFecha = k; }
  if (saldo < colchon && !primerRojo) primerRojo = { fecha: k, saldo, detalle: hoyMov.map(m => m.concepto).join(', ') };
  filas.push({ json: { fecha: k, entradas: hoyMov.filter(m => m.imp > 0).reduce((a,m)=>a+m.imp,0).toFixed(2),
    salidas: hoyMov.filter(m => m.imp < 0).reduce((a,m)=>a+Math.abs(m.imp),0).toFixed(2), saldo: saldo.toFixed(2) } });
}
const e = v => v.toFixed(2).replace('.', ',') + ' €';
const mensaje = primerRojo
  ? `<b>⚠️ Aviso de tesorería</b>\nEl ${primerRojo.fecha} tu saldo previsto baja a ${e(primerRojo.saldo)}, por debajo de tu colchón de ${e(colchon)}.\nEse día pagas: ${primerRojo.detalle || 'gastos fijos'}.\n\nSaldo mínimo en 60 días: ${e(minSaldo)} el ${minFecha}.\n\nOpciones: adelantar el cobro de una factura grande, aplazar un pago no crítico o preparar la póliza.`
  : `<b>Tesorería a 60 días: OK</b>\nSaldo mínimo previsto: ${e(minSaldo)} el ${minFecha}.\nColchón: ${e(colchon)}. Margen: ${e(minSaldo - colchon)}.`;
filas[0].json.riesgo = !!primerRojo;
filas[0].json.mensaje = mensaje;
return filas;
```

## Cómo probarla
- Rellena las hojas con datos reales de este mes y compara la previsión de los próximos 7 días con lo que tú ya sabes que va a pasar. Si no cuadra, casi siempre falta un gasto fijo en la hoja `Fijos`.
- Baja el `colchon_minimo` a un número absurdamente alto (por ejemplo 999999) para forzar la alerta y comprobar que el mensaje llega bien formateado.
- Al mes siguiente compara la previsión guardada en la hoja `Prevision` con el saldo real. Ajusta la regla de facturas vencidas (los 7 días) a lo que de verdad tarden en pagarte.

## Qué puede salir mal
- **Optimismo con los cobros**: si asumes que todos te pagan al vencimiento, la previsión miente. Añade un factor de retraso: multiplica la fecha de cobro por tu retraso medio real (si te pagan 12 días tarde de media, súmale 12 días a cada vencimiento).
- **Fines de semana y festivos**: un pago del día 1 que cae en sábado se ejecuta el lunes. Para la previsión no importa mucho, pero explica pequeños desfases.
- **IVA y otros impuestos**: son el mayor agujero sorpresa. Mételos como pagos puntuales en cuanto sepas la cifra (usa la receta del aviso de IVA para tenerla con dos semanas de margen).
- **Saldo desactualizado**: si el `saldo_actual` es del mes pasado, todo lo demás sobra. Automatízalo con la receta de open banking o ponte un recordatorio de 30 segundos cada lunes.
- **Cuentas múltiples**: si tienes dos bancos, suma los saldos en `saldo_actual` o duplica el flujo por cuenta.

## Cuánto cuesta
- 0 €. Cuatro lecturas de Sheets y un mensaje de Telegram a la semana.
- Cabe en el plan gratuito de Make (unas 30 operaciones al mes).
- Software de tesorería tipo Agicap o Sage Previsión cuesta desde 60-150 €/mes. Esta receta cubre lo esencial para un negocio de menos de 10 personas.
