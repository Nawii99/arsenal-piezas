# Subtítulos automáticos en español para todos tus vídeos…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Coge cada vídeo nuevo, saca el audio, lo transcribe con Whisper y genera un archivo .srt de subtítulos que guarda en Drive y sube como pista al vídeo de YouTube.

## Qué es y qué hace

Es una automatización de n8n con ffmpeg que detecta un vídeo nuevo en Drive, extrae su audio, lo transcribe con Whisper y genera un archivo de subtítulos .srt que guarda en Drive y sube a YouTube como pista. Entra el vídeo y sale el .srt y la pista de subtítulos en el canal. Requiere ffmpeg en el contenedor, una clave de la API de transcripción y credenciales de Drive y YouTube.

## Cómo usarla

1. Instala ffmpeg en tu n8n y añade la clave de la API
2. Conecta Drive y YouTube
3. Revisa un .srt de prueba antes de subir
4. Activa el flujo para todos los vídeos

## Cuándo usarla

Úsalo cuando publiques vídeos hablados y quieras subtítulos de verdad (no los automáticos de YouTube) sin pagar 1 € por minuto a un servicio de transcripción.

## Cómo ganar dinero con ella

Transcribir una hora cuesta unos 0,35 €, frente a 60-90 € de un transcriptor humano o 20-30 min tuyos corrigiendo el autogenerado.

- Subtitulado de vídeos para formadores y canales que quieren accesibilidad y retención.
- Subtítulos en lote para clientes de agencias de vídeo, cobrados por minuto de material.
- Paquete de subtitulado mensual para creadores con varios vídeos a la semana.

**Precio orientativo:** 120–300 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Detecta un vídeo nuevo en Drive, extrae el audio, lo manda a la API de transcripción de OpenAI (Whisper) pidiendo formato SRT y devuelve un archivo de subtítulos listo, que además sube a YouTube como pista de subtítulos en español.
Para creadores, formadores y negocios con vídeos hablados que quieren accesibilidad y más retención en móvil con el sonido quitado.

## Lo que necesitas antes
- n8n auto-alojado con **ffmpeg** instalado en el contenedor (imagen propia con `apk add ffmpeg` sobre `n8nio/n8n`), porque hace falta extraer el audio.
- Clave de API de OpenAI (platform.openai.com → API keys). Carga mínima de 5 $.
- Credenciales OAuth2 de Google Drive y de YouTube en n8n (mismo proyecto de Google Cloud del resto de recetas, con YouTube Data API v3 activada).
- Una carpeta de Drive `Vídeos` y otra `Subtítulos`.

## Los nodos, en orden
1. **Google Drive Trigger** — Event `File Created`, carpeta `Vídeos`, cada minuto.
2. **Google Drive** (Download File) — By ID `{{ $json.id }}`, propiedad binaria `data`.
3. **Read/Write Files from Disk** (Write File) — File Path: `/tmp/{{ $json.id }}.mp4`, Input Binary Field: `data`.
4. **Execute Command** — extrae el audio y lo comprime para no pasar el límite de 25 MB de la API:
```bash
ffmpeg -y -i /tmp/{{ $('Google Drive Trigger').item.json.id }}.mp4 -vn -ac 1 -ar 16000 -b:a 32k /tmp/{{ $('Google Drive Trigger').item.json.id }}.mp3
```
5. **Read/Write Files from Disk** (Read File) — File Path: `/tmp/{{ $('Google Drive Trigger').item.json.id }}.mp3`, Property Name: `audio`.
6. **HTTP Request** — Method `POST`, URL `https://api.openai.com/v1/audio/transcriptions`. Authentication: `Generic Credential Type` → `Header Auth` con Name `Authorization` y Value `Bearer TU_CLAVE`. Body Content Type: `Form-Data (multipart)`. Parámetros: `file` de tipo *n8n Binary File* apuntando a `audio`; `model` = `whisper-1`; `language` = `es`; `response_format` = `srt`. En *Options* activa `Response → Format: Text`.
7. **Convert to File** (Convert to Text File) — Text Input Field: `data`, File Name: `{{ $('Google Drive Trigger').item.json.name }}.srt`, Mime Type `text/plain`.
8. **Google Drive** (Upload File) — carpeta `Subtítulos`, Input Binary Field: `data`.
9. **HTTP Request** (opcional, subir la pista a YouTube) — Method `POST`, URL `https://www.googleapis.com/upload/youtube/v3/captions?part=snippet&uploadType=multipart`, Authentication: `Predefined Credential Type` → `YouTube OAuth2 API`. Body multipart con la parte JSON `{"snippet":{"videoId":"ID_DEL_VIDEO","language":"es","name":"Español","isDraft":false}}` y el binario del .srt.

## Un pulido opcional con nodo Code
Si quieres cortar las líneas largas para que quepan en pantalla, mete un **Code** entre el 6 y el 7:
```javascript
const srt = $input.first().json.data;
const bloques = srt.split(/\n\n/);
const salida = bloques.map(b => {
  const lineas = b.split('\n');
  if (lineas.length < 3) return b;
  const texto = lineas.slice(2).join(' ');
  const palabras = texto.split(' ');
  let l1 = '', l2 = '';
  for (const p of palabras) {
    if ((l1 + ' ' + p).trim().length <= 42) l1 = (l1 + ' ' + p).trim();
    else l2 = (l2 + ' ' + p).trim();
  }
  return [lineas[0], lineas[1], l1, l2].filter(Boolean).join('\n');
});
return [{ json: { data: salida.join('\n\n') } }];
```

## Cómo probarla
- Empieza con un vídeo de 30 segundos y mira el .srt en Drive: los tiempos deben empezar en `00:00:00,000`.
- Abre el vídeo en VLC con el .srt al lado y el mismo nombre: se cargará solo y verás si va sincronizado.

## Qué puede salir mal
- **Límite de 25 MB** en la API de audio: con el mp3 mono a 32 kbps te caben unas 6-7 horas, pero si aún así pasas, parte el audio con `ffmpeg -f segment -segment_time 600` y concatena las transcripciones sumando los tiempos.
- **Nombres propios y marcas mal escritos**: añade el parámetro `prompt` en el HTTP Request con una lista de tus términos («Nawi, Alicante, WhatsApp») y Whisper los respeta.
- **Error 401 en la pista de YouTube**: la API de captions solo funciona con vídeos del canal dueño de la credencial.
- **Archivos en /tmp**: añade un **Execute Command** final con `rm -f /tmp/ID.*` o llenarás el disco.

## Cuánto cuesta
- Whisper por API: 0,006 $ por minuto de audio, unos 0,35 € la hora.
- n8n auto-alojado, Drive y YouTube: 0 €.
- 20 vídeos de 10 minutos al mes salen por poco más de 1 €.
