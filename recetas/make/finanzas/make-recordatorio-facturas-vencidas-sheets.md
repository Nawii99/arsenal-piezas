# Make (make.com): recordatorio de facturas vencidas desde una…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Un escenario de Make (make.com) que cada semana mira tu hoja de facturas, prepara en Gmail un borrador de recordatorio para las vencidas y te avisa de las que llevan 30 días o más.

## Qué es y qué hace

Escenario de Make (make.com) que cada lunes lee tu hoja de facturas de Google Sheets y prepara en Gmail un borrador de recordatorio para las vencidas entre 7 y 29 días. Las de 30 días o más no reciben nada: te llega un aviso para decidir tú. Entran facturas con estado y fecha; salen borradores, marcas en la hoja y un resumen. No envía ni cobra.

## Cómo usarla

1. Crea la hoja Facturas con sus fórmulas
2. Conecta Google Sheets y Gmail en Make
3. Prueba con dos facturas de ejemplo
4. Que lo revise un profesional

## Cuándo usarla

Úsala si llevas las facturas en una hoja y se te pasa reclamar las pendientes o te incomoda hacerlo a mano.

## Cómo ganar dinero con ella

Cobra [TU PRECIO] por montar la hoja de facturas con el escenario. Ofrece [TU PRECIO] al mes por revisar con el cliente la lista semanal y cambiar el texto del aviso.

- Control de cobros para autónomos que llevan facturas en una hoja y olvidan reclamar pagos pendientes.
- Panel de facturas vencidas para una pyme, con revisión semanal de la lista de impagos.
- Plantillas de recordatorio de pago en tres tonos, revisadas con el cliente antes de activar el escenario.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

QUÉ HACE
Cada lunes, el escenario lee tu hoja de facturas. Para cada factura pendiente y vencida hace una de dos cosas, según los días de retraso.
Entre 7 y 29 días de retraso: prepara un borrador amable en Gmail (solo una vez por factura) y apunta en la hoja que el borrador está preparado.
Con 30 días o más: no escribe al cliente. Te manda un correo para que decidas tú qué hacer. Mientras la factura siga pendiente, ese aviso te llegará cada lunes.
QUÉ NECESITAS
Una cuenta de Make (make.com). Mira en su web cuántas operaciones o créditos incluye tu plan.
Una cuenta de Google con Google Sheets y Gmail.
Una hoja llamada «Facturas» con estas columnas en la fila 1, por este orden: Número, Cliente, Email, Importe, Fecha vencimiento, Estado, Borrador preparado, Días de retraso.
Fecha vencimiento debe ser una fecha de verdad. Estado solo admite «Pendiente» o «Cobrada».
En Días de retraso pon una fórmula, por ejemplo =SI(F2="Pendiente";MAX(0;HOY()-E2);0), y arrástrala hacia abajo. Así los cálculos de fechas los hace la hoja y no Make.
Si tu hoja está en inglés, las funciones se llaman IF y TODAY. Dale a esa columna formato Número, o Sheets puede mostrarla como una fecha.
LOS MÓDULOS, EN ORDEN
Programación del escenario: pulsa el reloj del primer módulo, en Run scenario elige «Days of the week», marca Monday y pon las 09:00.
Módulo 1 · Google Sheets › Search Rows (o Search Rows (Advanced), si Make te ofrece esa).
- Connection: tu cuenta de Google. Spreadsheet ID: «Select from My Drive» y la hoja. Sheet name: Facturas. Table contains headers: Yes.
- Filter: columna Estado, operador Equal to, valor Pendiente.
- Maximum number of returned rows: un número mayor que las facturas pendientes que esperas.
- Si la fecha te sale como un número raro, en los ajustes avanzados del módulo elige que devuelva el valor tal como se ve en la hoja (Formatted value / Formatted string).
Filtro entre el módulo 1 y el 2. Nombre: «Vencida (7 días o más)». Condición: Días de retraso, operador numérico «Greater than or equal to», 7.
Módulo 2 · Router (Flow Control › Router). Dos rutas.
Ruta A, entre 7 y 29 días, solo una vez. Filtro, todas las condiciones a la vez: Días de retraso «Less than» 30; Borrador preparado «Does not exist»; Email «Exists». Módulos: Gmail › Create a Draft y después Google Sheets › Update a Row.
- Si «Does not exist» no se comporta bien con celdas vacías en tu prueba, usa «Equal to» con el valor vacío.
- Gmail › Create a Draft. To: pulsa Add item y arrastra el Email de la factura. Subject: «Recordatorio de la factura » y el número.
- Content: «Hola [Cliente]. Te escribo para recordarte que la factura [Número], por [Importe] euros, venció el [Fecha vencimiento]. Si ya la has pagado, ignora este mensaje y disculpa la molestia. Si necesitas que te la reenvíe, dímelo. Un saludo, [TU NOMBRE]». Arrastra cada campo desde el módulo 1. Si la celda de Importe ya lleva el símbolo €, quita la palabra «euros».
- Google Sheets › Update a Row. Spreadsheet y Sheet name: los mismos. Row number: el «Row number» del módulo 1. Borrador preparado: la fecha de hoy, {{formatDate(now; "YYYY-MM-DD"; "Europe/Madrid")}}
- Deja vacíos el resto de campos, sobre todo Días de retraso, que lleva fórmula. Tras la prueba, comprueba que no se ha borrado nada de esa fila.
Ruta B, 30 días o más. Filtro: Días de retraso «Greater than or equal to» 30. Módulo: Gmail › Send an Email.
- To: tu correo. Subject: «Factura con más de 30 días de retraso». Content: número, cliente, importe y días de retraso. Termina con «Decide tú cómo seguir».
CÓMO PROBARLA
Añade a la hoja UNA factura de prueba con tu propio correo, Estado Pendiente y un vencimiento de hace 10 días.
Pulsa Run once. Debería aparecer un borrador en Gmail y la fecha en la columna Borrador preparado de esa fila.
Revisa que el importe y la fecha del borrador coinciden con la hoja.
Para probar la ruta B, cambia el vencimiento de esa fila a hace 40 días y borra Borrador preparado. Debe llegarte un aviso a ti, no un borrador.
Borra el contenido de Borrador preparado en esa fila si quieres repetir la prueba, y cuando acabes marca la factura de prueba como Cobrada.
Si todo va bien, activa Scheduling y pulsa Save.
CUÁNTO CUESTA
Cada ejecución gasta una operación en buscar filas y unas 2 o 3 más por cada factura que pasa el filtro. Compruébalo en el historial tras la prueba.
Con una ejecución a la semana, el gasto depende del número de facturas pendientes. Mira en su web cuántas operaciones o créditos incluye tu plan.
QUÉ NO HACER
No conviertas el borrador en envío automático. Una persona lo lee y lo manda.
No añadas intereses de demora, amenazas ni reclamaciones formales al texto. Eso, con un gestor o abogado.
No metas en el correo el IBAN ni datos que no hagan falta.
No pases por la hoja datos personales de más. Con nombre, email, número e importe basta.
QUÉ REVISAR A MANO ANTES DE ACTIVARLA
Las cifras. Una persona debe comprobar importes, fechas y cliente de cada borrador antes de enviarlo, porque es dinero y es una relación con un cliente.
Que la factura no esté ya cobrada en el banco antes de enviar el recordatorio.
Que la hoja se actualiza cuando entra un pago. Si no, el escenario recordará facturas ya pagadas.
Que el texto respeta el trato que tienes con cada cliente.
Que los casos de impago serio los ve tu gestor o asesor, no el escenario.
Que la hoja solo la ve quien la necesita: lleva nombres y correos de clientes. Mira también en su web cuánto tiempo guarda Make el historial de ejecuciones.
