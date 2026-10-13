# Make (make.com): contactos de Facebook e Instagram Lead Ads…

**Tipo:** Receta de automatización · **Área:** Ventas · **Licencia:** CC BY 4.0

Escenario de Make (make.com) que guarda cada contacto de un anuncio de formulario de Facebook o Instagram en Google Sheets, te avisa por Gmail y, si hay email, deja un borrador de primera respuesta.

## Qué es y qué hace

Escenario de Make (make.com) que guarda cada contacto de un anuncio de formulario de Facebook o Instagram en Google Sheets, te avisa por Gmail y, si hay email, deja un borrador de primera respuesta. Entran los leads de Meta; salen una fila en la hoja, un aviso y un borrador que no se envía solo. Pensado para negocios que pagan anuncios.

## Cómo usarla

1. Crea la hoja Leads con sus columnas
2. Conecta Facebook Lead Ads y Gmail en Make
3. Prueba con un lead de prueba y revisa el borrador
4. Que lo revise un profesional

## Cuándo usarla

Úsala si el negocio paga anuncios con formulario instantáneo y los contactos se quedan en Meta o se atienden tarde. También sirve si hoy copias los datos a mano a una hoja.

## Cómo ganar dinero con ella

Cobra [TU PRECIO] por montarla con las cuentas del cliente y dejarla probada.

- Montaje de captación de leads por anuncios para un negocio local que hoy copia los contactos a mano.
- Revisión mensual de la conexión con Meta y de los leads sin atender, con informe para el cliente.
- Ampliación del escenario con respuesta automática a leads fuera de horario, revisada antes de activarse.

**Precio orientativo:** 150–350 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

QUÉ HACE
Cuando alguien rellena el formulario de un anuncio de Facebook o Instagram (Lead Ads), el escenario guarda sus datos en una hoja de Google Sheets.
Te manda un correo de aviso para que contestes pronto.
Si el contacto ha dejado su email, deja además un borrador de primera respuesta en Gmail.
El borrador no se envía solo. Lo lees y lo mandas tú.
QUÉ NECESITAS
Una cuenta de Make (make.com). Mira en su web qué planes hay (también si hay uno gratuito para probar) y cuántas operaciones o créditos incluye el tuyo.
Una página de Facebook con un anuncio de formulario instantáneo (Lead Ads) ya creado, y un usuario con permiso para ver los contactos de esa página.
Una cuenta de Google con Google Sheets y Gmail.
Una hoja nueva de Google Sheets llamada «Leads» con estas columnas en la fila 1: Fecha, Nombre, Email, Teléfono, Origen, Estado, Notas.
LOS MÓDULOS, EN ORDEN
Módulo 1 · Facebook Lead Ads › Watch Leads (si no ves ese nombre exacto, busca el disparador que detecta contactos nuevos de un formulario).
- Connection: pulsa Add, inicia sesión con Facebook y acepta solo los permisos que pida Make. Esa cuenta debe poder ver los contactos de la página.
- Page: elige tu página. Form: elige el formulario del anuncio. Si ves el campo Limit, pon 10.
- Si el módulo tiene un reloj, púlsalo y elige cada cuánto mirar (por ejemplo, cada 15 minutos). Si es instantáneo, se activa solo al llegar el contacto.
- Los campos del formulario (nombre, email, teléfono) salen en el panel de datos con el nombre de cada pregunta. Si aún no los ves, haz antes la prueba de más abajo y vuelve a abrir los módulos siguientes.
Módulo 2 · Tools › Set multiple variables.
- Variable 1. Nombre: fecha. Valor: {{formatDate(now; "DD/MM/YYYY HH:mm"; "Europe/Madrid")}}
- Variable 2. Nombre: email_limpio. Valor: la función lower(trim(...)) con el campo de email del contacto dentro. Arrastra ese campo desde el panel de datos del módulo 1.
Módulo 3 · Google Sheets › Add a Row.
- Connection: tu cuenta de Google. Spreadsheet ID: pulsa «Select from My Drive» y elige la hoja. Sheet name: Leads. Table contains headers: Yes.
- Fecha: la variable fecha. Nombre: el campo del nombre completo. Email: la variable email_limpio. Teléfono: el campo del teléfono.
- Origen: escribe «Facebook/Instagram Lead Ads». Estado: Nuevo. Notas: vacío.
Módulo 4 · Router (Flow Control › Router). Crea dos rutas.
Ruta A, aviso para ti: Gmail › Send an Email. Esta ruta no lleva filtro.
- To: pulsa Add item y escribe tu correo de trabajo. Subject: «Nuevo contacto: » y el nombre.
- Content: nombre, email y teléfono, cada uno en su línea. El contenido admite HTML, así que separa las líneas con <br>. Añade la frase «Si ha dejado email, hay un borrador esperando en Gmail».
Ruta B, borrador para el contacto: Gmail › Create a Draft.
- Pulsa en la línea que sale del Router hacia este módulo, elige «Set up a filter», ponle de nombre «Tiene email» y la condición: el email «Exists».
- To: la variable email_limpio. Subject: «Hemos recibido tu solicitud». Content: «Hola, gracias por escribirnos a [NEGOCIO]. Hemos recibido tu solicitud y te escribimos en cuanto la hayamos revisado. Un saludo, [TU NOMBRE]».
- Es una plantilla: cámbiala por el tono del negocio y no prometas plazos que no puedas cumplir.
CÓMO PROBARLA
Crea UN solo contacto de prueba con la herramienta de pruebas de formularios de anuncio que ofrece Meta (busca «Lead Ads Testing Tool» en Meta for Developers), usando tu propio correo.
En Make pulsa Run once y espera a que el módulo 1 recoja ese contacto.
Comprueba tres cosas: una fila nueva en la hoja, un correo de aviso en tu bandeja y un borrador nuevo en Gmail.
Escribe PRUEBA en la columna Notas de esa fila para no confundirla con un cliente real.
Si todo está bien, activa el interruptor Scheduling (abajo a la izquierda) y pulsa Save.
CUÁNTO CUESTA
Cada módulo que se ejecuta puede gastar operaciones o créditos de tu plan. Con este diseño, un contacto pasa por unos 5 módulos.
Tras la prueba, mira en el historial cuánto ha contado Make y calcula cuántos contactos esperas al mes. Mira en su web cuántas operaciones o créditos incluye tu plan.
Los anuncios de Meta se pagan aparte.
QUÉ NO HACER
No uses los datos para nada distinto de lo que decía el formulario. Son datos personales: finalidad clara, solo lo necesario y enlace al aviso de privacidad en el formulario.
No cambies el borrador por un envío automático ni lo conviertas en mensajes masivos.
No pidas la contraseña de Facebook al cliente. Que conecte él su cuenta en Make o que te dé acceso a la página desde Meta con el permiso justo.
No compartas la hoja con «cualquier persona con el enlace». Da acceso solo a quien trabaje esos contactos.
No dejes los contactos en la hoja para siempre. Define cuánto tiempo los conservas y bórralos cuando ya no hagan falta.
QUÉ REVISAR A MANO ANTES DE ACTIVARLA
Que el formulario del anuncio incluye el enlace a la política de privacidad.
Que las columnas de la hoja tienen esos nombres y ese orden.
Que el correo de aviso no cae en spam.
Que una persona del negocio lee cada borrador antes de enviarlo.
Que el escenario no detecta duplicados: si alguien rellena el formulario dos veces, saldrá dos veces. Límpialo tú en la hoja.
Que el permiso de Meta sigue vigente. Si la conexión caduca, el escenario deja de recibir contactos y Make muestra un error en el historial.
Que el negocio sabe que Make, Google y Meta tratan estos datos. Mira en su web cuánto tiempo guarda Make el historial de ejecuciones y qué acuerdo de tratamiento de datos ofrece.
