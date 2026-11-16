# Fichaje de entrada y salida con llavero NFC

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
1. **Webhook** — método **POST**, path `fichaje`. En *Authentication* elige *Header Auth* y crea una credencial con nombre `X-Token` y un valor secreto largo que tú inventes; así nadie más puede colar fichajes. Deja el nodo con su nombre «Webhook» (el código lo cita) y, en *Respond*, elige responder con el nodo *Respond to Webhook*, porque la respuesta al lector la da el paso 7 (o la del rebote).
2. En el ESP32 con ESPHome, en el `binary_sensor` del lector, añade una acción `http_request.post` a la URL del webhook con el cuerpo `{"uid": "UID_LEIDO"}` y la cabecera `X-Token`. El asistente de ESPHome te genera casi todo; el bloque de tag es `on_tag: then: - http_request.post:`.
3. **Google Sheets** — *Get Row(s)* de la pestaña `Empleados`, filtro `uid` = `{{ $json.body.uid }}`. Llama al nodo exactamente «Empleados» (el código lo cita) y en sus ajustes activa que siempre devuelva datos aunque no encuentre el uid, para que un uid desconocido llegue al Code y salga como DESCONOCIDO. Devuelve el nombre.
4. **Google Sheets** — *Get Row(s)* de `Fichajes`, filtro `uid` = el mismo y `fecha` = hoy. Llama al nodo exactamente «Fichajes hoy» (el código lo cita); el uid se toma con `{{ $('Webhook').first().json.body.uid }}`, la fecha es la de hoy en formato es-ES (día/mes/año) calculada con la hora de Europe/Madrid, y en los ajustes del nodo activa que siempre devuelva datos y que se ejecute una sola vez. Sirve para saber si esta persona ya ha entrado.
5. **Code** (modo *Run Once for All Items*), llámalo «Decidir entrada o salida» — decide si es entrada o salida o si es un rebote:
```js
// Antirrebote: si el mismo llavero ya fichó hace menos de REBOTE_SEGUNDOS, no se apunta (pero se responde al lector)
const REBOTE_SEGUNDOS = 60;
const uid = $('Webhook').first().json.body.uid;
const emp = $('Empleados').all()[0];
const nombre = emp && emp.json.nombre ? emp.json.nombre : 'DESCONOCIDO ' + uid;
const previos = $('Fichajes hoy').all().map(i => i.json).filter(f => f.uid === uid);
const tipo = previos.length % 2 === 0 ? 'ENTRADA' : 'SALIDA';
const d = new Date(new Date().toLocaleString('en-US', { timeZone: 'Europe/Madrid' }));
const st = $getWorkflowStaticData('global');
st.ultimo = st.ultimo || {};
const ahora = Date.now();
const antes = st.ultimo[uid];
if (antes && ahora - antes < REBOTE_SEGUNDOS * 1000) {
  return [{ json: { rebote: true, uid, nombre, segundos: Math.round((ahora - antes) / 1000) } }];
}
st.ultimo[uid] = ahora;
// limpia llaveros que llevan más de un día sin fichar para que la memoria no crezca
for (const [k, t] of Object.entries(st.ultimo)) if (ahora - t > 86400000) delete st.ultimo[k];
return [{ json: { rebote: false, fecha: d.toLocaleDateString('es-ES'), hora: d.toLocaleTimeString('es-ES'), uid, nombre, tipo } }];
```
6. **IF** llamado «¿Rebote?», con la condición booleana `{{ $json.rebote }}` verdadera. La salida *true* va a un **Respond to Webhook** llamado «Responder rebote», con respuesta de texto `{{ $json.nombre }}: ya fichado hace {{ $json.segundos }} s (no se apunta otra vez)`, y ahí termina. La salida *false* va a **Google Sheets** — *Append Row* en `Fichajes`, llamado «Apuntar fichaje», con las columnas fecha, hora, uid, nombre y tipo tomadas de `{{ $json.campo }}`.
7. **Respond to Webhook** (llámalo «Responder al lector», conectado tras «Apuntar fichaje», con respuesta de texto) — devuelve `{{ $json.nombre }}: {{ $json.tipo }}`, para que si pones una pantallita o un zumbador el empleado tenga confirmación.
8. Segundo workflow: **Schedule Trigger** *Cron* `0 18 * * 5` (viernes a las 18:00), **Google Sheets** *Get Row(s)* de la pestaña `Fichajes` entera, sin filtro y con la opción de devolver siempre datos (el Code siguiente se queda con los últimos 7 días), un **Code** que sume por persona (entradas y salidas emparejadas) y un **Gmail** (operación Send Message, tipo de correo HTML, asunto `{{ $json.asunto }}` y mensaje `{{ $json.html }}`) con la tabla.

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

CÓDIGO DE LOS NODOS (el mismo que lleva el flujo importable)

Nodo Code «Sumar horas por persona»:
```js
// Suma las horas de la última semana por persona, emparejando ENTRADA con SALIDA
const filas = $input.all().map(i => i.json).filter(f => f.uid && f.fecha && f.hora);
const hoy = new Date(new Date().toLocaleString('en-US', { timeZone: 'Europe/Madrid' }));
const desde = new Date(hoy.getFullYear(), hoy.getMonth(), hoy.getDate() - 6).getTime();
const ts = f => {
  const [d, m, y] = String(f.fecha).split('/').map(Number);
  const [H, M, S] = String(f.hora).split(':').map(Number);
  return new Date(y, m - 1, d, H || 0, M || 0, S || 0).getTime();
};
const semana = filas.map(f => ({ ...f, t: ts(f) })).filter(f => !isNaN(f.t) && f.t >= desde).sort((a, b) => a.t - b.t);
const personas = {};
for (const f of semana) {
  const p = personas[f.uid] ||= { nombre: f.nombre, ms: 0, abierta: null, impar: false, fichajes: 0 };
  p.fichajes++;
  if (f.tipo === 'ENTRADA') {
    if (p.abierta !== null) p.impar = true; // dos entradas seguidas
    p.abierta = f.t;
  } else if (f.tipo === 'SALIDA') {
    if (p.abierta === null) p.impar = true; // salida sin entrada
    else { p.ms += f.t - p.abierta; p.abierta = null; }
  }
}
const hm = ms => Math.floor(ms / 3600000) + ' h ' + String(Math.round((ms % 3600000) / 60000)).padStart(2, '0') + ' min';
let html = '<p>Resumen de fichajes de los últimos 7 días.</p><table border="1" cellpadding="6" cellspacing="0"><tr><th>Persona</th><th>Fichajes</th><th>Horas</th><th>Revisar</th></tr>';
for (const p of Object.values(personas)) {
  if (p.abierta !== null) p.impar = true; // quedó una entrada sin salida
  html += '<tr><td>' + p.nombre + '</td><td>' + p.fichajes + '</td><td>' + hm(p.ms) + '</td><td>' + (p.impar ? 'FICHAJE IMPAR: revisar a mano' : '') + '</td></tr>';
}
html += '</table>';
if (!Object.keys(personas).length) html = '<p>No hay fichajes en los últimos 7 días.</p>';
return [{ json: { asunto: 'Resumen semanal de fichajes', html } }];
```
