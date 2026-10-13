# Archivo y renombrado automático por datos EXIF…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Renombra cada foto con la fecha, la cámara y un número, y la guarda en carpetas por año y mes leyendo los datos que la propia cámara graba.

## Qué es y qué hace

Lee con la API de Drive la fecha de disparo y el modelo de cámara de cada foto, construye un nombre como 2026-04-12_R6_0001.jpg y la mueve a la carpeta del año y mes, creándola si no existe. Sirve para buscar por fecha real de disparo y para que dos cuerpos de cámara no pisen nombres de archivo.

## Cómo usarla

1. Crea las carpetas 00_SIN_ORDENAR y ARCHIVO en Drive
2. Anota sus IDs
3. Conecta Drive en n8n
4. Prueba con una carpeta pequeña

## Cuándo usarla

Cuando acumulas miles de fotos con nombres de cámara y no encuentras nada, o trabajas con dos cuerpos y los nombres chocan.

## Cómo ganar dinero con ella

Evita nombres duplicados que pisan archivos y ahorra 1-2 horas por sesión grande de ordenar carpetas a mano.

- Instalación del renombrado por EXIF para fotógrafos con archivos grandes en Drive.
- Servicio de archivado trimestral para estudios que suben sesiones de varias cámaras.
- Plantilla de nombres por fecha vendida a agencias que buscan material por fecha de disparo.

**Precio orientativo:** 120–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee los metadatos EXIF de cada foto (fecha de disparo, modelo de cámara, objetivo), construye un nombre limpio tipo 2026-04-12_R6_0001.jpg y la mueve a la carpeta del año y mes correspondiente, creándola si no existe.
Para fotógrafos con archivo grande, agencias y cualquiera que quiera poder buscar por fecha real de disparo y no por fecha de subida.

## Lo que necesitas antes
- n8n con credencial Google Drive OAuth2.
- Una carpeta 00_SIN_ORDENAR y una carpeta raíz ARCHIVO en Drive, con sus IDs a mano.
- Nada más: los EXIF los devuelve la propia API de Drive.

## Los nodos, en orden
1) **Schedule Trigger**. Cada 30 minutos.
2) **Google Drive** (Listar). Resource: File/Folder, Operation: Search. Search Method: Advanced, Query String: `'ID_DE_00_SIN_ORDENAR' in parents and trashed = false`. En Options > Fields escribe `id,name,mimeType,imageMediaMetadata,createdTime`.
3) **Split In Batches**. Batch Size: 25. Así no saturas la API.
4) **Code** (Construir nombre). Ver el código abajo.
5) **IF** (¿Existe carpeta del mes?). Antes, un **Google Drive1** con Operation: Search, Query String: `name = '{{ $json.carpetaMes }}' and mimeType = 'application/vnd.google-apps.folder' and trashed = false`. El IF comprueba si `{{ $json.id }}` está vacío.
6) Rama false (no existe): **Google Drive2**, Resource: Folder, Operation: Create. Name: `{{ $('Code').item.json.carpetaMes }}`. Parent: la carpeta del año (créala igual con otro par Search/Create si quieres dos niveles).
7) **Google Drive3** (Renombrar). Resource: File, Operation: Update. File ID: `{{ $('Code').item.json.id }}`. En Update Fields > Name: `{{ $('Code').item.json.nombreNuevo }}`.
8) **Google Drive4** (Mover). Operation: Move. File ID el mismo. Parent Drive/Folder: el ID de la carpeta del mes.
9) Conecta la salida de vuelta al **Split In Batches** para que siga con el siguiente lote.

## El trozo de código (nodo Code, modo Run Once for All Items)
```javascript
const salida = [];
let contador = 1;
for (const item of $input.all()) {
  const f = item.json;
  const meta = f.imageMediaMetadata || {};
  const bruta = meta.time || f.createdTime || new Date().toISOString();
  const fecha = new Date(String(bruta).replace(':', '-').replace(':', '-'));
  const y = fecha.getFullYear();
  const m = String(fecha.getMonth() + 1).padStart(2, '0');
  const d = String(fecha.getDate()).padStart(2, '0');
  const camara = (meta.cameraModel || 'CAM').replace(/[^A-Za-z0-9]/g, '');
  const ext = (f.name.split('.').pop() || 'jpg').toLowerCase();
  const num = String(contador++).padStart(4, '0');
  salida.push({ json: {
    id: f.id,
    nombreNuevo: `${y}-${m}-${d}_${camara}_${num}.${ext}`,
    carpetaAno: String(y),
    carpetaMes: `${y}-${m}`
  }});
}
return salida;
```

## Cómo probarla
Sube seis fotos de dos cámaras distintas y de dos meses distintos. Ejecuta con Test Workflow y comprueba que se crean dos carpetas y que ningún nombre se repite. Si alguna foto no tiene EXIF, debe caer con la fecha de subida y no romper el flujo.

## Qué puede salir mal
- **Fotos sin EXIF** (capturas, WhatsApp): el código ya usa createdTime como respaldo.
- **El formato de fecha EXIF** viene como 2026:04:12 12:33:00; el replace del código lo arregla, no lo quites.
- **Contador que se reinicia**: cada ejecución empieza en 0001. Si te molesta, añade la hora al nombre: `${String(fecha.getHours()).padStart(2,'0')}${String(fecha.getMinutes()).padStart(2,'0')}`.
- **Límite de la API**: con más de 500 archivos, deja Batch Size en 25 y añade un **Wait** de 2 segundos dentro del bucle.

## Cuánto cuesta
0 € en n8n autoalojado. Google Drive gratis hasta 15 GB. Si prefieres hacerlo en local con archivos del disco, el mismo flujo funciona cambiando los nodos de Drive por **Read/Write Files from Disk**, y entonces no gastas nube.
