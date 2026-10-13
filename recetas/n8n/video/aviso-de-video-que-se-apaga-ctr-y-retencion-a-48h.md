# Aviso de vídeo que se apaga (CTR y retención a 48h)

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Cada mañana mira los vídeos publicados en las últimas 48-72 horas en YouTube y te avisa por email si el CTR o la retención van por debajo de tu media histórica.

## Qué es y qué hace

Consulta cada mañana la API de YouTube para los vídeos de las últimas 48-72 horas, compara su CTR y retención con tu media de 90 días y envía un email solo si caen por debajo. Entran el ID del canal y credenciales OAuth; sale un aviso y una fila en Sheets. Se monta con n8n y Google Sheets para creadores que publican al menos dos vídeos al mes.

## Cómo usarla

1. Activa YouTube Data y Analytics en Google Cloud
2. Crea la credencial OAuth en n8n
3. Prepara la hoja Radar vídeos
4. Programa el disparador diario y el umbral de aviso

## Cuándo usarla

Úsalo cuando publicas al menos 2 vídeos al mes en YouTube y quieres cambiar título o miniatura en la ventana en la que todavía sirve de algo, no dos semanas después.

## Cómo ganar dinero con ella

Recuperar un vídeo en las primeras 72 horas puede multiplicar sus visitas. Te ahorra entrar cada día a YouTube Studio: 10-15 minutos diarios.

- Auditoría mensual de rendimiento de canales de YouTube para pymes, con avisos de vídeos que caen…
- Gestión de canal para creadores pequeños: revisión de títulos y miniaturas dentro de la ventana de 72 horas…
- Panel de métricas de YouTube para clientes con alertas automáticas y recomendación de acción…

**Precio orientativo:** 40–120 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Compara el CTR de impresiones y la duración media de tus vídeos recién publicados contra tu media de los últimos 90 días y te manda un correo solo si algo va mal. Para creadores y negocios que suben vídeo a YouTube con cierta regularidad.

## Lo que necesitas antes
- Un canal de YouTube con acceso a YouTube Studio (tienes que ser el propietario).
- Cuenta de Google Cloud gratis: console.cloud.google.com → «Nuevo proyecto» → APIs y servicios → activa **YouTube Data API v3** y **YouTube Analytics API**.
- En «Credenciales» crea un **ID de cliente de OAuth** tipo «Aplicación web» y pon como URI de redirección la que te dé n8n al crear la credencial «YouTube OAuth2 API» (algo como https://tu-n8n/rest/oauth2-credential/callback).
- Una hoja de Google Sheets llamada «Radar vídeos» con columnas: fecha, videoId, titulo, ctr, retencion_pct, avisado.

## Los nodos, en orden
1. **Schedule Trigger** — «Days», cada 1 día, hora 09:00, zona horaria Europe/Madrid (ponla en Settings del workflow, no solo en el nodo).
2. **YouTube** (Resource: Video, Operation: Get Many) — Filtro: «My Videos», Limit 10, «Return All» desactivado. Devuelve tus últimos vídeos.
3. **Code** (modo «Run Once for All Items») — se queda solo con los publicados hace entre 36 y 96 horas.
4. **HTTP Request** — GET a https://youtubeanalytics.googleapis.com/v2/reports con autenticación «Predefined Credential Type» → YouTube OAuth2. Query: ids=channel==MINE, startDate y endDate (últimos 90 días), metrics=views,estimatedMinutesWatched,averageViewPercentage,cardClickRate, dimensions=video, filters=video=={{ $json.videoId }}.
5. **Code** — calcula la media histórica del canal y compara.
6. **IF** — condición: {{ $json.alerta }} es true.
7. **Gmail** (Send) — a tu correo, asunto «Revisa: {{ $json.titulo }}», cuerpo con las cifras y la sugerencia.
8. **Google Sheets** (Append) — guarda la fila en «Radar vídeos» para tener histórico.

## El código del nodo 5
```js
const media = { ctr: 4.5, retencion: 38 }; // sustituye por tu media real tras 2 semanas de datos
const out = [];
for (const item of $input.all()) {
  const d = item.json.rows ? item.json.rows[0] : null;
  if (!d) continue;
  const retencion = d[3];
  const alerta = retencion < media.retencion * 0.8;
  out.push({ json: { videoId: item.json.videoId, titulo: item.json.titulo, retencion_pct: retencion, alerta } });
}
return out;
```

## Cómo probarla
Ejecuta con «Test workflow» y mira el output del nodo 4: si devuelve `rows` vacío es que el vídeo es demasiado reciente (YouTube tarda 24-48h en consolidar datos). Fuerza `alerta = true` a mano una vez para comprobar que el correo llega.

## Qué puede salir mal
- **Datos a cero**: los primeros dos días los datos son provisionales. Por eso el filtro empieza a las 36 horas.
- **Token caducado**: si el proyecto de Google Cloud está en «Modo de prueba», el refresh token muere a los 7 días. Publica la app (aunque sea solo para ti) en la pantalla de consentimiento.
- **Cuota**: la Analytics API da de sobra para 10 vídeos al día; no hagas bucles innecesarios.
- **Horas**: si no fijas Europe/Madrid, en verano el aviso te llegará a las 11.

## Cuánto cuesta
Gratis del todo: n8n auto-alojado o su plan gratis, las APIs de YouTube no se cobran y Gmail tampoco. Solo pagas si necesitas más de 5 workflows activos en n8n Cloud (unos 20 €/mes).
