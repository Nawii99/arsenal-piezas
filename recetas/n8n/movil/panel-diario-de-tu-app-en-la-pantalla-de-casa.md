# Panel diario de tu app en la pantalla de casa…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Cada mañana reúne instalaciones, usuarios activos, fallos y nota media, monta una página web sencilla y te manda al móvil el resumen en tres líneas.

## Qué es y qué hace

Flujo de n8n que cada mañana reúne en un único resumen las instalaciones y ventas de App Store Connect, los usuarios activos de Google Analytics o BigQuery y los fallos de Sentry. Publica el resumen como página web sencilla y te envía tres líneas por Telegram. Entran las claves de API de cada servicio; sale una página HTML y un mensaje diario. Requiere cuentas de App Store Connect, Firebase y Sentry.

## Cómo usarla

1. 1. Genera las claves de App Store Connect y Sentry
2. 2. Enlaza Firebase con BigQuery
3. 3. Ajusta las métricas durante la primera semana
4. Que lo revise un profesional

## Cuándo usarla

Cuando tus números viven repartidos en cuatro paneles distintos y no tienes una foto de conjunto para empezar el día en 30 segundos.

## Cómo ganar dinero con ella

Elimina 30-45 minutos diarios de abrir paneles y te permite detectar un desplome de instalaciones o un pico de fallos el mismo día que ocurre.

- Panel de métricas diario para fundadores de apps que quieren el estado del negocio en un vistazo.
- Resumen automático para agencias que reportan a clientes sus instalaciones, fallos y nota media.
- Cuadro de mando móvil para equipos pequeños que dirigen una app sin analista dedicado.

**Precio orientativo:** 200–450 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Junta cada mañana los datos de las tiendas, de analítica y de errores en un único resumen, lo publica como página web privada y te lo manda por Telegram.
Para el que dirige una app y quiere el estado del negocio en un vistazo, sin ser analista.

## Lo que necesitas antes
- Clave de API de App Store Connect con rol `Sales and Reports` (Key ID, Issuer ID y el `.p8`).
- Firebase con Google Analytics para Firebase activado y BigQuery enlazado (el enlace es gratuito), o Google Analytics 4 con la Data API activada en Google Cloud.
- Token de API de Sentry (User settings → Auth tokens, permiso `project:read`).
- Bot de Telegram.
- Un sitio donde publicar el HTML: GitHub Pages, Cloudflare Pages o un bucket. Necesitas un token de GitHub con permiso `repo`.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 7 * * *`, zona `Europe/Madrid`.
2. **HTTP Request** («Ventas iOS») — informe diario de App Store Connect (`filter[frequency]=DAILY`, `filter[reportDate]` = ayer), con el JWT firmado en un nodo **Code** previo.
3. **HTTP Request** («GA4») — POST a `https://analyticsdata.googleapis.com/v1beta/properties/TU_ID:runReport` con body: métricas `activeUsers` y `sessions`, dimensión `platform`, rango `yesterday`.
4. **HTTP Request** («Sentry») — GET `https://sentry.io/api/0/projects/TU_ORG/TU_PROYECTO/stats/?stat=received&resolution=1d`, header `Authorization: Bearer TOKEN`.
5. **HTTP Request** («Ficha App Store») — GET `https://itunes.apple.com/lookup?id=TU_ID&country=es` para la nota media.
6. **Merge** — modo `Combine`, `Combine All`, para juntar las cuatro respuestas en un solo elemento.
7. **Code** («Montar panel») — calcula variaciones y genera el HTML y el texto corto.
8. **HTTP Request** («Publicar») — PUT a `https://api.github.com/repos/USUARIO/panel/contents/index.html` con el HTML en base64 y el `sha` del fichero anterior.
9. **Telegram** — manda el texto corto y el enlace a la página.

## El código del nodo «Montar panel»
```javascript
const d = $input.first().json;
const inst = Number(d.instalaciones || 0);
const activos = Number(d.activos || 0);
const errores = Number(d.errores || 0);
const nota = d.nota || '-';
const flecha = (a, b) => a > b ? '🔼' : (a < b ? '🔽' : '➡️');
const texto = `📱 Ayer: ${inst} instalaciones · ${activos} activos · ${errores} errores · ⭐ ${nota}`;
const html = `<!doctype html><meta charset="utf-8"><title>Panel app</title>
<style>body{font-family:system-ui;background:#111;color:#eee;padding:24px}
.c{display:inline-block;background:#1d1d1f;border-radius:16px;padding:20px 28px;margin:8px}
.n{font-size:38px;font-weight:700}.l{opacity:.6;font-size:13px}</style>
<h1>Panel · ${new Date().toLocaleDateString('es-ES')}</h1>
<div class="c"><div class="n">${inst}</div><div class="l">Instalaciones</div></div>
<div class="c"><div class="n">${activos}</div><div class="l">Usuarios activos</div></div>
<div class="c"><div class="n">${errores}</div><div class="l">Errores</div></div>
<div class="c"><div class="n">${nota}</div><div class="l">Nota media</div></div>`;
return [{ json: { texto, html_b64: Buffer.from(html).toString('base64') } }];
```

## Cómo probarla
- Conecta las fuentes de una en una y ejecuta después de cada una: así sabes cuál falla si algo peta.
- Compara las cifras del primer día con lo que dicen los paneles originales. Si GA4 da menos usuarios, revisa la zona horaria de la propiedad.
- Abre la página publicada en el móvil y añádela a la pantalla de inicio: se ve como una app.

## Qué puede salir mal
- El informe diario de Apple sale con 1-2 días de retraso; usa siempre `ayer menos 1` si te devuelve vacío, y controla el 404 con `On Error: Continue`.
- GA4 tarda hasta 48 horas en consolidar datos: las cifras del día anterior pueden moverse un poco. Es normal.
- Para actualizar un fichero en GitHub necesitas el `sha` actual: haz un GET previo al mismo endpoint y pásalo en el PUT, o tendrás error 409.
- La página en GitHub Pages es pública. Si los datos son sensibles, publica en Cloudflare Pages con Access, o manda solo el mensaje de Telegram.
- Si alguna API falla, el **Merge** puede quedarse esperando. Pon `Always Output Data` en los cuatro HTTP Request.

## Cuánto cuesta
Todo gratis: las APIs de Apple y Google van con tu cuenta de desarrollador, Sentry y GitHub Pages tienen plan gratuito y Telegram no cobra. Solo pagarías n8n Cloud si no lo alojas tú.
