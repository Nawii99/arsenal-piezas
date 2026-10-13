# Fichaje de entrada y salida con llavero NFC…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Los empleados fichan pasando un llavero por un lector en la pared y todo va solo a una hoja de cálculo, con resumen semanal de horas por persona.

## Qué es y qué hace

Un lector NFC con ESP32 y ESPHome envía el código del llavero por POST a un webhook de n8n, que registra entrada o salida en la hoja Fichajes con nombre y hora, calcula las horas y envía un resumen semanal por Gmail. Entrada: UID del llavero; salida: registro de jornada y resumen. Se monta en n8n.

## Cómo usarla

1. Carga el firmware ESPHome con el lector RC522
2. Crea las hojas Fichajes y Empleados
3. Que lo revise un profesional

## Cuándo usarla

Cuando tengas de 2 a 15 empleados, la obligación legal de registro de jornada y estés usando un cuaderno, un Excel a mano o una app de 4 €/mes por trabajador.

## Cómo ganar dinero con ella

Sustituye apps de fichaje de 3-5 € por empleado al mes y quita 2-3 horas al mes de recontar horas a mano. Con 8 empleados, unos 400 €/año.

- Registro de jornada para un taller o un obrador con dos a quince empleados.
- Fichaje sencillo para una tienda que quiere cumplir el registro horario sin app de pago.
- Panel de horas por persona para una pequeña oficina con resumen semanal.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un lector NFC barato pegado a la pared manda el código del llavero a n8n, que apunta la entrada o la salida en Google Sheets y hace el cálculo de horas. Los viernes te llega el resumen por correo. Para talleres, obradores, tiendas y pequeñas oficinas.

## Lo que necesitas antes
- Un **ESP32 con lector RFID/NFC RC522** (unos 12 € el conjunto en cualquier tienda de electrónica) y **llaveros MIFARE** (0,50 € cada uno). Se programa con ESPHome, que es un fichero de texto y no requiere saber programar.
- **n8n con URL accesible** desde la red del local (si es la misma red, la IP local vale).
- Una hoja de **Google Sheets** llamada `Fichajes` con `fecha`, `hora`, `uid`, `nombre`, `tipo`, y otra pestaña `Empleados` con `uid`, `nombre`.
- **Gmail** conectado en n8n.

## Los nodos, en orden
1. **Webhook** — método **POST**, path `fichaje`. En *Authentication* elige *Header Auth* y crea una credencial con nombre `X-Token` y un valor secreto largo que tú inventes; así nadie más puede colar fichajes.
2. En el ESP32 con ESPHome, en el `binary_sensor` del lector, añade una acción `http_request.post` a la URL del webhook con el cuerpo `{"uid": "UID_LEIDO"}` y la cabecera `X-Token`. El asistente de ESPHome te genera casi todo; el bloque de tag es `on_tag: then: - http_request.post:`.
3. **Google Sheets** — *Get Row(s)* de la pestaña `Empleados`, filtro `uid` = `{{ $json.body.uid }}`. Devuelve el nombre.
4. **Google Sheets** — *Get Row(s)* de `Fichajes`, filtro `uid` = el mismo y `fecha` = hoy. Sirve para saber si esta persona ya ha entrado.
5. **Code** — decide si es entrada o salida:
```js
const uid = $('Webhook').first().json.body.uid;
const emp = $('Empleados').all()[0];
const nombre = emp ? emp.json.nombre : 'DESCONOCIDO ' + uid;
const previos = $('Fichajes hoy').all().map(i => i.json).filter(f => f.uid === uid);
const tipo = previos.length % 2 === 0 ? 'ENTRADA' : 'SALIDA';
const d = new Date(new Date().toLocaleString('en-US', { timeZone: 'Europe/Madrid' }));
const st = $getWorkflowStaticData('global');
const clave = uid + '_' + d.getHours() + '_' + d.getMinutes();
if (st[clave]) return []; // el mismo llavero dos veces en el mismo minuto = rebote
st[clave] = true;
return [{ json: { fecha: d.toLocaleDateString('es-ES'), hora: d.toLocaleTimeString('es-ES'), uid, nombre, tipo } }];
```
6. **Google Sheets** — *Append Row* en `Fichajes`.
7. **Respond to Webhook** — devuelve `{{ $json.nombre }}: {{ $json.tipo }}`, para que si pones una pantallita o un zumbador el empleado tenga confirmación.
8. Segundo workflow: **Schedule Trigger** *Cron* `0 18 * * 5` (viernes a las 18:00), **Google Sheets** *Get Row(s)* de toda la semana, un **Code** que sume por persona (entradas y salidas emparejadas) y un **Gmail** con la tabla.

## Cómo probarla
- Manda una petición de prueba desde el propio n8n o con el navegador (en modo test) con un uid inventado: debe salir `DESCONOCIDO`.
- Da de alta tu llavero en `Empleados`, fichas cuatro veces seguidas y comprueba que alterna ENTRADA / SALIDA / ENTRADA / SALIDA.
- Pasa el llavero dos veces rápido: solo debe apuntarse uno.

## Qué puede salir mal
- **Alguien se olvida de fichar la salida** y las horas salen mal. Añade al resumen semanal una marca de "fichaje impar" para revisarlo a mano.
- **Se va el wifi** y el fichaje se pierde. ESPHome puede guardar en cola; lo más simple es un zumbador que suene solo si la respuesta HTTP es 200, así el empleado sabe si ha quedado registrado.
- **Cambio de hora**: usa siempre `Europe/Madrid` en el Code, nunca la hora del ESP32.
- **RGPD**: el registro de jornada es obligatorio (RD-ley 8/2019), debes conservarlo 4 años y tenerlo a disposición de la Inspección. Informa a la plantilla por escrito de qué guardas y no metas datos de más. Un UID de llavero no es un dato biométrico, así que aquí vas cómodo; **no uses huella dactilar**, que sí es dato biométrico y tiene requisitos mucho más duros.
- **Se pierde un llavero**: bórralo de `Empleados` y listo.

## Cuánto cuesta
ESP32 + RC522 + llaveros: 15-25 € una vez. ESPHome, Google Sheets, Gmail y n8n auto-alojado: **0 €/mes**, frente a los 3-5 € por empleado y mes de las apps comerciales.
