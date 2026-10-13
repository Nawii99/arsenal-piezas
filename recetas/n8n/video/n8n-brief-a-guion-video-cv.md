# n8n: del formulario de brief al borrador de guion en tu corr…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

El cliente rellena formulario, n8n abre su carpeta en Drive, pide el guion a Claude y te lo manda por correo a revisar.

## Qué es y qué hace

Flujo de n8n en el que el cliente rellena un formulario de brief, n8n crea su carpeta en Google Drive, pide el guion a Claude con el prompt de guion y te envía por correo el borrador con el enlace a la carpeta. Tú revisas antes de enviar nada al cliente. Ahorra crear carpetas y arrancar guiones a mano.

## Cómo usarla

1. Crea el formulario de brief
2. Configura la carpeta en Drive
3. Prueba con un brief de ejemplo
4. Revisa cada borrador antes de enviarlo

## Cuándo usarla

Cuando ya llevas más de dos o tres encargos al mes y pierdes tiempo creando carpetas y arrancando guiones a mano.

## Cómo ganar dinero con ella

Ordena el servicio de vídeo currículum: el cliente rellena un formulario y tú recibes brief, carpeta y primer borrador. Cobras el pack, no la automatización, y lees el guion antes de enviárselo.

- Gestión de encargos de vídeo currículum con carpeta y borrador automáticos…
- Instalación para estudios de vídeo pequeños que gestionan muchos clientes…
- Cuota mensual de mantenimiento del flujo de brief y guion…

**Precio orientativo:** 100–250 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# n8n: del formulario de brief al borrador de guion

Qué hace: el cliente rellena un formulario, n8n crea su carpeta en Drive, manda el brief a Claude con el prompt de guion, y te llega un correo con el borrador y el enlace a la carpeta. Tú revisas y decides si se lo envías al cliente. El guion no le llega al cliente sin que tú lo hayas leído.

## Cuentas que hacen falta

- **n8n**: gratis si lo instalas en tu ordenador o en un servidor propio. La versión en la nube de n8n tiene prueba gratuita y después es de pago; consulta el precio actual en su web.
- **Formulario**: el nodo n8n Form Trigger, que viene incluido y no necesita cuenta externa. Si prefieres Tally o Google Forms, el disparador cambia a Webhook.
- **Google Drive**: cuenta de Google normal con sus 15 GB gratuitos (compartidos con Gmail y Fotos). Los vídeos del cliente llenan eso rápido; para más espacio hay que pagar.
- **Anthropic API** (Claude): se paga por uso, no hay plan gratuito. Un guion cuesta céntimos, pero pon un límite de gasto en la consola de Anthropic el primer día.
- **Gmail**: para enviarte el correo a ti. Sin coste.

## Nodos, en orden

1. **n8n Form Trigger** (disparador). Campos: nombre, correo, teléfono, tipo de vídeo (desplegable: vídeo currículum / presentación profesional), puesto u oferta a la que va, plataforma (desplegable), tres logros con datos (tres campos de texto largo), por qué tú y no otro (texto largo), enlace a LinkedIn o CV en PDF (campo de archivo), pack contratado (desplegable). Marca como obligatorios todos menos el teléfono. Pon al pie del formulario una frase de consentimiento: para qué usas sus datos, cuánto tiempo los guardas y cómo pedir que los borres. Es obligatorio por protección de datos y evita un disgusto.
2. **Google Drive: Create Folder**. Nombre de carpeta: `{{ $json.nombre }} - {{ $now.format('yyyy-MM-dd') }}`. Dentro de una carpeta madre llamada `Clientes video CV` que creas a mano antes.
3. **Google Drive: Upload File** (solo si el cliente ha subido el CV). Sube el archivo del formulario a la carpeta recién creada. Si no hay archivo, este nodo se salta con un nodo **IF** delante que compruebe si el campo existe.
4. **Google Drive: Share** sobre la carpeta. Permiso de editor para el correo del cliente, para que después suba las tomas ahí. Quita el acceso cuando entregues.
5. **HTTP Request** a la API de Anthropic (o el nodo de Anthropic si tu versión de n8n lo trae). Método POST, cabecera con tu clave de API. En el cuerpo del mensaje pega el texto del comando `/guion-video-cv` de este arsenal como instrucción del sistema, y en el mensaje del usuario mete los campos del formulario uno por línea con su etiqueta. Pide la respuesta en Markdown.
6. **Google Drive: Upload File**. Guarda la respuesta de Claude como `guion-borrador-v1.md` en la carpeta del cliente. Así queda un histórico aunque el correo se pierda.
7. **Gmail: Send**. Destinatario: tú. Asunto: `Nuevo encargo video CV: {{ nombre }} ({{ pack }})`. Cuerpo: enlace a la carpeta, resumen del brief y el guion completo. Tú lo lees y decides.
8. **Gmail: Send** al cliente, solo con acuse de recibo: le confirmas que has recibido el brief, cuándo tendrá el guion y cómo pagar la señal. Sin guion. El guion se lo mandas tú a mano cuando lo hayas revisado.

## Riesgos que hay que saber

- La carpeta compartida contiene imagen y datos personales del cliente. Si pierdes el acceso a tu cuenta de Google o la compartes con quien no toca, el problema es tuyo. Activa la verificación en dos pasos.
- Si Claude se inventa un dato porque el brief venía flojo, lo firmas tú. El paso 7 existe para eso: nunca quites la revisión manual.
- Si el formulario lo publicas en tu web, te llegarán pruebas y basura. Añade un campo de texto que pregunte algo que solo un cliente real contesta (por ejemplo, la oferta concreta) y filtra con un nodo IF si viene vacío.

## Cómo probarla sin liarla

1. Antes de conectar Anthropic, ejecuta solo los nodos 1 a 4 con tus propios datos y comprueba que la carpeta aparece en Drive con el nombre correcto.
2. Conecta el nodo 5 con un límite de gasto puesto en la consola de Anthropic y lanza una sola ejecución con un brief inventado que diga claramente `PRUEBA` en el nombre.
3. Lee el guion que llega al correo. Si tiene datos que no estaban en el brief, arregla el prompt antes de seguir: es más fácil ahora que con un cliente delante.
4. Deja el nodo 8 (correo al cliente) desactivado hasta que hayas hecho dos encargos reales con el resto del flujo. Ese correo es el único que ve el cliente y no se puede deshacer.
5. Borra la carpeta de prueba de Drive al terminar.
