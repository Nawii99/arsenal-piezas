# Errores agrupados por huella que abren incidencia sola…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Recoge los errores de tu aplicación, agrupa los que son el mismo problema aunque cambien los datos, y abre una incidencia en GitHub sin repetirla mil veces.

## Qué es y qué hace

Recibe errores de tu aplicación por webhook, normaliza mensaje y ruta (quita ids, fechas y números) para calcular una huella y cuenta las repeticiones. La primera vez abre una incidencia en GitHub; después solo suma al contador y comenta cada 25 ocurrencias. Entrada: JSON de error; salida: incidencia y registro en hoja. Se monta en n8n con un token de GitHub de permisos acotados.

## Cómo usarla

1. Crea el token de GitHub con permiso Issues
2. Añade el envío en tu aplicación
3. Crea la hoja errores
4. Revisa las incidencias cada semana

## Cuándo usarla

Úsalo cuando tu app manda errores por correo o log y acabas ignorándolos porque llegan 300 iguales, o al revés, uno importante se pierde entre el ruido.

## Cómo ganar dinero con ella

Sustituye a un Sentry de pago (26 $/mes en adelante) y te ahorra 2-4 h/mes de leer logs para descubrir que eran cinco errores repetidos.

- Gestión de errores para apps pequeñas que no quieren pagar un servicio de monitorización.
- Seguimiento de incidencias para agencias con varios proyectos en GitHub.
- Alertas técnicas para startups con equipos de dos a cinco personas.

**Precio orientativo:** 150–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Recibe errores por webhook desde tu aplicación, los normaliza (quita ids, números, fechas y rutas variables) para calcular una huella del tipo de error, y lleva la cuenta. La primera vez abre una incidencia en GitHub con el detalle; las siguientes solo suma al contador y comenta cada 25 ocurrencias. Para quien tiene una app propia y no quiere pagar por un servicio de monitorización.
**Lo que necesitas antes**
- n8n.
- Un repositorio en GitHub (privado vale). Un token: GitHub > Settings > Developer settings > Personal access tokens > Fine-grained, permisos `Issues: Read and write` sobre ese repo. Credencial `GitHub` en n8n.
- Hoja `errores` con columnas: `huella`, `mensaje`, `primera_vez`, `ultima_vez`, `veces`, `issue_numero`, `estado`.
- En tu aplicación, un bloque que capture las excepciones y haga un POST a la URL del webhook con `{ mensaje, stack, entorno, usuario_id, url }`. Son 5 líneas en cualquier framework.
**Los nodos, en orden**
1. `Webhook` — POST, Path `error`, Respond `Immediately` con Response Code 204 (tu app no debe esperar; si el logger tarda, degradas la app por culpa del monitor).
2. `Code` (*Huella*) — Mode `Run Once for Each Item`:
```js
const crypto = require('crypto');
const b = $json.body || {};
let m = String(b.mensaje || 'sin mensaje');
m = m
  .replace(/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/gi, '<uuid>')
  .replace(/\b[0-9a-f]{16,}\b/gi, '<hex>')
  .replace(/\b\d{4}-\d{2}-\d{2}[T ][\d:.]+/g, '<fecha>')
  .replace(/\b\d+\b/g, '<n>')
  .replace(/'[^']*'/g, "'<x>'")
  .replace(/\s+/g, ' ')
  .trim();
const linea = String(b.stack || '').split('\n')[1] || '';
const base = m + '|' + linea.replace(/:\d+/g, ':<n>').trim();
const huella = crypto.createHash('sha1').update(base).digest('hex').slice(0, 12);
return { json: { huella, patron: m, mensaje_real: String(b.mensaje || '').slice(0, 500), stack: String(b.stack || '').slice(0, 3000), entorno: b.entorno || 'produccion', url: b.url || '', usuario: b.usuario_id || '' } };
```
   Recuerda la variable de entorno `NODE_FUNCTION_ALLOW_BUILTIN=crypto` en n8n auto-alojado.
3. `Google Sheets` — `Get Row(s)` de `errores`, Filter `huella` = `={{ $json.huella }}`. Activa `Always Output Data`.
4. `IF` — `={{ $json.huella }}` `is empty` (es decir, no había fila previa).
5. Rama **true (error nuevo)** > `GitHub` — Resource `Issue`, Operation `Create`, Title `[auto] {{ $('Huella').item.json.patron }}`, Body con:
```text
Huella: {{ $('Huella').item.json.huella }}
Entorno: {{ $('Huella').item.json.entorno }}
URL: {{ $('Huella').item.json.url }}
Mensaje real: {{ $('Huella').item.json.mensaje_real }}
Traza:
{{ $('Huella').item.json.stack }}
```
   Labels: `bug`, `auto`.
6. Detrás > `Google Sheets` — `Append`: `huella`, `mensaje` = el patrón, `primera_vez` = `={{ $now.toISO() }}`, `ultima_vez` igual, `veces` = `1`, `issue_numero` = `={{ $json.number }}`, `estado` = `abierto`.
7. Rama **false (ya conocido)** > `Code`:
```js
const fila = $json;
const veces = Number(fila.veces) + 1;
return { json: { row_number: fila.row_number, veces, issue_numero: fila.issue_numero, hito: veces % 25 === 0, huella: fila.huella } };
```
8. Detrás > `Google Sheets` — `Update` match on `row_number`: `veces` y `ultima_vez`.
9. Detrás > `IF` `={{ $json.hito }}` `is true` > `GitHub` — Operation `Create Comment` en Issue Number `={{ $json.issue_numero }}`, Body `Van {{ $json.veces }} ocurrencias. Última: {{ $now.setZone('Europe/Madrid').toFormat('dd/MM/yyyy HH:mm') }}`.
**Cómo probarla**
- Manda dos errores con el mismo tipo pero datos distintos: `curl -X POST -d '{"mensaje":"Cannot read id 4821 of user abc-123"}' ...` y luego con `id 9930` y otro uuid. Deben compartir huella y abrir **una sola** incidencia con `veces` = 2.
- Manda un error claramente distinto: debe abrir una incidencia nueva.
- Comprueba que el comentario de hito sale a la ocurrencia 25 (baja temporalmente el módulo a 3 para probarlo).
**Qué puede salir mal**
- *Agrupa de más*: si dos errores distintos quedan con el mismo patrón, incluye más líneas de la traza en la base del hash (`split('\n').slice(1,3)`).
- *Agrupa de menos*: si un mismo error abre 20 incidencias, es que la traza cambia; usa solo el mensaje normalizado, sin traza.
- *Avalancha*: si tu app entra en bucle y manda 10.000 errores por minuto, saturas Sheets y GitHub. Pon en tu app un límite (no más de 1 envío por segundo y tipo) y en n8n un `IF` que descarte si el mismo webhook llega más de X veces por minuto.
- *Límite de la API de GitHub*: 5.000 peticiones/hora con token; solo llamas al crear o en hitos, vas sobrado.
- *Datos personales en las trazas*: no mandes emails ni contenido de formularios al webhook; recorta en tu app antes de enviar. Es una obligación de RGPD, no un detalle.
**Cuánto cuesta**
Gratis: n8n auto-alojado, GitHub gratuito con incidencias ilimitadas y Sheets. Compara con Sentry (plan de equipo desde 26 $/mes) o Bugsnag.
