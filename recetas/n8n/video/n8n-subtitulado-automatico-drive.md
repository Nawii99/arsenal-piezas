# Subtitulado automático al subir vídeo a Drive

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Receta de n8n que transcribe automáticamente un vídeo subido a Google Drive y sube el .srt resultante a la misma carpeta, avisando cuando está listo.

## Qué es y qué hace

Receta de n8n que, al subir un vídeo a una carpeta de Google Drive, lo transcribe con Whisper (API de pago por minuto) y sube a la misma carpeta el archivo .srt troceado, avisando cuando está listo. Entra el vídeo; sale el .srt y un aviso por Telegram o Gmail. Alternativa: transcribir en local con la app de Whisper y saltar esos nodos. Ejemplo: un vídeo de 10 minutos llega con su .srt en la carpeta. Se usa para subtitular sin intervención manual.

## Cómo usarla

1. Crea la carpeta Vídeos a subtitular en Drive
2. Configura el trigger y el nodo de transcripción con tu clave
3. Sube el .srt a la carpeta y avisa
4. Revisa la tarifa vigente de la API antes de activarla

## Cuándo usarla

Quita la parte más pesada del subtitulado: subir el vídeo y recibir el .srt ya troceado sin transcribir ni ajustar tiempos a mano.

## Cómo ganar dinero con ella

El nodo de transcripción usa una API de pago por minuto; hay alternativa gratuita local fuera de n8n si no se quiere pagar.

- Flujo de subtitulado automático para creadores con varios vídeos a la semana.
- Servicio mensual de subtitulado para pymes con contenido en redes.
- Montaje del flujo como parte de un paquete de edición de vídeo.

**Precio orientativo:** 80–200 € por flujo montado. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué ahorra
Esta automatización te quita de encima la parte más pesada del subtitulado: subes el vídeo a una carpeta de Drive y te llega el archivo .srt ya troceado, sin tener que transcribir ni ajustar tiempos a mano.

## Cuentas necesarias
- Cuenta de Google (gratis) para Drive, con la carpeta "Vídeos a subtitular" creada de antemano.
- Cuenta de OpenAI con clave de API para usar Whisper: esto NO es gratis, cobra por minuto de audio transcrito ([consulta la tarifa vigente en openai.com/pricing antes de activar la automatización]). Si no quieres pagar, transcribe con la app de escritorio Whisper (gratis, pero necesita un ordenador con algo de potencia) y salta los nodos 4 y 5.
- Cuenta de Telegram (gratis, bot propio) o Gmail (gratis, con OAuth en n8n) para el aviso final.

## Nodos, en orden
1. Google Drive Trigger (llámalo exactamente «Disparador de Drive»; el código usa `$('Disparador de Drive')`): dispara "On file created" en la carpeta "Vídeos a subtitular" (carpeta concreta, por su ID), comprobando cada minuto, con tipo de archivo «todos».
2. IF (llámalo «¿Es un vídeo?»): condición de texto `{{ $json.mimeType }}` empieza por (*starts with*) `video/`. Solo la salida *true* sigue a la descarga; la salida *false* queda sin conectar. Así se filtran los archivos que no son vídeo.
3. Google Drive (llámalo exactamente «Descargar vídeo»; el código usa `$('Descargar vídeo')`): operación *Download*, File por ID con `{{ $json.id }}`; descarga el archivo que ha disparado el trigger.
4. HTTP Request (llámalo «Transcribir con Whisper»): método POST a `https://api.openai.com/v1/audio/transcriptions` (endpoint de Whisper), autenticación Header Auth (Name `Authorization`, Value `Bearer TU_CLAVE`), cuerpo *multipart-form-data* con el archivo descargado (campo `file`, tomado del campo binario `data`), `model` = `whisper-1` y `response_format` = `verbose_json`; sube el timeout de la petición a 600000 ms. La respuesta trae los tiempos por segmento.
5. Code (JavaScript; llámalo «Montar .srt», modo *Run Once for Each Item*, para que cada vídeo tenga su propio .srt): convierte la respuesta de la transcripción a formato .srt: numera los bloques, pon los tiempos en formato 00:00:00,000 y trocea el texto en líneas de máximo 42 caracteres.
6. Google Drive (llámalo «Subir .srt»; operación *Upload*): sube el .srt generado (campo binario `data`) a la misma carpeta, con el nombre `{{ $json.nombreSrt }}` (el mismo que el vídeo original con extensión .srt).
7. Telegram (llámalo «Aviso por Telegram»; o Gmail): envía un aviso con el nombre del archivo (`{{ $json.name }}`) y el enlace de Drive al .srt (`https://drive.google.com/file/d/{{ $json.id }}/view`). Los nodos van conectados en cadena, en el orden de esta lista.

## Cómo probarla sin liarla
Prueba primero con un vídeo de menos de 1 minuto, no con uno largo: así ves si el .srt tiene sentido y cuánto te cobra la API por ese minuto antes de dejarla corriendo con vídeos de media hora. Revisa el panel de uso de OpenAI después de la prueba para confirmar el coste real. No actives el trigger sobre una carpeta que ya tenga vídeos antiguos: muévelos fuera antes o se van a disparar todos de golpe y te va a llegar una factura sorpresa.

CÓDIGO DE LOS NODOS (el mismo que lleva el flujo importable)

Nodo Code «Montar .srt»:
```js
const fmt = (s) => {
  const ms = Math.round(s * 1000);
  const h = Math.floor(ms / 3600000), m = Math.floor(ms % 3600000 / 60000), sec = Math.floor(ms % 60000 / 1000), r = ms % 1000;
  const p = (n, l = 2) => String(n).padStart(l, '0');
  return `${p(h)}:${p(m)}:${p(sec)},${p(r, 3)}`;
};
const trocear = (texto, max = 42) => {
  const lineas = [];
  let actual = '';
  for (const palabra of String(texto).trim().split(/\s+/)) {
    if (!actual) actual = palabra;
    else if ((actual + ' ' + palabra).length <= max) actual += ' ' + palabra;
    else { lineas.push(actual); actual = palabra; }
  }
  if (actual) lineas.push(actual);
  return lineas;
};
// Se ejecuta una vez por cada vídeo: $json es SU transcripción y $('...').item es SU vídeo (emparejado por elemento).
const segmentos = $json.segments || [];
const srt = segmentos
  .filter(s => String(s.text || '').trim())
  .map((s, i) => `${i + 1}\n${fmt(s.start)} --> ${fmt(s.end)}\n${trocear(s.text).join('\n')}\n`)
  .join('\n');
let original = '';
try { original = $('Disparador de Drive').item.json.name || ''; } catch (e) { /* sin emparejamiento: se prueba con el binario */ }
if (!original) {
  try { original = $('Descargar vídeo').item.binary.data.fileName || ''; } catch (e) { /* nada */ }
}
original = original || 'video';
const base = original.replace(/\.[^.]+$/, '');
const binario = await this.helpers.prepareBinaryData(Buffer.from(srt, 'utf8'), `${base}.srt`, 'application/x-subrip');
return { json: { nombreSrt: `${base}.srt`, nombreVideo: original, bloques: segmentos.length }, binary: { data: binario } };
```
