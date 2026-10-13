# Avisos automáticos del formulario de contacto de tu portfoli…

**Tipo:** Receta de automatización · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

Alguien rellena el formulario de tu portfolio: datos en Google Sheets, aviso por Telegram.

## Qué es y qué hace

Flujo de n8n que recibe los datos del formulario de contacto de una web de portfolio mediante un webhook, los limpia con un nodo Set, los guarda en una hoja de Google Sheets y te avisa por Telegram en cuanto alguien escribe. Entran nombre, email y mensaje; salen una fila ordenada y una notificación. Requiere cuenta de n8n, de Google y un bot de Telegram creado con BotFather.

## Cómo usarla

1. Crea el webhook y pégalo en el formulario
2. Limpia campos y guárdalos en Sheets
3. Configura el aviso en Telegram
4. Que lo revise un profesional

## Cuándo usarla

Tu portfolio tiene un formulario de contacto y no quieres estar mirando el correo cada hora por si llega alguien con una oferta.

## Cómo ganar dinero con ella

Móntaselo a autónomos y negocios pequeños con web propia que reciben consultas, y cobra la instalación y, si quieres, un mantenimiento mensual [TU PRECIO]. Los contactos son datos personales, así que la web necesita su aviso de privacidad.

- Instalación de avisos de contacto para autónomos con web propia…
- Mantenimiento mensual de formularios y avisos para pequeños negocios…
- Gestión de consultas para profesionales que reciben muchos correos…

**Precio orientativo:** 60–120 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace esta automatización
Cuando alguien rellena el formulario de contacto de tu web de portfolio, guarda sus datos en una hoja de Google Sheets y te avisa por Telegram, sin que tengas que revisar el email a cada rato.

## Cuentas que hacen falta
- Cuenta de n8n (self-hosted gratis, o n8n Cloud con periodo de prueba; revisa el límite de ejecuciones del plan gratuito antes de depender de esto para trabajo real).
- Cuenta de Google con Google Sheets (gratis).
- Un bot de Telegram creado con @BotFather (gratis, sin límite práctico para uso personal).

## Nodos, en orden
1. Webhook (disparador): crea una URL que recibirá los datos cuando alguien envíe el formulario de tu web. Copia esa URL y ponla como destino del formulario de tu portfolio.
2. Set: renombra y limpia los campos que llegan (nombre, email, mensaje), por si el formulario los manda con nombres raros.
3. Google Sheets - Append Row: añade una fila nueva con nombre, email, mensaje y fecha en una hoja que tengas preparada de antes.
4. Telegram - Send Message: te envía un mensaje a ti mismo con el resumen del contacto nuevo, usando el chat_id de tu propio bot.
5. Respond to Webhook: devuelve un mensaje de 'gracias, te contactaremos' a quien rellenó el formulario, para que no se quede la página cargando.

## Cómo probarla sin liarla
Antes de conectarla a tu web real, prueba el webhook con datos falsos: usa el botón 'Listen for test event' de n8n y envía un formulario de prueba con tu propio email y un nombre como 'Prueba Prueba'. Comprueba que aparece la fila en Sheets y que te llega el Telegram antes de poner la URL en tu web de verdad.

## Ojo con esto
Si tu web de portfolio es pública, cualquiera puede mandar datos a ese webhook, no solo desde tu formulario. Añade una validación mínima en el nodo Set (por ejemplo que el email tenga una arroba) para no llenar tu hoja de basura.
