# Zapier: recordatorio de cita desde Google Calendar…

**Tipo:** Receta de automatización · **Área:** Productividad · **Licencia:** CC BY 4.0

Un Zap de Zapier que, antes de cada cita de tu Google Calendar, formatea fecha y hora y manda un recordatorio por Gmail al cliente invitado, sin datos del motivo.

## Qué es y qué hace

Zap de Zapier que, antes de cada cita de Google Calendar, formatea fecha y hora y envía un recordatorio por Gmail al cliente invitado con día, hora y dirección. Entran eventos del calendario Citas con un solo invitado; salen correos. El título de la cita no lleva motivo, y el correo tampoco. Solo llega si el cliente figura como invitado.

## Cómo usarla

1. Crea el calendario Citas con títulos genéricos
2. Pon el cliente como invitado de cada evento
3. Configura el tiempo de antelación y prueba con una cita
4. Que lo revise un profesional

## Cuándo usarla

Cuando atiendes con cita previa (peluquería, taller, consulta, clases) y pierdes tiempo o dinero con clientes que se olvidan de venir.

## Cómo ganar dinero con ella

Móntala a negocios con agenda: [TU PRECIO] de instalación y [TU PRECIO] al mes por mantenerla, cambiar textos y revisar que sigue enviando bien.

- Recordatorios de cita para peluquerías, clases o consultas con menos ausencias de clientes.
- Mantenimiento mensual de la agenda y los textos, con revisión de avisos no enviados.
- Sistema de confirmación de citas por respuesta, revisado antes de activarse.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

RECETA DE ZAPIER: recordatorio de cita desde Google Calendar
QUÉ HACE
Un tiempo antes de cada cita de tu Google Calendar, el Zap manda un correo de recordatorio a la persona invitada.
El correo lleva solo fecha, hora y dirección. No dice el motivo de la cita.
QUÉ NECESITAS
Una cuenta de Zapier.
Una cuenta de Google con Google Calendar y Gmail.
Un calendario solo para citas de clientes, por ejemplo llamado Citas.
Una norma fija para el título de la cita, por ejemplo empezar siempre por Cita. El título no lleva el motivo.
Que el cliente figure como invitado del evento, con su correo.
Un evento por cliente, con un solo cliente invitado.
PASOS (un Trigger y varias Action, en este orden)
Paso 1 · Trigger · Google Calendar · Event Start
- Calendar: el calendario Citas.
- Time Before: pon 24 y elige horas en el campo de unidad. Mira en los desplegables cómo se expresan el tiempo y la unidad.
- Zapier revisa el calendario cada cierto tiempo según tu plan. No pongas un margen de pocos minutos.
- Pulsa Test trigger y elige un evento de prueba.
Paso 2 · Action · Filter by Zapier · Only continue if
- Primera condición: el título del evento, (Text) Contains, Cita.
- Segunda condición: el campo con los correos de los invitados, (Text) Exists. Mira en Test cómo se llama.
- Así el Zap no avisa de reuniones internas ni de eventos sin invitado.
- En Test mira cuántos correos trae ese campo. Puede incluir el tuyo. Si trae a más de un cliente, el correo les llegaría a todos y verían sus direcciones entre ellos. En ese caso no actives el Zap y deja un solo cliente por evento.
Paso 3 · Action · Formatter by Zapier · Date/Time
- Transform: Format.
- Input: la fecha de inicio del evento. To Format: DD/MM/YYYY. To Timezone: Europe/Madrid.
Paso 4 · Action · Formatter by Zapier · Date/Time
- Igual que el Paso 3, pero To Format: HH:mm.
Paso 5 · Action · Gmail · Send Email
- To: el correo del invitado.
- Subject: Recordatorio de tu cita el, la fecha del Paso 3, a las, la hora del Paso 4.
- Body: Hola, te recordamos tu cita en (nombre del negocio) el (fecha) a las (hora). Dirección: (tu dirección). Si no puedes venir, responde a este correo.
- From Name: el nombre de tu negocio.
CÓMO PROBARLA
Crea UN evento de prueba en el calendario Citas, con tu propio correo como invitado, para dentro de unas horas.
Haz Test en cada paso.
Comprueba en el Paso 3 y en el Paso 4 que la hora sale en hora de España y no desplazada.
Comprueba que el correo te llega a ti con fecha y hora correctas.
Borra el evento de prueba antes de activar el Zap.
CUÁNTO CUESTA
Mira en la web de Zapier si hay plan gratuito para probar, cuántas tareas incluye tu plan y qué pasos cuentan como tarea.
Cada recordatorio ejecuta varios pasos. Si tienes muchas citas al día, calcula el total mensual y compáralo con el límite de tu plan.
QUÉ NO HACER
No pongas en el título del evento ni en el correo el motivo, el tratamiento ni el diagnóstico. Si tu negocio es sanitario, legal o de cualquier servicio delicado, esto es importante.
El propio nombre del negocio puede revelar el servicio (una clínica, un despacho). Piénsalo antes de ponerlo en el asunto.
No uses este Zap para mandar promociones. Solo recordatorios de una cita que el cliente pidió.
No lo apliques a calendarios personales ni a reuniones internas.
No des acceso a tu calendario a más cuentas de las necesarias.
QUÉ REVISAR A MANO ANTES DE ACTIVARLA
Que los clientes saben que recibirán el recordatorio por correo y que la política de privacidad de tu negocio lo recoge.
Que el texto no incluye datos que no quieras ver en la bandeja de otra persona.
Que, al cancelar o mover una cita, el recordatorio ya no sale o, si no lo tienes claro, avisas tú al cliente.
Que el calendario Citas lo ve solo quien tiene que verlo.
Quién lee las respuestas al recordatorio y quién cambia la cita en la agenda.
Si tu actividad es sanitaria o legal, una persona decide qué datos pueden aparecer en cada correo.
