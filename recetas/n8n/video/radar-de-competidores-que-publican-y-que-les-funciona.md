# Radar de competidores: qué publican y qué les funciona…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Detecta cada vídeo nuevo de los canales que vigilas y, tres días después, mide cuántas visitas lleva para avisarte solo de los que están despegando.

## Qué es y qué hace

Vigila los canales que indiques: el primer flujo lee sus feeds RSS públicos y anota cada vídeo nuevo en una hoja; el segundo, tres días después, consulta las visitas con la API de YouTube y avisa por Telegram si superan tu umbral. Entrada: Channel ID de competidores; salida: hoja Competencia y avisos. Se monta en n8n y el RSS no gasta cuota de la API.

## Cómo usarla

1. Saca los Channel ID de tus competidores
2. Crea la hoja Competencia
3. Activa los dos flujos
4. Ajusta el umbral de visitas tras una semana de datos

## Cuándo usarla

Cuando compites en un nicho concreto de YouTube y quieres saber qué formatos y temas están tirando sin pasarte el día mirando canales ajenos.

## Cómo ganar dinero con ella

Te da temas ya validados por el mercado antes de invertir un día de rodaje. Sustituye la ronda semanal de espionaje manual, que come 2-3 horas.

- Informe quincenal de competencia para marcas que pelean las mismas búsquedas en YouTube.
- Vigilancia de nicho para creadores que quieren saber qué temas están despegando.
- Radar de canales configurado una vez para agencias que gestionan varios clientes.

**Precio orientativo:** 30–100 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Son dos flujos: uno apunta en una hoja cada vídeo nuevo de tus competidores usando el RSS público de YouTube (sin gastar cuota), y otro, a los tres días, consulta las visitas y te avisa por Telegram solo si el vídeo ha superado el umbral que marques. Es para negocios y creadores que compiten por las mismas búsquedas.

## Lo que necesitas antes
- n8n.
- Los Channel ID de tus competidores: abre su canal, ve al código fuente con Ctrl+U y busca `channel_id`, o pega la URL en cualquier buscador de channel ID.
- Clave de API de YouTube Data v3 (solo para el segundo flujo).
- Hoja «Competencia» con columnas: canal, titulo, videoId, url, publicado, visitas_72h, avisado.
- El RSS de cada canal es `https://www.youtube.com/feeds/videos.xml?channel_id=UCxxxx` y no necesita clave ni cuota.

## Flujo 1: recoger publicaciones
1. **RSS Feed Trigger** — URL del primer competidor, Poll Times cada hora. Duplica el nodo por cada canal, o mejor: usa **Schedule Trigger** + **Google Sheets** (lista de canales) + **Split In Batches** + **RSS Read** para no tener 10 triggers.
2. **Code** («Normalizar») — extrae videoId, título, canal y fecha del feed.
3. **Google Sheets** — operación **Append or Update**, columna clave `videoId`. Así nunca duplicas aunque el RSS repita.

## Flujo 2: medir a los 3 días
4. **Schedule Trigger** — Cron `0 10 * * *`, diario a las 10:00.
5. **Google Sheets** — Get Row(s) de «Competencia».
6. **Code** («Los de hace 3 días») — deja solo filas publicadas hace entre 3 y 4 días y aún sin avisar.
7. **Split In Batches** — Batch Size 50 (videos.list admite 50 IDs de golpe si los juntas por comas; si prefieres simple, 1).
8. **HTTP Request** («Visitas») — GET `https://www.googleapis.com/youtube/v3/videos` con `part=statistics,snippet`, `id={{ $json.ids }}`, y la clave de API con Authentication > `Generic Credential Type` > `Query Auth`: una credencial de n8n con Name `key` y Value tu clave. No la escribas en los parámetros del nodo: un flujo exportado se llevaría la clave.
9. **Code** («Marcar los que despegan») — calcula visitas por día y compara con el umbral.
10. **IF** — `{{ $json.despega }}` is true.
11. **Telegram** — Send Message: `🔥 {{ $json.canal }} — {{ $json.titulo }} · {{ $json.visitas }} visitas en 3 días · {{ $json.url }}`.
12. **Google Sheets** — Update: visitas_72h y avisado = sí.

## El código de «Normalizar»
```js
return items.map(i => {
  const j = i.json;
  const id = (j.id || '').replace('yt:video:', '') || (j.link || '').split('v=')[1];
  return { json: {
    canal: j.author || (j.meta && j.meta.title) || '',
    titulo: j.title,
    videoId: id,
    url: 'https://youtu.be/' + id,
    publicado: (j.pubDate || j.isoDate || '').slice(0, 10),
    avisado: 'no'
  }};
});
```

## El código de «Marcar los que despegan»
```js
const UMBRAL_DIA = 1000; // visitas por día que te parecen mucho en tu nicho
const out = [];
for (const it of items) {
  for (const v of it.json.items || []) {
    const visitas = parseInt(v.statistics.viewCount || '0', 10);
    const dias = Math.max(1, (Date.now() - new Date(v.snippet.publishedAt)) / 86400000);
    out.push({ json: {
      canal: v.snippet.channelTitle,
      titulo: v.snippet.title,
      videoId: v.id,
      url: 'https://youtu.be/' + v.id,
      visitas,
      por_dia: Math.round(visitas / dias),
      despega: visitas / dias >= UMBRAL_DIA
    }});
  }
}
return out;
```

## Cómo probarla
- Ejecuta el flujo 1 a mano y comprueba que en la hoja aparecen los últimos 15 vídeos de cada canal (el RSS solo devuelve los 15 más recientes).
- Ajusta UMBRAL_DIA mirando tres o cuatro vídeos normales del competidor: si su vídeo medio hace 300 al día, pon el umbral en 900.
- Vuelve a lanzar el flujo 1 dos veces seguidas: no deben aparecer filas repetidas. Si aparecen, revisa que la clave del Append or Update sea `videoId`.

## Qué puede salir mal
- **El RSS solo trae 15 vídeos**: si un canal publica a diario y tú consultas cada 6 horas, no pasa nada; si consultas semanalmente, se te escapan.
- **Directos y Shorts** mezclados: filtra por `duration` pidiendo `part=contentDetails` si solo te interesan los vídeos largos.
- **Cuota**: videos.list gasta 1 unidad por llamada de hasta 50 IDs. Imposible agotar los 10.000 diarios.
- **Fechas**: guarda siempre en formato `yyyy-mm-dd` para que las comparaciones no fallen entre formatos españoles y americanos.

## Cuánto cuesta
Gratis: el RSS de YouTube es público y sin límite razonable, la API Data v3 no cobra, Sheets y Telegram tampoco. Solo pagas si usas n8n Cloud (unos 20-24 €/mes) en vez de auto-alojarlo.
