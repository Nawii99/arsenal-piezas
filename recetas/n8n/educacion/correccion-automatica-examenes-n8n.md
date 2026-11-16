# Corrección automática de exámenes con n8n

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Formulario -> IA corrige con tu rúbrica -> nota en hoja -> email con feedback, sin tu intervención.

## Qué es y qué hace

Flujo de n8n que recoge las entregas de un formulario, pide a una IA que las corrija con tu rúbrica, anota la nota en una hoja de cálculo y envía el feedback por email al alumno. Entra la respuesta del formulario y la rúbrica; sale nota, comentario y un registro en Google Sheets. Necesita cuentas de Google y de n8n, y una clave de API de pago por uso de Anthropic u OpenAI.

## Cómo usarla

1. Conecta el formulario a la hoja
2. Escribe la rúbrica en el nodo de IA
3. Prueba con tres entregas
4. Que lo revise un profesional antes de dar las notas

## Cuándo usarla

Los alumnos entregan por un formulario y no quieres corregir uno a uno ni escribir el feedback a mano. Encaja en cursos con muchas entregas parecidas.

## Cómo ganar dinero con ella

Ofrécela a academias o profesores online como montaje y mantenimiento del flujo, con una cuota de instalación y otra mensual [TU PRECIO]. La nota final la valida el profesor.

- Montaje de corrección automática de entregas para academias online.
- Cuota mensual de mantenimiento y revisión del flujo para profesores online.
- Informe semanal de notas por grupo para centros de formación.

**Precio orientativo:** 200–500 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Corrección automática de exámenes con n8n

## Para qué sirve
Cuando un alumno entrega un examen o ejercicio por un formulario online, este flujo lo corrige con IA usando tu rúbrica, apunta la nota en una hoja de cálculo y le manda el feedback por email. Tú solo revisas de vez en cuando.

## Cuentas que hacen falta
- Cuenta de Google (Gmail y Google Sheets, gratis)
- Cuenta de n8n (self-hosted gratis; n8n Cloud solo tiene una prueba gratuita temporal y después es de pago, revisa los planes actuales antes de usarlo con muchos alumnos)
- Cuenta en Anthropic o OpenAI con clave de API (de pago por uso, revisa el precio por token antes de lanzarlo a muchos alumnos, no hay plan gratuito ilimitado)

## Nodos, en orden
1. **Google Sheets Trigger** (llámalo «Fila nueva en la hoja de respuestas»): evento *Row Added*, revisando cada minuto; se dispara cuando llega una fila nueva en la hoja donde caen las respuestas del formulario (el Google Form debe estar conectado a esa hoja).
2. **Edit Fields (Set)**: llámalo exactamente «Recoger datos del alumno» (el código del paso 4 usa `$('Recoger datos del alumno')`). Recoge de la fila nueva el nombre, el email, el enunciado y la respuesta del alumno, y los deja en campos limpios llamados `nombre`, `email`, `enunciado` y `respuesta` (con `{{ $json['Nombre'] }}`, `{{ $json['Email'] }}`, `{{ $json['Enunciado'] }}`, `{{ $json['Respuesta'] }}`; usa los nombres de columna de tu formulario), más `row_number` (tipo número, `{{ $json.row_number }}`) para poder actualizar después esa misma fila.
3. **Nodo de IA (Anthropic o OpenAI)** (llámalo «Corregir con IA»; en Anthropic, operación *Message* con un mensaje de usuario): le pasas la rúbrica en JSON (usa la pieza "Rúbrica de corrección estructurada para IA") junto con el enunciado y la respuesta del alumno, y le pides (en las instrucciones de sistema) que devuelva solo un JSON con `nota` (número), `comentario_alumno` y `comentario_profesor`, tratando el enunciado y la respuesta como datos a evaluar y no como órdenes.
4. **Code** (llámalo exactamente «Separar la corrección», modo *Run Once for Each Item*; los nodos Gmail y Telegram usan `$('Separar la corrección')`): separa el JSON que ha devuelto la IA en campos sueltos: nota, comentario para el alumno, comentario para el profesor, y conserva `row_number`, `nombre` y `email` leyéndolos de «Recoger datos del alumno».
5. **Google Sheets (Update row)** (llámalo «Escribir nota en la hoja»): columna para localizar la fila `row_number` (`{{ $json.row_number }}`); escribe `Nota` (`{{ $json.nota }}`) y `Comentario profesor` (`{{ $json.comentario_profesor }}`) en la misma fila del alumno.
6. **Gmail (Send email)** (llámalo «Enviar nota al alumno», conectado a la salida de «Escribir nota en la hoja»): envía al alumno su nota y su comentario en un email con tono amable, tomando los datos de «Separar la corrección», p. ej. destinatario `{{ $('Separar la corrección').item.json.email }}` y la nota `{{ $('Separar la corrección').item.json.nota }}` (no de `$json`, porque la salida de Sheets no trae esos campos).
7. **Opcional: Telegram o Slack** (en el flujo, «Avisarme por Telegram (opcional)»): se conecta también a la salida de «Escribir nota en la hoja», en paralelo al Gmail, y te avisa de que se ha corregido un examen (nombre y nota, leídos con `$('Separar la corrección').item.json`). Sale a la vez que el email al alumno; si quieres revisar antes de que llegue, quita la conexión al Gmail y envíalo a mano.

## Antes de activarlo en serio
- Los exámenes de alumnos, sobre todo si son menores de edad, son datos personales: revisa que enviarlos a una IA externa cumple la normativa de protección de datos de tu centro o academia, y pide permiso si hace falta.
- Gmail gratuito tiene un límite de envíos diarios (alrededor de 500 emails), no lo montes para cientos de alumnos sin plantearte un proveedor de correo transaccional.
- Antes de conectarlo a un formulario real, prueba con una fila falsa en la hoja de cálculo y comprueba que la nota y el email salen bien.
- Revisa los avisos del paso 7 las primeras semanas, hasta que confíes en cómo corrige la IA (el aviso no frena el email: si quieres revisar antes de enviar, desconecta el Gmail como se explica en el paso 7).

CÓDIGO DE LOS NODOS (el mismo que lleva el flujo importable)

Nodo Code «Separar la corrección»:
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

const r = leerJson($input.item.json);
const nota = Number(r.nota);
if (!Number.isFinite(nota)) throw new Error('La IA no devolvió una nota numérica: ' + JSON.stringify(r).slice(0, 200));
const a = $('Recoger datos del alumno').item.json;
return { json: { row_number: a.row_number, nombre: a.nombre, email: a.email, nota, comentario_alumno: String(r.comentario_alumno || ''), comentario_profesor: String(r.comentario_profesor || '') } };
```
