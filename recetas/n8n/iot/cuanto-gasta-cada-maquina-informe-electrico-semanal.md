# Cuánto gasta cada máquina: informe eléctrico semanal…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Mide el consumo real de cada máquina con enchufes medidores y te manda cada lunes un email con los kWh y los euros que ha gastado cada una la semana pasada.

## Qué es y qué hace

Flujo de n8n que cada hora lee la energía acumulada de cada enchufe medidor Shelly, calcula lo consumido y lo multiplica por tu precio del kWh. Cada lunes envía un email con la tabla por máquina ordenada de mayor a menor gasto. Entra el ID de cada dispositivo y tu precio medio; sale el informe semanal y el registro horario.

## Cómo usarla

1. Enchufa un medidor Shelly a cada máquina
2. Apunta auth_key y ID de cada dispositivo en la hoja Consumo
3. Pon tu precio medio del kWh con impuestos
4. Revisa el informe del lunes durante un mes

## Cuándo usarla

Úsalo cuando tu factura de luz sea un misterio y sospeches que hay un aparato viejo, un arcón mal cerrado o un compresor que se come el margen.

## Cómo ganar dinero con ella

Descubrir el aparato que se lleva el 30 % de la factura suele traducirse en 60-200 € menos al mes con solo cambiarlo o programarlo.

- Auditoría energética para talleres y obradores que quieren saber qué máquina consume más.
- Informe mensual de consumo para restaurantes y peluquerías con varios equipos encendidos.
- Instalación de medidores y panel de consumo para naves y pequeñas industrias.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada hora pregunta a cada enchufe medidor cuánta energía lleva acumulada, calcula lo consumido en esa hora y lo apunta con su coste. El lunes a las 8:00 te manda un email con la tabla por máquina, ordenada de la que más gasta a la que menos.
Para obradores, talleres, restaurantes, peluquerías y cualquiera con varias máquinas enchufadas todo el día.
## Lo que necesitas antes
- Un **Shelly Plus Plug S** o **Shelly Plus 1PM** por máquina (20-25 € cada uno). Para el cuadro general, un **Shelly Pro 3EM** con pinzas.
- `auth_key`, servidor y el ID de cada dispositivo (app Shelly > cada aparato > Ajustes > Información).
- Hoja de Google «Consumo» con dos pestañas: `equipos` (columnas: nombre, device_id) y `horas` (columnas: fecha, hora, nombre, kwh, euros).
- Tu precio medio del kWh mirando la factura: el total dividido entre los kWh facturados, impuestos incluidos. Por ejemplo 0,21.
- Gmail conectado en n8n, o el nodo **Send Email** con SMTP.
## Los nodos, flujo 1: medir cada hora
1. **Schedule Trigger** — Cron `5 * * * *`.
2. **Google Sheets** — Get Row(s) de la pestaña `equipos`. Sale un item por máquina.
3. **Loop Over Items** (el nodo que antes se llamaba Split In Batches) — Batch Size 1.
4. Dentro del bucle > **HTTP Request** — POST `https://shelly-53-eu.shelly.cloud/device/status`, Form Urlencoded: `id` = `{{ $json.device_id }}`, `auth_key` = tu clave. Options > Response > Never Error.
5. **Code** «Calcular hora» — Run Once for Each Item:
```js
const st = $json.data && $json.data.device_status ? $json.data.device_status : {};
const bloque = st['switch:0'] || st;
const totalWh = bloque.aenergy ? bloque.aenergy.total : (bloque.meters ? bloque.meters[0].total : null);
const nombre = $('Loop Over Items').item.json.nombre;
const s = $getWorkflowStaticData('global');
if (!s.ultimo) s.ultimo = {};
const previo = s.ultimo[nombre];
s.ultimo[nombre] = totalWh;
let kwh = 0;
if (previo !== undefined && totalWh !== null && totalWh >= previo) kwh = (totalWh - previo) / 1000;
const PRECIO = 0.21;
const ahora = new Date().toLocaleString('sv-SE', { timeZone: 'Europe/Madrid' });
return { json: { fecha: ahora.substring(0,10), hora: ahora.substring(11,13), nombre, kwh: Number(kwh.toFixed(3)), euros: Number((kwh * PRECIO).toFixed(3)) } };
```
6. **Google Sheets** — Append Row en `horas` con esos cinco campos. Conecta la salida de vuelta al **Loop Over Items** para que siga con la siguiente máquina.
## Los nodos, flujo 2: informe del lunes
1. **Schedule Trigger** — Cron `0 8 * * 1`, Timezone Europe/Madrid.
2. **Google Sheets** — Get Row(s) de `horas`.
3. **Code** «Resumen semanal» — Run Once for All Items:
```js
const filas = $input.all().map(i => i.json);
const hoy = new Date();
const hace7 = new Date(hoy.getTime() - 7*24*3600*1000).toISOString().substring(0,10);
const sem = filas.filter(f => f.fecha >= hace7);
const acc = {};
sem.forEach(f => { const n = f.nombre; if (!acc[n]) acc[n] = { kwh: 0, eur: 0 }; acc[n].kwh += Number(f.kwh)||0; acc[n].eur += Number(f.euros)||0; });
const orden = Object.keys(acc).sort((a,b) => acc[b].eur - acc[a].eur);
const total = orden.reduce((s,n) => s + acc[n].eur, 0);
const filasHtml = orden.map(n => '<tr><td>' + n + '</td><td>' + acc[n].kwh.toFixed(1) + '</td><td>' + acc[n].eur.toFixed(2) + ' €</td></tr>').join('');
const html = '<h3>Consumo de los últimos 7 días</h3><table border=1 cellpadding=6><tr><th>Máquina</th><th>kWh</th><th>Coste</th></tr>' + filasHtml + '</table><p><b>Total: ' + total.toFixed(2) + ' €</b></p>';
return [{ json: { html, total: total.toFixed(2) } }];
```
4. **Gmail** — Send, Subject `Luz de la semana: {{ $json.total }} €`, Message `{{ $json.html }}`, Email Type HTML.
## Cómo probarla
Ejecuta el flujo 1 dos veces separadas 10 minutos: la primera fila saldrá con 0 kWh (no hay medida previa), la segunda ya con el consumo real. Comprueba que los números tienen sentido comparando con lo que marca la app Shelly. Ejecuta el flujo 2 a mano y mira el email.
## Qué puede salir mal
- **El contador del Shelly se resetea** al actualizar firmware o cortar la luz: el código ignora los valores menores que el previo, así que como mucho pierdes una hora.
- **Estructura distinta según modelo**: Plug S Gen2 usa `switch:0.aenergy.total` y los Gen1 usan `meters[0].total`. El código contempla los dos; si tienes un 3EM, mira la respuesta cruda y ajusta la línea.
- **Se te olvida cambiar el precio del kWh**: revísalo cada vez que cambies de tarifa.
- **Los datos en memoria se pierden si reinicias n8n**: solo afecta a la primera hora tras el reinicio.
- **Muchas máquinas, muchas llamadas**: con 10 equipos son 7.200 ejecuciones al mes dentro del bucle. Autoaloja n8n.
## Cuánto cuesta
20-25 € por enchufe medidor. Shelly Cloud, Sheets y Gmail gratis. n8n autoalojado 4-6 €/mes. Se paga solo el primer mes en cuanto localizas el aparato que se come la factura.
