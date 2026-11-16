# n8n: pedir la opinión días después de la entrega, con consentimiento

**Tipo:** Receta de automatización · **Área:** Tienda por internet · **Licencia:** CC BY 4.0

Deja en Gmail, con n8n, el borrador del correo que pide la opinión días tras la entrega, solo a clientes con consentimiento, y apunta las respuestas.

## Qué es y qué hace

Receta de n8n con Google Sheets y Gmail. Entra una hoja de pedidos con fecha de entrega y consentimiento; salen borradores de correo con el enlace de valoración, el pedido marcado como ya solicitado y una hoja de respuestas donde las notas bajas quedan marcadas para atender. No envía nada sola.

## Cómo usarla

1. Prepara la hoja de pedidos y la de respuestas
2. Monta los nodos del flujo A y del B
3. Prueba con tres filas propias
4. Revisa los primeros borradores y actívalo

## Cuándo usarla

Cuando tu tienda vende por encima de lo que puedes escribir a mano y quieres pedir opiniones cada día sin molestar a quien no consintió.

## Cómo ganar dinero con ella

Montas y mantienes el flujo de petición de opiniones para tiendas pequeñas como servicio de automatización, con una cuota por el mantenimiento.


## La receta, paso a paso

QUÉ HACE
Cada día, unos días después de la entrega, busca en una hoja de pedidos a los clientes que aceptaron recibir la petición de opinión y deja en Gmail un BORRADOR de correo con el enlace para valorar. No envía nada: lo revisas y lo envías tú. Después marca el pedido como «pedido ya solicitado» para no repetir. Un segundo flujo apunta las respuestas del formulario y marca las valoraciones bajas para que las atiendas pronto.
Pide la opinión a todos los que consintieron (salvo bajas e incidencias abiertas), no solo a los contentos. No ofrece nada a cambio de una valoración positiva.

QUÉ NECESITAS
Una instancia de n8n (propia o en su servicio de pago; mira los límites en su web).
Una cuenta de Google con Gmail y Google Sheets, conectada desde las credenciales de n8n (no se escribe ninguna clave en el flujo).
Una hoja de cálculo con una pestaña «Pedidos», una fila por pedido y estas columnas: pedido, nombre, email, producto, fecha_entrega (AAAA-MM-DD), consentimiento_opiniones (SI o NO), fecha_consentimiento, incidencia (SI o vacío), baja (SI o vacío), opinion_pedida (vacío al principio).
Otra pestaña «Respuestas» con las columnas: fecha, pedido, nota, comentario, revisar.
Un enlace de valoración: el de tu plataforma de opiniones, o un formulario que escriba en la pestaña «Respuestas». Compruébalo en la ayuda de la plataforma.
Un enlace o dirección de baja para el pie del correo.
Consentimiento: la columna consentimiento_opiniones solo se rellena con un consentimiento real y guardado, con fecha. Escribir solo a quien consintió es la regla prudente de esta receta, no una obligación general: el art. 21.2 de la LSSI prevé una excepción para clientes que facilitaron sus datos en una contratación y productos o servicios similares de la propia empresa. Comprueba la norma vigente sobre comunicaciones comerciales por correo (LSSI, art. 21, en boe.es) y consulta a tu asesor si dudas.

PASOS (FLUJO A: PEDIR LA OPINIÓN)
Nodo 1 · Schedule Trigger. Trigger Interval: Days. Days Between Triggers: 1. Trigger at Hour: 10.
Nodo 2 · Google Sheets. Operation: Get Row(s). Credential: tu cuenta de Google. Document: tu archivo. Sheet: Pedidos. Sin filtros: lee todas las filas.
Nodo 3 · Code; llámalo exactamente «Elegir pedidos a pedir». Mode: Run Once for All Items. Language: JavaScript. Pega este código:
const DIAS = 7;
const hoy = new Date();
hoy.setHours(0, 0, 0, 0);
return $input.all().filter(item => {
  const j = item.json;
  if (j.consentimiento_opiniones !== 'SI') return false;
  if (j.baja === 'SI' || j.incidencia === 'SI') return false;
  if (j.opinion_pedida) return false;
  const f = new Date(String(j.fecha_entrega).slice(0, 10) + 'T00:00:00');
  if (isNaN(f)) return false;
  f.setHours(0, 0, 0, 0);
  const dias = Math.round((hoy - f) / 86400000);
  return dias >= DIAS && dias <= DIAS + 3;
});
Qué hace, línea a línea: DIAS son los días tras la entrega; hoy es la fecha de hoy a las 00:00; se descartan las filas sin consentimiento «SI», las de baja o incidencia y las ya pedidas; se descartan las fechas ilegibles; se calculan los días desde la entrega y se aceptan entre 7 y 10, para no perder a nadie si un día no corrió el flujo. Ajusta DIAS al tipo de producto.
Nodo 4 · Gmail. Resource: Draft. Operation: Create. Credential: tu cuenta de Gmail. Subject: ¿Qué tal tu {{ $json.producto }}? Email Type: Text. Message: «Hola, {{ $json.nombre }}. Tu pedido llegó hace unos días y nos gustaría saber qué tal te ha ido. Tu opinión, sea buena o mala, ayuda a otras personas y a nosotros a mejorar: [TU ENLACE]. Si ha habido algún problema, responde a este correo y lo resolvemos. Para no recibir más correos como este, escribe a [DIRECCIÓN DE BAJA]. [TU FIRMA]». El destinatario, {{ $json.email }}, se pone en el campo de destinatarios del borrador (en Options o similar); si no lo ves, mira la ayuda del nodo Gmail en n8n.
Nodo 5 · Google Sheets. Operation: Update Row. Document y Sheet: los mismos. Column to Match on: pedido. Valores: pedido = {{ $('Elegir pedidos a pedir').item.json.pedido }} y opinion_pedida = {{ $today.toFormat('yyyy-MM-dd') }}. Así el pedido no se vuelve a pedir.

PASOS (FLUJO B: APUNTAR LAS RESPUESTAS)
Nodo 1 · Google Sheets Trigger. Event: Row Added. Sheet: Respuestas. Poll Times: cada hora.
Nodo 2 · IF. Condición numérica: {{ Number($json.nota) }} is less than or equal to 3. Rama true: Google Sheets, Update Row, Column to Match on: pedido, y escribe revisar = SI. Rama false: no hagas nada.
Cada mañana, filtra la pestaña por revisar = SI y responde a mano, en la plataforma o por correo.

CÓMO PROBARLO
Crea tres filas de prueba con tu propio correo: una con consentimiento SI y entrega de hace 7 días, otra con consentimiento NO y otra con incidencia SI. Pulsa Execute Workflow. Debe aparecer UN solo borrador y solo esa fila debe quedar con opinion_pedida rellena. Ejecútalo otra vez: no debe crear nada nuevo. Añade en «Respuestas» una fila con nota 2 y comprueba que queda revisar = SI. Abre el borrador y comprueba enlace y baja antes de enviar nada.

ERRORES TÍPICOS
Las fechas llegan con otro formato: usa AAAA-MM-DD en la hoja.
El nodo Code no devuelve filas: las columnas deben llamarse exactamente igual que en el código.
No se crea ningún borrador y no hay error: revisa que haya filas dentro de la ventana de días.
Se repiten peticiones: falla el nodo de actualización; comprueba la columna de coincidencia.
Llegan correos a quien se dio de baja: apunta la baja en la hoja el mismo día.
No pases al flujo datos de salud, de pago ni documentos de identidad.
Activa el flujo solo después de que una persona haya leído los primeros diez borradores.

NOMBRES QUE DEBES RESPETAR
Las expresiones del flujo buscan estos nodos por su nombre. Si lo montas a mano, ponles exactamente este nombre (en el flujo importable ya lo llevan):
- «Elegir pedidos a pedir»: el nodo Code.
