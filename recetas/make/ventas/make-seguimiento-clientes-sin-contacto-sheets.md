# Make (make.com): lista semanal de clientes sin contacto reci…

**Tipo:** Receta de automatización · **Área:** Ventas · **Licencia:** CC BY 4.0

Un escenario de Make (make.com) que cada lunes revisa tu hoja de clientes y te envía por correo la lista de los que llevan 60 días o más sin contacto, para que decidas a quién escribir.

## Qué es y qué hace

Escenario de Make (make.com) que cada lunes lee tu hoja de clientes de Google Sheets y te envía un correo con la lista de los activos sin contacto desde hace 60 días o más, con empresa, días sin contacto y siguiente paso. Entran las filas de clientes; salen un correo con la lista. No escribe a ningún cliente: decides tú.

## Cómo usarla

1. Crea la hoja Clientes con sus columnas y fórmulas
2. Conecta Google Sheets y Gmail en Make
3. Revisa la lista del primer lunes con el cliente
4. Que lo revise un profesional

## Cuándo usarla

Úsala si llevas los clientes en una hoja y se te olvida retomar el contacto con los que dejaste de ver, sin necesidad de un programa de gestión de clientes.

## Cómo ganar dinero con ella

Cobra [TU PRECIO] por montar la hoja de clientes y el escenario. Ofrece [TU PRECIO] al mes por ajustar los días de aviso y revisar la lista con el cliente.

- Retoma de clientes para despachos o estudios que pierden contactos de antiguos clientes.
- Seguimiento mensual de la cartera con informe de bajas, pausados y clientes sin consentimiento.
- Hoja de clientes sencilla para autónomos que no quieren pagar un CRM completo.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

QUÉ HACE
Cada lunes, el escenario lee tu hoja de clientes y busca los que están activos y llevan 60 días o más sin contacto.
Te manda UN correo con la lista, cada cliente con su empresa, los días sin contacto y el siguiente paso que apuntaste.
No escribe a ningún cliente. Eres tú quien decide a quién contactar y cómo.
QUÉ NECESITAS
Una cuenta de Make (make.com). Mira en su web cuántas operaciones o créditos incluye tu plan.
Una cuenta de Google con Google Sheets y Gmail.
Una hoja llamada «Clientes» con estas columnas, por este orden: Nombre, Empresa, Email, Teléfono, Último contacto, Días sin contacto, Estado, Consentimiento comercial, Siguiente paso.
Último contacto es una fecha de verdad. Estado solo admite «Activo», «Pausado» o «Baja». Consentimiento comercial solo admite «Sí» o «No».
En Días sin contacto pon la fórmula =SI(E2="";"";HOY()-E2) y arrástrala hacia abajo. La hoja calcula el número; Make solo lo lee. Dale a esa columna formato Número, o Sheets puede mostrarla como una fecha. Si tu hoja está en inglés, usa IF y TODAY.
Los clientes sin fecha en Último contacto no salen en la lista: rellénala siempre.
LOS MÓDULOS, EN ORDEN
Programación: pulsa el reloj del primer módulo, en Run scenario elige «Days of the week», marca Monday y pon las 08:30.
Módulo 1 · Google Sheets › Search Rows (o Search Rows (Advanced)).
- Connection: tu cuenta de Google. Spreadsheet ID: «Select from My Drive». Sheet name: Clientes. Table contains headers: Yes.
- Filter: columna Estado, Equal to, Activo. Maximum number of returned rows: un número mayor que tus clientes activos.
Filtro entre el módulo 1 y el 2 (pulsa en la línea que los une y elige «Set up a filter»). Nombre: «60 días o más». Condición: Días sin contacto, operador numérico «Greater than or equal to», 60.
Módulo 2 · Flow Control › Text aggregator (agregador de texto; lo encuentras junto a Iterator y Router).
- Source Module: Google Sheets › Search Rows (el módulo 1).
- Text: [Nombre] ([Empresa]), [Días sin contacto] días. Consentimiento comercial: [Consentimiento comercial]. Siguiente paso: [Siguiente paso]. Cada nombre entre corchetes es un campo que arrastras desde el módulo 1.
- Row separator: como el correo va en HTML, elige «Other» y escribe <br>.
Módulo 3 · Gmail › Send an Email.
- To: pulsa Add item y escribe tu correo. Subject: «Clientes sin contacto reciente: » y la fecha de hoy, {{formatDate(now; "DD/MM/YYYY"; "Europe/Madrid")}}
- Content: «Estos clientes llevan 60 días o más sin contacto:<br>» y, debajo, el campo Text del módulo 2. Si ves la opción Content type, elige HTML.
- Si esa semana ningún cliente cumple la condición, lo normal es que no llegue ningún correo.
Ampliación opcional, solo si quieres: un borrador de Gmail por cada cliente con Consentimiento comercial «Sí».
- Pon un Router justo después del módulo 1, con dos rutas. La ruta 1 lleva el filtro «60 días o más» y después el agregador y el correo. La ruta 2 lleva ese mismo filtro y, además, Consentimiento comercial «Equal to» Sí, y después Gmail › Create a Draft con el email del cliente.
- Texto corto y personal. El borrador no se envía solo. Mientras el cliente siga sin contacto, cada lunes se crearía otro borrador: bórralos o no actives esta ampliación.
CÓMO PROBARLA
Añade DOS clientes de prueba con tu correo, Estado Activo y un Último contacto de hace más de 60 días.
Pulsa Run once. Debería llegar UN correo con los dos nombres en la lista.
Comprueba que los días sin contacto del correo coinciden con la hoja.
Cuando acabes, cambia el Estado de esas filas a «Baja» o márcalas como prueba, y activa Scheduling y Save.
CUÁNTO CUESTA
Cada ejecución gasta una operación en buscar filas, otra por cada cliente que pasa el filtro y 1 más en el correo. Compruébalo en el historial tras la prueba.
Con una ejecución a la semana, el gasto depende del número de clientes. Mira en su web cuántas operaciones o créditos incluye tu plan.
QUÉ NO HACER
No envíes mensajes comerciales a quien no haya dado su consentimiento. Es un dato personal y tiene reglas (RGPD y normas de comunicaciones comerciales).
No envíes mensajes masivos con este escenario. Cada contacto lo decide una persona.
No guardes en la hoja datos que no necesites, como DNI, datos bancarios o de salud. Si no usas el teléfono, no lo guardes.
No compartas la hoja con edición abierta ni la mezcles con listas compradas.
QUÉ REVISAR A MANO ANTES DE ACTIVARLA
Que cada persona de la hoja ha dado su consentimiento o tiene una relación que justifica el contacto, y que sabes cómo atender si pide que la borres.
Que Último contacto se actualiza cada vez que hablas con el cliente.
Que el límite de 60 días tiene sentido para tu negocio. Puedes cambiarlo en el filtro.
Que los clientes de baja o pausados no aparecen en la lista.
Que el correo semanal llega solo a quien debe verlo.
Que el cliente sabe que su lista pasa por Make y Google. Mira en su web cuánto tiempo guarda Make el historial de ejecuciones.
