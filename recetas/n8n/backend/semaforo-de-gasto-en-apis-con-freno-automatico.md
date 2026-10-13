# Semáforo de gasto en APIs con freno automático…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Suma cada seis horas lo que llevas gastado en tus APIs de pago, lo compara con el presupuesto del mes y te avisa al 80 % o corta el grifo al 100 %.

## Qué es y qué hace

Cada seis horas suma el consumo de tus APIs de pago, lo compara con el presupuesto del mes prorrateado por día y actúa: avisa por Telegram al 80 % y, al 100 %, activa un interruptor de emergencia. Entrada: endpoints de consumo y presupuesto en una hoja; salida: avisos y freno. Se monta en n8n con las claves de administración de cada proveedor.

## Cómo usarla

1. Crea las claves de administración por proveedor
2. Rellena el presupuesto mensual
3. Prueba el freno con un límite bajo
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando pagas por uso (IA, SMS, mapas, envíos) y temes una factura sorpresa por un bucle mal hecho o un abuso desde fuera.

## Cómo ganar dinero con ella

Corta facturas desbocadas de cientos o miles de euros. El aviso al 80 % te da tiempo a reaccionar antes de que duela.

- Control de gasto con freno para startups que usan APIs de IA por uso.
- Vigilancia de presupuestos de SMS y mapas para negocios con envíos masivos.
- Guardia de costes para agencias que revenden servicios de API a sus clientes.

**Precio orientativo:** 100–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Consulta los endpoints de consumo de tus proveedores de pago por uso, suma el gasto del mes, lo compara con el presupuesto que hayas puesto (prorrateado por día para detectar picos raros) y actúa: aviso por Telegram al 80 %, aviso urgente y activación de un interruptor de emergencia al 100 %. Para cualquiera con costes variables de API.
**Lo que necesitas antes**
- n8n (auto-alojado o Cloud).
- Hoja `presupuesto_apis` con columnas: `servicio`, `url_consumo`, `presupuesto_mes_eur`, `gasto_actual`, `porcentaje`, `avisado_80`, `avisado_100`.
- Los endpoints de consumo de cada proveedor. Ejemplos: OpenAI `https://api.openai.com/v1/organization/costs?start_time=...` (necesita una Admin key desde platform.openai.com > Settings > Admin keys); Twilio `https://api.twilio.com/2010-04-01/Accounts/{SID}/Usage/Records/ThisMonth.json`; Stripe no cobra por uso pero sirve para vigilar volumen. Si tu proveedor no tiene endpoint, apunta el gasto a mano en la hoja.
- Un bot de Telegram: habla con `@BotFather`, `/newbot`, guarda el token; escribe a tu bot y saca tu chat id en `https://api.telegram.org/bot<TOKEN>/getUpdates`.
- Una hoja `interruptores` con `nombre` y `activo` (esta es tu llave de emergencia: tu app la lee antes de hacer llamadas caras, o la lee otro flujo de n8n).
**Los nodos, en orden**
1. `Schedule Trigger` — Trigger Interval `Hours`, Hours Between Triggers `6`.
2. `Google Sheets` — `Get Row(s)` de `presupuesto_apis`.
3. `HTTP Request` — Method GET, URL `={{ $json.url_consumo }}`, con Header Auth por servicio, `Continue On Fail` ON, Timeout 20000.
4. `Code` (*Normalizar gasto*) — Mode `Run Once for Each Item`. Cada API devuelve el gasto en un sitio distinto; aquí lo unificas:
```js
const fila = $('Google Sheets').item.json;
const r = $json;
let gasto = 0;
if (fila.servicio === 'openai') { gasto = (r.data || []).reduce((a, b) => a + (b.results || []).reduce((x, y) => x + (y.amount?.value || 0), 0), 0); }
else if (fila.servicio === 'twilio') { gasto = Number(r.usage_records?.[0]?.price || 0) * -1; }
else { gasto = Number(r.total || 0); }
const dias = new Date(new Date().getFullYear(), new Date().getMonth() + 1, 0).getDate();
const hoy = new Date().getUTCDate();
const esperado = Number(fila.presupuesto_mes_eur) * (hoy / dias);
const pct = Math.round((gasto / Number(fila.presupuesto_mes_eur)) * 100);
return { json: { servicio: fila.servicio, gasto: Number(gasto.toFixed(2)), presupuesto: Number(fila.presupuesto_mes_eur), porcentaje: pct, ritmo_desbocado: gasto > esperado * 1.5, avisado_80: fila.avisado_80, avisado_100: fila.avisado_100 } };
```
5. `Google Sheets` — `Update`, match on `servicio`, guarda `gasto_actual` y `porcentaje`.
6. `Switch` — Mode `Rules`, sobre `={{ $json.porcentaje }}`: salida 0 si `larger or equal` 100, salida 1 si `larger or equal` 80, salida 2 (fallback) el resto. Añade una cuarta condición sobre `={{ $json.ritmo_desbocado }}` si quieres avisar de picos aunque no llegues al 80 %.
7. Salida 0 (100 %) > `Google Sheets` — `Append or Update` en `interruptores`: `nombre` = `={{ 'freno_' + $json.servicio }}`, `activo` = `si`. Detrás, `Telegram` — Operation `Send Message`, Chat ID el tuyo, Text `🔴 FRENO ACTIVADO en {{ $json.servicio }}: {{ $json.gasto }} € de {{ $json.presupuesto }} €`.
8. Salida 1 (80 %) > `IF` `={{ $json.avisado_80 }}` `is not equal to` `si` > `Telegram` con `🟠 {{ $json.servicio }} al {{ $json.porcentaje }} % del presupuesto` y detrás un `Google Sheets` que marque `avisado_80` = `si` (así no te machaca cada 6 horas).
9. Un `Schedule Trigger` aparte, el día 1 de cada mes (Cron `0 4 1 * *`), que ponga a `no` las columnas `avisado_80` y `avisado_100` y a `no` los interruptores.
**Cómo probarla**
- Pon un presupuesto ridículo (0,01 €) en una fila y ejecuta: debe saltar el freno y llegarte el mensaje de Telegram.
- Comprueba que la hoja `interruptores` cambia a `si` y que tu app o tu otro flujo respeta ese valor (esto es lo importante: el freno solo sirve si algo lo lee).
- Vuelve a ejecutar con el aviso ya marcado: no debe repetirse el mensaje.
**Qué puede salir mal**
- *El endpoint de consumo va con retraso*: OpenAI y otros actualizan con horas de desfase. No confíes en el freno para cortar un bucle infinito en caliente; para eso pon límites duros (hard limits) en el propio panel del proveedor. Este flujo es la segunda línea de defensa.
- *Cambio de moneda*: si el proveedor factura en dólares, mete un `HTTP Request` a `https://api.frankfurter.app/latest?from=USD&to=EUR` (gratis, sin clave) y multiplica.
- *Silencio por fallo*: si la API de consumo falla, no te enteras de nada. Añade un `IF` que te avise si `$json.error` existe dos veces seguidas.
- *Fin de mes*: el prorrateo usa días UTC; si tu facturación va por ciclo de suscripción y no por mes natural, ajusta la fórmula con la fecha de renovación.
**Cuánto cuesta**
Gratis: 4 ejecuciones al día en n8n auto-alojado, Sheets y Telegram sin coste. En Make serían unas 120-360 operaciones al mes según cuántos servicios vigiles: cabe en el plan gratuito de 1.000.
