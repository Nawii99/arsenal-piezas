# Recordatorio de cita por WhatsApp oficial con registro de consentimiento (n8n)

**Tipo:** Receta de automatización · **Área:** Negocio · **Licencia:** CC BY 4.0

Flujo de n8n que manda por la API oficial de WhatsApp un recordatorio 24 h antes de cada cita, solo si hay consentimiento, lo apunta en una hoja y gestiona las bajas.

## Qué es y qué hace

Flujo de n8n con el nodo oficial WhatsApp Business Cloud. Cada hora lee tu Google Calendar y, 24 horas antes de cada cita, manda una plantilla utility aprobada solo a quien aceptó recordatorios y no pidió la baja. Entran tus citas y tu hoja de consentimientos; salen el recordatorio, una fila por envío con su consentimiento, la baja marcada si responden BAJA y un correo a una persona si algo falla o el cliente escribe. Trae el JSON importable.

## Cómo usarla

1. Crea la hoja con sus dos pestañas
2. Pide la plantilla utility a Meta
3. Importa el JSON y elige tus credenciales
4. Prueba con el número de prueba
5. Que lo revise un profesional

## Cuándo usarla

Si das citas (peluquería, clínica, taller, academia) y hoy las recuerdas a mano o con un bot no oficial. Necesitas la Cloud API de WhatsApp y una plantilla utility aprobada.

## Cómo ganar dinero con ella

Móntaselo a negocios con citas: conectas su calendario y su número oficial, dejas lista la hoja de consentimientos y cobras una revisión mensual de envíos y bajas.


## La receta, paso a paso

QUÉ HACE
Cada hora mira tu Google Calendar. A cada cita que empieza dentro de 24 horas le manda por la API oficial de WhatsApp (Cloud API) una plantilla de recordatorio aprobada como UTILITY.
Antes de enviar, comprueba en tu hoja de consentimientos que esa persona aceptó recibir recordatorios por WhatsApp y que no ha pedido la baja. Si no hay consentimiento, no se envía nada.
Apunta cada intento en la pestaña Envios: qué plantilla, qué categoría, qué consentimiento había y qué pasó.
Si el cliente responde BAJA (o «no me escribáis», «stop»…), lo marca en la hoja y no le vuelve a mandar recordatorios. Le confirma la baja con un mensaje normal, porque al escribir él se abre la ventana de 24 horas.
Si WhatsApp falla, lo reintenta como mucho 2 veces más y, si sigue fallando, te avisa por correo para que llames tú.
Cualquier otro mensaje del cliente te llega por correo para que lo conteste una persona.

QUÉ NECESITAS
- n8n (en la nube o en tu servidor). El JSON se ha montado con los nodos de n8n 2.47.7, la versión publicada el 13-nov-2026.
- Una cuenta de WhatsApp Business Platform con la Cloud API: tu app de Meta, tu cuenta de WhatsApp Business y tu número. Ojo: según Meta, un número que ya se usa en WhatsApp no se puede registrar en la Cloud API sin eliminarlo antes de allí. Para pruebas, Meta te da un número de prueba al seguir su guía de inicio.
- Una plantilla aprobada. Texto propuesto (pásalo antes por el jsonprompt «¿Utility o marketing?»):
  «Hola {{1}}, te recordamos tu cita en [NOMBRE DEL NEGOCIO] el {{2}} a las {{3}}. Si no puedes venir, responde a este mensaje y te damos otra hora. Para no recibir más recordatorios, responde BAJA.»
  Pide la categoría UTILITY. Meta no pone los recordatorios de cita entre sus ejemplos de utility y desde el 9-abr-2025, si cree que es marketing, la aprueba como MARKETING: cuando te la aprueben, mira la categoría en el Administrador de WhatsApp. Si sale MARKETING, no uses este flujo tal cual: necesitas consentimiento de marketing y cambia lo que pagas.
- Google Calendar con tus citas. En la descripción de cada cita escribe una línea «tel: 600 11 22 33» y, si quieres, «nombre: Ana». Sin teléfono no se envía nada.
- Una hoja de Google Sheets con dos pestañas:
  · Consentimientos, con estas columnas en la fila 1: telefono, nombre, optin_recordatorios, fecha_optin, como_se_obtuvo, texto_aceptado, optin_promociones, baja_recordatorios, fecha_baja, canal_baja.
  · Envios, con estas columnas en la fila 1: fecha_registro, event_id, telefono, nombre, cita, plantilla, categoria, consentimiento, resultado, detalle, wamid.
  Pon la columna telefono en formato texto y escribe los números con prefijo y sin espacios: 34600112233.
- Gmail para los avisos a una persona.

CÓMO SE RELLENA LA HOJA DE CONSENTIMIENTOS
Una fila por cliente que acepta. optin_recordatorios: SI. fecha_optin: el día en que aceptó. como_se_obtuvo: mostrador, formulario web, papel firmado… texto_aceptado: el texto exacto que vio, por ejemplo «Quiero recibir por WhatsApp de [NOMBRE DEL NEGOCIO] avisos de mis citas. Puedo darme de baja cuando quiera respondiendo BAJA.» optin_promociones va aparte y este flujo no lo usa nunca.
Meta pide que el consentimiento diga el nombre de tu negocio y deje claro que acepta tus mensajes, y recomienda pedirlo por separado para cada categoría. El RGPD (artículo 7.1) te obliga a poder demostrar ese consentimiento: esta hoja es tu prueba, no la borres.
Si alguien te pide la baja fuera de WhatsApp (en el local, por teléfono), escribe tú SI en baja_recordatorios. La política de WhatsApp obliga a respetar las bajas dentro y fuera de WhatsApp.

CÓMO IMPORTARLO
En n8n: nuevo workflow › menú de los tres puntos › Import from File (o copia el contenido de flujo_n8n y pégalo en el lienzo). El JSON no trae credenciales: las creas tú al abrir cada nodo.
Después de importar, abre estos nodos y elige lo tuyo:
- Citas de dentro de 24 h: tu credencial de Google Calendar y tu calendario.
- Leer consentimientos, Leer envíos, Apuntar envío aceptado, Apuntar error de envío, Apuntar no enviado, Apuntar fallo de entrega y Marcar baja: tu credencial de Google Sheets y tu hoja (Document). La pestaña ya va puesta por nombre.
- Enviar recordatorio (plantilla) y Confirmar baja: tu credencial de WhatsApp (token de acceso e identificador de la cuenta de WhatsApp Business), tu número en Sender Phone Number y, en el primero, tu plantilla en Template (sale como «nombre - idioma»). El valor recordatorio_cita|es_ES que trae es de ejemplo.
- WhatsApp: mensajes y avisos: credencial del disparador de WhatsApp (Client ID y Client Secret de tu app de Meta).
- Los dos nodos de Gmail: tu credencial y tu correo en To (ahora pone tu-correo@ejemplo.com).
- En la configuración del workflow, la zona horaria ya va puesta en Europe/Madrid.

LOS NODOS, EN ORDEN
Parte A, los recordatorios:
1. Cada hora (Schedule Trigger): se activa a cada hora en punto.
2. Citas de dentro de 24 h (Google Calendar › Get Many): trae las citas entre dentro de 24 y dentro de 25 horas, con las repeticiones desplegadas.
3. Preparar citas (Code): descarta eventos cancelados, de día entero y sin teléfono; saca nombre, teléfono, fecha y hora en español.
4. Leer consentimientos (Google Sheets › Get Rows, una sola vez).
5. Leer envíos (Google Sheets › Get Rows, una sola vez): para no mandar dos veces el mismo recordatorio.
6. Decidir envío (Code): solo deja enviar si optin_recordatorios es SI y baja_recordatorios no es SI. Si un teléfono sale varias veces, manda la última fila.
7. ¿Hay consentimiento? (If): sí › enviar; no › Apuntar no enviado.
8. Enviar recordatorio (plantilla) (WhatsApp Business Cloud › Send Template): manda la plantilla con nombre, fecha y hora. Tiene activado Retry On Fail con 3 intentos en total (el primero y 2 reintentos) separados 5 segundos, y On Error › Continue (using error output).
9. Apuntar envío aceptado (Google Sheets › Append): resultado «aceptado por Meta» y el identificador del mensaje (wamid).
10. Apuntar error de envío y Avisar a una persona (envío fallido): si tras 3 intentos sigue fallando, se apunta y te llega un correo.
11. Apuntar no enviado: queda constancia de por qué no se envió.
Parte B, lo que llega de WhatsApp:
12. WhatsApp: mensajes y avisos (WhatsApp Trigger): escucha mensajes, los fallos de entrega (solo el estado failed) y los cambios de categoría de plantillas.
13. Clasificar evento (Code): separa bajas, fallos, mensajes de clientes y avisos de Meta.
14. ¿Es una baja? (If) › Marcar baja (Google Sheets › Append or Update por teléfono) › Confirmar baja (WhatsApp › Send, mensaje de texto dentro de la ventana de 24 horas).
15. ¿Fallo de entrega? (If) › Apuntar fallo de entrega › Avisar a una persona. Si no es fallo (mensaje de un cliente o aviso de Meta), va directo a Avisar a una persona.

CÓMO PROBARLA
Hazlo con el número de prueba de Meta y con tu propio móvil antes de usar clientes reales.
1. Pon tu móvil en Consentimientos con optin_recordatorios SI.
2. Crea una cita que empiece dentro de 24 horas y media, con «tel: tu móvil» en la descripción.
3. Ejecuta la parte A a mano justo después de la hora en punto: te tiene que llegar el recordatorio y aparecer una fila «aceptado por Meta» en Envios.
4. Vuelve a ejecutarla: no debe mandarlo dos veces.
5. Cambia optin_recordatorios a NO y crea otra cita: debe salir «no enviado» y no llegarte nada.
6. Activa el workflow, responde BAJA al recordatorio: debe aparecer SI en baja_recordatorios y llegarte la confirmación.
7. Escribe cualquier otra cosa: te tiene que llegar un correo.

QUÉ PUEDE SALIR MAL
- Las citas que se crean con menos de 24 horas de antelación no reciben recordatorio, y una cita que mueves a otra hora después del envío tampoco recibe uno nuevo si conserva el mismo evento: avisa tú a mano.
- «Aceptado por Meta» no es «entregado». Si luego no se entrega, lo verás como «fallo de entrega» gracias al disparador.
- Un reintento puede duplicar un mensaje si el primer intento llegó a Meta pero la respuesta se perdió. Por eso solo hay 2 reintentos.
- Meta solo deja un webhook por app: un solo disparador de WhatsApp por app de Meta. Si ya usas la app para otra cosa, o si trabajas con un proveedor (BSP) que gestiona tu webhook, la parte B no te sirve tal cual: usa la gestión de bajas de tu proveedor y deja solo la parte A.
- Con la Cloud API directa no tienes una bandeja para contestar en el móvil: los mensajes te llegan por correo y necesitas una herramienta para responderlos dentro de la ventana de 24 horas. Si no la tienes, valora un proveedor con bandeja.
- Desde el 1-oct-2026, las plantillas utility se cobran también dentro de la ventana de servicio, y los mensajes de servicio tienen 1.000 gratis al mes por número. Consulta el precio en la tabla oficial de Meta antes de activarlo; esta receta no da precios.
- Si Meta cambia la categoría de tu plantilla a MARKETING, te llega un correo. Para el flujo hasta revisarlo.
- La comparación de teléfonos falla si en la hoja hay espacios o el número está guardado como número. Formato texto, con prefijo y sin espacios.

LÍMITES Y REVISIÓN HUMANA
- Usa solo la vía oficial: nada de Evolution API, WAHA, Baileys ni programas que vinculan tu número con un QR.
- No sirve para promociones. Este flujo solo manda avisos de citas a quien los aceptó.
- No es asesoría legal: que un profesional revise tu texto de consentimiento y tu cláusula de privacidad.
- Revisa cada mes la pestaña Envios y las bajas. Una persona contesta siempre los mensajes de los clientes.
- No verificado el 13-nov-2026: las tarifas por mensaje en España; si la coexistencia (usar el mismo número en la app y en la API) está disponible en España.
- El JSON se ha comprobado contra el código de n8n 2.47.7 (tipos, versiones y parámetros de cada nodo), pero no se ha importado en un n8n real: impórtalo y prueba con el número de prueba antes de usarlo con clientes.

FUENTES (comprobadas el 13-nov-2026)
- Precios y categorías de WhatsApp: https://developers.facebook.com/documentation/business-messaging/whatsapp/pricing?locale=en_US
- Categorías de plantillas: https://developers.facebook.com/documentation/business-messaging/whatsapp/templates/template-categorization
- Consentimiento: https://developers.facebook.com/documentation/business-messaging/whatsapp/getting-opt-in
- Ventana de 24 horas: https://developers.facebook.com/documentation/business-messaging/whatsapp/messages/send-messages
- Números ya usados en WhatsApp: https://developers.facebook.com/documentation/business-messaging/whatsapp/business-phone-numbers/phone-numbers
- Política de mensajería de WhatsApp Business: https://whatsappbusiness.com/es-la/policy/
- RGPD (artículo 7): https://www.boe.es/buscar/doc.php?id=DOUE-L-2016-80807
- Nodo WhatsApp Business Cloud de n8n: https://docs.n8n.io/integrations/builtin/app-nodes/n8n-nodes-base.whatsapp/
- Disparador de WhatsApp de n8n: https://docs.n8n.io/integrations/builtin/trigger-nodes/n8n-nodes-base.whatsapptrigger/
- Código de los nodos de n8n 2.47.7: https://github.com/n8n-io/n8n/tree/n8n%402.47.7/packages/nodes-base/nodes
