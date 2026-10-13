# Subtítulos automáticos en SRT para cada vídeo nuevo…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Coges el vídeo, saca el audio, lo transcribe con IA y te deja un archivo .srt de subtítulos junto al vídeo, con la transcripción completa guardada en texto.

## Qué es y qué hace

Detecta un vídeo nuevo en Drive, extrae el audio, lo convierte a MP3 y lo envía a la API de transcripción de OpenAI (Whisper). Genera un archivo .srt con tiempos y un .txt con la transcripción limpia junto al vídeo. Entran el vídeo y las claves de OpenAI y CloudConvert; salen el .srt y el .txt en Drive. Sirve para creadores, formadores y agencias que publican en español.

## Cómo usarla

1. Crea cuenta de OpenAI con saldo y clave de API
2. Genera token de CloudConvert con task.read y task.write
3. Crea las carpetas de Drive
4. Prueba con un vídeo de dos minutos

## Cuándo usarla

Cuando publicas vídeo en redes o YouTube y pagas o pierdes horas subtitulando, o cuando quieres el texto del vídeo para reutilizarlo en blog y newsletter.

## Cómo ganar dinero con ella

Subtitular 10 minutos a mano son 40-60 minutos o 15-25 € a un freelance. Aquí cuesta unos 0,06 € y 2 minutos sin que estés delante.

- Subtitulado de vídeos para empresas y formadores con tarifa por minuto de vídeo…
- Transcripciones de entrevistas y reuniones grabadas en vídeo para consultoras…
- Paquete mensual de subtítulos y textos para redes de un creador o pyme…

**Precio orientativo:** 5–25 € por vídeo. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Detecta un vídeo nuevo en Drive, extrae el audio, lo manda a la API de transcripción de OpenAI (Whisper) y genera un archivo `.srt` de subtítulos con tiempos, más un `.txt` con la transcripción limpia. Para creadores, formadores y agencias que publican vídeo en español y quieren subtítulos sin pagarlos.

## Lo que necesitas antes
- n8n (gratis, nube o auto-alojado).
- Cuenta de OpenAI con saldo: platform.openai.com → «API keys» → «Create new secret key». Mete 5 € de saldo, dan para muchísimo audio.
- Cuenta gratuita de CloudConvert (cloudconvert.com) para pasar de MP4 a MP3: perfil → «API» → «Create new token» con permisos `task.read` y `task.write`. El plan gratis da 25 conversiones al día.
- Carpeta de Drive `VIDEOS-A-SUBTITULAR` y otra `SUBTITULOS`.

## Los nodos, en orden
1. **Google Drive Trigger** — Evento: `File Created`, carpeta `VIDEOS-A-SUBTITULAR`, cada 15 minutos.
2. **Google Drive** — Operation: `Share`. File ID: `{{ $json.id }}`. Permissions: Role `reader`, Type `anyone`. Esto genera un enlace público temporal que CloudConvert puede descargar.
3. **HTTP Request** (crear el trabajo de conversión) — Method: POST. URL: `https://api.cloudconvert.com/v2/jobs`. Authentication: Generic → Header Auth → Name `Authorization`, Value `Bearer TU_TOKEN`. Body JSON: `{"tasks":{"import-1":{"operation":"import/url","url":"https://drive.google.com/uc?export=download&id={{ $('Google Drive Trigger').item.json.id }}"},"convert-1":{"operation":"convert","input":"import-1","output_format":"mp3","audio_bitrate":64},"export-1":{"operation":"export/url","input":"convert-1"}}}`.
4. **Wait** — Amount: 90, Unit: `seconds`. Da tiempo a que CloudConvert termine.
5. **HTTP Request1** (recoger el resultado) — Method: GET. URL: `https://api.cloudconvert.com/v2/jobs/{{ $('HTTP Request').item.json.data.id }}`. Misma cabecera de autorización.
6. **Code** — Saca del JSON la URL del MP3 exportado (ver código abajo).
7. **HTTP Request2** — Method: GET. URL: `{{ $json.audio_url }}`. En Options → Response → Format: `File`, Output Field: `data`. Ahora tienes el MP3 dentro del flujo.
8. **HTTP Request3** (transcribir) — Method: POST. URL: `https://api.openai.com/v1/audio/transcriptions`. Header Auth: `Authorization` = `Bearer TU_API_KEY_OPENAI`. Body Content Type: `Form-Data`. Parámetros: `file` tipo n8n Binary File con campo `data`; `model` = `whisper-1`; `language` = `es`; `response_format` = `verbose_json`.
9. **Code1** — Convierte los segmentos en formato SRT y genera el binario del archivo.
10. **Google Drive1** — Operation: `Upload`. Input Data Field Name: `srt`. File Name: `{{ $('Google Drive Trigger').item.json.name }}.srt`. Carpeta: `SUBTITULOS`.
11. **Google Drive2** — Operation: `Share` sobre el vídeo original con Role `reader` → cámbialo a permiso quitado: usa Operation `Delete Permission` para dejar el vídeo otra vez privado. No te saltes este paso.

## El código del nodo Code (paso 6)
```javascript
const tareas = $json.data.tasks || [];
const exportar = tareas.find(t => t.operation === 'export/url' && t.status === 'finished');
if (!exportar) { throw new Error('CloudConvert aún no ha terminado. Sube el Wait a 180 segundos.'); }
return { json: { audio_url: exportar.result.files[0].url } };
```

## El código del nodo Code1 (paso 9)
```javascript
function tc(s) {
  const h = String(Math.floor(s / 3600)).padStart(2, '0');
  const m = String(Math.floor((s % 3600) / 60)).padStart(2, '0');
  const seg = String(Math.floor(s % 60)).padStart(2, '0');
  const ms = String(Math.round((s % 1) * 1000)).padStart(3, '0');
  return h + ':' + m + ':' + seg + ',' + ms;
}
const segmentos = $json.segments || [];
const NL = String.fromCharCode(10);
let srt = '';
segmentos.forEach((s, i) => {
  srt += (i + 1) + NL + tc(s.start) + ' --> ' + tc(s.end) + NL + s.text.trim() + NL + NL;
});
const texto = segmentos.map(s => s.text.trim()).join(' ');
return {
  json: { texto, num_segmentos: segmentos.length },
  binary: { srt: await this.helpers.prepareBinaryData(Buffer.from(srt, 'utf-8'), 'subtitulos.srt', 'text/plain') }
};
```

## Cómo probarla
1. Usa un vídeo de 30 segundos hablando claro. Ejecuta paso a paso con «Execute step» en cada nodo.
2. Abre el `.srt` resultante con el Bloc de notas: tiene que empezar por `1`, luego el tiempo `00:00:00,000 --> ...` y la frase.
3. Súbelo a YouTube Studio en «Subtítulos» y comprueba que los tiempos cuadran.

## Qué puede salir mal
- **Whisper solo acepta archivos de hasta 25 MB**. Por eso conviertes a MP3 a 64 kbps: así entra hasta 1 hora larga. Si te pasas, parte el audio en trozos.
- **Fallo «file too large»**: baja `audio_bitrate` a 32 en el paso 3.
- **El Wait se queda corto** con vídeos largos: sube a 180 o 300 segundos, o repite el paso 5 con un nodo IF que compruebe `status === 'finished'`.
- **El vídeo se queda público**: si el flujo falla a medias, el enlace público sigue vivo. Añade en Settings del workflow un «Error Workflow» que quite el permiso.
- **Nombres con acentos o espacios** dan problemas en algunas APIs: renombra los archivos sin tildes.

## Cuánto cuesta
La transcripción cuesta unos 0,006 $ por minuto de audio: una hora de vídeo, 0,36 $. CloudConvert: 25 conversiones al día gratis, luego desde 9 $/mes. n8n y Drive, gratis. Total realista para 20 vídeos de 10 minutos al mes: menos de 1,50 €.
