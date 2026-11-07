---
description: Crea o repara un formulario de contacto en HTML estático que envíe al correo, con validación, antispam y mensaje de gracias
argument-hint: "[ruta del HTML y a qué correo deben llegar los mensajes]"
---

Vas a dejar funcionando el formulario de contacto de: $ARGUMENTS

## Paso 0: preguntas obligatorias antes de escribir código
Pregunta y espera respuesta:
1. Correo donde quiere recibir los mensajes.
2. Dónde está publicada la web: Netlify, Cloudflare Pages, GitHub Pages, Vercel u hosting normal. Esto cambia la solución entera.
3. Qué datos necesita pedir de verdad (nombre, email, teléfono, mensaje, presupuesto). Cada campo de más baja el número de envíos.

## Paso 1: elige el método según el hosting
- Netlify: atributos netlify y netlify-honeypot en el <form>. Gratis hasta 100 envíos al mes.
- Cloudflare Pages, GitHub Pages, Vercel o cualquier hosting estático: usa un servicio de formularios tipo Formspree, Web3Forms o Formsubmit, con action apuntando a su endpoint y method POST. Explica que hay que registrarse y confirmar el correo una vez.
- Nunca propongas mailto: en el action. Abre el cliente de correo del visitante, falla en móvil y se pierde la mitad de los mensajes. Si el usuario lo pide, explícale por qué no.

## Paso 2: escribe el formulario con estas reglas
- Cada input con su <label> asociado por for e id: sin label, el móvil no ayuda al usuario y es inaccesible.
- type="email" para el correo y type="tel" con inputmode="tel" para el teléfono: cambia el teclado del móvil.
- required solo en los campos imprescindibles.
- name en todos los campos, porque sin name el dato no viaja.
- Campo trampa antispam: un input oculto con CSS (no con hidden) que los bots rellenan y las personas no.
- Botón con texto de acción concreto, no "Enviar": "Pedir presupuesto", "Quiero que me llamen".
- Casilla de consentimiento de datos con enlace a la política de privacidad, obligatoria en España.
- Mensaje de gracias: página aparte o texto que aparece tras enviar. Si el visitante no ve confirmación, envía dos y tres veces.

## Paso 3: errores típicos que debes comprobar
- El <form> sin atributo action o con action vacío: no envía a ningún sitio.
- Botón fuera de la etiqueta <form>.
- Botón sin type="submit" dentro de una página con más scripts.
- Falta method="POST".
- El servicio de formularios sin verificar por correo: los primeros envíos se tiran.
- Los mensajes acaban en spam del propio usuario: avísale de que revise esa carpeta el primer día.

## Paso 4: prueba real
Dile en pasos numerados que tras publicar debe enviarse un mensaje de prueba desde el móvil con datos reales, mirar la bandeja y la carpeta de spam, y marcar el remitente como correo deseado.
Si no llega en 5 minutos, la causa casi siempre es: servicio sin verificar, action mal escrito o campos sin name. Dilo así de claro.

## Formato de respuesta
1. Qué método has elegido y por qué, en dos frases.
2. Bloque HTML completo del formulario listo para pegar.
3. Bloque CSS mínimo para que se vea decente y para ocultar la trampa antispam.
4. Pasos de alta en el servicio, numerados.
5. Prueba de verificación.

Si el archivo ya tenía un formulario, señala línea por línea qué estaba mal antes de dar el nuevo.
