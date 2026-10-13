# Detector de cambios raros en tus páginas clave…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Cada día compara el texto y los precios de tus 10 páginas más importantes con los de ayer y te avisa si algo ha cambiado sin que tú lo tocaras.

## Qué es y qué hace

Flujo de n8n que cada mañana descarga las 5 a 10 páginas clave de tu web, calcula una huella de su texto visible y la compara con la del día anterior. Entra la lista de URLs en una hoja y el bot de Telegram; sale un aviso si cambia más de lo normal o desaparece el precio, el botón de compra o el teléfono. Pensado para webs con plugins que se actualizan solos.

## Cómo usarla

1. Elige 5-10 páginas críticas y rellena la hoja Centinela web
2. Crea el bot de Telegram
3. Ajusta el umbral de cambio con dos días de prueba
4. Revisa los falsos avisos cada semana

## Cuándo usarla

Úsalo cuando una actualización de plugin, un tema o un becario te hayan roto alguna vez la página de precios, el botón de compra o el teléfono de contacto sin que te enteraras hasta semanas después.

## Cómo ganar dinero con ella

Un precio mal puesto o un botón caído en la página de ventas te cuesta ventas cada hora. Aquí lo detectas en 24 h en vez de en un mes, gratis.

- Vigilancia de páginas de venta para negocios que dependen de su landing y no pueden permitirse caídas.
- Monitorización de cambios en webs de clientes de una agencia, con informe diario.
- Servicio de guardia web mensual para tiendas que actualizan plugins con frecuencia.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**: guarda una «huella» del contenido visible de tus páginas críticas y cada mañana la compara con la del día anterior; si el texto cambia más de lo normal o desaparecen palabras clave (el precio, el botón, el teléfono), te lo dice por Telegram. Para tiendas, páginas de ventas y webs con plugins que se actualizan solos.
**Para quién no es**: para páginas que cambian a diario a propósito (portada de un periódico, listados con stock rotativo).

### Lo que necesitas antes
- **n8n** (auto-alojado gratis o plan cloud).
- **Una hoja de Google Sheets** «Centinela web» con pestaña `estado` y columnas: `url`, `huella`, `longitud`, `ultima_revision`. Rellena a mano la columna `url` con tus 5-10 páginas clave (inicio, precios, checkout, contacto, ficha del producto estrella).
- **Una segunda pestaña** `alertas` con columnas: `fecha`, `url`, `motivo`, `detalle`.
- **Telegram**: abre Telegram, habla con **@BotFather**, comando `/newbot`, te da un token. Luego escribe algo a tu bot y abre `https://api.telegram.org/bot<TU_TOKEN>/getUpdates` en el navegador para ver tu `chat.id`. En n8n: Credentials > Telegram API > pega el token.
- **Palabras que deben aparecer sí o sí** en cada página (por ejemplo `Añadir al carrito`, `39,90`, `+34 6`). Añádelas en una columna `imprescindible` de la pestaña `estado`, separadas por `;`.

### Los nodos, en orden
**1. Schedule Trigger** — Days, cada 1 día, hora 7:30. Timezone del workflow: `Europe/Madrid`.
**2. Google Sheets** — Operation: `Get Row(s)`, Document: «Centinela web», Sheet: `estado`. Devuelve una fila por página.
**3. Loop Over Items** — Batch Size: `1`.
**4. HTTP Request** («Bajar página») — GET `{{ $json.url }}`, Response Format `Text`, Never Error activado, Timeout `20000`, y en Options > Headers añade `User-Agent` con valor `Mozilla/5.0 (compatible; CentinelaWeb/1.0)` para que no te tomen por un bot malo.
**5. Code** («Comparar») — Mode: `Run Once for All Items`:
```js
const html = $json.data || '';
const fila = $('Loop Over Items').first().json;
let texto = html.replace(/<script[\s\S]*?<\/script>/gi, ' ');
texto = texto.replace(/<style[\s\S]*?<\/style>/gi, ' ');
texto = texto.replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim();
let h = 0;
for (let i = 0; i < texto.length; i++) { h = (h * 31 + texto.charCodeAt(i)) | 0; }
const huella = String(h);
const faltan = [];
for (const p of String(fila.imprescindible || '').split(';')) {
  const t = p.trim();
  if (t && !texto.includes(t)) faltan.push(t);
}
const antes = Number(fila.longitud || 0);
const ahora = texto.length;
const variacion = antes ? Math.abs(ahora - antes) / antes : 0;
const motivos = [];
if (faltan.length) motivos.push('Faltan textos obligatorios: ' + faltan.join(', '));
if (antes && variacion > 0.15) motivos.push('El contenido ha cambiado un ' + Math.round(variacion * 100) + '%');
if (ahora < 500) motivos.push('La página ha devuelto casi nada, puede estar caída');
return [{ json: { url: fila.url, huella, longitud: ahora, alerta: motivos.length > 0, motivo: motivos.join(' | '), fila: fila.row_number } }];
```
**6. Google Sheets** («Guardar huella») — Operation: `Update Row`, Document «Centinela web», Sheet `estado`, Column to Match On: `url`. Campos: `huella` = `{{ $json.huella }}`, `longitud` = `{{ $json.longitud }}`, `ultima_revision` = `{{ $now.format('dd/MM/yyyy HH:mm') }}`.
**7. IF** — Boolean: `{{ $json.alerta }}` is true.
**8. Google Sheets** (rama true) — Append Row en la pestaña `alertas` con fecha, url, motivo.
**9. Telegram** (rama true) — Operation: `Send Message`, Chat ID: el tuyo, Text: `⚠️ Cambio raro en {{ $('Comparar').item.json.url }}%0A{{ $('Comparar').item.json.motivo }}`.
**10. Conecta la salida al Loop Over Items** para pasar a la siguiente página.

### Cómo probarla
- Ejecuta el workflow una vez: la primera vez no dará alertas (no hay huella previa), solo rellenará las columnas.
- Vuelve a ejecutarlo: no debería avisar de nada.
- Ahora escribe en la columna `imprescindible` de una fila algo que NO esté en la página, por ejemplo `PALABRAMAGICA`. Ejecuta: debes recibir el aviso en Telegram en segundos.

### Qué puede salir mal
- **Alertas falsas cada día** en páginas con contador de visitas, fecha o listados rotatorios: sube el umbral del 15% al 30% en el Code, o quita esa página del listado.
- **Webs con contenido cargado por JavaScript** (React, tiendas headless): el HTML llega casi vacío. Solución: vigila esas páginas por su API o usa el servicio gratuito de renderizado de `r.jina.ai` poniendo la URL como `https://r.jina.ai/https://tudominio.com/precios`.
- **Cloudflare te devuelve una página de reto**: verás longitud baja y alertas constantes; añade tu IP del servidor de n8n a la lista blanca en Cloudflare (Security > WAF > Tools).
- **Zona horaria**: si el aviso llega a las 8:30 en verano, no pusiste Europe/Madrid en Workflow Settings.

### Cuánto cuesta
- n8n auto-alojado, Google Sheets y Telegram: **0 €**. Telegram no cobra por mensajes de bot.
- Si usas `r.jina.ai` sin clave, es gratis con límite de peticiones; con clave gratuita subes el límite.
