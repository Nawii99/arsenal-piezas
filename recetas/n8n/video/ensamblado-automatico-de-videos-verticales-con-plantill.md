# Ensamblado automático de vídeos verticales con plantill…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

A partir de un texto y unos clips en Drive, monta un vídeo vertical con subtítulos quemados, logo y música usando ffmpeg, listo para publicar.

## Qué es y qué hace

Lee una fila de una hoja con el texto, el clip de fondo y el titular; genera la locución, calcula los subtítulos y, con ffmpeg, quema texto, logo y música sobre un vídeo vertical 1080x1920, dejando el archivo final en Drive. Entrada: fila de hoja y clips verticales; salida: MP4 listo para publicar. Requiere n8n auto-alojado con ffmpeg instalado y una carpeta de recursos.

## Cómo usarla

1. Instala ffmpeg en n8n con Docker
2. Prepara fuentes, logo y clips verticales
3. Rellena la hoja Piezas
4. Revisa la primera pieza antes de automatizar el lote

## Cuándo usarla

Cuando necesitas sacar muchos vídeos cortos parecidos (fichas de producto, consejos, testimonios) y montar cada uno a mano no te compensa.

## Cómo ganar dinero con ella

Baja el coste por vídeo de 30-60 minutos de edición a un par de minutos de máquina: sacar 20 piezas al mes deja de ser un proyecto.

- Producción de vídeos verticales para tiendas con fichas de producto repetitivas.
- Pack mensual de piezas cortas para academias que publican consejos diarios.
- Plantilla de vídeo para negocios locales con testimonios y ofertas en lote.

**Precio orientativo:** 150–400 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lees una fila de una hoja con el texto, el clip de fondo y el titular; el flujo genera la locución, calcula los subtítulos, quema texto y logo sobre el vídeo vertical y deja el archivo listo en Drive. Es para tiendas, academias y negocios locales que publican piezas cortas repetitivas.

## Lo que necesitas antes
- n8n **auto-alojado** con ffmpeg instalado (`docker exec -u root -it n8n apk add ffmpeg`) y una carpeta montada en `/files`.
- Una fuente TrueType en `/files/fuentes/Inter-Bold.ttf` (descárgala de Google Fonts) y tu logo en PNG con transparencia en `/files/logo.png`.
- Clips de fondo verticales 1080x1920 en `/files/fondos/` (grabados por ti o de stock gratuito tipo Pexels).
- Una pista de música sin derechos en `/files/musica.mp3`.
- Clave de API de OpenAI para la locución (opcional: si prefieres tu propia voz, salta ese paso).
- Hoja «Piezas» con columnas: id, titular, guion, fondo, estado, url_final.

## Los nodos, en orden
1. **Google Sheets Trigger** — Row Added en «Piezas», poll cada 10 minutos.
2. **IF** — `{{ $json.estado }}` equals `listo para montar`.
2b. **Code** («Validar fila», modo «Run Once for Each Item») — `id`, `fondo` y `titular` acaban en el comando de ffmpeg, así que se limpian y comprueban antes; si algo no cuadra, el flujo para: `const j = $json; const titular = String(j.titular).replace(/'/g, '’').replace(/:/g, ' -'); const ok = /^[A-Za-z0-9_-]+$/.test(String(j.id)) && /^[A-Za-z0-9_-]+\.(mp4|mov)$/i.test(String(j.fondo)) && /^[\p{L}\p{N} ¡!¿?.,’-]{1,80}$/u.test(titular); if (!ok) throw new Error('Fila ' + j.id + ' con datos no válidos para el comando'); return { json: { ...j, titular } };`
3. **HTTP Request** («Locución») — POST a `https://api.openai.com/v1/audio/speech`, Header Auth con tu clave, body JSON: `{"model":"tts-1","voice":"onyx","input":"{{ $json.guion }}","response_format":"mp3"}`. En Options, Response > Format: File, campo binario `data`.
4. **Read/Write Files from Disk** — modo Write, ruta `/files/tmp/{{ $('Validar fila').item.json.id }}.mp3`, campo binario `data`.
5. **Execute Command** («Duración de la voz») — `ffprobe -v quiet -show_entries format=duration -of csv=p=0 "/files/tmp/{{ $('Validar fila').item.json.id }}.mp3"`.
6. **Code** («Montar subtítulos») — parte el guion en trozos de 5-6 palabras y reparte la duración; genera un archivo .ass o una lista de filtros drawtext.
7. **Read/Write Files from Disk** — Write del archivo de subtítulos (campo binario `data`) en `/files/tmp/{{ $('Validar fila').item.json.id }}.srt`.
8. **Execute Command** («Montaje final») — el comando ffmpeg largo (abajo).
9. **Google Drive** — Upload del archivo `/files/salida/{{ $('Validar fila').item.json.id }}.mp4` (léelo antes con **Read/Write Files from Disk**) a tu carpeta «Listos para publicar».
10. **Google Sheets** — Update: estado = `montado`, url_final = el enlace de Drive.

## El código de «Montar subtítulos»
```js
const dur = parseFloat($('Duración de la voz').first().json.stdout) || 10;
const j = $('Validar fila').first().json;
const palabras = String(j.guion).split(/\s+/).filter(Boolean);
const grupos = [];
for (let i = 0; i < palabras.length; i += 5) grupos.push(palabras.slice(i, i + 5).join(' '));
const paso = dur / grupos.length;
const tc = s => {
  const h = String(Math.floor(s / 3600)).padStart(2, '0');
  const m = String(Math.floor((s % 3600) / 60)).padStart(2, '0');
  const seg = String(Math.floor(s % 60)).padStart(2, '0');
  const ms = String(Math.floor((s % 1) * 1000)).padStart(3, '0');
  return `${h}:${m}:${seg},${ms}`;
};
let srt = '';
grupos.forEach((g, i) => {
  srt += `${i + 1}\n${tc(i * paso)} --> ${tc((i + 1) * paso)}\n${g}\n\n`;
});
return [{ json: { id: j.id, titular: j.titular, fondo: j.fondo, duracion: Math.ceil(dur) }, binary: { data: { data: Buffer.from(srt).toString('base64'), mimeType: 'text/plain', fileName: j.id + '.srt' } } }];
```

## El comando de «Montaje final»
```bash
ffmpeg -stream_loop -1 -i "/files/fondos/{{ $('Validar fila').item.json.fondo }}" \
  -i "/files/tmp/{{ $('Validar fila').item.json.id }}.mp3" -i "/files/musica.mp3" -i "/files/logo.png" \
  -filter_complex "[0:v]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,\
  subtitles=/files/tmp/{{ $('Validar fila').item.json.id }}.srt:force_style='FontName=Inter,Fontsize=16,\
  PrimaryColour=&H00FFFFFF,BorderStyle=3,Outline=2,Alignment=2,MarginV=260',\
  drawtext=fontfile=/files/fuentes/Inter-Bold.ttf:text='{{ $('Validar fila').item.json.titular }}':\
  fontcolor=white:fontsize=64:x=(w-text_w)/2:y=180:box=1:boxcolor=black@0.5:boxborderw=20[v1];\
  [v1][3:v]overlay=W-w-40:40[v];[2:a]volume=0.12[m];[1:a][m]amix=inputs=2:duration=first[a]" \
  -map "[v]" -map "[a]" -t {{ $('Montar subtítulos').item.json.duracion }} -c:v libx264 -preset veryfast -crf 21 \
  -pix_fmt yuv420p -c:a aac -b:a 192k -y "/files/salida/{{ $('Validar fila').item.json.id }}.mp4"
```

## Cómo probarla
- Monta primero una pieza con un guion de dos frases: comprueba que la voz y los subtítulos van sincronizados y que el vídeo dura lo que la locución.
- Si los subtítulos se pisan con el titular, sube el `MarginV` (más margen desde abajo) o baja el `y` del drawtext.
- Prueba con un titular que lleve tilde y apóstrofo: si el texto desaparece, es problema de escapado (ver más abajo).
- Reproduce el resultado en el móvil, no solo en el ordenador: es donde se ve si el texto queda tapado por la interfaz de Instagram.

## Qué puede salir mal
- **Comillas y apóstrofos en el titular** rompen el comando: sustitúyelos en un Code previo con `titular.replace(/'/g, "").replace(/:/g, ' -')`. El carácter `:` dentro de drawtext también da guerra.
- **Celdas con trampa**: un titular o un fondo con comillas, `$(...)` o acento grave ejecutaría órdenes, porque van dentro del comando. «Validar fila» los limpia y comprueba antes; si no cumplen, no se monta nada.
- **Archivos `undefined.mp3` o `.srt` vacío**: tras la locución o un Execute Command, `$json` ya no trae `id`, `fondo` ni `titular`; por eso las rutas y el montaje leen de `$('Validar fila')`, y «Montar subtítulos» entrega el .srt como binario `data` para que el paso 7 lo pueda escribir.
- **El fondo es más corto que la locución**: el `-stream_loop -1` lo repite en bucle y el `-t` recorta al final.
- **Voz robótica**: tts-1 va bien para informativo; para ventas graba tú y salta los pasos 3-5, leyendo la duración del mp3 que subas.
- **Subtítulos que no aparecen**: la ruta del filtro `subtitles=` no admite comillas ni acentos; usa siempre rutas simples tipo `/files/tmp/123.srt`.
- **Se come la CPU**: `-preset veryfast` y 1080x1920 tardan unos 30-60 s por pieza en un equipo normal. No lances 50 a la vez; usa Split In Batches con Batch Size 1.
- **Zona de seguridad**: deja los subtítulos entre el 20 % y el 75 % de la altura o los tapan los botones de la app.

## Cuánto cuesta
La locución de OpenAI cuesta 15 $ por millón de caracteres: un guion de 400 caracteres sale por 0,006 $ (menos de un céntimo). ffmpeg, n8n auto-alojado, Drive y Sheets son gratis. El gasto real es el ordenador o VPS donde renderiza; con 20 piezas al mes te vale cualquier equipo de casa.
