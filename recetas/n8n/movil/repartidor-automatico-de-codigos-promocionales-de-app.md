# Repartidor automático de códigos promocionales de app…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Cuando alguien pide una prueba gratis de tu app, le manda un código promocional único de tu lista, lo marca como usado y avisa cuando quedan pocos.

## Qué es y qué hace

Flujo de n8n que recibe la petición desde un formulario, toma el primer código libre de la hoja Codigos, lo marca como entregado con el correo y la fecha, y lo envía con las instrucciones de canje. Avisa cuando quedan pocos códigos. Entran nombre, correo y plataforma; sale un correo con el código. Requiere códigos generados en App Store Connect o Google Play Console y Gmail conectado.

## Cómo usarla

1. 1. Genera los códigos en App Store Connect o Google Play
2. 2. Crea la hoja Codigos y el formulario
3. 3. Prueba con un código de sobra antes de abrirlo
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando repartas códigos de la App Store o de Google Play a prensa, creadores o primeros usuarios y acabes mandándolos a mano uno a uno.

## Cómo ganar dinero con ella

Ahorra 3-5 minutos por cada petición y evita el error caro de mandar el mismo código a dos personas o quedarte sin stock sin enterarte.

- Reparto de códigos de prueba para apps de pago que regalan accesos a prensa y creadores.
- Gestión de códigos para beta testers de apps que no quieren mandar el mismo código dos veces.
- Campañas de códigos para agencias que lanzan apps de clientes con promociones controladas.

**Precio orientativo:** 120–300 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recoge la petición desde un formulario web, coge el primer código libre de tu hoja, lo marca como entregado y lo manda por correo con las instrucciones de canje.
Para desarrolladores de apps de pago o con suscripción que reparten códigos de prueba a periodistas, influencers o beta testers.

## Lo que necesitas antes
Los códigos: en App Store Connect > tu app > Promo Codes generas hasta 100 por versión; en Google Play Console > Monetizar > Códigos promocionales.
Una hoja `Codigos` con columnas: codigo, plataforma, usado (SI/NO), email, fecha_entrega.
Un formulario que envíe a un webhook: vale el nodo **n8n Form Trigger** (viene incluido y te da una página lista) o un Tally/Google Form con webhook.
Gmail conectado en n8n y un bot de Telegram para los avisos de stock bajo.

## Los nodos, en orden
1. **n8n Form Trigger**: título «Consigue tu código de prueba», campos: Email (obligatorio), Nombre, Plataforma (desplegable iOS/Android). Te da una URL pública que puedes poner en tu web.
2. **Google Sheets** (Get Row(s)): hoja `Codigos`, filtros: `usado` igual a `NO` y `plataforma` igual a `{{ $json.Plataforma }}`. En Options pon Return All desactivado y Limit = 1.
3. **IF**: String, valor 1 `{{ $json.codigo }}`, operación «is not empty».
4. Rama true — **Google Sheets** (Update): fila localizada por columna `codigo`, pon `usado` = SI, `email` = `{{ $('n8n Form Trigger').item.json.Email }}`, `fecha_entrega` = `{{ $now.toISO() }}`.
5. Rama true — **Gmail** (Send): a `{{ $('n8n Form Trigger').item.json.Email }}`, asunto «Tu código de prueba», cuerpo con el código y los pasos de canje.
6. Rama false — **Telegram**: «Se han acabado los códigos de {{ plataforma }}, genera más en la consola».
7. **Google Sheets** (Get Row(s)) al final, filtro `usado` = NO, y un **IF** que si quedan menos de 10 te manda un **Telegram** de aviso.

## Texto del correo que funciona
«Hola {{ nombre }}: aquí tienes tu código: CODIGO. En iPhone, abre la App Store, toca tu foto arriba a la derecha, entra en Canjear código de regalo y pégalo. Caduca en 28 días. Si te atascas, respóndeme a este correo.»
En Android: Play Store > tu foto > Pagos y suscripciones > Canjear código.

## Cómo probarla
Mete tres códigos falsos en la hoja y rellena el formulario con tu propio correo. Debe llegarte el primero y quedar marcado como SI.
Rellena el formulario dos veces más para agotar el stock y comprobar que el aviso de Telegram salta en la cuarta.

## Qué puede salir mal
Duplicados: si dos personas envían el formulario en el mismo segundo pueden llevarse el mismo código. Para evitarlo, en Settings del workflow marca «Limit concurrency» a 1 (o en n8n auto-alojado, ejecuta en modo cola con un solo worker).
Los códigos de la App Store caducan a los 28 días y solo valen para la versión con la que se generaron: apunta la fecha de caducidad en otra columna y descarta los vencidos con un filtro.
Correo a spam: manda desde tu Gmail de siempre y evita asuntos en mayúsculas.

## Cuánto cuesta
Gratis. Los códigos promocionales no cuestan dinero (Apple no te cobra comisión por ellos). n8n auto-alojado, Sheets, Gmail y Telegram, sin coste.
