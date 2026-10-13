# Guardia de la factura del cloud: alerta antes del susto…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Consulta a diario el gasto acumulado de tus proveedores (AWS, Google Cloud, OpenAI, Twilio, Vercel), lo compara con lo previsto para ese día del mes y te avisa si te estás pasando.

## Qué es y qué hace

A las 7:30 consulta el gasto acumulado del mes en cada proveedor de pago por uso (AWS, Google Cloud, OpenAI, Twilio, Vercel), compara con el ritmo previsto y avisa si vas a superar el presupuesto. Además detecta saltos bruscos frente a la media de los siete días anteriores. Entrada: claves de solo lectura de facturación; salida: avisos y hoja de gasto. Se monta en n8n.

## Cómo usarla

1. Crea claves de solo lectura por proveedor
2. Carga el presupuesto mensual
3. Activa el aviso de saltos bruscos
4. Que lo revise un profesional

## Cuándo usarla

Cuando pagues por uso en cualquier servicio (nube, APIs de IA, SMS, envío de correos) y no tengas ni idea de cuánto llevas gastado hasta que llega el cargo a final de mes.

## Cómo ganar dinero con ella

Detecta bucles infinitos, procesos duplicados o abusos el mismo día en vez de a los 30, lo que en la práctica evita facturas sorpresa de cientos o miles de euros.

- Control de costes cloud para startups que pagan por uso y temen facturas sorpresa.
- Guardia de gastos de IA para agencias que revenden APIs a sus clientes.
- Informe mensual de gasto en servicios para pymes con varios proveedores.

**Precio orientativo:** 60–250 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada mañana a las 7:30 pregunta a cada proveedor cuánto llevas gastado en el mes en curso, lo apunta en una hoja y calcula el ritmo diario: si al ritmo actual vas a cerrar el mes por encima de tu presupuesto, te avisa.
Además detecta saltos bruscos: si el gasto de ayer fue más del triple de la media de los 7 días anteriores, te manda un aviso urgente aunque el total del mes aún vaya bien.

## Lo que necesitas antes
- n8n (Cloud o auto-alojado).
- Claves de lectura de facturación de cada proveedor que uses:
  - **OpenAI / Anthropic**: una API key de la organización; el endpoint de uso es de solo lectura.
  - **AWS**: usuario IAM con la política `AWSBudgetsReadOnlyAccess` y permiso `ce:GetCostAndUsage`. Access Key y Secret.
  - **Google Cloud**: exporta la facturación a BigQuery (gratis) y consulta ahí, o usa la API de Cloud Billing.
  - **Vercel, Twilio, Brevo, Cloudflare**: casi todos tienen un endpoint de uso en su API; busca "usage" en su documentación.
- Hoja de Google Sheets "Gasto cloud" con pestañas `diario` (fecha, proveedor, acumulado_mes, gasto_dia) y `presupuestos` (proveedor, limite_mes).
- Bot de Telegram y chat ID.

## Los nodos, en orden
1. **Schedule Trigger** — Cron: `30 7 * * *`, Timezone Europe/Madrid.
2. **Google Sheets** (nombre: Presupuestos) — Get Row(s) de la pestaña presupuestos, Return All.
3. **Switch** — sobre `={{ $json.proveedor }}`, una salida por proveedor.
4. **HTTP Request** (rama OpenAI) — GET `=https://api.openai.com/v1/organization/costs?start_time={{ $now.startOf('month').toSeconds() }}&limit=31`, Authentication: Generic, Header Auth con `Authorization: Bearer TU_KEY`.
5. **HTTP Request** (rama AWS) — Method: POST a `https://ce.us-east-1.amazonaws.com/`, Authentication: Predefined Credential Type, AWS. Header `X-Amz-Target: AWSInsightsIndexService.GetCostAndUsage`, Body JSON con TimePeriod del mes y Granularity MONTHLY, Metrics `["UnblendedCost"]`.
6. **Code** (nombre: Normalizar gasto) — deja todo igual: proveedor, acumulado en euros, gasto de ayer.
7. **Merge** — Mode: Append, tantas entradas como proveedores.
8. **Google Sheets** (nombre: Histórico) — Append or Update Row en `diario`, columnas clave: fecha y proveedor.
9. **Google Sheets** (nombre: Últimos 8 días) — Get Row(s) filtrando por proveedor, para calcular la media.
10. **Code** (nombre: Analizar) — calcula proyección de fin de mes y detecta el pico. Código abajo.
11. **IF** — `={{ $json.alertar }}` is true.
12. **Telegram** — mensaje con el desglose.

## El código del nodo "Normalizar gasto"
```javascript
const salida = [];
for (const it of $input.all()) {
  const j = it.json;
  let proveedor = j.proveedor || 'desconocido', acumulado = 0;
  if (j.data && Array.isArray(j.data)) { // OpenAI
    proveedor = 'openai';
    acumulado = j.data.reduce((s, b) => s + (b.results || []).reduce((x, r) => x + (r.amount?.value || 0), 0), 0);
  } else if (j.ResultsByTime) { // AWS
    proveedor = 'aws';
    acumulado = Number(j.ResultsByTime[0]?.Total?.UnblendedCost?.Amount || 0);
  }
  salida.push({ json: { fecha: new Date().toISOString().slice(0,10), proveedor, acumulado_mes: Math.round(acumulado * 100) / 100 } });
}
return salida;
```

## El código del nodo "Analizar"
```javascript
const hoy = new Date();
const diaMes = hoy.getDate();
const diasMes = new Date(hoy.getFullYear(), hoy.getMonth() + 1, 0).getDate();
const presu = $('Presupuestos').all().map(i => i.json);
const hist = $('Últimos 8 días').all().map(i => i.json);
const avisos = [];
for (const it of $input.all()) {
  const j = it.json;
  const limite = Number((presu.find(p => p.proveedor === j.proveedor) || {}).limite_mes || 0);
  const proyeccion = diaMes > 0 ? (j.acumulado_mes / diaMes) * diasMes : 0;
  const previos = hist.filter(h => h.proveedor === j.proveedor).slice(-8).map(h => Number(h.gasto_dia || 0));
  const media = previos.length ? previos.reduce((a,b)=>a+b,0) / previos.length : 0;
  const ayer = previos.length ? previos[previos.length - 1] : 0;
  if (limite && proyeccion > limite) avisos.push('📈 ' + j.proveedor + ': llevas ' + j.acumulado_mes + '€, proyección ' + proyeccion.toFixed(2) + '€ sobre un límite de ' + limite + '€');
  if (media > 0.5 && ayer > media * 3) avisos.push('🚨 ' + j.proveedor + ': ayer ' + ayer.toFixed(2) + '€ frente a una media de ' + media.toFixed(2) + '€');
}
return [{ json: { alertar: avisos.length > 0, mensaje: avisos.join('\n') } }];
```

## Cómo probarla
- Pon a mano en la pestaña presupuestos un límite ridículo (por ejemplo 1 euro) para un proveedor y ejecuta: debe llegarte el Telegram de proyección.
- Mete a mano una fila en `diario` con un gasto_dia enorme de ayer: debe saltar el aviso de pico.
- Comprueba que los importes cuadran con lo que ves en el panel de facturación del proveedor (ojo: algunos devuelven dólares; conviértelos o asume la diferencia).

## Qué puede salir mal
- **Los datos de facturación van con retraso**: AWS tarda hasta 24 horas en consolidar. No te alarmes por un día raro; el flujo mira medias precisamente por eso.
- **Dólares y euros mezclados**: si mezclas proveedores, añade una conversión con un HTTP Request a `https://api.frankfurter.app/latest?from=USD&to=EUR` (gratis, sin clave).
- **Claves de facturación con demasiados permisos**: crea usuarios de solo lectura. Una clave de AWS con permisos de más filtrada es exactamente el desastre que intentas evitar.
- **Meses cortos**: la proyección con 31 días en febrero te da sustos falsos; el código ya calcula los días reales del mes.
- **Falsos picos el día 1**: con un solo día de datos la proyección es un disparate. Añade `if (diaMes < 3) return [{json:{alertar:false}}];` si te molesta.

## Cuánto cuesta
- Gratis: todos los endpoints de facturación son de lectura y no se cobran (la consulta de Cost Explorer de AWS cuesta 0,01 dólares por petición: 0,30 dólares al mes).
- n8n, Sheets y Telegram: gratis.
