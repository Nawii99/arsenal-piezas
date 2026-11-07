# Radar de la competencia en YouTube…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Vigila los canales de tu sector y te avisa por Telegram en cuanto publican, guardando en una hoja el título, el enlace y las visitas a las 48 horas.

## Qué es y qué hace

Es una automatización de n8n que revisa cada hora el feed RSS público de los canales que indiques, te avisa por Telegram de cada vídeo nuevo y guarda en una hoja el título, el enlace y las visitas a las 48 horas. Entra una lista de IDs de canal y tu bot de Telegram; sale un aviso por vídeo y un registro en Sheets. La clave de YouTube Data API es opcional, solo para las visitas.

## Cómo usarla

1. Saca el ID de cada canal a vigilar
2. Crea el bot de Telegram y guarda tu chat_id
3. Añade la lista de canales a la hoja
4. Activa el flujo cada hora

## Cuándo usarla

Úsalo cuando quieras copiar temas que funcionan, detectar tendencias antes que nadie o llevar un registro del ritmo de publicación de tus competidores.

## Cómo ganar dinero con ella

Sustituye 20-30 min diarios de revisar canales a mano y te da datos reales para decidir qué grabar, en vez de ir a ciegas.

- Vigilancia de competidores para agencias que entregan informes a sus clientes.
- Radar de tendencias para creadores que quieren grabar temas que ya funcionan.
- Alertas de canales del sector para empresas que siguen a proveedores o rivales.

**Precio orientativo:** 100–250 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada hora comprueba los canales que le indiques usando su feed RSS público de YouTube, detecta vídeos nuevos, te los manda por Telegram y los apunta en una hoja. Dos días después vuelve a mirar cuántas visitas llevan.
Para creadores, agencias y negocios que quieren saber qué está funcionando en su nicho sin suscribirse a herramientas de pago.

## Lo que necesitas antes
- n8n (auto-alojado o cloud).
- El ID de cada canal a vigilar: abre el canal, botón derecho → Ver código fuente, busca `channelId`. O usa una web tipo commentpicker que te lo saca del enlace.
- Un bot de Telegram: habla con **@BotFather**, `/newbot`, guarda el token; escribe a tu bot y saca tu `chat_id` abriendo `https://api.telegram.org/bot<TOKEN>/getUpdates`.
- Clave de **YouTube Data API v3** (Google Cloud → Credenciales → Clave de API), solo si quieres las visitas.
- Una hoja con columnas: `canal`, `titulo`, `video_id`, `url`, `publicado`, `visitas_48h`.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: `Hours`, cada 1 hora.
2. **Code** (lista de canales) — devuelve una fila por canal:
```javascript
const canales = [
  { canal: 'Competidor A', id: 'UCxxxxxxxxxxxxxxxxxxxxxx' },
  { canal: 'Competidor B', id: 'UCyyyyyyyyyyyyyyyyyyyyyy' }
];
return canales.map(c => ({ json: { ...c, url: `https://www.youtube.com/feeds/videos.xml?channel_id=${c.id}` } }));
```
3. **RSS Read** — URL: `{{ $json.url }}`. Options: `Ignore SSL Issues` desactivado.
4. **Google Sheets** (Get Row(s)) — trae toda la hoja para comparar.
5. **Code** (filtrar novedades) — se queda solo con lo que no está ya registrado:
```javascript
const vistos = new Set($('Google Sheets').all().map(i => i.json.video_id));
const nuevos = [];
for (const item of $input.all()) {
  const id = (item.json.link || '').split('v=')[1];
  if (!id || vistos.has(id)) continue;
  const horas = (Date.now() - new Date(item.json.pubDate).getTime()) / 3600000;
  if (horas > 48) continue;
  nuevos.push({ json: { video_id: id, titulo: item.json.title, url: item.json.link, publicado: item.json.pubDate, canal: item.json.author } });
}
return nuevos;
```
6. **Google Sheets** (Append Row) — añade cada vídeo nuevo.
7. **Telegram** (Send Message) — Chat ID el tuyo, Text: `🎬 {{ $json.canal }} ha publicado: {{ $json.titulo }} — {{ $json.url }}`.

## Segundo flujo: las visitas a las 48 horas
1. **Schedule Trigger** — una vez al día a las 09:00 (`Europe/Madrid`).
2. **Google Sheets** (Get Row(s)) — Filters: `visitas_48h` vacío.
3. **Code** — se queda con los que ya tienen más de 48 h y junta los IDs de 50 en 50.
4. **HTTP Request** — GET `https://www.googleapis.com/youtube/v3/videos?part=statistics&id={{ $json.ids }}`, con Authentication: Generic > Query Auth con una credencial de n8n (Name `key`, Value tu clave). No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él.
5. **Google Sheets** (Update Row) — escribe `visitas_48h` con `{{ $json.statistics.viewCount }}`.

## Cómo probarla
- Mete un canal muy activo y ejecuta a mano: deberían llegarte los vídeos de las últimas 48 horas y ninguno repetido en la segunda ejecución.
- Manda un mensaje de prueba al bot antes: si nunca le has escrito, Telegram bloquea los envíos.

## Qué puede salir mal
- **El feed RSS solo trae los 15 últimos vídeos**: con canales que publican varias veces al día, baja el Schedule a cada 30 minutos.
- **Duplicados**: dependen de que la hoja se lea antes de escribir; si ejecutas dos veces a la vez, activa en n8n la opción de ejecución en cola o usa `Settings → Execution Order: v1`.
- **Cuota de la API**: `videos.list` gasta 1 unidad por llamada de hasta 50 IDs, ni te acercas al límite.
- **Zona horaria**: pon `GENERIC_TIMEZONE=Europe/Madrid` en n8n o las horas te saldrán en UTC.

## Cuánto cuesta
- Todo gratis: RSS de YouTube, Telegram y la cuota diaria de la API sobran.
- Solo pagas el alojamiento de n8n si no lo tienes ya.
