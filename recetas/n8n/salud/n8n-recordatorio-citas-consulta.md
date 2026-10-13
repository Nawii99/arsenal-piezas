# Recordatorio de cita por correo el día antes…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

A las 18h, n8n lee mañana del calendario y envía a cada paciente un email con fecha, hora y dirección de la cita.

## Qué es y qué hace

Es una receta de n8n que a las 18:00 mira las citas del día siguiente en tu Google Calendar, saca el correo del paciente de la descripción y envía un recordatorio con fecha, hora y dirección. Entra el calendario; sale un email por cita. Solo datos mínimos, sin tratamiento ni motivo. Hay que revisar la cuenta de Google.

## Cómo usarla

1. Configura la hora de envío en n8n
2. Prueba con citas ficticias
3. Revisa el tratamiento de datos de la cuenta de Google
4. Que lo revise un profesional

## Cuándo usarla

Tu consulta pierde citas por olvidos y cada tarde mandas los avisos a mano desde el móvil. Lo montas una vez y el recordatorio sale solo el día antes.

## Cómo ganar dinero con ella

Instálalo en consultas pequeñas de fisioterapia, psicología o dental que no tienen quien les lleve la agenda, y cobra el montaje más una cuota mensual de mantenimiento de [TU PRECIO]. Toca datos de salud: antes de entregarlo, que lo revise un profesional de protección de datos.

- Montaje de recordatorios para fisioterapia y psicología sin agenda digital, por instalación…
- Mantenimiento mensual de recordatorios y control de envíos, por mes…
- Revisión del flujo ante cambios de agenda o de cuenta, por hora…

**Precio orientativo:** 150–300 € puesta en marcha. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

# Recordatorio de cita por correo el día antes (n8n)

## Qué hace

Cada día a las 18:00 mira las citas del día siguiente en tu Google Calendar, saca el correo del paciente de la descripción del evento y le envía un recordatorio con fecha, hora y dirección. Nada más. Ni tratamiento, ni motivo, ni nombre del profesional si no quieres.

## Antes de montar nada: lo que tiene riesgo

- El nombre de un paciente en la agenda de una consulta ya es un dato de salud (revela que es paciente tuyo). Google Calendar con cuenta gratuita de Gmail no te da contrato de encargado de tratamiento. Con Google Workspace ([PRECIO POR USUARIO Y MES]) sí. Si sigues con Gmail gratis, que lo sepas y lo apuntes en tu análisis de riesgos.
- n8n Cloud aloja el flujo en sus servidores. n8n autoalojado (gratis, en un servidor tuyo o contratado en la UE) evita ese tercero. Para empezar, Cloud vale; para un centro con volumen, mejor autoalojado en la UE.
- Enviar recordatorios no requiere consentimiento aparte: forma parte del servicio (art. 6.1.b RGPD). Pero tiene que estar en la cláusula informativa que firma el paciente. Si no está, añádelo.
- No uses tu WhatsApp personal ni WhatsApp Business normal para automatizar esto: va contra sus condiciones y te pueden cerrar el número. Si quieres WhatsApp, es la API oficial a través de un proveedor (Twilio, 360dialog) con coste por mensaje y plantillas aprobadas. Esta receta usa correo porque es gratis y no tiene ese problema.

## Cuentas que hacen falta

- Google (Calendar y Gmail). Gmail gratis permite unos 500 correos al día; de sobra.
- n8n: Cloud con prueba gratuita de 14 días y luego de pago ([PRECIO PLAN STARTER]), o autoalojado gratis.
- Para conectar Google con n8n hace falta crear una credencial OAuth en Google Cloud. Es la parte más pesada y no es programar: la documentación de n8n tiene la guía paso a paso con capturas ('Google OAuth2 single service'). Reserva media hora.

## Cómo tienes que apuntar las citas en el calendario

Para que funcione, cada evento de cita lleva en la descripción una línea exactamente así: `correo: paciente@ejemplo.com`. El título del evento puede ser el nombre del paciente o unas iniciales; el flujo no lo usa. No pongas el tratamiento en el título: se ve en cualquier pantalla y en el móvil.

## Nodos, en orden

1. **Schedule Trigger**. Modo: Days. Hora: 18:00. Zona horaria: Europe/Madrid (se cambia en los ajustes del flujo, no en el nodo).

2. **Google Calendar** (operación Get Many). Calendario: el de la consulta. En 'After' pon la expresión `{{ $now.plus(1, 'day').startOf('day').toISO() }}` y en 'Before' `{{ $now.plus(1, 'day').endOf('day').toISO() }}`. Activa 'Return All'. Esto trae las citas de mañana.

3. **Filter**. Condición: el campo `description` contiene `correo:`. Así se saltan los eventos que no son citas (comidas, formaciones, bloqueos).

4. **Edit Fields (Set)**. Crea cuatro campos:
   - `email`: expresión `{{ $json.description.match(/correo:\s*(\S+)/)[1] }}`
   - `fecha`: expresión `{{ DateTime.fromISO($json.start.dateTime).setLocale('es').toFormat("cccc d 'de' LLLL") }}`
   - `hora`: expresión `{{ DateTime.fromISO($json.start.dateTime).setZone('Europe/Madrid').toFormat('HH:mm') }}`
   - `direccion`: texto fijo con la dirección de la consulta.

5. **Gmail** (operación Send). Para: `{{ $json.email }}`. Asunto: `Recordatorio de tu cita de mañana`. Cuerpo (texto plano):
   `Hola. Te recordamos que tienes cita mañana {{ $json.fecha }} a las {{ $json.hora }} en [NOMBRE DE LA CONSULTA], {{ $json.direccion }}. Si no puedes venir, responde a este correo o llama al [TELÉFONO] con al menos 24 horas de antelación. Gracias.`
   No pongas ni el motivo de la cita ni el nombre del profesional si es una consulta de psicología o similar: el correo lo puede ver otra persona.

6. **Google Sheets** (operación Append, opcional pero recomendable). Hoja 'recordatorios' con columnas fecha_envio, email, fecha_cita. Te sirve para saber qué se envió si un paciente dice que no le llegó nada.

## Cómo probarla sin liarla

1. Crea en el calendario una cita para mañana con `correo: TU-PROPIO-CORREO` en la descripción. Solo esa.
2. En n8n pulsa 'Test workflow'. Debe llegarte un correo a ti.
3. Comprueba que la hora del correo coincide con la del calendario. Si sale con una o dos horas de diferencia, el problema es la zona horaria: revisa los ajustes del flujo y el nodo Set.
4. Borra la cita de prueba. Activa el flujo con el interruptor 'Active'.
5. Los primeros tres días, mira la ejecución en 'Executions' a las 18:05 y confirma que ha enviado tantos correos como citas tenías.
6. Si un día no se ejecuta, la causa habitual es que la credencial de Google ha caducado. Se vuelve a conectar desde 'Credentials' y listo.

## Lo que esta receta no hace

- No confirma la cita ni la cancela. Si quieres eso, el siguiente paso es que el paciente responda 'CANCELAR' y un segundo flujo lea el correo, pero eso ya toca la agenda automáticamente y merece probarse mucho antes de fiarse.
- No envía SMS ni WhatsApp. Para SMS, sustituye el nodo Gmail por Twilio (cuesta [PRECIO POR SMS] y requiere alta con documentación); el resto de la receta es igual.
- No sirve si apuntas las citas en papel o en una app que no sea Google Calendar.
