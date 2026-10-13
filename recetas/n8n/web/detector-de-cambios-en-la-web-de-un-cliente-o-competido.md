# Detector de cambios en la web de un cliente o competido…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Guarda cada día una huella del contenido de las páginas que le indiques y te avisa con el detalle exacto de qué texto ha cambiado, se ha añadido o ha desaparecido.

## Qué es y qué hace

Cada mañana descarga el HTML de una lista de páginas, elimina scripts, estilos y etiquetas, compara el texto limpio con la versión del día anterior guardada en la hoja y, si hay diferencias, envía un correo con las líneas añadidas y eliminadas. Entrada: URLs y, opcionalmente, un selector CSS para una parte concreta. Salida: email con el cambio exacto. Se monta en n8n y la misma lógica puede hacerse en Make o Zapier.

## Cómo usarla

1. Lista las páginas en la hoja
2. Añade el selector CSS si solo te interesa una parte
3. Compara durante una semana
4. Ajusta el filtro de ruido

## Cuándo usarla

Úsalo cuando quieras enterarte de que un competidor ha cambiado precios, o de que alguien ha tocado la web de tu cliente sin avisarte.

## Cómo ganar dinero con ella

Servicios como Visualping cobran 15-50 €/mes por unas pocas páginas; aquí vigilas todas las que quieras gratis y con el texto del cambio en el email.

- Vigilancia de precios de la competencia para tiendas online que compiten por precio.
- Seguimiento de cambios en webs de clientes para agencias que quieren enterarse antes que nadie.
- Informe semanal de cambios en webs de referencia para equipos de marketing.

**Precio orientativo:** 120–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Descarga cada mañana el HTML de una lista de páginas, le quita el ruido (scripts, estilos, etiquetas), se queda con el texto limpio, lo compara con la versión guardada del día anterior y, si ha cambiado, te manda un email con las líneas que han entrado y las que han salido.
Para dueños de tienda que vigilan precios de la competencia, agencias que mantienen webs de clientes y cualquiera que necesite saber que una página legal o una tarifa se ha movido.

## Lo que necesitas antes
- n8n (auto-alojado o cloud).
- Hoja «Paginas vigiladas» con columnas: `url`, `nombre`, `selector`, `huella`, `texto_anterior`.
- Credenciales de Google Sheets y Gmail en n8n.
- Opcional: saber el selector CSS de la parte de la página que te interesa (clic derecho > Inspeccionar sobre el bloque de precios, por ejemplo `.pricing-table`). Si lo dejas vacío, compara la página entera.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 9 * * *`, zona `Europe/Madrid`.
2. **Google Sheets** (*Get Row(s)*) — hoja «Paginas vigiladas».
3. **Split In Batches** — Batch Size `1`.
4. **HTTP Request** — GET `={{ $json.url }}`, Response Format `Text`, `Never Error` activado, y en Headers añade `User-Agent: Mozilla/5.0 (compatible; MonitorWeb/1.0)`.
5. **Code** — limpia el HTML, calcula la huella y compara con la guardada (código abajo).
6. **IF** — `{{ $json.ha_cambiado }}` *is true*.
7. **Gmail** (*Send*) — asunto `Cambio en {{ $json.nombre }}`, cuerpo con el diff en HTML.
8. **Google Sheets** (*Update Row*) — guarda la nueva `huella` y el nuevo `texto_anterior` (siempre, haya cambio o no, para no repetir el aviso).
9. Vuelve al **Split In Batches**.

## El nodo Code
```javascript
const crypto = require('crypto');
const fila = $('Split In Batches').first().json;
let html = $input.first().json.data || '';
// Si hay selector, nos quedamos con ese bloque de forma sencilla
if (fila.selector && fila.selector.startsWith('.')) {
  const clase = fila.selector.slice(1);
  const re = new RegExp('<[^>]*class="[^"]*' + clase + '[^"]*"[\\s\\S]*?</[a-zA-Z]+>', 'i');
  const m = html.match(re);
  if (m) html = m[0];
}
let texto = html
  .replace(/<script[\s\S]*?<\/script>/gi, ' ')
  .replace(/<style[\s\S]*?<\/style>/gi, ' ')
  .replace(/<!--[\s\S]*?-->/g, ' ')
  .replace(/<[^>]+>/g, '\n')
  .replace(/&nbsp;/g, ' ')
  .replace(/[ \t]+/g, ' ');
const lineas = texto.split('\n').map(l => l.trim()).filter(l => l.length > 2);
const limpio = lineas.join('\n');
const huella = crypto.createHash('md5').update(limpio).digest('hex');
const anterior = (fila.texto_anterior || '').split('\n');
const setAnterior = new Set(anterior);
const setNuevo = new Set(lineas);
const anadidas = lineas.filter(l => !setAnterior.has(l)).slice(0, 25);
const quitadas = anterior.filter(l => l && !setNuevo.has(l)).slice(0, 25);
const primeraVez = !fila.huella;
const ha_cambiado = !primeraVez && huella !== fila.huella;
const diff = '<b>Añadido:</b><br>' + anadidas.map(l => '+ ' + l).join('<br>') + '<br><br><b>Quitado:</b><br>' + quitadas.map(l => '- ' + l).join('<br>');
return [{ json: { url: fila.url, nombre: fila.nombre, huella, texto_anterior: limpio.slice(0, 45000), ha_cambiado, diff } }];
```

## Cómo probarla
- Mete una URL tuya y ejecuta: la primera vez solo guarda la huella y no avisa (eso es correcto).
- Cambia un texto en tu web y vuelve a ejecutar: te debe llegar el email con la línea nueva y la vieja.
- Añade luego las URLs de verdad y activa.

## Qué puede salir mal
- **Avisos todos los días por tonterías**: muchas webs meten fechas, contadores de visitas o tokens que cambian en cada carga. Solución: usa el `selector` para vigilar solo el bloque que te importa, o añade en el Code un filtro que descarte líneas con números de más de 6 dígitos.
- **Webs hechas con JavaScript**: si el contenido se carga después, el HTML plano viene vacío. Para esas, busca su API interna abriendo la pestaña Red del navegador y vigila esa URL en lugar de la página.
- **Celda de Google Sheets llena**: el límite es 50.000 caracteres por celda, por eso el `slice(0, 45000)`. Si tus páginas son enormes, guarda solo la huella y las 100 primeras líneas.
- **Te bloquean**: si vigilas a un competidor grande, puede bloquearte por IP. Espacia a día y medio y no rastrees más de unas pocas páginas de su sitio.
- **Legalidad**: vigilar páginas públicas está bien; no uses esto para descargar contenido protegido ni saltarte un login.

## Cuánto cuesta
- 0 € en herramientas. Solo el VPS de n8n si lo auto-alojas.
- Gmail gratis hasta 500 correos al día.
