# Zapier: borrador de factura desde Google Sheets…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Un Zap de Zapier que, al marcar una fila de Google Sheets como lista, rellena una plantilla de Google Docs y te avisa por Gmail para que revises el borrador de factura.

## Qué es y qué hace

Zap de Zapier que, al marcar una fila de Google Sheets como Listo, rellena una plantilla de Google Docs con los datos de la factura, guarda el borrador en Drive y te envía un correo con el enlace. Entran la fila con base, IVA y cliente; salen un borrador de factura. No emite una factura válida: los cálculos los hace la hoja y tu gestor debe revisar la numeración.

## Cómo usarla

1. Crea la hoja Facturas por preparar con fórmulas de IVA
2. Crea la plantilla de Docs y la carpeta de Drive
3. Conecta Sheets, Docs y Gmail en Zapier
4. Que lo revise un profesional

## Cuándo usarla

Cuando emites pocas facturas al mes y pierdes tiempo copiando los datos del cliente en la plantilla, con el riesgo de equivocarte al teclear.

## Cómo ganar dinero con ella

Móntala a autónomos que facturan a mano: [TU PRECIO] por preparar plantilla y Zap, y [TU PRECIO] al mes si te encargas de mantenerlos y revisarlos.

- Borradores de factura para autónomos que emiten pocas facturas al mes y se equivocan al copiar datos.
- Mantenimiento de la plantilla con revisión de requisitos de facturación junto al gestor.
- Hoja de control de facturas emitidas con total mensual para la declaración de IVA.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

RECETA DE ZAPIER: borrador de factura desde Google Sheets
QUÉ HACE
Cuando marcas una fila de tu hoja como lista, el Zap rellena una plantilla de Google Docs con los datos de esa fila.
Guarda el borrador en una carpeta de Drive y te manda un correo con el enlace para revisarlo.
Esto prepara un BORRADOR. No emite una factura válida por sí solo.
QUÉ NECESITAS
Una cuenta de Zapier.
Una cuenta de Google con Google Sheets, Google Docs, Google Drive y Gmail.
Una hoja llamada Facturas por preparar con las columnas Nº factura, Fecha, Cliente, NIF, Dirección, Concepto, Base, IVA %, Cuota IVA, Total, Listo y Enlace borrador.
En Cuota IVA y Total pon fórmulas de la hoja. Los cálculos los hace la hoja, no Zapier.
Por ejemplo, si Base está en la columna G, IVA % en la H, Cuota IVA en la I y Total en la J: en I2 escribe =G2*H2/100 y en J2 escribe =G2+I2. En IVA % escribe 21 sin el símbolo %. Ajusta las letras a tu hoja.
Si aplicas retención de IRPF, añade a la hoja y a la plantilla las columnas que hagan falta. Que tu gestor valide la fórmula del Total.
Pon la columna Fecha con formato de fecha DD/MM/AAAA y la columna Listo con una lista desplegable con Sí y No.
Una plantilla en Google Docs con marcas entre llaves dobles: {{numero}}, {{fecha}}, {{cliente}}, {{nif}}, {{direccion}}, {{concepto}}, {{base}}, {{iva}}, {{cuota}}, {{total}}.
Una carpeta de Drive llamada Facturas borrador, privada.
PASOS (un Trigger y varias Action, en este orden)
Paso 1 · Trigger · Google Sheets · New or Updated Spreadsheet Row
- Drive, Spreadsheet y Worksheet: tu hoja Facturas por preparar.
- Trigger Column: Listo. Zapier avisa cuando cambia esa columna.
- Este disparador también salta con filas nuevas aunque Listo esté vacío. Por eso va el filtro del Paso 2.
- Rellena la fila entera y escribe Sí en Listo al final.
- Pulsa Test trigger y mira cómo llega cada dato. Comprueba que la fecha llega con el día y el mes en su sitio.
- Si repites Sí en una misma fila, Zapier puede no verlo como cambio. Para repetir una factura, copia la fila a una nueva.
Paso 2 · Action · Filter by Zapier · Only continue if
- Primera condición: Listo, (Text) Exactly matches, Sí (con tilde, igual que en la hoja).
- Segunda condición, con AND: Enlace borrador, (Text) Does not exist.
- Así no se crea un segundo documento de la misma fila.
Paso 3 · Action · Google Docs · Create Document from Template
- Template: tu plantilla de factura.
- Document Name: BORRADOR, el Nº factura y el cliente.
- Folder: Facturas borrador.
- Al elegir la plantilla, Zapier muestra un campo por cada marca. Rellena cada uno con su columna del Paso 1.
- Si no aparecen campos, comprueba que las marcas llevan llaves dobles y están bien escritas.
- Los números llegan como texto, tal como se ven en la hoja. Pon en la hoja dos decimales.
Paso 4 · Action · Google Sheets · Update Spreadsheet Row
- Worksheet: la misma hoja. Row: el número de fila del Paso 1. Mira en Test cómo se llama ese campo.
- Enlace borrador: el enlace del documento creado en el Paso 3. Mira en Test cómo se llama ese campo.
Paso 5 · Action · Gmail · Send Email
- To: tu propio correo.
- Subject: Revisar borrador de factura y el número.
- Body: cliente, total y el enlace del documento. No pongas el NIF.
CÓMO PROBARLA
Usa UNA fila con un cliente ficticio y números sencillos.
Haz Test en cada paso. Abre el documento del Paso 3 y compara cada dato con la hoja.
Suma a mano base más IVA y comprueba que coincide con el total.
Comprueba que la columna Enlace borrador se rellena y que el enlace abre el documento.
Comprueba que el correo te llega a ti.
Borra la fila y el documento de prueba antes de activar el Zap.
CUÁNTO CUESTA
Mira en la web de Zapier si hay plan gratuito para probar, cuántas tareas incluye tu plan y qué pasos cuentan como tarea.
Cada factura ejecuta varios pasos (documento, actualización de fila y correo). Calcula cuántas emites al mes y compáralo con el límite de tu plan.
QUÉ NO HACER
No envíes el documento al cliente desde el Zap. Lo revisas, lo conviertes en la factura definitiva y lo mandas tú.
No uses este Zap como sustituto de tu programa de facturación. Si la normativa te exige un programa o un formato concreto, pregunta a tu gestor antes de usar un documento suelto.
No compartas la carpeta ni la hoja con enlace público. Contienen NIF y direcciones, que son datos personales.
Zapier recibe esos datos para poder trabajar con ellos. Mira en su web su acuerdo de tratamiento de datos.
No dejes que el Zap invente el número de factura. La numeración la controlas tú. Mira que no haya dos filas con el mismo número.
QUÉ REVISAR A MANO ANTES DE ACTIVARLA
Una persona (tú, o tu gestor) revisa los datos obligatorios, el tipo de IVA, las retenciones, la numeración y el concepto antes de emitir nada.
Que las fórmulas de la hoja usan el tipo de IVA y la retención que te corresponden. Si dudas, pregunta a tu gestor.
Que la plantilla tiene tus datos fiscales actualizados.
Que la carpeta Facturas borrador y la hoja son privadas.
Cuánto tiempo guardas los borradores y quién los borra. Decídelo con tu gestor.
Este Zap no da asesoramiento fiscal. Cualquier duda sobre impuestos la resuelve una persona con conocimientos de fiscalidad.
