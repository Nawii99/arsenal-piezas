# Demo personalizada automática…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Un posible cliente rellena un formulario con su negocio y en unos minutos recibe por email un quiz de prueba con su nombre y su temática. Tú recibes aviso en Telegram.

## Qué es y qué hace

Es un flujo de n8n que recibe el formulario de un posible cliente, pide a Claude una serie de preguntas de quiz sobre su negocio, guarda el archivo en GitHub Pages y le envía por email el enlace de su demo. Entra el nombre del negocio y su temática; sale un quiz publicado y un aviso en Telegram.

## Cómo usarla

1. Monta el formulario y el nodo de n8n
2. Conecta la API de Claude y GitHub
3. Prueba con un negocio ficticio antes de activarlo

## Cuándo usarla

Quieres que un posible cliente vea su propio quiz, con su nombre y su temática, antes de decidir si compra, sin preparar cada demo a mano.

## Cómo ganar dinero con ella

Es tu forma de abrir ventas de mini-apps: ofreces la demo gratis y, cuando el negocio ve su quiz funcionando, le propones la versión completa a [TU PRECIO]. Te avisa por Telegram para que le escribas tú.

- Demos automáticas para captar clientes de mini-apps en academias, por instalación…
- Puesta en marcha del flujo para agencias pequeñas, por instalación…
- Mantenimiento mensual de la automatización y de las demos publicadas, por cuota…

**Precio orientativo:** 80–200 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Demo personalizada automática (n8n)

## Qué hace

1. Un posible cliente rellena un formulario: nombre del negocio, a qué se dedica, qué quiere que aprendan sus clientes o alumnos, email.
2. Claude genera 8 preguntas de quiz sobre ese negocio.
3. Se guardan como archivo en tu repositorio de GitHub, donde ya vive tu quiz publicado.
4. Se espera a que GitHub Pages actualice.
5. El posible cliente recibe un email con el enlace a su demo y una propuesta de llamada.
6. Tú recibes un aviso en Telegram con sus datos.

## Cuentas que hacen falta

- **n8n**: gratis si lo instalas tú en un ordenador o servidor que esté encendido; n8n Cloud tiene prueba gratuita y después es de pago [comprobar precio actual].
- **GitHub**: gratis. GitHub Pages en plan gratuito exige que el repositorio sea **público**. Necesitas un token personal con permiso de escritura en ese repositorio.
- **Anthropic API**: de pago por uso. Cada demo consume una llamada pequeña; el coste por demo es de céntimos [comprobar en la página de precios]. Pon un límite de gasto mensual en la consola de Anthropic antes de activar esto.
- **Gmail**: gratis. Cuenta desde la que se envían los emails. Conéctala en n8n como credencial de Google.
- **Telegram**: gratis. Crea un bot con @BotFather y apunta el token y tu chat ID.

## Antes de empezar

Tu quiz publicado en GitHub Pages tiene que leer `?demo=nombre` de la dirección y cargar `demos/nombre.json`. Si no existe ese archivo, debe mostrar el quiz genérico. Pídeselo así a Claude Code y pruébalo a mano subiendo un `demos/prueba.json` antes de montar nada en n8n.

## Nodos, en orden

### 1. Form Trigger (disparador)

Nodo **n8n Form Trigger**. Título: «Pide tu demo gratis». Campos, todos obligatorios:
- `negocio` (texto corto)
- `sector` (desplegable: academia, clínica, tienda, restaurante, gimnasio, otro)
- `tema` (texto largo, etiqueta: «¿Qué quieres que aprendan tus clientes o alumnos?»)
- `email` (email)

Al activar el flujo, n8n te da una dirección pública del formulario. Esa es la que pones en tu web o en tu Instagram.

### 2. Edit Fields (Set)

Crea un campo nuevo `slug` con esta expresión, tal cual:
`{{ $json.negocio.toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '') }}`

Convierte «Academia Sol & Luna» en `academia-sol-luna`. Sirve de nombre de archivo y de dirección. Activa «Include Other Input Fields» para no perder el resto.

### 3. HTTP Request (llamada a Claude)

- Método: POST. URL: `https://api.anthropic.com/v1/messages`
- Authentication: Generic Credential Type > Header Auth, con una credencial de n8n (Name `x-api-key`, Value tu clave). No escribas la clave en el nodo: un flujo exportado o compartido se la llevaría. Cabeceras: `anthropic-version` con `2023-06-01` y `content-type` con `application/json`.
- Cuerpo JSON: modelo `[MODELO QUE USES]`, `max_tokens` 2000, y un único mensaje de usuario con este texto:

«Eres redactor de contenidos educativos. Escribe 8 preguntas tipo test para un quiz del negocio {{ $json.negocio }} (sector: {{ $json.sector }}). Tema: {{ $json.tema }}. Español de España, tono cercano, cada pregunta con 4 opciones y una explicación de una línea. Responde SOLO con un JSON válido con esta forma exacta y nada más, sin comillas triples ni texto alrededor: {"titulo": "...", "preguntas": [{"pregunta": "...", "opciones": ["...","...","...","..."], "correcta": 0, "explicacion": "..."}]}»

El texto de respuesta está en `content[0].text`.

### 4. GitHub (crear archivo)

Nodo **GitHub**, recurso File, operación Create.
- Repositorio: el de tu quiz. Rama: `main`.
- Ruta: `demos/{{ $('Edit Fields').item.json.slug }}.json`
- Contenido: `{{ $json.content[0].text }}`
- Mensaje de commit: `demo {{ $('Edit Fields').item.json.slug }}`

Si el archivo ya existe (mismo negocio dos veces), este nodo falla. Para empezar, acéptalo así: te enterarás por Telegram y lo resolverás a mano. Cuando funcione, cambia la operación a Edit con un nodo IF delante.

### 5. Wait

Nodo **Wait**, 3 minutos. GitHub Pages tarda entre uno y tres minutos en publicar el archivo nuevo. Si mandas el email antes, el enlace sale roto y pierdes al cliente.

### 6. Gmail (email al posible cliente)

- Para: `{{ $('Form Trigger').item.json.email }}`
- Asunto: `Tu demo para {{ $('Form Trigger').item.json.negocio }} ya está lista`
- Cuerpo, texto plano, corto:

«Hola. Aquí tienes un quiz de prueba hecho para {{ negocio }}: https://[TUUSUARIO].github.io/[REPO]/?demo={{ slug }} . Ábrelo en el móvil y dale a «Añadir a pantalla de inicio» para verlo como app. Es una demo con preguntas generadas automáticamente; la versión final la hacemos con tu contenido y tu marca. Si te encaja, respóndeme a este email y buscamos 15 minutos para hablar. [TU NOMBRE]»

Rellena las expresiones con la misma forma que en los nodos anteriores.

### 7. Telegram (aviso para ti)

Nodo **Telegram**, operación Send Message, a tu chat ID:
`Nueva demo: {{ negocio }} ({{ sector }}) - {{ email }} - https://[TUUSUARIO].github.io/[REPO]/?demo={{ slug }}`

## Riesgos que tienes que asumir antes de activarlo

- **El repositorio es público.** El nombre del negocio y las preguntas quedan visibles para cualquiera. Nunca guardes el email ni datos personales en el archivo JSON. Solo el email va por Gmail.
- **Cualquiera puede rellenar el formulario** y cada envío te cuesta dinero en la API. Pon el límite de gasto en Anthropic y revisa el aviso de Telegram a diario. Si te llegan envíos basura, añade un nodo IF tras el formulario que pare el flujo si el `tema` tiene menos de 20 caracteres.
- **Estás tratando el email de una persona.** En el formulario pon una línea de aviso de privacidad: para qué usas el email y que puede pedir que lo borres. Sin esa línea estás incumpliendo el RGPD aunque no guardes nada más.
- **Claude a veces responde con texto alrededor del JSON.** Si eso pasa, el quiz no cargará. En las pruebas ábrelo siempre. Si ocurre a menudo, pídele a Claude Code que el quiz sea tolerante y busque el primer `{` y el último `}` del archivo.

## Cómo probarlo sin liarla

1. Con el flujo **desactivado**, usa el botón «Test workflow» en n8n y rellena el formulario de prueba con **tu propio email** y un negocio inventado, por ejemplo «Prueba Panadería».
2. Mira que en GitHub aparece `demos/prueba-panaderia.json` y que abriéndolo en el navegador se lee como JSON, sin texto raro alrededor.
3. Espera los 3 minutos y abre el enlace de tu email en el móvil. Juega la partida entera.
4. Comprueba que te ha llegado el Telegram.
5. Borra a mano el archivo de prueba en GitHub.
6. Repite una vez más con otro nombre. Solo cuando salga bien dos veces seguidas, activa el flujo y publica la dirección del formulario.
7. La primera semana, revisa cada demo que se genere. Si alguna pregunta es falsa o rara, es tu nombre el que va en el email.
