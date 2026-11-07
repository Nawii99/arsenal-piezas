# Informe semanal de velocidad con PageSpeed…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Mide cada semana la velocidad de tus páginas clave en móvil y ordenador con la herramienta oficial de Google y te avisa si empeoran.

## Qué es y qué hace

Cada lunes llama a la API gratuita de PageSpeed Insights para cuatro o cinco URL clave, en móvil y ordenador, y guarda puntuación, LCP, CLS e INP en Google Sheets. Envía un correo si una URL baja de 70 o empeora más de 10 puntos. Entrada: lista de URL y clave de API; salida: hoja de evolución y aviso. Se monta en n8n.

## Cómo usarla

1. Activa PageSpeed Insights API en Google Cloud y crea la clave
2. Prepara la hoja Velocidad web
3. Define las URL clave
4. Programa el lunes a las 6:00

## Cuándo usarla

Cuando has instalado plugins, cambiado plantilla o subido fotos pesadas y no sabes si tu web se ha vuelto más lenta.

## Cómo ganar dinero con ella

Cada segundo de más en móvil se lleva alrededor de un 7% de las conversiones. Ver la caída la semana que pasa, no seis meses después, evita perder ventas a ciegas.

- Seguimiento semanal de velocidad para una tienda online tras cambios de plantilla.
- Informe de rendimiento web para una agencia que mantiene varias webs de clientes.
- Auditoría mensual de velocidad para un negocio local con web en WordPress.

**Precio orientativo:** 80–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Llama a la API gratuita de PageSpeed Insights para 4 o 5 URLs importantes (portada, categoría, ficha de producto, checkout, artículo estrella).
Guarda las notas en una hoja para ver la evolución y te manda un correo si alguna baja de 70 o empeora más de 10 puntos respecto a la semana anterior.

## Lo que necesitas antes
- Una clave de API de Google: entra en Google Cloud Console, crea un proyecto, ve a *APIs y servicios > Biblioteca*, activa «PageSpeed Insights API», y en *Credenciales* crea una *Clave de API*. Es gratis y no pide tarjeta.
- Hoja de Google «Velocidad web» con columnas: `fecha`, `url`, `dispositivo`, `puntuacion`, `lcp`, `cls`, `inp`.
- Credencial de Google Sheets y Gmail en n8n.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 6 * * 1` (lunes 6:00), `Timezone` `Europe/Madrid`.
2. **Code** («Lista de URLs») — devuelve las páginas a medir, en móvil y escritorio.
3. **Split In Batches** — *Batch Size* 1. La API tarda 20-40 segundos por página, hay que ir de uno en uno.
4. **HTTP Request** — GET a `https://www.googleapis.com/pagespeedonline/v5/runPagespeed?url={{ encodeURIComponent($json.url) }}&strategy={{ $json.dispositivo }}&category=performance`. Authentication: Generic Credential Type > Query Auth, con una credencial de n8n (Name `key`, Value tu clave de API de Google). No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él. Pon *Timeout* 120000 y *Retry On Fail* ON con 3 intentos y 5 segundos de espera.
5. **Code** («Extraer métricas») — se queda con lo que importa.
6. **Google Sheets** — *Append Row* en «Velocidad web».
7. Conecta de vuelta a **Split In Batches**.
8. **Google Sheets** («Leer histórico», salida *done*) — *Get Rows* de la misma hoja.
9. **Code** («Comparar semanas») — busca caídas.
10. **IF** — `{{ $json.hayAvisos }}` is true → **Gmail** *Send Message* con el resumen.

## El código del nodo «Lista de URLs»
```javascript
const urls = [
  'https://tunegocio.es/',
  'https://tunegocio.es/tienda',
  'https://tunegocio.es/producto/mi-mas-vendido',
  'https://tunegocio.es/contacto'
];
const salida = [];
for (const url of urls) {
  salida.push({ json: { url, dispositivo: 'mobile' } });
  salida.push({ json: { url, dispositivo: 'desktop' } });
}
return salida;
```

## El código del nodo «Extraer métricas»
```javascript
const r = $json.lighthouseResult || {};
const a = r.audits || {};
const lote = $('Split In Batches').first().json;
return [{ json: {
  fecha: new Date().toISOString().slice(0,10),
  url: lote.url,
  dispositivo: lote.dispositivo,
  puntuacion: Math.round((r.categories?.performance?.score || 0) * 100),
  lcp: a['largest-contentful-paint']?.displayValue || '',
  cls: a['cumulative-layout-shift']?.displayValue || '',
  inp: a['interaction-to-next-paint']?.displayValue || a['total-blocking-time']?.displayValue || ''
} }];
```

## Cómo probarla
- Ejecuta con una sola URL primero: si la API tarda y da timeout, sube el *Timeout* a 180000.
- Comprueba que la fila aparece en la hoja con una puntuación entre 0 y 100.
- Mete una fila falsa de la semana pasada con puntuación 95 y ejecuta: te debe avisar de la caída.

## Qué puede salir mal
- **Error 429 «Quota exceeded»**: la API gratuita permite 25.000 consultas al día pero solo unas 240 por minuto. Con Split In Batches de 1 y 10 URLs no hay problema; si aumentas, mete un nodo **Wait** de 5 segundos.
- **La puntuación baila mucho entre semanas**: es normal, PageSpeed usa datos de laboratorio y varía. Por eso avisamos solo con caídas de más de 10 puntos, no de 3.
- **Timeout en páginas muy lentas**: sube el timeout y activa los reintentos, no lo trates como error real.
- **No escribas la clave en la URL**: se guardaría en el historial de ejecuciones. Va en la credencial *Query Auth* de n8n (Name `key`).

## Cuánto cuesta
- PageSpeed Insights API: gratis, 25.000 consultas diarias sin tarjeta.
- Google Sheets y Gmail: gratis.
- n8n: unas 30 ejecuciones de nodo por semana; cabe en cualquier plan. En Make serían unas 40 operaciones semanales, dentro del gratuito.
