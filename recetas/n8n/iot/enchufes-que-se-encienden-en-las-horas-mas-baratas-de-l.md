# Enchufes que se encienden en las horas más baratas de l…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Cada hora consulta el precio de la luz PVPC del día y enciende o apaga tus enchufes inteligentes solo en las horas más baratas.

## Qué es y qué hace

Consulta cada hora los 24 precios PVPC del día en una API pública y enciende o apaga enchufes Shelly solo en las horas más baratas. Entran los precios y la hora actual, y salen órdenes de encendido por enchufe más un registro del ahorro. Sirve para cargas que pueden esperar, como termo, lavavajillas o coche eléctrico. Se monta con n8n en la misma red que los enchufes.

## Cómo usarla

1. Elige tu tarifa PVPC y fija la IP del Shelly
2. Prueba la API de precios en el navegador
3. Monta en n8n un flujo horario que ordena las horas y decide
4. Revisa el registro de la primera semana

## Cuándo usarla

Cuando tengas cargas que dan igual a qué hora funcionen: termo eléctrico, lavavajillas, coche eléctrico, deshumidificador, bomba de piscina o carga de baterías de herramienta.

## Cómo ganar dinero con ella

Mover 6 kWh al día de la hora cara a la barata ahorra 0,60-1,20 € diarios, entre 200 y 400 € al año, sin cambiar de tarifa ni comprar nada más que el enchufe.

- Instalación de control por precio horario en una vivienda o nave con tarifa PVPC, con tres enchufes y un informe de ahorro mensual.
- Mantenimiento mensual de la automatización y revisión de la factura de luz para autónomos con cargas flexibles, por cuota.
- Formación de una hora para familias o pymes sobre cómo programar cargas en las horas más baratas del día.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
A la hora en punto pregunta a una API pública los 24 precios PVPC del día, ordena las horas de más barata a más cara, y si la hora actual está entre las N más baratas enciende el enchufe; si no, lo apaga. Además guarda un registro para que veas lo que has ahorrado.
Para autónomos y familias con tarifa regulada PVPC y aparatos que pueden esperar.

## Lo que necesitas antes
- Tarifa PVPC (la regulada). Con tarifa fija de precio único esto no sirve de nada.
- Un enchufe o relé Shelly Plus Plug S o Shelly Plus 1PM, con IP fija en tu router (por ejemplo 192.168.1.61). Si prefieres controlarlo desde fuera de casa, activa Shelly Cloud y saca el auth_key en la app: Ajustes → Ajustes de usuario → Autorización en la nube.
- API de precios: `https://api.preciodelaluz.org/v1/prices/all?zone=PCB` es gratuita y sin clave. Alternativa oficial: ESIOS de Red Eléctrica, que pide un token gratuito por email a consultasios@ree.es.
- n8n (autoalojado o Cloud) y una hoja de Google Sheets llamada «Luz».

## Los nodos, en orden
1. **Schedule Trigger**: Cron Expression `2 * * * *` (cada hora, en el minuto 2, para que la API ya tenga el dato). Timezone del workflow: Europe/Madrid.
2. **HTTP Request** «Precios»: GET `https://api.preciodelaluz.org/v1/prices/all?zone=PCB`, Response Format JSON, Retry On Fail activado con 3 intentos.
3. **Code** «Decidir»: ordena las horas y mira si la actual está entre las más baratas.
4. **IF**: `{{ $json.encender }}` is true.
5. Rama true → **HTTP Request** «ON»: GET `http://192.168.1.61/rpc/Switch.Set?id=0&on=true`.
6. Rama false → **HTTP Request** «OFF»: GET `http://192.168.1.61/rpc/Switch.Set?id=0&on=false`.
7. Las dos → **Google Sheets** (Append): fecha, hora, precio de esa hora, precio medio del día y acción tomada.

## El trozo de código (nodo Code, «Decidir»)
```js
const HORAS_BARATAS = 5;
const datos = $json;
const lista = Object.keys(datos).map(k => ({ hora: Number(k.split('-')[0]), precio: Number(datos[k].price) }));
lista.sort((a, b) => a.precio - b.precio);
const baratas = lista.slice(0, HORAS_BARATAS).map(x => x.hora);
const ahora = Number(new Date().toLocaleString('es-ES', { timeZone: 'Europe/Madrid', hour: '2-digit', hour12: false }));
const precioAhora = lista.find(x => x.hora === ahora);
const media = lista.reduce((s, x) => s + x.precio, 0) / lista.length;
return [{ json: { encender: baratas.includes(ahora), hora: ahora, precio: precioAhora ? precioAhora.precio : null, media: Math.round(media * 100) / 100, baratas: baratas.sort((a,b)=>a-b).join(',') } }];
```
Cambia `HORAS_BARATAS` según la carga: un termo suele necesitar 3-4 horas, un coche eléctrico 6-8.

## Cómo probarla
- Ejecuta a mano y mira la salida del nodo Code: debe listarte las 5 horas más baratas del día. Compáralas con cualquier app de precio de la luz.
- Con el enchufe a la vista, cambia temporalmente `HORAS_BARATAS` a 24 (siempre enciende) y luego a 0 (siempre apaga) para ver que el Shelly obedece.
- Deja la hoja de Sheets llenándose una semana y compara la media que has pagado con la media del día.

## Qué puede salir mal
- **Días de 23 o 25 horas** (cambio de hora en marzo y octubre): el código usa la lista que devuelve la API, así que se adapta solo. No hardcodees 24.
- **La API cae**: si el HTTP Request falla, el enchufe se queda como estaba. Añade un nodo IF de error que mande un Telegram; nunca dejes que un fallo apague un congelador.
- **No pongas ahí cargas críticas**: nevera, alarma o router no deben depender de esto.
- **Termo eléctrico y legionela**: fuerza al menos una vez a la semana un ciclo largo a más de 60 ºC. Puedes hacerlo con un segundo Schedule Trigger los domingos.
- **Shelly Cloud tiene límites** de llamadas; una por hora está muy lejos del límite, pero el control local por IP es más rápido y no depende de internet.

## Cuánto cuesta
0 € de software: la API de precios es gratuita, n8n autoalojado es gratis y en n8n Cloud son 24 ejecuciones al día, que tras la prueba gratuita temporal exigen un plan de pago. Hardware: 20-35 € por enchufe Shelly.
