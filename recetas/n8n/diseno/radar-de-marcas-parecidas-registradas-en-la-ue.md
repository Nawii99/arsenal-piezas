# Radar de marcas parecidas registradas en la UE…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Consulta cada semana el registro europeo de marcas buscando nombres parecidos a los de tus clientes y te avisa si alguien intenta registrar algo confundible.

## Qué es y qué hace

Consulta cada semana la API pública de búsqueda de marcas de la EUIPO con los nombres que vigilas, guarda las solicitudes nuevas en Airtable y genera un resumen con las que se parecen a tu marca. Sirve para detectar registros confundibles dentro del plazo de oposición. Se monta con n8n, Make o Zapier y necesita una aplicación gratuita en el portal de desarrolladores de la EUIPO.

## Cómo usarla

1. Regístrate en el portal de desarrolladores de la EUIPO
2. Crea las tablas Vigilancia y Alertas en Airtable
3. Añade las credenciales en n8n
4. Define los nombres a vigilar
5. Que lo revise un profesional

## Cuándo usarla

Cuando has creado un naming y una identidad para un cliente y quieres protegerlo, o antes de lanzar una marca nueva para vigilar el terreno.

## Cómo ganar dinero con ella

Un aviso a tiempo permite oponerse dentro del plazo de 3 meses, en vez de tener que rehacer toda la identidad después: entre 3.000 y 15.000 € de trabajo.

- Vigilancia de marcas como servicio recurrente para estudios de branding…
- Alerta de registros parecidos para negocios antes de lanzar una marca…
- Informe de riesgo de registro para cada naming que entregas…

**Precio orientativo:** 30–80 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Interroga la API pública de búsqueda de marcas de la EUIPO con los nombres que vigilas, guarda las solicitudes nuevas en una base y te manda un resumen semanal con las que se parecen a lo tuyo.
Es para estudios de branding que quieren ofrecer vigilancia de marca como servicio recurrente y para negocios que acaban de registrar su nombre.
## Lo que necesitas antes
Registro en el portal de desarrolladores de la EUIPO (dev.euipo.europa.eu): crea una aplicación y obtén `client_id` y `client_secret` para la API de Trade Marks. Es gratuita, solo hay que darse de alta.
Una base en Airtable (plan gratuito) con la tabla `Vigilancia`: campos `nombre_vigilado` (texto), `activo` (checkbox); y la tabla `Alertas`: `marca`, `numero`, `solicitante`, `fecha_solicitud`, `clases`, `similitud`.
En n8n: credencial «Airtable Personal Access Token API» (token desde airtable.com/create/tokens con permisos `data.records:read` y `write`) y credencial «Gmail OAuth2».
## Los nodos, en orden
**1. «Schedule Trigger»** — Interval: Weeks, martes a las 8:00.
**2. «Airtable»** — Resource: Record, Operation: Search, Base y Table `Vigilancia`, Filter By Formula `{activo}=1`.
**3. «HTTP Request»** (nómbralo Token) — POST a la URL de token de EUIPO, Body Content Type: Form Urlencoded, campos `grant_type` = `client_credentials`, y el `client_id` y el `client_secret` en una credencial de n8n (Authentication: Generic Credential Type > Custom Auth, con JSON `{"body": {"client_id": "TU_CLIENT_ID", "client_secret": "TU_CLIENT_SECRET"}, "headers": {"X-IBM-Client-Id": "TU_CLIENT_ID"}}`), nunca escritos en el nodo: un flujo exportado se llevaría las claves. Guarda `access_token`.
**4. «Split In Batches»** — Batch Size 1, para no saturar la API.
**5. «HTTP Request»** (nómbralo Buscar marca) — GET al endpoint de búsqueda de trademarks con query `basicSearch={{ $json.nombre_vigilado }}` y `size=50`. En Headers: `Authorization` = `Bearer {{ $('Token').first().json.access_token }}` y `X-IBM-Client-Id` = tu client id (desde la misma credencial, no escrito a mano). Settings: Retry On Fail activado.
**6. «Code»** — calcula el parecido entre el nombre vigilado y cada resultado con distancia de Levenshtein (código abajo) y deja solo los que superan el 70%.
**7. «Airtable»** (nómbralo Ya vistas) — Search en `Alertas` para no repetir avisos, comparando el campo `numero`.
**8. «IF»** — comprueba que quedan resultados nuevos.
**9. «Airtable»** — Operation: Create, guarda cada alerta nueva.
**10. «Gmail»** — Send, asunto `Radar de marcas: {{ $items().length }} solicitudes parecidas`, con la tabla de resultados en HTML.
**11.** Conecta de vuelta a «Split In Batches».
## El trozo de código (nodo «Code»)
```javascript
function lev(a, b) {
  a = a.toLowerCase(); b = b.toLowerCase();
  const m = [];
  for (let i = 0; i <= b.length; i++) m[i] = [i];
  for (let j = 0; j <= a.length; j++) m[0][j] = j;
  for (let i = 1; i <= b.length; i++) {
    for (let j = 1; j <= a.length; j++) {
      m[i][j] = b[i-1] === a[j-1] ? m[i-1][j-1] : Math.min(m[i-1][j-1]+1, m[i][j-1]+1, m[i-1][j]+1);
    }
  }
  return m[b.length][a.length];
}
function similitud(a, b) { const d = lev(a, b); const max = Math.max(a.length, b.length); return max === 0 ? 0 : Math.round((1 - d/max) * 100); }
const vigilado = $('Split In Batches').first().json.nombre_vigilado;
const salida = [];
for (const item of $input.all()) {
  const lista = item.json.trademarks || item.json.results || [];
  for (const t of lista) {
    const nombre = t.wordMarkSpecification?.verbalElement || t.markVerbalElementText || '';
    if (!nombre) continue;
    const s = similitud(vigilado, nombre);
    if (s < 70) continue;
    salida.push({ json: { marca: nombre, numero: t.applicationNumber || '', solicitante: (t.applicants && t.applicants[0]?.name) || '', fecha_solicitud: t.applicationDate || '', clases: (t.niceClasses || []).join(', '), similitud: s, vigilado } });
  }
}
return salida;
```
## Cómo probarla
Vigila a propósito un nombre muy común como `Bella` y comprueba que devuelve decenas de resultados con distintos porcentajes.
Baja el umbral a 50 en el Code para ver el ruido, y súbelo hasta que solo salgan cosas que de verdad te preocuparían.
## Qué puede salir mal
La estructura exacta del JSON de la EUIPO cambia entre versiones de la API: ejecuta primero el HTTP Request solo y ajusta los nombres de campo del Code a lo que veas.
Levenshtein no detecta parecidos fonéticos (`Kwik` vs `Quick`). Añade una normalización previa: sustituye `k`→`c`, `ph`→`f`, quita vocales dobles.
Esto vigila la UE. Para España en concreto tendrías que consultar además la OEPM, y para el resto del mundo TMview.
Esto no es asesoramiento legal: cuando salte una alerta, el cliente debe hablar con un agente de la propiedad industrial dentro del plazo de oposición.
## Cuánto cuesta
Todo gratis: la API de la EUIPO no cobra, Airtable tiene plan gratuito con 1.000 registros por base y n8n auto-alojado no tiene límite. Solo pagarías Airtable (unos 20 €/mes) si vigilas cientos de marcas.
