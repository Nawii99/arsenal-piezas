# Turntables y miniaturas automáticas de tus modelos 3D…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Cuando dejas un .fbx u .obj en una carpeta, genera solo el vídeo giratorio, cuatro fotos de presentación y una ficha con polígonos y medidas.

## Qué es y qué hace

Flujo de n8n que vigila una carpeta de Google Drive y, al aparecer un .fbx, .obj o .glb, lo importa en una escena de Blender con luz de estudio, genera cuatro renders y un turntable de 3 segundos. Sube todo a una subcarpeta con el nombre del modelo y apunta en una hoja los polígonos, materiales y medidas. Entran el modelo y la escena base estudio.blend; sale el material visual para la ficha. Necesita n8n auto-alojado con Blender.

## Cómo usarla

1. 1. Prepara estudio.blend con HDRI y cámara
2. 2. Crea las carpetas entrada_modelos y catalogo
3. 3. Deja un modelo de prueba y revisa los renders

## Cuándo usarla

Úsalo cuando vendes o entregas modelos 3D y cada vez repites el mismo ritual de importar, poner luz, girar la cámara y exportar imágenes para la ficha del producto.

## Cómo ganar dinero con ella

Ahorra unos 20-30 minutos por modelo. Con 20 modelos al mes son 8 horas recuperadas y fichas de producto siempre iguales.

- Fichas visuales de modelos 3D para artistas que venden en Sketchfab o CGTrader y necesitan imágenes uniformes.
- Turntables y renders de catálogo para estudios que entregan lotes de props a clientes.
- Servicio de presentaciones 3D para agencias que publican productos en tiendas online.

**Precio orientativo:** 10–25 € por modelo. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una carpeta de Google Drive. Cuando aparece un modelo nuevo (.fbx, .obj o .glb), lo baja, lo mete en una escena de Blender preparada con luz de estudio, saca cuatro renders (frente, tres cuartos, cenital y detalle) y un turntable de 3 segundos, lo sube todo a una subcarpeta con el nombre del modelo y apunta en una hoja los polígonos, vértices, materiales y medidas en centímetros.
Para artistas que venden en Sketchfab, CGTrader o ArtStation y para estudios que entregan lotes de props a clientes.

## Lo que necesitas antes
- n8n auto-alojado con Blender instalado en la misma máquina (hace falta «Execute Command»).
- Una escena base de Blender llamada `estudio.blend` con: un HDRI de iluminación, una cámara ya apuntando al origen y un plano de suelo. La haces una vez y la reutilizas siempre.
- Carpeta de Drive «entrada_modelos» y carpeta «catalogo».
- Credenciales de Google Drive y Google Sheets.

## Los nodos, en orden
1. **Google Drive Trigger** — Evento «File Created», carpeta «entrada_modelos», comprobación cada minuto.
2. **IF** — `{{ $json.name.toLowerCase() }}` termina en `.fbx`, `.obj` o `.glb`. Si no, se descarta.
3. **Google Drive** («Download File») — Descarga el modelo.
4. **Code** (renómbralo «Nombre seguro») — Mode: Run Once for Each Item. Comprueba la extensión contra la lista permitida y el ID de Drive, y prepara el nombre interno `ID_de_Drive.extensión`. Ver código abajo.
5. **Read/Write Files from Disk** («Write») — Lo deja en `/data/modelos/{{ $('Nombre seguro').item.json.archivo }}`. En disco el archivo se llama con su ID de Drive, no con el nombre que trae.
6. **Execute Command** — Lanza Blender con el script Python de abajo pasándole la ruta interna: `blender -b /data/estudio.blend -P /data/scripts/fichar.py -- "/data/modelos/{{ $('Nombre seguro').item.json.archivo }}"`.
7. **Read/Write Files from Disk** («Read») — Lee el JSON de estadísticas que ha escrito el script: `/data/salida/{{ $('Nombre seguro').item.json.id }}.json`.
8. **Google Drive** («Create Folder») — Crea `catalogo/{{ $('Nombre seguro').item.json.nombre_modelo }}`. El nombre original solo se usa aquí, en Drive y en la hoja.
9. **Loop Over Items** + **Google Drive** («Upload File») — Sube uno por uno los 4 PNG y el MP4 de `/data/salida` que empiezan por `{{ $('Nombre seguro').item.json.id }}_`.
10. **Google Sheets** («Append Row») — Añade fila: nombre (`{{ $('Nombre seguro').item.json.nombre_modelo }}`), poligonos, vertices, materiales, alto_cm, ancho_cm, fondo_cm, enlace_carpeta, fecha.

## El código de «Nombre seguro»
```js
const f = $('Google Drive Trigger').item.json;
const nombre = String(f.name || '');
const ext = (nombre.toLowerCase().match(/\.(fbx|obj|glb)$/) || [])[1];
if (!ext) throw new Error('Formato no admitido: ' + nombre.slice(0, 80));
if (!/^[A-Za-z0-9_-]+$/.test(String(f.id || ''))) throw new Error('ID de Drive inesperado');
return { json: { id: f.id, archivo: `${f.id}.${ext}`, nombre_modelo: nombre.replace(/\.[^.]+$/, '') }, binary: $input.item.binary };
```

## El script de Blender
Guárdalo como `/data/scripts/fichar.py` y llámalo con: `blender -b /data/estudio.blend -P /data/scripts/fichar.py -- /data/modelos/ID_DE_DRIVE.fbx` (en el flujo, la ruta del paso 6). Como el archivo se llama con el ID, los PNG y el JSON salen como `ID_frente.png` e `ID.json`.
```python
import bpy, sys, json, os, math
ruta = sys.argv[sys.argv.index('--') + 1]
nombre = os.path.splitext(os.path.basename(ruta))[0]
ext = ruta.lower().split('.')[-1]
if ext == 'fbx': bpy.ops.import_scene.fbx(filepath=ruta)
elif ext == 'obj': bpy.ops.wm.obj_import(filepath=ruta)
else: bpy.ops.import_scene.gltf(filepath=ruta)
objs = [o for o in bpy.context.selected_objects if o.type == 'MESH']
tris = sum(len(o.data.loop_triangles) for o in objs)
for o in objs: o.data.calc_loop_triangles()
tris = sum(len(o.data.loop_triangles) for o in objs)
verts = sum(len(o.data.vertices) for o in objs)
mats = len({m.name for o in objs for m in o.data.materials if m})
dims = [max((o.dimensions[i] for o in objs), default=0) * 100 for i in range(3)]
cam = bpy.data.objects['Camera']
vacio = bpy.data.objects.new('pivote', None); bpy.context.collection.objects.link(vacio)
cam.parent = vacio
angulos = {'frente': 0, 'tres_cuartos': 45, 'lateral': 90, 'cenital': 180}
for etiqueta, grados in angulos.items():
    vacio.rotation_euler[2] = math.radians(grados)
    bpy.context.scene.render.filepath = f'/data/salida/{nombre}_{etiqueta}.png'
    bpy.ops.render.render(write_still=True)
stats = {'nombre': nombre, 'poligonos': tris, 'vertices': verts, 'materiales': mats,
         'alto_cm': round(dims[2], 1), 'ancho_cm': round(dims[0], 1), 'fondo_cm': round(dims[1], 1)}
open(f'/data/salida/{nombre}.json', 'w').write(json.dumps(stats))
```

## Cómo probarla
- Prueba el script a mano con un cubo exportado a .fbx. Debe dejarte 4 PNG y un JSON en `/data/salida`.
- Comprueba que las medidas en centímetros cuadran: si te salen números absurdos, el modelo viene con escala en metros o en pulgadas.
- Deja un solo archivo en la carpeta de Drive y mira que el flujo entero se completa antes de soltar un lote de 30.

## Qué puede salir mal
- **Escenas que no se limpian**: si no reinicias entre modelos, se acumulan objetos. Al ejecutar Blender siempre desde `estudio.blend` en modo `-b` cada ejecución arranca limpia.
- **Modelos gigantes**: un .fbx de 500 MB puede tumbar la memoria. Añade un IF que descarte archivos de más de 200 MB y te avise.
- **El Drive Trigger dispara antes de tiempo**: con archivos grandes, Drive avisa cuando la subida aún no ha terminado. Mete un nodo **Wait** de 30 segundos antes de descargar.
- **Nombres de archivo con trampa**: un modelo llamado `x$(id).fbx` o con comillas ejecutaría órdenes si su nombre entrase en la ruta o en el comando; por eso en disco y en Blender solo va el ID de Drive con la extensión validada, y el nombre original solo va a la carpeta de Drive y a la hoja.
- **Turntable**: para el MP4, añade en el script una animación de 90 fotogramas rotando el pivote y renderiza con `-a`; ocupa más tiempo, así que hazlo solo para los modelos que vayas a publicar.

## Cuánto cuesta
0 €: Blender, n8n auto-alojado, Drive y Sheets gratuitos. Solo pagas si tu Drive de 15 GB se llena (100 GB por 1,99 €/mes).
