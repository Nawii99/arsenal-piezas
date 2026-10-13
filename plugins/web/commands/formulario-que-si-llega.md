---
description: Instala un formulario de contacto funcional sin backend, con antispam, aviso legal y confirmación al usuario
argument-hint: [qué datos quieres recibir y a qué email]
---

Eres quien deja funcionando el formulario de una web estática. El usuario no tiene servidor propio ni quiere pagar cuotas.

Datos del usuario: $ARGUMENTS

PASO 1. Mira si ya hay un formulario en los HTML del proyecto. Si lo hay, revisa por qué no funciona: lo normal es que tenga action vacío, action="#", o un action de plantilla que apunta a un dominio de ejemplo.

PASO 2. Pregunta en una sola tanda:
1. ¿A qué correo quieres que lleguen los mensajes?
2. ¿Qué datos necesitas de verdad? (cada campo de más baja el número de envíos: quédate con lo mínimo)
3. ¿Quieres que al enviar se quede en la página o que vaya a una página de gracias?
4. ¿Quieres recibir también los mensajes por WhatsApp?

PASO 3. Explica en tres líneas las opciones gratuitas reales y recomienda una, sin marear:
- Un servicio de formularios por email (tipo Formspree, Web3Forms, Getform): pegas una dirección en el action y listo. Plan gratis limitado en envíos al mes.
- El formulario nativo de la plataforma donde publica (Netlify Forms si publica en Netlify): gratis y sin terceros.
- Un enlace mailto: no lo recomiendes como opción principal, falla en móviles y en quien no tiene cliente de correo, pero déjalo como plan B.
Recomienda UNA según dónde publique, y explica en una frase por qué.

PASO 4. Escribe el HTML del formulario con estas reglas de oficio:
- Cada campo con su <label> visible y asociado por for/id. Los placeholders no sustituyen a las etiquetas.
- type correcto: email, tel, text. En móvil eso cambia el teclado que sale y sube los envíos.
- autocomplete en nombre, email y teléfono.
- required solo en lo imprescindible.
- Un campo trampa oculto (honeypot) para el spam: un input con nombre tipo _gotcha, oculto por CSS, no con display:none dentro de un contenedor visible sino bien escondido y con tabindex=-1 y autocomplete=off.
- Casilla NO premarcada de aceptación de la política de privacidad, con enlace.
- Botón con texto que diga qué pasa: "Enviar mensaje", no "Enviar".
- Mensaje de éxito y de error visibles, sin depender de un alert.
- Estados de foco visibles para teclado.

PASO 5. Añade el JS mínimo para enviar sin recargar la página y mostrar "Enviando...", "Recibido, te contesto en menos de 24 h" o el error. Que el botón se desactive mientras envía, para evitar dobles envíos.

PASO 6. Responde con este formato exacto:

## Qué he montado
Dos frases: qué servicio, por qué y qué límite gratuito tiene.

## Lo que tienes que hacer tú
Pasos numerados con el registro en el servicio, dónde copiar la clave o URL y en qué línea del archivo pegarla. Sé literal.

## El código
Bloques de HTML, CSS y JS listos, ya aplicados a los archivos.

## Pruébalo así
1) Publica. 2) Rellena el formulario tú mismo con un texto reconocible. 3) Mira la bandeja de entrada Y la carpeta de spam. 4) Marca el correo como "no es spam" y añade el remitente a contactos, o los siguientes se perderán.

## Errores típicos que te vas a encontrar
Tres o cuatro: el primer correo va a spam; el servicio pide confirmar el email antes de activar; en local no funciona y hay que probarlo publicado; si cambias de correo hay que cambiarlo también en el servicio.

## Siguiente paso opcional
Cómo montar la respuesta automática al cliente y por qué merece la pena (que sepa que ha llegado).

REGLAS:
- Nada de pedir 9 campos. Cuantos menos, más envíos.
- No propongas montar un servidor ni una base de datos.
- Si ya usa una plataforma de publicación concreta, aprovecha su formulario nativo antes que un tercero.
