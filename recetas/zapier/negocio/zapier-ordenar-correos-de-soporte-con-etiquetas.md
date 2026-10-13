# Zapier: ordenar correos de soporte con etiquetas…

**Tipo:** Receta de automatización · **Área:** Negocio · **Licencia:** CC BY 4.0

Un Zap de Zapier que lee los correos nuevos de tu buzón de soporte, los clasifica con Paths by Zapier, les pone etiqueta en Gmail y deja un borrador de respuesta.

## Qué es y qué hace

Zap de Zapier que lee los correos nuevos de tu buzón de soporte, los clasifica con Paths by Zapier (facturas, envíos u otros), les pone etiqueta en Gmail, los apunta en una hoja de incidencias y deja un borrador con tu plantilla. Entran correos entrantes; salen etiquetas, filas y borradores. Nada se envía solo.

## Cómo usarla

1. Crea las etiquetas en Gmail y la hoja Incidencias
2. Escribe tres plantillas de respuesta
3. Conecta Gmail y Sheets en Zapier y prueba con correos de ejemplo
4. Que lo revise un profesional

## Cuándo usarla

Cuando tu negocio recibe dudas, pedidos e incidencias por un mismo correo y pierdes tiempo ordenándolas una a una antes de contestar.

## Cómo ganar dinero con ella

Móntala a tiendas y servicios con buzón de soporte: [TU PRECIO] de instalación y [TU PRECIO] al mes por ajustar palabras, etiquetas y plantillas.

- Orden del buzón de soporte para tiendas online con dudas de pedidos y envíos mezcladas.
- Revisión mensual de etiquetas y plantillas con informe de los temas más frecuentes para el equipo.
- Formación de una hora al equipo sobre cómo usar las etiquetas y los borradores sin enviar nada por error.

**Precio orientativo:** 150–350 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

RECETA DE ZAPIER: ordenar correos de soporte con etiquetas
QUÉ HACE
Cada correo nuevo que llega a tu buzón de soporte se apunta en una hoja, se clasifica por palabras clave y recibe una etiqueta de Gmail.
Además deja en Borradores una respuesta con una plantilla tuya. Nada se envía solo.
QUÉ NECESITAS
Una cuenta de Zapier.
Una cuenta de Gmail o Google Workspace. Usa un buzón de soporte aparte, no tu correo personal.
En Gmail, crea tres etiquetas: Soporte/Facturas, Soporte/Envíos y Soporte/Otros.
Una hoja de Google Sheets llamada Incidencias con las columnas Fecha, De, Asunto, Tipo y Estado.
Tres plantillas de respuesta escritas por ti, de dos o tres frases cada una.
PASOS (un Trigger y varias Action, en este orden)
Paso 1 · Trigger · Gmail · New Email Matching Search
- Search String: in:inbox to:soporte@tudominio.com (cambia la dirección por la tuya).
- La búsqueda hace que el Zap procese solo los correos de ese buzón.
- Ojo: al conectar Gmail, Zapier recibe permiso sobre toda la cuenta. La búsqueda limita lo que procesa el Zap, no lo que Zapier puede ver. Por eso conviene una cuenta de soporte aparte.
- Pulsa Test trigger y elige un correo de prueba que te hayas mandado tú.
- Mira en Test cómo se llaman los campos del remitente, el asunto, el texto y el identificador del correo.
Paso 2 · Action · Google Sheets · Create Spreadsheet Row
- Fecha: la fecha del correo. De: el remitente. Asunto: el campo Subject.
- Tipo: déjalo vacío. Lo rellenará cada Path al final. Estado: escribe Nuevo.
- No copies el cuerpo del mensaje en la hoja.
Paso 3 · Action · Formatter by Zapier · Text
- Transform: Lowercase.
- Input: el campo Subject y, justo después, el cuerpo del mensaje en texto plano (Body Plain). Así se buscan palabras en los dos sitios.
- Si el correo trae citado un hilo anterior, puede traer palabras de mensajes viejos.
Paso 4 · Action · Paths by Zapier
- Path A, Facturas: (Text) Contains factura, cobro o pago. Usa reglas con OR.
- Path B, Envíos: (Text) Contains envío, envio, pedido o seguimiento. Usa reglas con OR.
- Path C, Otros: márcalo como Fallback path, que solo corre si no entra ningún otro. Si no ves esa opción, usa (Text) Does not contain con todas las palabras anteriores y reglas AND.
- Un correo con palabras de dos grupos puede entrar en más de un Path y crear dos borradores. Pruébalo con un correo que diga factura y envío.
Dentro del Path A:
Paso A1 · Action · Gmail · Add Label to Email
- Email: el identificador del correo del Paso 1. Label: Soporte/Facturas.
Paso A2 · Action · Gmail · Create Draft
- To: el remitente del Paso 1. Subject: Re y el asunto original.
- Body: tu plantilla para facturas y cobros.
- Si ves un campo para el hilo (Thread ID), pon el del Paso 1 para que el borrador cuelgue de esa conversación.
Paso A3 · Action · Google Sheets · Update Spreadsheet Row
- Row: la fila creada en el Paso 2. Mira en Test cómo se llama ese campo.
- Tipo: Facturas. Estado: Borrador creado.
Path B y Path C: repite A1, A2 y A3 con su etiqueta, su plantilla y su Tipo (Envíos u Otros).
Opcional: un paso de IA (Claude, Codex, Gemini o una IA local) puede proponer un borrador ajustado al mensaje. Pruébalo solo cuando la plantilla fija ya funcione, y siempre como borrador.
Ese paso recibe el texto del cliente. Mira antes qué hace con él el servicio que uses. Si no lo tienes claro, usa una IA local.
CÓMO PROBARLA
Mándate UN correo a ti mismo al buzón de soporte con la palabra factura en el asunto.
Haz Test en cada paso. En Paths, comprueba que solo se activa el Path A.
Mira en Gmail que el correo tiene la etiqueta y que hay un borrador nuevo.
Mira en la hoja que la fila tiene Tipo Facturas y Estado Borrador creado.
Repite con un correo que diga envío y con otro sin ninguna palabra clave, uno por uno.
Borra de Gmail y de la hoja los correos, borradores y filas de prueba.
CUÁNTO CUESTA
Mira en la web de Zapier si hay plan gratuito para probar, cuántas tareas incluye tu plan y qué pasos cuentan como tarea.
Paths by Zapier puede requerir un plan de pago: mira en su web qué incluye el tuyo.
Cada correo ejecuta varios pasos. Calcula cuántos correos recibes al mes y compáralo con el límite de tu plan.
QUÉ NO HACER
No sustituyas Create Draft por un envío automático. Una respuesta mal clasificada que salga sola puede equivocar a un cliente.
No uses tu correo personal ni un buzón con mensajes privados. Zapier tiene permiso sobre toda la cuenta que conectas.
No guardes en la hoja datos de pago, de salud ni documentos de identidad. A veces el cliente los escribe en el asunto: mira esa columna de vez en cuando.
No des acceso a la cuenta de Gmail de otra persona sin su permiso por escrito. No pidas ni guardes su contraseña.
QUÉ REVISAR A MANO ANTES DE ACTIVARLA
Que la búsqueda del Paso 1 solo recoge el buzón de soporte.
Que cada plantilla no promete reembolsos, plazos ni garantías que no hayas decidido tú.
Si tu soporte trata devoluciones, garantías o reclamaciones, una persona lee y decide cada respuesta. Si hay dudas legales, consúltalo con un profesional.
Los correos y la hoja contienen datos personales. Decide quién los ve, cuánto tiempo los guardas y quién los borra.
Si un cliente pide borrar sus datos, quítalos también de la hoja y de Gmail.
Las palabras clave fallan. Durante el primer mes, mira a mano los correos que cayeron en Otros.
Los mensajes automáticos (avisos, no-reply) también entran. Mira cómo quedan etiquetados.
