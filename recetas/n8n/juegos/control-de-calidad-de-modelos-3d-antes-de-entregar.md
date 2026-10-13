# Control de calidad de modelos 3D antes de entregar…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Revisa automáticamente cada modelo que dejas en la carpeta de entregas: triángulos, escala, nombres, materiales y texturas, y te manda un informe con lo que falla.

## Qué es y qué hace

Flujo de n8n que, cuando aparece un .gltf o .glb en la carpeta de entregas, lee su estructura y comprueba el número de triángulos, los materiales sin nombre, las texturas enormes y los objetos fuera del origen. Entran los modelos exportados desde Blender en glTF 2.0; sale un informe por correo y una fila en la hoja qa con el resultado. Sirve como control previo antes de subir a Fab, CGTrader o Sketchfab, o de entregar a un cliente con normas de malla.

## Cómo usarla

1. 1. Exporta desde Blender en glTF 2.0
2. 2. Deja los archivos en la carpeta entregas_revisar
3. 3. Corrige lo que marque el informe y vuelve a dejarlo

## Cuándo usarla

Úsalo cuando entregas modelos a clientes o los subes a marketplaces y te han rechazado alguno por mallas sucias, escala rara o texturas que no viajaban con el archivo.

## Cómo ganar dinero con ella

Evita el ida y vuelta con el cliente por un modelo mal preparado: cada rechazo te cuesta medio día y credibilidad.

- Control de calidad de modelos para artistas 3D que venden en marketplaces y reciben rechazos por malla o escala.
- Revisión previa de entregas para estudios que subcontratan props y quieren normas claras antes de aceptar.
- Plantilla de normas de malla y texturas por cliente para agencias de contenido 3D.

**Precio orientativo:** 80–200 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cuando aparece un `.gltf` o `.glb` en la carpeta de entregas, lee su estructura interna y comprueba una lista de requisitos: número de triángulos, materiales sin nombre, texturas enormes, objetos fuera del origen.
Para quien vende modelos en Fab, CGTrader, Sketchfab o entrega a estudios que tienen normas estrictas de malla.

## Lo que necesitas antes
n8n (vale la versión cloud si exportas siempre a `.gltf` en texto; para `.glb` binario mejor auto-alojado).
Credenciales de Google Drive OAuth2, Gmail OAuth2 y Google Sheets OAuth2 en n8n.
Una carpeta en Drive llamada `entregas_revisar` y otra `entregas_ok`. Apunta los IDs de ambas.
Una hoja `qa` con columnas: `fecha`, `archivo`, `resultado`, `triangulos`, `materiales`, `avisos`.
Exporta siempre desde Blender con `Archivo > Exportar > glTF 2.0` en formato **glTF Separate o Embedded** (el `.gltf` es texto JSON y es el que sabemos leer sin librerías).
Define tus límites antes: por ejemplo máximo 50.000 triángulos, texturas de 2048 px como mucho, nada de nombres tipo `Cube.001`.

## Los nodos, en orden
1) **Google Drive Trigger** — evento `File Created`, carpeta `entregas_revisar`, comprobación cada minuto.
2) **IF** — que el nombre `{{ $json.name }}` termine en `.gltf`. Si no, para ahí.
3) **Google Drive** (operación `Download`) — descarga el archivo.
4) **Extract From File** (operación `Move Binary to JSON` o `Text`) — convierte el binario a texto en el campo `data`.
5) **Code** — el análisis (ver abajo).
6) **IF** — `{{ $json.resultado }}` es igual a `OK`.
7a) Rama verdadera: **Google Drive** (operación `Move`) → carpeta `entregas_ok`.
7b) Rama falsa: **Gmail** (`Send`) con asunto `QA fallida: {{ $json.archivo }}` y cuerpo `{{ $json.avisos }}`.
8) **Google Sheets** (`Append Row`) — registra el resultado en la hoja `qa` pase lo que pase.

## El trozo de código (nodo Code)
```javascript
const nombre = $('Google Drive Trigger').first().json.name;
let g;
try { g = JSON.parse($input.first().json.data); }
catch (e) { return [{ json: { archivo: nombre, resultado: 'ERROR', avisos: 'No es un glTF legible' } }]; }
const avisos = [];
let triangulos = 0;
for (const m of (g.meshes || [])) {
  for (const p of (m.primitives || [])) {
    const acc = g.accessors?.[p.indices];
    if (acc) triangulos += Math.floor(acc.count / 3);
  }
}
if (triangulos > 50000) avisos.push('Demasiados triángulos: ' + triangulos);
const materiales = (g.materials || []).length;
if (materiales === 0) avisos.push('El modelo no tiene ningún material asignado');
if (materiales > 4) avisos.push('Demasiados materiales (' + materiales + '), agrupa en un atlas');
for (const m of (g.materials || [])) {
  if (!m.name || /^Material(\.\d+)?$/.test(m.name)) avisos.push('Material sin renombrar: ' + (m.name || 'sin nombre'));
}
for (const n of (g.nodes || [])) {
  if (/\.\d{3}$/.test(n.name || '')) avisos.push('Objeto con nombre automático: ' + n.name);
  const t = n.translation;
  if (t && (Math.abs(t[0]) > 5 || Math.abs(t[1]) > 5 || Math.abs(t[2]) > 5)) avisos.push('Objeto lejos del origen: ' + n.name);
  const s = n.scale;
  if (s && s.some(v => Math.abs(v - 1) > 0.001)) avisos.push('Escala sin aplicar en: ' + n.name);
}
for (const im of (g.images || [])) {
  if (im.uri && im.uri.startsWith('data:') && im.uri.length > 8000000) avisos.push('Textura embebida enorme: ' + (im.name || 'sin nombre'));
}
if (!(g.meshes || []).some(m => (m.primitives || []).some(p => p.attributes?.TEXCOORD_0))) avisos.push('Falta el desplegado UV en alguna malla');
return [{ json: {
  fecha: new Date().toISOString().slice(0, 10),
  archivo: nombre,
  triangulos,
  materiales,
  resultado: avisos.length ? 'FALLA' : 'OK',
  avisos: avisos.join(' | ') || 'Sin incidencias'
} }];
```

## Cómo probarla
Exporta a propósito un cubo con el nombre por defecto `Cube.001` y escala sin aplicar: debe darte dos avisos.
Exporta luego un modelo bien preparado y comprueba que se mueve solo a `entregas_ok`.
Ajusta el límite de 50.000 triángulos al tipo de trabajo que hagas (para móvil bajarás mucho, para cine no aplica).

## Qué puede salir mal
Si exportas `.glb` (binario) el JSON no se puede leer como texto: o exportas `.gltf`, o añades un Execute Command con la herramienta `gltf-transform` para convertirlo antes.
El disparador de Drive tarda hasta un minuto en enterarse; no es instantáneo.
Archivos de más de 100 MB pueden hacer que n8n se quede sin memoria: sube el límite con la variable `N8N_PAYLOAD_SIZE_MAX`.
Si subes muchos archivos a la vez, Drive puede lanzar varias ejecuciones seguidas; no pasa nada, cada una es independiente.

## Cuánto cuesta
Todo gratis: Drive, Sheets, Gmail y n8n auto-alojado.
Si usas n8n Cloud, el plan de inicio ronda 20 € al mes y este flujo consume una ejecución por archivo revisado.
