# Detector de cambios no autorizados en tus páginas clave…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Guarda una huella digital del HTML de tus páginas más importantes y te avisa si cambian sin que tú hayas tocado nada, o si aparece código sospechoso inyectado.

## Qué es y qué hace

Cada seis horas descarga el HTML de entre 3 y 10 URLs críticas, elimina las partes que cambian solas, calcula un hash y lo compara con el anterior guardado en una hoja. Si cambia, avisa por Telegram con el detalle y busca palabras típicas de inyección de spam. Entrada: lista de URLs y token del bot. Salida: aviso de cambio y hash actualizado. Se monta en n8n; con webs grandes conviene limitar el número de páginas.

## Cómo usarla

1. Elige entre 3 y 10 páginas críticas
2. Crea la hoja Vigiladas
3. Configura el bot de Telegram
4. Que lo revise un profesional

## Cuándo usarla

Cuando quieres enterarte de que un plugin, una actualización o un intruso te han cambiado la portada, el precio o han metido enlaces de spam ocultos.

## Cómo ganar dinero con ella

Detecta un ataque o una regresión en horas en vez de semanas. La limpieza de una web con spam inyectado y la recuperación en Google cuestan de 500 a 2.000 €.

- Vigilancia de seguridad básica para tiendas con precios y checkout expuestos.
- Detección de inyecciones de spam para webs de clientes con WordPress.
- Servicio mensual de comprobación de integridad de la web para autónomos con marca propia.

**Precio orientativo:** 100–250 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada 6 horas descarga el HTML de una lista corta de URLs críticas (portada, página de precios, checkout, contacto), lo limpia de las partes que cambian solas y calcula un hash.
Si el hash cambia, te manda un aviso con qué ha cambiado y busca además palabras típicas de inyección de spam.

## Lo que necesitas antes
- n8n.
- Hoja `Vigiladas` en Google Sheets con columnas `url`, `hash`, `ultimo_cambio`, `activa`.
- Bot de Telegram con su token y tu `chat_id` (créalo con `@BotFather`).
- Elige pocas URLs, entre 3 y 10. Vigilar 200 páginas genera ruido y no lo lee nadie.

## Los nodos, en orden
1. **Schedule Trigger** — `Hours`, cada `6`, timezone `Europe/Madrid`.
2. **Google Sheets** — `Get Row(s)` de `Vigiladas`, filtrando `activa = si`.
3. **Split In Batches** — Batch Size `1`.
4. **HTTP Request** — GET a `{{ $json.url }}`, `Response Format: Text`, header `User-Agent: Mozilla/5.0 (compatible; vigilante/1.0)`, `Timeout 20000`, `On Error: Continue`.
5. **Code** — limpia el HTML volátil, calcula el hash y busca patrones sospechosos (código abajo).
6. **IF** — `{{ $json.cambiado }}` es `true` o `{{ $json.sospechoso }}` es `true`.
7. **Telegram** — `Send Message` con la URL, si es cambio o sospecha, y las palabras encontradas.
8. **Google Sheets** — `Update Row` guardando el nuevo hash y la fecha.
9. Realimenta al **Split In Batches**.

## El nodo Code
```js
const crypto = require('crypto');
const SOSPECHOSAS = ['eval(', 'atob(', 'document.write(unescape', 'casino', 'viagra', 'display:none;position:absolute;left:-9999', '.top/', 'base64_decode'];
const salida = [];
for (const item of $input.all()) {
  let html = item.json.data || '';
  const fila = $('Split In Batches').item.json;
  const limpio = html
    .replace(/<script[^>]*>[\s\S]*?<\/script>/gi, '')
    .replace(/nonce="[^"]*"/gi, '')
    .replace(/\?ver=[\w.\-]+/gi, '')
    .replace(/csrf[^"']*["'][^"']*["']/gi, '')
    .replace(/\d{2}:\d{2}:\d{2}/g, '')
    .replace(/\s+/g, ' ')
    .trim();
  const hash = crypto.createHash('sha256').update(limpio).digest('hex').slice(0, 16);
  const encontradas = SOSPECHOSAS.filter(p => html.toLowerCase().includes(p.toLowerCase()));
  salida.push({ json: {
    url: fila.url,
    hash,
    cambiado: Boolean(fila.hash) && fila.hash !== hash,
    primera_vez: !fila.hash,
    sospechoso: encontradas.length > 0,
    palabras: encontradas.join(', '),
    tamano: limpio.length
  }});
}
return salida;
```

## Cómo probarla
- La primera ejecución solo guarda hashes: no debe avisar de nada (por eso está `primera_vez`).
- Cambia una palabra en la portada y ejecuta de nuevo: debe llegarte el aviso.
- Añade temporalmente la palabra `casino` en un borrador visible y comprueba que salta la sospecha.

## Qué puede salir mal
- **Falsos positivos por contenido dinámico**: si la portada muestra 'últimos artículos' o un contador, cambiará siempre. Amplía las limpiezas del Code o vigila solo un trozo: extrae con una regex la sección `<main>` y haz el hash de eso.
- **Scripts eliminados del hash**: los quitamos porque cambian a menudo, pero eso significa que una inyección dentro de `<script>` no cambia el hash. Por eso está la búsqueda de palabras sospechosas sobre el HTML completo, sin limpiar.
- **Caché del hosting**: si hay CDN puedes recibir una versión vieja. Añade `?nocache={{ Date.now() }}` a la URL o el header `Cache-Control: no-cache`.
- **Avisos en cadena**: al actualizar la web a propósito recibirás un aviso; es lo correcto. Si molesta, añade una columna `pausada_hasta` en la hoja.

## Cuánto cuesta
0 €. Cuatro ejecuciones diarias por 5 URLs son 20 peticiones al día, nada para ningún plan.
