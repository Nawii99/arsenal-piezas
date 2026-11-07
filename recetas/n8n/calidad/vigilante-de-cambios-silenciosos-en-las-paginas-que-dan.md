# Vigilante de cambios silenciosos en las páginas que dan…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Cada hora comprueba que el precio, el teléfono, el botón de compra y el aviso legal siguen tal cual en tus páginas clave. Si algo cambia sin que tú lo tocaras, te avisa.

## Qué es y qué hace

Cada hora descarga el HTML de tus páginas clave, extrae con una expresión regular el precio, el teléfono, el botón de compra o el aviso legal, y lo compara con el valor guardado en Google Sheets. Si cambia sin que lo hayas tocado, avisa al instante. Entrada: URL y patrones; salida: alerta de cambio. Se monta en n8n.

## Cómo usarla

1. Crea la hoja vigilancia con url, elemento y regex
2. Saca el patrón con Inspeccionar
3. Que lo revise un profesional

## Cuándo usarla

Cuando tu web la toca más de una persona, tienes plugins que se autoactualizan o has sufrido alguna vez un precio mal puesto durante días.

## Cómo ganar dinero con ella

Un precio con un cero de menos durante una tarde puede costarte cientos de euros. Esto lo pilla en la hora siguiente.

- Vigilancia de precios y datos de contacto para una tienda con varios editores.
- Control de avisos legales y textos críticos para una web con plugins que se actualizan solos.
- Monitor de páginas de servicio para una clínica que necesita datos correctos.

**Precio orientativo:** 100–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Descarga el HTML de tus páginas críticas, extrae con una expresión los trozos que importan (precio, teléfono, texto del botón, IBAN, horario) y los compara con el valor guardado. Si cambian, avisa al instante.
Para tiendas y webs de servicios donde un cambio no anunciado significa perder dinero o incumplir algo legal.

## Lo que necesitas antes
- n8n.
- Credenciales de Google Sheets y Gmail (o un bot de Telegram).
- Una hoja `vigilancia` con columnas: `url`, `elemento`, `regex`, `valor_previo`, `activo`.
- Rellenar la hoja. Ejemplos de fila: url `https://tuweb.com/producto-a`, elemento `precio`, regex `class="precio">([^<]+)<`. Para sacar el regex: abre la página, botón derecho > Inspeccionar sobre el precio, y copia la clase o el id que lo envuelve.

## Los nodos, en orden
1. **Schedule Trigger**. Cada hora: `Interval: Hours`, valor 1.
2. **Google Sheets** `Get Row(s)` de la hoja `vigilancia`. En Filters, `activo` = `si`.
3. **Split In Batches**. Batch Size 1. (Evita machacar tu servidor con 20 peticiones a la vez.)
4. **HTTP Request**. `GET` a `{{ $json.url }}`. En Options > Response > Response Format elige `Text`. Añade header `User-Agent` = `n8n-qa-bot`. Activa *Never Error*.
5. **Code** (`Run Once for All Items`):
```javascript
function hash(s) { let h = 0; for (let i = 0; i < s.length; i++) { h = (h * 31 + s.charCodeAt(i)) | 0; } return (h >>> 0).toString(16); }
const fila = $('Split In Batches').first().json;
const html = $input.first().json.data || '';
let valor = 'NO_ENCONTRADO';
try { const m = html.match(new RegExp(fila.regex, 'i')); if (m) valor = (m[1] || m[0]).replace(/\s+/g, ' ').trim(); } catch (e) { valor = 'REGEX_MALO'; }
return [{ json: {
  url: fila.url,
  elemento: fila.elemento,
  valor,
  hash: hash(valor),
  valor_previo: fila.valor_previo || '',
  cambio: (fila.valor_previo || '') !== '' && valor !== fila.valor_previo
} }];
```
6. **IF**. `{{ $json.cambio }}` *is true*.
7. Rama **true** > **Telegram** (o Gmail) con: `CAMBIO EN {{ $json.url }} — {{ $json.elemento }}: antes "{{ $json.valor_previo }}", ahora "{{ $json.valor }}"`.
8. **Google Sheets** `Update Row`. Columna clave: `url`. Escribe `valor_previo` = `{{ $json.valor }}` para que la próxima comparación parta del valor actual.
9. Conecta la salida de vuelta al **Split In Batches** para procesar la siguiente fila.

## Cómo probarla
- Añade una fila apuntando a una página tuya y ejecuta dos veces: la primera guarda el valor, la segunda no debe avisar.
- Cambia el precio en la web a mano (o edita `valor_previo` en la hoja) y ejecuta: debe llegar el aviso.
- Prueba con un regex mal escrito y comprueba que aparece `REGEX_MALO` en vez de romper el flujo.

## Qué puede salir mal
- **NO_ENCONTRADO constante**: la página carga el precio con JavaScript y no está en el HTML. Solución: apunta el vigilante a la API o al feed de producto, o usa la URL con `?format=json` si tu tienda la ofrece.
- **Cachés y CDN**: puedes estar leyendo una versión antigua. Añade `?nocache={{ $now.toMillis() }}` al final de la URL.
- **Alertas en cadena tras un rediseño**: desactiva las filas (`activo` = `no`) mientras trabajas en la web.
- **Bloqueo por exceso de peticiones**: con Split In Batches a 1 y un Wait de 2 segundos entre lotes es suficiente para 20-30 URLs.

## Cuánto cuesta
0 € de software si auto-alojas n8n (Community Edition, gratis). Si usas n8n Cloud (prueba gratuita temporal y después planes de pago), 24 ejecuciones al día por página consumen cupo del plan: baja a cada 4 horas o auto-aloja.
