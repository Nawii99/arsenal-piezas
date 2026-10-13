# Ingesta de material bruto: renombrar, ordenar y catalog…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Cada vez que subes tarjetas de cámara a una carpeta de Drive, renombra los archivos con fecha y proyecto, los mueve a la carpeta del rodaje y apunta duración y peso en una hoja.

## Qué es y qué hace

Vigila una carpeta de entrada de Google Drive y, por cada vídeo nuevo, lo renombra con fecha, proyecto y número, lo mueve a la carpeta del rodaje y anota nombre original, tamaño y enlace en una hoja de inventario. Entran archivos de cámara o móvil y sale material ordenado y catalogado. Se monta con el disparador de Drive de n8n y un nodo de Sheets, para videógrafos y agencias pequeñas.

## Cómo usarla

1. Crea 00_ENTRADA y la carpeta de proyectos en Drive
2. Configura OAuth de Drive y Sheets
3. Define la convención de nombres
4. Activa el disparador cada 5 minutos

## Cuándo usarla

Cuando grabas con cámara o móvil y acabas con carpetas llenas de C0012.MP4 e IMG_4471.MOV que nadie sabe de qué rodaje son.

## Cómo ganar dinero con ella

Ahorra 30-60 minutos por rodaje en ordenar material y evita el coste real de perder una toma buena porque nadie la encuentra.

- Organización de archivos de rodaje para productoras pequeñas, entregada como servicio puntual…
- Gestión mensual de archivos de vídeo para clientes, con inventario y copia de seguridad…
- Plantilla y configuración del flujo de catalogación para videógrafos de boda y eventos…

**Precio orientativo:** 90–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una carpeta «00_ENTRADA» de Google Drive, y cada archivo de vídeo nuevo lo renombra a `2026-03-14_bodaLopez_001.mp4`, lo mueve a la carpeta del proyecto y registra fila en un inventario. Para videógrafos, agencias pequeñas y cualquiera que grabe más de un proyecto al mes.

## Lo que necesitas antes
- Cuenta de Google con Drive.
- En n8n, credencial **Google Drive OAuth2 API** (mismo proceso de Google Cloud: activa Drive API y Sheets API, crea ID de cliente OAuth de aplicación web).
- En Drive: una carpeta «00_ENTRADA» y una carpeta «PROYECTOS» con subcarpetas por cliente.
- Una hoja «Inventario material» con columnas: fecha, proyecto, nombre_original, nombre_nuevo, tamano_mb, enlace.
- Convención acordada: subes los archivos a «00_ENTRADA/nombreProyecto/».

## Los nodos, en orden
1. **Google Drive Trigger** — Event: «File Created», Poll Times: cada 5 minutos, Watch Folder: la carpeta «00_ENTRADA», «Include subfolders» activado.
2. **IF** — Condición String: {{ $json.mimeType }} «contains» `video/`. Rama false: Stop and Error (o simplemente nada).
3. **Google Drive** (File → Get) — File ID: {{ $json.id }}, en «Options» activa Fields: `id,name,size,parents,createdTime,webViewLink`.
4. **Code** — construye el nombre nuevo y decide la carpeta destino.
5. **Google Drive** (File → Update) — File ID: {{ $json.id }}, Change Name: activado, New Name: {{ $json.nombre_nuevo }}.
6. **Google Drive** (File → Move) — File ID: {{ $json.id }}, Destination Folder: {{ $json.carpeta_destino }} (usa «By ID»).
7. **Google Sheets** (Append) — vuelca los datos en «Inventario material».

## El código del nodo 4
```js
const out = [];
const CARPETAS = { bodaLopez: '1AbC...idDeLaCarpeta', marcaX: '1XyZ...' };
for (const item of $input.all()) {
  const f = item.json;
  const proyecto = f.parents_name || 'sinProyecto';
  const fecha = new Date(f.createdTime).toISOString().slice(0,10);
  const ext = f.name.split('.').pop().toLowerCase();
  const n = String(Math.floor(Math.random()*900)+100);
  out.push({ json: {
    id: f.id,
    nombre_original: f.name,
    nombre_nuevo: `${fecha}_${proyecto}_${n}.${ext}`,
    carpeta_destino: CARPETAS[proyecto] || CARPETAS.marcaX,
    tamano_mb: Math.round((f.size||0)/1048576),
    enlace: f.webViewLink, fecha, proyecto } });
}
return out;
```

## Cómo probarla
Sube dos archivos pequeños (un .mp4 de 5 segundos y un .pdf) a «00_ENTRADA». El PDF debe quedarse quieto; el vídeo debe salir renombrado en la carpeta del proyecto y con su fila en la hoja. Comprueba que el nombre nuevo no se repite.

## Qué puede salir mal
- **Numeración duplicada**: el aleatorio puede repetir. Si te importa, sustitúyelo por un contador leído de la hoja con un nodo Google Sheets (Get Many) antes del Code.
- **Archivos aún subiendo**: si Drive dispara el trigger mientras el archivo se está subiendo, el tamaño sale 0. Añade un **Wait** de 2 minutos antes del nodo 3.
- **Nombres con acentos o barras**: limpia con `.replace(/[^\w.-]/g,'_')` en el Code.
- **Cuota de Drive**: 15 GB gratis se llenan en dos rodajes en 4K. Vigílalo.

## Cuánto cuesta
n8n y las APIs de Google, gratis. El gasto real es el almacenamiento de Drive: 2 TB por unos 10 €/mes en Google One, imprescindible si grabas en 4K.
