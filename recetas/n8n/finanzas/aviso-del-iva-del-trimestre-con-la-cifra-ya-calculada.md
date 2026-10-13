# Aviso del IVA del trimestre con la cifra ya calculada…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Suma el IVA repercutido de tus facturas emitidas y el soportado de tus gastos, calcula lo que sale a pagar y te avisa 15 días antes del plazo del modelo 303.

## Qué es y qué hace

El día 1 de enero, abril, julio y octubre, y de nuevo el día 10 como recordatorio, lee las hojas de facturas emitidas y gastos de Google Sheets, filtra el trimestre cerrado, suma el IVA repercutido y el soportado y calcula la diferencia. Te envía un correo con la cifra, el desglose y la fecha límite del modelo 303. Para régimen general de IVA.

## Cómo usarla

1. Preparar las hojas Facturas y Gastos con las columnas indicadas
2. Credenciales de Google Sheets y Gmail en n8n
3. Probar con un trimestre cerrado
4. Que lo revise un profesional

## Cuándo usarla

Cuando llega el 18 de abril, descubres que te toca pagar 3.400 € de IVA y no los tienes apartados. Vale para cualquier autónomo o SL en régimen general.

## Cómo ganar dinero con ella

Evita recargos de Hacienda del 1% al 15% por presentar tarde y te deja apartar el dinero con tiempo. Un recargo del 5% sobre 3.000 € son 150 € que te ahorras.

- Aviso de IVA trimestral para autónomos y SL que llevan sus facturas en hojas de cálculo.
- Revisión del cálculo de IVA con el gestor antes de presentar el modelo 303.
- Plantilla de calendario fiscal con avisos que la gestoría ofrece a sus clientes pequeños.

**Precio orientativo:** 100–220 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
El día 1 de enero, abril, julio y octubre (y otra vez el día 10 como recordatorio) lee tus dos hojas —facturas emitidas y gastos— filtra las del trimestre que acaba de cerrar, suma el IVA repercutido y el soportado, calcula la diferencia y te manda un email con la cifra, el desglose y la fecha límite de presentación del modelo 303.
Para autónomos y pymes en régimen general de IVA que llevan sus facturas en una hoja de cálculo.

## Lo que necesitas antes
- Hoja `Facturas` (la de emitidas) con columnas: `numero`, `fecha_emision`, `base`, `iva`, `total`, `estado`.
- Hoja `Gastos` (la de recibidas) con: `fecha`, `proveedor`, `base`, `iva`, `total`, `deducible`. En `deducible` pon `si` o `no` (el café con un cliente no lo es; el material de oficina sí).
- Ambas pueden estar en el mismo documento de Google Sheets, en pestañas distintas.
- Credenciales **Google Sheets OAuth2** y **Gmail OAuth2** en n8n.

## Los nodos, en orden
1. **Schedule Trigger** — Mode: `Custom (Cron)`, Expression: `0 8 1,10 1,4,7,10 *` (a las 8:00 de los días 1 y 10 de enero, abril, julio y octubre). Timezone del workflow: `Europe/Madrid`.
2. **Google Sheets** («Emitidas») — Operation: `Get Row(s)`, Document: tu documento, Sheet: `Facturas`.
3. **Google Sheets** («Gastos») — Operation: `Get Row(s)`, Sheet: `Gastos`. Conéctalo también desde el Schedule Trigger para que se ejecuten en paralelo.
4. **Merge** — Mode: `Append`, Number of Inputs: `2`. Entrada 1 desde «Emitidas», entrada 2 desde «Gastos». (No mezclamos campos, solo juntamos para procesarlos de una vez; el Code distingue por qué nodo vinieron.)
5. **Code** («Calcular IVA») — Mode: `Run Once for All Items`. En vez de usar el Merge, el código lee directamente de cada nodo por su nombre, así que puedes prescindir del Merge y conectar el Code después de «Gastos». Código abajo.
6. **IF** («¿Sale a pagar?») — Condition `Number`, izquierda `{{ $json.a_pagar }}`, operación `larger`, derecha `0`. Solo para cambiar el asunto del correo; puedes usar un nodo **Switch** si quieres tres mensajes (a pagar, a compensar, a cero).
7. **Gmail** («Aviso IVA») — To: tu email. Subject: `{{ $json.asunto }}`. Message: `{{ $json.cuerpo }}`. Email Type: `Text`.
8. Opcional: **Google Sheets** («Histórico IVA») — Operation: `Append Row` en una pestaña `IVA_trimestres` con `trimestre`, `repercutido`, `soportado`, `a_pagar`. Así ves la evolución año a año.

## El código del nodo Code
```javascript
const hoy = new Date();
let anio = hoy.getFullYear();
let tri = Math.ceil((hoy.getMonth() + 1) / 3) - 1;
if (tri === 0) { tri = 4; anio -= 1; }
const desde = new Date(anio, (tri - 1) * 3, 1);
const hasta = new Date(anio, tri * 3, 0, 23, 59, 59);
const num = v => Number(String(v ?? 0).replace(/\./g,'').replace(',','.')) || 0;
const enRango = f => { const d = new Date(String(f) + 'T00:00:00'); return d >= desde && d <= hasta; };
let rep = 0, baseRep = 0, sop = 0, baseSop = 0, nEm = 0, nGa = 0;
for (const it of $('Emitidas').all()) {
  const f = it.json;
  if (!f.fecha_emision || !enRango(f.fecha_emision)) continue;
  rep += num(f.iva); baseRep += num(f.base); nEm++;
}
for (const it of $('Gastos').all()) {
  const g = it.json;
  if (!g.fecha || !enRango(g.fecha)) continue;
  if (String(g.deducible).toLowerCase() === 'no') continue;
  sop += num(g.iva); baseSop += num(g.base); nGa++;
}
const aPagar = +(rep - sop).toFixed(2);
const limites = { 1: `20 de abril de ${anio}`, 2: `20 de julio de ${anio}`, 3: `20 de octubre de ${anio}`, 4: `30 de enero de ${anio + 1}` };
const e = v => v.toFixed(2).replace('.', ',') + ' €';
const cuerpo = [
  `Cierre del ${tri}T de ${anio} (del ${desde.toISOString().slice(0,10)} al ${hasta.toISOString().slice(0,10)})`,
  '',
  `IVA repercutido (ventas): ${e(rep)} sobre base ${e(baseRep)} — ${nEm} facturas`,
  `IVA soportado (gastos deducibles): ${e(sop)} sobre base ${e(baseSop)} — ${nGa} facturas`,
  '',
  aPagar >= 0 ? `A INGRESAR en el modelo 303: ${e(aPagar)}` : `A COMPENSAR en el próximo trimestre: ${e(Math.abs(aPagar))}`,
  '',
  `Fecha límite de presentación: ${limites[tri]}`,
  aPagar > 0 ? `Aparta ${e(aPagar)} en la cuenta de impuestos hoy mismo.` : '',
  '',
  'Recuerda: esto es una estimación a partir de tus hojas. La declaración la revisa y presenta tu asesor.'
].join('\n');
return [{ json: { trimestre: `${anio}-T${tri}`, repercutido: +rep.toFixed(2), soportado: +sop.toFixed(2), a_pagar: aPagar,
  asunto: aPagar >= 0 ? `IVA ${tri}T ${anio}: a pagar ${e(aPagar)}` : `IVA ${tri}T ${anio}: a compensar ${e(Math.abs(aPagar))}`, cuerpo } }];
```

## Cómo probarla
- Rellena las dos hojas con los datos de un trimestre que ya presentaste y compara la cifra que da el flujo con la del 303 real. Si no cuadra, la diferencia casi siempre está en gastos marcados como deducibles que no lo eran, o en facturas con IVA distinto del 21%.
- Para probar sin esperar a enero, cambia temporalmente el cron a `*/5 * * * *` (cada 5 minutos) y luego devuélvelo a su valor.
- Comprueba que el trimestre que calcula es el ANTERIOR al mes en curso: ejecutándolo el 1 de abril debe decir «1T».

## Qué puede salir mal
- **Facturas fuera de plazo**: una factura de gasto de marzo que te llega en mayo ya no entra en ese trimestre. El flujo la ignorará; consúltalo con tu asesor, se puede deducir en trimestres siguientes dentro del plazo legal.
- **Recargo de equivalencia, criterio de caja, inversión del sujeto pasivo, intracomunitarias**: este cálculo NO los contempla. Si estás en alguno de esos regímenes, úsalo solo como orientación.
- **Fechas mal escritas**: cualquier fecha que no esté en `AAAA-MM-DD` se descarta silenciosamente. Añade al final del código un contador de filas descartadas si te preocupa.
- **Zona horaria**: con el timezone mal puesto, un flujo programado a las 8:00 del día 1 puede dispararse el día 31 anterior y calcular el trimestre equivocado. Fíjalo en Settings del workflow.

## Cuánto cuesta
- 0 €. Google Sheets, Gmail y n8n auto-alojado son gratis y el flujo se ejecuta 8 veces al año.
- En Make cabe de sobra en el plan gratuito. En Zapier necesitarías Code by Zapier, disponible desde el plan Professional (unos 20 €/mes), así que aquí n8n o Make ganan claramente.
