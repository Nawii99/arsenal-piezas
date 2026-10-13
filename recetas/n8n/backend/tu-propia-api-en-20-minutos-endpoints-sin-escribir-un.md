# Tu propia API en 20 minutos: endpoints sin escribir un…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Convierte n8n en una pequeña API que devuelve JSON: consulta tu base de datos o tus hojas, aplica una clave de acceso y responde a tu web o a tu app.

## Qué es y qué hace

Publica tres endpoints en n8n: listado de productos con filtros y paginación, detalle por ID y un POST de contacto que guarda y avisa. Cada llamada exige clave y devuelve JSON con códigos HTTP correctos. Entrada: petición HTTP con clave; salida: JSON desde tu base o tu hoja. Pensado para webs estáticas o apps que necesitan datos dinámicos sin montar un servidor propio.

## Cómo usarla

1. Configura n8n con dominio y HTTPS
2. Crea la clave de acceso
3. Prueba los tres endpoints con curl
4. Que lo revise un profesional si expones datos personales

## Cuándo usarla

Cuando tu web estática o tu app necesite datos dinámicos, o cuando quieras dar a un cliente o a un colaborador acceso controlado a unos datos sin abrirle la base de datos.

## Cómo ganar dinero con ella

Te ahorra desarrollar y mantener un backend (de 1.500 a 5.000 euros de desarrollo inicial) y el hosting de una aplicación adicional.

- Mini API de catálogo para tiendas que quieren mostrar productos en su web.
- Endpoint de contacto y datos para landings de clientes sin backend propio.
- Acceso controlado a datos para colaboradores o clientes sin abrir la base.

**Precio orientativo:** 250–800 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Publica tres endpoints reales: `GET /api/productos` con filtros y paginación, `GET /api/productos/:id` y `POST /api/contacto` que guarda y avisa. Todo con autenticación por clave, límite de peticiones y respuestas JSON con códigos HTTP correctos.
Está pensado para que tu landing en HTML, tu app móvil o el Zapier de un cliente puedan pedirte datos sin que tú levantes ni mantengas un servidor Node o PHP.

## Lo que necesitas antes
- n8n **auto-alojado con dominio propio y HTTPS** (con Caddy o el proxy de tu VPS, es una línea de configuración). Necesario porque los webhooks tienen que estar siempre activos y quieres una URL bonita.
- La variable de entorno `WEBHOOK_URL=https://api.tudominio.com/` en el docker-compose de n8n, para que las URLs que genera sean las buenas.
- Una base de datos con los datos (Postgres, MySQL) o una hoja de Google Sheets.
- Una clave de API que te inventas tú, larga y aleatoria: `openssl rand -hex 24`.
- Redis si quieres límite de peticiones serio (opcional; abajo hay una versión sin Redis).

## Los nodos, en orden (endpoint de listado)
1. **Webhook** — HTTP Method: GET, Path: `api/productos`, Authentication: Header Auth (credencial con Name `X-API-Key` y Value tu clave), Respond: Using 'Respond to Webhook' node. En Options activa "Raw Body" desactivado y "Response Headers" con `Access-Control-Allow-Origin: https://tudominio.com`.
2. **Code** (nombre: Validar parámetros) — saca `page`, `limit`, `categoria` y `q` de la query, con valores por defecto y topes. Código abajo.
3. **IF** (nombre: ¿Parámetros válidos?) — `={{ $json.error === null }}` is true.
4. **Postgres** (nombre: Consultar) — Operation: Execute Query, con la consulta parametrizada de abajo. **Nunca** metas texto del usuario dentro del SQL con una expresión: usa Query Parameters.
5. **Code** (nombre: Formatear) — monta el objeto de respuesta con datos y metadatos de paginación.
6. **Respond to Webhook** — Respond With: JSON, Response Body: `={{ JSON.stringify($json) }}`, Response Code: 200, Response Headers: `Content-Type: application/json` y `Cache-Control: public, max-age=60`.
7. (rama falsa del IF) **Respond to Webhook** — Response Code: 400, Body: `={{ JSON.stringify({ error: $json.error }) }}`.

## El código del nodo "Validar parámetros"
```javascript
const q = $json.query || {};
let error = null;
const page = Math.max(1, parseInt(q.page || '1', 10) || 1);
let limit = parseInt(q.limit || '20', 10) || 20;
if (limit > 100) limit = 100;
const categoria = (q.categoria || '').slice(0, 50);
const buscar = (q.q || '').slice(0, 100);
if (q.page && isNaN(parseInt(q.page, 10))) error = 'El parámetro page debe ser un número';
return [{ json: { page, limit, offset: (page - 1) * limit, categoria: categoria || null, buscar: buscar ? '%' + buscar + '%' : null, error } }];
```

## La consulta parametrizada
```sql
SELECT id, sku, nombre, descripcion, precio, stock, categoria,
       count(*) OVER() AS total
FROM productos
WHERE activo = true
  AND ($1::text IS NULL OR categoria = $1)
  AND ($2::text IS NULL OR nombre ILIKE $2)
ORDER BY nombre
LIMIT $3 OFFSET $4;
```
Query Parameters (en este orden): `={{ $json.categoria }}`, `={{ $json.buscar }}`, `={{ $json.limit }}`, `={{ $json.offset }}`.

## El código del nodo "Formatear"
```javascript
const filas = $input.all().map(i => i.json);
const total = filas.length ? Number(filas[0].total) : 0;
const p = $('Validar parámetros').first().json;
const datos = filas.map(({ total, ...r }) => ({ ...r, precio: Number(r.precio) }));
return [{ json: { datos, meta: { pagina: p.page, por_pagina: p.limit, total, paginas: Math.ceil(total / p.limit) } } }];
```

## El endpoint POST /api/contacto
1. **Webhook** — POST, Path: `api/contacto`, Respond: Using 'Respond to Webhook'.
2. **Code** (nombre: Validar) — comprueba que hay nombre, email con formato válido y mensaje de menos de 2.000 caracteres; rechaza si el campo oculto `website` viene relleno (trampa antibots).
3. **Postgres** — INSERT en la tabla contactos.
4. **Gmail** — te avisa a ti.
5. **Respond to Webhook** — código 201 con `{"ok":true}`.

## Límite de peticiones sin Redis
Añade justo tras el Webhook un **Code** con esto (usa la memoria estática del workflow, suficiente para proteger de abusos tontos):
```javascript
const ip = $json.headers['x-forwarded-for'] || $json.headers['x-real-ip'] || 'sin-ip';
const st = $getWorkflowStaticData('global');
st.hits = st.hits || {};
const ahora = Date.now();
st.hits[ip] = (st.hits[ip] || []).filter(t => ahora - t < 60000);
st.hits[ip].push(ahora);
const bloqueado = st.hits[ip].length > 60;
return [{ json: { ...$json, bloqueado, ip } }];
```
Detrás, un **IF** que si `bloqueado` es true responde con código 429.

## Cómo probarla
- `curl -H 'X-API-Key: TU_CLAVE' 'https://api.tudominio.com/webhook/api/productos?limit=5&categoria=camisetas'` y mira que el JSON tenga `datos` y `meta`.
- Prueba sin la cabecera: debe darte 403.
- Prueba con `limit=99999`: debe capar a 100.
- Prueba con `categoria=' OR 1=1--`: no debe devolver de más ni petar. Si devuelve todo, has metido el parámetro en el SQL en vez de usar Query Parameters. Arréglalo.
- Haz 70 peticiones seguidas con un bucle bash: la 61 en adelante deben dar 429.

## Qué puede salir mal
- **Confundir la URL de test con la de producción**: n8n te da `/webhook-test/...` mientras editas y `/webhook/...` cuando el workflow está activo. La de test solo funciona si le das a "Listen for test event".
- **CORS**: si llamas desde el navegador te hará falta responder también al método OPTIONS. Crea un segundo nodo Webhook con Method OPTIONS y la misma ruta que responda 204 con las cabeceras Allow.
- **Latencia**: n8n no es tan rápido como un backend de verdad; cuenta con 100-400 ms por petición. Para un catálogo va sobrado, para algo de alto tráfico no.
- **Volumen**: en n8n auto-alojado cada petición es una ejecución guardada en la base de datos. Ve a Settings del workflow y pon "Save successful production executions: No" o te crecerá sin control.
- **Clave de API en el frontend**: si la pones en el JavaScript de tu web, es pública. Para eso, mejor sin clave y con el CORS bien cerrado y el límite de peticiones.

## Cuánto cuesta
- n8n auto-alojado: gratis, más el VPS (5-10 euros al mes según tráfico).
- En n8n Cloud, cada llamada consume ejecución; a partir de unas 2.500 al mes te toca plan de pago (unos 20 euros).
- Base de datos: gratis en Supabase o Neon hasta medio giga.
