# Seguimiento de keys enviadas a streamers y prensa…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Lleva la cuenta de a quién le diste una key de tu juego, comprueba sola si ese canal ya ha publicado algo y te avisa de quién no ha dado señales. Para lanzamientos indie con claves.

## Qué es y qué hace

Guarda en una hoja a qué creador enviaste cada key, con su canal y la fecha. Cada día busca en YouTube si ese canal ha publicado un vídeo que mencione tu juego después del envío y marca la fila. Pasados 14 días sin publicación prepara un correo de recordatorio y a los 30 sugiere revocar la key. Entrada: hoja de keys; salida: estado por creador y correos. Se monta en n8n con YouTube Data API y Gmail.

## Cómo usarla

1. Crear la clave de YouTube y la hoja Keys enviadas
2. Conectar Gmail en n8n
3. Probar con dos canales
4. Que lo revise un profesional

## Cuándo usarla

Cuando repartas decenas o cientos de keys de Steam a creadores y prensa y no tengas ni idea de cuántas se han usado ni quién ha publicado vídeo.

## Cómo ganar dinero con ella

Recupera keys sin usar (cada una es venta perdida) y te ahorra 4-6 horas de buscar canal por canal en cada lanzamiento.

- Hacer seguimiento de keys para editoras indie en lanzamiento, cobrando por campaña.
- Ofrecer a estudios el control de qué creadores publican y qué keys siguen sin usar.
- Montar un informe de cobertura de prensa y creadores al cierre de cada lanzamiento.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Partes de una hoja donde apuntas cada key enviada con el nombre del creador, su canal y la fecha. Cada día el flujo busca en YouTube si ese canal ha publicado algún vídeo que mencione tu juego después de la fecha de envío.
Si lo encuentra, guarda el enlace y marca la fila como «publicado». Si pasan 14 días sin nada, te prepara (y opcionalmente envía) un correo de recordatorio amable, y a los 30 días te sugiere revocar la key. Para desarrolladores y pequeñas editoras en campaña de lanzamiento.

## Lo que necesitas antes
Clave de YouTube Data API v3: en Google Cloud Console creas proyecto, activas «YouTube Data API v3» y en «Credenciales» generas una API Key (no hace falta OAuth para búsquedas).
Cuenta de Gmail conectada en n8n con OAuth (para los recordatorios).
Una hoja «Keys enviadas» con columnas: creador, email, canal_id, key, fecha_envio, estado, url_video, recordatorios, notas.
Para sacar el `canal_id` de un canal: abre el canal, ve al código fuente y busca `channelId`, o pega la URL en cualquier extractor de ID de canal. Si solo tienes el @handle, guárdalo y el flujo lo resolverá con una llamada extra.
El nombre exacto de tu juego tal y como lo pondrían en un título, y una o dos variantes (con y sin subtítulo).

## Los nodos, en orden
**Schedule Trigger** — Cron: `0 9 * * 1-5` (de lunes a viernes a las 9:00, Timezone Europe/Madrid).
**Google Sheets** — Get Row(s) de «Keys enviadas», Return All.
**Filter** — `{{$json.estado}}` distinto de `publicado` Y distinto de `revocada`.
**Split In Batches** — Batch Size: 1 (para controlar la cuota de la API y poder esperar entre llamadas).
**HTTP Request** — GET a `https://www.googleapis.com/youtube/v3/search` con Query Parameters: `key` = tu API key, `channelId` = `{{$json.canal_id}}`, `q` = `NOMBRE DE TU JUEGO`, `part` = `snippet`, `type` = `video`, `publishedAfter` = `{{ new Date($json.fecha_envio).toISOString() }}`, `maxResults` = `5`. En Settings activa «Always Output Data» y «Retry On Fail» con 3 intentos.
**Code** — decide el estado y qué hacer (abajo).
**Switch** — Mode: Rules sobre `{{$json.accion}}`: salida 1 `marcar`, salida 2 `recordar`, salida 3 `nada`.
**Google Sheets** (salida 1) — Update Row: `estado` = publicado, `url_video`.
**Gmail** (salida 2) — Send, To: `{{$json.email}}`, Subject: `¿Te llegó bien la key de NOMBRE DEL JUEGO?`, Message: texto corto y sin presionar, con el enlace de prensa y tu contacto.
**Google Sheets** (salida 2) — Update Row: sube `recordatorios` en uno.
**Wait** — 2 segundos, y vuelta al **Split In Batches** para la siguiente fila.

## El nodo Code
```javascript
const fila = $('Split In Batches').item.json;
const items = $json.items || [];
const dias = Math.floor((Date.now() - new Date(fila.fecha_envio)) / 86400000);
const recordatorios = Number(fila.recordatorios || 0);
if (items.length > 0) {
  return { json: { ...fila, accion: 'marcar', url_video: 'https://youtu.be/' + items[0].id.videoId, titulo: items[0].snippet.title } };
}
if (dias >= 14 && recordatorios === 0) return { json: { ...fila, accion: 'recordar', recordatorios: 1 } };
if (dias >= 30 && recordatorios === 1) return { json: { ...fila, accion: 'recordar', recordatorios: 2, notas: 'Candidata a revocar' } };
return { json: { ...fila, accion: 'nada' } };
```

## Cómo probarla
Mete tres filas: un canal que sabes que ya habló de tu juego, uno que no, y uno con fecha de hace 20 días. Ejecuta a mano y comprueba que salen las tres acciones distintas.
Antes de conectar Gmail de verdad, sustituye el nodo por un **NoOp** o mándate el correo a ti mismo cambiando el campo To.
Revisa que `publishedAfter` está en formato ISO completo con la Z al final; si no, la API devuelve error 400.

## Qué puede salir mal
La cuota gratuita de YouTube son 10.000 unidades al día y cada búsqueda cuesta 100: eso son 100 filas al día como máximo. Si tienes más creadores, reparte la lista en dos ejecuciones o filtra por los que llevan menos de 45 días.
Un creador puede publicar sin poner el nombre del juego en el título: la búsqueda mira título y descripción, pero si aun así se escapa, revisa a mano los marcados como «candidata a revocar» antes de revocar nada.
Nunca revoques automáticamente: deja siempre la decisión final en tus manos, quemar la relación con un creador cuesta más que una key.
Si el correo de recordatorio se manda dos veces por un fallo, el contador `recordatorios` te protege; asegúrate de que la actualización de la hoja va después del envío.
Twitch no está cubierto: si te importa, añade una rama con la API de Twitch (client_id y client_secret gratis en dev.twitch.tv) buscando en los VOD del canal.

## Cuánto cuesta
YouTube Data API: gratis dentro de la cuota diaria. Gmail y Sheets: gratis. n8n auto-alojado: gratis.
En Make o Zapier también se puede montar, pero cada fila consume operaciones; con 100 creadores y ejecución diaria te salías del plan gratuito en dos semanas.
