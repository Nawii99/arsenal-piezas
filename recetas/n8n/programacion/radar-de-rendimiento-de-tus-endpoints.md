# Radar de rendimiento de tus endpoints…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Mide cada hora cuánto tarda tu API en responder desde fuera, guarda el histórico y te avisa cuando un endpoint se degrada frente a su media de la semana.

## Qué es y qué hace

Cada hora llama a una lista de endpoints de tu API o web desde fuera, mide el tiempo de respuesta y el código HTTP, guarda el histórico en Google Sheets y calcula la mediana de los últimos siete días. Entrada: hoja Endpoints con URL, método y tiempo máximo. Salida: una fila por medición y un aviso por Telegram si la última medición se dispara más del doble. Se monta en n8n y el mismo esquema puede replicarse en Make o Zapier.

## Cómo usarla

1. Rellena la hoja de endpoints
2. Configura un token de solo lectura si hace falta
3. Fija el margen de alerta
4. Revisa la mediana semanal

## Cuándo usarla

Cuando tu web o API funciona pero «a veces va lenta» y no tienes datos para saber cuándo empezó ni qué parte es.

## Cómo ganar dinero con ella

Sustituye a un monitor de rendimiento de pago (25-50 €/mes) y te da el dato objetivo para justificar o descartar una optimización.

- Monitorización de rendimiento mensual para tiendas online con informe de tiempos de respuesta.
- Vigilancia de APIs de clientes con alertas de degradación y un resumen mensual.
- Diagnóstico de lentitud para proyectos que dicen va lenta y necesitan datos antes de optimizar.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

### Qué hace y para quién
Llama cada hora a una lista de rutas de tu aplicación, registra el tiempo de respuesta y el código HTTP, calcula la mediana de los últimos siete días y avisa si la última medición se dispara más del doble.
Para quien tiene una aplicación en producción y quiere datos de rendimiento sin instalar agentes ni pagar observabilidad.

### Lo que necesitas antes
- n8n.
- Hoja de Google Sheets «Latencia» con columnas: `fecha`, `endpoint`, `ms`, `codigo`.
- Una segunda hoja «Endpoints» con: `nombre`, `url`, `metodo`, `espera_max_ms`.
- Si tus rutas requieren autenticación, un token de solo lectura o un usuario de prueba.
- Bot de Telegram para los avisos.

### Los nodos, en orden
1. **Schedule Trigger** — Mode `Every X`, cada `1` hora, timezone `Europe/Madrid`.
2. **Google Sheets** (nombre: «Lista de endpoints») — Operation `Get Row(s)` de la hoja «Endpoints».
3. **Split In Batches** — Batch Size `1`, para medir cada llamada limpia y sin interferencias.
4. **Code** (nombre: «Marca de inicio») — guarda el timestamp antes de llamar.
5. **HTTP Request** (nombre: «Llamar endpoint») — Method `{{ $json.metodo }}`, URL `{{ $json.url }}`. Settings: `Continue On Fail` activado, `Timeout` 15000 ms, y en Options marca `Include Response Headers and Status`. **No** actives Retry: reintentar falsearía la medición.
6. **Code** (nombre: «Medir») — calcula los milisegundos transcurridos y el veredicto.
7. **Google Sheets** — Operation `Append` en «Latencia».
8. **Google Sheets** (nombre: «Histórico») — Operation `Get Row(s)` filtrando por ese endpoint, Limit 200.
9. **Code** (nombre: «Comparar con la mediana») — calcula mediana y percentil 95 y decide si hay degradación.
10. **IF** — Condition: Boolean `{{ $json.degradado }}` `is true`.
11. **Telegram** — Operation `Send Message`.

### El código del nodo «Medir»
```javascript
const inicio = $('Marca de inicio').first().json.t0;
const fila = $('Split In Batches').first().json;
const res = $input.first().json;
const ms = Date.now() - inicio;
const codigo = (res.$response && res.$response.statusCode) || res.statusCode || (res.error ? 0 : 200);
return [{ json: { fecha: new Date().toISOString(), endpoint: fila.nombre, url: fila.url, ms, codigo, espera_max_ms: Number(fila.espera_max_ms || 1500) } }];
```

### El código del nodo «Comparar con la mediana»
```javascript
const actual = $('Medir').first().json;
const hist = $input.all().map(i => Number(i.json.ms)).filter(n => n > 0).sort((a, b) => a - b);
const mediana = hist.length ? hist[Math.floor(hist.length / 2)] : actual.ms;
const p95 = hist.length ? hist[Math.floor(hist.length * 0.95)] : actual.ms;
const degradado = actual.codigo >= 400 || actual.codigo === 0 || actual.ms > Math.max(actual.espera_max_ms, mediana * 2);
const texto = `🐌 ${actual.endpoint}\nAhora: ${actual.ms} ms (HTTP ${actual.codigo})\nMediana 7 días: ${mediana} ms · p95: ${p95} ms\n${actual.url}`;
return [{ json: { ...actual, mediana, p95, degradado, texto } }];
```

### El código del nodo «Marca de inicio»
```javascript
return [{ json: { ...$input.first().json, t0: Date.now() } }];
```

### Cómo probarla
- Empieza con tres rutas: la portada, un endpoint de lectura y uno que haga consulta pesada a base de datos.
- Ejecuta a mano cinco veces seguidas y mira que los milisegundos varían poco: si bailan mucho, tu red o el propio n8n están metiendo ruido.
- Apaga a propósito el servicio un minuto: debe llegarte el aviso con código 0.

### Qué puede salir mal
- **Mides tu red, no tu servidor**: la latencia incluye el viaje; ejecuta n8n en un sitio estable y compara siempre contra la mediana propia, no contra números absolutos.
- **Endpoints que escriben datos**: no midas un `POST /pedidos` real; crea una ruta `/health` que toque base de datos sin escribir nada.
- **La hoja crece sin freno**: 3 endpoints × 24 horas × 30 días son 2.160 filas al mes; borra o archiva lo anterior a 90 días, o cambia a InfluxDB si quieres gráficas serias.
- **Filtrar el histórico en Sheets es lento**: si te molesta, sustituye el paso 8 por un nodo `Postgres` con una tabla propia.
- **Cachés que te engañan**: añade un parámetro aleatorio a la URL (`?t={{Date.now()}}`) si quieres medir sin caché.

### Cuánto cuesta
- 0 € con n8n auto-alojado, Sheets y Telegram.
- En n8n Cloud (prueba gratuita temporal y después de pago), una ejecución por hora son ~720 al mes y puedes pasarte del límite del plan: aquí conviene auto-alojar (VPS de 5 €/mes).
- Un servicio equivalente de monitorización de rendimiento cuesta entre 25 y 50 €/mes.
