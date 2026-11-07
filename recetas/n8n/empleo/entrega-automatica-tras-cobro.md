# Entrega automatica tras el cobro…

**Tipo:** Receta de automatización · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

Pagan en Stripe, aparecen solos en Drive, llega email y tú solo facturas y entregas.

## Qué es y qué hace

Receta de n8n que, cuando un cliente paga en Stripe, crea su carpeta en Drive, copia la plantilla del paquete, genera un borrador con IA, envía el email con el formulario de datos y apunta la venta en una hoja para facturar. Entra el pago de Stripe y sale una carpeta, un borrador y un correo de bienvenida. Stripe cobra comisión por cobro, en torno al 1,5 % más 0,25 euros; confirma la tarifa vigente antes de usarla.

## Cómo usarla

1. Crea el producto y el enlace de pago en Stripe
2. Monta el flujo de Drive y la hoja de ventas en n8n
3. Prueba con un pago de prueba
4. Que lo revise un profesional (facturación)

## Cuándo usarla

Cuando ya vendes paquetes y quieres que el alta del cliente, el borrador y el email de bienvenida salgan solos tras el pago.

## Cómo ganar dinero con ella

Te quita 30 minutos de administracion por cliente. Con cuatro ventas al mes ya te paga el tiempo que tardas en montarla.

- Automatización de entrega tras el cobro para autónomos que venden paquetes digitales con Stripe.
- Alta de cliente automatizada para servicios de consultoría que quieren ahorrar 30 minutos por venta.
- Mantenimiento mensual del flujo de cobro y entrega, con revisión de fallos y cambios de plantilla.

**Precio orientativo:** 150–250 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

RECETA n8n: del cobro a la entrega, sin tocar nada

QUE HACE
Cliente paga en Stripe -> n8n crea su carpeta en Drive, copia la plantilla del paquete,
genera un borrador con IA, le manda el email con el formulario de datos, y apunta la
venta en una hoja para que factures. Tu solo revisas y entregas.

CUENTAS QUE HACEN FALTA Y LIMITE GRATUITO
- n8n: gratis si lo autoalojas (n8n Community, Docker). La nube tiene prueba y luego cuota.
- Stripe: sin cuota mensual. Cobra comision por cobro (tarjetas europeas, en torno al
  1,5 por ciento mas 0,25 euros). Confirma la tarifa del dia en stripe.com/es/pricing.
- Google Drive, Docs y Sheets: gratis con los 15 GB de la cuenta de Google.
- Gmail: gratis, limite de 500 envios al dia. Sobra.
- Claude API (opcional, para el borrador): de pago por uso, centimos por cliente.
- Tally o Google Forms para el formulario de datos: gratis.

ANTES DE EMPEZAR
1. En Stripe crea un Producto por paquete y un Enlace de pago para cada uno.
   Apunta el price_id de cada uno: empiezan por price_.
2. En Drive crea la carpeta CLIENTES y dentro una carpeta PLANTILLAS con un Google Doc
   por paquete (plantilla-revision, plantilla-curriculum, plantilla-completa).
3. Crea una hoja de calculo VENTAS con columnas: fecha, nombre, email, NIF, paquete,
   base, IVA, total, num_factura, estado, id_sesion.
4. Monta el formulario de datos (Tally) con: nombre, NIF o DNI, direccion fiscal, puesto
   que busca, enlace a la oferta, y subida del curriculum actual.

NODOS, EN ORDEN

NODO 1 - Disparador: Stripe Trigger
- Credencial: tu clave de API de Stripe (empieza en modo prueba por sk_test_).
- Evento: checkout.session.completed
- Este nodo te da el email, el nombre, el importe y el price_id de lo comprado.

NODO 1b - IF + Google Sheets "Comprobar pago y duplicados"
- El Stripe Trigger ya verifica la firma del webhook.
- IF: sigue solo si payment_status es paid. checkout.session.completed tambien salta
  con metodos de pago diferidos que aun no han cobrado.
- Busca en la hoja VENTAS el id de la sesion (el id del objeto del evento). Si ya
  existe, el flujo se para: Stripe puede enviar el mismo evento mas de una vez y no
  quieres dos carpetas ni dos emails.

NODO 2 - Switch "Que paquete es"
- Modo: Rules. Campo a evaluar: el price_id que llega del nodo 1.
- Una salida por paquete: revision, curriculum, completa, acompanamiento.
- Salida por defecto: manda a un nodo de aviso por email a ti. Si no reconoce el precio,
  no adivina.

NODO 3 - Set "Datos del cliente"
- Crea campos limpios: nombre, email, paquete, base_eur, iva_eur, total_eur, plazo_dias.
- Calcula plazo_dias segun el paquete: 2, 4, 7 o 28 dias habiles.

NODO 4 - Google Drive: Create Folder
- Carpeta padre: CLIENTES.
- Nombre: {{ $json.nombre }} - {{ $json.paquete }} - {{ $now.format('yyyy-MM-dd') }}

NODO 5 - Google Drive: Copy File
- Origen: la plantilla del paquete que salio del Switch.
- Destino: la carpeta que acaba de crear el nodo 4.

NODO 6 - HTTP Request a la API de Claude (opcional pero es donde esta el ahorro)
- Metodo POST, URL de mensajes de la API de Anthropic, clave en una credencial Header Auth de n8n (no la escribas en el nodo: un flujo exportado se la llevaría).
- En el mensaje mete el paquete y los datos que ya tengas y pide el borrador inicial
  del entregable. Es un BORRADOR: no se envia al cliente sin que tu lo leas.

NODO 7 - Google Docs: Update Document
- Pega el texto del nodo 6 dentro del documento copiado en el nodo 5.

NODO 8 - Gmail: Send Message
- Para: el email del cliente.
- Asunto: Ya esta el pago, ahora necesito 5 minutos tuyos
- Cuerpo: gracias, confirma el paquete y el total con IVA, enlace al formulario de datos,
  y una linea clara: "El plazo de X dias habiles empieza cuando me devuelvas esto relleno."
- Anade siempre la frase de honestidad: se entrega el trabajo y las revisiones, no el puesto.

NODO 9 - Google Sheets: Append Row
- Hoja VENTAS. Rellena fecha, nombre, email, paquete, base, IVA, total, id_sesion, estado=PENDIENTE_FACTURA.
- La factura NO la automatices el primer mes. La haces tu o tu gestoria mirando esta hoja.
  Una factura mal numerada te da mas problemas que el tiempo que ahorras.

NODO 10 - Wait + Gmail (recordatorio)
- Wait de 2 dias. Si el formulario sigue sin llegar, segundo email corto de recordatorio.

COMO PROBARLA SIN LIARLA
1. Pon Stripe en modo Prueba (el interruptor Test mode del panel).
2. Usa las claves sk_test_ en la credencial de n8n.
3. Abre tu enlace de pago de prueba y paga con la tarjeta 4242 4242 4242 4242,
   cualquier fecha futura y cualquier CVC. No se mueve dinero real.
4. En el nodo 8, la primera vez pon TU email como destinatario, no el del cliente.
5. Ejecuta el flujo y revisa: carpeta creada, documento copiado, fila en la hoja, email.
6. Cuando funcione tres veces seguidas, cambia a claves reales y al email del cliente.

AVISOS
- Guarda las claves de Stripe y de la API en las credenciales de n8n, nunca escritas
  dentro de un nodo ni en un Set.
- Si el flujo falla a mitad, el cliente ya ha pagado. Configura un Error Workflow que te
  mande un email a ti para que lo remates a mano ese mismo dia.
- Guardas datos personales de clientes (NIF, direccion): informa en tu web de que los
  tratas, para que, y borra las carpetas de clientes cerrados cuando ya no las necesites.
- Automatiza la administracion, no el criterio. El entregable lo revisas tu antes de enviarlo.
