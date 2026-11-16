# n8n: del formulario de encargo de animación a ficha y borrador

**Tipo:** Receta de automatización · **Área:** Webs animadas · **Licencia:** CC BY 4.0

Receta de n8n que lleva el formulario de encargo de animación a una ficha en Google Sheets y a un borrador en Gmail que revisas tú antes de enviar.

## Qué es y qué hace

Receta de n8n para recibir encargos de animación: un formulario recoge los datos del cliente, el flujo guarda una fila de proyecto en una hoja de cálculo de Google y crea en Gmail un borrador de respuesta dirigido al cliente. No envía nada: tú lees el borrador y lo envías. No usa IA. Horas, tarifa y costes los rellenas tú en la hoja; el total lo calculas tú con la fórmula indicada.

## Cómo usarla

1. Crea la hoja con los encabezados indicados
2. Conecta Google a n8n y monta los 4 nodos
3. Prueba con la Test URL y datos inventados
4. Activa el flujo y revisa cada borrador antes de enviarlo

## Cuándo usarla

Cuando recibes encargos de animación por mensajes sueltos y quieres tener cada proyecto ordenado en una hoja y una respuesta preparada en minutos.

## Cómo ganar dinero con ella

Montas este flujo para otros freelances o estudios de animación y cobras por la instalación y por el mantenimiento de la hoja y las plantillas de respuesta.


## La receta, paso a paso

QUÉ HACE
Cuando un cliente rellena tu formulario de encargo de animación, el flujo guarda una fila con los datos en una hoja de cálculo de Google (la ficha del proyecto) y crea en tu Gmail un borrador de respuesta dirigido a esa persona.
El borrador NO se envía: lo abres, lo lees, lo completas y lo envías tú. No hay ninguna IA ni ningún paso de envío automático.
Horas, tarifa y costes externos los rellenas tú en la hoja (no hay columna de total: lo calculas tú con la fórmula del nodo 3).

QUÉ NECESITAS
- n8n, en la nube o en tu servidor. El formulario solo funciona para tus clientes si tu n8n es accesible desde internet. Compruébalo en la ayuda oficial de n8n según cómo lo tengas instalado.
- Una cuenta de Google con Google Sheets y Gmail, y conectar ambas a n8n con las credenciales que guía n8n (OAuth2). Sigue la guía oficial de n8n para cada una. Nunca escribas claves o contraseñas dentro de los nodos.
- Una hoja de Google llamada «Proyectos de animación», con una pestaña «Proyectos». En la fila 1, estos encabezados, uno por columna y escritos igual: id_proyecto, fecha_recepcion, estado, cliente, email, empresa, descripcion, uso, duracion_segundos, fecha_limite, material, referencias, horas_estimadas, tarifa_hora, costes_externos, notas.
- Una política de privacidad publicada y un texto de consentimiento para el formulario. Comprueba la norma vigente sobre protección de datos o consulta con tu asesoría.

PASOS
Nodo 1 · n8n Form Trigger (nómbralo «Formulario de encargo»).
- Form Title: «Encargo de animación».
- Form Description: «Cuéntame qué quieres animar. Usaré estos datos solo para responderte. Más información: [ENLACE A TU POLÍTICA DE PRIVACIDAD]».
- Form Fields (Add Form Element, uno por campo; la etiqueta es «Label»; el dato sale en el flujo con ese mismo nombre salvo que rellenes «Custom Field Name»):
  - Nombre · Text Input · obligatorio.
  - Email · Email · obligatorio.
  - Empresa · Text Input.
  - Qué quieres animar · Textarea · obligatorio.
  - Uso · Dropdown · opciones: Redes sociales, Web, Presentación, Publicidad, Otro.
  - Duración aproximada en segundos · Number.
  - Fecha límite deseada · Date.
  - Material que ya tienes · Dropdown · opciones: Logo, Ilustraciones, Guion, Nada todavía.
  - Referencias · Text Input (enlaces a ejemplos que le gusten).
  - Consentimiento · Checkboxes, con una sola opción: «Acepto que uses mis datos para responder a esta solicitud» · obligatorio.

Nodo 2 · Edit Fields (Set) (nómbralo «Ordenar datos»).
- Mode: Manual Mapping. Deja desactivado «Include Other Input Fields».
- Añade estos campos. Arrastra cada valor desde el panel izquierdo (Input) a la caja para que n8n escriba la expresión por ti:
  - id_proyecto: {{ $now.toFormat('yyyyMMdd-HHmmss') }}
  - fecha_recepcion: {{ $now.toFormat('yyyy-MM-dd') }}
  - estado: Nuevo (texto fijo)
  - cliente: el campo Nombre del formulario.
  - email: el campo Email.
  - empresa: el campo Empresa.
  - descripcion: el campo Qué quieres animar.
  - uso: el campo Uso.
  - duracion_segundos: el campo Duración aproximada en segundos.
  - fecha_limite: el campo Fecha límite deseada.
  - material: el campo Material que ya tienes.
  - referencias: el campo Referencias.
- Estos nombres deben coincidir con los encabezados de la hoja.

Nodo 3 · Google Sheets (nómbralo «Ficha en la hoja»).
- Credential to connect with: tu cuenta de Google.
- Resource: Sheet Within Document. Operation: Append Row.
- Document: By ID o From list, elige «Proyectos de animación». Sheet: «Proyectos».
- Mapping Column Mode: Map Each Column Manually. Para cada columna, arrastra el campo del mismo nombre de la entrada. Deja sin rellenar horas_estimadas, tarifa_hora, costes_externos y notas.
- Cuando lo rellenes tú: total = horas_estimadas × tarifa_hora + costes_externos. Usa tu propia tarifa y tus propias horas; este flujo no las calcula.

Nodo 4 · Gmail (nómbralo «Borrador de respuesta»).
- Credential to connect with: tu cuenta de Gmail.
- Resource: Draft. Operation: Create.
- Subject: Tu encargo de animación: recibido ({{ $('Ordenar datos').item.json.id_proyecto }})
- Email Type: Text.
- Message (cambia lo que va entre corchetes y revisa el resto):
  Hola {{ $('Ordenar datos').item.json.cliente }},
  Gracias por escribirme. He recibido tu solicitud para animar: {{ $('Ordenar datos').item.json.descripcion }}.
  Voy a revisarla con calma. [AQUÍ TE PONES TÚ UN PLAZO PARA RESPONDER, SI QUIERES] Si necesito más información, te la pediré en otro correo.
  Un saludo,
  [TU NOMBRE]
- En Options (Add Option), busca el campo del destinatario, que se llama To Email (parámetro sendTo), y pon: {{ $('Ordenar datos').item.json.email }}.
- No añadas ningún nodo de envío (Gmail › Send). El borrador se queda en Borradores.

Conexiones: Formulario de encargo → Ordenar datos → Ficha en la hoja → Borrador de respuesta.

CÓMO PROBARLO
1. Abre el nodo del formulario y copia la Test URL. Rellena el formulario con datos inventados y un email tuyo.
2. Pulsa Execute workflow antes de enviar el formulario. Comprueba nodo por nodo que la salida tiene datos.
3. Mira la hoja: debe haber una fila nueva con todas las columnas en su sitio.
4. Mira Gmail > Borradores: debe estar el borrador dirigido a tu email de prueba, con el nombre y la descripción bien puestos.
5. Cuando todo salga bien, activa el flujo (Active) y usa la Production URL del formulario. Haz una última prueba real y borra después las filas de prueba.

ERRORES TÍPICOS
- Cambias el nombre de un campo del formulario y la expresión deja de encontrarlo: vuelve a arrastrarlo desde el panel de entrada.
- Los encabezados de la hoja no coinciden con los nombres del nodo 2 y se rellenan columnas equivocadas o vacías.
- El borrador sale sin destinatario: el campo de destinatario está en Options y no se ha añadido.
- El formulario no abre para tus clientes porque tu n8n no es accesible desde internet.
- Si falla un nodo, la solicitud solo queda en el historial de ejecuciones de n8n. Mira ese historial cada día los primeros días y, si quieres, configura un Error Workflow que te avise a ti.

QUÉ NO HACER
- No envíes ninguna respuesta automáticamente: lee cada borrador y complétalo.
- No prometas precios ni plazos en el borrador: eso va en la propuesta, cuando hayas calculado el alcance con tus horas.
- No guardes más datos de los que pides. Limita quién abre la hoja y bórralos cuando no los necesites; comprueba la norma vigente de protección de datos.
- Si la conexión de Google deja de funcionar pasado un tiempo, vuelve a conectarla; compruébalo en la ayuda oficial de Google y n8n.
