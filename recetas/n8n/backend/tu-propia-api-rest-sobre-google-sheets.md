# Tu propia API REST sobre Google Sheets…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Convierte una hoja de cálculo en una API con clave de acceso: consultar, crear y actualizar registros desde tu web o tu app sin montar servidor ni base de datos.

## Qué es y qué hace

Publica tres endpoints (listar, crear y actualizar) que leen y escriben una hoja de Google, protegidos con una clave de API y con CORS configurado. Entran peticiones HTTP desde tu web o app con la clave; salen registros en JSON. Sirve para landings con formulario, catálogos o listas de espera que no necesitan base de datos propia. Requiere n8n con HTTPS público y credencial de Sheets.

## Cómo usarla

1. Crea la hoja Datos con cabeceras
2. Genera una clave larga con openssl
3. Configura el Webhook con CORS en n8n
4. Prueba los tres endpoints desde tu web

## Cuándo usarla

Úsalo cuando necesites que tu web, una app de Glide o un formulario lean y escriban datos y no quieras pagar ni mantener un backend.

## Cómo ganar dinero con ella

Te ahorras un backend a medida (1.500-4.000 € de desarrollo) y su mantenimiento, para proyectos pequeños de hasta unos miles de registros.

- Backend ligero para landings y formularios con datos en hoja, sin servidor propio…
- Lista de espera o catálogo para pymes conectado a su web en pocos días…
- Configuración de API sobre hojas para apps no-code como Glide…

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Publica tres endpoints —listar, crear y actualizar— que leen y escriben en una hoja de Google, protegidos con una clave de API. Para landings con formulario, catálogos, listas de espera o pequeños paneles internos.

## Lo que necesitas antes
- n8n con HTTPS público.
- Credencial «Google Sheets OAuth2 API» en n8n (mismo proceso de Google Cloud Console que para Drive).
- Una hoja «Datos» con la primera fila de cabeceras, por ejemplo: id, nombre, email, estado, creado.
- Inventa una clave larga, por ejemplo con `openssl rand -hex 24`. Guárdala en una variable de entorno de n8n (por ejemplo `API_CLAVE`) y no la escribas en el nodo Code: un flujo exportado se llevaría la clave. Si tu n8n bloquea el acceso a variables desde los nodos, ajusta `N8N_BLOCK_ENV_ACCESS_IN_NODE=false`.

## Los nodos, en orden
1. **Webhook** — HTTP Method: elige «Multiple Methods» y marca GET y POST, Path: `api/registros`, Respond: «Using Respond to Webhook node». En Options activa «Allowed Origins (CORS)» y pon tu dominio, o `*` si es público. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
2. **Code** (renómbralo «Autenticar y enrutar») — Run Once for Each Item:
```javascript
const CLAVE = $env.API_CLAVE; // variable de entorno de n8n, nunca la clave escrita aquí
const req = $input.item.json;
const h = req.headers || {};
const recibida = h['x-api-key'] || ''; // la clave solo por cabecera, nunca en la URL
const metodo = (h['x-http-method'] || req.method || 'GET').toUpperCase();
const cuerpo = req.body || {};
const accion = (cuerpo.accion || req.query?.accion || (metodo === 'POST' ? 'crear' : 'listar')).toLowerCase();
return { json: {
  autorizado: recibida === CLAVE,
  accion,
  datos: cuerpo,
  filtro: req.query?.estado || '',
  id: cuerpo.id || req.query?.id || ''
} };
```
3. **IF** — `{{ $json.autorizado }}` is true. Rama false → **Respond to Webhook** con Response Code 401 y body `{"error":"clave invalida"}`.
4. Rama true → **Switch** — Mode: Rules, valor `={{ $json.accion }}`, tres salidas: `listar`, `crear`, `actualizar`.
5. Salida **listar** → **Google Sheets** (Get Row(s), hoja «Datos», Filters: columna `estado` igual a `={{ $json.filtro }}` solo si viene filtro; si no, deja sin filtro y Return All: on).
6. Salida **crear** → **Code** para generar id y fecha:
```javascript
const d = $input.item.json.datos || {};
return { json: {
  id: 'r_' + Date.now().toString(36),
  nombre: d.nombre || '',
  email: (d.email || '').toLowerCase().trim(),
  estado: d.estado || 'nuevo',
  creado: new Date().toISOString()
} };
```
   → **Google Sheets** (Append Row, Mapping Column Mode: Map Each Column Manually).
7. Salida **actualizar** → **Google Sheets** (Update Row, Matching Column: `id`).
8. Las tres salidas van a un mismo **Respond to Webhook** — Respond With: JSON, Response Body: `={{ JSON.stringify({ ok: true, datos: $input.all().map(i => i.json) }) }}`, Response Code 200.

## Cómo probarla
- Listar (con la clave en una variable de tu terminal, `export API_CLAVE=...`, para no dejarla escrita en comandos ni en el historial compartido): `curl -H "x-api-key: $API_CLAVE" 'https://tu-n8n/webhook/api/registros'`.
- Crear: `curl -X POST -H "x-api-key: $API_CLAVE" -H 'Content-Type: application/json' -d '{"accion":"crear","nombre":"Ana","email":"ana@x.com"}' https://tu-n8n/webhook/api/registros`.
- Sin cabecera, comprueba que devuelve 401.
- Desde el navegador, en la consola de tu web, prueba un `fetch` para verificar que el CORS está bien.

## Qué puede salir mal
- **La clave viaja en el navegador**: si llamas a esta API desde JavaScript público, cualquiera ve la clave. Para eso, limita a la acción `crear`, usa una clave distinta y solo permite escritura, nunca listado.
- **Concurrencia**: dos escrituras a la vez pueden pisarse. Sheets no es una base de datos transaccional; si esperas más de 1-2 escrituras por segundo, cambia el destino por el nodo **Postgres** o **Supabase**.
- **Límites de Google**: 300 peticiones por minuto y proyecto, y unas 5 millones de celdas por hoja. Cuando te acerques, migra.
- **CORS preflight**: el navegador manda un OPTIONS. n8n lo responde solo si tienes configurado «Allowed Origins»; si no, verás errores raros solo en el navegador y no con curl.
- **Cabeceras en minúscula**: en n8n las cabeceras llegan siempre en minúsculas; por eso el código lee `x-api-key`, no `X-API-Key`.

## Cuánto cuesta
n8n auto-alojado 0 €. Google Sheets 0 €. Solo pagas el VPS. En n8n Cloud (prueba gratuita temporal y después planes de pago) te comes las ejecuciones rápido si la API recibe tráfico real.
