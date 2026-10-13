# Presupuesto de rendimiento semanal con alerta de regres…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Mide cada semana la velocidad de tus páginas clave con PageSpeed Insights, guarda el histórico y te avisa solo cuando la nota o las Core Web Vitals empeoran respecto a la semana anterior.

## Qué es y qué hace

Cada lunes analiza una lista de URLs con la API gratuita de PageSpeed Insights, guarda nota, LCP, CLS e INP en Google Sheets y compara con la medición anterior. Solo envía un aviso si alguna métrica empeora por encima del margen que fijes. Entrada: clave de API y pestañas urls e historico. Salida: fila histórica y alerta de regresión. Se monta en n8n y el mismo esquema puede replicarse en Make o Zapier.

## Cómo usarla

1. Crea la clave de PageSpeed
2. Prepara las pestañas urls e historico
3. Fija el margen de regresión
4. Revisa la alerta durante una semana de prueba

## Cuándo usarla

Cuando mantienes webs vivas y quieres enterarte de que un plugin, una fuente nueva o una imagen sin comprimir han hundido la velocidad antes de que lo note Google.

## Cómo ganar dinero con ella

Sustituye una auditoría manual mensual (2-3 h) y evita perder posiciones por rendimiento. Coste 0 € con la API gratuita de Google.

- Guardián de rendimiento para tiendas que cambian plugins o imágenes con frecuencia.
- Control de velocidad mensual para agencias que quieren evitar regresiones en sus clientes.
- Servicio de auditoría de rendimiento con alerta solo cuando hay caídas reales.

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Todos los lunes analiza una lista de URLs con la API de PageSpeed Insights, guarda nota, LCP, CLS e INP en una hoja y compara con la medición anterior.
Solo te escribe si algo ha empeorado por encima del margen que tú decidas: es un guardián, no un informe más que nadie lee.

## Lo que necesitas antes
- n8n.
- Una clave de la API de PageSpeed: entra en console.cloud.google.com, crea un proyecto, en `APIs y servicios > Biblioteca` activa `PageSpeed Insights API`, y en `Credenciales` crea una `Clave de API`. Es gratis.
- Hoja de Google Sheets `Rendimiento` con dos pestañas: `urls` (columnas `url`, `cliente`) y `historico` (columnas `fecha`, `url`, `estrategia`, `nota`, `lcp`, `cls`, `inp`).
- Credenciales de Google Sheets y Gmail en n8n.

## Los nodos, en orden
1. **Schedule Trigger** — `Weeks`, lunes, 06:00, timezone `Europe/Madrid`.
2. **Google Sheets** — `Get Row(s)` de la pestaña `urls`.
3. **Split In Batches** — Batch Size `1` (la API tarda 20-40 s por URL).
4. **HTTP Request** — GET a `https://www.googleapis.com/pagespeedonline/v5/runPagespeed?url={{ encodeURIComponent($json.url) }}&strategy=mobile&category=performance&key=TU_CLAVE`. En Options pon `Timeout: 120000` y `Retry On Fail` con 3 intentos y 5000 ms de espera.
5. **Code** — extrae las métricas del JSON gigante (código abajo).
6. **Google Sheets** — `Append Row` en `historico`.
7. **Google Sheets** — `Get Row(s)` en `historico` con filtro por `url`, para leer las mediciones anteriores.
8. **Code** — compara la nueva con la última anterior y marca `regresion` si la nota baja 5 puntos o más, o si el LCP supera 2500 ms.
9. **IF** — `{{ $json.regresion }}` es true.
10. **Gmail** — `Send`, asunto `Bajada de rendimiento en {{ $json.url }}`, cuerpo con nota anterior, nota nueva y las tres métricas.
11. Realimenta al **Split In Batches**.

## El nodo Code de extracción
```js
const salida = [];
for (const item of $input.all()) {
  const r = item.json;
  const lh = r.lighthouseResult || {};
  const a = lh.audits || {};
  salida.push({ json: {
    fecha: new Date().toISOString().slice(0,10),
    url: lh.finalUrl || r.id,
    estrategia: 'mobile',
    nota: Math.round(((lh.categories||{}).performance||{}).score * 100),
    lcp: ((a['largest-contentful-paint']||{}).numericValue||0),
    cls: ((a['cumulative-layout-shift']||{}).numericValue||0),
    inp: ((a['interaction-to-next-paint']||{}).numericValue||0)
  }});
}
return salida;
```

## Cómo probarla
- Lanza el workflow a mano con una sola URL y comprueba que la nota coincide con la que ves en pagespeed.web.dev.
- Edita a mano la última fila del histórico poniendo una nota de 99 y vuelve a ejecutar: debe saltar el aviso de regresión.
- Prueba con una URL que no exista: debe fallar solo esa iteración, no el workflow entero.

## Qué puede salir mal
- **Límite de la API**: 25.000 consultas al día y 240 por minuto, pero las peticiones son lentas; con más de 30 URLs usa Batch Size 1 y un nodo **Wait** de 5 segundos entre iteraciones.
- **Ruido**: PageSpeed varía ±5 puntos entre ejecuciones. Por eso el umbral es 5 puntos, no 1. Si te sigue dando falsos positivos, sube a 8.
- **Timeouts**: si el sitio es lento, la API tarda; sube el Timeout a 120 s y activa Retry On Fail.
- **Móvil vs escritorio**: mide en `mobile`, que es lo que usa Google para posicionar. Si quieres las dos, duplica el HTTP Request con `strategy=desktop`.

## Cuánto cuesta
Todo gratis: la API de PageSpeed no se cobra, Sheets y Gmail tampoco. Si lo montas en n8n Cloud, unas 40 ejecuciones semanales caben en el plan de entrada.
