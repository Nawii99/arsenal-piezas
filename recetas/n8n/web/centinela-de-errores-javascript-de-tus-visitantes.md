# Centinela de errores JavaScript de tus visitantes…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Un fragmento de código en tu web envía a n8n cualquier error de JavaScript que sufra un visitante real; el flujo los agrupa por huella, ignora el ruido conocido y avisa solo la primera vez.

## Qué es y qué hace

Recoge los errores de JavaScript y las promesas no capturadas de los visitantes reales y los centraliza con un webhook de n8n. Calcula una huella por error (mensaje, archivo y línea) para agrupar repeticiones, ignora el ruido conocido y avisa por Telegram solo de la primera aparición. Entrada: fragmento de script en tu web. Salida: fila en Google Sheets y aviso. Requiere una URL pública para el webhook.

## Cómo usarla

1. Expón n8n con URL pública
2. Pega el fragmento en la web
3. Crea la hoja Errores JS
4. Provoca un error de prueba

## Cuándo usarla

Cuando tu web o tienda tiene funcionalidad (carrito, filtros, formularios) y no te enteras de que algo se ha roto hasta que un cliente te lo dice por WhatsApp.

## Cómo ganar dinero con ella

Hace el trabajo básico de Sentry o LogRocket (de 26 a 99 €/mes) por 0 €, y detecta ventas perdidas por un botón roto el mismo día.

- Monitorización de errores para tiendas y webs con formularios o pagos.
- Detección de fallos en producción para agencias que no quieren depender de los clientes.
- Mantenimiento mensual con informe de errores de JavaScript para webs de clientes.

**Precio orientativo:** 150–300 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recoge los errores de JavaScript y las promesas sin capturar que ocurren en el navegador de tus visitantes y los centraliza.
Calcula una huella única por error (mensaje + archivo + línea) para que 400 avisos del mismo fallo no se conviertan en 400 mensajes de Telegram.

## Lo que necesitas antes
- n8n accesible desde internet (auto-alojado con dominio y HTTPS, o n8n Cloud). Sin URL pública el webhook no funciona.
- Acceso al HTML de tu web o a un gestor de etiquetas para pegar el fragmento.
- Hoja `Errores JS` en Google Sheets con columnas: `huella`, `mensaje`, `archivo`, `linea`, `pagina`, `navegador`, `primera_vez`, `ultima_vez`, `veces`.
- Un bot de Telegram: habla con `@BotFather`, `/newbot`, copia el token y saca tu `chat_id` escribiendo al bot y mirando `https://api.telegram.org/botTOKEN/getUpdates`.

## El fragmento que pegas en tu web
```html
<script>
(function(){
  var HOOK = "https://TU-N8N.com/webhook/js-errors";
  function enviar(d){ try { navigator.sendBeacon(HOOK, new Blob([JSON.stringify(d)], {type:"application/json"})); } catch(e){} }
  window.addEventListener("error", function(e){
    enviar({tipo:"error", msg: e.message, archivo: e.filename, linea: e.lineno, col: e.colno, pagina: location.href, ua: navigator.userAgent});
  });
  window.addEventListener("unhandledrejection", function(e){
    enviar({tipo:"promesa", msg: String(e.reason), archivo: "", linea: 0, col: 0, pagina: location.href, ua: navigator.userAgent});
  });
})();
</script>
```

## Los nodos, en orden
1. **Webhook** — método `POST`, ruta `js-errors`, Response Mode `Immediately` (contesta 200 al instante para no frenar la web). En Options activa `Raw Body: off`. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
2. **Code** — normaliza y calcula la huella, y filtra el ruido conocido (código abajo).
3. **IF** — `{{ $json.ignorar }}` es `false`.
4. **Google Sheets** — `Get Row(s)` filtrando por columna `huella` igual a `{{ $json.huella }}`.
5. **IF** — comprueba si vino alguna fila: `{{ $items().length }}` mayor que `0`.
6. Rama SÍ existe: **Google Sheets** `Update Row` sumando 1 a `veces` y poniendo `ultima_vez`.
7. Rama NO existe: **Google Sheets** `Append Row` con `primera_vez` y `veces = 1`, y después **Telegram** `Send Message` con el mensaje, la página y el navegador.

## El nodo Code
```js
const crypto = require('crypto');
const RUIDO = ['ResizeObserver loop', 'Script error.', 'Non-Error promise rejection', 'chrome-extension://', 'moz-extension://'];
const salida = [];
for (const item of $input.all()) {
  const b = item.json.body || item.json;
  const msg = String(b.msg || '').slice(0, 300);
  const archivo = String(b.archivo || '');
  const ignorar = RUIDO.some(r => msg.includes(r) || archivo.includes(r));
  const huella = crypto.createHash('sha1').update(msg + '|' + archivo + '|' + (b.linea || 0)).digest('hex').slice(0, 12);
  const ahora = new Date().toISOString();
  salida.push({ json: { huella, mensaje: msg, archivo, linea: b.linea || 0, pagina: b.pagina || '', navegador: String(b.ua || '').slice(0, 120), primera_vez: ahora, ultima_vez: ahora, ignorar } });
}
return salida;
```

## Cómo probarla
- Con el workflow activo, abre tu web, pulsa F12 y escribe en la consola: `null.f()`. Debe llegarte el aviso en Telegram en segundos.
- Repite el mismo error tres veces: solo debe llegar un mensaje y la columna `veces` debe subir a 3.
- Prueba desde el móvil para confirmar que `sendBeacon` funciona también ahí.

## Qué puede salir mal
- **Avalancha de errores**: si un fallo afecta a toda la web recibirás muchísimas peticiones. Protégete añadiendo tras el Webhook un **IF** que descarte si ya has recibido más de 200 en la última hora, o pon el webhook detrás de Cloudflare con un límite de tasa.
- **`Script error.` sin detalles**: los errores de scripts de otro dominio llegan vacíos. Añade `crossorigin="anonymous"` a tus etiquetas `<script>` y la cabecera `Access-Control-Allow-Origin` en el CDN.
- **CORS**: `sendBeacon` no necesita respuesta, así que no suele dar problemas, pero si usas `fetch` sí tendrás que devolver la cabecera CORS desde n8n.
- **Datos personales**: no envíes nunca el contenido de formularios en el error. El fragmento de arriba solo manda mensaje, archivo y URL.

## Cuánto cuesta
n8n auto-alojado en un VPS de 5 €/mes lo aguanta de sobra. Telegram y Sheets, gratis. En n8n Cloud ten cuidado: cada error es una ejecución y una web con tráfico puede comerse el plan; ahí conviene auto-alojar.
