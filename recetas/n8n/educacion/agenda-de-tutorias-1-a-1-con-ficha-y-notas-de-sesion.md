# Agenda de tutorías 1 a 1 con ficha y notas de sesión…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Cuando un alumno reserva una tutoría, se le prepara todo: recordatorio, enlace de videollamada, ficha con su historial y, al terminar, un email de resumen con los acuerdos.

## Qué es y qué hace

Flujo de n8n que al reservar una tutoría en Cal.com recibe el evento por webhook, anota la reserva en la hoja Tutorías con la ficha del alumno y envía recordatorio y enlace de videollamada. Tras la sesión manda un email con los acuerdos y los deberes. Entra el webhook de reserva y el objetivo de la sesión; sale la ficha y los emails.

## Cómo usarla

1. Crea el tipo de evento en Cal.com y el webhook hacia n8n
2. Prepara la hoja Tutorías y las plantillas de email
3. Prueba una reserva completa
4. Que lo revise un profesional (datos personales de los alumnos)

## Cuándo usarla

Cuando das mentorías o clases particulares y llegas a la sesión sin recordar qué hablasteis la vez anterior.

## Cómo ganar dinero con ella

Quita 15 minutos de preparación y 10 de seguimiento por sesión, y reduce las ausencias sin avisar. Con 30 tutorías al mes son 12 horas.

- Gestión de tutorías para profesores particulares que pierden tiempo preparando cada sesión.
- Automatización de sesiones para coaches y mentores con clientes recurrentes.
- Sistema de seguimiento para academias de refuerzo con tutorías individuales semanales.

**Precio orientativo:** 250–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Automatiza el ciclo completo de una tutoría: reserva, recordatorio, ficha previa con el historial del alumno, y email posterior con los acuerdos y los deberes.
Es para mentores, profesores particulares, coaches y academias con sesiones individuales.

## Lo que necesitas antes
n8n.
Cuenta gratuita en Cal.com (o Calendly). Crea un tipo de evento «Tutoría 45 min» con un campo obligatorio «¿Qué quieres trabajar hoy?». En Cal.com ve a Settings > Developer > Webhooks y crea uno apuntando a la URL del nodo Webhook de n8n, con los eventos BOOKING_CREATED y BOOKING_CANCELLED.
Hoja «Tutorías» con columnas: fecha, alumno, email, objetivo, acuerdos, deberes, siguiente_paso, estado.
Credencial Google OAuth2 (Sheets, Gmail, Calendar).

## Los nodos, en orden
**1. Webhook**. Method: POST, Path: `tutorias`. Copia la Production URL en el webhook de Cal.com.
**2. Switch**. Campo: `{{ $json.body.triggerEvent }}`. Salida 0 para `BOOKING_CREATED`, salida 1 para `BOOKING_CANCELLED`.
**3. Set** «Datos reserva» (salida 0). `alumno` = `{{ $json.body.payload.attendees[0].name }}`, `email` = `{{ $json.body.payload.attendees[0].email }}`, `inicio` = `{{ $json.body.payload.startTime }}`, `enlace` = `{{ $json.body.payload.metadata.videoCallUrl }}`, `objetivo` = la respuesta del campo personalizado.
**4. Google Sheets** «Historial». Get Row(s) de «Tutorías» filtrando por `email` igual a `{{ $json.email }}`, ordenado por fecha. Sirve para recuperar las sesiones anteriores.
**5. Code** «Montar ficha». Junta las últimas 3 sesiones en un bloque de texto (código abajo).
**6. Gmail** «Ficha para ti». To: tu email. Subject: `Tutoría con {{ $json.alumno }} el {{ $json.fecha_texto }}`. Cuerpo: objetivo de hoy, acuerdos de las sesiones anteriores y deberes que quedaron pendientes. Programa el envío con un **Wait** hasta 2 horas antes usando modo «At Specified Time».
**7. Gmail** «Confirmación al alumno». Subject: `Tu tutoría del {{ $json.fecha_texto }} está confirmada`. Incluye el enlace, qué debe traer preparado y la política de cancelación.
**8. Google Sheets** «Registrar sesión». Append Row con fecha, alumno, email, objetivo y estado `programada`.
**9. Schedule Trigger** aparte, cron `0 * * * *`: busca en la hoja las sesiones cuyo fin fue hace más de 30 minutos y estado `programada`, y manda un **Gmail** a ti con un enlace a un **n8n Form** de tres campos: acuerdos, deberes y siguiente paso.
**10. n8n Form Trigger** «Cierre de sesión». Al enviarlo: **Google Sheets** «Update Row» con los tres campos y estado `cerrada`, y **Gmail** al alumno con el resumen: lo hablado, sus deberes y la fecha propuesta para la siguiente.
**11.** (salida 1, cancelaciones) **Google Sheets** «Update Row» estado `cancelada` y **Gmail** al alumno ofreciendo dos huecos alternativos.

## El trozo de código
Nodo **Code** número 5, modo «Run Once for All Items»:
```javascript
const reserva = $('Datos reserva').first().json;
const previas = $('Historial').all().map(i => i.json).filter(r => r.estado === 'cerrada');
previas.sort((a, b) => new Date(b.fecha) - new Date(a.fecha));
const ultimas = previas.slice(0, 3);
const ficha = ultimas.length
  ? ultimas.map(r => `• ${r.fecha}: acordamos ${r.acuerdos}. Deberes: ${r.deberes}. Siguiente paso: ${r.siguiente_paso}`).join('\n')
  : 'Primera sesión con este alumno.';
const d = new Date(reserva.inicio);
const fecha_texto = d.toLocaleString('es-ES', { weekday: 'long', day: 'numeric', month: 'long', hour: '2-digit', minute: '2-digit', timeZone: 'Europe/Madrid' });
return [{ json: { ...reserva, ficha, fecha_texto, sesiones_previas: previas.length } }];
```

## Cómo probarla
Reserva tú mismo una tutoría en tu Cal.com con un email secundario. Comprueba que llegan los dos correos y que la fila aparece en la hoja.
Rellena el formulario de cierre y verifica que el resumen al alumno sale con los textos correctos.
Cancela otra reserva de prueba para probar la salida 1 del Switch.

## Qué puede salir mal
Cal.com manda el startTime en UTC: si no fuerzas `timeZone: 'Europe/Madrid'`, la hora sale con una o dos horas menos.
La estructura del payload cambia entre versiones de Cal.com. Antes de montar nada, pon el Webhook en modo «Listen for Test Event», haz una reserva real y mira el JSON que llega.
Si usas Calendly en vez de Cal.com, los webhooks solo están en el plan de pago; con Calendly gratis usa un **Schedule Trigger** que lea el calendario de Google en su lugar.
Alumnos que reservan y no aparecen: añade al flujo un aviso por email 10 minutos después de la hora de inicio si no has cerrado la sesión.
Guarda las notas de sesión con cabeza: son datos personales, no las publiques ni las metas en hojas compartidas con otros alumnos.

## Cuánto cuesta
Cal.com: plan gratuito suficiente para un calendario y webhooks.
n8n auto-alojado, Sheets, Gmail y Calendar: 0 €.
Coste total: 0 €.
