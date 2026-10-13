---
name: formulario-contacto-web-getform
description: Conecta el formulario de contacto de tu web con Getform para que cada mensaje te llegue al correo y quede guardado, con código listo para pegar, antispam, aviso de privacidad y pruebas. Úsala cuando tu web necesite un formulario y no quieras montar un servidor.
---

# Formulario de contacto web con Getform

Instalación: guarda este archivo como .claude/skills/formulario-contacto-web-getform/SKILL.md en tu proyecto. Claude Code la usará cuando le pidas un formulario de contacto para tu web.
Última revisión: octubre de 2026. Los menús y planes de Getform cambian. Sigue su ayuda oficial cuando no coincida.

## Qué hace
- Escribe el formulario (HTML) apuntando a la URL de envío que da Getform. El usuario lo pega en su web. Si los archivos de la web están en la carpeta de trabajo, Claude Code lo coloca después de enseñar el cambio.
- Añade antispam, casilla de privacidad y una página de «gracias».
- Entrega una lista de pruebas para saber si funciona de verdad.
- Para el formulario no hace falta ninguna conexión: solo la URL pública de envío. Si Getform está conectado a Claude (por MCP o con n8n), comprueba antes qué puede hacer esa conexión.

## Qué preguntar antes de empezar
Pregunta de una en una.
1. ¿Con qué está hecha tu web (WordPress, Wix, Webflow, Squarespace, Shopify, archivos propios)? Si no lo sabes, dime la dirección y te explico cómo averiguarlo.
2. ¿Tu web ya tiene un formulario que funciona y te llega bien? Si es que sí, no hace falta cambiar nada.
3. ¿Has creado ya el formulario en Getform y tienes su URL de envío? Si no, créalo en su panel y copia la URL. [URL DE TU FORMULARIO EN GETFORM]
4. ¿Qué campos necesitas? Lo normal es nombre, correo y mensaje. ¿Teléfono? ¿Archivo adjunto?
5. ¿A qué correo debe avisarte y quién lo lee? Mejor un correo del negocio que uno personal.
6. ¿Qué debe ver la persona al enviar? Una página de «gracias» propia o un mensaje.
7. ¿Tienes política de privacidad publicada? ¿En qué dirección?
8. ¿Qué límites tiene tu plan de Getform (envíos al mes, tamaño de archivos, antispam)? [MIRA EN TU CUENTA]

## Paso a paso
1. Decide si hace falta. Si el gestor de la web ya trae formularios y te llegan bien, se queda ese.
2. Crea el código del formulario con este modelo. Cambia lo que está entre corchetes:
```html
<form action='[URL DE TU FORMULARIO EN GETFORM]' method='POST'>
  <label for='nombre'>Nombre</label>
  <input type='text' id='nombre' name='nombre' required autocomplete='name'>
  <label for='email'>Correo electrónico</label>
  <input type='email' id='email' name='email' required autocomplete='email'>
  <label for='mensaje'>Mensaje</label>
  <textarea id='mensaje' name='mensaje' rows='5' required></textarea>
  <input type='text' name='[NOMBRE DEL CAMPO TRAMPA SEGÚN GETFORM]' style='display:none' tabindex='-1' autocomplete='off'>
  <input type='checkbox' id='privacidad' name='privacidad' required>
  <label for='privacidad'>He leído la <a href='[URL DE TU POLÍTICA DE PRIVACIDAD]'>política de privacidad</a></label>
  <button type='submit'>Enviar</button>
</form>
```
3. Si el formulario lleva archivo adjunto, añade enctype='multipart/form-data' dentro de la etiqueta form.
4. Antispam: activa en el panel de Getform la protección que ofrezca y usa el nombre exacto del campo trampa que te indique. Un campo trampa es un campo oculto que solo rellenan los robots.
5. Pega el código. En tu editor busca un bloque llamado «HTML personalizado», «Código» o «Incrustar». El nombre cambia según la plataforma. Algunos planes de gestores web no permiten código propio. Si el tuyo no, usa su formulario nativo.
6. Página de «gracias»: configura en el panel de Getform a qué dirección se redirige tras enviar, siguiendo su ayuda. Crea una página sencilla en tu web.
7. Texto de privacidad bajo el botón: «Responsable: [TU NOMBRE O EMPRESA Y NIF]. Finalidad: responder a tu consulta. Base legal: [LA CONFIRMA TU ASESOR]. Destinatarios: los proveedores necesarios para prestar el servicio, como el del formulario. Derechos: acceso, rectificación, supresión y otros, escribiendo a [TU CORREO]. Más información en la política de privacidad.»
8. Lo obligatorio es informar. La casilla «he leído» es práctica habitual y tu asesor decide si la dejas. Si quieres enviar newsletter, va en una casilla aparte y sin marcar.
9. Prueba: envía desde el ordenador y desde el móvil. Comprueba que llega al correo y que se guarda en el panel de Getform. Mira la carpeta de spam. Envía otro con un campo vacío y otro con el campo trampa relleno. Si algo no llega, no lo des por bueno. Borra después los mensajes de prueba.
10. Si la web es de un cliente, la cuenta de Getform va a su nombre o hay un acuerdo escrito sobre quién responde de los datos.

## Qué devolver y con qué formato
- El código del formulario en un bloque, con los datos ya puestos y lo que falte entre corchetes.
- El texto de privacidad listo para pegar.
- Los pasos para pegarlo en la plataforma concreta del usuario.
- La lista de pruebas con casillas [ ].
- Un apartado «Pendiente de revisión humana».

## Qué NO hacer
- No pidas ni pegues contraseñas ni claves de API de Getform. El formulario solo necesita la URL pública de envío.
- No toques archivos de la web sin enseñar antes el cambio y sin que exista una copia de seguridad.
- No des el formulario por bueno sin una prueba real de envío y recepción.
- No pidas datos que no necesites. Nunca números de tarjeta, claves ni documentos de identidad.
- No recojas datos de salud u otros delicados sin revisión previa de un asesor.
- No prometas que ningún mensaje se pierde. Puede caer en spam o fallar el servicio. Hay que revisarlo de vez en cuando.
- No dejes marcada de antemano la casilla de newsletter.
- No cambies un formulario que ya funciona solo por cambiarlo.

## Revisión humana antes de usar el resultado
Termina siempre recordando que una persona revisa:
- El texto de privacidad y la política completa, quien responde de la web.
- Dónde guarda Getform los datos y si ofrece contrato de encargado de tratamiento. El RGPD lo exige cuando un proveedor trata datos por ti.
- Cuánto tiempo se guardan los mensajes y quién puede leerlos. Los antiguos se borran.
- Si el formulario es de una clínica, un despacho u otro negocio con secreto profesional, que lo valide un profesional antes de publicar.
