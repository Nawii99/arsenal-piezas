# Make (make.com): de formulario de Google Forms a presupuesto…

**Tipo:** Receta de automatización · **Área:** Documentos · **Licencia:** CC BY 4.0

Escenario de Make (make.com) que convierte cada respuesta de un Google Form de presupuesto en un documento de Google Docs desde tu plantilla, lo pasa a PDF, busca el precio en una hoja de tarifas y deja un borrador en Gmail.

## Qué es y qué hace

Escenario de Make (make.com) que convierte cada respuesta de un Google Form de presupuesto en un documento de Google Docs desde tu plantilla, lo pasa a PDF, busca el precio en una hoja de tarifas y deja un borrador en Gmail. Entran las respuestas del formulario y las tarifas; salen el PDF, un borrador y un aviso. Nada se envía al cliente sin tu revisión.

## Cómo usarla

1. Crea el formulario, la plantilla y la hoja Tarifas
2. Conecta Forms, Docs, Drive y Gmail en Make
3. Genera un presupuesto de prueba y compara importes
4. Que lo revise un profesional

## Cuándo usarla

Úsala si pides presupuestos por formulario y rehaces el mismo documento cada vez, cambiando solo el nombre, el servicio y el precio.

## Cómo ganar dinero con ella

Cobra [TU PRECIO] por montar el formulario, la plantilla y el escenario. Ofrece [TU PRECIO] al mes por mantener las tarifas al día y revisar los presupuestos generados.

- Presupuestos automáticos para reformas, diseño o servicios con tarifas cerradas y revisión final.
- Mantenimiento mensual de tarifas y plantillas, con comprobación de que importes e IVA están bien.
- Formulario y plantilla de propuesta para una agencia pequeña que pide presupuestos por web.

**Precio orientativo:** 200–400 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

QUÉ HACE
Cuando alguien rellena tu formulario de solicitud de presupuesto, el escenario crea un documento de Google Docs desde tu plantilla.
Busca el precio del servicio en una hoja de tarifas, lo pasa a PDF y deja un borrador en Gmail con el PDF adjunto.
También te avisa con un correo con el enlace al documento. Nada se envía al cliente sin que lo hagas tú.
QUÉ NECESITAS
Una cuenta de Make (make.com). Mira en su web cuántas operaciones o créditos incluye tu plan.
Una cuenta de Google con Forms, Docs, Sheets, Drive y Gmail.
Un Google Form con estas preguntas: Nombre, Email, Servicio (lista desplegable), Descripción de lo que necesita.
Una hoja «Tarifas» con las columnas Servicio, Precio sin IVA, IVA %, Total con IVA. Calcula el Total dentro de la hoja con tus fórmulas. Los nombres de Servicio deben ser idénticos a las opciones del formulario.
El tipo de IVA de cada servicio lo defines tú. Confírmalo con tu gestor.
Una plantilla de Google Docs con marcadores como {{nombre}}, {{servicio}}, {{descripcion}}, {{total}}, {{numero}}, {{fecha}} y {{validez}}.
Una carpeta de Drive llamada «Presupuestos», privada.
LOS MÓDULOS, EN ORDEN
Módulo 1 · Google Forms › Watch Responses.
- Connection: tu cuenta de Google. Form: elige el formulario. Limit: 10.
- Cada respuesta saldrá con el texto de cada pregunta como nombre de campo. Si aún no los ves, haz antes la prueba de más abajo y vuelve a abrir los módulos siguientes.
Módulo 2 · Google Sheets › Search Rows (o Search Rows (Advanced)).
- Spreadsheet ID: la hoja de tarifas. Sheet name: Tarifas. Table contains headers: Yes.
- Filter: columna Servicio, Equal to, la respuesta «Servicio» del módulo 1. Maximum number of returned rows: 1.
- Si el servicio no coincide con ninguna fila de la hoja, Make se para aquí y no crea nada. Mira el historial si un formulario no genera presupuesto.
Módulo 3 · Tools › Set multiple variables.
- numero: {{formatDate(now; "YYYYMMDD-HHmmss"; "Europe/Madrid")}} Es una referencia, no una numeración correlativa. Si necesitas una serie correlativa, llévala tú.
- fecha: {{formatDate(now; "DD/MM/YYYY"; "Europe/Madrid")}}
- validez: {{formatDate(addDays(now; 30); "DD/MM/YYYY"; "Europe/Madrid")}} Cambia el 30 por los días que quieras.
Módulo 4 · Google Docs › Create a Document from a Template.
- Document name: «Presupuesto » y la variable numero, un guion y el nombre del cliente.
- New document's location: «Select from My Drive» y la carpeta Presupuestos. Template document: tu plantilla.
- Values: añade un elemento por marcador. Cada uno lleva el marcador y su valor: el campo del formulario o de la hoja de tarifas que corresponda. En total pon el campo «Total con IVA» del módulo 2. Mira en la ayuda del módulo si el marcador se escribe con o sin llaves dobles; la prueba te dirá si ha funcionado.
Módulo 5 · Descarga en PDF. Usa Google Docs › Download a Document con el formato PDF, o Google Drive › Download a File con la opción de convertir a PDF, según lo que te ofrezca Make.
- Document ID o File ID: el ID del documento creado en el módulo 4.
Módulo 6 · Gmail › Create a Draft.
- To: pulsa Add item y arrastra el email del formulario. Subject: «Presupuesto » y la variable numero.
- Content: «Hola [nombre]. Te adjunto el presupuesto que nos has pedido. Tiene validez hasta el [validez]. Si tienes dudas, escríbeme. Un saludo, [TU NOMBRE]».
- Attachments: añade un adjunto. En el nombre pon el del PDF, que debe acabar en .pdf, y en Data pon los datos del PDF del módulo 5.
Módulo 7 · Gmail › Send an Email.
- To: tu correo. Subject: «Presupuesto nuevo para revisar». Content: nombre del cliente, servicio y enlace al documento de Drive. Si el módulo 4 no te da el enlace, escribe https://docs.google.com/document/d/ y detrás el ID del documento.
CÓMO PROBARLA
Rellena el formulario UNA vez con datos inventados y tu propio correo.
Pulsa Run once. Abre el documento creado y comprueba que ningún marcador se ha quedado sin rellenar.
Abre el PDF del borrador. Mira el importe, el IVA y la fecha de validez.
Prueba también con cada servicio de la lista, para ver que todos encuentran su precio.
Cuando esté bien, activa Scheduling y pulsa Save.
CUÁNTO CUESTA
Cada respuesta del formulario pasa por 7 módulos, es decir, unas 7 operaciones o créditos. Compruébalo en el historial tras la prueba.
Mira en su web cuántas operaciones o créditos incluye tu plan y calcula cuántos presupuestos esperas al mes.
QUÉ NO HACER
No envíes el PDF sin que una persona haya revisado importes, IVA, condiciones y datos del cliente.
No metas cláusulas legales sin que las haya mirado tu gestor o abogado. Un presupuesto no es asesoramiento legal ni fiscal.
No pidas en el formulario DNI ni datos bancarios si no hacen falta.
No compartas la carpeta Presupuestos con «cualquier persona con el enlace».
QUÉ REVISAR A MANO ANTES DE ACTIVARLA
Que las tarifas están al día y que los servicios de la hoja coinciden con el formulario.
Que el IVA y las condiciones de pago son correctos para ese servicio. Que lo confirme tu gestor.
Que el formulario enlaza la política de privacidad.
Que los casos especiales (descuentos, varios servicios) los resuelves tú a mano.
Que los documentos de la carpeta con datos de clientes se borran cuando ya no hagan falta. Mira también en su web cuánto tiempo guarda Make el historial de ejecuciones.
