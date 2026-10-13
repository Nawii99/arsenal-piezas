# Lista de espera que rellena huecos de cancelaciones…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Cuando alguien cancela una cita, el sistema busca en tu lista de espera a quien mejor encaje con ese hueco y le ofrece la plaza por WhatsApp por orden, sin que tú llames a nadie.

## Qué es y qué hace

Vigila el calendario de citas; cuando una cita pasa a cancelada, busca en la hoja ListaEspera a los pacientes cuyo servicio y franja encajan y les ofrece el hueco por WhatsApp uno a uno, con 20 minutos para responder. Entrada: cancelación en Google Calendar; salida: hueco asignado y mensajes. Se monta en n8n con Google Calendar, Sheets y WhatsApp.

## Cómo usarla

1. Crear el calendario Citas y la hoja ListaEspera
2. Conectar Calendar, Sheets y WhatsApp
3. Probar con una cancelación ficticia
4. Que lo revise un profesional

## Cuándo usarla

Cuando cancelan a última hora y esa hora se queda muerta porque no da tiempo a llamar a diez personas de la lista.

## Cómo ganar dinero con ella

Rellenar 6 huecos al mes de 50 € son 300 € de facturación que hoy se pierden; el montaje son un par de horas una sola vez.

- Rellenar huecos de cancelación para clínicas de estética y fisioterapia, cobrando la instalación.
- Ofrecer el sistema a psicólogos con lista de espera de pacientes.
- Montar un registro de ofertas de hueco y respuestas para recepción.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Vigila tu Google Calendar de citas; cuando una cita desaparece o pasa a estado `cancelada`, busca en una hoja de lista de espera a los pacientes cuyo servicio y disponibilidad horaria encajan y les ofrece el hueco por WhatsApp uno a uno, con 20 minutos de margen para responder.
Para clínicas de fisio, estética, dental o psicología con agenda en Google Calendar y una lista de espera que hoy vive en un cuaderno.

## Lo que necesitas antes
n8n (auto-alojado o Cloud) accesible desde internet si quieres respuesta por WhatsApp; con n8n Cloud ya lo es, auto-alojado necesitas un dominio o un túnel.
Google Calendar con un calendario dedicado `Citas` y credencial `Google Calendar OAuth2` en n8n (activa Google Calendar API en console.cloud.google.com).
Google Sheet `ListaEspera` con columnas: `id`, `nombre`, `telefono`, `servicio`, `franja` (valores `manana`, `tarde` o `cualquiera`), `prioridad` (1 alta a 3 baja), `estado`, `ofrecido_hasta`.
Cuenta de Twilio con WhatsApp; necesitas Account SID, Auth Token y el número emisor.

## Los nodos, en orden
1. **Schedule Trigger** — cada 10 minutos, expresión `*/10 * * * *`, timezone `Europe/Madrid`.
2. **Google Calendar** — Operation `Get Many`, calendario `Citas`, Start Time `{{$now.toISO()}}`, End Time `{{$now.plus(7,'days').toISO()}}`, `Return All` activado, opción `Show Deleted` activada para ver las canceladas.
3. **Code** (huecos) — compara los eventos que ahora están `cancelled` con la lista guardada; devuelve los huecos nuevos con `fecha`, `hora_inicio`, `servicio` (lo lees del título del evento, formato recomendado `Servicio - Nombre paciente`).
4. **Google Sheets** — hoja `ListaEspera`, Operation `Get Row(s)`, `Return All`.
5. **Merge** — Mode `Combine`, Combine By `All Possible Combinations`, para cruzar cada hueco con cada candidato.
6. **Code** (matching) — filtra por servicio igual, franja compatible y estado distinto de `ofrecido` u `off`; ordena por `prioridad` y devuelve solo el mejor candidato de cada hueco (código abajo).
7. **Twilio** — WhatsApp a `{{$json.telefono}}` con el texto: `Hola {{$json.nombre}}, se ha liberado un hueco el {{$json.fecha}} a las {{$json.hora_inicio}}. Responde SI en los próximos 20 minutos y te lo reservo.`
8. **Google Sheets** — `Update Row`, matching `id`, pon `estado` = `ofrecido` y `ofrecido_hasta` = `{{$now.plus(20,'minutes').toISO()}}`.
9. **Webhook** (workflow aparte) — Method `POST`, path `wa-respuesta`; pega esa URL en Twilio, en la configuración del número, campo `A message comes in`.
10. **IF** — comprueba que el cuerpo del mensaje contiene `SI` y que `ofrecido_hasta` sigue en el futuro.
11. **Google Calendar** — Operation `Create`, título `{{$json.servicio}} - {{$json.nombre}}`, Start y End del hueco; y **Google Sheets** para poner `estado` = `confirmado`.

## El nodo Code de matching
```js
const franjaOk = (franja, hora) => franja === 'cualquiera' || (franja === 'manana' && hora < '14:00') || (franja === 'tarde' && hora >= '14:00');
const porHueco = {};
for (const it of $input.all()) {
  const d = it.json;
  if (d.estado === 'off' || d.estado === 'ofrecido' || d.estado === 'confirmado') continue;
  if (String(d.servicio).toLowerCase() !== String(d.servicio_hueco).toLowerCase()) continue;
  if (!franjaOk(d.franja, d.hora_inicio)) continue;
  const clave = d.fecha + d.hora_inicio;
  const actual = porHueco[clave];
  if (!actual || Number(d.prioridad) < Number(actual.prioridad)) porHueco[clave] = d;
}
return Object.values(porHueco).map(json => ({ json }));
```

## Cómo probarla
Crea una cita de prueba en el calendario, bórrala y espera al siguiente ciclo de 10 minutos con tu propio móvil en la lista de espera.
Prueba el caso feo: dos huecos el mismo día y un solo candidato válido; debe recibir una sola oferta.

## Qué puede salir mal
Si nadie responde, el `ofrecido_hasta` caduca: añade un segundo Schedule que devuelva a `estado` vacío los ofrecidos vencidos y pase al siguiente candidato.
Doble reserva: comprueba siempre con un Google Calendar `Get Many` justo antes del `Create`, por si el hueco lo ocupó una llamada telefónica.
Twilio en sandbox solo escribe a números que se hayan dado de alta; para producción necesitas número propio y plantillas aprobadas.
Zona horaria: guarda las horas en ISO con offset, no en texto suelto.

## Cuánto cuesta
n8n auto-alojado 0 €, Cloud desde unos 20 €/mes.
Twilio WhatsApp: unos 0,04-0,06 € por conversación iniciada por la empresa; 100 ofertas al mes son unos 5 €.
Google Calendar y Sheets: gratis.
