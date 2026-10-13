# Papeleo previo a la cita, con freno si falta algo…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Manda al paciente el consentimiento y el cuestionario antes de venir, guarda las respuestas y el PDF firmado en Drive, y avisa al profesional si el día antes sigue faltando papeleo.

## Qué es y qué hace

Cuando entra una cita de primera visita, envía por email un formulario previo con consentimiento y cuestionario, identificado por el id de la cita. Al recibir la respuesta genera un PDF y lo archiva en Drive por paciente. El día antes manda un recordatorio a quien falte y a las 20:00 avisa al profesional de las citas sin papeleo. Entrada: cita y respuestas; salida: PDF archivado y avisos. Se monta en n8n con Google Forms, Drive, Calendar y Gmail.

## Cómo usarla

1. Crear el Google Form con id_cita y consentimiento
2. Conectar Calendar, Drive y Gmail
3. Probar con una cita ficticia
4. Que lo revise un profesional

## Cuándo usarla

Cuando pierdes diez minutos de cada primera visita rellenando papeles y a veces empiezas sin el consentimiento firmado.

## Cómo ganar dinero con ella

Diez minutos recuperados en 40 primeras visitas al mes son casi 7 horas de agenda libre, unos 300 € en servicio facturable.

- Organizar el papeleo previo de fisioterapeutas y nutricionistas, cobrando por instalación.
- Ofrecer el archivo de consentimientos por paciente a clínicas que tratan datos sensibles.
- Montar un panel de papeleo pendiente para recepción.

**Precio orientativo:** 250–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cuando entra una cita nueva marcada como primera visita, envía por email el enlace al formulario previo (datos, consentimiento informado y cuestionario de hábitos) con un identificador único; al recibir la respuesta genera un PDF y lo archiva en una carpeta de Drive por paciente.
El día antes revisa quién no ha contestado y manda un recordatorio, y a las 20:00 avisa al profesional con la lista de citas sin papeleo.
Para clínicas de fisio, psicología, nutrición y estética que tratan datos sensibles y quieren tenerlo todo firmado y ordenado.

## Lo que necesitas antes
Google Form con campos: `id_cita` (respuesta corta, se rellena por URL), nombre, DNI, email, casillas de consentimiento y las preguntas de tu cuestionario. En el Form, en Respuestas, crea la hoja de cálculo vinculada.
La URL precargada del formulario: en el Form, tres puntos, `Obtener enlace prerrelleno`, escribe `TEST` en `id_cita`, copia el enlace y sustituye `TEST` por la expresión de n8n.
Carpeta en Google Drive `Pacientes` y credencial `Google Drive OAuth2` (activa Drive API).
Credenciales `Google Calendar OAuth2`, `Google Sheets OAuth2` y `Gmail OAuth2`.
Convención en el calendario: las primeras visitas llevan `[1V]` al principio del título.

## Los nodos, en orden
1. **Schedule Trigger** — `0 * * * *` (cada hora en punto).
2. **Google Calendar** — `Get Many`, Start `{{$now.toISO()}}`, End `{{$now.plus(10,'days').toISO()}}`, `Return All`.
3. **Filter** — condición: `{{$json.summary}}` contiene `[1V]`.
4. **Google Sheets** — hoja `EnvíosPapeleo` (columnas `id_cita`, `email`, `enviado`, `respondido`), `Get Row(s)`.
5. **Code** — descarta las citas que ya estén en la hoja y prepara el enlace: `https://docs.google.com/forms/d/e/FORM_ID/viewform?usp=pp_url&entry.123456=` seguido del `id_cita`, que será el id del evento de calendario.
6. **Gmail** — `Send`, asunto `Antes de tu cita: 3 minutos de formulario`, cuerpo con el enlace y una frase clara sobre para qué usas los datos.
7. **Google Sheets** — `Append Row` en `EnvíosPapeleo` con `enviado` = fecha de hoy.
8. Workflow 2, **Google Sheets Trigger** — Event `Row Added`, sobre la hoja de respuestas del Form, Poll Times cada 5 minutos.
9. **HTML** — nodo `HTML` en modo `Generate HTML Template`, monta una ficha con las respuestas y el texto del consentimiento y la fecha.
10. **Convert to File** o nodo **HTTP Request** a una API de PDF; la vía sin coste es usar el nodo `HTML` y guardar el `.html` en Drive, que se abre y se imprime igual.
11. **Google Drive** — `Create Folder` con nombre `{{$json.nombre}} - {{$json.dni}}` dentro de `Pacientes`, y luego `Upload File` con el documento.
12. **Google Sheets** — `Update Row` en `EnvíosPapeleo`, `respondido` = sí.
13. Workflow 3, **Schedule Trigger** `0 20 * * *` — cruza citas de mañana con `EnvíosPapeleo` y manda **Gmail** al profesional con los que faltan, más un segundo recordatorio al paciente.

## Cómo probarla
Crea una cita `[1V] Prueba` para dentro de 3 días con tu email y comprueba que recibes el enlace y que el `id_cita` viene ya relleno.
Rellena el formulario y verifica que aparece la carpeta en Drive con el documento dentro.

## Qué puede salir mal
El `entry.123456` cambia en cada formulario: sácalo siempre del enlace prerrelleno, no lo copies de otro sitio.
Si el paciente abre el enlace desde otra cuenta de Google puede que no cargue: en la configuración del Form desactiva `Limitar a 1 respuesta` y `Recopilar direcciones de correo`.
Duplicados: la hoja `EnvíosPapeleo` es la que impide reenviar cada hora; no la borres.
RGPD: la carpeta de Drive debe estar restringida a la cuenta de la clínica, sin enlace público, y con un texto de finalidad en el formulario.

## Cuánto cuesta
n8n auto-alojado 0 €, Google Forms, Sheets, Drive y Gmail gratis con cuenta personal (15 GB).
Si quieres firma electrónica con validez reforzada, Signaturit o Docusign desde unos 10-25 €/mes; para consentimiento sanitario básico la casilla más el registro suele bastar, consúltalo con tu asesor.
