# Optimizador automático de modelos GLB para web y móvil…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Sueltas un .glb en una carpeta y te devuelve una versión comprimida lista para web, con el informe de cuántos megas y polígonos ha ahorrado. Para quien vende o publica modelos 3D.

## Qué es y qué hace

Sueltas un .glb en una carpeta de Drive y n8n lo descarga, lo comprime con gltf-transform (Draco y WebP) y sube la versión ligera junto con un informe de ahorro en una hoja. Entrada: archivo glb; salida: glb optimizado y registro de megas y polígonos ahorrados. Necesita n8n en una máquina con Node.js, porque ejecuta una herramienta local.

## Cómo usarla

1. Instalar Node.js y gltf-transform
2. Crear las carpetas de Drive y la hoja optimizaciones
3. Probar con un modelo de muestra
4. Activar el vigilante de carpeta

## Cuándo usarla

Cuando tienes que preparar modelos 3D para una web, un configurador o realidad aumentada y cada uno te lleva 15 minutos de compresión manual.

## Cómo ganar dinero con ella

15 minutos por modelo a mano frente a cero; y un GLB que pasa de 40 MB a 4 MB reduce el abandono en el visor y te ahorra ancho de banda del hosting.

- Optimizar modelos 3D para configuradores web de tiendas, cobrando por lote de modelos.
- Entregar a artistas 3D que venden assets una versión ya preparada para web y móvil.
- Dar mantenimiento mensual a una agencia que publica visores 3D para sus clientes.

**Precio orientativo:** 100–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una carpeta de Drive, descarga cada .glb nuevo, le aplica compresión Draco de geometría y WebP de texturas con gltf-transform, sube el resultado optimizado y apunta el ahorro en una hoja. Para artistas 3D que venden assets, estudios de configuradores de producto y cualquiera que publique modelos en web.

## Lo que necesitas antes
- **n8n auto-alojado**, porque hace falta ejecutar un comando local.
- Node.js 18 o superior en la misma máquina. Instala la herramienta: `npm install -g @gltf-transform/cli`. Comprueba con `gltf-transform --version`.
- Carpetas locales: `/datos/glb/entrada` y `/datos/glb/salida`.
- Dos carpetas en Google Drive: `modelos-crudos` y `modelos-web`.
- Una Google Sheet `optimizaciones` con columnas: `fecha`, `fichero`, `mb_antes`, `mb_despues`, `ahorro_pct`, `enlace`.
- Opcional: un webhook de Slack (Apps > Incoming Webhooks) para el aviso.

## Los nodos, en orden
1. **Google Drive Trigger** — Trigger On: `Changes Involving a Specific Folder`, Folder: `modelos-crudos`, Watch For: `File Created`, Poll: cada 15 minutos.
2. **IF** (llamado `¿Es GLB?`) — String `{{ $json.name }}` `ends with` `.glb`. Así ignoras los .txt y las miniaturas que la gente sube por error.
3. **Google Drive** (`Descargar`) — Operation: `Download`, File ID `{{ $json.id }}`, Options > Put Output File in Field: `data`.
4. **Read/Write Files from Disk** (`Guardar en local`) — Operation: `Write File to Disk`, File Name: `/datos/glb/entrada/{{ $('Google Drive Trigger').item.json.name }}`, Input Binary Field: `data`.
5. **Execute Command** (`Optimizar`) — Command exacto abajo. Activa Continue On Fail.
6. **Code** (`Leer informe`) — parsea el JSON que escupe el inspector para sacar tamaños y triángulos.
7. **Read/Write Files from Disk** (`Leer optimizado`) — File(s) Selector: `/datos/glb/salida/{{ $('Google Drive Trigger').item.json.name }}`.
8. **Google Drive** (`Subir`) — Operation: `Upload`, carpeta `modelos-web`, nombre `{{ $('Google Drive Trigger').item.json.name.replace('.glb','') }}_web.glb`.
9. **Google Sheets** — Append Row con fecha, nombre, MB antes, MB después, porcentaje y `{{ $json.webViewLink }}`.
10. **HTTP Request** (`Slack`) — POST al webhook con body `{ "text": "🧊 {{ $('Code').item.json.fichero }}: {{ $('Code').item.json.mb_antes }} MB → {{ $('Code').item.json.mb_despues }} MB (-{{ $('Code').item.json.ahorro_pct }} %)" }`.

## El comando del nodo Execute Command
```bash
F="{{ $('Google Drive Trigger').item.json.name }}" && gltf-transform optimize "/datos/glb/entrada/$F" "/datos/glb/salida/$F" --compress draco --texture-compress webp --texture-size 2048 --simplify true --simplify-error 0.001 && stat -c%s "/datos/glb/entrada/$F" && stat -c%s "/datos/glb/salida/$F"
```

## El código de `Leer informe`
```javascript
const salida = $input.first().json.stdout.trim().split('\n');
const nums = salida.filter(l => /^\d+$/.test(l.trim())).map(Number);
const antes = nums[nums.length - 2] || 0;
const despues = nums[nums.length - 1] || 0;
const mb = b => Math.round((b / 1048576) * 100) / 100;
return [{ json: {
  fecha: $now.toFormat('yyyy-MM-dd HH:mm'),
  fichero: $('Google Drive Trigger').item.json.name,
  mb_antes: mb(antes),
  mb_despues: mb(despues),
  ahorro_pct: antes ? Math.round((1 - despues / antes) * 100) : 0
} }];
```

## Cómo probarla
- Prueba primero el comando en la terminal con un modelo tuyo y **abre el resultado** en `gltf.report` o en el visor de Windows: la compresión agresiva puede romper animaciones o los shape keys.
- Si el modelo tiene animación, quita `--simplify true`: simplificar mallas con esqueleto suele deformar el skinning.
- Sube un modelo de prueba a la carpeta de Drive y espera al poll de 15 minutos, o pulsa Fetch Test Event.

## Qué puede salir mal
- **Texturas que se ven borrosas**: `--texture-size 2048` reescala todo. Para modelos de héroe sube a 4096 o quita la opción.
- **WebP no soportado**: si tu visor es antiguo, usa `--texture-compress jpeg` en su lugar.
- **Draco y three.js**: hay que cargar el decodificador Draco en el visor o el modelo no se verá. En model-viewer y en Babylon ya viene incluido.
- **Nombres con espacios o acentos**: rompen el comando. Añade un Code previo que renombre a minúsculas sin acentos y sin espacios.
- **Drive Trigger se pierde ficheros** si subes 30 de golpe. Sube en tandas o cambia el trigger por un Schedule + `Search Files` filtrando por fecha de creación.

## Cuánto cuesta
- gltf-transform: **gratis y de código abierto**.
- Drive y Sheets: gratis dentro de tus 15 GB.
- n8n auto-alojado: gratis, VPS o tu propio PC. Ojo: si lo pones en un VPS pequeño, la compresión de un modelo grande puede necesitar 2 GB de RAM; con 4 GB vas bien (~6 €/mes).
