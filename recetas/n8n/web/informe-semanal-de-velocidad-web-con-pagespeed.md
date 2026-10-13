# Informe semanal de velocidad web con PageSpeed…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Cada lunes mide la velocidad y los Core Web Vitals de tus páginas clave en móvil y escritorio, lo guarda en una hoja y te manda un email si algo empeora.

## Qué es y qué hace

Cada lunes envía tus URLs clave a la API gratuita de PageSpeed Insights, guarda puntuación, LCP, CLS e INP para móvil y escritorio en Google Sheets, y manda por email una tabla con alerta si alguna página cae más de 10 puntos respecto a la semana anterior. Entrada: clave de la API y lista de URLs. Salida: fila semanal por página y correo. Se monta en n8n y el mismo esquema sirve en Make o Zapier.

## Cómo usarla

1. Obtén la clave de PageSpeed
2. Crea la hoja Velocidad web
3. Define las URLs clave
4. Fija el umbral de 10 puntos

## Cuándo usarla

Úsalo cuando vives de tu web o de las de clientes y quieres detectar que una página se ha vuelto lenta antes de que Google te baje posiciones.

## Cómo ganar dinero con ella

Sustituye herramientas de monitorización de rendimiento de 30-100 €/mes y te ahorra la hora semanal de ir metiendo URLs a mano en PageSpeed Insights.

- Informe semanal de rendimiento para tiendas online que dependen de Google para vender.
- Seguimiento de Core Web Vitals para agencias con varias webs de clientes.
- Auditoría de velocidad mensual con recomendaciones priorizadas para blogs con tráfico.

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Todos los lunes a las 7:00 pasa tus URLs importantes por la API de PageSpeed Insights (la misma que usa la web pagespeed.web.dev), guarda la puntuación y los Core Web Vitals en una hoja y te manda un correo con la tabla y una alerta si alguna página ha caído más de 10 puntos respecto a la semana anterior.
Para dueños de tiendas online, blogs con tráfico y agencias que mantienen webs de clientes.

## Lo que necesitas antes
- Cuenta de n8n (gratis auto-alojada o prueba en n8n.cloud).
- Clave de la API de PageSpeed: entra en console.cloud.google.com, crea un proyecto, ve a «APIs y servicios > Biblioteca», busca «PageSpeed Insights API», actívala y en «Credenciales > Crear credenciales > Clave de API» copia la clave. Es gratis.
- Hoja de Google Sheets «Velocidad web» con columnas: `fecha`, `url`, `dispositivo`, `puntuacion`, `lcp`, `cls`, `inp`.
- Credenciales de Google Sheets y Gmail en n8n (ambas OAuth2, se conectan desde n8n).

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 7 * * 1` (lunes a las 7:00), zona horaria `Europe/Madrid`.
2. **Code** — devuelve la lista de URLs a medir y los dos dispositivos (código abajo, bloque 1).
3. **Split In Batches** — Batch Size `1`. Importante: la API se enfada si le mandas todo de golpe.
4. **HTTP Request** — Method `GET`, URL: `https://www.googleapis.com/pagespeedonline/v5/runPagespeed`. En *Query Parameters* añade: `url` = `={{ $json.url }}`, `strategy` = `={{ $json.dispositivo }}`, `category` = `performance`, `key` = tu clave. En *Options* pon `Timeout` = `120000` y activa `Retry On Fail` (3 intentos, 5 segundos de espera).
5. **Code** — extrae solo los números que importan (bloque 2).
6. **Google Sheets** (operación *Append Row*) — hoja «Velocidad web», mapea las columnas.
7. **Wait** — 2 segundos, y de ahí vuelve al **Split In Batches** para la siguiente URL.
8. Al terminar el bucle, **Google Sheets** (operación *Get Row(s)*) para leer el histórico, **Code** para comparar con la semana anterior y montar el HTML del email.
9. **Gmail** (operación *Send*) — a tu correo, asunto `Velocidad web semana {{ $now.format('W') }}`, cuerpo en HTML.

## Los nodos Code
```javascript
// Bloque 1: lista de URLs
const urls = [
  'https://tudominio.es/',
  'https://tudominio.es/servicios',
  'https://tudominio.es/producto-estrella'
];
const salida = [];
for (const url of urls) {
  salida.push({ json: { url, dispositivo: 'mobile' } });
  salida.push({ json: { url, dispositivo: 'desktop' } });
}
return salida;
```
```javascript
// Bloque 2: extraer métricas
const r = $input.first().json;
const audits = r.lighthouseResult.audits;
const entrada = $('Split In Batches').first().json;
return [{ json: {
  fecha: new Date().toISOString().slice(0,10),
  url: entrada.url,
  dispositivo: entrada.dispositivo,
  puntuacion: Math.round(r.lighthouseResult.categories.performance.score * 100),
  lcp: audits['largest-contentful-paint'].numericValue / 1000,
  cls: audits['cumulative-layout-shift'].numericValue,
  inp: audits['interactive'] ? audits['interactive'].numericValue / 1000 : null
} }];
```

## Cómo probarla
- Ejecuta el workflow a mano con una sola URL en el bloque 1 y comprueba que la fila aparece en la hoja con una puntuación entre 0 y 100.
- Compara ese número con el que da pagespeed.web.dev para la misma URL: puede variar 3-5 puntos, es normal (la medición es de laboratorio).
- Deja las URLs definitivas y activa el workflow.

## Qué puede salir mal
- **Error 429 o 500 de la API**: es el fallo más típico. Se arregla con el Split In Batches de 1 en 1, el Wait de 2 segundos y el Retry On Fail. Sin clave de API el límite es ridículo, con clave gratuita tienes 25.000 peticiones al día.
- **Timeout**: una web lenta puede tardar más de 60 segundos en analizarse. Por eso el Timeout está en 120 segundos.
- **Puntuaciones que bailan**: la misma URL puede dar 78 y 85 en dos medidas seguidas. No te alarmes con menos de 10 puntos de diferencia; por eso la alerta salta a partir de 10.
- **URLs con redirección**: mide la URL final (con o sin barra al final, con o sin www), o compararás peras con manzanas cada semana.

## Cuánto cuesta
- API de PageSpeed: gratis hasta 25.000 consultas diarias, muy por encima de lo que vas a usar.
- Google Sheets y Gmail: gratis.
- n8n: 0 € auto-alojado. Si usas n8n.cloud, este workflow gasta unas 30 ejecuciones al mes, cabe en cualquier plan.
