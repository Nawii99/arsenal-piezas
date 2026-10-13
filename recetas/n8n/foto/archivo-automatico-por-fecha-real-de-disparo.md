# Archivo automático por fecha real de disparo…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Ordena las fotos que subes a Drive en carpetas año/mes/cliente usando la fecha que grabó la cámara, no la de subida, y las renombra con un patrón fijo.

## Qué es y qué hace

Vigila una carpeta de entrada en Drive. Al llegar una foto, lee la fecha de captura del EXIF, crea si hace falta la carpeta año, mes y cliente, y mueve el archivo renombrado con fecha, cliente y número. El nombre del cliente sale de un prefijo que pones al subir. Entran archivos con EXIF y salen fotos ordenadas en carpetas, con n8n y ExifTool. Para fotógrafos que acumulan sesiones sin ordenar.

## Cómo usarla

1. Instala ExifTool en n8n
2. Crea las carpetas de entrada y de archivo
3. Acuerda el prefijo cliente__nombre al subir
4. Prueba con una tarjeta de prueba antes de todo

## Cuándo usarla

Úsalo cuando acumules sesiones sin ordenar y pierdas tiempo buscando «la boda de octubre», o cuando trabajes con varias cámaras y las fechas de archivo no cuadren.

## Cómo ganar dinero con ella

Ahorra entre 2 y 4 horas al mes de ordenar carpetas y, sobre todo, evita esa hora de búsqueda desesperada cuando un cliente pide una foto de hace tres años.

- Ordenación del archivo fotográfico por fecha real para fotógrafos con años acumulados, cobrada por archivo.
- Mantenimiento mensual del archivo y renombrado para estudios con varias cámaras, por cuota.
- Plantilla de archivo por fecha vendida a fotógrafos que quieren encontrar cualquier sesión en segundos.

**Precio orientativo:** 100–250 € por archivo (hasta 2.000 fotos. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una carpeta «BUZÓN» de Google Drive. Cuando llega una foto, lee su fecha de captura del EXIF (`DateTimeOriginal`), crea si hace falta la carpeta `2026/10-Octubre/NombreCliente` y mueve el archivo allí renombrado como `20261014_NombreCliente_0001.jpg`.
Es para fotógrafos que descargan tarjetas a lo bruto y luego no ordenan nunca. El nombre del cliente se saca de un prefijo que tú pones al subir: `boda-garcia__DSC0042.jpg`.

## Lo que necesitas antes
- n8n auto-alojado con ExifTool instalado (mira la receta de auditoría de metadatos para el comando de instalación).
- Carpeta `BUZON` en Drive y una carpeta raíz `ARCHIVO` donde vivirá el árbol de carpetas.
- Credencial «Google Drive OAuth2 API» en n8n, con permiso de escritura (el alcance por defecto ya lo trae).
- Costumbre de subir los archivos con el prefijo del cliente y doble guion bajo: `cliente__nombreoriginal.jpg`.

## Los nodos, en orden
1. **Google Drive Trigger** — Event: `File Created`, Watch Folder: `BUZON`, Poll Times: cada minuto.
2. **Google Drive** — Operation: `Download`, File ID: `{{ $json.id }}`, output en el campo `data`.
3. **Read/Write Files from Disk** — Operation: `Write File to Disk`, File Path: `/tmp/{{ $json.name }}`, Input Binary Field: `data`. ExifTool necesita el archivo en disco.
4. **Execute Command** — Command: `exiftool -j -DateTimeOriginal -CreateDate "/tmp/{{ $('Google Drive Trigger').item.json.name }}"`.
5. **Code** — Mode: `Run Once for Each Item`. Calcula ruta y nombre nuevo (código abajo).
6. **Google Drive** (renómbralo «Crear carpeta año») — Operation: `Create Folder`, Folder Name: `{{ $json.anio }}`, Parent Folder: `ARCHIVO`. En Options activa «Same Name As Existing» si tu versión lo ofrece; si no, hazlo con el nodo de búsqueda del punto siguiente.
7. **Google Drive** (renómbralo «Buscar o crear mes/cliente») — Operation: `Search`, Query String: `{{ $json.carpeta_mes }}`, Filter: `Folders`. Encadena un **IF** que compruebe si hay resultados y, si no, un **Google Drive** con `Create Folder`.
8. **Google Drive** — Operation: `Update`, File ID: el del archivo, campos: `name` = `{{ $json.nombre_nuevo }}`, y en «Move to Folder» el id de la carpeta destino.

## El código del nodo Code
```javascript
let exif = {};
try { exif = JSON.parse($json.stdout)[0] || {}; } catch (e) {}
const nombreOriginal = $('Google Drive Trigger').item.json.name;
const bruto = exif.DateTimeOriginal || exif.CreateDate || '';
let fecha;
if (/^\d{4}:\d{2}:\d{2}/.test(bruto)) {
  const [f, h] = bruto.split(' ');
  const [a, m, d] = f.split(':');
  fecha = new Date(a + '-' + m + '-' + d + 'T' + (h || '00:00:00'));
} else {
  fecha = new Date($('Google Drive Trigger').item.json.createdTime);
}
const meses = ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];
const anio = String(fecha.getFullYear());
const mm = String(fecha.getMonth() + 1).padStart(2, '0');
const dd = String(fecha.getDate()).padStart(2, '0');
const partes = nombreOriginal.split('__');
const cliente = partes.length > 1 ? partes[0].replace(/[^a-zA-Z0-9-]/g, '') : 'sin-cliente';
const extension = nombreOriginal.split('.').pop();
return { json: {
  anio,
  carpeta_mes: mm + '-' + meses[fecha.getMonth()],
  carpeta_cliente: cliente,
  nombre_nuevo: anio + mm + dd + '_' + cliente + '_' + Math.random().toString(36).slice(2, 6) + '.' + extension,
  fecha_captura: fecha.toISOString()
} };
```

## Cómo probarla
- Sube una foto con nombre `pruebas__DSC0001.jpg` sacada hace meses. Comprueba que acaba en la carpeta del mes en que la hiciste, no en la de hoy.
- Sube una captura de pantalla (sin EXIF de cámara): debe caer en el mes actual usando la fecha de creación como respaldo, sin romper el flujo.
- Sube dos fotos a la vez para ver que el sufijo aleatorio evita que la segunda pise a la primera.

## Qué puede salir mal
- **Fotos con la fecha de la cámara mal puesta**: si viajaste y no cambiaste el reloj, la foto irá al mes equivocado. Se arregla con ExifTool antes: `exiftool "-AllDates+=2:0:0" carpeta/` suma dos horas.
- **Zona horaria**: `DateTimeOriginal` no guarda zona. Al convertirlo, n8n usa la zona del servidor. Fija la del flujo en Settings del workflow a `Europe/Madrid` para que una foto de las 00:30 no salte de día.
- **Carpetas duplicadas**: Drive permite dos carpetas con el mismo nombre. Por eso hay un paso de buscar antes de crear; si te salen duplicadas, es que te saltaste el IF.
- **Límite de peticiones de Drive**: subir 800 fotos de golpe puede dar error 403 «rate limit». Mete un **Split In Batches** de 20 con un nodo **Wait** de 2 segundos.
- **RAW**: los `.CR3` o `.NEF` funcionan igual con ExifTool, pero pesan; asegúrate de tener espacio en `/tmp` y añade un **Execute Command** final con `rm` para limpiar.

## Cuánto cuesta
- Google Drive: gratis hasta 15 GB; 2 TB por unos 10 € al mes si archivas RAW.
- n8n auto-alojado: 0 a 5 € al mes. ExifTool: gratis.
