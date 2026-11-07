# Archivo por EXIF: renombra, sella copyright y ordena po…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Lee los datos EXIF de cada foto, la renombra con fecha, cámara y número, le escribe tu copyright en los metadatos IPTC y la guarda en carpetas por año y mes.

## Qué es y qué hace

Lee los datos EXIF de cada foto que sueltas en una carpeta BUZÓN, escribe tu nombre y aviso de copyright en los campos IPTC y XMP, renombra el archivo con fecha y cámara y lo mueve a una carpeta por año y mes. Además anota cada foto en un inventario buscable. Necesita n8n autoalojado con ExifTool, porque usa el nodo Execute Command.

## Cómo usarla

1. Instala ExifTool en el contenedor
2. Crea las carpetas BUZÓN, ARCHIVO y ERRORES
3. Prueba con 20 fotos
4. Que lo revise un profesional

## Cuándo usarla

Cuando tienes miles de DSC_0043.jpg sin orden, no encuentras nada dos años después y tus fotos circulan por internet sin tu nombre dentro del archivo.

## Cómo ganar dinero con ella

Te ahorra 1-2 horas de ordenar por sesión y te da prueba de autoría escrita en el archivo, clave si algún día reclamas un uso indebido.

- Instalación del archivado automático con copyright para fotógrafos que tienen miles de archivos sin ordenar.
- Servicio trimestral de archivo y sellado de sesiones para estudios de fotografía.
- Plantilla de flujo de archivo vendida a agencias pequeñas que necesitan prueba de autoría escrita en las fotos.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Para cualquier fotógrafo que archiva a mano: coge lo que sueltes en una carpeta «BUZÓN», extrae fecha de disparo, cámara, objetivo, ISO y diafragma, escribe tu nombre y aviso de copyright en los campos IPTC y XMP, renombra el archivo con un patrón legible y lo mueve a `ARCHIVO/2026/09/`. Además apunta cada foto en una hoja que te sirve de inventario buscable.

## Lo que necesitas antes
- n8n **auto-alojado** (esta receta usa el nodo Execute Command, que no existe en n8n Cloud).
- ExifTool instalado en el contenedor. Si usas Docker, crea un Dockerfile con: `FROM n8nio/n8n` y `USER root` y `RUN apk add --no-cache exiftool` y `USER node`, y levántalo con ese image.
- Credencial Google Drive OAuth2 y Google Sheets OAuth2 en n8n.
- Tres carpetas en Drive: BUZÓN, ARCHIVO y ERRORES. Apúntate sus IDs (están en la URL).
- Una hoja «Inventario» con columnas: archivo, fecha, camara, objetivo, iso, diafragma, carpeta, id_drive.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: Minutes, Minutes Between Triggers: 30.
2. **Google Drive** — Operation: Search. Query String: `'ID_BUZON' in parents and trashed=false`. Return All activado. Fields: `id,name,mimeType`.
3. **Loop Over Items** — Batch Size: 1.
3b. **Code «Nombre seguro»** (modo «Run Once for Each Item») — `const ext = String($json.name).split('.').pop().toLowerCase(); if (!['jpg','jpeg','png','tif','tiff','heic','dng','cr2','cr3','nef','arw','raf','orf','rw2'].includes(ext) || !/^[A-Za-z0-9_-]+$/.test($json.id)) throw new Error('Formato no admitido: ' + $json.name); return { json: { ...$json, archivo: $json.id + '.' + ext } };`. En /tmp y en los comandos solo se usa `archivo`.
4. **Google Drive** — Operation: Download. File ID `={{ $json.id }}`. Put Output File in Field: `data`. En Options activa «File Name» para conservar el nombre.
5. **Read/Write Files from Disk** — Operation: Write File to Disk. File Path: `=/tmp/foto/{{ $('Nombre seguro').item.json.archivo }}`. Input Binary Field: `data`. (Antes crea la carpeta con un Execute Command: `mkdir -p /tmp/foto`.)
6. **Execute Command «Leer EXIF»** — Command: `exiftool -json -DateTimeOriginal -Model -LensModel -ISO -FNumber -ImageWidth -ImageHeight "/tmp/foto/{{ $('Nombre seguro').item.json.archivo }}"`.
7. **Code «Parsear y nombrar»** — convierte el JSON de salida y compone el nombre nuevo (código abajo).
8. **Execute Command «Sellar IPTC»** — Command: `exiftool -overwrite_original -Artist="Tu Nombre" -Copyright="(c) 2026 Tu Nombre. Todos los derechos reservados" -XMP-dc:Rights="(c) 2026 Tu Nombre" -XMP-xmpRights:WebStatement="https://tuweb.com/licencias" -IPTC:Credit="Tu Nombre" -IPTC:Source="tuweb.com" "/tmp/foto/{{ $json.archivo }}"`.
9. **Read/Write Files from Disk** — Operation: Read File from Disk, File Path el mismo, campo binario `data`.
10. **Google Drive** — Operation: Folder > Create. Name `={{ $('Parsear y nombrar').item.json.anio }}`, Parent: ARCHIVO. En Options activa «Return existing folder if it exists» o encadena una búsqueda previa para no duplicar carpetas.
11. Repite el paso anterior para el mes dentro del año.
12. **Google Drive** — Operation: Upload. Input Data Field Name: `data`. File Name `={{ $('Parsear y nombrar').item.json.nombre_nuevo }}`. Parent Folder: el ID que devolvió el nodo del mes.
13. **Google Drive** — Operation: Delete File (el original del BUZÓN) o mejor Operation: Move, para no perder nada.
14. **Google Sheets** — Operation: Append con todos los campos del inventario.
15. Rama de error: **IF** con `{{ $json.fecha }}` Is Empty > **Google Drive** Move a la carpeta ERRORES y **Gmail** de aviso.

## El trozo de código (nodo Code «Parsear y nombrar»)
```javascript
const salida = [];
for (const item of $input.all()) {
  const bruto = item.json.stdout || '[]';
  const d = JSON.parse(bruto)[0] || {};
  const fecha = (d.DateTimeOriginal || '').replace(/:/g, '-').replace(' ', '_');
  const partes = (d.DateTimeOriginal || '').split(' ')[0].split(':');
  const camara = (d.Model || 'sincamara').replace(/[^A-Za-z0-9]/g, '');
  const original = $('Loop Over Items').item.json.name;
  const ext = original.split('.').pop().toLowerCase();
  salida.push({ json: {
    nombre_original: original,
    archivo: $('Nombre seguro').item.json.archivo,
    nombre_nuevo: fecha ? `${fecha}_${camara}_${original.replace(/\.[^.]+$/, '')}.${ext}` : original,
    anio: partes[0] || 'sin-fecha',
    mes: partes[1] || '00',
    fecha: d.DateTimeOriginal || '',
    camara: d.Model || '',
    objetivo: d.LensModel || '',
    iso: d.ISO || '',
    diafragma: d.FNumber || ''
  }});
}
return salida;
```

## Cómo probarla
- Sube 3 fotos al BUZÓN: una JPG de cámara, una captura de móvil y una imagen descargada de internet (sin EXIF).
- Ejecuta a mano. Las dos primeras deben acabar en `ARCHIVO/2026/09/`; la tercera, en ERRORES.
- Descarga una foto ya archivada y comprueba en Windows (Propiedades > Detalles) o con `exiftool archivo.jpg` que aparece tu nombre en Autor y Copyright.

## Qué puede salir mal
- **Zona horaria**: el EXIF guarda la hora de la cámara, no la del servidor. Si tu cámara está desajustada, corrige en bloque con `exiftool -AllDates+=1:0:0 0` antes de archivar.
- **Carpetas duplicadas**: Drive permite dos carpetas con el mismo nombre. Antes de crear, busca con Google Drive > Search y Query `name='2026' and 'ID_ARCHIVO' in parents and mimeType='application/vnd.google-apps.folder'`.
- **Archivos enormes**: los RAW de 50 MB pueden agotar la memoria de n8n. Sube `N8N_DEFAULT_BINARY_DATA_MODE=filesystem` en las variables de entorno.
- **Se llena /tmp**: añade un Execute Command final con `rm -f "/tmp/foto/{{ $('Nombre seguro').item.json.archivo }}"`.
- **Nombres con trampa**: una foto llamada `$(id).jpg` o con comillas ejecutaría órdenes en ExifTool. En /tmp va como `ID-de-Drive.extensión` y el nombre original solo sirve para el nombre nuevo y la hoja; si llega otra extensión, el flujo para: muévela a ERRORES.
- **Perder originales**: usa Move en lugar de Delete hasta que lleves un mes sin fallos.

## Cuánto cuesta
Todo gratis: n8n auto-alojado (un VPS de 5 €/mes o tu propio ordenador), ExifTool es software libre, Drive y Sheets con tu cuenta. El único gasto real es el almacenamiento de Drive si superas los 15 GB (Google One 100 GB, 1,99 €/mes).
