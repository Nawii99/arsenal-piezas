# Control de gasto de tus APIs de pago con freno automáti…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Suma cada hora lo que llevas gastado en las APIs que pagas por uso, te avisa al 80 por ciento del presupuesto y corta el grifo si se pasa.

## Qué es y qué hace

Flujo de n8n que cada hora consulta el consumo acumulado del mes en tus APIs de pago por uso, lo compara con el presupuesto y envía un aviso al 80 por ciento y otro urgente al 100. Al superarlo activa un interruptor de emergencia en una hoja o variable que tu aplicación lee antes de llamar a esas APIs, para acotar el gasto.

## Cómo usarla

1. Guarda las credenciales de cada proveedor en n8n
2. Define presupuesto mensual y umbrales
3. Haz que tu aplicación lea el interruptor antes de cada llamada
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando uses APIs que cobran por consumo (IA, SMS, mapas, envíos) y te dé pánico que un bucle mal hecho o un abuso te genere una factura de tres cifras en una noche.

## Cómo ganar dinero con ella

Un fallo sin control puede costar cientos de euros en horas; con el freno puesto el daño máximo queda acotado a tu presupuesto diario.

- Control de costes para productos con IA o SMS que cobran por uso…
- Límites de gasto para agencias que usan APIs en nombre de clientes…
- Monitorización de facturas de API para startups con presupuesto ajustado…

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada hora consulta el consumo acumulado del mes en tus proveedores de pago por uso, lo compara con el presupuesto que hayas fijado y actúa: aviso al 80 por ciento, aviso urgente al 100 y activación de un interruptor de emergencia que tu aplicación lee antes de llamar a esas APIs.
Para el desarrollador con un producto propio o un cliente donde el coste variable puede dispararse sin que nadie lo mire hasta la factura.

## Lo que necesitas antes
- n8n, mejor auto-alojado por la frecuencia horaria.
- Las claves de los proveedores que quieras vigilar, guardadas como credenciales en n8n. Muchos exponen su consumo: Twilio en `https://api.twilio.com/2010-04-01/Accounts/{SID}/Usage/Records/ThisMonth.json` con autenticación básica (SID y token del panel de Twilio), y proveedores de IA suelen tener un endpoint de costes o al menos un panel con exportación; si alguno no lo ofrece, calcula el gasto tú mismo registrando cada llamada.
- Una hoja «Presupuestos» con columnas: proveedor, presupuesto_mes, gasto_actual, porcentaje, estado, actualizado.
- Una hoja o pestaña «Interruptor» con una única celda `A2` que contenga `abierto` o `cerrado`. Tu aplicación debe leer esa celda (o mejor, una clave en Redis o en Cloudflare KV) antes de llamar a la API cara; si dice `cerrado`, devuelve una respuesta de cortesía en vez de gastar.

## Los nodos, en orden
1. **Schedule Trigger** — «Interval», cada 1 hora.
2. **HTTP Request** («Twilio») — GET `https://api.twilio.com/2010-04-01/Accounts/{{ $credentials.sid }}/Usage/Records/ThisMonth.json?Category=totalprice`, Authentication: Basic Auth con la credencial de Twilio.
3. **HTTP Request** («Otro proveedor») — el endpoint de costes que corresponda, con su cabecera `Authorization: Bearer ...` mediante credencial «Header Auth» de n8n. Marca «Continue On Fail» en ambos.
4. **Code** («Normalizar gasto») — deja todo en euros y en un mismo formato.
```javascript
const salida = [];
const tw = $('Twilio').first();
if (tw && tw.json && tw.json.usage_records) {
  const total = tw.json.usage_records.reduce((s, r) => s + Number(r.price || 0), 0);
  salida.push({ json: { proveedor: 'twilio', gasto: Math.abs(Math.round(total * 100) / 100) } });
}
const otro = $('Otro proveedor').first();
if (otro && otro.json && otro.json.total_usage !== undefined) {
  salida.push({ json: { proveedor: 'ia', gasto: Math.round(Number(otro.json.total_usage) / 100 * 100) / 100 } });
}
return salida;
```
5. **Google Sheets** («Presupuestos») — Get Row(s) para leer el límite de cada proveedor.
6. **Code** («Decidir») — cruza gasto y presupuesto.
```javascript
const limites = {};
for (const item of $('Presupuestos').all()) limites[item.json.proveedor] = { max: Number(String(item.json.presupuesto_mes).replace(',', '.')), fila: item.json.row_number };
const salida = [];
for (const item of $input.all()) {
  const p = item.json.proveedor;
  const l = limites[p];
  if (!l) continue;
  const pct = Math.round((item.json.gasto / l.max) * 100);
  let estado = 'ok';
  if (pct >= 80) estado = 'aviso';
  if (pct >= 100) estado = 'cortar';
  salida.push({ json: { proveedor: p, gasto: item.json.gasto, presupuesto: l.max, porcentaje: pct, estado, fila: l.fila } });
}
return salida;
```
7. **Google Sheets** («Actualizar») — Operation: Update por Row Number con gasto, porcentaje, estado y fecha.
8. **Switch** — por `{{ $json.estado }}`: salida `ok` (no hace nada), `aviso`, `cortar`.
9. **Telegram** («Aviso 80%») — `⚠️ {{ $json.proveedor }} va por el {{ $json.porcentaje }} % del presupuesto ({{ $json.gasto }} de {{ $json.presupuesto }} €)`.
10. **Google Sheets** («Cerrar interruptor») — Update de la celda del interruptor a `cerrado`.
11. **Telegram** («Corte») — `🛑 Presupuesto de {{ $json.proveedor }} agotado. Interruptor cerrado. Ábrelo a mano cuando lo revises.`
12. Opcional y más fino: en lugar de la hoja, un **HTTP Request** a tu propio endpoint `/admin/kill-switch` protegido con un token, o a la API de Cloudflare para escribir una clave en KV que tu aplicación consulta con latencia mínima.

## Cómo probarla
Pon el presupuesto de un proveedor en 0,01 euros y ejecuta: debe avisar y cerrar el interruptor. Verifica después que tu aplicación respeta el interruptor, que es la parte que de verdad protege: si la app no lo lee, esto es solo un aviso bonito. Devuelve luego el presupuesto real y abre el interruptor.

## Qué puede salir mal
- **El consumo no es en tiempo real**: muchos proveedores actualizan el gasto con minutos u horas de retraso. Deja margen: pon el presupuesto un 20 por ciento por debajo de lo que de verdad te duele.
- **Cortar de golpe rompe el servicio**: mejor que cerrar del todo, define un modo degradado (respuestas cacheadas, modelo más barato, cola de espera). El interruptor puede tener tres valores: `abierto`, `ahorro`, `cerrado`.
- **Reapertura automática**: no la pongas. Que el interruptor se abra solo el día 1 del mes o a mano, tras mirar qué pasó.
- **Moneda**: algunos endpoints devuelven dólares o céntimos. Normalízalo en el Code, como hace el ejemplo, o compararás cifras que no significan lo mismo.
- **Frecuencia**: cada hora es un equilibrio razonable; cada minuto puede chocar con los límites de las propias APIs de facturación.

## Cuánto cuesta
La automatización es gratis; lo que ahorra es dinero real. Con n8n auto-alojado, 720 ejecuciones mensuales no cuestan nada; en el plan gratuito de la nube se comería casi todo el cupo, así que baja la frecuencia a cada 3 horas si vas por ahí.
