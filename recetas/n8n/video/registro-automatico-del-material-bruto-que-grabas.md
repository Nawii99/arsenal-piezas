# Registro automático del material bruto que grabas…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Vigila la carpeta donde vuelcas las tarjetas, lee la duración, resolución y fecha de cada archivo, lo renombra con un patrón y lo apunta en una hoja.

## Qué es y qué hace

Vigila una carpeta donde vuelcas las tarjetas de cámara; por cada archivo de vídeo lee duración, resolución y fecha con ffprobe, genera una miniatura de contacto, lo renombra con fecha y proyecto y añade una fila a la hoja Inventario. Entrada: ficheros de vídeo; salida: archivos ordenados e inventario. Requiere n8n auto-alojado con ffmpeg; no funciona en n8n Cloud, Make ni Zapier.

## Cómo usarla

1. Instala n8n con Docker y ffmpeg
2. Crea las carpetas entrada, ordenado y miniaturas
3. Crea la hoja Inventario
4. Prueba con una tarjeta antes de usarlo a diario

## Cuándo usarla

Cuando grabas mucho y acabas con carpetas llenas de C0012.MP4 sin saber qué hay dentro, cuánto ocupa ni si ya está editado o entregado.

## Cómo ganar dinero con ella

Ahorra 20-40 minutos por rodaje ordenando material y evita el peor gasto: volver a grabar algo porque no encuentras la toma buena.

- Organización de material para productoras pequeñas que entregan muchas horas de rodaje.
- Inventario de archivos para bodas o eventos con sesiones grabadas en varias cámaras.
- Sistema de archivo para creadores con cientos de clips sin catalogar.

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Detecta cada archivo de vídeo nuevo en una carpeta de tu ordenador o servidor, le saca los metadatos técnicos con ffprobe, genera una miniatura de contacto, renombra el archivo con fecha y proyecto y añade una fila al inventario. Es para videógrafos, agencias pequeñas y cualquiera que graba con cámara o móvil y luego no encuentra nada.

## Lo que necesitas antes
- n8n **auto-alojado** (esto no se puede hacer en n8n Cloud, Make ni Zapier: necesitan acceso a tus archivos). Instalación: `docker run -d --name n8n -p 5678:5678 -v ~/.n8n:/home/node/.n8n -v /ruta/de/tu/material:/files docker.n8n.io/n8nio/n8n`.
- ffmpeg y ffprobe dentro del contenedor: `docker exec -u root -it n8n apk add ffmpeg`.
- Una estructura de carpetas: `/files/entrada` (donde vuelcas las tarjetas), `/files/ordenado`, `/files/miniaturas`.
- Credencial de Google Sheets y una hoja «Inventario» con columnas: fecha, proyecto, archivo_nuevo, duracion, resolucion, fps, tamaño_mb, ruta, estado.

## Los nodos, en orden
1. **Local File Trigger** — Trigger On: Changes to a Specific Folder, Folder `/files/entrada`, activa «Watch for: File Added» y en Options pon **Awaits Write Finish** en true (clave: si no, procesa el archivo mientras se está copiando).
2. **IF** — comprueba que la extensión está permitida: `{{ ['mp4','mov','mxf','mkv','avi'].includes($json.path.split('.').pop().toLowerCase()) }}` is true.
3. **Wait** — 20 segundos, colchón extra para copias grandes desde tarjeta.
4. **Execute Command** («ffprobe») — comando: `ffprobe -v quiet -print_format json -show_format -show_streams "{{ $json.path }}"`.
5. **Code** («Leer metadatos») — parsea la salida y monta el nombre nuevo.
6. **Execute Command** («Miniatura») — `ffmpeg -ss 3 -i "{{ $json.ruta_origen }}" -frames:v 1 -vf scale=640:-1 -y "/files/miniaturas/{{ $json.archivo_nuevo }}.jpg"`.
7. **Execute Command** («Mover y renombrar») — `mkdir -p "/files/ordenado/{{ $json.proyecto }}" && mv "{{ $json.ruta_origen }}" "/files/ordenado/{{ $json.proyecto }}/{{ $json.archivo_nuevo }}"`.
8. **Google Sheets** — Append a «Inventario».
9. **Telegram** — mensaje resumen: `Nuevo bruto: {{ $json.archivo_nuevo }} · {{ $json.duracion }} · {{ $json.resolucion }} · {{ $json.tamaño_mb }} MB`.

## El código de «Leer metadatos»
```js
const j = JSON.parse(items[0].json.stdout);
const ruta = $('Local File Trigger').first().json.path;
const v = j.streams.find(s => s.codec_type === 'video') || {};
const dur = Math.round(parseFloat(j.format.duration || 0));
const mm = String(Math.floor(dur / 60)).padStart(2, '0');
const ss = String(dur % 60).padStart(2, '0');
const fpsRaw = (v.r_frame_rate || '0/1').split('/');
const fps = Math.round((+fpsRaw[0]) / (+fpsRaw[1] || 1));
const fecha = (j.format.tags?.creation_time || new Date().toISOString()).slice(0, 10);
const proyecto = ruta.split('/').slice(-2, -1)[0] || 'sin_proyecto';
const base = ruta.split('/').pop();
const ext = base.split('.').pop();
return [{ json: {
  fecha, proyecto,
  ruta_origen: ruta,
  archivo_nuevo: `${fecha}_${proyecto}_${base.replace('.' + ext, '')}_${mm}m${ss}s.${ext}`,
  duracion: `${mm}:${ss}`,
  resolucion: `${v.width}x${v.height}`,
  fps,
  tamaño_mb: Math.round((+j.format.size || 0) / 1048576),
  ruta: `/files/ordenado/${proyecto}/`,
  estado: 'bruto'
}}];
```

## Cómo probarla
- Copia un solo archivo pequeño a `/files/entrada` y mira la ejecución en n8n. Comprueba que ffprobe devuelve JSON en `stdout` (si sale vacío, la ruta tiene espacios sin comillas o ffprobe no está instalado).
- Prueba con un archivo de 8 GB desde una tarjeta real: es donde se ve si el Awaits Write Finish y el Wait funcionan.
- Verifica que la miniatura se abre y corresponde al vídeo.

## Qué puede salir mal
- **Archivos procesados a medias**: pasa siempre con tarjetas lentas. Solución: Awaits Write Finish + el Wait de 20 s, y si copias por red, súbelo a 120 s.
- **Rutas con espacios o acentos**: mantén las comillas dobles en todos los comandos, tal cual están escritas.
- **Nombres duplicados**: dos cámaras generan C0001.MP4. El nombre nuevo incluye fecha y duración, lo que ya casi elimina el choque; si quieres cero riesgo, añade `_${Date.now()}`.
- **Permisos**: si `mv` falla, el contenedor no tiene escritura en el volumen; arranca el docker con `--user root` o ajusta permisos de la carpeta.
- **Sin creation_time**: algunas cámaras no lo escriben; el código cae a la fecha de hoy.

## Cuánto cuesta
Cero euros de software: n8n auto-alojado, ffmpeg y Google Sheets son gratis. El único gasto es el disco donde guardas el material y, si lo pones en un servidor, unos 5 €/mes de VPS (aunque para vídeo lo suyo es tenerlo en tu propio equipo o NAS).
