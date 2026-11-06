# Make (make.com): aviso de reseñas nuevas de Google con borra…

**Tipo:** Receta de automatización · **Área:** Marketing · **Licencia:** CC BY 4.0

Un escenario de Make (make.com) que detecta reseñas nuevas de tu ficha de Google, las apunta en una hoja, te avisa por correo y prepara un borrador de respuesta para las de 1 a 3 estrellas.

## Qué es y qué hace

Escenario de Make (make.com) que detecta reseñas nuevas de tu ficha de Google, las anota en una hoja, te avisa por correo y, si tienen de 1 a 3 estrellas, prepara una propuesta de respuesta con una IA de texto. Entran las reseñas de Google Business Profile; salen filas, avisos y borradores. No publica nada en Google. Sirve con Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Crea la hoja Reseñas
2. Conecta la ficha de Google como administrador
3. Escribe la guía de tono con el cliente y pruébala
4. Que lo revise un profesional

## Cuándo usarla

Úsala si el negocio es local, depende de Google Maps y las reseñas se quedan semanas sin contestar.

## Cómo ganar dinero con ella

Cobra [TU PRECIO] por montarla y por escribir con el cliente la guía de tono para las respuestas. Ofrece [TU PRECIO] al mes por revisar los avisos y mantener la conexión.

- Gestión de reseñas para restaurantes, talleres o clínicas con respuestas revisadas antes de publicar.
- Informe mensual de reseñas por local para cadenas pequeñas: valoración media y temas repetidos.
- Guía de tono y plantillas de respuesta para negocios locales que contestan tarde o con prisas.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

QUÉ HACE
Cada reseña nueva de la ficha de Google se guarda en una hoja de Google Sheets y te llega un correo.
Si la reseña tiene de 1 a 3 estrellas, el correo incluye una propuesta de respuesta escrita por una IA de texto.
El escenario no publica nada en Google. La respuesta pública la copias y la publicas tú.
QUÉ NECESITAS
Una cuenta de Make (make.com). Mira en su web cuántas operaciones o créditos incluye tu plan.
Acceso de propietario o administrador a la ficha de Google (Perfil de Negocio). Pídelo al cliente, no uses su contraseña.
Una cuenta de Google con Google Sheets y Gmail.
Una IA de texto: Claude, Codex, Gemini o una IA local. Mira en su web cuánto cobra por uso. Una IA local en tu ordenador no es accesible desde Make salvo que la expongas con seguridad.
Una hoja llamada «Reseñas» con estas columnas: Fecha, Estrellas, Autor, Texto, Estado.
LOS MÓDULOS, EN ORDEN
Módulo 1 · Google My Business › Watch Reviews. Si en tu cuenta la app aparece como Google Business Profile, es la misma: busca el disparador de reseñas nuevas.
- Connection: Add e inicio de sesión con la cuenta que gestiona la ficha. Google puede exigir un permiso especial para usar su API de Perfil de Negocio, y aprobarlo puede tardar. Sigue la ayuda de Make para esa app y avisa al cliente de que no depende de ti.
- Account y Location: elige la cuenta y el local. Si ves Limit, pon 10.
- Choose where to start: para probar, elige una reseña ya publicada como punto de partida (opción «Choose manually» o similar). Para producción, «From now on».
Módulo 2 · Tools › Set multiple variables.
- Variable 1. Nombre: estrellas. Valor: una función switch que convierta ONE en 1, TWO en 2, THREE en 3, FOUR en 4 y FIVE en 5, aplicada al campo de la puntuación, con un último valor por defecto 0. Si tu módulo ya devuelve un número, sáltate esta variable.
- Variable 2. Nombre: texto. Valor: la función ifempty(comentario; "Sin texto") con el campo del comentario de la reseña.
Módulo 3 · Google Sheets › Add a Row.
- Spreadsheet ID: «Select from My Drive». Sheet name: Reseñas. Table contains headers: Yes.
- Fecha: la fecha de creación de la reseña con la función formatDate(...; "DD/MM/YYYY"; "Europe/Madrid"). Si el módulo no la ofrece, usa {{formatDate(now; "DD/MM/YYYY"; "Europe/Madrid")}}, que es el día en que el escenario la procesa.
- Estrellas: la variable estrellas. Autor: el nombre del autor. Texto: la variable texto. Estado: Pendiente de responder.
- Cuando publiques la respuesta, cambia a mano el Estado a «Respondida». El escenario no lo hace.
Módulo 4 · Router (Flow Control › Router). Dos rutas.
Ruta A, de 4 a 5 estrellas. Filtro: estrellas «Greater than or equal to» 4. Módulo: Gmail › Send an Email.
- To: pulsa Add item y escribe tu correo. Subject: «Reseña nueva: » y las estrellas. Content: autor, texto y el enlace a la reseña si el módulo lo ofrece. Separa las líneas con <br>. Añade «Responde cuando puedas».
Ruta B, de 1 a 3 estrellas. Filtro: estrellas «Less than or equal to» 3 y «Greater than» 0. Dos módulos seguidos.
- Primero, la IA de texto (su app en Make o HTTP › Make a request; con HTTP, activa Parse response). Instrucciones: «Redacta una respuesta pública a esta reseña de [NEGOCIO]. Máximo 80 palabras, español de España, tono tranquilo y educado. Agradece el comentario y no discutas. No admitas culpas legales. No menciones datos personales, detalles del servicio ni confirmes que la persona es cliente. Invita a escribir a [EMAIL] o llamar al [TELÉFONO]. No prometas compensaciones.» Mensaje del usuario: estrellas y texto.
- El texto de la reseña lo escribe un tercero y puede incluir órdenes dirigidas a la IA. Por eso la propuesta la lee una persona antes de publicar nada.
- Después, Gmail › Send an Email. To: tu correo. Subject: «Reseña de pocas estrellas: revisa y responde». Content: autor, estrellas, texto de la reseña y, debajo, la propuesta de la IA (el campo con el texto que devuelve el módulo anterior).
CÓMO PROBARLA
Usa UNA reseña real ya publicada como punto de partida en el módulo 1 y pulsa Run once.
Comprueba que hay una fila nueva en la hoja y un correo en tu bandeja.
Si la reseña elegida tiene 3 estrellas o menos, mira que la propuesta de respuesta es educada y no cuenta nada de más.
No crees reseñas falsas para probar: las normas de Google lo prohíben.
Si alguna reseña llega con 0 estrellas en la hoja, revísala a mano: la puntuación no se ha convertido.
Cuando funcione, cambia el punto de partida a «From now on», activa Scheduling y pulsa Save.
CUÁNTO CUESTA
Cada reseña gasta operaciones o créditos por cada módulo que se ejecuta: de 4 a 6 según la ruta. Compruébalo en el historial tras la prueba.
La IA se cobra aparte. Mira en su web cuántas operaciones o créditos incluye tu plan y cuánto cuesta la IA.
QUÉ NO HACER
No publiques la respuesta de la IA sin leerla y adaptarla. La publica una persona.
No pidas ni compres reseñas a cambio de regalos, ni pidas reseña solo a los clientes contentos. Google no lo permite.
No confirmes en una respuesta pública que alguien es cliente o paciente. En una clínica o un negocio de salud esto es especialmente delicado.
No copies datos personales de la reseña (nombre del autor, texto) a otros sitios. La hoja es de uso interno.
QUÉ REVISAR A MANO ANTES DE ACTIVARLA
Que la cuenta conectada tiene el rol correcto en la ficha del local.
Que el correo de aviso llega a alguien que lo mira a diario.
Que las críticas con insultos, amenazas o posible difamación las ve una persona y, si hace falta, un asesor legal. Para pedir a Google que retire una reseña, usa su propio formulario de denuncia.
Que el tono de las respuestas coincide con la voz del negocio.
Que la conexión con Google sigue activa: si caduca, no llegarán avisos y Make lo mostrará en el historial.
Que el nombre de los autores y el texto de las reseñas no se quedan en la hoja más tiempo del necesario.
