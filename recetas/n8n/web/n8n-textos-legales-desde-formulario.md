# Textos legales para clientes: del formulario al Google Doc s…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

El cliente rellena un formulario con los datos de su negocio, n8n genera con IA el borrador de aviso legal, privacidad y cookies, lo guarda en un Google Doc y te avisa para revisarlo.

## Qué es y qué hace

Receta de n8n que recibe las respuestas de un formulario de Tally con los datos del negocio, pide a Claude los tres textos legales, los guarda en un Google Doc con el nombre del cliente y envía un correo con el enlace y los huecos pendientes. No envía nada al cliente: el profesional revisa el borrador primero. Requiere clave de API de pago por uso.

## Cómo usarla

1. Crea el formulario en Tally
2. Conecta el webhook a n8n
3. Revisa el borrador en Google Docs
4. Que lo revise un profesional

## Cuándo usarla

Atiendes a varios clientes que te piden textos legales y pierdes horas recogiendo sus datos por mensajes sueltos. Con el formulario llegan completos y el borrador te espera en un Google Doc.

## Cómo ganar dinero con ella

Úsalo como puerta de entrada de tu servicio de textos legales para webs y cobra por documento entregado, [TU PRECIO]. Antes de enviar nada al cliente, un profesional revisa el borrador.

- Recogida automática de datos legales para varios clientes a la vez…
- Servicio de textos legales por documento entregado con formulario de entrada…
- Mantenimiento de la plantilla de textos legales al cambiar la normativa…

**Precio orientativo:** 60–180 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Receta n8n: textos legales desde un formulario

## Qué hace
El cliente rellena un formulario. n8n coge las respuestas, genera los tres textos legales con IA, los guarda en un Google Doc con el nombre del cliente y te manda un correo con el enlace y la lista de huecos pendientes. El cliente NO recibe nada automáticamente: lo revisas tú primero.

## Cuentas que hacen falta
- **n8n**: gratis si lo instalas tú (self-hosted). En la nube tiene prueba gratuita y después cuesta [precio actual en n8n.io].
- **Tally** (formularios): plan gratuito con formularios y respuestas ilimitadas. Vale también Google Forms, pero Tally tiene webhook directo y es más cómodo.
- **Anthropic** (o OpenAI): clave de API de pago por uso. Cada juego de textos cuesta céntimos, no euros: [comprueba el precio del modelo que uses].
- **Google**: cuenta gratuita para Docs y Gmail.

## Antes de montar nada: el riesgo real
En el formulario van NIF, direcciones y emails de tus clientes. Eso son datos personales y tú eres encargado del tratamiento. Tres cosas que tienes que hacer sí o sí: firmar un contrato de encargo con cada cliente (te lo puede dar un modelo de la AEPD), no meter en el prompt más datos de los necesarios, y mirar en qué región procesa datos tu proveedor de IA. Si no quieres asumirlo, quita el NIF y la dirección del formulario y déjalos como [DATO PENDIENTE] para rellenarlos tú a mano.

## Nodos, en orden

### 1. Tally Trigger (disparador)
Crea el formulario en Tally con estos campos: nombre comercial, razón social o nombre completo, tipo (autónomo / sociedad / profesional colegiado), NIF, dirección postal, email de contacto, dominio de la web, qué recoge la web (casillas: contacto, newsletter, tienda, reservas, área de clientes), herramientas que usa (casillas: Google Analytics, Meta Pixel, Hotjar, YouTube, Google Maps, chat, Mailchimp/Brevo, Stripe, otras), hosting y correo, número de colegiado si aplica.
En n8n: nodo Tally Trigger, evento "New response". Conecta tu cuenta de Tally y elige el formulario.

### 2. Edit Fields (Set)
Renombra cada respuesta con un nombre limpio: nombre, tipo, nif, direccion, email, dominio, recoge, herramientas, hosting, colegiado. Así el prompt no depende de los nombres raros que pone Tally.

### 3. Anthropic (o OpenAI) - Message a model
- System prompt: pega el comando textos-legales-web completo, quitando la cabecera y la línea de $ARGUMENTS.
- User message: "Datos del negocio: nombre {{ $json.nombre }}, tipo {{ $json.tipo }}, NIF {{ $json.nif }}, dirección {{ $json.direccion }}, email {{ $json.email }}, dominio {{ $json.dominio }}, la web recoge {{ $json.recoge }}, herramientas {{ $json.herramientas }}, hosting {{ $json.hosting }}, colegiado {{ $json.colegiado }}. No preguntes nada: lo que falte, déjalo como [DATO PENDIENTE]."
- Esa última frase es importante: en n8n no hay conversación, así que el modelo no puede pedirte datos.
- Max tokens: pon al menos 6000. Los tres textos son largos.

### 4. Google Docs - Create
Título: "Legal - {{ $('Edit Fields').item.json.dominio }} - {{ $now.format('yyyy-MM-dd') }}". Carpeta: una que se llame "Clientes legal" o parecido.

### 5. Google Docs - Update
Acción "Insert". Texto: la salida del nodo de IA. Si el nodo de Docs pierde los títulos en negrita, no pasa nada: es un borrador para revisar, no la versión final.

### 6. Gmail - Send
Para: tu propio correo. Asunto: "Borrador legal listo: {{ dominio }}". Cuerpo: enlace al Doc y esta frase: "Busca [DATO PENDIENTE] antes de enviar nada al cliente".

### 7. (Opcional) Google Sheets - Append row
Una fila por cliente: fecha, dominio, enlace al Doc, estado (borrador / revisado / entregado). Te sirve de lista de trabajo.

## Cómo probarla sin liarla
1. Rellena el formulario con tus propios datos, no con los de un cliente.
2. En n8n pulsa "Test workflow" y mira la salida de cada nodo de uno en uno. Si el nodo de IA devuelve un texto cortado, sube los max tokens.
3. Abre el Doc y comprueba que están los tres documentos, los textos de primera capa y los del banner.
4. Solo cuando el Doc salga bien dos veces seguidas, pon el flujo en "Active".
5. Nunca añadas un nodo que envíe el Doc al cliente directamente. Un NIF mal puesto o una base legal equivocada llegan al cliente sin que lo hayas visto, y la responsabilidad es tuya.

## Lo que esta automatización no hace
No sustituye la revisión: cada borrador lo lees tú antes de entregarlo. No comprueba las cookies reales de la web del cliente: eso lo haces con el JSON de política de cookies de este arsenal, pasando la lista que ves en el navegador. Y no genera condiciones de venta completas para tiendas: si el cliente vende, esa parte va aparte y con abogado.
