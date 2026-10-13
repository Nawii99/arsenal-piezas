# Alerta de gasto disparado por categoría respecto a tu m…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Compara cada semana lo que llevas gastado por categoría con tu media de los seis meses anteriores y te avisa solo cuando algo se ha disparado de verdad.

## Qué es y qué hace

Cada viernes toma los movimientos bancarios ya categorizados de Google Sheets, calcula el gasto del mes por categoría, lo proyecta a fin de mes y lo compara con la media de los seis meses anteriores. Solo avisa cuando una categoría supera tu umbral, con importe y porcentaje. Si nada se desvía, no envía nada. Requiere al menos cuatro meses de histórico.

## Cómo usarla

1. Preparar la hoja Movimientos con categoría
2. Fijar el umbral de desviación
3. Montar el flujo semanal en n8n con aviso
4. Que lo revise un profesional

## Cuándo usarla

Cuando revisas los gastos una vez al año y descubres tarde que el gasto en combustible, suministros o comisiones bancarias lleva meses subiendo sin motivo.

## Cómo ganar dinero con ella

Cazar una desviación en el mes en que ocurre en vez de al cierre del año. Un 15% de sobrecoste en una categoría de 800 €/mes son 1.440 € al año.

- Control de gasto por categoría para pymes con partidas de combustible, suministros y comisiones.
- Revisión mensual de desviaciones con el gestor para negocios con gasto variable.
- Informe de control de gastos que el consultor vende como servicio de seguimiento mensual.

**Precio orientativo:** 100–250 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada viernes coge tus movimientos bancarios ya categorizados, calcula el gasto del mes en curso por categoría, lo proyecta a fin de mes según los días transcurridos y lo compara con la media de los seis meses anteriores de esa misma categoría. Solo te avisa de las categorías que se desvían más de un umbral que tú fijas, con el importe y el porcentaje. Si nada se desvía, no te manda nada.
Para negocios con varias partidas de gasto que quieren control sin mirar hojas todos los días.

## Lo que necesitas antes
- Hoja `Movimientos` con `fecha`, `concepto`, `importe` (negativo en gastos) y `categoria`. La categoría la puede poner la receta de open banking automáticamente, o la pones tú con un desplegable en Sheets (Datos > Validación de datos).
- Al menos 4 meses de histórico para que la media signifique algo. Con menos, el flujo te avisará de que no hay datos suficientes.
- Un Slack gratuito con una app y el scope `chat:write` (o cambia el último nodo por Telegram o Gmail, es indiferente).
- Credenciales **Google Sheets OAuth2** y **Slack API** en n8n.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: `Weeks`, Trigger on Weekdays: `Friday`, Hour: `17`. Timezone `Europe/Madrid`.
2. **Google Sheets** («Movimientos») — Operation: `Get Row(s)`, Sheet: `Movimientos`.
3. **Code** («Detectar desviaciones») — Mode: `Run Once for All Items`. Código abajo. Ajusta arriba `UMBRAL_PCT` (por defecto 25%) y `UMBRAL_EUR` (por defecto 100 €): tienen que cumplirse los dos para que salte la alerta, así evitas ruido de categorías pequeñas.
4. **IF** («¿Hay alertas?») — Condition `Number`, izquierda `{{ $json.n_alertas }}`, operación `larger`, derecha `0`. Solo la rama true sigue.
5. **Slack** («Alerta gasto») — Send Message To: `Channel`, Channel: `#finanzas`, Message Text: `{{ $json.texto }}`. En Options activa `Include Link to Workflow` si quieres poder saltar a la ejecución.
6. Opcional: **Google Sheets** («Histórico alertas») — Append Row en una pestaña `Alertas` con `fecha`, `categoria`, `real`, `media`, `desvio_pct`. Sirve para ver si una desviación es puntual o crónica.

## El código del nodo Code
```javascript
const UMBRAL_PCT = 25;
const UMBRAL_EUR = 100;
const MESES_BASE = 6;
const num = v => Math.abs(Number(String(v ?? 0).replace(/\./g,'').replace(',','.')) || 0);
const hoy = new Date();
const mesActual = hoy.toISOString().slice(0,7);
const diaHoy = hoy.getDate();
const diasMes = new Date(hoy.getFullYear(), hoy.getMonth() + 1, 0).getDate();
const porMesCat = {};
for (const it of $input.all()) {
  const m = it.json;
  const imp = Number(String(m.importe ?? 0).replace(/\./g,'').replace(',','.')) || 0;
  if (imp >= 0) continue;
  if (!m.fecha) continue;
  const mes = String(m.fecha).slice(0,7);
  const cat = (m.categoria || 'Sin categoría').trim();
  porMesCat[cat] = porMesCat[cat] || {};
  porMesCat[cat][mes] = (porMesCat[cat][mes] || 0) + num(imp);
}
const mesesBase = [];
for (let i = 1; i <= MESES_BASE; i++) {
  const d = new Date(hoy.getFullYear(), hoy.getMonth() - i, 1);
  mesesBase.push(d.toISOString().slice(0,7));
}
const alertas = [], ok = [];
for (const [cat, meses] of Object.entries(porMesCat)) {
  const valores = mesesBase.map(m => meses[m]).filter(v => v !== undefined);
  if (valores.length < 3) continue;
  const media = valores.reduce((a,b) => a+b, 0) / valores.length;
  const real = meses[mesActual] || 0;
  const proyectado = +(real * (diasMes / diaHoy)).toFixed(2);
  const desvio = media ? +(((proyectado - media) / media) * 100).toFixed(1) : 0;
  const dif = +(proyectado - media).toFixed(2);
  const fila = { cat, real: +real.toFixed(2), proyectado, media: +media.toFixed(2), desvio, dif };
  if (desvio >= UMBRAL_PCT && dif >= UMBRAL_EUR) alertas.push(fila);
  else ok.push(fila);
}
alertas.sort((a,b) => b.dif - a.dif);
const e = v => v.toFixed(2).replace('.', ',') + ' €';
const texto = [
  `*Aviso de gasto — ${mesActual} (día ${diaHoy} de ${diasMes})*`, '',
  ...alertas.map(a => `• *${a.cat}*: llevas ${e(a.real)}, proyección a fin de mes ${e(a.proyectado)} frente a una media de ${e(a.media)}. Son ${e(a.dif)} de más (+${a.desvio}%).`),
  '', `Categorías dentro de lo normal: ${ok.length}.`,
  '', '_Proyección lineal: si el gasto está concentrado a principio de mes, exagera. Contrástalo antes de actuar._'
].join('\n');
return [{ json: { n_alertas: alertas.length, texto, alertas } }];
```

## Cómo probarla
- Ejecuta el Code y mira el array `alertas` sin mandar nada a Slack. Si salen 15 alertas, tus umbrales son demasiado bajos: sube `UMBRAL_PCT` a 35 o `UMBRAL_EUR` a 200.
- Prueba a bajar `UMBRAL_EUR` a 1 para ver todas las categorías con su media y comprobar que los cálculos son correctos contra tu hoja.
- Ejecútalo el día 3 de un mes: la proyección multiplicará por 10 y dará números disparatados. Si te molesta, añade al principio del código `if (diaHoy < 7) return [{ json: { n_alertas: 0, texto: '' } }];`.

## Qué puede salir mal
- **Proyección lineal engañosa**: pagos que se concentran (el alquiler el día 1, los seguros en enero) inflan la proyección al principio del mes. La coletilla del mensaje lo advierte; si te da mucho ruido, excluye las categorías de gasto fijo con una lista negra.
- **Categorías mal puestas**: si un mes clasificas algo como «Material» y otro como «Compras», la media es basura. Usa validación de datos en la hoja para que solo se puedan elegir categorías de una lista cerrada.
- **Meses estacionales**: si vendes el triple en diciembre, tus compras suben con razón. Para negocios estacionales, compara contra el mismo mes del año anterior en vez de contra la media de los 6 anteriores (cambia `mesesBase` por el mes equivalente de años previos).
- **Falta de histórico**: el código exige al menos 3 meses con datos por categoría. Antes de eso, la categoría se ignora en silencio.
- **Reintentos**: si el nodo Sheets falla, la ejecución se pierde y no pasa nada grave; la semana siguiente vuelve a mirar lo mismo.

## Cuánto cuesta
- 0 €. Una ejecución semanal, dos nodos gratuitos.
- Encaja en el plan gratuito de Make. En Zapier haría falta Code by Zapier, que está en planes de pago.
- Lo caro aquí no es la herramienta, es tener los movimientos categorizados: por eso conviene combinarlo con la receta de open banking, que ya categoriza automáticamente.
