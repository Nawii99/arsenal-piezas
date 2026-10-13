# Buzón de fallos: de Sentry a tarea sin duplicados…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Recibe los errores que tu app manda a Sentry, agrupa los repetidos y crea una tarea solo la primera vez, con un aviso si el fallo se dispara.

## Qué es y qué hace

Flujo de n8n que recibe por webhook los errores de tu app enviados a Sentry, lleva un contador por tipo de fallo en una hoja y crea una tarjeta en Trello solo la primera vez que aparece cada uno. Avisa por Telegram si un fallo se dispara. Entran los eventos de Sentry; sale una tarjeta por fallo único y un contador. Requiere cuentas de Sentry y Trello, y un bot de Telegram.

## Cómo usarla

1. 1. Crea el webhook y pégalo en Sentry
2. 2. Genera la clave y el token de Trello
3. 3. Revisa el tablero cada mañana y cierra los fallos arreglados

## Cuándo usarla

Úsalo cuando tu app ya tenga usuarios reales y te lleguen tantos avisos de error que acabes ignorándolos todos.

## Cómo ganar dinero con ella

Convierte el ruido de cientos de alertas en dos o tres tareas de verdad al día. Menos horas de triaje y menos fallos que se quedan olvidados.

- Triaje de errores de apps en producción para equipos sin desarrollador dedicado.
- Tablero de fallos priorizados para agencias que mantienen apps de clientes con pocos recursos.
- Alertas de fallo repetido para estudios de apps que quieren arreglar primero lo que más usuarios afecta.

**Precio orientativo:** 150–350 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Escucha los errores nuevos que tu app iOS o Android envía a Sentry, lleva un contador por tipo de fallo en una hoja y crea una tarjeta en Trello la primera vez que aparece cada uno.
Para quien tiene una app en producción y un desarrollador (o ninguno) y necesita saber qué arreglar primero.

## Lo que necesitas antes
Cuenta de Sentry (su plan gratuito incluye 5.000 errores al mes y es más que suficiente para empezar).
El SDK de Sentry ya instalado en la app; eso lo hace tu desarrollador o lo añades siguiendo la guía de tu framework.
Cuenta de Trello y su clave: entra en trello.com/power-ups/admin, genera API Key y Token. En n8n, Credentials > Trello API.
Bot de Telegram con su token y tu chat_id (con @BotFather).
Una hoja `Fallos` con columnas: fingerprint, titulo, veces, primera_vez, url_sentry.

## Los nodos, en orden
1. **Webhook**: Method POST, Path `sentry-fallos`. Copia la URL de producción que te da n8n.
2. En Sentry, ve a Settings > Integrations > Webhooks (o Alerts > Create Alert Rule > Send a notification via webhook) y pega esa URL. Marca el evento «issue created» y «issue alert».
3. **Code**: normaliza el mensaje de Sentry y crea una huella (fingerprint) del fallo. Código abajo.
4. **Google Sheets** (Get Row(s)) con filtro: columna `fingerprint` igual a `{{ $json.fingerprint }}`.
5. **IF**: condición Number, `{{ $items().length }}`... más sencillo: usa condición String, valor 1 `{{ $json.fingerprint || '' }}`, operación «is empty». Si está vacío, es un fallo nuevo.
6. Rama «fallo nuevo»: **Google Sheets** (Append) con veces = 1 y primera_vez = ahora, y luego **Trello** (operación Create Card) en tu lista «Bugs» con nombre `{{ $('Code').item.json.titulo }}` y descripción con el enlace a Sentry.
7. Rama «ya existía»: **Google Sheets** (Update) sumando 1 a `veces`.
8. **IF** final: si `veces` es mayor o igual a 50, **Telegram** con el mensaje `Fallo repetido 50 veces: ...` para que lo mires ya.

## El nodo Code
```javascript
const cuerpo = $input.first().json.body || $input.first().json;
const issue = cuerpo.data && cuerpo.data.issue ? cuerpo.data.issue : cuerpo;
const titulo = (issue.title || issue.metadata && issue.metadata.type || 'Fallo sin título').slice(0, 120);
const culpa = (issue.culprit || '').slice(0, 120);
const fingerprint = (titulo + '|' + culpa).toLowerCase().replace(/[^a-z0-9|]/g, '').slice(0, 90);
const url = issue.web_url || issue.url || 'https://sentry.io';
return [{ json: { titulo, culpa, fingerprint, url_sentry: url, primera_vez: new Date().toISOString() } }];
```

## Cómo probarla
En Sentry, abre cualquier error y usa el botón de prueba de la integración, o provoca un fallo a propósito en una build de desarrollo.
Con el Webhook en modo «Listen for test event» verás llegar el JSON entero: úsalo para comprobar que el Code saca bien título y culpa.
Manda dos veces el mismo error: la primera debe crear tarjeta en Trello, la segunda solo subir el contador.

## Qué puede salir mal
Sentry manda muchos formatos según el tipo de alerta; por eso el Code mira dos rutas posibles. Si te llega otra, imprime el JSON y ajusta la primera línea.
Si te llegan ráfagas de cientos de eventos por minuto, Google Sheets se atraganta: pon en el workflow Settings el modo «Queue» o mete un nodo **Wait** de 1 segundo antes de escribir.
Zonas horarias: guarda siempre en ISO (como hace el código) y formatea solo al mostrar.

## Cuánto cuesta
Sentry gratis hasta 5.000 errores/mes. Trello gratis. n8n auto-alojado gratis. Solo pagarías Sentry si tu app crece mucho (desde unos 26 $/mes).
