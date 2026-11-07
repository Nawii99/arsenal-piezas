# Alerta de páginas que pierden posiciones en Google…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Cada lunes compara los últimos 28 días con los 28 anteriores en Search Console y te avisa de las páginas que han perdido clics o posiciones. Para quien vive del tráfico orgánico.

## Qué es y qué hace

Cada lunes pide a la API de Search Console los clics, impresiones y posición media por página de los últimos 28 días y de los 28 anteriores, y los cruza. Marca las páginas con caída de más del 25 % en clics (y al menos 10 perdidos) o de más de 3 posiciones, y te envía una tabla ordenada con el enlace de cada página. Para negocios con tráfico orgánico.

## Cómo usarla

1. Verificar la web en Search Console
2. Crear el proyecto y la credencial OAuth2 con scope webmasters.readonly
3. Montar el flujo semanal en n8n
4. Revisar el primer informe

## Cuándo usarla

Úsalo cuando tengas blog o fichas de producto que traigan clientes desde Google, después de una migración o un rediseño, o si notas que «entra menos gente» y no sabes por qué.

## Cómo ganar dinero con ella

Detectar una caída a la semana siguiente en vez de al trimestre. Sustituye herramientas SEO de 30-100 €/mes y evita perder posiciones que cuestan meses recuperar.

- Vigilancia de tráfico orgánico para blogs y tiendas que dependen de Google.
- Análisis de caídas tras una migración o rediseño de la web de un cliente.
- Informe SEO mensual con alertas de pérdida de posiciones para agencias pequeñas.

**Precio orientativo:** 120–250 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Pide a la API de Search Console los clics, impresiones y posición media por página de dos periodos de 28 días consecutivos y los cruza.
Marca las páginas con caída de clics de más del 25% (y al menos 10 clics perdidos) o con pérdida de más de 3 posiciones, y te envía una tabla ordenada por urgencia con el enlace directo a cada página.

## Lo que necesitas antes
- Tu web verificada en Google Search Console.
- Un proyecto en `console.cloud.google.com` con la «Google Search Console API» activada en «APIs y servicios > Biblioteca».
- Credencial OAuth2 en n8n: en Cloud crea «ID de cliente de OAuth > Aplicación web», añade como URI de redirección la que te muestra n8n, y en n8n crea una credencial `Google OAuth2 API` con el scope `https://www.googleapis.com/auth/webmasters.readonly`.
- La propiedad exacta tal cual aparece en Search Console: `https://tudominio.com/` o `sc-domain:tudominio.com`. Hay que codificarla en la URL (`sc-domain%3Atudominio.com`).
- Hoja de Google «SEO semanal» y credencial Gmail.

## Los nodos, en orden
1. **Schedule Trigger** — Weeks, Trigger on Weekdays: Monday, Hour: 8.
2. **Code** (renómbralo «Fechas») — calcula los cuatro límites de fecha. Ver código.
3. **HTTP Request** (renómbralo «Periodo actual») — Method: POST; URL: `https://www.googleapis.com/webmasters/v3/sites/sc-domain%3Atudominio.com/searchAnalytics/query`; Authentication: Predefined Credential Type > Google OAuth2 API (la que creaste); Body Content Type: JSON; Body: `={{ JSON.stringify({ startDate: $json.ini_actual, endDate: $json.fin_actual, dimensions: ['page'], rowLimit: 500 }) }}`.
4. **HTTP Request** (renómbralo «Periodo anterior») — igual, pero con `$json.ini_previo` y `$json.fin_previo` (usa `$('Fechas').item.json`).
5. **Code** (renómbralo «Comparar») — ver código.
6. **Google Sheets** — Append Row con todas las páginas y sus variaciones (para tener histórico).
7. **IF** — Number: `={{ $json.length }}`... mejor: en el Code de comparar devuelve un solo item con `caidas` y `html`; el IF comprueba `={{ $json.total_caidas }}` greater than 0.
8. **Gmail** — Subject: `SEO: {{ $json.total_caidas }} páginas cayendo esta semana`; Message Type: HTML; Message: `={{ $json.html }}`.

## El código de «Fechas»
```js
const d = (n) => new Date(Date.now() - n * 86400000).toISOString().slice(0, 10);
return [{ json: { fin_actual: d(3), ini_actual: d(30), fin_previo: d(31), ini_previo: d(58) } }];
```

## El código de «Comparar»
```js
const fila = (r) => ({ page: r.keys[0], clicks: r.clicks, impressions: r.impressions, position: r.position });
const act = ($('Periodo actual').first().json.rows || []).map(fila);
const pre = ($('Periodo anterior').first().json.rows || []).map(fila);
const mapaPre = Object.fromEntries(pre.map(r => [r.page, r]));
const caidas = [];
for (const a of act) {
  const p = mapaPre[a.page];
  if (!p) continue;
  const difClicks = a.clicks - p.clicks;
  const pct = p.clicks > 0 ? Math.round((difClicks / p.clicks) * 100) : 0;
  const difPos = a.position - p.position;
  if ((pct <= -25 && difClicks <= -10) || difPos >= 3) {
    caidas.push({ page: a.page, antes: p.clicks, ahora: a.clicks, pct, pos_antes: p.position.toFixed(1), pos_ahora: a.position.toFixed(1), perdidos: -difClicks });
  }
}
caidas.sort((x, y) => y.perdidos - x.perdidos);
const filas = caidas.slice(0, 20).map(c => `<tr><td><a href="${c.page}">${c.page.replace(/^https?:\/\/[^/]+/, '')}</a></td><td>${c.antes}</td><td>${c.ahora}</td><td>${c.pct}%</td><td>${c.pos_antes} → ${c.pos_ahora}</td></tr>`).join('');
const html = `<p>Páginas que han perdido tráfico en los últimos 28 días frente a los 28 anteriores:</p><table border="1" cellpadding="6" cellspacing="0"><tr><th>Página</th><th>Clics antes</th><th>Clics ahora</th><th>Variación</th><th>Posición</th></tr>${filas}</table><p>Empieza por la primera: revisa si cambió el título, si perdió enlaces internos o si un competidor la ha superado.</p>`;
return [{ json: { total_caidas: caidas.length, html, caidas } }];
```

## Cómo probarla
- Ejecuta a mano y compara dos o tres cifras con la pantalla «Rendimiento» de Search Console filtrando por esas mismas fechas: deben cuadrar.
- Si sale vacío, revisa que la propiedad de la URL esté bien codificada (`%3A` en vez de `:`).
- Baja temporalmente el umbral a `pct <= -5` para ver que el correo se genera bien, y luego devuélvelo a -25.

## Qué puede salir mal
- **Error 403 «User does not have sufficient permission»**: la cuenta de Google con la que autorizaste no es propietaria de la propiedad en Search Console; añádela como usuario con permiso completo.
- **Faltan los últimos días**: Search Console tarda 2-3 días en consolidar datos; por eso el código termina en `d(3)`, no en hoy.
- **Muchas páginas con pocos clics dan porcentajes locos**: el filtro de «al menos 10 clics perdidos» ya lo evita; súbelo a 25 si tienes mucho tráfico.
- **Estacionalidad**: en agosto o Navidad todo cae. Compara también con el mismo periodo del año anterior añadiendo una tercera consulta.
- **Más de 500 páginas**: pagina con `startRow` en incrementos de 500 en el cuerpo de la petición.

## Cuánto cuesta
- API de Search Console: gratis (límite de 1.200 consultas por minuto, ni te acercas).
- n8n auto-alojado, Sheets y Gmail: gratis (n8n Cloud: prueba gratuita temporal y después de pago). Cuatro ejecuciones al mes.
