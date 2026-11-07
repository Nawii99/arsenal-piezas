# Presupuesto automático: formulario, PDF y seguimiento del co…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

El cliente rellena formulario, tú recibes PDF del presupuesto por email, se guarda en una hoja y te avisa si no contesta.

## Qué es y qué hace

Es una receta de n8n: el cliente rellena un formulario, n8n rellena una plantilla de Google Docs con los datos y tus condiciones fijas, la exporta a PDF y la envía por Gmail, la apunta en una hoja con estado Enviado y te avisa si lleva siete días sin respuesta. Entra el formulario; sale un presupuesto en PDF y un seguimiento.

## Cómo usarla

1. Crea la plantilla en Google Docs y el formulario
2. Conecta Gmail y Sheets en n8n
3. Prueba con un presupuesto ficticio
4. Que lo revise un profesional

## Cuándo usarla

Montas cada presupuesto a mano y luego se te olvida hacer seguimiento al que no contesta. Este flujo lo hace desde un formulario y te avisa a los 7 días.

## Cómo ganar dinero con ella

Móntalo a medida para pequeños negocios que presupuestan a menudo, como reformas, estudios de diseño o instaladores: cobras la instalación con su plantilla y una cuota de mantenimiento de [TU PRECIO]. El IVA y las condiciones de la plantilla los revisa su gestor.

- Montaje de presupuestos automáticos para autónomos con muchos encargos, por instalación…
- Seguimiento de presupuestos pendientes para pymes, por mes…
- Plantillas de presupuesto por sector para una gestoría, por lote…

**Precio orientativo:** 150–300 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

# Presupuesto automático: del formulario al PDF y al recordatorio

## Qué hace

1. El cliente rellena un formulario con lo que necesita.
2. n8n rellena una plantilla de Google Docs con esos datos y tus condiciones fijas.
3. Lo exporta a PDF y se lo envía al cliente por Gmail, con copia a ti.
4. Apunta el presupuesto en una hoja de Google Sheets con estado 'Enviado'.
5. Cada mañana mira la hoja y, si un presupuesto lleva 7 días en 'Enviado', te manda un aviso para que hagas seguimiento.

No calcula precios solos: el precio lo pones tú en la plantilla o se lo pides al cliente como campo. Un presupuesto automático con precio calculado a ciegas es la forma más rápida de comprometerte a un trabajo por menos de lo que cuesta.

## Cuentas que hacen falta y lo que cuesta

- **n8n**: instalado en tu ordenador o servidor es gratis. n8n Cloud tiene prueba gratis y luego cuota mensual: [comprueba precio actual en n8n.io].
- **Tally** (formulario): plan gratis con formularios ilimitados y respuestas ilimitadas en el momento de escribir esto; [comprueba límites actuales]. Alternativa: Google Forms, también gratis.
- **Google Docs, Drive, Sheets y Gmail**: una cuenta de Google normal, gratis. Gmail gratis permite unos 500 envíos al día, de sobra.
- No hacen falta herramientas de pago para PDF: Google Drive exporta el documento a PDF.

## Antes de tocar n8n

1. Crea el formulario en Tally con estos campos: Nombre, Email, Empresa (opcional), Qué necesitas (texto largo), Fecha límite, Presupuesto orientativo (opcional). Activa en Tally la integración 'Webhook'.
2. Crea la plantilla en Google Docs. Escribe tu presupuesto completo (usa el comando /presupuesto-condiciones si lo tienes) y donde vayan los datos del cliente pon marcadores así: {{nombre}}, {{empresa}}, {{descripcion}}, {{fecha}}, {{numero}}. Las condiciones (pago, cambios, cancelación, validez) van fijas en la plantilla.
3. Crea una hoja de Google Sheets llamada 'Presupuestos' con estas columnas en la fila 1: Numero, Fecha, Nombre, Email, Empresa, Descripcion, Estado, Enlace PDF.
4. Crea una carpeta en Drive llamada 'Presupuestos enviados'.

## Flujo 1: enviar el presupuesto

Nodo por nodo, en este orden:

**1. Webhook** (disparador). Método POST. Copia la URL de producción que te da n8n y pégala en Tally, en Integrations > Webhooks. Manda una respuesta de prueba desde Tally para ver cómo llegan los datos. Pon un signing secret en el webhook de Tally y verifica la firma `Tally-Signature` en un nodo Code.

**2. Set** (renombrar campos). Crea campos limpios: nombre, email, empresa, descripcion, fecha_limite. Cada uno apunta al campo del formulario que corresponda. Aquí añade también: numero, con la expresión {{ 'P-' + $now.format('yyyyMMdd') + '-' + $now.format('HHmm') }}. Da un número único por minuto; si mandas más de un presupuesto por minuto, cambia a segundos.

**3. Google Sheets** > Append row. Hoja 'Presupuestos'. Mapea Numero, Fecha (hoy), Nombre, Email, Empresa, Descripcion y Estado = 'Enviado'. Enlace PDF se rellena más adelante.

**4. Google Docs** > Get. Documento: la plantilla. Esto trae el contenido.

**5. Google Drive** > Copy file. Copia la plantilla a la carpeta 'Presupuestos enviados' con nombre 'Presupuesto {{numero}} - {{nombre}}'. Así nunca tocas la plantilla original.

**6. Google Docs** > Update. Documento: el ID del archivo copiado en el nodo anterior. Acción: Replace text. Añade un reemplazo por marcador: {{nombre}} por el nombre, {{empresa}} por la empresa, {{descripcion}} por la descripción, {{fecha}} por la fecha de hoy, {{numero}} por el número.

**7. Google Drive** > Download. Archivo: el ID de la copia. En opciones, Google File Conversion: Docs a PDF. Esto devuelve el PDF como archivo binario.

**8. Gmail** > Send. Para: el email del cliente. CC: tu email. Asunto: 'Presupuesto {{numero}} - [TU MARCA]'. Cuerpo: 4 líneas: gracias, adjunto el presupuesto, tiene validez de 15 días, responde a este correo con 'acepto' si te encaja. Adjuntos: el binario del nodo 7.

**9. Google Sheets** > Update row. Busca por Numero y rellena Enlace PDF con el enlace de la copia en Drive (webViewLink del nodo 5).

## Flujo 2: recordatorio de seguimiento

**1. Schedule Trigger**. Cada día a las 9:00.

**2. Google Sheets** > Get rows. Hoja 'Presupuestos'. Filtro: Estado igual a 'Enviado'.

**3. Filter**. Condición: la fecha de la fila es anterior a hoy menos 7 días. Expresión: {{ DateTime.fromISO($json.Fecha) < $now.minus({days: 7}) }}.

**4. Gmail** > Send. Para ti. Asunto: 'Seguimiento pendiente: {{ $json.Numero }}'. Cuerpo: nombre, email y descripción del presupuesto, y una frase que diga 'lleva más de 7 días sin respuesta'. Si prefieres el aviso en el móvil, cambia este nodo por Telegram: crea un bot con @BotFather y usa el nodo Telegram > Send message. Es gratis.

**5. Google Sheets** > Update row. Cambia Estado a 'Seguimiento'. Así no te avisa cada día del mismo.

Cuando el cliente acepta o dice que no, cambias tú el Estado a mano en la hoja: 'Aceptado' o 'Rechazado'. No intentes automatizar esa parte leyendo los emails: te equivocarás y perderás un cliente por un 'acepto' mal detectado.

## Cómo probarlo sin liarla

1. Antes de conectar Tally, en el nodo Webhook usa 'Listen for test event' y manda el formulario tú mismo con tu propio email.
2. Ejecuta el flujo nodo a nodo con el botón de ejecutar en cada uno. Mira que la copia en Drive tenga los marcadores sustituidos. Si aparece un {{nombre}} sin sustituir, el nombre del marcador en la plantilla y en el nodo 6 no coinciden exactamente.
3. Comprueba que el PDF abre bien y que las condiciones se leen enteras.
4. Manda tres presupuestos de prueba a tres emails tuyos. Revisa la hoja.
5. Para probar el Flujo 2 sin esperar 7 días, cambia una fecha en la hoja a hace 10 días y ejecuta el flujo a mano.
6. Solo cuando todo eso funcione, activa los dos flujos (botón Active).
7. Borra las filas de prueba de la hoja y los PDFs de prueba de Drive.

## Cómo venderlo como servicio

Lo que cobras no es 'un flujo de n8n', es que un negocio deje de tardar dos días en mandar presupuestos. Formato: montaje a precio cerrado más una cuota mensual pequeña por mantenerlo. Precios: [DEFINE LOS TUYOS]; no los pongo porque dependen de tu zona y de a quién se lo vendas.

Lo que hay que dejar claro por escrito al venderlo:

- Las cuentas (Google, Tally, n8n) van a nombre del cliente, no al tuyo. Si se van, se llevan su automatización. Si las montas a tu nombre, tú eres responsable de sus datos y de sus emails.
- Los datos del formulario son datos personales de sus clientes. Tú, al montarlo y mantenerlo, eres encargado del tratamiento: hace falta un contrato de encargado (art. 28 RGPD) entre tú y tu cliente. Sin eso, ambos estáis expuestos.
- Un presupuesto enviado por este flujo no es una factura. La factura la emite el cliente cuando cobra, con su programa de facturación. No ofrezcas 'facturación automática' con esta receta: los requisitos de Verifactu para programas de facturación [comprueba fecha vigente en la AEAT] no los cumple un flujo de n8n.
- Gmail puede marcar como spam envíos masivos desde una cuenta nueva. Para menos de 20 presupuestos al día no suele pasar. Para más, hace falta un dominio propio con correo configurado, y eso es otro presupuesto.
- Tu servicio de montaje lleva IVA al 21 %.
