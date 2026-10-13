# Reparto de claves a creadores con aprobación manual…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Los creadores piden clave en un formulario, tú das visto bueno en Telegram, n8n envía la clave y anota quién la recibió.

## Qué es y qué hace

Flujo de n8n con aprobación manual para repartir claves de juego: el creador rellena un formulario, recibes un aviso en Telegram con sus datos, y al marcar sí en una hoja, n8n envía la clave por correo y la registra. Nadie recibe clave sin revisión humana. No detecta cuentas falsas por sí solo; sirve para decidir y dejar registro.

## Cómo usarla

1. Crea el formulario y la hoja de aprobación
2. Conecta el aviso de Telegram
3. Prueba con una clave de prueba
4. Revisa cada solicitud antes de aprobar

## Cuándo usarla

Anuncias un juego y de golpe llegan decenas de peticiones de clave, sin saber cuáles son de creadores reales y cuáles de cuentas falsas.

## Cómo ganar dinero con ella

Móntasela a un estudio como parte de su servicio de prensa, o cóbrala como instalación suelta por [TU PRECIO] más una cuota mensual de mantenimiento.

- Gestión de claves para estudios que anuncian un juego con muchas peticiones…
- Montaje de reparto de claves como parte del servicio de prensa…
- Registro de claves enviadas para informes del estudio…

**Precio orientativo:** 80–200 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Reparto de claves a creadores con aprobación manual (n8n)

Qué hace: un creador rellena un formulario pidiendo clave, tú recibes un aviso en Telegram con sus datos, marcas "sí" o "no" en una hoja de cálculo desde el móvil, y n8n manda la clave por correo y la apunta en el registro. Nadie recibe clave sin que una persona lo haya aprobado.

Por qué merece la pena: cuando anuncias un juego llegan decenas de peticiones, y buena parte son cuentas falsas que revenden la clave. Este montaje no detecta el fraude por ti, pero te obliga a mirar cada una y te deja registro de todo.

## Cuentas que hacen falta y su límite gratuito

- n8n: la versión que instalas tú (self-hosted) es gratis. La versión en la nube tiene prueba gratuita limitada [comprueba la duración actual en n8n.io] y después se paga al mes.
- Tally (formulario): plan gratuito con respuestas ilimitadas. Vale también Google Forms.
- Google Sheets: gratis con cuenta de Google.
- Gmail: gratis. Límite de envío de unos 500 correos al día en cuentas personales. Sobra para esto.
- Telegram: gratis. Hay que crear un bot con @BotFather (dos minutos) y anotar el token y tu chat_id.

## Preparación antes de tocar n8n

1. Crea una hoja de Google Sheets llamada `claves` con dos pestañas.
2. Pestaña `stock`: columnas `clave`, `plataforma`, `usada` (vacío o SI), `enviada_a`, `fecha`. Pega aquí las claves que te haya dado el estudio.
3. Pestaña `peticiones`: columnas `fecha`, `nombre`, `correo`, `canal`, `plataforma`, `aprobado` (vacío, SI o NO), `enviada` (vacío o SI).
4. Crea el formulario en Tally con estos campos: nombre, correo, enlace al canal, plataforma que quiere (lista: Steam, itch.io), mensaje. Activa la integración con Webhook en Tally y deja a mano la URL que te dará n8n en el paso siguiente.

## Flujo 1: recibir la petición

Nodo 1 · Webhook (disparador): método POST. Copia la URL de producción y pégala en Tally como webhook. Cada envío del formulario dispara el flujo.

Nodo 2 · Set: renombra los campos que llegan de Tally a nombres limpios: `nombre`, `correo`, `canal`, `plataforma`, `mensaje`. Añade `fecha` con la expresión `{{ $now.toFormat('yyyy-MM-dd HH:mm') }}`.

Nodo 3 · Google Sheets (Append): pestaña `peticiones`. Mapea las columnas. Deja `aprobado` y `enviada` vacías.

Nodo 4 · Telegram (Send Message): al chat_id tuyo. Texto sugerido: `Nueva petición de clave. Nombre: {{ $json.nombre }}. Canal: {{ $json.canal }}. Correo: {{ $json.correo }}. Plataforma: {{ $json.plataforma }}. Abre la hoja y pon SI o NO en aprobado.` Añade el enlace a la hoja en el mismo mensaje para abrirla desde el móvil.

Con esto tú recibes el aviso, entras al canal, compruebas que el correo del formulario coincide con el que muestra el canal en su sección de contacto, y escribes SI o NO en la hoja.

## Flujo 2: enviar la clave a los aprobados

Nodo 1 · Schedule Trigger (disparador): cada 15 minutos. No hace falta que sea al instante.

Nodo 2 · Google Sheets (Get Many Rows): pestaña `peticiones`. Filtro: `aprobado` igual a SI y `enviada` vacía.

Nodo 3 · IF: si no hay filas, termina aquí. Si hay, sigue.

Nodo 4 · Loop Over Items: para procesar una petición cada vez y no gastar dos claves en una sola persona.

Nodo 5 · Google Sheets (Get Many Rows): pestaña `stock`. Filtro: `plataforma` igual a la de la petición y `usada` vacía. Limita a 1 resultado.

Nodo 6 · IF: si no hay clave disponible, manda un Telegram diciendo `Sin claves de {{ plataforma }} para {{ nombre }}` y salta a la siguiente petición. No mandes correo.

Nodo 7 · Gmail (Send): destinatario el correo de la petición. Asunto: `Tu clave de [NOMBRE DEL JUEGO]`. Cuerpo corto: gracias por el interés, aquí la clave, fecha de embargo si la hay, enlace a la carpeta de materiales, correo de contacto. Sin adjuntos.

Nodo 8 · Google Sheets (Update): pestaña `stock`, la fila de la clave usada. Pon `usada` = SI, `enviada_a` = correo, `fecha` = ahora.

Nodo 9 · Google Sheets (Update): pestaña `peticiones`, la fila procesada. Pon `enviada` = SI.

Nodo 10 · Telegram: `Clave enviada a {{ nombre }} ({{ plataforma }}). Quedan {{ número }} en stock.` Para el número, cuenta las filas sin usar en un nodo Google Sheets previo o déjalo fuera si te complica.

## Cómo probarla sin liarla

1. En la pestaña `stock` pon solo dos claves falsas tipo `PRUEBA-0001` mientras pruebas. Las reales las pegas cuando todo funcione.
2. Rellena el formulario con tu propio correo. Comprueba que llega el Telegram y que aparece la fila en `peticiones`.
3. Escribe SI en `aprobado` y ejecuta el flujo 2 a mano con el botón de prueba de n8n, sin activarlo. Mira que llega el correo, que la clave pasa a `usada` = SI y que la petición pasa a `enviada` = SI.
4. Ejecuta el flujo 2 otra vez. No debe enviar nada. Si envía, el filtro de `enviada` está mal.
5. Pon NO en una petición y comprueba que no se mueve nada.
6. Solo entonces activa el flujo 2 y sustituye las claves de prueba por las reales.

## Riesgos que tienes que contar al estudio

- Este montaje no comprueba si el creador es real. Lo compruebas tú antes de escribir SI. Si te saltas ese paso, es un reparto automático a cualquiera.
- Las claves están en una hoja de Google. Quien tenga acceso a la hoja tiene las claves. Compártela solo con quien las necesite y no la publiques en ningún sitio.
- Si el estudio quiere repartir cientos de claves, Keymailer o Woovit lo hacen mejor y con verificación de canales. Este flujo es para campañas pequeñas o medianas.

## Cómo cobrarlo

Montaje inicial a precio cerrado: [PRECIO] euros más IVA, incluye formulario, las dos hojas y los dos flujos probados con el cliente delante. Mantenimiento opcional mensual por [PRECIO] euros: revisar que sigue funcionando, cargar claves nuevas y sacar el informe de a quién se han enviado. Si n8n corre en la nube, el coste de la suscripción lo paga el estudio y va aparte.
