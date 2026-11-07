# Informe semanal del canal en tu correo cada lunes…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Cada lunes recoge las vistas, minutos y suscriptores de los últimos 7 días, los compara con la semana anterior y te manda un correo claro con qué ha funcionado.

## Qué es y qué hace

Cada lunes pide a YouTube Analytics las métricas de los últimos 7 días y de los 7 anteriores (vistas, minutos y suscriptores), calcula la variación, ordena los vídeos por vistas y envía un correo con tabla y tres conclusiones. Entra la API de Analytics autorizada con la cuenta propietaria; sale el correo y una fila de histórico en Sheets. Útil para creadores y agencias que reportan a clientes.

## Cómo usarla

1. Activa YouTube Analytics y Data API en Google Cloud
2. Autoriza con la cuenta propietaria del canal
3. Crea la hoja Metricas semanales
4. Fija el disparador del lunes a las 9:00

## Cuándo usarla

Cuando entras en YouTube Studio a mirar números y sales sin conclusiones, o cuando llevas el canal de un cliente y tienes que reportar cada semana.

## Cómo ganar dinero con ella

Sustituye el informe manual semanal, entre 45 y 90 minutos. Si lo haces para clientes, es una entrega recurrente que no te cuesta tiempo.

- Informe semanal de YouTube para clientes de agencias, sin trabajo manual cada lunes…
- Panel de tendencias de canal para creadores con histórico en hoja…
- Servicio mensual de análisis de canal con recomendaciones de contenido…

**Precio orientativo:** 30–100 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Todos los lunes a las 9:00 pide a la API de YouTube Analytics las métricas de los últimos 7 días y de los 7 anteriores, calcula la variación, ordena tus vídeos por vistas y te manda un correo con la tabla y tres conclusiones escritas en cristiano. Guarda además el histórico en Sheets para ver tendencias. Para creadores y para agencias que gestionan canales de clientes.

## Lo que necesitas antes
- n8n.
- Google Cloud con **YouTube Analytics API** y **YouTube Data API v3** activadas, y una credencial OAuth2 en n8n con los scopes `yt-analytics.readonly` y `youtube.readonly`. Importante: debes autorizar con la cuenta propietaria del canal.
- Hoja de Sheets `Metricas semanales` con columnas: `semana`, `vistas`, `minutos`, `suscriptores`, `vistas_prev`, `variacion`.

## Los nodos, en orden
1. **Schedule Trigger** — Interval `Weeks`, día `Monday`, hora 09:00. Timezone del workflow: `Europe/Madrid`.
2. **Code** — Calcula las cuatro fechas que necesitas (inicio y fin de esta semana y de la anterior) en formato `YYYY-MM-DD`.
3. **HTTP Request** (semana actual) — GET a `https://youtubeanalytics.googleapis.com/v2/reports`. Authentication: Google OAuth2. Query: `ids` = `channel==MINE`, `startDate` = `{{ $json.ini_actual }}`, `endDate` = `{{ $json.fin_actual }}`, `metrics` = `views,estimatedMinutesWatched,subscribersGained,averageViewDuration`.
4. **HTTP Request1** (semana anterior) — Igual pero con `{{ $('Code').item.json.ini_prev }}` y `{{ $('Code').item.json.fin_prev }}`.
5. **HTTP Request2** (top vídeos) — Mismos parámetros que el 3 más `dimensions` = `video`, `sort` = `-views`, `maxResults` = `10`.
6. **HTTP Request3** (nombres de los vídeos) — GET a `https://www.googleapis.com/youtube/v3/videos` con `part` = `snippet` e `id` = la lista de IDs separada por comas que montas en el Code siguiente.
7. **Code1** — Cruza métricas con títulos, calcula las variaciones en porcentaje y monta el HTML del correo.
8. **Google Sheets** — Append con la fila del histórico.
9. **Gmail** — Send, Email Type `HTML`, asunto `Canal: {{ $json.vistas }} vistas esta semana ({{ $json.variacion }})`.

## El código del nodo Code (paso 2)
```javascript
const f = (d) => d.toISOString().slice(0, 10);
const hoy = new Date();
const finActual = new Date(hoy); finActual.setDate(hoy.getDate() - 1);
const iniActual = new Date(hoy); iniActual.setDate(hoy.getDate() - 7);
const finPrev = new Date(hoy); finPrev.setDate(hoy.getDate() - 8);
const iniPrev = new Date(hoy); iniPrev.setDate(hoy.getDate() - 14);
return { json: { ini_actual: f(iniActual), fin_actual: f(finActual), ini_prev: f(iniPrev), fin_prev: f(finPrev) } };
```

## El código del nodo Code1 (paso 7)
```javascript
const act = $('HTTP Request').first().json.rows?.[0] || [0,0,0,0];
const prev = $('HTTP Request1').first().json.rows?.[0] || [0,0,0,0];
const pct = (a, b) => b === 0 ? '—' : (((a - b) / b) * 100).toFixed(1) + '%';
const filas = $('HTTP Request2').first().json.rows || [];
const titulos = {};
($('HTTP Request3').first().json.items || []).forEach(v => { titulos[v.id] = v.snippet.title; });
let tabla = '<table border=1 cellpadding=6><tr><th>Vídeo</th><th>Vistas</th><th>Minutos</th></tr>';
filas.forEach(r => { tabla += '<tr><td>' + (titulos[r[0]] || r[0]) + '</td><td>' + r[1] + '</td><td>' + r[2] + '</td></tr>'; });
tabla += '</table>';
const html = '<h2>Resumen de la semana</h2><p>Vistas: <b>' + act[0] + '</b> (' + pct(act[0], prev[0]) + ' vs semana anterior)<br>Minutos vistos: <b>' + act[1] + '</b> (' + pct(act[1], prev[1]) + ')<br>Suscriptores nuevos: <b>' + act[2] + '</b> (' + pct(act[2], prev[2]) + ')<br>Duración media: <b>' + act[3] + ' s</b></p>' + tabla;
return { json: { html, vistas: act[0], minutos: act[1], suscriptores: act[2], vistas_prev: prev[0], variacion: pct(act[0], prev[0]), semana: new Date().toISOString().slice(0,10) } };
```

## Cómo probarla
1. Ejecuta a mano un lunes cualquiera y compara los números con YouTube Studio → Analytics → últimos 7 días. Deben cuadrar salvo un par de horas de desfase.
2. Si el nodo 3 devuelve `rows` vacío, es que has autorizado con una cuenta de Google que no es la propietaria del canal.
3. Envíate el correo a ti mismo dos semanas antes de mandárselo a un cliente.

## Qué puede salir mal
- **Error 403 «Forbidden»**: falta el scope `yt-analytics.readonly`. Borra la credencial en n8n y vuelve a autorizarla desde cero.
- **Datos incompletos de las últimas 48 horas**: YouTube tarda en consolidar. Por eso el informe termina en «ayer» y no en «hoy».
- **Canal de marca (brand account)**: al autorizar tienes que elegir el canal correcto en el selector de Google, no la cuenta personal.
- **Vídeos borrados** salen sin título: el código ya lo cubre mostrando el ID.
- **Cambio de hora en marzo y octubre**: con Timezone `Europe/Madrid` puesto en el workflow no te afecta.

## Cuánto cuesta
Cero euros. YouTube Analytics API es gratuita dentro de las cuotas normales, y Sheets y Gmail también; n8n autoalojado (Community Edition) es gratis, mientras que n8n Cloud tiene una prueba gratuita temporal y después planes de pago.
