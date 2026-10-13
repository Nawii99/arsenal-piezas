# Reparto controlado de claves a creadores de contenido…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Recibe solicitudes de claves de tu juego, comprueba el canal de YouTube de quien la pide, y solo si cumple el mínimo le asigna una clave del listado y se la envía.

## Qué es y qué hace

Flujo de n8n que recibe solicitudes de claves con un formulario, comprueba con la API de YouTube que el canal existe y cumple un mínimo de suscriptores y vídeos, y solo entonces asigna una clave libre de tu hoja y la marca como usada. Entran nombre, correo, canal y plataforma; sale la clave enviada por correo y las peticiones que no pasan el filtro en una pestaña de revisión. Necesita una clave de la API de YouTube y Google Sheets.

## Cómo usarla

1. 1. Pega tus claves de Steamworks en la hoja
2. 2. Pon tu clave de YouTube y los mínimos de suscriptores
3. 3. Publica el formulario y revisa a mano la pestaña de revisión
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando anuncias que das claves de prensa y te llegan cientos de peticiones, la mayoría de canales fantasma que revenden la clave a los dos días.

## Cómo ganar dinero con ella

Ahorra la tarde entera de revisar canales uno a uno y evita regalar claves que acaban en webs de reventa, que es dinero perdido directo.

- Gestión de claves de prensa para estudios que lanzan y no quieren regalar claves a canales fantasma.
- Campaña de creadores ordenada para desarrolladores que reparten claves por lista, sin repetidos.
- Filtro de solicitudes para editoras pequeñas que reparten claves en festivales y necesitan trazabilidad.

**Precio orientativo:** 120–300 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un formulario recoge el correo y el enlace del canal. El flujo consulta la API de YouTube, mira suscriptores y actividad reciente, y solo entonces asigna una clave sin repetir.
Para el desarrollador que va a lanzar y quiere una campaña de creadores ordenada, sin hoja de cálculo caótica ni claves duplicadas.

## Lo que necesitas antes
Un formulario: el nodo **n8n Form Trigger** te vale y es gratis, con los campos `nombre`, `email`, `canal_youtube` y `plataforma`.
Una clave de la API de YouTube: entra en `console.cloud.google.com`, crea un proyecto, activa `YouTube Data API v3` en Biblioteca y genera una clave en Credenciales. Es gratis con cuota diaria.
Credenciales de Google Sheets OAuth2 y Gmail OAuth2 en n8n.
Una hoja con dos pestañas. `claves`: columnas `clave`, `estado` (`libre` u `dada`), `asignada_a`, `fecha`. Pega ahí las claves que te da Steamworks. `solicitudes`: `fecha`, `nombre`, `email`, `canal`, `suscriptores`, `veredicto`.
Decide tus mínimos antes: por ejemplo 1.000 suscriptores y al menos un vídeo en los últimos 90 días.

## Los nodos, en orden
1) **n8n Form Trigger** — con los cuatro campos y un texto legal de que guardas los datos.
2) **Code** — saca el identificador del canal a partir de la URL que ha pegado (soporta `/channel/UC...`, `/@usuario` y `/c/nombre`).
3) **HTTP Request** — GET a `https://www.googleapis.com/youtube/v3/channels?part=statistics,snippet&id={{ $json.id }}&key=TU_CLAVE`. Si el usuario dio un `@handle`, usa `&forHandle={{ $json.handle }}` en vez de `id`.
4) **IF** — condiciones combinadas: `{{ $json.items[0].statistics.subscriberCount }}` mayor que `1000`.
5) Rama falsa: **Gmail** con un «gracias, esta vez no» amable y **Google Sheets** (`Append`) en `solicitudes` con veredicto `rechazada`.
6) Rama verdadera: **Google Sheets** (`Get Row(s)`) en la pestaña `claves` filtrando `estado` igual a `libre`, con `Return All` desactivado y `Limit` a 1.
7) **IF** — comprueba que ha venido alguna clave; si no, avísate a ti mismo de que te has quedado sin existencias.
8) **Google Sheets** (`Update Row`) — marca esa clave como `dada`, con el correo y la fecha. **Este nodo va antes de enviar el correo**, para que si algo falla nunca se asigne dos veces.
9) **Gmail** (`Send`) — envía la clave con las instrucciones de canje y la fecha del embargo.
10) **Google Sheets** (`Append`) en `solicitudes` con veredicto `aceptada`.

## El trozo de código (nodo Code)
```javascript
const url = ($json.canal_youtube || '').trim();
let id = null, handle = null;
const m1 = url.match(/channel\/(UC[\w-]{20,})/);
const m2 = url.match(/@([\w.\-]+)/);
if (m1) id = m1[1];
else if (m2) handle = m2[1];
if (!id && !handle) return [{ json: { ...$json, error: 'URL de canal no reconocida' } }];
return [{ json: { ...$json, id: id || '', handle: handle || '' } }];
```

## Cómo probarla
Mete tres claves de mentira en la hoja (`TEST-1`, `TEST-2`, `TEST-3`) y envía el formulario con tu propio canal.
Envía dos solicitudes seguidas y comprueba que reciben claves distintas y que la hoja marca las dos como `dada`.
Prueba con un canal de 20 suscriptores y comprueba que recibe el correo de rechazo, no una clave.

## Qué puede salir mal
Dos solicitudes en el mismo segundo pueden coger la misma clave. Para evitarlo, en Settings del flujo activa `Execution Order: v1` y limita la concurrencia a 1 (variable `N8N_CONCURRENCY_PRODUCTION_LIMIT=1`).
La cuota gratis de YouTube es de 10.000 unidades al día; una consulta de canal gasta 1, así que te sobra.
Canales con los suscriptores ocultos devuelven `hiddenSubscriberCount: true` y no traen el número: trátalos como rechazo manual y revísalos tú.
Un canal grande no siempre es un buen canal: añade una segunda comprobación de vídeos recientes con `part=contentDetails` si te llegan perfiles comprados.
Guarda el mínimo de datos personales y borra la hoja de solicitudes pasada la campaña; te lo pide el RGPD.

## Cuánto cuesta
Todo gratis: la API de YouTube tiene cuota gratuita de sobra, Sheets, Gmail y el formulario de n8n no cuestan nada.
Gmail gratuito permite unos 500 envíos al día, suficiente para cualquier campaña de lanzamiento.
