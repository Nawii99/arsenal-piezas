# Turntable 360 automático de cada modelo nuevo para rede…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Cada modelo que terminas se convierte solo en un vídeo giratorio de 8 segundos con fondo de estudio, listo para Instagram, ArtStation o tu tienda.

## Qué es y qué hace

Cada modelo 3D nuevo (.fbx, .obj o .glb) que entra en una carpeta se importa en una escena de Blender con luz de estudio, se renderizan 120 fotogramas girando la cámara y ffmpeg los une en un MP4 que se publica. Entrada: modelo 3D; salida: vídeo de 8 segundos. Necesita n8n en la máquina donde están Blender y ffmpeg.

## Cómo usarla

1. Instalar Blender y ffmpeg en la máquina de n8n
2. Preparar la escena base.blend
3. Probar con un modelo
4. Conectar el canal de Discord o la carpeta de Drive

## Cuándo usarla

Cuando publicas modelos con frecuencia y siempre acabas sin vídeo de presentación porque montarlo a mano te lleva media hora por pieza.

## Cómo ganar dinero con ella

30 minutos por pieza convertidos en cero; y un turntable decente multiplica las visitas de una ficha de asset frente a una captura estática.

- Hacer turntables de catálogo para tiendas de props y assets 3D, cobrando por modelo renderizado.
- Ofrecer vídeos de presentación de producto a fabricantes pequeños que necesitan contenido para redes.
- Montar la escena base y el flujo para un artista 3D y cobrar por la configuración.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Detecta modelos nuevos (.fbx, .obj o .glb) en una carpeta, los importa en una escena de Blender preparada con luz de estudio, renderiza 120 fotogramas girando la cámara, los junta en MP4 con ffmpeg y publica el vídeo. Para artistas de props y personajes que venden o enseñan trabajo constantemente.

## Lo que necesitas antes
- **n8n auto-alojado en la máquina con Blender** y ffmpeg instalado (`ffmpeg -version` debe responder).
- Una escena base de Blender guardada como `/datos/turntable/base.blend`: cámara apuntando al origen, un HDRI en el World, suelo neutro y motor EEVEE con resolución 1080x1080. Esto lo montas una vez a mano, 20 minutos.
- Carpeta local `/datos/turntable/entrada` y `/datos/turntable/frames`.
- Carpeta de Drive `modelos-terminados` (entrada) y `turntables` (salida).
- Webhook de Discord del canal donde enseñas trabajo.

## Los nodos, en orden
1. **Google Drive Trigger** — carpeta `modelos-terminados`, File Created, poll cada 15 minutos.
2. **Google Drive** > **Read/Write Files from Disk** — descargar y escribir en `/datos/turntable/entrada/{{ $json.name }}` (igual que en cualquier flujo de ficheros).
3. **Execute Command** (`Renderizar giro`) — Command: `MODELO="/datos/turntable/entrada/{{ $('Google Drive Trigger').item.json.name }}" blender -b /datos/turntable/base.blend --python /datos/turntable/turntable.py -o /datos/turntable/frames/f_#### -F PNG -s 1 -e 120 -a`. Timeout: 1800000 ms.
4. **Execute Command** (`Montar vídeo`) — Command: `ffmpeg -y -framerate 30 -i /datos/turntable/frames/f_%04d.png -c:v libx264 -pix_fmt yuv420p -crf 20 -vf "scale=1080:1080" /datos/turntable/{{ $('Google Drive Trigger').item.json.name }}.mp4 && rm -f /datos/turntable/frames/*.png`.
5. **Read/Write Files from Disk** — leer el MP4 generado.
6. **Google Drive** — subir a la carpeta `turntables`, y en Options activa el permiso de lectura para cualquiera con el enlace si quieres compartirlo.
7. **HTTP Request** (`Discord`) — POST al webhook, Body Content Type: `Form-Data` (n8n: `multipart-form-data`), campo `file` = el binario del MP4 y campo `payload_json` = `{"content":"Nuevo modelo terminado: {{ $('Google Drive Trigger').item.json.name }}"}`. Discord acepta hasta 8 MB en servidores sin boost, por eso el CRF 20.
8. **Google Sheets** (opcional) — registra fecha, modelo y enlace para llevar tu catálogo.

## El script `turntable.py`
```python
import bpy, os, math
ruta = os.environ.get('MODELO')
ext = ruta.lower().split('.')[-1]
if ext == 'fbx':
    bpy.ops.import_scene.fbx(filepath=ruta)
elif ext == 'obj':
    bpy.ops.wm.obj_import(filepath=ruta)
else:
    bpy.ops.import_scene.gltf(filepath=ruta)
objetos = [o for o in bpy.context.selected_objects if o.type == 'MESH']
if not objetos:
    objetos = [o for o in bpy.data.objects if o.type == 'MESH']
for o in objetos:
    o.select_set(True)
bpy.context.view_layer.objects.active = objetos[0]
bpy.ops.object.join() if len(objetos) > 1 else None
obj = bpy.context.view_layer.objects.active
obj.location = (0, 0, 0)
dim = max(obj.dimensions)
if dim > 0:
    escala = 2.0 / dim
    obj.scale = (escala, escala, escala)
bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
obj.rotation_mode = 'XYZ'
obj.rotation_euler = (0, 0, 0)
obj.keyframe_insert(data_path='rotation_euler', frame=1)
obj.rotation_euler = (0, 0, math.radians(360))
obj.keyframe_insert(data_path='rotation_euler', frame=121)
for fc in obj.animation_data.action.fcurves:
    for kp in fc.keyframe_points:
        kp.interpolation = 'LINEAR'
bpy.context.scene.frame_start = 1
bpy.context.scene.frame_end = 120
```

## Cómo probarla
- Ejecuta el comando de Blender a mano con un FBX cualquiera y abre uno de los PNG: si el modelo sale gigante o fuera de plano, ajusta la distancia de la cámara en `base.blend`, no el script.
- Prueba con los tres formatos, porque el importador de OBJ cambió de nombre en Blender 4.x (`wm.obj_import`); en 3.x era `import_scene.obj`.
- Mira el MP4 completo antes de conectar Discord: comprueba que el giro es continuo y no da un salto al cerrar el bucle (por eso el último keyframe está en 121 y no en 120).

## Qué puede salir mal
- **Materiales que no vienen**: los FBX con texturas enlazadas fuera del fichero llegan en gris. Exporta siempre en GLB con texturas embebidas, o añade al script una asignación de material neutro.
- **Modelos descentrados**: si el origen del objeto no está en el centro geométrico, el giro sale excéntrico. Añade `bpy.ops.object.origin_set(type='ORIGIN_GEOMETRY')` antes de mover a (0,0,0).
- **Vídeo demasiado pesado para Discord**: sube el CRF a 26 o baja a 720x720.
- **Frames viejos mezclados**: el `rm` va al final del comando de ffmpeg; si el render falla, quedan PNG de la vez anterior. Añade un `rm -f` también al principio del paso 3.

## Cuánto cuesta
- Blender, ffmpeg y n8n auto-alojado: **gratis**.
- Discord y Drive: gratis.
- Un turntable EEVEE de 120 frames a 1080x1080 tarda 2-5 minutos en una GPU normal: lo único que pagas es luz.
