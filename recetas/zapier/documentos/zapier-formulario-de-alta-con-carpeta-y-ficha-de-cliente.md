# Zapier: formulario de alta con carpeta y ficha de cliente…

**Tipo:** Receta de automatización · **Área:** Documentos · **Licencia:** CC BY 4.0

Un Zap de Zapier que, cuando alguien envía un Google Form, crea su carpeta en Drive, lo apunta en Google Sheets y le manda por Gmail un acuse de recibo.

## Qué es y qué hace

Zap de Zapier que, cuando alguien envía tu Google Form de alta, crea una carpeta con su nombre en Drive, apunta sus datos en una hoja Clientes y le manda un correo de acuse de recibo. Entran las respuestas del formulario con la casilla de privacidad; salen carpeta, fila y correo. Requiere que la carpeta sea privada y que la política esté aceptada.

## Cómo usarla

1. Crea el formulario con casilla de privacidad y la carpeta privada en Drive
2. Crea la hoja Clientes
3. Conecta Forms, Drive, Sheets y Gmail en Zapier
4. Que lo revise un profesional

## Cuándo usarla

Cuando captas clientes nuevos con un formulario y luego pasas tiempo creando a mano carpetas, fichas y correos de confirmación.

## Cómo ganar dinero con ella

Móntala a estudios, gestorías y consultoras: [TU PRECIO] de montaje y [TU PRECIO] al mes por mantener formulario, carpetas y la revisión de permisos.

- Alta de clientes para estudios, gestorías o consultoras, con carpeta y ficha creadas sin tareas manuales.
- Revisión trimestral de permisos de carpetas y de la política de privacidad del formulario.
- Correo de bienvenida y checklist de documentos para cada cliente nuevo.

**Precio orientativo:** 200–400 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

RECETA DE ZAPIER: formulario de alta con carpeta y ficha de cliente
QUÉ HACE
Cuando alguien envía tu formulario de Google Forms, el Zap crea una carpeta con su nombre en Drive.
Apunta sus datos en una hoja de Google Sheets y le manda un correo de acuse de recibo.
QUÉ NECESITAS
Una cuenta de Zapier.
Una cuenta de Google con Google Forms, Google Drive, Google Sheets y Gmail.
Un formulario con estas preguntas: Nombre o empresa, Email (obligatorio y con validación de correo), Teléfono (opcional), Servicio que necesitas y una casilla obligatoria de aceptación de la política de privacidad con su enlace.
Una carpeta de Drive llamada Clientes, privada.
Una hoja llamada Clientes con las columnas Fecha alta, Nombre, Email, Teléfono, Servicio, Carpeta, Estado y Política aceptada.
PASOS (un Trigger y varias Action, en este orden)
Paso 1 · Trigger · Google Forms · New Form Response
- Form: elige tu formulario. Si Zapier te pide instalar un complemento o dar un permiso, sigue sus instrucciones.
- Si no encuentras este disparador, usa Google Sheets · New Spreadsheet Row sobre la hoja donde se guardan las respuestas del formulario.
- Pulsa Test trigger y elige una respuesta de prueba.
Paso 2 · Action · Filter by Zapier · Only continue if
- Condición: la respuesta de la casilla de privacidad, (Text) Exists. Mira en Test qué texto devuelve la casilla marcada.
- Si no la marcan, el Zap se detiene.
Paso 3 · Action · Formatter by Zapier · Text
- Transform: Titlecase.
- Input: el campo Nombre o empresa del Paso 1.
- Titlecase puede estropear siglas y apellidos (S.L., de la Fuente, McDonald). Mira el resultado en Test. Si no te gusta, salta este paso y usa el nombre tal cual.
Paso 4 · Action · Google Drive · Create Folder
- Folder Name: Cliente, un guion y el resultado del Paso 3.
- Parent Folder: la carpeta Clientes.
- Si ves campos para compartir la carpeta, déjalos vacíos.
Paso 5 · Action · Google Sheets · Create Spreadsheet Row
- Drive, Spreadsheet y Worksheet: tu hoja Clientes.
- Fecha alta: la fecha de envío del formulario. Nombre: el resultado del Paso 3.
- Email, Teléfono y Servicio: sus campos del Paso 1.
- Carpeta: el enlace de la carpeta creada en el Paso 4. Mira en Test cómo se llama el campo.
- Estado: escribe Nuevo. Política aceptada: escribe Sí.
Paso 6 · Action · Gmail · Send Email
- To: el email de la persona (Paso 1).
- Subject: Hemos recibido tu solicitud.
- Body: gracias, confirmación de que has recibido la solicitud, el enlace a tu política de privacidad y que le escribirás en un plazo que de verdad puedas cumplir.
- No repitas en el correo los datos de la solicitud ni adjuntes datos de otras personas.
CÓMO PROBARLA
Rellena tú el formulario UNA vez con datos ficticios y tu propio correo.
Haz Test en cada paso.
Comprueba que se crea UNA carpeta, que está dentro de Clientes y que nadie más tiene acceso.
Comprueba que la hoja tiene UNA fila y que el correo te llega.
Rellena el formulario sin marcar la casilla de privacidad y comprueba que el Zap se detiene.
Borra la carpeta y la fila de prueba antes de activar el Zap.
CUÁNTO CUESTA
Mira en la web de Zapier si hay plan gratuito para probar, cuántas tareas incluye tu plan y qué pasos cuentan como tarea.
Cada alta ejecuta varios pasos (carpeta, fila y correo). Calcula cuántas altas esperas al mes y compáralo con el límite de tu plan.
QUÉ NO HACER
No pidas en el formulario más datos de los que necesitas. Evita DNI, datos de salud, ideología o cualquier dato especialmente protegido.
No compartas la carpeta Clientes ni sus subcarpetas con enlace público.
No uses estos datos para mandar promociones. El acuse de recibo solo confirma la solicitud.
Cualquiera puede escribir un correo ajeno en el formulario. Por eso el acuse no lleva datos de la solicitud.
No conectes cuentas de otras personas sin permiso por escrito. No pidas ni guardes su contraseña.
QUÉ REVISAR A MANO ANTES DE ACTIVARLA
Que el formulario enseña quién eres, para qué usarás los datos y dónde ejercer sus derechos. Si dudas de cómo redactarlo, consúltalo con un profesional.
Que la base legal de tratar esos datos (por ejemplo, atender su solicitud) está clara. Una casilla marcada no la resuelve por sí sola. Consúltalo con un profesional.
Quién tiene acceso a la carpeta Clientes y a la hoja.
Cuánto tiempo guardarás los datos y quién los borra después. Decídelo antes de empezar.
Si alguien pide borrar sus datos, quítalos de la carpeta, de la hoja y de Gmail.
Zapier recibe esos datos para trabajar con ellos. Mira en su web su acuerdo de tratamiento de datos.
Que el plazo que prometes en el correo lo puedes cumplir.
Mira de vez en cuando la hoja por si alguien envió el formulario dos veces: el Zap no comprueba duplicados.
