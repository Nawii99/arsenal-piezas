# Buzón RGPD que no se te olvida…

**Tipo:** Receta de automatización · **Área:** Tienda por internet · **Licencia:** CC BY 4.0

Registra cada solicitud RGPD de un cliente: acceso, supresión, baja. Manda acuse al momento y te avisa cuando quedan 7 días.

## Qué es y qué hace

Automatización de n8n que registra cada solicitud RGPD de un cliente (acceso, supresión, baja), le envía un acuse al momento con la fecha límite y te avisa cuando quedan siete días del plazo de un mes. Usa un correo dedicado, Google Sheets y un nodo de aviso. No resuelve la solicitud ni borra datos: eso lo hace una persona.

## Cómo usarla

1. Crea el correo dedicado y la hoja de registro
2. Conecta Gmail, Sheets y tu aviso en n8n
3. Prueba con una solicitud de ejemplo
4. Que lo revise un profesional

## Cuándo usarla

Un cliente te escribe pidiendo que borres sus datos y no quieres que el mensaje se hunda en la bandeja hasta que venza el mes de plazo.

## Cómo ganar dinero con ella

Instálalo a tiendas y pymes sin nadie pendiente de privacidad: cobras el montaje una vez y un mantenimiento mensual, ambos en [TU PRECIO]. Cada solicitud la resuelve una persona, y si hay dudas, un profesional de protección de datos.

- Buzón de derechos RGPD para tiendas y pymes que no tienen responsable de privacidad.
- Mantenimiento mensual del registro de solicitudes para empresas con muchos clientes.
- Procedimiento de respuesta a derechos RGPD como servicio de cumplimiento para pequeños negocios.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué resuelve

Cuando un cliente te escribe pidiendo que borres sus datos o que le digas qué tienes de él, la ley (RGPD) te da 1 mes para responder. El problema real no es responder: es que el email se pierde en la bandeja y el plazo vence. Esta automatización registra cada solicitud, manda el acuse al momento y te avisa cuando queda una semana.

Importante: la automatización NO resuelve la solicitud ni borra datos de nadie. Eso lo haces tú a mano. Ella solo garantiza que ninguna solicitud se pierda ni venza.

## Qué necesitas

- Una cuenta de Gmail dedicada o un alias tipo privacidad@tudominio (gratis con Gmail; el alias con dominio propio depende de tu proveedor de correo).
- Google Sheets (gratis).
- n8n: gratis si lo tienes instalado tú (self-hosted); la versión en la nube de n8n es de pago tras la prueba, [consulta el precio actual en n8n.io].

## Preparación

1. Crea una hoja de Google Sheets llamada 'Solicitudes RGPD' con estas columnas en la fila 1: Fecha recepción, Email cliente, Asunto, Fecha límite, Estado.
2. Publica el email de privacidad en tu política de privacidad, para que las solicitudes lleguen todas al mismo sitio.

## Flujo 1: registrar y acusar recibo

1. **Gmail Trigger** — Conecta la cuenta de privacidad. Evento: 'Message Received'. Así arranca cada vez que entra un email a ese buzón. Al ser un buzón dedicado, no hace falta filtrar por palabras y no se escapa nada.
2. **Google Sheets (Append Row)** — Añade una fila a 'Solicitudes RGPD' con: Fecha recepción (expresión: {{ $now.format('yyyy-MM-dd') }}), Email cliente (el remitente del trigger), Asunto (el asunto del email), Fecha límite (expresión: {{ $now.plus({ months: 1 }).format('yyyy-MM-dd') }}), Estado: 'Pendiente'.
3. **Gmail (Send)** — Responde al remitente con un acuse de recibo. Texto sugerido: 'Hemos recibido tu solicitud sobre tus datos personales. Te responderemos en el plazo máximo de un mes que marca la normativa. Si necesitamos algo más para identificarte, te lo pediremos por este medio.' No prometas nada más en el acuse.

## Flujo 2: aviso antes de que venza el plazo

1. **Schedule Trigger** — Cada día a las 9:00.
2. **Google Sheets (Get Rows)** — Lee todas las filas de 'Solicitudes RGPD'.
3. **Filter** — Deja pasar solo las filas con Estado 'Pendiente' y Fecha límite a 7 días o menos de hoy.
4. **Gmail (Send)** — Si queda alguna fila, te envía un email a ti con la lista: 'Estas solicitudes RGPD vencen en menos de una semana'. Cuando resuelvas una, cambia tú su Estado a 'Resuelta' en la hoja, para que deje de avisar.

## Cómo probarla sin liarla

1. Activa solo el Flujo 1 y envíate un email desde otra cuenta tuya al buzón de privacidad.
2. Comprueba que aparece la fila en la hoja con la fecha límite bien calculada y que te llega el acuse.
3. Para probar el Flujo 2 sin esperar un mes, edita a mano una fila de prueba y ponle como fecha límite pasado mañana; ejecuta el flujo con 'Execute Workflow' y mira que llegue el aviso. Borra la fila de prueba después.

## Ojo con esto

- El plazo de 1 mes se puede ampliar 2 meses más en casos complejos, pero solo si avisas al cliente dentro del primer mes. Si vas justo, ese aviso también lo escribes tú, no la máquina.
- Antes de dar o borrar datos, verifica que quien escribe es realmente el cliente (por ejemplo, que escriba desde el email con el que compró). No respondas con datos personales a cualquier remitente.
- No conectes nada que borre datos automáticamente. Una supresión mal hecha (por ejemplo, borrar facturas que Hacienda te obliga a conservar) es peor que responder tarde.
