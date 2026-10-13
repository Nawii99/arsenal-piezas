# Del formulario del cliente al contrato listo para firmar…

**Tipo:** Receta de automatización · **Área:** Legal y contratos · **Licencia:** CC BY 4.0

Receta de n8n que genera un contrato desde tu plantilla de Google Docs: el cliente rellena un formulario con sus datos, el flujo sustituye los huecos de nombre, NIF, precio y fechas, y te envía el PDF por email para revisar.

## Qué es y qué hace

Receta de n8n que genera un contrato desde tu plantilla de Google Docs: el cliente rellena un formulario con sus datos, el flujo sustituye los huecos de nombre, NIF, precio y fechas, y te envía el PDF por email para revisar. Evita erratas con datos de otro cliente. Usa un formulario, Google Docs y Gmail.

## Cómo usarla

1. Prepara la plantilla con huecos claros
2. Conecta formulario, Google Docs y Gmail en n8n
3. Prueba con datos ficticios
4. Que lo revise un profesional

## Cuándo usarla

Con cada cliente nuevo cambias a mano nombre, NIF, precio y fechas en la plantilla, y alguna vez se ha colado un dato del cliente anterior.

## Cómo ganar dinero con ella

Instálaselo a freelancers y agencias pequeñas que firman contratos a menudo: cobras el montaje una vez, [TU PRECIO], y si quieres un mantenimiento aparte. La plantilla de contrato tiene que haberla revisado antes un abogado.

- Generación automática de contratos para freelancers que firman muchos clientes al mes.
- Instalación del flujo para agencias pequeñas que contratan con frecuencia.
- Mantenimiento mensual de plantillas de contrato y del flujo de alta de clientes.

**Precio orientativo:** 150–300 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué resuelve

Cada cliente nuevo te obliga a abrir la plantilla del contrato, cambiar a mano nombre, NIF, dirección, precio y fechas, exportar a PDF y mandarlo. Son 20-30 minutos por cliente y es donde más erratas se cuelan (el clásico contrato que llega con el nombre del cliente anterior). Con este flujo, el cliente mete sus datos una vez y el contrato sale montado.

## Qué cuentas hacen falta

- **n8n**: autoalojado gratis, o n8n Cloud de pago (plan gratuito solo de prueba, [consulta el límite actual en n8n.io/pricing]).
- **Tally** (formularios): plan gratuito con formularios y respuestas ilimitadas en lo básico. Vale también Google Forms.
- **Cuenta de Google** (Docs, Drive, Gmail): gratis. En n8n necesitas crear una credencial de Google OAuth, que es el paso más pesado del montaje; sigue la guía oficial de n8n para "Google OAuth2".
- Prepara antes en Google Docs tu plantilla de contrato con huecos escritos así: {{NOMBRE_CLIENTE}}, {{NIF_CLIENTE}}, {{DIRECCION_CLIENTE}}, {{SERVICIO}}, {{PRECIO}}, {{FECHA_INICIO}}. Puedes generar la plantilla con la pieza "Generador de borrador de contrato de colaboración" de este mismo arsenal.

## Nodos, en orden

1. **Webhook** (disparador). Copia la URL de producción del nodo y pégala en Tally: en tu formulario, Integrations, Webhooks. El formulario debe pedir: nombre o razón social, NIF/CIF, dirección, email, servicio contratado, precio acordado y fecha de inicio.
2. **Edit Fields (Set)**. Crea un campo limpio por cada dato del formulario (nombre_cliente, nif_cliente, etc.) mapeando desde el JSON que manda Tally. Así, si un día cambias de formulario, solo tocas este nodo.
3. **Google Drive, operación Copy**. Copia el archivo de tu plantilla de Docs y ponle de nombre: Contrato - {{nombre_cliente}} - {{fecha de hoy}}. Trabajar sobre una copia es lo que evita destrozar la plantilla original.
4. **Google Docs, operación Update**. Sobre el documento recién copiado (usa el ID que devuelve el nodo anterior), añade una acción "Replace All" por cada hueco: busca {{NOMBRE_CLIENTE}} y reemplaza por el campo nombre_cliente, y así con todos.
5. **Google Drive, descarga con conversión a PDF**. Descarga el documento convertido a PDF para adjuntarlo.
6. **Gmail, Send**. Envíatelo A TI, no al cliente, con el PDF adjunto y asunto "Contrato listo para revisar: {{nombre_cliente}}". Tú le echas el último vistazo y lo reenvías. Un contrato con un error enviado automáticamente al cliente queda fatal y es difícil de arreglar.

## La firma a distancia

- En España y en toda la UE la firma electrónica es válida (reglamento eIDAS). Para contratos de servicios del día a día, una firma electrónica simple con evidencias (quién, cuándo, desde dónde) suele bastar; para importes altos, busca firma avanzada o cualificada.
- Usa una plataforma de firma (por ejemplo Docuseal, que tiene versión de código abierto autoalojable gratis, o Signaturit y DocuSign de pago, [consulta precios y límites actuales en sus webs]) y sube ahí el PDF que te llega por email. Cuando domines el flujo, puedes añadir un nodo HTTP Request al final que suba el PDF a la plataforma por API y ahorrarte también ese paso.
- No firméis "respondiendo OK por WhatsApp": puede valer como prueba, pero te complica la vida si hay conflicto. Firma de verdad, aunque sea electrónica simple.

## Cómo probarla sin liarla

1. Crea una plantilla de prueba en Docs con dos huecos y usa esa, no tu contrato real.
2. Rellena el formulario tú mismo con datos inventados y tu propio email como "cliente".
3. Ejecuta el flujo con "Test workflow" en n8n y revisa la salida de cada nodo, uno a uno: el fallo típico es que el Replace All no encuentra el hueco porque en la plantilla está escrito con un espacio de más.
4. Comprueba que el PDF llega a TU email y que ningún hueco se quedó sin sustituir. Solo entonces cambia a la plantilla real y activa el flujo.
5. Deja para siempre el envío dirigido a ti: la revisión humana antes de mandar un contrato no es un paso opcional.
