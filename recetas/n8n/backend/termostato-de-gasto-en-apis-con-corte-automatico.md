# Termostato de gasto en APIs con corte automático…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Vigila cada hora lo que llevas gastado en las APIs que pagas por uso y, si te acercas al presupuesto del mes, avisa y activa el modo ahorro.

## Qué es y qué hace

Cada hora consulta el gasto acumulado del mes en tus APIs de pago y lo compara con el presupuesto que fijas. Al 80 % avisa y, al 100 %, llama a un endpoint de tu backend que activa un modo ahorro, por ejemplo desactivando un chat de IA. Entran las claves de lectura y la hoja de presupuestos; sale un aviso y una bandera de corte. Para negocios pequeños con costes variables. Revisa los límites con un profesional.

## Cómo usarla

1. Crea claves de solo lectura por proveedor
2. Rellena la hoja presupuestos con el límite mensual
3. Crea el endpoint de modo ahorro protegido
4. Prueba el corte con un presupuesto ficticio
5. Que lo revise un profesional

## Cuándo usarla

Cuando pagas por uso (IA, SMS, mapas, envíos) y te da miedo abrir la factura porque un bucle o un bot puede dispararla en una noche.

## Cómo ganar dinero con ella

Un fallo en bucle contra una API de pago puede costar cientos de euros en horas. Esto lo corta cuando llevas el 80% del presupuesto.

- Control de gasto de APIs para startups que temen facturas inesperadas…
- Configuración de límites de consumo para agencias con clientes que usan IA…
- Mantenimiento de presupuestos de APIs para pymes con servicios de pago…

**Precio orientativo:** 80–200 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada hora consulta el gasto acumulado del mes en las APIs que pagas por consumo y lo compara con el presupuesto que tú has fijado.
Al 80% te avisa; al 100% llama a un endpoint de tu backend que enciende el «modo ahorro» (por ejemplo: desactivar el chat de IA y dejar solo el formulario). Para negocios pequeños con costes variables.

## Lo que necesitas antes
- Una hoja de Google Sheets llamada `presupuestos` con columnas: servicio, url_consulta, presupuesto_mes, avisado_80, cortado.
- Las claves de lectura de cada proveedor. Ejemplos: Twilio usa autenticación básica con Account SID y Auth Token; Stripe, una clave restringida de solo lectura desde Desarrolladores > Claves de API > Crear clave restringida.
- Un endpoint propio tipo `POST https://tuweb.com/admin/modo-ahorro` protegido con una cabecera secreta (p. ej. `X-Admin-Key`) que en n8n va en una credencial Header Auth, nunca escrita en el nodo (un flujo exportado se llevaría la clave). Si no tienes backend, sustitúyelo por desactivar el flujo consumidor con la API de n8n.

## Los nodos, en orden
1. **Schedule Trigger** — Hours, cada 1 hora.
2. **Google Sheets** — Operation: Get Row(s), hoja `presupuestos`.
3. **Split In Batches** — Batch Size: 1, para tratar cada servicio por separado.
4. **HTTP Request** — GET a `={{ $json.url_consulta }}` con las credenciales del proveedor. Activa «Retry On Fail», 3 intentos.
5. **Code** — normaliza la respuesta de cada proveedor a euros y calcula el porcentaje.
6. **IF** — porcentaje mayor o igual a 100 y `cortado` distinto de «si».
7. **Google Sheets** — Operation: Update Row, marca `cortado` = `si` ANTES de llamar al endpoint (reservar el corte), y vuelve a leer la fila: solo sigue si ese cambio lo has hecho tú.
8. **HTTP Request** — POST a tu endpoint de modo ahorro. Si falla, vuelve a dejar `cortado` vacío y avisa.
9. **Gmail** — aviso con el detalle. En la rama del 80% haz lo mismo: marca `avisado_80` = `si` antes de enviar y solo avisa.

## El código del nodo Code
```js
const fila = $('Split In Batches').first().json;
const r = $input.first().json;
let gastado = 0;
if (fila.servicio === 'twilio') gastado = Math.abs(parseFloat(r.total_price || 0));
else if (fila.servicio === 'stripe') gastado = (r.pending || []).reduce((s,b) => s + b.amount, 0) / 100;
else gastado = parseFloat(r.total_usd || r.amount || 0) * 0.92;
const presupuesto = parseFloat(fila.presupuesto_mes);
const pct = Math.round((gastado / presupuesto) * 100);
return [{ json: { servicio: fila.servicio, gastado: gastado.toFixed(2), presupuesto, pct, fila_id: fila.row_number } }];
```

## Cómo probarla
- Pon un presupuesto ridículo (0,10 €) en un servicio y lanza el flujo: debe avisar y llamar a tu endpoint. Luego deja el presupuesto real y pon `cortado` a vacío.
- Prueba el endpoint de modo ahorro por separado con curl antes de meterlo aquí.

## Qué puede salir mal
- **Los proveedores dan el gasto con retraso** (hasta 24 horas en algunos). El termostato es una red de seguridad, no un contador exacto: pon el aviso al 70% si el retraso es grande.
- **Cambio de mes.** Añade una rama en el Schedule que el día 1 a las 00:05 ponga `avisado_80` y `cortado` a vacío en todas las filas.
- **Divisa.** Casi todos facturan en dólares. El 0,92 del código es un cambio aproximado: ajústalo o usa una API de tipos de cambio.
- **Ejecuciones solapadas.** Si una ejecución tarda más de una hora, la siguiente empezaría con la fila aún sin marcar. Deja el flujo ejecutándose de uno en uno (concurrencia 1) y reserva la marca antes de actuar, como en los pasos 7 y 9.
- **Cortar de más.** Que el modo ahorro degrade el servicio, no lo apague. Nunca cortes cobros ni envío de pedidos.

## Cuánto cuesta
- El flujo en sí, gratis. Las consultas de facturación no se cobran en ningún proveedor grande.
- n8n Cloud: 720 ejecuciones al mes con un servicio; si tienes tres, agrúpalos en una sola ejecución con el Split In Batches para no gastar cuota.
