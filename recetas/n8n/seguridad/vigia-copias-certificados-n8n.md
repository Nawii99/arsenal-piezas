# Vigía de copias y certificados en n8n

**Tipo:** Receta de automatización · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Vigilancia automática semanal de tus webs: responden, certificados vivos, copias en orden.

## Qué es y qué hace

Es una receta de n8n que cada semana revisa las webs de tus clientes: si responden, cuándo caduca el certificado y si las copias están en orden. Te avisa solo cuando hay algo que mirar. Entra una hoja con clientes y URLs, y un canal de aviso; sale un aviso semanal solo si hay fallos. Es vigilancia, no reparación, y solo vale para webs que te han encargado por escrito.

## Cómo usarla

1. Crea la hoja de clientes con URL y contacto
2. Monta el disparador semanal y las comprobaciones
3. Revisa el primer informe y ajusta los avisos

## Cuándo usarla

Para montar una cuota mensual de vigilancia a clientes pequeños con web, tienda o servidor propio.

## Cómo ganar dinero con ella

Cuota de 30 a 60 € al mes por cliente, con informe mensual. Instalación inicial aparte, unos 150 €.

- Cuota mensual de vigilancia para clientes con web o tienda propia.
- Informe mensual de estado de webs como entregable visible al cliente.
- Vigilancia de certificados para agencias que llevan muchas webs pequeñas.

**Precio orientativo:** 30–60 € al mes por cliente. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

# Vigía semanal de copias y certificados (n8n)

Qué consigue: cada lunes revisa los sitios de tus clientes y te avisa solo si hay algo que mirar. Es vigilancia, no reparación.

## Cuentas que hacen falta

- n8n: gratis si lo ejecutas tú (n8n Community, autoalojado). La nube oficial empieza sobre 20 € al mes con límite de ejecuciones.
- Un canal de aviso: Telegram (bot gratis, sin límite práctico) o correo con tu proveedor. Gmail por API tiene cupo gratuito de sobra para esto.
- Opcional, Google Sheets (gratis) como lista de clientes y registro de resultados.

## Nodos, en orden

1. **Schedule Trigger** — disparador. Semanal, lunes a las 8:00, zona horaria Europe/Madrid.
2. **Google Sheets (Get rows)** — lee la hoja `clientes` con columnas: `nombre`, `url`, `avisar_dias_certificado`, `url_prueba_copia`, `contacto`.
3. **Split In Batches** (Loop Over Items), llamado exactamente «Un cliente por vuelta» (el código lo cita con ese nombre) — tamaño 1, para tratar un cliente por vuelta y no saturar. Su salida «loop» (la segunda) va al paso 4; la «done» se deja sin conectar. Las dos ramas finales (pasos 9-10 y el registro de revisión correcta) vuelven a la entrada de este nodo.
4. **HTTP Request (web viva)** — GET a `{{$json.url}}`, tiempo máximo 15 segundos, activa «Never Error» y la respuesta completa (para que llegue el código de estado en statusCode), y en los ajustes del nodo haz que un fallo continúe por la salida normal, para que no rompa el flujo.
5. **Code** (modo Run Once for All Items), llamado exactamente «Revisar certificado» (otros nodos lo citan con ese nombre) — abre una conexión TLS al puerto 443 de la web del cliente y lee el certificado que presenta de verdad (no llama a ningún servicio público), calcula los días que quedan y marca cert_estado como ok, invalido (caducado, de otro dominio, autofirmado) o desconocido si no se ha podido comprobar. Devuelve la fila del cliente (que lee de `$('Un cliente por vuelta')`) más codigo_estado, cert_estado, dias_certificado, cert_caduca y cert_error. Necesita el módulo tls: define en n8n la variable de entorno `NODE_FUNCTION_ALLOW_BUILTIN=tls` (si ya tienes otras, sepáralas con comas, por ejemplo `crypto,tls`; con task runners externos, ponla también en el contenedor del runner).
6. **HTTP Request (señal de copia)** — GET a `url_prueba_copia`: una dirección que tu script de copias marca con la fecha del último respaldo correcto. La respuesta se lee como texto (queda en el campo data), sin error por código de estado, y en los ajustes del nodo haz que un fallo continúe por la salida normal. Si el cliente no tiene copias (`url_prueba_copia` vacía), el nodo no corta el flujo, no cuenta como fallo de copia y el aviso lo dice.
7. **IF (hay algo que avisar)**, llamado «¿Hay algo que avisar?», con las condiciones unidas con O (los datos del cliente salen de `$('Revisar certificado').first().json`) — verdadero si el estado no es 200, o si cert_estado no es ok (certificado inválido o no comprobable), o si el certificado caduca en menos de `avisar_dias_certificado` (21 si está vacío), o si el cliente tiene `url_prueba_copia` y la fecha de la última copia (la respuesta, en `$json.data`) no se puede leer o tiene más de 8 días. La salida «true» va al paso 8; la «false» va a un Google Sheets (Append) llamado «Registrar revisión correcta» (ver paso 10).
8. **Set (redactar aviso)**, llamado exactamente «Redactar aviso» (otro nodo lo cita), con un campo de texto llamado `mensaje` — texto corto: nombre del cliente, qué falla, desde cuándo y qué toca hacer. Nada de datos personales del cliente final en el mensaje.
9. **Telegram (Send Message)** o **Gmail (Send)** — el aviso va a ti, no al cliente. El texto es `{{ $json.mensaje }}`, y en los ajustes del nodo haz que un fallo de envío continúe por la salida normal, para que el flujo siga con el registro. Tú decides qué le cuentas y cuándo.
10. **Google Sheets (Append)** — escribe una fila en `registro` con fecha, cliente y resultado. Son dos nodos: «Registrar aviso», a continuación del aviso del paso 9 (resultado: el mensaje redactado), y «Registrar revisión correcta», en la salida «false» del IF (resultado: un texto «OK: ...» con el código de la web, el estado del certificado y si la copia está al día). Los dos vuelven a la entrada de «Un cliente por vuelta». Ese registro es lo que enseñas en la factura mensual.

## Cómo probarla sin liarla

1. Empieza con una sola fila en la hoja y que sea tu propia web.
2. Ejecuta con «Execute Workflow» a mano y mira la salida de cada nodo antes de encadenar el siguiente.
3. Fuerza el fallo a propósito: pon una dirección inventada y comprueba que el aviso llega.
4. Baja `avisar_dias_certificado` a 400 para ver que la rama del certificado dispara, y luego déjalo en 21.
5. Solo cuando todo salga bien, activa el disparador y añade el resto de clientes.

## Límites y cuándo hace falta una persona

- Esto detecta síntomas. No arregla nada y no sustituye a copias de seguridad reales ni a probar una restauración completa al menos dos veces al año.
- Que la web responda 200 no significa que no esté comprometida.
- Pide autorización por escrito antes de vigilar un sitio que no es tuyo, aunque solo sea consultarlo.
- Si el aviso apunta a intrusión, datos filtrados o web secuestrada, no improvises: eso lo lleva el responsable técnico del cliente o un profesional de respuesta a incidentes, y si hay datos personales afectados hay plazos legales de notificación que revisa un abogado.

CÓDIGO DE LOS NODOS (el mismo que lleva el flujo importable)

Nodo Code «Revisar certificado»:
```js
// Comprueba el certificado que PRESENTA el servidor (TLS al puerto 443 con el nombre de la web), no los emitidos.
// Necesita NODE_FUNCTION_ALLOW_BUILTIN=tls en n8n. Si no se puede comprobar, el estado es «desconocido» y se avisa.
const cli = $('Un cliente por vuelta').first().json;
const web = $input.first().json;
const codigo_estado = Number(web.statusCode || (web.error && web.error.status) || 0);
let dias_certificado = null, cert_estado = 'desconocido', cert_caduca = '', cert_error = '';
try {
  let tls;
  try { tls = require('tls'); } catch (e) { throw new Error('el nodo Code no puede usar el módulo tls (falta NODE_FUNCTION_ALLOW_BUILTIN=tls en n8n)'); }
  // (sin new URL(): el nodo Code de n8n no tiene URL disponible)
  const m = String(cli.url || '').trim().match(/^(https?):\/\/([^\/:?#\s]+)(?::(\d+))?/i);
  if (!m) throw new Error('la url de la hoja no es válida: «' + (cli.url || '') + '»');
  const host = m[2].toLowerCase();
  const puerto = m[1].toLowerCase() === 'https' && m[3] ? Number(m[3]) : 443;
  const cert = await new Promise((resolve, reject) => {
    const s = tls.connect({ host, port: puerto, servername: host, rejectUnauthorized: false, timeout: 15000 }, () => {
      const c = s.getPeerCertificate();
      const r = { valid_to: c && c.valid_to, autorizado: s.authorized, motivo: s.authorizationError ? String(s.authorizationError) : '' };
      s.end();
      resolve(r);
    });
    s.on('timeout', () => { s.destroy(); reject(new Error('el servidor no responde en el puerto ' + puerto)); });
    s.on('error', reject);
  });
  const fin = Date.parse(cert.valid_to || '');
  if (isNaN(fin)) throw new Error('el servidor no presenta un certificado legible');
  dias_certificado = Math.floor((fin - Date.now()) / 86400000);
  cert_caduca = new Date(fin).toISOString().slice(0, 10);
  if (cert.autorizado) cert_estado = 'ok';
  else { cert_estado = 'invalido'; cert_error = 'el navegador lo rechazaría (' + cert.motivo + ')'; }
} catch (e) {
  cert_estado = 'desconocido';
  cert_error = 'no se ha podido comprobar el certificado: ' + e.message;
}
return [{ json: { ...cli, codigo_estado, cert_estado, dias_certificado, cert_caduca, cert_error } }];
```
