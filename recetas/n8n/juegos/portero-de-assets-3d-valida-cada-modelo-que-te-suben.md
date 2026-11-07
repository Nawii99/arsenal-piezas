# Portero de assets 3D: valida cada modelo que te suben…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Cada vez que un artista sube un .fbx, .obj o .blend a una carpeta de Drive, Blender lo abre solo, cuenta polígonos, materiales y texturas, y te dice si cumple tus normas.

## Qué es y qué hace

Cada modelo .fbx, .obj o .blend que sube un colaborador a Drive se abre con Blender en modo consola para contar polígonos, materiales, texturas, escala y transformaciones sin aplicar. Entrada: archivo 3D; salida: fila en una hoja y un correo con el aprobado o la lista exacta de fallos. Necesita n8n auto-alojado con Blender instalado en la misma máquina.

## Cómo usarla

1. Instalar n8n auto-alojado y Blender
2. Definir tus normas de polígonos y texturas
3. Probar con dos modelos
4. Activar el vigilante de la carpeta

## Cuándo usarla

Úsalo cuando trabajes con más de un artista o subcontrates modelado y estés cansado de abrir cada archivo a mano para descubrir que trae 900.000 polígonos y texturas de 8K.

## Cómo ganar dinero con ella

Ahorra entre 10 y 20 minutos por asset revisado y evita rehacer trabajo por normas incumplidas; con 40 assets al mes son unas 10 horas.

- Auditar entregas de modelado de colaboradores externos antes de pagarlas.
- Vender el control de calidad de assets a estudios que subcontratan modelado.
- Montar un checklist técnico de entrega para una agencia de 3D.

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una carpeta de Google Drive y, cuando aparece un modelo 3D nuevo, lo descarga y lo abre con Blender en modo consola (sin interfaz) para contar polígonos, materiales, texturas, escala y si hay transformaciones sin aplicar.
Apunta el resultado en una hoja de cálculo y manda un correo al artista con el aprobado o la lista exacta de fallos; está pensado para estudios indie y freelances 3D que reciben trabajo de colaboradores externos.

## Lo que necesitas antes
n8n **auto-alojado** (en tu ordenador con Docker o en un VPS de 5-6 €/mes): el nodo «Execute Command» no existe en n8n Cloud, y aquí es imprescindible.
Blender instalado en la misma máquina que n8n. Si usas Docker, monta una imagen que incluya Blender o instálalo dentro del contenedor con `apt-get install -y blender`. Comprueba que responde con `blender --version`.
Cuenta de Google. En Google Cloud Console creas un proyecto, activas «Google Drive API» y «Google Sheets API», creas credenciales OAuth de tipo «Aplicación web» y pegas el «Redirect URL» que te da n8n en la pantalla de credenciales.
Una carpeta de Drive llamada «01-ENTRADA-ASSETS» y una hoja de cálculo «Control assets» con estas columnas en la fila 1: fecha, archivo, artista, poligonos, materiales, texturas, escala_ok, veredicto, motivos.
Un archivo de texto con tus normas decidido de antemano: por ejemplo máximo 30.000 triángulos, máximo 4 materiales, texturas de 2048 px, escala 1.0 y origen en el suelo.

## Los nodos, en orden
**Google Drive Trigger** — Resource: File, Event: «File Created», Folder: 01-ENTRADA-ASSETS, Poll Times: cada 5 minutos. Devuelve el id y el nombre del archivo.
**IF** — Condición String → «Operation: Regex Match» sobre `{{$json.name}}` con el patrón `\.(fbx|obj|glb|blend)$`. La rama false no hace nada (así ignoras readme y capturas).
**Code** («Nombre seguro», modo «Run Once for Each Item») — `const ext = String($json.name).split('.').pop().toLowerCase(); if (!['fbx','obj','glb','blend'].includes(ext) || !/^[A-Za-z0-9_-]+$/.test($json.id)) throw new Error('Formato no admitido: ' + $json.name); return { json: { ...$json, archivo: $json.id + '.' + ext } };`. En disco y en el comando solo se usa `archivo`.
**Google Drive** — Resource: File, Operation: Download, File ID: `{{$json.id}}`. En Options activa «Binary Property» con nombre `data`.
**Read/Write Files from Disk** — Operation: Write File to Disk, File Path: `/data/assets/{{ $('Nombre seguro').item.json.archivo }}`, Input Binary Field: `data`.
**Execute Command** — Command: `blender -b -P /data/scripts/validar.py -- "/data/assets/{{ $('Nombre seguro').item.json.archivo }}"`. Marca «Execute Once» desactivado.
**Code** — modo «Run Once for Each Item», recoge la salida de la consola y saca el JSON (código completo más abajo).
**Google Sheets** — Operation: Append Row, documento «Control assets», hoja «Hoja 1», mapeo manual de cada columna con los campos del Code.
**IF** — Boolean: `{{$json.veredicto}}` igual a `RECHAZADO`.
**Gmail** (rama true) — Operation: Send, To: correo del artista (o `{{$json.artista}}` si lo sacas del nombre del archivo), Subject: `Revisión de {{$json.archivo}}: hay que corregir`, Message: `{{$json.motivos}}`.
**Google Drive** (rama false) — Operation: Move File, a la carpeta «02-APROBADOS».

## El script de Blender (guárdalo como /data/scripts/validar.py)
```python
import bpy, sys, json, os
ruta = sys.argv[sys.argv.index('--') + 1]
ext = os.path.splitext(ruta)[1].lower()
bpy.ops.wm.read_factory_settings(use_empty=True)
if ext == '.blend': bpy.ops.wm.open_mainfile(filepath=ruta)
elif ext == '.fbx': bpy.ops.import_scene.fbx(filepath=ruta)
elif ext == '.obj': bpy.ops.wm.obj_import(filepath=ruta)
else: bpy.ops.import_scene.gltf(filepath=ruta)
tris = 0; mats = set(); escala_ok = True
for ob in bpy.data.objects:
    if ob.type != 'MESH': continue
    m = ob.evaluated_get(bpy.context.evaluated_depsgraph_get()).to_mesh()
    m.calc_loop_triangles(); tris += len(m.loop_triangles)
    for s in ob.material_slots:
        if s.material: mats.add(s.material.name)
    if tuple(round(v,3) for v in ob.scale) != (1.0,1.0,1.0): escala_ok = False
texs = [i.size[0] for i in bpy.data.images if i.size[0] > 0]
print('RESULTADO_JSON' + json.dumps({'triangulos': tris, 'materiales': len(mats), 'texturas': len(texs), 'tex_max': max(texs) if texs else 0, 'escala_ok': escala_ok}))
```

## El nodo Code
```javascript
const salida = $json.stdout || '';
const trozo = salida.split('RESULTADO_JSON')[1];
if (!trozo) { return { json: { veredicto: 'ERROR', motivos: 'Blender no pudo abrir el archivo', archivo: $('Google Drive Trigger').item.json.name } }; }
const d = JSON.parse(trozo.trim().split('\n')[0]);
const motivos = [];
if (d.triangulos > 30000) motivos.push(`Demasiados triángulos: ${d.triangulos} (máximo 30.000)`);
if (d.materiales > 4) motivos.push(`Demasiados materiales: ${d.materiales} (máximo 4)`);
if (d.tex_max > 2048) motivos.push(`Textura de ${d.tex_max}px (máximo 2048)`);
if (!d.escala_ok) motivos.push('Hay objetos con la escala sin aplicar (Ctrl+A)');
return { json: { fecha: new Date().toISOString().slice(0,10), archivo: $('Google Drive Trigger').item.json.name, poligonos: d.triangulos, materiales: d.materiales, texturas: d.texturas, escala_ok: d.escala_ok, veredicto: motivos.length ? 'RECHAZADO' : 'APROBADO', motivos: motivos.join(' | ') } };
```

## Cómo probarla
Primero lanza el comando a mano en la terminal del servidor con un .fbx cualquiera y comprueba que sale la línea `RESULTADO_JSON{...}`. Si no sale, el problema es Blender, no n8n.
En n8n, usa «Execute Workflow» con el trigger en modo test y sube un archivo a la carpeta. Revisa la salida de cada nodo pinchando en él.
Prueba adrede con un modelo malo (una esfera con 3 subdivisiones y una textura de 4K) y confirma que llega el correo de rechazo.
Déjalo activo solo cuando hayas visto tres archivos seguidos pasar bien.

## Qué puede salir mal
Blender tarda mucho con escenas pesadas: sube el «Timeout» del nodo Execute Command a 300 segundos en sus Settings.
El disparador de Drive puede repetir un archivo si la subida es lenta. Añade un nodo **Remove Duplicates** con «Keep Items Where: Value Is New» sobre `{{$json.id}}`.
Los .fbx exportados de Maya a veces traen unidades en centímetros y la escala saldrá siempre mal: ajusta el umbral en el script o aplica un factor conocido.
Si n8n corre en Docker, la carpeta `/data` tiene que estar montada como volumen o los archivos desaparecen entre nodos.
Un archivo llamado `$(id).glb` o con comillas ejecutaría órdenes si su nombre entrara en el comando: por eso en disco va como `ID-de-Drive.extensión` y el nombre original solo se apunta en la hoja y el correo.

## Cuánto cuesta
Blender es gratis. n8n auto-alojado es gratis, solo pagas el servidor (5-6 €/mes en Hetzner o similar, o 0 € si lo dejas en tu propio PC).
Las APIs de Google Drive y Sheets son gratuitas en el uso normal de un estudio pequeño.
Si prefieres no montar servidor, esta receta no se puede hacer en Zapier ni Make: necesitan ejecutar Blender y eso solo lo permite un n8n propio.
