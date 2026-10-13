# Lista de espera que llena los huecos de clases cancelad…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Cuando un alumno cancela, detecta el hueco y lo ofrece automáticamente a la lista de espera por orden, con un enlace para aceptarlo, hasta que alguien lo coge.

## Qué es y qué hace

Cuando se cancela una clase con menos de 48 horas de antelación, busca en la hoja de espera quién puede ocupar esa franja y le envía un email con un botón para aceptar el hueco. El primero que pulsa lo crea en Google Calendar y el resto recibe aviso de que ya está ocupado. Usa n8n, Calendar y Sheets, y necesita una URL pública para el enlace.

## Cómo usarla

1. Crea las hojas EsperaClases y Huecos
2. Expón n8n con una URL pública
3. Prueba el botón de aceptar con dos alumnos
4. Activa el sondeo cada 15 minutos

## Cuándo usarla

Úsalo cuando cada cancelación es una hora perdida que podrías haber vendido a otro alumno si te hubiera dado tiempo a llamar.

## Cómo ganar dinero con ella

Rellenar 6 huecos al mes a 30 € la clase son 180 € que antes se evaporaban, sin hacer ni una llamada.

- Instalación de la lista de espera automática para profesores particulares con agenda en Google Calendar.
- Gestión mensual de huecos para una academia: ajustar franjas y revisar el registro de ofertas aceptadas.
- Plantilla de lista de espera vendida a centros de yoga, pilates o música con agenda por franjas.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila tu calendario. Cuando un evento de clase se cancela o se borra con menos de 48 horas de antelación, mira quién está en la lista de espera para esa franja, y le manda un email con un botón «Lo cojo». El primero que pulsa se queda el hueco: el flujo crea el evento a su nombre y avisa al resto de que ya está ocupado.

## Lo que necesitas antes
- Google Calendar con tus clases.
- Hoja `EsperaClases` con: `nombre`, `email`, `franjas` (por ejemplo `L18,X18,V17`), `prioridad` (número), `activo` (sí/no).
- Hoja `Huecos` para el registro: `id_hueco`, `fecha_hora`, `estado`, `ofrecido_a`, `aceptado_por`.
- n8n con una URL pública accesible (auto-alojado con dominio, con túnel, o n8n Cloud): hace falta para el enlace de aceptación.

## Los nodos, en orden
**Flujo A: detectar el hueco**
1) **Schedule Trigger** — Every 15 Minutes.
2) **Google Calendar** (Get Many Events) — After `{{ $now.toISO() }}`, Before `{{ $now.plus(7, 'days').toISO() }}`, Return All, Show Deleted activado en Options.
3) **Code** — detecta eventos con `status: cancelled` o con `[LIBRE]` en el título que aún no estén en la hoja `Huecos`. Código abajo.
4) **Google Sheets** (Get Rows) — hoja `EsperaClases`.
5) **Code** — filtra quién encaja con la franja del hueco y ordena por prioridad y antigüedad.
6) **Split In Batches** (Batch Size 1) — para ofrecerlo de uno en uno.
7) **Gmail** (Send Message) — Subject `Se ha liberado una clase el {{ $json.fecha_texto }}`, con el enlace: `https://TU-N8N/webhook/aceptar?hueco={{ $json.id_hueco }}&alumno={{ $json.email }}&t={{ $json.token }}`.
8) **Wait** — Resume: After Time Interval, 45 minutes. Si nadie acepta, vuelve al Split In Batches y se lo ofrece al siguiente.
9) **Google Sheets** (Append or Update Row) — marca el hueco como `ofrecido`.
**Flujo B: aceptar el hueco**
10) **Webhook** — HTTP Method GET, Path `aceptar`, Respond: Using Respond to Webhook node.
11) **Google Sheets** (Get Rows) — hoja `Huecos`, busca el `id_hueco`.
12) **IF** — `{{ $json.estado }}` equals `ofrecido`. Si ya está `aceptado`, va a la rama de «lo siento, ya lo han cogido».
13) **Google Calendar** (Create Event) — Summary `Clase - {{ $json.nombre }}`, Start y End los del hueco, Attendees el email del alumno.
14) **Google Sheets** (Update Row) — estado `aceptado`, `aceptado_por` el email.
15) **Respond to Webhook** — Respond With: Text, con un mensaje bonito: «Listo, la clase es tuya. Te llega la invitación al correo.»
16) **Gmail** (Send Message) — a ti, avisándote de que el hueco se ha cubierto.

## El código del nodo 3
```js
const crypto = require('crypto');
const yaVistos = new Set(); // rellénalo desde la hoja Huecos con $('Google Sheets').all()
const out = [];
for (const it of items) {
  const e = it.json;
  const libre = e.status === 'cancelled' || /\[LIBRE\]/i.test(e.summary || '');
  if (!libre) continue;
  const ini = e.start?.dateTime; if (!ini) continue;
  const d = new Date(ini);
  const horas = (d - new Date()) / 3600000;
  if (horas < 2 || horas > 168) continue;
  const id = crypto.createHash('md5').update(String(e.id)).digest('hex').slice(0, 10);
  if (yaVistos.has(id)) continue;
  const letras = ['D','L','M','X','J','V','S'];
  out.push({ json: { id_hueco: id, inicio: ini, fin: e.end?.dateTime, franja: letras[d.getDay()] + d.getHours(), fecha_texto: d.toLocaleString('es-ES', { weekday: 'long', day: 'numeric', month: 'long', hour: '2-digit', minute: '2-digit' }), token: crypto.randomBytes(8).toString('hex') } });
}
return out;
```

## Cómo probarla
- Crea un evento mañana con `[LIBRE]` en el título y ponte a ti mismo en la lista de espera con esa franja. Debe llegarte el email en menos de 15 minutos.
- Pulsa el enlace dos veces: la segunda tiene que decirte que ya está cogido. Esa es la prueba importante.
- Prueba con dos alumnos de espera y no aceptes: a los 45 minutos debe pasarle la oferta al segundo.

## Qué puede salir mal
- **Dos personas aceptan a la vez**: el IF del paso 12 evita el doble. Para más seguridad, ejecuta el flujo B con Settings > Execution Order y comprueba el estado justo antes de crear el evento.
- **Enlaces manipulables**: el token aleatorio y la comprobación de que el email está en la lista de espera bastan para un negocio pequeño.
- **Ofertas en mitad de la noche**: añade un **IF** que solo mande emails entre las 8:00 y las 21:00, y si no, un **Wait** hasta la mañana.
- **Eventos borrados en vez de cancelados**: si borras el evento, Calendar deja de devolverlo salvo con Show Deleted. Mejor acostúmbrate a poner `[LIBRE]` en el título.

## Cuánto cuesta
- Todo gratis salvo el alojamiento de n8n, que aquí conviene que sea auto-alojado con dominio (5 a 8 €/mes en un VPS) por el webhook público.
- En Zapier este flujo no cabe bien: necesita bucles y esperas largas.
