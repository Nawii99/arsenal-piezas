# Del formulario de encargo al pack entregado por correo, con…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Receta de n8n: un profesor rellena un formulario, la IA genera el borrador del pack, se guarda en Google Drive y te llega un aviso para revisarlo antes de enviarlo. Nada sale solo.

## Qué es y qué hace

Es una receta de n8n que, tras un formulario de encargo y el pago confirmado, pide a Claude el borrador del pack de materiales, lo guarda en Google Drive y te avisa para revisarlo antes de enviarlo al cliente. Entra el encargo; sale un borrador revisable y un correo de entrega con hoja de datos.

## Cómo usarla

1. Monta el formulario y el cobro en n8n
2. Conecta Drive y la API de Claude
3. Revisa cada borrador antes de enviarlo

## Cuándo usarla

Te llegan pedidos de packs de materiales y quieres que el cliente rellene un formulario y pague, y tú solo tengas que revisar el borrador.

## Cómo ganar dinero con ella

Es el flujo de tu servicio de packs educativos: el cliente paga, la IA hace el borrador y tú lo revisas antes de enviarlo, a [TU PRECIO] por pack. Nada sale al cliente sin pasar por ti.

- Flujo de pedidos de packs para academias y profesores, por instalación…
- Mantenimiento mensual del flujo de encargos y su revisión, por cuota…
- Formación a un centro pequeño para revisar borradores, por sesión…

**Precio orientativo:** 150–350 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Del formulario de encargo al pack entregado, con n8n

## Qué hace

1. El cliente rellena un formulario con el encargo.
2. n8n comprueba que ha pagado (o que tú lo has marcado como pagado).
3. La IA genera el borrador del pack con las instrucciones de la skill pack-materiales-clase-cliente.
4. El borrador se guarda en Google Drive como documento.
5. Te llega un aviso por correo o Telegram con el enlace para revisar.
6. Cuando tú lo apruebas (moviendo el archivo a una carpeta), se envía al cliente con la hoja de entrega.

Lo importante: el paso 6 no ocurre solo. Tú revisas siempre antes de que el cliente lo vea. Vender material educativo sin revisar es la forma más segura de perder al cliente a la primera errata.

## Cuentas que hacen falta y sus límites gratuitos

- **n8n**: la versión en la nube tiene prueba gratuita limitada y después es de pago. Instalado en tu propio ordenador o servidor es gratis sin límite de ejecuciones, pero tiene que estar encendido para que funcione el flujo.
- **Tally** (formulario): plan gratuito con formularios y respuestas ilimitadas. También sirve Google Forms.
- **Google Drive y Gmail**: con una cuenta de Google normal es suficiente. El espacio gratuito de Drive es compartido con Gmail y Fotos.
- **Anthropic (Claude) u OpenAI**: se paga por uso, no hay plan gratuito real para la API. Un pack completo cuesta céntimos por generación, pero hay que meter una tarjeta y poner un límite de gasto mensual en el panel de la cuenta antes de activar nada.
- **Telegram** (opcional, para el aviso): gratis. Hay que crear un bot con @BotFather; se hace en cinco minutos desde el móvil.
- **Stripe** (opcional, para cobrar antes de generar): sin cuota fija; cobran una comisión por cada pago. Si no quieres meterte con Stripe al principio, cobra por transferencia o Bizum y marca el pago a mano en el paso 2.

## Nodos, en orden

### 1. Disparador: Tally Trigger (o Google Forms mediante Google Sheets Trigger)

Formulario con estos campos, en este orden: nombre, correo, centro o academia, curso y etapa, asignatura, tema, qué piezas quiere (casillas: presentación, ficha, rúbrica, juego, pack completo), duración de la sesión, alumnado con apoyo (texto libre), herramienta de maquetación (desplegable: Canva, Genially, Google Slides, papel), fecha en la que lo necesita, y una casilla obligatoria de aceptación de condiciones con el texto de tu presupuesto (uso en su centro, sin reventa, una ronda de cambios).

Conecta Tally con n8n desde la pestaña Integrations de Tally pegando la URL del webhook que te da el nodo.

### 2. IF: ¿está pagado?

Dos opciones según cómo cobres:

- Con Stripe: añade antes un nodo Stripe Trigger para el evento de pago completado y cruza el correo del pagador con el del formulario. Si coinciden, sigue.
- Sin Stripe: el formulario guarda la fila en una hoja de Google Sheets con una columna "pagado" vacía. Cuando recibes el Bizum o la transferencia, escribes SÍ en esa columna. Un Google Sheets Trigger de tipo "fila actualizada" arranca el resto del flujo.

Si no está pagado, el flujo termina aquí. No se generan materiales para nadie que no haya pagado el 50 % inicial.

### 3. Set: construir el encargo

Un nodo Set que junta todos los campos del formulario en un solo texto llamado encargo, con este formato: una línea por campo, "Campo: valor". Es lo que leerá la IA.

### 4. Nodo de IA: generar el borrador

Usa el nodo de Anthropic o de OpenAI en modo chat.

- Mensaje del sistema: pega el contenido de la skill pack-materiales-clase-cliente desde la línea que empieza por "# Pack de materiales" hasta el final. Añade al principio esta frase: "No hagas preguntas. Si falta un dato, escríbelo como [SUPUESTO] o [A CONFIRMAR CON EL DOCENTE] y sigue." Es imprescindible: dentro de n8n no hay nadie para responder preguntas.
- Mensaje del usuario: el campo encargo del nodo anterior.
- Longitud máxima de respuesta: ponla alta (la que permita el modelo), un pack completo es largo.

### 5. Google Docs: crear el documento

Nodo Google Docs con la operación Create. Título: "BORRADOR - [tema] - [curso] - [nombre del cliente]". Después, un segundo nodo Google Docs con Update para insertar el texto generado. Guárdalo en una carpeta de Drive llamada "1 - Por revisar".

### 6. Aviso para ti: Gmail o Telegram

Mensaje corto: cliente, tema, curso, fecha en la que lo necesita y el enlace al documento. Si usas Telegram te llega al móvil al momento.

### 7. Segundo flujo: entrega al aprobar

Es un flujo separado en n8n, con su propio disparador:

- **Google Drive Trigger**, evento "archivo movido o creado" sobre la carpeta "2 - Aprobados".
- **Google Docs: Get** para leer el contenido.
- **Google Sheets: Lookup** para recuperar el correo del cliente por el nombre del archivo o por una columna de identificador.
- **Gmail: Send** al cliente con un texto corto de entrega, el documento adjunto en PDF (activa la exportación a PDF en el nodo de Google Drive Download antes de enviar) y el recordatorio del 50 % restante con tus datos de pago en [CORCHETES].
- **Google Drive: Move** del archivo a la carpeta "3 - Entregados".

Tu trabajo entre los dos flujos es abrir el borrador, corregir lo que haga falta, quitar la palabra BORRADOR del título y arrastrarlo a "2 - Aprobados". Eso es todo.

## Riesgos que tienes que saber

- El borrador de la IA puede contener errores de contenido curricular. Por eso el flujo no envía nada sin tu revisión. No quites ese paso para "ir más rápido".
- Estás tratando datos personales de clientes (nombre, correo, centro). Si cobras por esto, necesitas una política de privacidad enlazada en el formulario y saber dónde se guardan los datos. En Tally puedes activar la casilla de consentimiento; no la quites.
- Si el flujo genera muchos packs seguidos por error (por ejemplo, un bucle mal configurado), la factura de la API sube. Pon un límite de gasto en el panel de Anthropic u OpenAI antes de activar.
- Si instalas n8n en tu ordenador y lo apagas, los formularios que lleguen mientras tanto no se procesan hasta que lo enciendas. Tally guarda las respuestas; el problema es que el cliente no recibe nada y tú no te enteras.

## Cómo probarla sin liarla

1. Desactiva el segundo flujo (entrega). Solo vas a probar el primero.
2. En el nodo de IA, cambia temporalmente el mensaje del usuario por un encargo corto y fijo ("Tema: fracciones. Curso: 5º Primaria. Piezas: solo rúbrica.") para que las pruebas cuesten céntimos.
3. Rellena el formulario tú mismo con tu propio correo. Marca el pago a mano en la hoja.
4. Comprueba que aparece el documento en "1 - Por revisar" y que recibes el aviso.
5. Abre el documento y busca las palabras SUPUESTO y CONFIRMAR. Si el modelo ha inventado criterios de evaluación en lugar de marcarlos, refuerza la frase del mensaje del sistema y repite.
6. Vuelve a poner el mensaje del usuario original (el campo encargo).
7. Activa el segundo flujo y mueve tu documento de prueba a "2 - Aprobados". El correo debe llegarte a ti, con el PDF adjunto.
8. Solo después de recibir ese correo, publica el enlace del formulario a un cliente real. Al primero, avísale de que estás estrenando el sistema y revisa el envío a mano.
