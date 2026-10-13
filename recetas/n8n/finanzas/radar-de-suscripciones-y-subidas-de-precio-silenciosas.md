# Radar de suscripciones y subidas de precio silenciosas…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Analiza tus movimientos bancarios, detecta los cargos que se repiten cada mes, calcula lo que te cuestan al año y te avisa cuando uno sube de precio o aparece uno nuevo.

## Qué es y qué hace

Una vez al mes lee tus movimientos bancarios de los últimos 12 meses desde Google Sheets, agrupa los cargos por comercio, identifica los que se repiten mensual o anualmente, calcula su coste anual y detecta subidas comparando el último cargo con el anterior. Te manda por Gmail un informe ordenado de mayor a menor gasto anual.

## Cómo usarla

1. Preparar la hoja Movimientos con fecha, concepto e importe
2. Credenciales de Google Sheets y Gmail en n8n
3. Ejecutar una primera vez con el histórico
4. Que lo revise un profesional

## Cuándo usarla

Cuando sospechas que pagas herramientas que ya no usas y no tienes ni idea de cuánto se te va en cuotas. Ideal para negocios con muchas apps y servicios contratados.

## Cómo ganar dinero con ella

Detecta de golpe 40-150 €/mes en suscripciones zombis y subidas del 10-20% que pasan desapercibidas. Solo cancelar dos herramientas ya paga el trabajo de montarlo.

- Auditoría de suscripciones para pymes con software y servicios recurrentes sin control.
- Revisión anual de cuotas y software para negocios con muchas herramientas contratadas.
- Informe de gasto recurrente que el consultor entrega como parte de un servicio de control de costes.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Una vez al mes lee todos tus movimientos bancarios de los últimos 12 meses, agrupa los cargos por comercio normalizado, identifica los que se repiten con periodicidad mensual o anual, calcula el coste anualizado de cada uno, detecta subidas de precio comparando el último cargo con el anterior, y te manda un informe ordenado de mayor a menor gasto anual.
Para cualquier negocio pequeño que acumula software, seguros, cuotas y servicios recurrentes sin control.

## Lo que necesitas antes
- Una hoja `Movimientos` con al menos `fecha`, `concepto`, `importe` (negativos los gastos). La puedes llenar con la receta de open banking, exportando el CSV del banco, o descargando el extracto de tu tarjeta.
- Idealmente 12 meses de histórico; con 4 meses ya detecta lo mensual, pero no lo anual.
- Credenciales **Google Sheets OAuth2** y **Gmail OAuth2** en n8n.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: `Months`, Trigger at Day of Month: `1`, Hour: `9`. Timezone `Europe/Madrid`.
2. **Google Sheets** («Movimientos») — Operation: `Get Row(s)`, Sheet: `Movimientos`.
3. **Code** («Detectar recurrentes») — Mode: `Run Once for All Items`. Código abajo. Devuelve un item por suscripción detectada más un item `informe`.
4. **Google Sheets** («Guardar catálogo») — Operation: `Append or Update Row`, Sheet: `Suscripciones`, Matching Columns: `comercio`. Columnas: `comercio`, `importe_actual`, `periodicidad`, `coste_anual`, `ultimo_cargo`, `variacion`, `estado`. Deja `estado` para escribir tú `activa`, `a cancelar` o `cancelada`.
5. **IF** («¿Hay novedades?») — Condition `Number`, izquierda `{{ $json.novedades }}`, operación `larger`, derecha `0`. Solo la rama true manda correo, para no recibir un email cuando no cambia nada.
6. **Gmail** («Informe») — To: tu email. Subject: `Suscripciones: {{ $json.total_anual }} €/año`. Message: `{{ $json.texto }}`.

## El código del nodo Code
```javascript
const num = v => Number(String(v ?? 0).replace(/\./g,'').replace(',','.')) || 0;
const clave = s => String(s || '').toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g,'')
  .replace(/\d{4,}/g, '').replace(/(pago|compra|tarj|recibo|cargo|domicil|www|com|es|sl|sa|ltd|inc)/g,'')
  .replace(/[^a-z ]/g,'').trim().split(/\s+/).slice(0,2).join(' ');
const grupos = {};
for (const it of $input.all()) {
  const m = it.json;
  const imp = num(m.importe);
  if (imp >= 0) continue;
  const k = clave(m.concepto);
  if (k.length < 3) continue;
  (grupos[k] = grupos[k] || []).push({ fecha: m.fecha, imp: Math.abs(imp), concepto: m.concepto });
}
const subs = [];
for (const [k, cargos] of Object.entries(grupos)) {
  if (cargos.length < 3) continue;
  cargos.sort((a,b) => new Date(a.fecha) - new Date(b.fecha));
  const gaps = [];
  for (let i = 1; i < cargos.length; i++) gaps.push((new Date(cargos[i].fecha) - new Date(cargos[i-1].fecha)) / 86400000);
  const medio = gaps.reduce((a,b) => a+b, 0) / gaps.length;
  let periodicidad = null, veces = 0;
  if (medio >= 25 && medio <= 35) { periodicidad = 'mensual'; veces = 12; }
  else if (medio >= 84 && medio <= 96) { periodicidad = 'trimestral'; veces = 4; }
  else if (medio >= 350 && medio <= 380) { periodicidad = 'anual'; veces = 1; }
  if (!periodicidad) continue;
  const ult = cargos[cargos.length - 1];
  const prev = cargos[cargos.length - 2];
  const variacion = prev.imp ? +(((ult.imp - prev.imp) / prev.imp) * 100).toFixed(1) : 0;
  subs.push({ comercio: k, concepto: ult.concepto, importe_actual: ult.imp, periodicidad,
    coste_anual: +(ult.imp * veces).toFixed(2), ultimo_cargo: ult.fecha, variacion, cargos: cargos.length });
}
subs.sort((a,b) => b.coste_anual - a.coste_anual);
const total = subs.reduce((a,s) => a + s.coste_anual, 0);
const subidas = subs.filter(s => s.variacion > 3);
const nuevas = subs.filter(s => s.cargos === 3);
const lineas = subs.map(s => `${s.comercio.padEnd(18)} ${s.importe_actual.toFixed(2)} €/${s.periodicidad === 'mensual' ? 'mes' : s.periodicidad} → ${s.coste_anual.toFixed(2)} €/año${s.variacion > 3 ? `  ⬆ +${s.variacion}%` : ''}`);
const texto = [
  `Gasto recurrente detectado: ${total.toFixed(2)} € al año (${(total/12).toFixed(2)} €/mes)`, '',
  'DETALLE (de mayor a menor):', ...lineas, '',
  subidas.length ? `SUBIDAS DE PRECIO:\n${subidas.map(s => `• ${s.comercio}: de ${(s.importe_actual/(1+s.variacion/100)).toFixed(2)} a ${s.importe_actual.toFixed(2)} € (+${s.variacion}%)`).join('\n')}` : 'Sin subidas de precio este mes.', '',
  nuevas.length ? `NUEVAS:\n${nuevas.map(s => `• ${s.comercio}: ${s.importe_actual.toFixed(2)} €`).join('\n')}` : '', '',
  'Repasa la lista y marca en la hoja Suscripciones las que ya no uses.'
].filter(Boolean).join('\n');
const items = subs.map(s => ({ json: s }));
items.push({ json: { tipo: 'informe', texto, total_anual: total.toFixed(2), novedades: subidas.length + nuevas.length } });
return items;
```

## Cómo probarla
- Ejecuta el Code y compara la lista con lo que ya sabes que pagas. Si falta algo, casi siempre es porque el banco escribe el concepto distinto cada mes (con número de operación variable): amplía la limpieza de la función `clave`.
- Prueba bajando `cargos.length < 3` a `< 2` para ver qué más aparece, y súbelo otra vez si salen falsos positivos.
- Comprueba que un gasto variable como el supermercado NO aparece: si sale, es que sus fechas caen casualmente cada 30 días; añade una comprobación de que los importes sean similares (por ejemplo, descartar si la desviación entre cargos supera el 25%).

## Qué puede salir mal
- **Conceptos cambiantes**: PayPal y algunas pasarelas ponen «PAYPAL *NOMBRE» con variaciones. Añade reglas de limpieza específicas al array de reemplazos.
- **Suscripciones anuales**: necesitas 3 años de datos para detectarlas con la regla de 3 cargos. Baja el mínimo a 2 cargos solo para el caso anual si te interesa.
- **Falsos positivos**: alquiler, nóminas y cuota de autónomos aparecerán como «suscripción». No es un fallo: es gasto fijo, y verlo anualizado también es útil. Márcalos como `fijo` en la columna `estado`.
- **Cambio de tarifa a mitad de mes**: se detecta al mes siguiente, no en el momento. Es un informe mensual, no una alarma en tiempo real.

## Cuánto cuesta
- 0 €. Una ejecución al mes con nodos gratuitos.
- Cabe sin problema en el plan gratuito de Make (unas 4 operaciones al mes). En Zapier necesitas Code, disponible solo en planes de pago.
- Herramientas comerciales de control de suscripciones para empresas cobran 10-25 €/mes; esta receta hace lo mismo para el 90% de los casos.
