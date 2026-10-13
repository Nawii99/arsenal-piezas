# Caché de llamadas caras a APIs…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Pone un intermediario entre tu web y las APIs que cobran por llamada: si la misma pregunta ya se hizo, devuelve la respuesta guardada al instante y gratis.

## Qué es y qué hace

Pone un intermediario entre tu web y las APIs de pago: calcula una huella de cada petición, mira en Redis si ya tiene la respuesta y, si la tiene, la devuelve sin gastar; si no, llama a la API, guarda el resultado con caducidad y lo devuelve. Entran peticiones desde tu web y la clave de la API; salen respuestas cacheadas. Para buscadores, calculadoras de envío o traductores con peticiones repetidas.

## Cómo usarla

1. Levanta Redis con límite de memoria
2. Guarda la clave de la API como credencial en n8n
3. Define la caducidad de caché por tipo de consulta
4. Mide el ahorro de llamadas durante una semana

## Cuándo usarla

Úsalo cuando llames a APIs de pago (IA, geocodificación, precios, envíos) con peticiones que se repiten mucho y la factura no pare de subir.

## Cómo ganar dinero con ella

En consultas repetitivas se ahorra entre el 40 % y el 80 % de las llamadas. Con una factura de 200 €/mes son 80-160 € al mes menos, y respuestas más rápidas.

- Optimización de costes de APIs para tiendas con buscador de productos o cálculo de envíos…
- Configuración de caché para apps con IA que repiten preguntas frecuentes…
- Mantenimiento de proxy de APIs para pymes con factura de llamadas creciente…

**Precio orientativo:** 150–400 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Tu aplicación deja de llamar a la API cara directamente y llama a este flujo. Él calcula una huella de la petición, mira si ya tiene la respuesta guardada y, si la tiene, la devuelve sin gastar. Si no, llama a la API real, guarda el resultado con caducidad y lo devuelve. Para webs con buscadores, calculadoras de envío, traductores o funciones de IA.

## Lo que necesitas antes
- Redis funcionando: `docker run -d --name cache -p 6379:6379 -v cache:/data redis:7-alpine redis-server --appendonly yes --maxmemory 256mb --maxmemory-policy allkeys-lru`.
- En n8n: Credentials → New → «Redis», Host `127.0.0.1`, Port 6379.
- La clave de la API cara, guardada como credencial Header Auth en n8n (nunca en el navegador).
- Una clave propia para que solo tu web pueda usar este proxy.

## Los nodos, en orden
1. **Webhook** — POST, Path: `cache/consulta`, Respond: «Using Respond to Webhook node».
2. **Code** (renómbralo «Huella») — Run Once for Each Item:
```javascript
const crypto = require('crypto');
const MI_CLAVE = 'CLAVE_INTERNA_LARGA';
const req = $input.item.json;
const autorizado = (req.headers['x-app-key'] || '') === MI_CLAVE;
const cuerpo = req.body || {};
const normal = JSON.stringify(cuerpo, Object.keys(cuerpo).sort());
const huella = crypto.createHash('sha256').update(normal.toLowerCase().trim()).digest('hex').slice(0, 32);
return { json: { autorizado, huella, consulta: cuerpo, clave: 'cache:' + huella } };
```
3. **IF** — `{{ $json.autorizado }}` is true. Rama false → **Respond to Webhook** con 401.
4. **Redis** — Operation: Get, Key: `={{ $json.clave }}`, Property Name: `guardado`, Options → Key Type: automatic.
5. **IF** (renómbralo «¿Está en caché?») — Condition: String → `{{ $json.guardado }}` is not empty.
6. Rama **true** (acierto) → **Respond to Webhook**, Respond With: JSON, Body: `={{ $json.guardado }}`. Añade una cabecera de respuesta `X-Cache: HIT` para poder medir.
7. Rama **false** (fallo de caché) → **HTTP Request** — la llamada real a la API cara. Method POST, URL del proveedor, Authentication: tu Header Auth, Body: `={{ JSON.stringify($('Huella').first().json.consulta) }}`. Options → Timeout 30000, Retry On Fail: on, Max Tries 2.
8. → **Code** (renómbralo «Preparar guardado»):
```javascript
const r = $input.item.json;
const h = $('Huella').first().json;
const util = r.body ?? r;
return { json: {
  clave: h.clave,
  valor: JSON.stringify(util),
  ttl: 86400 * 7
} };
```
9. → **Redis** — Operation: Set, Key: `={{ $json.clave }}`, Value: `={{ $json.valor }}`, Expire: on, TTL: `={{ $json.ttl }}`.
10. → **Respond to Webhook** con el JSON y cabecera `X-Cache: MISS`.
11. Extra recomendado: un **Schedule Trigger** diario + **Redis** (Operation: Info) + **Telegram** con `keyspace_hits` y `keyspace_misses` para ver cuánto estás ahorrando de verdad.

## Cómo probarla
- Lanza dos veces la misma petición con curl y compara: la segunda debe tardar milisegundos y traer `X-Cache: HIT`.
- Cambia una letra de la consulta: debe volver a ser MISS. Eso confirma que la huella distingue peticiones.
- Comprueba en `redis-cli keys 'cache:*'` que las claves se crean, y con `redis-cli ttl clave` que caducan.

## Qué puede salir mal
- **Datos que cambian**: no caches precios en tiempo real con 7 días de TTL. Ajusta: precios 5 minutos, traducciones 30 días, geocodificación indefinido.
- **Respuestas de error cacheadas**: si la API devuelve un 500 y lo guardas, sirves basura durante días. Añade un **IF** antes de guardar que exija `statusCode` entre 200 y 299.
- **Datos personales en la caché**: si la consulta lleva datos de clientes, la huella los deja en Redis. Pon TTL corto y no incluyas en la clave campos identificativos si no hacen falta.
- **Memoria llena**: la política `allkeys-lru` va tirando lo menos usado; con 256 MB caben decenas de miles de respuestas.
- **Redis caído**: el nodo Get dará error y romperá la petición. Marca en ese nodo «On Error: Continue (using error output)» y conéctalo a la rama de llamada real, para que sin caché siga funcionando.

## Cuánto cuesta
Redis auto-alojado 0 € (o Redis Cloud gratuito con 30 MB). n8n 0 €. El ahorro es directo en la factura de la API cara.
