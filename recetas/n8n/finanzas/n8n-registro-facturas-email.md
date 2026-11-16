# Registro automático de facturas de gastos por email

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Receta de n8n que recibe facturas por email, extrae los datos con IA, los guarda en un libro de gastos en Google Sheets y avisa por Telegram si falta algún dato.

## Qué es y qué hace

Receta de n8n que, al llegar un correo con factura adjunta en PDF, extrae sus datos con una IA, los guarda en un libro de gastos de Google Sheets y avisa por Telegram si falta algún dato. Entran un Gmail Trigger con etiqueta, el PDF adjunto y el bot de Telegram; sale una fila nueva por factura y un aviso cuando algo no cuadra. Requiere Gmail, Google Sheets y un bot gratuito de Telegram, además de una API de IA de pago por uso (Claude, Codex, Gemini o una IA local).

## Cómo usarla

1. Crea la etiqueta de facturas en Gmail
2. Extrae los datos del PDF con IA
3. Guarda la fila en Sheets y avisa por Telegram
4. Que lo revise un profesional

## Cuándo usarla

Te llegan facturas de proveedores por correo y cada trimestre te toca apuntarlas a mano. Con esta receta se anotan solas y te avisa por Telegram si falta algún dato.

## Cómo ganar dinero con ella

Puedes montar un libro de gastos automático para autónomos y pymes pequeñas, con instalación única y cuota mensual a [TU PRECIO]. Un gestor o profesional revisa los datos antes de presentar impuestos.

- Libro de gastos automático para autónomos que reciben facturas por correo.
- Registro de facturas de proveedores para una pyme pequeña, con instalación y cuota.
- Mantenimiento mensual del registro de gastos para una gestoría con varios clientes.

**Precio orientativo:** 60–150 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

# Automatización: registro automático de facturas de gastos por email

## Qué hace
Cuando llega un email con una factura adjunta en PDF, extrae los datos con IA, los guarda en una hoja de Google Sheets como libro de gastos y avisa por Telegram si falta algún dato.

## Cuentas necesarias y límites gratuitos
- Cuenta de Gmail (o el correo que uses para recibir facturas): gratis, el nodo trigger de Gmail en n8n no tiene coste aparte.
- Cuenta de OpenAI con API key: de pago por uso, no es gratis; calcula unos céntimos por factura procesada y revisa el precio actual antes de automatizar en volumen.
- Cuenta de Google con Google Sheets: gratis.
- Bot de Telegram (se crea gratis con @BotFather): gratis.
- n8n: si usas n8n Cloud, solo hay una prueba gratuita temporal y después es de pago; si lo instalas tú (self-hosted, Community Edition), es gratis pero lo mantienes tú.

## Nodos, en orden
1. Gmail Trigger: se dispara cuando llega un email nuevo a una carpeta o etiqueta concreta (crea una etiqueta "facturas" en Gmail y filtra solo esa: en el filtro de búsqueda pon label:facturas). Desactiva la opción de simplificar la salida y activa la descarga de adjuntos, para que el PDF llegue como dato binario.
2. IF, llámalo exactamente «Comprobar PDF adjunto» (el código del paso 5 usa ese nombre): comprueba, con una condición booleana, que algún adjunto binario del email es de tipo application/pdf (la expresión {{ Object.values($binary || {}).some(b => b.mimeType === 'application/pdf') }} debe ser verdadera). Solo la salida «true» se conecta con el paso 3; la «false» se deja sin conectar, así que si no hay PDF el flujo para aquí.
3. Extract from File: convierte el PDF adjunto a texto (operación de extraer de PDF; en el campo del dato binario pon la expresión {{ Object.keys($binary).find(k => $binary[k].mimeType === 'application/pdf') }}, para que coja el adjunto PDF se llame como se llame).
4. OpenAI (nodo de mensaje): le pasas el texto extraído (en el mensaje de usuario, la expresión {{ $json.text }}) con la instrucción de extracción de datos de factura española (usa la ficha de extracción de datos de factura como instrucción) y le pides que devuelva JSON con número, fecha, NIF emisor, base imponible, IVA, retención y total.
5. Code, en modo Run Once for Each Item, llámalo «Leer JSON y comprobar campos»: lee el JSON que devuelve la IA, comprueba los siete campos obligatorios (numero, fecha, nif_emisor, base_imponible, iva, retencion y total) y devuelve esos campos más archivo (nombre del PDF, que lo toma de $('Comprobar PDF adjunto'), por eso ese nombre debe ser exacto), faltan (lista de los campos vacíos) y completo (true o false). Después, un IF con una condición booleana ({{ $json.completo }} verdadero) comprueba si el JSON tiene todos los campos obligatorios rellenos: su salida «true» va al paso 6 y la «false» al paso 7.
6. Google Sheets (operación Append Row, hoja «Gastos», conectado a la salida «true» del IF): si están todos los datos, añade una fila nueva al libro de gastos con esos campos.
7. Telegram (Send Message, conectado a la salida «false» del IF y con el texto basado en {{ $json.archivo }} y {{ $json.faltan.join(', ') }}): si falta algún dato, envía un aviso al usuario con el nombre del archivo y qué campo falta, para que lo revise a mano.

## Cómo probarla sin liarla
Antes de conectarla a tu correo real de facturas, envíate a ti mismo dos o tres facturas de prueba (una bien hecha, una con un dato que falte a propósito) a una etiqueta de Gmail separada como "facturas-test". Ejecuta el flujo manualmente desde n8n paso a paso la primera vez, revisa que la fila que llega a Google Sheets tiene los números correctos comparándolos con la factura original, y solo entonces cambia el trigger a la etiqueta real y actívalo. Revisa el gasto de la API de OpenAI en el panel de uso después de las primeras ejecuciones, para saber cuánto te va a costar al mes con tu volumen real de facturas.

CÓDIGO DE LOS NODOS (el mismo que lleva el flujo importable)

Nodo Code «Leer JSON y comprobar campos»:
```js
function buscar(o) {
  if (typeof o === 'string') return o;
  if (Array.isArray(o)) { for (const x of o) { const t = buscar(x); if (t) return t; } return ''; }
  if (o && typeof o === 'object') {
    for (const k of ['text', 'output_text', 'content']) if (typeof o[k] === 'string') return o[k];
    for (const v of Object.values(o)) if (v && typeof v === 'object') { const t = buscar(v); if (t) return t; }
  }
  return '';
}
function leerJson(o) {
  let t = buscar(o).replace(/```json|```/g, '');
  const a = t.indexOf('{'), b = t.lastIndexOf('}');
  if (a < 0 || b < a) throw new Error('La IA no devolvió JSON: ' + t.slice(0, 200));
  return JSON.parse(t.slice(a, b + 1));
}

const obligatorios = ['numero', 'fecha', 'nif_emisor', 'base_imponible', 'iva', 'retencion', 'total'];
let r = {};
try { r = leerJson($input.item.json); } catch (e) { r = {}; }
const vacio = v => v === null || v === undefined || (typeof v === 'string' && v.trim() === '');
const faltan = obligatorios.filter(k => vacio(r[k]));
const adj = Object.values($('Comprobar PDF adjunto').item.binary || {}).find(b => b.mimeType === 'application/pdf');
const out = { archivo: adj ? adj.fileName : '(sin nombre)', faltan, completo: faltan.length === 0 };
for (const k of obligatorios) out[k] = vacio(r[k]) ? '' : r[k];
return { json: out };
```
