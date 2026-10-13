# Presupuesto de velocidad con PageSpeed…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Mide cada semana la velocidad y el Core Web Vitals de tus páginas clave, guarda el histórico en una hoja y te avisa solo si la nota baja de tu límite.

## Qué es y qué hace

Cada lunes mide con PageSpeed Insights unas URLs clave en móvil, guarda nota y métricas en Google Sheets y avisa por Slack si alguna baja del presupuesto que fijes o empeora más de 8 puntos frente a la medición anterior. Sirve para mantener el rendimiento de una web tras optimizarla, sin herramientas de pago.

## Cómo usarla

1. Crear la clave de PageSpeed Insights API
2. Preparar la hoja Velocidad con pestaña URLs
3. Configurar el bot de Slack
4. Revisar el umbral con el cliente

## Cuándo usarla

Úsalo cuando has optimizado una web y quieres que no se degrade sola con cada plugin, imagen o script de marketing que alguien añade.

## Cómo ganar dinero con ella

Detecta la caída de velocidad la semana que pasa, no seis meses después con las ventas ya bajadas. Auditoría manual equivalente: 150-300 €.

- Vigilancia de rendimiento para tiendas online tras una optimización.
- Informe de velocidad para el mantenimiento mensual de webs de clientes.
- Control de degradación de la web tras añadir scripts de marketing.

**Precio orientativo:** 100–200 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién.** Cada lunes mide con la API oficial de PageSpeed Insights un puñado de URLs tuyas (portada, categoría, producto, artículo) en móvil, guarda nota y métricas en Google Sheets y te avisa por Slack si alguna baja del presupuesto que tú fijes o empeora más de 8 puntos respecto a la medición anterior.
Para desarrollador web o dueño de tienda que ya sabe que la velocidad le afecta a la conversión y quiere vigilancia sin pagar herramientas de 90 €/mes.

**Lo que necesitas antes**
- n8n.
- Una clave de la API de PageSpeed: entra en `console.cloud.google.com`, crea un proyecto, APIs y servicios > Biblioteca > busca `PageSpeed Insights API` > Habilitar; luego Credenciales > Crear credenciales > Clave de API. Gratis, 25.000 consultas al día.
- Hoja de Google Sheets `Velocidad` con columnas: `fecha`, `url`, `nota`, `lcp`, `cls`, `inp`, `tbt`.
- Una segunda pestaña `URLs` con columnas `url` y `minimo` (por ejemplo `85`).
- Slack conectado en n8n (o cambia el último nodo por Gmail si no usas Slack).

**Los nodos, en orden**
1. **Schedule Trigger** — Weeks 1, Monday, Hour 7.
2. **Google Sheets** — Get Row(s) de la pestaña `URLs`, Return All.
3. **Split In Batches** — Batch Size 1 (la API tarda 20-40 s por URL, no la agobies).
4. **HTTP Request** (`Medir`) — Method GET, URL: `https://www.googleapis.com/pagespeedonline/v5/runPagespeed`. En Options > Query Parameters añade: `url` = `{{ $json.url }}`, `key` = tu clave, `strategy` = `mobile`, y cuatro veces `category` con valores `performance`, `accessibility`, `best-practices`, `seo`. Timeout 120000. Retry On Fail activado, 3 intentos, 5000 ms entre intentos.
5. **Code** (`Extraer metricas`) — Mode: Run Once for Each Item. Código abajo.
6. **Google Sheets** (`Guardar`) — Append Row en la pestaña `Velocidad`, mapeando los campos del Code.
7. **Code** (`Comparar`) — compara con la fila anterior de esa misma URL. Código abajo.
8. **IF** (`Alarma?`) — Boolean `{{ $json.alarma }}` `is true`.
9. **Slack** — Send Message al canal `#web`, texto `{{ $json.aviso }}`.

**El código del nodo `Extraer metricas`**
```js
const r = $json.lighthouseResult || {};
const a = r.audits || {};
const num = (x) => (x && typeof x.numericValue === 'number') ? Math.round(x.numericValue * 100) / 100 : null;
return { json: {
  fecha: $now.format('yyyy-LL-dd'),
  url: r.finalUrl || $json.id,
  nota: Math.round((r.categories?.performance?.score || 0) * 100),
  lcp: num(a['largest-contentful-paint']),
  cls: num(a['cumulative-layout-shift']),
  inp: num(a['interaction-to-next-paint']) ?? num(a['max-potential-fid']),
  tbt: num(a['total-blocking-time'])
} };
```

**El código del nodo `Comparar`**
```js
const historico = $('Guardar').all().map(i => i.json);
const minimos = {};
for (const f of $('Google Sheets').all()) minimos[f.json.url] = Number(f.json.minimo || 80);
const salida = [];
for (const item of $input.all()) {
  const j = item.json;
  const previas = historico.filter(h => h.url === j.url && h.fecha !== j.fecha).slice(-1)[0];
  const bajaMucho = previas ? (Number(previas.nota) - Number(j.nota)) >= 8 : false;
  const bajoMinimo = Number(j.nota) < (minimos[j.url] ?? 80);
  salida.push({ json: { ...j, alarma: bajaMucho || bajoMinimo, aviso: `Velocidad ${j.url}: ${j.nota}/100 (minimo ${minimos[j.url] ?? 80}). LCP ${j.lcp} ms, CLS ${j.cls}.` } });
}
return salida;
```

**Cómo probarla**
- Ejecuta a mano con una sola URL y comprueba que en Sheets aparece la fila con la nota. Contrasta el número con `pagespeed.web.dev` a la misma hora: pueden bailar 3-5 puntos, es normal.
- Baja a propósito el `minimo` de una URL a `99` y comprueba que salta el aviso de Slack.

**Qué puede salir mal**
- Error 500 aleatorio de la API: por eso está Retry On Fail. Si falla siempre, la URL tarda demasiado o está bloqueada por contraseña o `robots.txt`.
- La nota de PageSpeed oscila por naturaleza; por eso comparamos con umbral de 8 puntos y no con cualquier bajada.
- Si mides 30 URLs, la ejecución puede durar 20 minutos: no es un fallo, pero sube el timeout del workflow en Settings > Workflow Timeout.
- No confundas `strategy=mobile` con `desktop`: si comparas mediciones mezcladas te volverás loco. Deja siempre móvil.

**Cuánto cuesta**
- API de PageSpeed: gratis (25.000/día, tú harás 4-30 a la semana).
- Sheets y Slack: gratis en sus planes básicos. n8n autoalojado gratis.
