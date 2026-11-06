# Make (make.com): recordatorio de cita por correo 24 horas an…

**Tipo:** Receta de automatización · **Área:** Productividad · **Licencia:** CC BY 4.0

Un escenario de Make (make.com) que cada hora busca en tu Google Calendar las citas que empiezan dentro de 24 a 25 horas y envía un recordatorio por correo a los invitados.

## Qué es y qué hace

Escenario de Make (make.com) que cada hora busca en Google Calendar las citas que empiezan en 24 a 25 horas y envía un recordatorio por correo al invitado con día, hora y cómo cambiarla. Entran eventos con un cliente invitado y el texto; salen correos automáticos. Si una ejecución falla, una cita puede quedarse sin aviso. Sirve para peluquerías, consultas o talleres.

## Cómo usarla

1. Crea el calendario Citas con títulos genéricos
2. Conecta Google Calendar y Gmail en Make
3. Prueba con una cita de prueba a tu correo
4. Que lo revise un profesional

## Cuándo usarla

Úsala en negocios con cita previa (peluquería, taller, consulta, academia, asesoría) donde hay clientes que olvidan la cita.

## Cómo ganar dinero con ella

Cobra [TU PRECIO] por montarla y redactar con el cliente el texto del recordatorio. Ofrece [TU PRECIO] al mes por revisar que los recordatorios salen y ajustar horarios.

- Recordatorios de cita para peluquerías, consultas o talleres que pierden clientes por olvidos.
- Mantenimiento mensual de los avisos, con revisión del texto y de los horarios de envío.
- Ampliación con confirmación por respuesta del cliente, revisada antes de activarse.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

QUÉ HACE
Cada hora, el escenario mira tu calendario de citas. Si hay una cita que empieza dentro de 24 a 25 horas y tiene un cliente como invitado, le manda un correo con el día, la hora y cómo cambiarla.
La ventana de búsqueda dura una hora, así que cada cita se comprueba en principio una sola vez. Si una ejecución falla o se retrasa, una cita puede quedarse sin aviso.
QUÉ NECESITAS
Una cuenta de Make (make.com). Mira en su web cuántas operaciones o créditos incluye tu plan.
Google Calendar con un calendario solo para citas, por ejemplo «Citas».
Que cada cita se cree con el correo del cliente como invitado. Sin invitado no hay recordatorio.
Títulos de cita genéricos, por ejemplo «Cita - Marta». No pongas el motivo de la cita.
Una cuenta de Gmail desde la que enviar.
LOS MÓDULOS, EN ORDEN
Programación: pulsa el reloj del primer módulo, en Run scenario elige «At regular intervals» y pon 60 minutos. Si ves la opción de limitar días y horas (Advanced scheduling), úsala para no gastar operaciones de noche.
Módulo 1 · Google Calendar › Search Events (la acción que busca eventos en un rango de fechas).
- Connection: Add e inicio de sesión con la cuenta propietaria del calendario. Calendar ID: «Citas».
- Fecha de inicio del rango: {{addHours(now; 24)}}. Fecha de fin del rango: {{addHours(now; 25)}}
- Si ves la opción de eventos repetidos (Single Events), ponla en Yes, para que las citas repetidas salgan una a una.
Módulo 2 · Flow Control › Iterator.
- Array: el campo de invitados (Attendees) del módulo 1. Crea un paquete por cada invitado.
Filtro entre el módulo 2 y el 3. Nombre: «Solo clientes». Condiciones (todas a la vez): el email del invitado «Not equal to» tu correo; si aparece el estado de respuesta, que no sea «declined».
Módulo 3 · Tools › Set multiple variables.
- Variable 1. Nombre: fecha_cita. Valor: {{formatDate(inicio de la cita; "DD/MM/YYYY"; "Europe/Madrid")}}
- Variable 2. Nombre: hora_cita. Valor: {{formatDate(inicio de la cita; "HH:mm"; "Europe/Madrid")}}
- En «inicio de la cita» arrastra el campo de fecha de inicio del módulo 1.
Módulo 4 · Gmail › Send an Email.
- To: pulsa Add item y arrastra el email del invitado (el del Iterator). Subject: «Recordatorio de tu cita del » y la variable fecha_cita, « a las » y la variable hora_cita.
- Content: «Hola. Te recordamos tu cita en [NEGOCIO] el [fecha_cita] a las [hora_cita], en [DIRECCIÓN]. Si no puedes venir, responde a este correo o llama al [TELÉFONO] para cambiarla. Gracias.»
- Opcional: Make tiene una app de WhatsApp Business para enviar por WhatsApp, pero exige cuenta de empresa, plantillas aprobadas y que el cliente haya aceptado recibir mensajes. Empieza por correo.
CÓMO PROBARLA
Crea UNA cita de prueba para mañana con OTRA dirección tuya como invitada. No uses la dirección de la cuenta del calendario: el filtro «Solo clientes» la descarta.
En el módulo 1, cambia el rango para que cubra la hora de esa cita. Por ejemplo, desde una hora antes hasta una hora después.
Pulsa Run once. Mira que llega UN correo con el día y la hora correctos.
Vuelve a dejar el rango en las funciones {{addHours(now; 24)}} y {{addHours(now; 25)}}, activa Scheduling y pulsa Save.
CUÁNTO CUESTA
Aunque no haya citas, cada ejecución gasta al menos una operación en la búsqueda. Con una ejecución por hora son unas 24 al día; limitarlo a horas de trabajo reduce el gasto.
Cada recordatorio enviado gasta unas 3 o 4 operaciones más. Compruébalo en el historial tras la prueba. Mira en su web cuántas operaciones o créditos incluye tu plan.
QUÉ NO HACER
No incluyas el motivo de la cita ni datos de salud o tratamientos en el correo. En clínicas y consultas, solo día, hora y dirección. Si el negocio es sanitario, que una persona del centro valide el texto: saber que alguien tiene cita ya puede ser un dato delicado.
No uses el recordatorio para meter publicidad.
No envíes mensajes a quien no haya dado su correo para recibir avisos de su cita.
No des al escenario acceso a todos tus calendarios. Usa el de citas.
QUÉ REVISAR A MANO ANTES DE ACTIVARLA
Que la zona horaria del calendario y la del escenario son Europe/Madrid.
Que las citas que ya existen tienen al cliente como invitado.
Que la hora del recordatorio es la correcta en citas de primera hora de la mañana: se avisa 24 horas antes, así que llega por la mañana del día anterior.
Que el correo no cae en spam.
Que el escenario sigue activo tras vacaciones o cambios de contraseña de Google.
Que no hay recordatorios duplicados ni citas sin aviso durante la primera semana. Mira el historial de Make cada día.
Que el negocio informa a los clientes de que recibirán este aviso y de qué datos se usan, en su política de privacidad.
