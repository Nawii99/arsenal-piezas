# Make (make.com): borrador de respuesta en Gmail con IA para…

**Tipo:** Receta de automatización · **Área:** Negocio · **Licencia:** CC BY 4.0

Un escenario de Make (make.com) que lee las consultas que llegan a una etiqueta de Gmail, pide a una IA de texto un borrador de respuesta y lo guarda como borrador para que lo revises tú.

## Qué es y qué hace

Escenario de Make (make.com) que lee los correos de una etiqueta de Gmail, pide a una IA de texto un borrador de respuesta y lo guarda en Borradores. Entran las consultas y un documento con la información del negocio; salen borradores, o un aviso si la consulta parece una queja o un tema delicado. No envía nada. La IA puede ser Claude, Codex, Gemini o una IA local con acceso seguro.

## Cómo usarla

1. Redacta el documento de información del negocio
2. Crea la etiqueta en Gmail y conecta Make
3. Prueba con diez consultas reales
4. Que lo revise un profesional

## Cuándo usarla

Úsala si el negocio recibe muchas preguntas repetidas por correo (horarios, precios orientativos, cómo reservar) y contestar una a una se come la mañana.

## Cómo ganar dinero con ella

Cobra [TU PRECIO] por montarla y redactar con el cliente el documento de información del negocio que usa la IA. Ofrece [TU PRECIO] al mes por mantener esa información.

- Atención a consultas repetidas (horarios, precios, reservas) para clínicas, tiendas o academias por correo.
- Plantilla de respuestas para el buzón de info de una empresa, con revisión semanal del texto de referencia.
- Mantenimiento mensual del documento de información y revisión de borradores con el cliente.

**Precio orientativo:** 150–350 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

QUÉ HACE
Cuando llega un correo a una etiqueta concreta de Gmail, el escenario lo lee y pide a una IA de texto un borrador de respuesta.
El borrador queda guardado en Gmail. No se envía nada al cliente.
Si la consulta parece una queja, una reclamación o un tema delicado, no hay borrador: te llega un aviso para que la atiendas tú.
QUÉ NECESITAS
Una cuenta de Make (make.com). Mira en su web cuántas operaciones o créditos incluye tu plan.
Una cuenta de Gmail o Google Workspace de atención al cliente (por ejemplo info@), mejor que tu correo personal.
Una IA de texto: Claude, Codex, Gemini o una IA local. Necesitas su clave de acceso (API) y mirar en su web cuánto cobra por uso, porque se paga aparte de Make.
Una IA local instalada en tu ordenador no es accesible desde Make, que funciona en internet. Solo sirve si sabes exponerla de forma segura; si no, elige otra.
Un texto con la información que sí se puede decir: horarios, dirección, servicios, formas de pago, política de cambios. Solo lo que el negocio acepte que se diga.
En Gmail, un filtro que ponga la etiqueta «Consultas» a los correos que llegan a esa dirección.
LOS MÓDULOS, EN ORDEN
Módulo 1 · Gmail › Watch Emails.
- Connection: pulsa Add e inicia sesión con la cuenta de atención al cliente. Make pedirá permisos sobre Gmail. Si te pide crear tu propia conexión con Google, sigue la guía de Make para Gmail.
- Folder: la etiqueta Consultas. Max results: 5. Choose where to start: From now on.
Filtro entre el módulo 1 y el 2 (pulsa en la línea que los une y elige «Set up a filter»). Nombre: «No es de la casa». Condición: el email del remitente (dentro del campo From) «Does not contain» @tudominio.com. Evita que conteste a tus propios correos.
Módulo 2 · Tools › Set variable.
- Variable name: consulta. Variable value: la función substring(...) con el texto del correo, desde 0 hasta 1500. Así recortas el texto y gastas menos en la IA.
- Si en alguna prueba ese texto sale vacío, el correo llega solo en formato HTML. Prueba con otro correo y no sigas hasta que el texto salga.
Módulo 3 · La IA de texto. Si Make tiene app para la IA que uses, busca su acción de generar texto a partir de un mensaje. Si no, usa HTTP › Make a request siguiendo la guía de la propia IA.
- Con HTTP, activa Parse response para poder usar los campos de la respuesta. La clave de acceso va en la cabecera que indique la guía de la IA, nunca en el texto del mensaje.
- Instrucciones (rol del sistema): «Eres el asistente de [NEGOCIO]. Escribe un borrador de respuesta breve, amable y en español de España, tuteando. Usa solo la información de abajo. No inventes precios, plazos ni disponibilidad: si no tienes el dato, di que lo confirmas y que le escribimos. Si el correo es una queja, una reclamación, un asunto legal, de salud, de pago o de datos personales, responde solo con la palabra DERIVAR.»
- Debajo de las instrucciones pega el texto con la información del negocio.
- Mensaje del usuario: el asunto del correo y la variable consulta.
- El texto del correo lo escribe un tercero y puede incluir órdenes dirigidas a la IA. Por eso el resultado solo se guarda como borrador y lo lee una persona.
Módulo 4 · Router (Flow Control › Router). Dos rutas.
Ruta A, con borrador: filtro «La respuesta de la IA» Does not contain DERIVAR (si ves la versión «case insensitive» del operador, úsala). Módulo: Gmail › Create a Draft.
- To: pulsa Add item y pon el email del remitente del correo original. Subject: «Re: » y el asunto original.
- Content: la respuesta de la IA (el campo con el texto que devuelve el módulo 3) y, debajo, tu firma. Si el módulo deja indicar el hilo (Thread ID), pon el del correo original.
Ruta B, para ti: filtro «La respuesta de la IA» Contains DERIVAR (también en versión «case insensitive» si la ves). Módulo: Gmail › Send an Email.
- To: tu correo. Subject: «Consulta para atender a mano». Content: remitente, asunto y fecha del correo.
CÓMO PROBARLA
Escribe UN solo correo de prueba desde otra dirección tuya con una pregunta sencilla, por ejemplo el horario.
Mira que Gmail le ha puesto la etiqueta Consultas, pulsa Run once en Make y espera.
Abre el borrador. Comprueba que no inventa datos, que usa tu tono y que el asunto empieza por «Re:».
En otra prueba aparte, con otro Run once, envía una queja inventada para ver que te llega el aviso de la ruta B.
Cuando funcione, activa Scheduling y pulsa Save.
CUÁNTO CUESTA
Cada módulo que se ejecuta puede gastar operaciones o créditos. Con este diseño, un correo pasa por unos 5 módulos. Compruébalo en el historial tras la prueba.
La IA se cobra aparte, según su tarifa. Mira en su web cuánto cuesta y cuántas operaciones o créditos incluye tu plan de Make.
QUÉ NO HACER
No envíes las respuestas automáticamente. Cada borrador lo lee una persona antes de enviarlo.
No pases a la IA datos de salud, DNI, datos bancarios ni contraseñas. Si un correo los lleva, que lo atienda una persona. Revisa las condiciones de privacidad de la IA que uses.
No des permisos de Gmail con tu cuenta personal si el escenario es del cliente. Usa la cuenta de atención al cliente.
No metas en el texto del negocio precios o condiciones que no estén confirmados.
QUÉ REVISAR A MANO ANTES DE ACTIVARLA
Que la etiqueta Consultas solo cae en correos de clientes y no en facturas, avisos ni correos internos.
Que el filtro del módulo 1 evita que el escenario conteste a tus propios correos.
Que la información del negocio está al día.
Que las quejas, reclamaciones, devoluciones y cualquier tema legal, de salud o de pago los gestiona una persona.
Que has leído al menos diez borradores reales antes de dar el escenario por bueno.
Que los clientes saben que sus correos pasan por una IA (ponlo en la política de privacidad) y que has revisado el acuerdo de tratamiento de datos de Make y de la IA que uses.
