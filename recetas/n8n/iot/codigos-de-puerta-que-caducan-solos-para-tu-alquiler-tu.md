# Códigos de puerta que caducan solos para tu alquiler tu…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Cuando entra una reserva en tu calendario, genera un PIN único para la cerradura inteligente, se lo manda al huésped y lo borra al día siguiente de la salida.

## Qué es y qué hace

Flujo de n8n que cuando aparece una reserva en tu calendario de Google genera un PIN de seis dígitos para una cerradura Nuki, lo da de alta con fecha de inicio y fin y lo envía al huésped por email. Un segundo flujo borra cada noche los códigos caducados. Entra el token de la API de Nuki y el ID de la cerradura; sale el PIN y el registro.

## Cómo usarla

1. Genera el API token en web.nuki.io y apunta el smartlockId
2. Conecta el calendario de Reservas
3. Prueba con una reserva de prueba
4. Que lo revise un profesional (seguridad y datos de huéspedes)

## Cuándo usarla

Úsalo cuando alquiles pisos turísticos, despachos por horas, trasteros o salas de reuniones y estés perdiendo tiempo con entregas de llaves.

## Cómo ganar dinero con ella

Elimina 20-30 minutos por reserva de coordinar entrega de llaves y el riesgo de copias sueltas. Con 15 reservas al mes son 7 horas.

- Gestión automática de accesos para propietarios de pisos turísticos con varias cerraduras.
- Entrega de llaves sin presencia para coworkings pequeños y salas de reuniones por horas.
- Configuración de códigos temporales para alquiler de trasteros con reservas online.

**Precio orientativo:** 300–600 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada vez que aparece un evento nuevo en el calendario de reservas, n8n inventa un PIN de 6 dígitos, lo da de alta en la cerradura con fecha de inicio y fin, se lo envía al huésped por email y lo apunta en una hoja. Un segundo flujo limpia cada noche los códigos ya caducados.
Para propietarios de uno a diez apartamentos turísticos, coworkings pequeños y alquiler de trasteros.
## Lo que necesitas antes
- Una cerradura **Nuki Smart Lock** con **Nuki Keypad** (el conjunto ronda 250-350 €) y el **Nuki Bridge** o cerradura con wifi para que sea accesible desde internet.
- Token de la API web: entra en `web.nuki.io` con tu cuenta, ve a API y genera un **API token** con permisos de gestión de autorizaciones. Apunta también el `smartlockId` (aparece en la URL o llamando a `GET https://api.nuki.io/smartlock`).
- Un calendario de Google llamado «Reservas» donde caigan tus reservas. Si usas Airbnb o Booking, importa su enlace iCal en ese calendario (Google Calendar > Otros calendarios > Desde URL). Ojo: Google refresca el iCal cada varias horas, no es instantáneo.
- Que en el evento aparezca el email del huésped: en la descripción o como invitado.
- Hoja de Google «Codigos» con columnas: reserva, huesped, pin, auth_id, entrada, salida.
## Los nodos, flujo 1: crear el código
1. **Google Calendar Trigger** — Resource: Event, Event: Event Created, Calendar: Reservas, Poll Times: cada 15 minutos.
2. **Code** «Preparar PIN» — Run Once for Each Item:
```js
const ev = $json;
const pin = String(Math.floor(100000 + Math.random() * 899999));
const inicio = new Date(ev.start.dateTime || ev.start.date + 'T15:00:00+02:00');
const fin = new Date(ev.end.dateTime || ev.end.date + 'T12:00:00+02:00');
const texto = (ev.description || '') + ' ' + (ev.summary || '');
const m = texto.match(/[\w.+-]+@[\w-]+\.[\w.]+/);
const email = m ? m[0] : ((ev.attendees && ev.attendees[0]) ? ev.attendees[0].email : '');
return { json: { pin, nombre: ev.summary || 'Huésped', email, desde: inicio.toISOString(), hasta: fin.toISOString(), reserva: ev.id } };
```
3. **HTTP Request** «Crear autorización Nuki» — POST `https://api.nuki.io/smartlock/TU_SMARTLOCK_ID/auth`. Authentication: Generic > Header Auth, nombre `Authorization`, valor `Bearer TU_TOKEN`. Body: JSON, con: `{ "name": "{{ $json.nombre }}", "type": 13, "code": {{ $json.pin }}, "allowedFromDate": "{{ $json.desde }}", "allowedUntilDate": "{{ $json.hasta }}" }`. El tipo 13 es código de teclado.
4. **Gmail** — Send. To `{{ $('Code').item.json.email }}`. Subject `Tu código de entrada`. Message HTML: `<p>Hola {{ $('Code').item.json.nombre }},</p><p>Tu código para abrir la puerta es <b style="font-size:24px">{{ $('Code').item.json.pin }}</b></p><p>Marca el código en el teclado de la puerta y pulsa el botón del candado. Funciona desde el {{ $('Code').item.json.desde }} hasta el {{ $('Code').item.json.hasta }}.</p>`
5. **Google Sheets** — Append Row en «Codigos» con reserva, huesped, pin, entrada y salida.
## Los nodos, flujo 2: limpiar caducados
1. **Schedule Trigger** — Cron `0 3 * * *`.
2. **HTTP Request** — GET `https://api.nuki.io/smartlock/TU_SMARTLOCK_ID/auth`, misma Header Auth.
3. **Code** — filtra los que tengan `allowedUntilDate` anterior a ayer y devuelve su `id`.
4. **Loop Over Items** + **HTTP Request** — DELETE `https://api.nuki.io/smartlock/TU_SMARTLOCK_ID/auth/{{ $json.id }}`.
## Cómo probarla
Crea a mano un evento en el calendario «Reservas» de mañana con tu propio email en la descripción. Ejecuta el trigger en modo test (o espera al sondeo). Debe llegarte el email con el PIN, y en la app Nuki debe aparecer la nueva autorización con sus fechas. Ve a la puerta y prueba el código de verdad antes de dejarlo suelto. Prueba también el flujo 2 con una autorización antigua.
## Qué puede salir mal
- **PIN repetido**: Nuki no acepta dos códigos iguales activos. Si la API devuelve error, añade un **Code** que reintente con otro número.
- **Códigos con ceros o secuencias fáciles**: el código de arriba genera de 100000 a 999999. Evita permitir 000000 o 123456.
- **La hora de entrada y salida**: se ponen a las 15:00 y las 12:00 con `+02:00` (horario de verano). En invierno España es `+01:00`. Si te importa la precisión al minuto, usa la librería de fechas del nodo Date & Time en vez de escribirlo a mano.
- **Reservas modificadas o canceladas**: este flujo solo escucha creaciones. Añade otro Google Calendar Trigger con Event Updated que borre la autorización y cree otra.
- **Huésped sin email en el evento**: pon un **IF** que compruebe que `email` no está vacío y, si lo está, te avise a ti por Telegram para hacerlo a mano.
- **Se cae internet en el piso**: el keypad de Nuki guarda los códigos en la cerradura, así que la puerta sigue abriéndose; lo que no podrás es crear códigos nuevos hasta que vuelva.
## Cuánto cuesta
Nuki con keypad, 250-350 € una vez. La API web de Nuki es gratuita. Google Calendar, Sheets y Gmail gratis. n8n autoalojado 4-6 €/mes. Alternativas más baratas: cerraduras TTLock con su API, desde 90 €, aunque su documentación es más árida.
