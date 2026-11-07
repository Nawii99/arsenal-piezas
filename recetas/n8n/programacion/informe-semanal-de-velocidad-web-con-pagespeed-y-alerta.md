# Informe semanal de velocidad web con PageSpeed y alerta…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Cada lunes mide la velocidad de tus páginas clave en móvil, guarda las notas en una hoja y te avisa si alguna ha empeorado más de 10 puntos respecto a la semana anterior.

## Qué es y qué hace

Flujo de n8n que se ejecuta cada lunes, llama a la API de PageSpeed Insights con una lista de URLs y guarda puntuación, LCP, CLS e INP en Google Sheets. Compara con la medición anterior y envía un aviso por Gmail si una página cae más de 10 puntos. Sirve para vigilar el rendimiento tras cada cambio en la web.

## Cómo usarla

1. Crea la clave de PageSpeed en Google Cloud
2. Prepara la hoja con sus columnas
3. Define la lista de URLs y los umbrales
4. Activa el aviso semanal

## Cuándo usarla

Cuando tienes webs o tiendas donde la velocidad afecta a las ventas y al SEO, y solo te enteras de que va lenta cuando ya es tarde.

## Cómo ganar dinero con ella

Detecta regresiones de rendimiento antes de que hundan las conversiones. Sustituye herramientas de monitorización de 20-50 €/mes.

- Control de velocidad mensual para tiendas online de clientes…
- Informe de rendimiento para agencias de SEO con histórico en hoja…
- Auditoría inicial de velocidad antes de entregar una web nueva…

**Precio orientativo:** 120–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Llama a la API de PageSpeed Insights para una lista de URLs, guarda puntuación, LCP, CLS e INP en una hoja con la fecha, compara con la medición anterior y avisa si hay bajón.
Para quien vende por internet o vive del SEO y hace cambios en la web sin medir el efecto.

## Lo que necesitas antes
- Una clave de API de Google: console.cloud.google.com > crea un proyecto > APIs y servicios > Biblioteca > activa `PageSpeed Insights API` > Credenciales > Crear credenciales > Clave de API. Es gratis.
- Una hoja de Google Sheets `velocidad` con columnas: `fecha`, `url`, `estrategia`, `puntuacion`, `lcp`, `cls`, `inp`.
- Credenciales Google Sheets y Gmail en n8n.

## Los nodos, en orden
**1. Schedule Trigger** — `Weeks`, lunes, hora 7. Timezone `Europe/Madrid`.
**2. Code** («URLs a medir») — un item por página clave (portada, categoría, ficha de producto, checkout).
**3. Split In Batches** — Batch Size `1`. La API es lenta (10-30 segundos por URL) y no admite ráfagas.
**4. HTTP Request** («Medir») — `GET` `https://www.googleapis.com/pagespeedonline/v5/runPagespeed`, Send Query Parameters activado con: `url` = `={{ $json.url }}`, `strategy` = `mobile`, y añade cuatro veces el parámetro `category` con valor `performance`. Options > Timeout `120000`, y `Never Error` activado. La clave de API va en Authentication > `Generic Credential Type` > `Query Auth` (credencial de n8n con Name `key` y Value tu clave), nunca escrita en los parámetros del nodo: un flujo exportado se llevaría la clave.
**5. Code** («Extraer métricas») — saca los números del JSON gigante.
**6. Google Sheets** — Operation `Append Row` en `velocidad`.
**7. Wait** — 5 `Seconds`, y de vuelta al `Split In Batches` para la siguiente URL.
**8. Google Sheets** («Histórico») — al terminar el bucle (salida `done`), Operation `Get Row(s)` de toda la hoja.
**9. Code** («Comparar semanas») — busca caídas de más de 10 puntos.
**10. IF** + **Gmail** — si hay caídas, email con la tabla.

## El código del nodo 2
```javascript
const urls = [
  'https://tudominio.com/',
  'https://tudominio.com/tienda',
  'https://tudominio.com/producto/estrella'
];
return urls.map(u => ({ json: { url: u } }));
```

## El código del nodo 5
```javascript
const r = $input.first().json;
if (!r.lighthouseResult) return [{ json: { fecha: new Date().toISOString().slice(0,10), url: $('URLs a medir').item.json.url, estrategia: 'mobile', puntuacion: 0, lcp: 0, cls: 0, inp: 0 } }];
const a = r.lighthouseResult.audits;
const num = (k) => a[k] && a[k].numericValue ? Math.round(a[k].numericValue * 1000) / 1000 : 0;
return [{ json: {
  fecha: new Date().toISOString().slice(0,10),
  url: r.id,
  estrategia: 'mobile',
  puntuacion: Math.round(r.lighthouseResult.categories.performance.score * 100),
  lcp: Math.round(num('largest-contentful-paint')) / 1000,
  cls: num('cumulative-layout-shift'),
  inp: Math.round(num('interaction-to-next-paint'))
}}];
```

## El código del nodo 9
```javascript
const filas = $input.all().map(i => i.json).filter(f => f.url);
const porUrl = {};
for (const f of filas) { (porUrl[f.url] = porUrl[f.url] || []).push(f); }
const alertas = [];
for (const [url, lista] of Object.entries(porUrl)) {
  lista.sort((a, b) => String(a.fecha).localeCompare(String(b.fecha)));
  if (lista.length < 2) continue;
  const hoy = lista[lista.length - 1];
  const antes = lista[lista.length - 2];
  const dif = Number(hoy.puntuacion) - Number(antes.puntuacion);
  if (dif <= -10) alertas.push('<tr><td>' + url + '</td><td>' + antes.puntuacion + '</td><td>' + hoy.puntuacion + '</td><td>' + dif + '</td><td>' + hoy.lcp + ' s</td></tr>');
}
if (!alertas.length) return [{ json: { hay: false } }];
return [{ json: { hay: true, html: '<h3>Bajadas de rendimiento</h3><table border=1 cellpadding=6><tr><th>URL</th><th>Antes</th><th>Ahora</th><th>Dif.</th><th>LCP</th></tr>' + alertas.join('') + '</table>' } }];
```

## Cómo probarla
1. Ejecuta a mano y mira que la hoja se llena con tres filas y números coherentes (compáralo con pagespeed.web.dev abriendo la misma URL).
2. Cambia a mano una puntuación antigua de la hoja a 95 para forzar una caída y comprueba que llega el email.
3. Deja pasar dos lunes para tener histórico real.

## Qué puede salir mal
- **La medición varía sola**: PageSpeed en modo laboratorio da ±5 puntos entre ejecuciones. Por eso el umbral es de 10, no de 3. No te vuelvas loco con las oscilaciones pequeñas.
- **Error 429 o 500**: la API tiene cuota de 25.000 consultas al día pero limita las ráfagas; el Split In Batches de 1 con Wait de 5 segundos lo evita.
- **Timeout**: una URL pesada puede tardar más de 60 segundos, sube el timeout del nodo a 120.000 ms.
- **URLs detrás de contraseña** no se pueden medir: PageSpeed necesita acceso público.
- **El bucle no avanza**: recuerda conectar la salida del Wait de vuelta a la entrada del Split In Batches; es el fallo clásico.

## Cuánto cuesta
0 €. La API de PageSpeed Insights es gratuita con clave (25.000 consultas al día); Sheets, Gmail y n8n auto-alojado, gratis.
