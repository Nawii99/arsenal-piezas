# Errores de JavaScript del navegador a incidencia en Git…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Recoge los errores que revientan en el navegador de tus visitantes, los agrupa para no repetir, y abre una incidencia en GitHub con el navegador, la página y las veces que ha pasado.

## Qué es y qué hace

Un fragmento de JavaScript en tu web envía a un webhook de n8n los errores no controlados del navegador. El flujo los agrupa con una huella, cuenta repeticiones en una hoja y, al llegar a tres apariciones, abre una incidencia en GitHub con navegador, página y número de veces, y avisa por Telegram. Entrada: JSON con mensaje, página y navegador. Salida: fila en la hoja, incidencia y aviso. Se monta en n8n con un token de GitHub.

## Cómo usarla

1. Crea el token de GitHub con permiso repo
2. Pega el script en la web
3. Crea la hoja Errores JS
4. Provoca un error de prueba y comprueba la incidencia

## Cuándo usarla

Úsalo cuando tu web o tu aplicación falla solo en algunos navegadores o móviles y te enteras porque un cliente te escribe «no me deja pagar».

## Cómo ganar dinero con ella

Un Sentry de pago cuesta desde 26 $/mes; esto es gratis y detecta el error del botón de compra roto antes de perder un día de ventas.

- Monitorización de errores para tiendas online que pierden ventas por un botón roto.
- Vigilancia de fallos en formularios y carritos para agencias con clientes de comercio.
- Mantenimiento técnico mensual con informe de errores de navegador para webs de clientes.

**Precio orientativo:** 150–300 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un trozo pequeño de JavaScript en tu web captura los errores no controlados y los manda a un webhook de n8n. El flujo los normaliza, agrupa los iguales por una huella, cuenta las repeticiones en una hoja y, cuando un error nuevo llega a 3 apariciones, abre una incidencia en GitHub y te avisa por Telegram.
Para quien tiene una tienda online o una aplicación web con formularios, pagos o carritos.

## Lo que necesitas antes
- n8n con URL pública.
- Repositorio en GitHub y credencial de GitHub en n8n (Personal Access Token con permiso `repo`: github.com > Settings > Developer settings > Personal access tokens).
- Hoja «Errores JS» con columnas: `huella`, `mensaje`, `pagina`, `navegador`, `veces`, `primera_vez`, `ultima_vez`, `issue_url`.
- Poder añadir un script a tu web (en WordPress, con el plugin «WPCode» o en el `footer.php` del tema hijo).

## El script en tu web
```html
<script>
(function(){
  var URL_N8N = 'https://tu-n8n.es/webhook/errores-js';
  var enviados = {};
  function enviar(datos){
    try {
      var clave = datos.mensaje + '|' + datos.fichero + '|' + datos.linea;
      if (enviados[clave]) return; // uno por sesion y error
      enviados[clave] = true;
      datos.pagina = location.href;
      datos.navegador = navigator.userAgent;
      datos.pantalla = window.innerWidth + 'x' + window.innerHeight;
      navigator.sendBeacon(URL_N8N, new Blob([JSON.stringify(datos)], {type:'application/json'}));
    } catch(e){}
  }
  window.addEventListener('error', function(e){
    enviar({ mensaje: e.message, fichero: e.filename, linea: e.lineno, columna: e.colno, pila: e.error && e.error.stack ? String(e.error.stack).slice(0,1500) : '' });
  });
  window.addEventListener('unhandledrejection', function(e){
    enviar({ mensaje: 'Promesa rechazada: ' + (e.reason && e.reason.message ? e.reason.message : String(e.reason)), fichero: '', linea: 0, columna: 0, pila: '' });
  });
})();
</script>
```

## Los nodos, en orden
1. **Webhook** — POST, Path `errores-js`, Respond `Immediately` (el navegador no espera respuesta). Protégelo: configura un *Secret* en el webhook de GitHub, valida la cabecera `X-Hub-Signature-256` en un nodo Code con ese secreto leído de una variable de entorno y descarta entregas repetidas por `X-GitHub-Delivery`.
2. **Code** — normaliza y calcula la huella del error, y descarta el ruido conocido (código abajo).
3. **IF** — `{{ $json.ignorar }}` *is false*.
4. **Google Sheets** (*Get Row(s)*) — busca por columna `huella` el valor `={{ $json.huella }}`. Activa `Always Output Data` en Settings del nodo.
5. **IF** — `{{ $json.veces }}` *is not empty* (¿ya existía?).
6. Rama sí: **Google Sheets** (*Update Row*) sumando 1 a `veces` y actualizando `ultima_vez`. Rama no: **Google Sheets** (*Append Row*) con `veces` = 1.
7. **IF** — `{{ $json.veces }}` *is equal to* `3` y `{{ $json.issue_url }}` *is empty*.
8. **GitHub** (Resource `Issue`, Operation `Create`) — título `[JS] {{ $json.mensaje }}`, cuerpo con página, navegador, línea y pila; etiqueta `bug`.
9. **Google Sheets** (*Update Row*) — guarda `issue_url`.
10. **Telegram** (*Send Message*) — aviso con el enlace de la incidencia.

## El nodo Code
```javascript
const crypto = require('crypto');
const b = $input.first().json.body || $input.first().json;
const mensaje = String(b.mensaje || '').slice(0, 300);
const fichero = String(b.fichero || '');
// Ruido tipico que no es culpa tuya: extensiones del navegador y scripts de terceros
const ruido = ['Script error', 'ResizeObserver loop', 'chrome-extension://', 'moz-extension://', 'googletagmanager', 'fbevents', 'Non-Error promise rejection'];
const ignorar = ruido.some(r => (mensaje + fichero).includes(r)) || mensaje.length < 5;
const ua = String(b.navegador || '');
let navegador = 'Otro';
if (/Edg\//.test(ua)) navegador = 'Edge'; else if (/Chrome\//.test(ua)) navegador = 'Chrome'; else if (/Safari\//.test(ua) && !/Chrome/.test(ua)) navegador = 'Safari'; else if (/Firefox\//.test(ua)) navegador = 'Firefox';
const movil = /Mobile|Android|iPhone/.test(ua) ? 'movil' : 'escritorio';
const huella = crypto.createHash('md5').update(mensaje + '|' + fichero + '|' + (b.linea || 0)).digest('hex').slice(0, 12);
return [{ json: { huella, mensaje, fichero, linea: b.linea || 0, pagina: String(b.pagina || '').slice(0,300), navegador: navegador + ' ' + movil, pila: String(b.pila || '').slice(0, 1500), ignorar, ahora: new Date().toISOString() } }];
```

## Cómo probarla
- Con el script puesto, abre tu web, abre la consola del navegador (F12) y escribe `null.propiedad` para provocar un error. Debe aparecer en n8n.
- Repite tres veces desde una ventana de incógnito (el script solo envía una vez por sesión) y comprueba que se crea la incidencia en GitHub.
- Comprueba que un segundo error idéntico ya no crea otra incidencia, solo suma en la hoja.

## Qué puede salir mal
- **Avalancha de eventos**: si una página muy visitada tiene un error, te pueden llegar miles de peticiones. El filtro de una vez por sesión y la agrupación por huella lo contienen; aun así, si tienes mucho tráfico, añade en el Code un límite por hora.
- **«Script error» sin detalle**: pasa con scripts servidos desde otro dominio. Añade `crossorigin="anonymous"` a esas etiquetas `<script>` y la cabecera CORS correspondiente.
- **CORS en el webhook**: `sendBeacon` no necesita respuesta, pero si usas `fetch` sí; configura Allowed Origins en el nodo Webhook.
- **Datos personales**: no envíes nunca el contenido de los formularios en el error. Este script solo manda mensaje, fichero, línea y navegador, y así debe quedarse (RGPD).
- **Google Sheets como base de datos**: aguanta bien hasta unos miles de filas. Si crece, cambia esos nodos por Airtable o una base de datos Postgres.

## Cuánto cuesta
- GitHub: incidencias ilimitadas gratis en repos públicos y privados.
- n8n auto-alojado 0 €. En cloud, con mucho tráfico te comerías las ejecuciones: para esto, auto-aloja.
- Sheets y Telegram: 0 €.
