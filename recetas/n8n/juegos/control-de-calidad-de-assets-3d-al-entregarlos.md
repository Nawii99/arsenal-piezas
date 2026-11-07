# Control de calidad de assets 3D al entregarlos…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Revisa cada modelo que subes a la carpeta compartida: nombres, polígonos, escala, UVs y texturas, y rechaza el que no cumple tus normas.

## Qué es y qué hace

Flujo de n8n que, al aparecer un modelo en la carpeta de entregas, lo abre en Blender y revisa el nombre según tu convención, el máximo de triángulos, la escala aplicada, el origen, los UVs y el tamaño de las texturas. Si pasa, lo mueve a aprobados; si no, a rechazados con la lista exacta de fallos. Entran el modelo y tus normas; sale un registro y un aviso. Necesita n8n auto-alojado con Blender instalado.

## Cómo usarla

1. 1. Escribe tus normas: prefijos, triángulos, texturas y escala
2. 2. Crea las carpetas entregas, aprobados y rechazados
3. 3. Prueba con tres modelos buenos y tres malos

## Cuándo usarla

Úsalo cuando trabajas con freelancers o con un equipo y te llegan modelos con nombres inventados, escalas raras o texturas de 8K que revientan el rendimiento del juego.

## Cómo ganar dinero con ella

Evita 1-2 horas de arreglos por asset defectuoso y las revisiones de ida y vuelta con el artista, que suelen costar más que el propio modelo.

- Control de calidad de assets para directores de arte que trabajan con freelancers y necesitan normas claras.
- Revisión previa de entregas para estudios que reciben modelos de terceros con escalas y nombres inventados.
- Plantilla de normas técnicas y chequeo automático para equipos de arte que quieren menos ida y vuelta.

**Precio orientativo:** 150–350 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada modelo que aparece en la carpeta «entregas» pasa por un chequeo automático en Blender: nombre según tu convención, número de triángulos por debajo del presupuesto, escala aplicada, objeto en el origen, UVs sin solapes graves y texturas dentro del tamaño máximo. Si pasa, se mueve a «aprobados» y se registra; si no, se mueve a «rechazados» y el artista recibe la lista exacta de fallos.
Para directores de arte, jefes de equipo y freelancers que quieren entregar siempre limpio.

## Lo que necesitas antes
- n8n auto-alojado con Blender instalado (nodo «Execute Command»).
- Carpetas en Drive: «entregas», «aprobados», «rechazados».
- Un documento con tus normas: por ejemplo prefijo `SM_` para mallas estáticas, máximo 15.000 triángulos para props, texturas máximo 2048 px, escala 1,1,1 y origen en la base del objeto.
- Credencial de Google Drive y app de Slack con webhook entrante (api.slack.com/apps → Incoming Webhooks).

## Los nodos, en orden
1. **Google Drive Trigger** — «File Created» en «entregas».
2. **Wait** — 45 segundos, para que Drive termine de subir el archivo entero.
3. **Code** (renómbralo «Nombre seguro») — Mode: Run Once for Each Item. Comprueba la extensión contra la lista permitida (`fbx`, `obj`, `glb`, `gltf`) y prepara el nombre interno `ID_de_Drive.extensión`. Ver código abajo.
4. **Google Drive** («Download File», File ID `{{ $json.id }}`) y **Read/Write Files from Disk** («Write») a `/data/qa/{{ $('Nombre seguro').item.json.archivo }}`.
5. **Execute Command** — `blender -b --python /data/scripts/qa.py -- "/data/qa/{{ $('Nombre seguro').item.json.archivo }}"`.
6. **Read/Write Files from Disk** («Read») — Lee `/data/qa/resultado.json`.
7. **Code** — Convierte el JSON en una lista de fallos legible y añade las comprobaciones del nombre original, que ya no llega al script: con `$('Nombre seguro').item.json.nombre`, falla si no empieza por `SM_` o `SK_` o si tiene espacios.
8. **IF** — `{{ $json.fallos.length }}` igual a `0`.
9. **Google Drive** («Move File») — A «aprobados» o a «rechazados» según la rama.
10. **Google Sheets** («Append Row») — Registro: fecha, archivo, artista, triángulos, veredicto, fallos.
11. **Slack** — Mensaje al canal #arte: `✅ SM_silla.fbx aprobado (8.412 tris)` o `❌ silla_final2.fbx rechazado: nombre sin prefijo SM_, escala sin aplicar, textura de 4096 px`.

## El código de «Nombre seguro»
```js
const ext = String($json.name || '').toLowerCase().split('.').pop();
if (!['fbx', 'obj', 'glb', 'gltf'].includes(ext)) throw new Error('Formato no admitido: ' + ext);
if (!/^[A-Za-z0-9_-]+$/.test($json.id)) throw new Error('ID de Drive inesperado');
return { json: { id: $json.id, nombre: $json.name, archivo: `${$json.id}.${ext}` } };
```

## El script de comprobación
Guárdalo como `/data/scripts/qa.py`:
```python
import bpy, sys, os, json
ruta = sys.argv[sys.argv.index('--') + 1]
nombre = os.path.basename(ruta)
bpy.ops.wm.read_factory_settings(use_empty=True)
ext = nombre.lower().split('.')[-1]
if ext == 'fbx': bpy.ops.import_scene.fbx(filepath=ruta)
elif ext == 'obj': bpy.ops.wm.obj_import(filepath=ruta)
else: bpy.ops.import_scene.gltf(filepath=ruta)
fallos = []
# El nombre original (prefijo SM_/SK_, espacios) se comprueba en el nodo Code de n8n: aquí llega el nombre interno
tris = 0
for o in bpy.data.objects:
    if o.type != 'MESH': continue
    o.data.calc_loop_triangles()
    tris += len(o.data.loop_triangles)
    if tuple(round(s, 3) for s in o.scale) != (1.0, 1.0, 1.0):
        fallos.append(f'{o.name}: escala sin aplicar {tuple(round(s,2) for s in o.scale)}')
    if max(abs(v) for v in o.location) > 0.01:
        fallos.append(f'{o.name}: no esta en el origen')
    if not o.data.uv_layers:
        fallos.append(f'{o.name}: sin coordenadas UV')
if tris > 15000: fallos.append(f'demasiados triangulos: {tris} (maximo 15000)')
for img in bpy.data.images:
    if max(img.size) > 2048: fallos.append(f'textura {img.name} de {img.size[0]}px (maximo 2048)')
json.dump({'archivo': nombre, 'triangulos': tris, 'fallos': fallos},
          open('/data/qa/resultado.json', 'w'))
```

## Cómo probarla
- Prepara tres archivos a propósito: uno correcto, uno con el nombre mal y uno con escala 2,2,2. Súbelos de uno en uno y comprueba que cada veredicto es el esperado.
- Ejecuta el script a mano en la terminal primero; si ahí no escribe el JSON, el flujo tampoco.
- Ajusta el límite de triángulos a tu proyecto antes de dejarlo suelto: 15.000 vale para props, no para personajes.

## Qué puede salir mal
- **Dos entregas a la vez**: ambas escriben en `resultado.json` y se pisan. Usa `/data/qa/{{ $execution.id }}.json` en vez de un nombre fijo, y pon Concurrency a 1.
- **Formatos raros**: .blend, .max o .ma no los cubre este script. Añade un IF que los mande directamente a revisión manual.
- **Falsos rechazos**: un personaje con esqueleto tendrá objetos fuera del origen. Haz dos variantes del script y elige según el prefijo (SM_ o SK_).
- **Artista desconocido**: Drive no siempre dice quién subió el archivo. Pide que el nombre incluya iniciales (`SM_silla_JG.fbx`) y sácalas con una expresión.
- **Nombres con comillas o `$( )`**: el nombre que sube el artista nunca entra en la ruta ni en el comando de Blender; en disco va el ID de Drive con la extensión validada y el nombre original solo se comprueba en el nodo Code.

## Cuánto cuesta
0 €: Blender y n8n auto-alojado son gratis, Drive y Slack tienen plan gratuito suficiente. El único coste sería un VPS si no quieres tener tu equipo encendido.
