# Recordatorio de cita por email el día antes, con n8n…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Cada tarde, n8n revisa mañana en el calendario y manda a cada paciente un email con hora y lugar, sin datos sensibles.

## Qué es y qué hace

Es una receta de n8n que cada tarde lee las citas de mañana en Google Calendar y envía a cada paciente un email con fecha, hora y dirección, sin datos clínicos. Entra el calendario y el correo del paciente; sale un recordatorio por email enviado la víspera. Riesgo: el nombre en la agenda ya es dato de salud.

## Cómo usarla

1. Conecta Google Calendar y el correo en n8n
2. Prueba con citas de prueba
3. Revisa el aviso de datos y la cuenta de Google antes de usarla con pacientes
4. Que lo revise un profesional

## Cuándo usarla

Tus pacientes faltan sin avisar y quieres que la víspera reciban un email con hora y dirección, sin escribirlo tú cada tarde.

## Cómo ganar dinero con ella

Instálalo en consultas pequeñas que ya apuntan las citas en Google Calendar y cobra la puesta en marcha y un mantenimiento mensual a [TU PRECIO]. Antes de usarlo con pacientes reales, un profesional de protección de datos revisa la cuenta de Google y el tratamiento.

- Instalación de recordatorios para fisioterapia y dental pequeños, por instalación…
- Cuota mensual de mantenimiento del envío y de la agenda, por mes…
- Adaptación del aviso para cada centro, por configuración…

**Precio orientativo:** 150–300 € puesta en marcha. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

# Recordatorio de cita por email el día antes

## Qué hace

Cada día a la hora que elijas (por ejemplo 18:00), n8n lee las citas de mañana en tu Google Calendar y manda un email a cada paciente con: nombre, día, hora, dirección y cómo cancelar. Nada más. Reduce las citas a las que no viene nadie sin que tengas que escribir a mano.

## Cuentas que hacen falta y qué cuestan

- **n8n**: gratis si lo instalas tú en un servidor (self-hosted). La versión en la nube de n8n es de pago desde el primer plan; mira el precio actual en su web. Para alguien que empieza, self-hosted en un servidor barato o la nube con el plan más bajo.
- **Google Calendar**: donde ya apuntas las citas. Ver el aviso de datos más abajo.
- **Gmail** (o el correo de tu dominio): Gmail gratuito permite unos 500 envíos al día; Google Workspace, unos 2.000. Una consulta no llega ni de lejos.

## Aviso de datos, antes de montar nada

Vas a meter nombres y emails de pacientes en Google Calendar y a enviarlos por Gmail. Eso convierte a Google en encargado del tratamiento y necesitas un contrato con él (art. 28 RGPD).

- Con una cuenta Gmail gratuita personal **no tienes** ese contrato. No la uses para pacientes.
- Con **Google Workspace** (de pago, plan básico por usuario y mes, precio en su web) sí: Google incluye el anexo de tratamiento de datos (DPA). Es la opción mínima aceptable.
- Si lo tuyo es un programa de citas específico para consultas, mira si ya manda recordatorios. Suele ser mejor que esto.

Regla fija: en el calendario, el título de la cita es solo el nombre del paciente. El motivo de la consulta no se escribe nunca en el evento. Y n8n tampoco lo va a enviar.

## Cómo tienes que apuntar las citas en el calendario

Para que la receta funcione sin programar nada:

- Crea un calendario aparte llamado "Consulta" (no uses tu calendario personal).
- Título del evento: nombre del paciente. Ejemplo: `Marta García`.
- Invitado del evento: el email del paciente (campo "Añadir invitados"). n8n lo lee de ahí.
- Ubicación del evento: la dirección de la consulta.
- Sin descripción, o solo "Confirmada" / "Pendiente".

## Nodos, en orden

**1. Schedule Trigger** (disparador)
- Trigger interval: Days. Hours: `18`. Minutes: `0`.
- Time zone del workflow: Europe/Madrid (en Settings del workflow).

**2. Google Calendar → Get Many events**
- Credential: tu cuenta de Google Workspace (conectar con OAuth, n8n te guía).
- Calendar: el calendario "Consulta".
- Options → After: `{{ $now.plus(1, 'day').startOf('day').toISO() }}`
- Options → Before: `{{ $now.plus(1, 'day').endOf('day').toISO() }}`
- Return All: activado.
- Esto devuelve una lista con todas las citas de mañana. Cada cita sale como un elemento y los nodos siguientes se ejecutan una vez por cita, sin hacer nada más.

**3. IF** (filtra citas sin email)
- Condición: `{{ $json.attendees }}` → Array → is not empty.
- Rama true sigue. Rama false no se conecta a nada: las citas sin invitado se saltan y no fallan.

**4. Set (Edit Fields)** (prepara los datos limpios)
- `nombre` = `{{ $json.summary }}`
- `email` = `{{ $json.attendees[0].email }}`
- `hora` = `{{ DateTime.fromISO($json.start.dateTime).setZone('Europe/Madrid').toFormat('HH:mm') }}`
- `fecha` = `{{ DateTime.fromISO($json.start.dateTime).setZone('Europe/Madrid').setLocale('es').toFormat("cccc d 'de' LLLL") }}`
- `direccion` = `{{ $json.location }}`

**5. Gmail → Send**
- Credential: la misma cuenta de Workspace.
- To: `{{ $json.email }}`
- Subject: `Recordatorio de cita: mañana a las {{ $json.hora }}`
- Email Type: Text.
- Message:
  `Hola {{ $json.nombre }}, te recordamos tu cita mañana {{ $json.fecha }} a las {{ $json.hora }} en {{ $json.direccion }}. Si no puedes venir, responde a este correo o llama al [TELÉFONO] con al menos [HORAS] horas de antelación. Gracias. [NOMBRE DE LA CONSULTA]`

**6. Gmail → Send** (aviso a ti, opcional)
- Conéctalo a la rama false del IF. To: tu email. Subject: `Cita sin email mañana: {{ $json.summary }}`. Así te enteras de qué recordatorios no han salido.

## Cómo probarla sin liarla

1. Crea en el calendario "Consulta" un evento mañana con tu propio nombre y tu propio email como invitado.
2. Crea otro evento mañana sin invitado, para probar la rama de "sin email".
3. En n8n pulsa **Test workflow** (no lo actives todavía). Mira en cada nodo la pestaña Output: en el nodo 2 deben salir dos eventos, en el nodo 5 debe salir un solo envío.
4. Comprueba el correo que te ha llegado: hora correcta, fecha en español, dirección bien.
5. Si la hora sale mal, es la zona horaria: revisa Settings del workflow y la expresión del nodo 4.
6. Borra los eventos de prueba. Solo entonces pulsa **Active**.
7. La primera semana, cada tarde mira en Executions que ha corrido y cuántos envíos ha hecho.

## Qué NO hacer

- No pongas el motivo de la cita ni nada clínico en el evento ni en el email. Un recordatorio lo puede leer cualquiera que tenga el móvil del paciente en la mano.
- No lo montes con una cuenta Gmail personal gratuita para pacientes reales.
- No mandes por WhatsApp desde tu número personal "porque es más cómodo". El paso a WhatsApp requiere la API oficial a través de un proveedor con contrato, y tiene coste por mensaje.
- No añadas al calendario a pacientes que no te han dicho que sí a los recordatorios. Esa casilla está en tu hoja informativa de datos.
- No actives el workflow sin haber hecho la prueba con tu propio email.
