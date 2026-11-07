# Reparto controlado de claves de Steam a prensa y creado…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Recoge solicitudes de claves, comprueba que el canal es real (suscriptores, vídeos), asigna una clave única de tu lista y la envía por correo.

## Qué es y qué hace

Flujo de n8n con un formulario de solicitud de claves que comprueba que el canal de YouTube es real (suscriptores y vídeos), que ese correo no ha pedido ya una clave, y asigna una clave única de tu lista. Entran nombre, correo, canal y país; sale el correo con la clave y la hoja actualizada. Las solicitudes que no pasan el filtro quedan para revisión manual. Necesita claves de Steamworks y de la API de YouTube.

## Cómo usarla

1. 1. Descarga las claves de Steamworks a la hoja
2. 2. Pon tu clave de YouTube y los mínimos de filtro
3. 3. Revisa a mano la pestaña de rechazos
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando lanzas o rebajas el juego y te llueven peticiones de claves, muchas de cuentas falsas que revenden, y no quieres repartirlas a ciegas ni llevar la cuenta a mano.

## Cómo ganar dinero con ella

Evita regalar decenas de claves a revendedores y ahorra 5-10 horas de gestión manual en cada lanzamiento.

- Reparto de claves en lanzamientos para estudios que reciben cientos de peticiones de revendedores.
- Gestión de prensa para estudios que quieren trazabilidad de cada clave entregada en festivales.
- Filtro de solicitudes para editoras que reparten claves a creadores y quieren evitar cuentas falsas.

**Precio orientativo:** 150–350 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Publicas un formulario donde el creador pone su nombre, correo, enlace de canal y país. n8n comprueba con la API de YouTube que el canal existe y tiene un mínimo de suscriptores y vídeos, revisa que ese correo no haya pedido ya una clave, coge la primera clave libre de tu hoja, la marca como usada y se la manda con las condiciones. Las peticiones que no pasan el filtro quedan en una pestaña «revisar a mano».
Para estudios que reparten claves en lanzamiento, festivales o campañas con creadores.

## Lo que necesitas antes
- n8n.
- Una hoja de Google con tres pestañas: «claves» (columnas: clave, estado, asignada_a, fecha), «solicitudes» (registro completo) y «revisar» (las rechazadas automáticamente).
- Tus claves generadas en Steamworks: Steamworks → tu juego → «Steam keys» → solicitar paquete de claves → descargar el CSV y pegar las claves en la columna «clave» con estado «libre».
- Clave de API de YouTube Data v3: console.cloud.google.com → habilitar «YouTube Data API v3» → Credenciales → Clave de API. Gratis, 10.000 unidades al día.
- Credencial de Gmail para enviar.

## Los nodos, en orden
1. **Form Trigger** — Campos: nombre, email (tipo Email, obligatorio), enlace_canal, plataforma (desplegable: YouTube / Twitch / Prensa), pais, mensaje.
2. **Google Sheets** («Get Row(s)», pestaña «solicitudes») — Para detectar repetidos.
3. **Code** — Extrae el ID o el handle del canal de la URL y comprueba si el correo ya pidió (código abajo).
4. **IF** «¿Repetido?» — Si `ya_pidio` es true → **Gmail** con un «ya te enviamos una clave» y fin.
5. **HTTP Request** — GET `https://www.googleapis.com/youtube/v3/channels?part=statistics,snippet&forHandle={{ $json.handle }}`, con Authentication: Generic > Query Auth con una credencial de n8n (Name `key`, Value tu clave). No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él.
6. **IF** «¿Cumple mínimos?» — `{{ $json.items[0].statistics.subscriberCount }}` mayor que `500` **Y** `videoCount` mayor que `10`.
7. **Google Sheets** («Get Row(s)», pestaña «claves», filtro estado = libre, límite 1) — Coge la siguiente clave.
8. **Google Sheets** («Update Row») — Marca esa fila como estado `asignada`, `asignada_a` = correo, `fecha` = hoy. **Hazlo ANTES de enviar el correo**.
9. **Gmail** («Send») — Asunto `Tu clave de [NOMBRE DEL JUEGO]`. Cuerpo con la clave, cómo canjearla (Steam → Juegos → Activar un producto), la fecha del embargo y el enlace al kit de prensa.
10. **Google Sheets** («Append Row», pestaña «solicitudes») — Registro con todo.
11. **Google Sheets** («Append Row», pestaña «revisar») — Rama de los que no cumplen mínimos, para que los mires tú.

## El nodo Code
```javascript
const url = ($json.enlace_canal || '').trim();
const m = url.match(/@([A-Za-z0-9._-]+)/);
const handle = m ? '@' + m[1] : '';
const email = ($json.email || '').toLowerCase().trim();
const previas = $('Google Sheets').all().map(i => String(i.json.email || '').toLowerCase());
return [{ json: { ...$json, email, handle, ya_pidio: previas.includes(email) } }];
```

## Cómo probarla
- Mete 3 claves de mentira en la hoja («TEST-1», «TEST-2», «TEST-3») y haz tres solicitudes: una válida, una repetida y una con un canal minúsculo. Comprueba que cada una acaba donde debe.
- Verifica que tras la primera, la clave TEST-1 queda marcada como asignada y la segunda solicitud coge TEST-2.
- Solo cuando todo cuadre, pega las claves reales.

## Qué puede salir mal
- **Dos peticiones a la vez**: pueden llevarse la misma clave. Pon «Concurrency» a 1 en los ajustes del workflow.
- **URLs de canal raras**: hay formatos `/channel/UC...` y `/c/nombre`. Amplía el Code con un segundo `match` para `/channel/(UC[\w-]+)` y usa el parámetro `id=` en la API.
- **Twitch y prensa**: la API de YouTube no sirve. Para esas plataformas manda la solicitud directamente a «revisar» y decide tú.
- **Se acaban las claves**: añade un **IF** que, si no hay filas libres, te avise por correo. Steamworks tarda unas horas en aprobar un lote nuevo.
- **Correo a spam**: envía desde tu dominio con Gmail configurado, no desde una cuenta recién creada.

## Cuánto cuesta
0 €. Las claves de Steam son gratuitas para el desarrollador, la API de YouTube tiene cuota diaria gratis de sobra, Sheets y Gmail gratis. Solo se paga n8n si eliges su nube de pago.
