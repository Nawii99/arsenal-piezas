# Aviso temprano cuando un reel tuyo empieza a despegar…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Mira cada pocas horas las reproducciones de tus últimos reels y te avisa si uno va muy por encima de tu media, para que lo empujes a tiempo.

## Qué es y qué hace

Consulta cada tres horas, con la API de Instagram Graph, las reproducciones de tus reels de los últimos siete días, calcula tu media y te avisa por Telegram si uno la dobla, con una checklist de acciones. Entrada: token de larga duración e ID de la cuenta profesional; salida: aviso y registro. Se monta en n8n y requiere una app creada en Meta for Developers.

## Cómo usarla

1. Crea la app en developers.facebook.com
2. Convierte el token en uno de 60 días
3. Crea el bot de Telegram
4. Activa el flujo cada tres horas

## Cuándo usarla

Cuando publicas vertical en Instagram y siempre te enteras tarde de que un vídeo ha funcionado, cuando ya ha perdido el empuje del algoritmo.

## Cómo ganar dinero con ella

Detectar el vídeo ganador en las primeras 12 horas te deja promocionarlo o replicarlo mientras aún tira: mismo contenido, varias veces más alcance.

- Monitor de rendimiento de reels para negocios locales con cuenta profesional.
- Informe semanal de vídeos ganadores para community managers que gestionan varias cuentas.
- Configuración de avisos para creadores que quieren impulsar un reel en sus primeras horas.

**Precio orientativo:** 40–120 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Consulta cada tres horas las reproducciones de tus reels de los últimos siete días, calcula tu media normal y te manda un aviso a Telegram si alguno la dobla, con una checklist de qué hacer ahora. Es para negocios y creadores con cuenta de Instagram profesional.

## Lo que necesitas antes
- Cuenta de Instagram **de empresa o creador**, vinculada a una página de Facebook (Configuración de Instagram > Cuenta > Cambiar a cuenta profesional).
- Una app en developers.facebook.com: crea App tipo «Empresa», añade el producto **Instagram Graph API**, y en el Explorador de la API de Graph genera un token con los permisos `instagram_basic`, `instagram_manage_insights`, `pages_show_list` y `pages_read_engagement`.
- Convierte ese token en uno de larga duración (60 días) con: `GET https://graph.facebook.com/v21.0/oauth/access_token?grant_type=fb_exchange_token&client_id=APPID&client_secret=SECRET&fb_exchange_token=TOKEN_CORTO`.
- Tu Instagram Business Account ID: `GET https://graph.facebook.com/v21.0/me/accounts?fields=instagram_business_account&access_token=TOKEN`.
- Hoja «Reels» con columnas: mediaId, fecha, permalink, caption, plays, horas, ritmo, avisado.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 9,12,15,18,21 * * *`, cinco veces al día, Europe/Madrid.
2. **HTTP Request** («Últimos reels») — GET `https://graph.facebook.com/v21.0/{IG_ID}/media` con `fields=id,caption,media_product_type,permalink,timestamp` y `access_token=TU_TOKEN`, `limit=25`.
3. **Code** («Solo reels de 7 días») — filtra por `media_product_type = REELS` y fecha.
4. **Split In Batches** — Batch Size 1.
5. **HTTP Request** («Insights») — GET `https://graph.facebook.com/v21.0/{{ $json.mediaId }}/insights` con `metric=plays,reach,likes,comments,shares,saved` y el token. Activa Continue On Fail.
6. **Code** («Calcular ritmo y media») — reproducciones por hora de vida y comparación con la media.
7. **IF** — `{{ $json.despega }}` is true.
8. **Google Sheets** — Append or Update sobre «Reels», clave `mediaId`.
9. **Telegram** — mensaje con el permalink, el ritmo y la checklist: subirlo a TikTok y YouTube Shorts, fijarlo en el perfil, responder todos los comentarios de la primera hora y valorar promocionarlo con 20 € en Meta.

## El código de «Solo reels de 7 días»
```js
const limite = Date.now() - 7 * 86400000;
return (items[0].json.data || [])
  .filter(m => m.media_product_type === 'REELS' && new Date(m.timestamp).getTime() > limite)
  .map(m => ({ json: {
    mediaId: m.id,
    fecha: m.timestamp,
    permalink: m.permalink,
    caption: (m.caption || '').slice(0, 80),
    horas: Math.max(1, Math.round((Date.now() - new Date(m.timestamp)) / 3600000))
  }}));
```

## El código de «Calcular ritmo y media»
```js
const previos = $('Solo reels de 7 días').all().map(i => i.json);
const datos = items.map((it, idx) => {
  const arr = it.json.data || [];
  const plays = (arr.find(x => x.name === 'plays')?.values?.[0]?.value) || 0;
  const p = previos[idx] || {};
  return { ...p, plays, ritmo: Math.round(plays / (p.horas || 1)) };
});
const maduros = datos.filter(d => d.horas >= 48);
const media = maduros.length
  ? maduros.reduce((a, d) => a + d.ritmo, 0) / maduros.length
  : 0;
return datos.map(d => ({ json: {
  ...d,
  media_ritmo: Math.round(media),
  despega: d.horas >= 4 && d.horas <= 36 && media > 0 && d.ritmo >= media * 2
}}));
```

## Cómo probarla
- Ejecuta a mano: comprueba que en la hoja aparecen tus reels con reproducciones parecidas a las que ves en la app (los insights de Instagram redondean, no busques el número exacto).
- Baja el multiplicador de 2 a 1.1 para forzar un aviso y comprobar Telegram; luego devuélvelo a 2.
- Deja pasar una semana antes de fiarte de la media: con menos de cinco reels maduros la referencia no vale.

## Qué puede salir mal
- **El token caduca a los 60 días**: apúntalo en el calendario o monta un flujo mensual que lo renueve con la llamada `fb_exchange_token`. Es el fallo más habitual.
- **Métrica no disponible**: `plays` no existe en fotos ni en carruseles; por eso se filtra por REELS. Si Meta renombra la métrica (ha pasado con `video_views`), verás error 100: cámbiala en el parámetro `metric`.
- **Avisos repetidos del mismo reel**: la columna `avisado` y el Append or Update por `mediaId` lo cortan; añade un IF que compruebe `avisado != sí`.
- **Límite de peticiones**: la Graph API permite de sobra 5 ejecuciones diarias con 25 reels; no bajes a cada 15 minutos.
- **TikTok**: su API para creadores es mucho más cerrada; aquí se cubre Instagram y el aviso te recuerda replicar a mano.

## Cuánto cuesta
Gratis: la Instagram Graph API no cobra, Sheets y Telegram tampoco. Lo único de pago es opcional: los 20-50 € de promoción en Meta que decidas meter al vídeo que despega.
