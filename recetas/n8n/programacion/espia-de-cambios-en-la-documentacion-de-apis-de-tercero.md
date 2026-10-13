# Espía de cambios en la documentación de APIs de tercero…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Vigila las páginas de changelog y documentación de los servicios de los que depende tu código y te avisa el día que cambian algo que puede romperte.

## Qué es y qué hace

Flujo de n8n que cada día descarga las páginas de changelog o de referencia de los proveedores que indiques, elimina el HTML y calcula una huella del texto. Si cambia respecto al día anterior, te envía por Telegram solo las líneas nuevas, no un aviso vacío. Sirve para detectar cambios y retiradas en APIs de pago, mensajería o transporte.

## Cómo usarla

1. Lista las URLs de changelog de tus proveedores en una hoja
2. Define el selector opcional de cada página
3. Activa el disparador diario
4. Prueba con un cambio conocido

## Cuándo usarla

Úsalo cuando tu producto dependa de APIs externas (pasarelas de pago, mensajería, IA, transportistas) y no quieras enterarte de una versión retirada cuando ya falla en producción.

## Cómo ganar dinero con ella

Anticipar un cambio de API evita una caída de servicio y la reparación de urgencia: fácilmente medio día de trabajo y clientes enfadados por aviso.

- Vigilancia de APIs para equipos que integran pasarelas de pago…
- Seguimiento de deprecaciones para startups con varios proveedores externos…
- Informe semanal de cambios en proveedores para agencias de desarrollo…

**Precio orientativo:** 120–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada día descarga las páginas de changelog o de referencia que le indiques, les quita el HTML, calcula una huella digital del texto y la compara con la del día anterior. Si ha cambiado, te manda por Telegram las líneas nuevas, no un aviso vacío de «algo ha cambiado».
Para quien integra Stripe, Twilio, la API de un banco, un ERP o cualquier proveedor que cambia cosas sin avisar por correo a los clientes pequeños.

## Lo que necesitas antes
- n8n (auto-alojado recomendado, para no consumir ejecuciones).
- Una hoja «Vigilancia docs» con columnas: activo, proveedor, url, selector_opcional, hash_anterior, texto_anterior, ultimo_cambio.
- Bot de Telegram con token y chat_id.
- Elegir bien las URLs: busca la página de «Changelog», «Release notes», «API versions» o «Deprecations» de cada proveedor. Si el proveedor publica RSS, mejor todavía: apúntalo también.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 7 * * 1-5` (de lunes a viernes a las 7:00).
2. **Google Sheets** — Get Row(s) de «Vigilancia docs», filtro `activo` = `si`.
3. **Split In Batches** — Batch Size 1.
4. **HTTP Request** («Descargar página») — GET `{{ $json.url }}`, en Options «Response Format: Text», cabecera `User-Agent: Mozilla/5.0 (compatible; VigilanteDocs/1.0)` (sin ella muchas webs devuelven 403), Timeout 30000 ms, «Continue On Fail» activado.
5. **Code** («Limpiar y comparar»)
```javascript
const crypto = require('crypto');
const fila = $('Split In Batches').item.json;
const html = $input.first().json.data || '';
let texto = html
  .replace(/<script[\s\S]*?<\/script>/gi, ' ')
  .replace(/<style[\s\S]*?<\/style>/gi, ' ')
  .replace(/<[^>]+>/g, '\n')
  .replace(/&nbsp;/g, ' ')
  .replace(/[ \t]+/g, ' ');
const lineas = texto.split('\n').map(l => l.trim()).filter(l => l.length > 25);
const limpio = lineas.join('\n');
const hash = crypto.createHash('sha256').update(limpio).digest('hex');
const anteriores = new Set((fila.texto_anterior || '').split('\n'));
const nuevas = lineas.filter(l => !anteriores.has(l)).slice(0, 12);
const cambiado = fila.hash_anterior && fila.hash_anterior !== hash;
return [{ json: { proveedor: fila.proveedor, url: fila.url, fila: fila.row_number, hash, cambiado: Boolean(cambiado), primera_vez: !fila.hash_anterior, nuevas: nuevas.join('\n'), texto: limpio.slice(0, 40000) } }];
```
6. **IF** — `{{ $json.cambiado }}` es verdadero.
7. **Code** («Filtrar ruido») — descarta cambios irrelevantes como contadores o fechas.
```javascript
const ruido = /^(hace |updated |última actualización|copyright|©|\d{1,2} (de )?\w+ \d{4}$)/i;
const salida = [];
for (const item of $input.all()) {
  const utiles = item.json.nuevas.split('\n').filter(l => l && !ruido.test(l));
  if (utiles.length) salida.push({ json: { ...item.json, nuevas: utiles.join('\n') } });
}
return salida;
```
8. **Telegram** — Send Message, Text `📄 Cambio en la documentación de {{ $json.proveedor }}\n{{ $json.url }}\n\nNuevo:\n{{ $json.nuevas }}`, con «Disable Web Page Preview» activado.
9. **Google Sheets** («Guardar huella») — Operation: Update, Row Number `{{ $json.fila }}`, actualiza `hash_anterior`, `texto_anterior` y `ultimo_cambio` con la fecha. Este nodo debe ejecutarse tanto si hubo cambio como si no (conéctalo también a la rama falsa del IF, o directamente después del Code de comparación).
10. Vuelta al **Split In Batches**.

## Cómo probarla
La primera ejecución solo guarda huellas y no avisa (por eso está el campo `primera_vez`). Para forzar una prueba, edita a mano en la hoja el `hash_anterior` de una fila poniendo cualquier texto: en la siguiente ejecución debe detectar cambio y mandarte líneas. Prueba con una página que sepas que cambia a diario, como un blog, para ver el formato del aviso.

## Qué puede salir mal
- **Páginas hechas con JavaScript**: si la documentación se carga desde el navegador, el HTML vendrá vacío. Busca la versión en Markdown en su repositorio de GitHub (muchos proveedores la tienen) o su feed RSS, que además es más limpio.
- **Ruido constante**: banners, fechas relativas y tokens de sesión cambian cada día. Por eso se filtran líneas de menos de 25 caracteres y se aplica el filtro de ruido; amplíalo con lo que veas.
- **Límite de la celda de Google Sheets**: 50.000 caracteres. El código recorta a 40.000; si una página es enorme, guarda solo el hash y renuncia al diff de líneas.
- **Bloqueos 403**: además del User-Agent, algunos sitios exigen cabeceras `Accept-Language`. Si insisten, usa su RSS.

## Cuánto cuesta
Gratis. Solo consume ancho de banda y el alojamiento de n8n. Servicios comerciales de vigilancia de páginas cobran desde 10 euros al mes por unas pocas URLs.
