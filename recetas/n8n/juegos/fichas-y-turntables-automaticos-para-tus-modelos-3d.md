# Fichas y turntables automáticos para tus modelos 3D…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Cada modelo nuevo se renderiza solo en un turntable de 360°, se saca una miniatura y se genera el texto de la ficha listo para publicar en Sketchfab, Fab o tu web.

## Qué es y qué hace

Detecta modelos nuevos en una carpeta, los coloca en una escena de Blender iluminada, renderiza 36 fotogramas girando la cámara y los junta en un MP4 con ffmpeg. Además genera una miniatura y redacta título, descripción, especificaciones y etiquetas en una hoja lista para pegar en Sketchfab o Fab. Entrada: modelo 3D; salida: vídeo, miniatura y ficha. Necesita n8n con Blender y ffmpeg en la misma máquina.

## Cómo usarla

1. Instalar Blender y ffmpeg junto a n8n
2. Preparar la escena plantilla
3. Probar con un modelo
4. Copiar la ficha generada al marketplace

## Cuándo usarla

Cuando vendas modelos 3D en marketplaces y se te acumulen los archivos sin publicar porque montar renders y escribir la ficha te lleva media tarde por modelo.

## Cómo ganar dinero con ella

Pasas de 30-45 minutos de renders y ficha por modelo a cero: con 15 modelos al mes recuperas unas 8 horas y publicas mucho antes.

- Preparar turntables y fichas para artistas que venden en marketplaces, cobrando por modelo.
- Ofrecer paquetes de presentación 3D a tiendas de props y mobiliario virtual.
- Montar el flujo para un estudio y formar a su equipo para revisar las fichas.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Detecta modelos nuevos en una carpeta, los mete en una escena de Blender ya iluminada, renderiza 36 fotogramas girando la cámara, los junta en un vídeo mp4 y saca además una miniatura cuadrada.
Después construye el texto de la ficha (título, descripción, especificaciones técnicas y etiquetas) y lo deja en una hoja de cálculo con los enlaces a los archivos, listo para copiar y pegar en el marketplace. Para artistas 3D que venden en Sketchfab, Fab, CGTrader o su propia web.

## Lo que necesitas antes
n8n auto-alojado con Blender y FFmpeg instalados en la misma máquina (`apt-get install -y blender ffmpeg`).
Una escena de Blender tuya guardada como `/data/plantillas/estudio.blend` con: un HDRI de estudio en el World, una cámara apuntando al origen, un suelo neutro y la salida configurada a 1000x1000 y motor EEVEE.
Cuenta de Google con Drive API y Sheets API activadas, credenciales OAuth pegadas en n8n.
Una hoja «Catálogo 3D» con columnas: fecha, nombre, triangulos, materiales, url_video, url_miniatura, titulo, descripcion, etiquetas, publicado.

## Los nodos, en orden
**Google Drive Trigger** — Event: File Created, carpeta «MODELOS-LISTOS», Poll: cada 15 minutos.
**Code** («Nombre seguro», modo «Run Once for Each Item») — `const ext = String($json.name).split('.').pop().toLowerCase(); if (!['fbx','obj','glb','gltf'].includes(ext) || !/^[A-Za-z0-9_-]+$/.test($json.id)) throw new Error('Formato no admitido: ' + $json.name); return { json: { ...$json, archivo: $json.id + '.' + ext } };`. En disco y en el comando solo se usa `archivo`.
**Google Drive** — Operation: Download, Binary Property: `data`.
**Read/Write Files from Disk** — Write File to Disk, path `/data/entrada/{{ $('Nombre seguro').item.json.archivo }}`.
**Execute Command** (déjale el nombre «Execute Command»: el Code de la ficha lo cita así) — `blender -b /data/plantillas/estudio.blend -P /data/scripts/turntable.py -- "/data/entrada/{{ $('Nombre seguro').item.json.archivo }}" "/data/salida"`. Timeout: 900 segundos.
**Execute Command** — `ffmpeg -y -framerate 24 -i /data/salida/frame_%04d.png -c:v libx264 -pix_fmt yuv420p -crf 20 /data/salida/turntable.mp4`
**Read/Write Files from Disk** — Read File from Disk, `/data/salida/turntable.mp4`, propiedad binaria `video`.
**Google Drive** — Operation: Upload, carpeta «RENDERS», Input Binary Field: `video`, nombre `{{ $('Google Drive Trigger').item.json.name.replace(/\.[^.]+$/, '') }}_turntable.mp4`.
**Google Drive** — Operation: Share, Permissions: Anyone with the link, Role: Reader (para tener URL pública).
Repite los dos últimos pasos para `/data/salida/frame_0001.png` como miniatura.
**Code** — genera el texto de la ficha (abajo).
**Google Sheets** — Append Row en «Catálogo 3D» con todos los campos y `publicado` = NO.

## El script de Blender (/data/scripts/turntable.py)
```python
import bpy, sys, math, os
ruta, salida = sys.argv[sys.argv.index('--')+1], sys.argv[sys.argv.index('--')+2]
ext = os.path.splitext(ruta)[1].lower()
if ext == '.fbx': bpy.ops.import_scene.fbx(filepath=ruta)
elif ext == '.obj': bpy.ops.wm.obj_import(filepath=ruta)
else: bpy.ops.import_scene.gltf(filepath=ruta)
objs = [o for o in bpy.context.selected_objects if o.type=='MESH']
bpy.ops.object.select_all(action='DESELECT')
pivote = bpy.data.objects.new('PIVOTE', None); bpy.context.scene.collection.objects.link(pivote)
for o in objs: o.parent = pivote
pivote.rotation_mode = 'XYZ'
for i in range(36):
    pivote.rotation_euler[2] = math.radians(i*10)
    bpy.context.scene.render.filepath = os.path.join(salida, 'frame_%04d' % (i+1))
    bpy.ops.render.render(write_still=True)
tris = sum(len(o.data.loop_triangles) for o in objs if o.data.calc_loop_triangles() is None or True)
print('DATOS' + str({'triangulos': tris, 'materiales': len(bpy.data.materials)}))
```

## El nodo Code de la ficha
```javascript
const nombre = $('Google Drive Trigger').item.json.name.replace(/\.[^.]+$/, '');
const bonito = nombre.replace(/[_-]+/g, ' ').replace(/\b\w/g, c => c.toUpperCase());
const tris = Number(($('Execute Command').item.json.stdout.match(/'triangulos': (\d+)/) || [0,0])[1]);
const etiquetas = bonito.toLowerCase().split(' ').filter(p => p.length > 3).concat(['lowpoly','pbr','gamready','blender']).join(', ');
return { json: {
  fecha: new Date().toISOString().slice(0,10),
  nombre: bonito,
  triangulos: tris,
  titulo: `${bonito} - Modelo 3D low poly con texturas PBR`,
  descripcion: `${bonito} listo para motor de videojuegos. ${tris} triángulos, UVs sin solapes y texturas PBR de 2048px (Base Color, Normal, Roughness, Metallic, AO). Incluye formatos FBX, OBJ y GLB. Escala real en metros y origen en la base del objeto. Probado en Unity y Unreal Engine.`,
  etiquetas,
  publicado: 'NO'
} };
```

## Cómo probarla
Abre a mano `estudio.blend`, importa un modelo y comprueba que la cámara lo encuadra: si no, ajusta la distancia de la cámara antes de automatizar nada.
Lanza el comando de Blender en terminal con un modelo pequeño y mira que aparezcan los 36 PNG en /data/salida.
Ejecuta el flujo entero con un solo archivo y abre el mp4 resultante antes de dejar el trigger activo.

## Qué puede salir mal
Modelos con escalas locas se salen del encuadre: añade en el script un ajuste de escala automático dividiendo por la dimensión máxima del objeto.
La carpeta de salida no se vacía entre modelos y se mezclan fotogramas: añade un **Execute Command** con `rm -f /data/salida/frame_*.png` antes del render.
Renders lentos si usas Cycles: usa EEVEE y 32 samples, la diferencia en un turntable de catálogo no se nota.
El enlace de Drive no es público hasta que ejecutas el paso de Share; sin él, el marketplace no verá la imagen.
Un modelo llamado `$(id).glb` o con comillas ejecutaría órdenes si su nombre entrara en el comando: en disco va como `ID-de-Drive.extensión` y el nombre original solo se usa para el texto de la ficha.
El vídeo subido se llamaba `undefined_turntable.mp4`: tras leer el archivo del disco, `$json` ya no trae el nombre, así que la subida lo toma de `$('Google Drive Trigger')`.

## Cuánto cuesta
Todo gratis salvo el servidor. Si tienes una máquina con GPU en casa, coste cero; si alquilas un VPS con GPU para renderizar rápido, unos 0,20-0,50 €/hora solo mientras renderiza.
Blender, FFmpeg y n8n auto-alojado: 0 €. APIs de Google: gratis en este volumen.
