# Zapier: leads de Facebook Lead Ads a Google Sheets…

**Tipo:** Receta de automatización · **Área:** Ventas · **Licencia:** CC BY 4.0

Un Zap de Zapier que guarda cada contacto de Facebook Lead Ads en Google Sheets, te avisa por Gmail y deja un borrador del primer mensaje para que lo revises tú.

## Qué es y qué hace

Zap de Zapier que guarda cada contacto de Facebook Lead Ads en Google Sheets, te avisa por Gmail y deja un borrador del primer mensaje en Borradores. Entran los leads nuevos del formulario de Meta; salen una fila en la hoja, un correo de aviso y un borrador. Solo procesa leads desde que lo activas, y el mensaje lo envías tú.

## Cómo usarla

1. Crea la hoja Leads
2. Conecta Facebook Lead Ads y Gmail en Zapier
3. Prueba con un lead de prueba y revisa el borrador
4. Que lo revise un profesional

## Cuándo usarla

Cuando captas contactos con anuncios de Facebook o Instagram y se quedan sin atender porque nadie los pasa a una hoja ni te avisa a tiempo.

## Cómo ganar dinero con ella

Móntala a negocios locales que captan contactos con anuncios: [TU PRECIO] de montaje y [TU PRECIO] al mes por revisarla y mantenerla.

- Captación de contactos para negocios locales que pagan anuncios y tardan en responder.
- Mantenimiento mensual del Zap y revisión de leads sin atender, con informe para el cliente.
- Plantillas de primer mensaje por tipo de servicio, revisadas antes de activar el Zap.

**Precio orientativo:** 150–350 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

RECETA DE ZAPIER: leads de Facebook Lead Ads a Google Sheets
QUÉ HACE
Cada vez que alguien rellena tu formulario de Facebook o Instagram Lead Ads, el Zap apunta sus datos en una hoja de Google Sheets.
Te manda un correo de aviso a ti y deja en Gmail un borrador del primer mensaje para el contacto.
El borrador no se envía solo. Lo lees, lo ajustas y lo mandas tú.
Solo recoge los leads nuevos desde que lo activas. Los anteriores no pasan solos a la hoja.
QUÉ NECESITAS
Una cuenta de Zapier.
Una cuenta de Facebook con permisos sobre la página y sobre el formulario de captación (normalmente, rol de administrador).
Si trabajas para un cliente, pídele que te dé ese acceso desde su cuenta. No le pidas su contraseña.
Una cuenta de Google con Gmail y Google Sheets.
Una hoja nueva llamada Leads con estas columnas en la fila 1: Fecha, Nombre, Email, Teléfono, Origen, Estado, Notas.
Un formulario de Meta que enseñe el enlace a tu política de privacidad.
PASOS (un Trigger y varias Action, en este orden)
Paso 1 · Trigger · Facebook Lead Ads · New Lead
- Account: conecta tu cuenta de Facebook. Zapier te enseñará qué permisos pide. Léelos antes de aceptar.
- Page: elige tu página.
- Form: elige un formulario concreto, no todos.
- Pulsa Test trigger y elige un lead de prueba. Puedes crearlo con la herramienta de prueba de Lead Ads de Meta.
- Mira en Test cómo se llaman los campos de nombre, email, teléfono y fecha. Cambian según las preguntas de tu formulario.
Paso 2 · Action · Filter by Zapier · Only continue if
- Condición: el campo Email del Paso 1, (Text) Contains, @.
- Así el Zap se para si el lead dejó el email vacío o mal escrito.
- Va antes del Formatter para que este no reciba un campo vacío y falle.
Paso 3 · Action · Formatter by Zapier · Text
- Transform: Lowercase.
- Input: el campo Email del Paso 1.
Paso 4 · Action · Google Sheets · Create Spreadsheet Row
- Drive, Spreadsheet y Worksheet: tu hoja Leads.
- Fecha: el campo de fecha de creación del lead (Paso 1).
- Nombre y Teléfono: los campos de nombre y teléfono del Paso 1.
- Email: el resultado del Paso 3.
- Origen: escribe a mano Facebook Lead Ads. Si Test trae el nombre de la campaña, añádelo con su campo.
- Estado: escribe Nuevo. Notas: déjalo vacío.
Paso 5 · Action · Gmail · Send Email
- To: tu propio correo, nunca el del lead.
- Subject: Lead nuevo, seguido del nombre (Paso 1).
- Body: nombre, teléfono, email y el enlace a tu hoja Leads.
Paso 6 · Action · Gmail · Create Draft
- To: el email del lead (resultado del Paso 3).
- Subject: Sobre tu consulta en (nombre de tu negocio).
- Body: tres frases tuyas. Saludo, lo que pidió y una propuesta de llamada. Sin precios inventados.
- Si quieres ayuda para redactar la plantilla, pídesela a Claude, Codex, Gemini o una IA local y pégala ya revisada. No le pases datos de contactos reales.
CÓMO PROBARLA
Haz Test en cada paso con UN solo lead de prueba.
Paso 2: cambia la condición un momento para ver que el Zap se detiene, y déjala como estaba.
Paso 4: mira la hoja. Debe haber UNA fila nueva y cada dato en su columna.
Paso 5: el correo debe llegarte a ti.
Paso 6: abre Gmail, entra en Borradores y lee el texto. Si es de prueba, no lo envíes y bórralo.
Borra de la hoja la fila de prueba antes de activar el Zap.
Cuando todo cuadre, pulsa Publish para activar el Zap.
CUÁNTO CUESTA
Mira en la web de Zapier si hay plan gratuito para probar, cuántas tareas incluye tu plan y qué pasos cuentan como tarea.
Mira también si la app de Facebook Lead Ads exige un plan de pago.
Cada lead ejecuta varios pasos. Calcula cuántos leads esperas al mes y compáralo con el límite de tu plan.
QUÉ NO HACER
No cambies el borrador por un envío automático al lead. Que alguien te deje su contacto en un anuncio no te autoriza a escribirle mensajes en masa ni a mandarle promociones.
Nombre, teléfono y email son datos personales. Guarda solo los que necesitas y no compartas la hoja con enlace público.
No pidas en el formulario más datos de los que necesitas.
Zapier trata esos datos por tu cuenta. Mira en su web su acuerdo de tratamiento de datos y consulta con un profesional si tu negocio lo exige.
Conecta solo las cuentas del negocio. Si trabajas para un cliente, usa su cuenta con permiso por escrito. No pidas ni guardes su contraseña.
QUÉ REVISAR A MANO ANTES DE ACTIVARLA
Que el formulario de Meta enseñe el enlace a tu política de privacidad y que el contacto sepa para qué usarás sus datos.
Que cada columna de la hoja recibe el dato que toca.
Que el borrador no promete resultados ni plazos que no puedas cumplir.
Que la hoja Leads la ve solo quien trabaja con esos contactos.
Cuánto tiempo guardarás los contactos y quién los borra. Decídelo antes de empezar.
Si alguien te pide ver, corregir o borrar sus datos, hay que quitarlos también de la hoja, de Gmail y de Meta. Si dudas, consúltalo con un profesional.
Cada semana, mira el Zap History de Zapier. Si hay ejecuciones con error, una persona decide qué hacer con ese lead.
Una persona decide si se contesta a cada lead y qué se le dice. El Zap solo prepara el borrador.
