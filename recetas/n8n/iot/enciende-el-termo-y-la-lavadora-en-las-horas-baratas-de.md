# Enciende el termo y la lavadora en las horas baratas de…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Consulta cada hora el precio de la luz en España y enciende o apaga un enchufe inteligente para que tus aparatos gordos trabajen solo en las horas más baratas del día.

## Qué es y qué hace

Flujo de n8n que cada hora consulta el precio de la luz de las 24 horas del día en España (PVPC) y ordena las horas de más barata a más cara. Si la hora actual está entre las N más baratas, enciende un enchufe Shelly; si no, lo apaga. Entra el ID del dispositivo y el número de horas; sale el control del enchufe y un registro en hoja de cálculo.

## Cómo usarla

1. Instala el Shelly con electricista si la carga es grande
2. Pon la auth_key y el ID del dispositivo
3. Elige cuántas horas baratas quieres usar
4. Revisa la hoja de consumo una semana

## Cuándo usarla

Úsalo cuando tengas termo eléctrico, lavavajillas industrial, arcón, cargador de coche o bomba de calor con tarifa indexada o PVPC.

## Cómo ganar dinero con ella

Mover 3-4 kWh diarios de la hora cara a la barata ahorra entre 15 y 40 € al mes según el aparato, sin tocar nada a mano.

- Programación de cargas para pymes con tarifa PVPC que tienen termos o lavadoras de uso flexible.
- Configuración de ahorro energético para pisos turísticos o alojamientos con agua caliente.
- Auditoría de tarifa eléctrica y automatización de horarios para talleres o lavanderías.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada hora en punto pregunta el precio del kWh de las 24 horas del día, ordena de barato a caro, y si la hora actual está entre las N más baratas enciende el enchufe; si no, lo apaga. Deja constancia en una hoja para que veas cuánto has movido.
Para autónomos y pequeños negocios con tarifa PVPC o indexada y algún aparato que da igual cuándo funcione.
## Lo que necesitas antes
- Enchufe o relé Shelly con capacidad suficiente: Shelly Plus Plug S para hasta 2.500 W (termos pequeños, lavadoras) o Shelly Pro 1PM en el cuadro para cargas grandes. Ojo: si es un termo de 2.000 W o más, que lo monte un electricista en el cuadro, no en un enchufe.
- `auth_key`, servidor y ID del dispositivo de la nube Shelly (app Shelly > Ajustes de usuario > Autorización nube de control).
- Nada de claves para el precio: usamos `https://api.preciodelaluz.org/v1/prices/all?zone=PCB`, gratis y sin registro. La zona PCB es península, Baleares y Canarias; para Ceuta y Melilla usa `CYM`.
- Hoja de Google «Luz» con columnas: fecha, hora, precio, decision.
- Decide cuántas horas quieres: 4 para un termo, 6-8 para un arcón.
## Los nodos, en orden
1. **Schedule Trigger** — Cron Expression: `2 * * * *` (minuto 2 de cada hora, para no pillar la API justo en el cambio).
2. **HTTP Request** — Method GET, URL `https://api.preciodelaluz.org/v1/prices/all?zone=PCB`. Options > Response > Never Error activado.
3. **Code** (llámalo «Elegir horas») — Run Once for All Items, código abajo.
4. **HTTP Request** (llámalo «Mandar a Shelly») — Method POST, URL `https://shelly-53-eu.shelly.cloud/device/relay/control` (tu servidor). Body Form Urlencoded con: `id` = tu device id, `auth_key` = tu clave, `channel` = `0`, `turn` = `{{ $json.accion }}`.
5. **Google Sheets** — Append Row en «Luz»: fecha `{{ $json.fecha }}`, hora `{{ $json.hora }}`, precio `{{ $json.precio }}`, decision `{{ $json.accion }}`.
## El código del nodo Code
```js
const HORAS_BARATAS = 4;
const data = $input.first().json;
const lista = Object.keys(data).map(k => ({ franja: k, hora: data[k].hour, precio: data[k].price }));
lista.sort((a, b) => a.precio - b.precio);
const baratas = lista.slice(0, HORAS_BARATAS).map(x => String(x.hora).padStart(2, '0'));
const ahora = new Date().toLocaleString('sv-SE', { timeZone: 'Europe/Madrid' });
const horaActual = ahora.substring(11, 13);
const fecha = ahora.substring(0, 10);
const actual = lista.find(x => String(x.hora).padStart(2, '0') === horaActual);
const accion = baratas.includes(horaActual) ? 'on' : 'off';
return [{ json: { fecha, hora: horaActual, precio: actual ? actual.precio : null, baratas: baratas.join(','), accion } }];
```
## Cómo probarla
Ejecuta a mano y mira la salida del Code: la lista `baratas` debe tener 4 horas con pinta razonable (madrugada o mediodía soleado). Comprueba que el enchufe cambia de estado en la app Shelly. Para forzar una prueba, sube `HORAS_BARATAS` a 24 y ejecuta: debe encender siempre. Vuelve a bajarlo y activa el workflow.
## Qué puede salir mal
- **La API va lenta o no responde a las 20:15**, cuando publican precios nuevos: por eso disparamos en el minuto 2 y ponemos «Never Error». Si viene vacío, el Code fallará; añade delante un **IF** que compruebe `{{ Object.keys($json).length }}` **larger** `20`.
- **Zona horaria**: el `sv-SE` con `Europe/Madrid` te da la hora local correcta en verano e invierno. No uses `new Date().getHours()` a secas si tu servidor está en UTC.
- **El aparato no debe cortarse a mitad de ciclo**: para lavavajillas o lavadoras, usa este flujo solo para DAR corriente y programa el arranque en la máquina, o quítale el corte durante 2 horas seguidas.
- **Termo con legionela**: fuerza al menos un calentamiento a 60 ºC a la semana. Añade un segundo **Schedule Trigger** semanal que encienda 3 horas seguidas pase lo que pase.
- **Precio negativo o cero**: no rompe nada, simplemente esa hora saldrá siempre elegida.
## Cuánto cuesta
La API del precio de la luz es gratis y sin registro. Shelly Cloud, gratis. El hardware, 20-45 €. Solo pagas el alojamiento de n8n. Con 720 ejecuciones al mes cabe de sobra en un n8n autoalojado y en la mayoría de planes de pago pequeños.
