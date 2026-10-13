# Informe semanal de tu canal de YouTube al correo…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Cada lunes te llega un correo con las visitas, el tiempo de visualización, los suscriptores ganados y los 5 vídeos que mejor funcionaron la semana pasada, comparado con la anterior.

## Qué es y qué hace

Es una automatización de n8n que cada lunes consulta la API de YouTube Analytics de los últimos 7 días y de los 7 anteriores, calcula las variaciones y te envía un correo con la tabla y los cinco mejores vídeos. Entra el ID del canal y la credencial de Analytics; sale un correo semanal y una fila de histórico en Sheets. Requiere activar YouTube Analytics API con permiso de solo lectura.

## Cómo usarla

1. Activa YouTube Analytics API en Google Cloud
2. Conecta la credencial OAuth2 y Gmail
3. Crea la hoja Histórico
4. Revisa el primer correo y fija el cron del lunes

## Cuándo usarla

Úsalo cuando entres a YouTube Studio a mirar números y acabes perdiendo media hora, o cuando lleves un canal para un cliente y tengas que reportarle cada semana.

## Cómo ganar dinero con ella

Ahorra 30-45 min semanales de recopilar datos y hace que los reportes a cliente dejen de ser una excusa para no facturar mantenimiento.

- Informe semanal de canal para agencias que reportan a sus clientes cada semana.
- Panel de métricas para creadores que quieren ver la evolución sin entrar a Studio.
- Mantenimiento de canal mensual con informe incluido para negocios que usan YouTube como canal de venta.

**Precio orientativo:** 100–250 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Consulta la API de YouTube Analytics de los últimos 7 días y de los 7 anteriores, calcula la variación y te manda un correo con la tabla, guardando además el histórico en una hoja.
Para creadores con canal propio y para agencias o freelances que gestionan canales de clientes.

## Lo que necesitas antes
- n8n y una credencial **YouTube OAuth2** en n8n. Importante: en Google Cloud, además de YouTube Data API v3, activa **YouTube Analytics API**, y en la pantalla de consentimiento añade el permiso `https://www.googleapis.com/auth/yt-analytics.readonly`.
- Cuenta de Gmail conectada (Gmail OAuth2) o SMTP.
- Una hoja `Histórico` con columnas: `semana`, `visitas`, `minutos`, `suscriptores`, `vistas_medias`.

## Los nodos, en orden
1. **Schedule Trigger** — Cron personalizado `0 8 * * 1` (lunes a las 8:00). Pon la zona `Europe/Madrid` en los ajustes del flujo.
2. **Code** (calcular fechas):
```javascript
const hoy = new Date();
const f = d => d.toISOString().slice(0, 10);
const menos = n => new Date(hoy.getTime() - n * 86400000);
return [{ json: { ini: f(menos(7)), fin: f(menos(1)), iniPrev: f(menos(14)), finPrev: f(menos(8)) } }];
```
3. **HTTP Request** (semana actual) — GET `https://youtubeanalytics.googleapis.com/v2/reports`, Authentication: Predefined → YouTube OAuth2. Query Parameters: `ids` = `channel==MINE`, `startDate` = `{{ $json.ini }}`, `endDate` = `{{ $json.fin }}`, `metrics` = `views,estimatedMinutesWatched,subscribersGained,averageViewDuration`.
4. **HTTP Request** (semana anterior) — igual pero con `iniPrev` y `finPrev`.
5. **HTTP Request** (top 5 vídeos) — mismos ajustes más `dimensions` = `video`, `sort` = `-views`, `maxResults` = `5`.
6. **HTTP Request** (títulos) — GET `https://www.googleapis.com/youtube/v3/videos?part=snippet&id=` con los IDs del paso anterior separados por comas.
7. **Code** (montar el HTML del correo):
```javascript
const a = $('HTTP Request').first().json.rows[0];
const b = $('HTTP Request1').first().json.rows[0];
const pct = (x, y) => y ? `${(((x - y) / y) * 100).toFixed(0)}%` : 'n/d';
const filas = ['Visitas', 'Minutos vistos', 'Suscriptores', 'Duración media (s)']
  .map((n, i) => `<tr><td>${n}</td><td>${a[i]}</td><td>${b[i]}</td><td>${pct(a[i], b[i])}</td></tr>`).join('');
const tops = $('HTTP Request3').first().json.items
  .map(v => `<li>${v.snippet.title}</li>`).join('');
const html = `<h2>Tu semana en YouTube</h2><table border=1 cellpadding=6><tr><th>Métrica</th><th>Esta semana</th><th>Anterior</th><th>Variación</th></tr>${filas}</table><h3>Top 5 vídeos</h3><ul>${tops}</ul>`;
return [{ json: { html, visitas: a[0], minutos: a[1], subs: a[2] } }];
```
8. **Google Sheets** (Append Row) — guarda la semana en el histórico.
9. **Gmail** (Send Message) — To: tu correo (o el del cliente), Subject: `Informe YouTube {{ $now.format('dd/MM') }}`, Email Type: `HTML`, Message: `{{ $json.html }}`.

## Cómo probarla
- Ejecuta a mano un jueves cualquiera: los números deben cuadrar con la pestaña Analytics de YouTube Studio en el mismo rango de fechas.
- Ojo: los datos de los últimos 2-3 días son provisionales, por eso el informe termina en «ayer» y no en «hoy».

## Qué puede salir mal
- **Error 403 `Insufficient permission`**: no añadiste el permiso de Analytics; borra la credencial en n8n, vuelve a crearla y acepta de nuevo el consentimiento.
- **Canal de marca**: si el canal pertenece a una cuenta de marca, entra con la cuenta que tiene acceso de propietario o los datos vendrán vacíos.
- **`rows` indefinido**: si la semana no tuvo ni una visita, la API no devuelve `rows`. Protege el Code con `|| [[0,0,0,0]]`.
- **Horario de verano**: el cron de n8n usa la zona del sistema; fija `GENERIC_TIMEZONE=Europe/Madrid`.

## Cuánto cuesta
- Gratis del todo: la API de Analytics no consume cuota de pago y Gmail envía sin coste.
- Si lo montas para 5 clientes, duplica el flujo cambiando la credencial: sigue siendo 0 €.
