# Zapier: recordatorio de seguimiento tras un presupuesto…

**Tipo:** Receta de automatización · **Área:** Ventas · **Licencia:** CC BY 4.0

Un Zap de Zapier que, al etiquetar un presupuesto enviado en Gmail, lo apunta en Google Sheets y, pasados unos días sin respuesta, te deja un borrador de seguimiento.

## Qué es y qué hace

Zap de Zapier que, al etiquetar en Gmail un presupuesto enviado, lo anota en Google Sheets con su fecha y, pasados unos días sin respuesta, deja en Borradores un mensaje de seguimiento y te avisa. Entran el correo etiquetado y el plazo; salen una fila y un borrador. No envía nada al cliente: el mensaje lo revisas tú. Requiere Delay by Zapier en tu plan.

## Cómo usarla

1. Crea la etiqueta Presupuesto enviado y la hoja Seguimiento
2. Escribe el texto de seguimiento
3. Conecta Gmail y Sheets en Zapier y prueba con un presupuesto de prueba
4. Que lo revise un profesional

## Cuándo usarla

Cuando envías presupuestos y no vuelves a escribir a quien no contesta, porque se te pasa o no sabes cuándo hacerlo.

## Cómo ganar dinero con ella

Móntala a autónomos y pymes de servicios: [TU PRECIO] de instalación y [TU PRECIO] al mes por mantenerla y ajustar los plazos y plantillas.

- Seguimiento de presupuestos para autónomos o pymes de servicios que pierden ventas por no volver a escribir.
- Revisión mensual de presupuestos pendientes con informe de aceptados y perdidos.
- Plantillas de seguimiento por tipo de servicio para una agencia o estudio pequeño.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

RECETA DE ZAPIER: recordatorio de seguimiento tras un presupuesto
QUÉ HACE
Cuando mandas un presupuesto y le pones una etiqueta en Gmail, el Zap lo apunta en una hoja de seguimiento.
Espera unos días. Si el cliente no ha contestado, deja en Borradores un mensaje de seguimiento y te avisa.
No envía nada al cliente. El mensaje lo revisas y lo mandas tú.
QUÉ NECESITAS
Una cuenta de Zapier. Mira en su web si tu plan incluye Delay by Zapier.
Una cuenta de Gmail.
En Gmail, una etiqueta llamada Presupuesto enviado. La pones tú a mano en cada presupuesto que HAS ENVIADO. Si se la pones a un correo recibido, el seguimiento iría a ti mismo.
Una hoja de Google Sheets llamada Seguimiento con las columnas Fecha envío, Cliente, Asunto, Seguir el, Estado.
Un texto de seguimiento escrito por ti, de tres o cuatro frases.
PASOS (un Trigger y varias Action, en este orden)
Paso 1 · Trigger · Gmail · New Labeled Email
- Label: Presupuesto enviado.
- Pulsa Test trigger y elige un presupuesto de prueba. En Test, fíjate en el campo del destinatario (suele llamarse To) y en el de asunto (Subject).
Paso 2 · Action · Formatter by Zapier · Text
- Transform: Extract Email Address.
- Input: el campo del destinatario del Paso 1. Así te quedas solo con el correo, sin el nombre.
- Si el presupuesto tiene varios destinatarios, el Zap se queda con uno solo. Mira cuál en Test.
Paso 3 · Action · Formatter by Zapier · Date/Time
- Transform: Add/Subtract Time.
- Input: escribe now. Si Zapier no lo acepta, usa el campo de fecha del correo del Paso 1.
- Expression: +5 days. To Format: DD/MM/YYYY.
Paso 4 · Action · Google Sheets · Create Spreadsheet Row
- Drive, Spreadsheet y Worksheet: tu hoja Seguimiento.
- Fecha envío: la fecha del correo. Cliente: el resultado del Paso 2. Asunto: el campo Subject.
- Seguir el: el resultado del Paso 3. Estado: escribe Esperando respuesta.
Paso 5 · Action · Delay by Zapier · Delay For
- Time Delayed For: 5 days.
- Mientras tanto, la ejecución queda en espera y la ves en el Zap History.
Paso 6 · Action · Gmail · Find Email
- Search String: in:inbox, un espacio, from: y el resultado del Paso 2, otro espacio y newer_than:5d.
- Pon que el paso se considere correcto aunque no encuentre nada (la opción de continuar cuando no hay resultado).
- Este paso es delicado. Busca cualquier correo del cliente en los últimos 5 días, sea o no la respuesta al presupuesto.
- Puede fallar en los dos sentidos: darte un borrador aunque el cliente contestó en los primeros minutos, o no darte borrador porque te escribió por otro asunto.
- Si no te sale, quítalo y mira tú a mano si el cliente ha contestado.
Paso 7 · Action · Filter by Zapier · Only continue if
- Condición: el identificador del correo encontrado en el Paso 6, (Text) Does not exist.
- Si el cliente ya ha contestado, el Zap se detiene aquí y la fila queda en Esperando respuesta. Cámbiala tú a mano a Contestó.
Paso 8 · Action · Gmail · Create Draft
- To: el resultado del Paso 2.
- Subject: Re y el asunto original.
- Body: tu texto de seguimiento. Sin presión y con una pregunta clara.
- Si quieres ayuda para redactar la plantilla, pídesela a Claude, Codex, Gemini o una IA local y pégala ya revisada.
Paso 9 · Action · Google Sheets · Update Spreadsheet Row
- Elige la fila creada en el Paso 4 (mira en Test cómo se llama el campo con su número). Estado: Borrador de seguimiento creado.
CÓMO PROBARLA
En el editor, puede que el Test de Delay by Zapier no espere el tiempo entero.
Para ver la espera real, publica el Zap con un Time Delayed For corto (unos minutos) y etiqueta UN presupuesto que te hayas mandado a ti mismo desde otra cuenta tuya.
Al terminar, vuelve a poner 5 days y publica de nuevo antes de usarlo con clientes reales.
Haz Test en cada paso. Comprueba la fila, la espera y el borrador.
Contesta a ese correo desde la otra cuenta y repite la prueba para ver que, con respuesta, el Zap se detiene en el Paso 7.
Borra la fila y el borrador de prueba.
CUÁNTO CUESTA
Mira en la web de Zapier si hay plan gratuito para probar, cuántas tareas incluye tu plan y qué pasos cuentan como tarea.
Cada presupuesto ejecuta varios pasos. Calcula cuántos etiquetas al mes y compáralo con el límite de tu plan.
QUÉ NO HACER
No cambies Create Draft por un envío automático. Un recordatorio que sale sin que lo leas puede molestar a quien ya contestó por otro canal.
No mandes más de un seguimiento por presupuesto desde este Zap.
No lo uses con listas de personas que no te han pedido presupuesto. Eso es otra cosa y tiene reglas distintas sobre comunicaciones comerciales.
No pongas etiquetas a correos con datos que no necesitas guardar.
QUÉ REVISAR A MANO ANTES DE ACTIVARLA
Que el borrador respeta lo hablado con el cliente: precio, plazos y condiciones.
Que el cliente no ha contestado por teléfono, WhatsApp u otro canal. El Zap solo ve el correo.
Que la hoja Seguimiento no es pública. Tiene correos de clientes, que son datos personales.
Cuánto tiempo guardas la hoja y quién borra las filas antiguas.
Que la búsqueda del Paso 6 encuentra respuestas reales. Pruébala con un cliente que sí contestó.
Si tu actividad toca salud, legal o finanzas, una persona decide si y cómo escribir a ese cliente. Ante la duda sobre comunicaciones comerciales, consúltalo con un profesional.
