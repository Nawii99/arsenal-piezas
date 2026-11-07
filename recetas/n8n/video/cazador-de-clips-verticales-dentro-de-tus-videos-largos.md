# Cazador de clips verticales dentro de tus vídeos largos…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Transcribe un vídeo largo, deja que una IA elija los 5 momentos más potentes y te devuelve los cortes exactos con los comandos ffmpeg listos para recortar.

## Qué es y qué hace

Es una automatización de n8n que transcribe un vídeo largo desde una carpeta de Drive, pide a un modelo de IA (Claude, Codex, Gemini o una IA local) los cinco fragmentos de 30 a 60 segundos con más gancho y deja en una hoja el inicio, el fin, el titular y el comando ffmpeg para cortarlos. Entra un vídeo y sale una tabla de cortes listos. Requiere n8n auto-alojado para poder ejecutar ffmpeg.

## Cómo usarla

1. Instala n8n auto-alojado con ffmpeg
2. Conecta Drive y Sheets
3. Elige el modelo de IA y su clave
4. Revisa los cinco cortes antes de recortar

## Cuándo usarla

Cuando grabas podcast, formación o directos largos y quieres sacar Shorts, Reels y TikToks sin verte el vídeo entero buscando el momento bueno.

## Cómo ganar dinero con ella

Sustituye 1-2 horas de revisar el bruto por cada vídeo. La transcripción cuesta unos 0,20 € por hora de vídeo y la IA menos de 0,05 € por análisis.

- Cortes para Shorts a partir de podcasts con horas de audio sin usar.
- Extracción de momentos para formadores que quieren vertical cada semana.
- Análisis de vídeos largos para agencias que entregan verticales a sus clientes.

**Precio orientativo:** 120–300 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Detecta un vídeo nuevo en una carpeta de Drive, saca su transcripción con marcas de tiempo, pide a un modelo de IA los 5 fragmentos de 30-60 segundos con más gancho y te deja en una hoja el minuto de inicio, el de fin, el titular sugerido y el comando ffmpeg para cortarlo. Es para quien produce contenido largo y necesita alimentar vertical cada semana.

## Lo que necesitas antes
- n8n (mejor auto-alojado, así puedes usar el nodo Execute Command para el audio y para cortar).
- Cuenta de Google con Drive y Sheets; credencial «Google Drive OAuth2 API» en n8n.
- Clave de API de OpenAI (platform.openai.com > API keys), con 5 € de saldo cargados.
- ffmpeg instalado en la máquina de n8n. Si usas la imagen oficial de Docker: `docker exec -u root -it n8n apk add ffmpeg`.
- Una carpeta en Drive llamada «Para clipear» y una hoja «Clips» con columnas: fecha, archivo, inicio, fin, titular, gancho, comando.

## Los nodos, en orden
1. **Google Drive Trigger** — evento «File Created», carpeta «Para clipear», Poll Times cada 15 minutos.
1b. **Code** («Nombre seguro», modo «Run Once for Each Item») — `const ext = String($json.name).split('.').pop().toLowerCase(); if (!['mp4','mov','m4v','mkv','webm'].includes(ext) || !/^[A-Za-z0-9_-]+$/.test($json.id)) throw new Error('Formato no admitido: ' + $json.name); return { json: { ...$json, archivo: $json.id + '.' + ext } };`. En disco y en los comandos solo se usa `archivo`.
2. **Google Drive** — operación Download, File ID `{{ $json.id }}`. Salida binaria en el campo `data`.
3. **Execute Command** («Extraer audio») — comando: `ffmpeg -i "/files/{{ $('Nombre seguro').item.json.archivo }}" -vn -ac 1 -ar 16000 -b:a 32k -y "/files/audio.m4a"`. Antes, guarda el binario a disco con un nodo **Read/Write Files from Disk** en modo Write, ruta `/files/{{ $('Nombre seguro').item.json.archivo }}`.
4. **Read/Write Files from Disk** («Leer audio») — modo Read, ruta `/files/audio.m4a`.
5. **HTTP Request** («Whisper») — POST a `https://api.openai.com/v1/audio/transcriptions`. Authentication: Generic > Header Auth, cabecera `Authorization` con valor `Bearer TU_CLAVE`. Body: Form-Data con `file` (tipo n8n Binary File, campo `data`), `model` = `whisper-1`, `response_format` = `verbose_json`, `timestamp_granularities[]` = `segment`, `language` = `es`.
6. **Code** («Compactar transcripción») — junta los segmentos en bloques de 30 s con su minuto de inicio.
7. **HTTP Request** («Elegir momentos») — POST a `https://api.openai.com/v1/chat/completions`, body JSON con `model` = `gpt-4o-mini`, `response_format` = `{"type":"json_object"}` y un mensaje de usuario que incluya `{{ $json.texto }}` y la instrucción: «Devuelve un JSON {"clips":[{"inicio":segundos,"fin":segundos,"titular":"...","gancho":"..."}]} con los 5 fragmentos de 30 a 60 segundos con más gancho para vertical. Usa solo momentos que se entiendan sin contexto previo.»
8. **Code** («Montar comandos») — parte la respuesta en 5 filas y escribe el comando ffmpeg de recorte y reencuadre a 9:16.
9. **Google Sheets** — Append a la hoja «Clips».
10. (Opcional, solo auto-alojado) **Execute Command** — ejecuta `{{ $('Montar comandos').item.json.comando }}` para dejar los 5 clips ya cortados en `/files/clips/`.

## El código de «Compactar transcripción»
```js
const segs = items[0].json.segments || [];
let texto = '';
let bloque = -1;
for (const s of segs) {
  const b = Math.floor(s.start / 30);
  if (b !== bloque) { bloque = b; texto += `\n[${Math.floor(s.start)}s] `; }
  texto += s.text.trim() + ' ';
}
return [{ json: { texto: texto.trim() } }];
```

## El código de «Montar comandos»
```js
const raw = items[0].json.choices[0].message.content;
const clips = JSON.parse(raw).clips || [];
const nombre = $('Google Drive Trigger').first().json.name;
const archivo = $('Nombre seguro').first().json.archivo;
return clips.map((c, i) => {
  const ini = Number(c.inicio), fin = Number(c.fin);
  if (!Number.isFinite(ini) || !Number.isFinite(fin) || ini < 0 || fin <= ini) throw new Error('Tiempos no válidos en el clip ' + (i + 1));
  const dur = fin - ini;
  const cmd = `ffmpeg -ss ${ini} -i "/files/${archivo}" -t ${dur} ` +
    `-vf "crop=ih*9/16:ih,scale=1080:1920" -c:v libx264 -crf 20 -c:a aac ` +
    `-y "/files/clips/clip_${i + 1}.mp4"`;
  return { json: {
    fecha: new Date().toISOString().slice(0, 10),
    archivo: nombre,
    inicio: ini, fin: fin,
    titular: c.titular, gancho: c.gancho, comando: cmd
  }};
});
```

## Cómo probarla
- Sube a la carpeta un vídeo corto de 5 minutos y ejecuta el workflow con **Execute Workflow** mientras miras cada nodo.
- Comprueba dos cosas: que el JSON de Whisper trae `segments` (si no, te falta `verbose_json`) y que los minutos que propone la IA coinciden de verdad con lo que se dice ahí.
- Corta a mano el primer clip con el comando de la hoja antes de fiarte del paso 10.

## Qué puede salir mal
- **Whisper rechaza el archivo por tamaño**: el límite es 25 MB. El paso 3 baja el audio a mono 32 kbps precisamente para eso (una hora ocupa unos 14 MB). Si aun así pasa, trocea con `-f segment -segment_time 1800`.
- **La IA devuelve texto con explicaciones y peta el JSON.parse**: obliga `response_format: json_object` y, por si acaso, envuelve el parse en un try/catch que devuelva el texto crudo a una columna «error».
- **El recorte central corta cabezas**: cambia el `crop` a `crop=ih*9/16:ih:(iw-ih*9/16)/2:0` o ajusta el desplazamiento X según dónde esté la persona.
- **Nombres con trampa**: un vídeo llamado `a"; rm -rf ~; ".mp4` ejecutaría órdenes en ffmpeg y en el paso 10. En disco va como `ID-de-Drive.extensión`, los tiempos de la IA se comprueban como números y el nombre original solo va a la hoja.
- **Comando sacado de la hoja**: el paso 10 lee el comando de `$('Montar comandos')`, que lo arma con valores comprobados, y no de lo que devuelve Google Sheets, que alguien podría editar.
- **Duplicados**: si el trigger vuelve a ver el mismo archivo, muévelo a una carpeta «Procesados» con un nodo Google Drive (operación Move) al final.

## Cuánto cuesta
Whisper cuesta 0,006 $ por minuto de audio (una hora, 0,36 $, unos 0,33 €); gpt-4o-mini para elegir momentos, menos de 0,01 € por vídeo. Drive y Sheets, gratis. n8n auto-alojado, gratis; en n8n Cloud cada ejecución cuenta para tu límite mensual.
