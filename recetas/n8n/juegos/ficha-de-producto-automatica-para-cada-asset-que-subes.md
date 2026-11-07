# Ficha de producto automática para cada asset que subes…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Cuando terminas un asset 3D, genera solo su descripción de venta, las etiquetas, el recuento de polígonos y las publicaciones para redes, y te lo deja todo listo para pegar en Gumroad o Fab.

## Qué es y qué hace

Al detectar un pack terminado en Drive, Blender extrae polígonos, materiales, tamaño de texturas y si hay UVs o esqueleto. Un modelo de lenguaje redacta la descripción comercial y las etiquetas, y todo se guarda en una base de Notion lista para copiar en Gumroad, Fab o Sketchfab. Entrada: archivo .blend o .glb; salida: ficha técnica y comercial. Necesita n8n en la máquina con Blender.

## Cómo usarla

1. Instalar Blender y n8n en la misma máquina
2. Crear la base de Notion con sus propiedades
3. Probar con un pack
4. Revisar la ficha antes de publicar

## Cuándo usarla

Cuando vendes modelos o packs 3D y cada vez que subes uno pierdes una hora escribiendo descripción, especificaciones y publicaciones.

## Cómo ganar dinero con ella

Una hora por asset. Si publicas 4 al mes, son 4 horas; y una ficha con especificaciones completas y etiquetas correctas vende bastante más que un «modelo de silla».

- Escribir fichas técnicas para artistas 3D que venden en marketplaces, cobrando por pack.
- Ofrecer a tiendas de assets un flujo que genera descripciones y especificaciones coherentes.
- Montar el catálogo en Notion para un estudio que publica packs cada mes.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Detecta un pack terminado en Drive, saca con Blender los datos técnicos reales (polígonos, materiales, tamaño de texturas, si tiene UVs y esqueleto), pide a un modelo de lenguaje la descripción comercial y las etiquetas, y lo guarda todo en una página de Notion lista para copiar en las tiendas. Para artistas 3D que venden en Gumroad, Fab, Sketchfab o ArtStation.

## Lo que necesitas antes
- **n8n auto-alojado en la máquina con Blender**, porque hay que ejecutar un script.
- Carpeta de Drive `assets-terminados` donde sueltas el `.blend` o el `.glb` de cada pack.
- Una base de datos en Notion llamada `Catálogo` con propiedades: `Nombre` (título), `Estado` (selección), `Polígonos` (número), `Materiales` (número), `Formatos` (multi-selección), `Descripción` (texto), `Etiquetas` (texto), `Post redes` (texto), `Precio sugerido` (número).
- Integración de Notion: `notion.so/my-integrations` > New integration > copia el Internal Integration Token, y en la base de datos > menú `...` > Connections > añade tu integración.
- Clave de OpenRouter u otro proveedor de modelos.

## Los nodos, en orden
1. **Google Drive Trigger** — carpeta `assets-terminados`, File Created, poll cada 30 minutos.
1b. **Code** (`Nombre seguro`, modo «Run Once for Each Item») — `const ext = String($json.name).split('.').pop().toLowerCase(); if (!['blend','glb'].includes(ext) || !/^[A-Za-z0-9_-]+$/.test($json.id)) throw new Error('Formato no admitido: ' + $json.name); return { json: { ...$json, archivo: $json.id + '.' + ext } };`. En disco y en el comando solo se usa `archivo`; el nombre original queda para el prompt.
2. **Google Drive** > **Read/Write Files from Disk** — descarga y guarda en `/datos/assets/{{ $('Nombre seguro').item.json.archivo }}`.
3. **Execute Command** (`Inspeccionar`) — Command: `ASSET="/datos/assets/{{ $('Nombre seguro').item.json.archivo }}" blender -b --python /datos/assets/inspeccionar.py`. El script imprime una línea JSON que empieza por `DATOS:`.
4. **Code** (`Extraer JSON`) — busca la línea `DATOS:` en el stdout y la parsea: `const linea = $input.first().json.stdout.split('\n').find(l => l.startsWith('DATOS:')); return [{ json: JSON.parse(linea.replace('DATOS:', '')) }];`
5. **HTTP Request** (`Redactar ficha`) — POST a `https://openrouter.ai/api/v1/chat/completions`. Body con el prompt: `Eres redactor de fichas de assets 3D. Con estos datos técnicos: {{ JSON.stringify($json) }} y el nombre del pack "{{ $('Google Drive Trigger').item.json.name }}", devuelve un JSON con las claves: descripcion (150-200 palabras en inglés, orientada a compradores de Unity y Unreal, mencionando polígonos, texturas PBR y usos típicos), descripcion_es (la versión en español de España), etiquetas (20 etiquetas separadas por comas, en inglés, sin almohadilla), post_x (un tuit de menos de 240 caracteres), precio_sugerido (número en euros, coherente con packs similares). Responde solo el JSON, sin texto alrededor.` Añade `"response_format": {"type": "json_object"}` si tu modelo lo admite.
6. **Code** (`Parsear respuesta`) — `const txt = $input.first().json.choices[0].message.content.replace(/```json|```/g, '').trim(); return [{ json: JSON.parse(txt) }];`
7. **Notion** — Resource: `Database Page`, Operation: `Create`. Database: `Catálogo`. Rellena cada propiedad con las expresiones correspondientes y pon `Estado` = `Listo para publicar`.
8. **Telegram / Slack** — aviso con el enlace a la página de Notion para que la revises antes de publicar.

## El script `inspeccionar.py`
```python
import bpy, os, json
ruta = os.environ.get('ASSET')
if ruta.lower().endswith('.blend'):
    bpy.ops.wm.open_mainfile(filepath=ruta)
else:
    bpy.ops.wm.read_factory_settings(use_empty=True)
    bpy.ops.import_scene.gltf(filepath=ruta)
tris = 0
objetos = 0
tiene_uv = True
tiene_hueso = False
for o in bpy.data.objects:
    if o.type == 'MESH':
        objetos += 1
        m = o.to_mesh()
        m.calc_loop_triangles()
        tris += len(m.loop_triangles)
        if not o.data.uv_layers:
            tiene_uv = False
        o.to_mesh_clear()
    if o.type == 'ARMATURE':
        tiene_hueso = True
texturas = sorted({str(max(i.size[0], i.size[1])) for i in bpy.data.images if i.size[0] > 0})
datos = {
    'triangulos': tris,
    'objetos': objetos,
    'materiales': len(bpy.data.materials),
    'texturas_px': texturas,
    'uvs_completas': tiene_uv,
    'rigged': tiene_hueso,
    'animaciones': len(bpy.data.actions)
}
print('DATOS:' + json.dumps(datos))
```

## Cómo probarla
- Ejecuta el script a mano sobre un .blend tuyo y comprueba que el recuento de triángulos coincide con el que ves en la barra de estadísticas de Blender. Si no cuadra, suele ser por modificadores: `to_mesh()` los aplica, la estadística de la interfaz también, pero el modo objeto sin evaluar no.
- Lee la primera descripción con ojo crítico: si el modelo dice «4K PBR textures» y tú has exportado a 2K, corrige el prompt para que use solo los datos que le das y no invente.
- Publica la primera ficha a mano en la tienda y compara la conversión con las anteriores.

## Qué puede salir mal
- **El modelo se inventa características**: es lo típico. En el prompt insiste en «usa exclusivamente los datos técnicos proporcionados; si un dato no está, no lo menciones».
- **JSON mal formado**: los modelos a veces envuelven la respuesta en bloques de código. El Code del paso 6 ya los limpia; si aun así falla, activa Continue On Fail y manda el texto crudo a Notion para arreglarlo tú.
- **Etiquetas prohibidas**: cada tienda tiene sus normas (Fab limita el número, Sketchfab no acepta ciertas palabras). Revisa antes de pegar.
- **Blender abre el .blend con scripts**: si el fichero venía de fuera, `open_mainfile` puede ejecutar código embebido. Usa solo ficheros tuyos, o añade `use_scripts=False`.
- **Nombres con trampa**: un pack llamado `$(id).glb` o con comillas ejecutaría órdenes si su nombre entrara en el comando. En disco se guarda como `ID-de-Drive.extensión` y el nombre original solo va al prompt y a Notion.
- **Descripción demasiado genérica**: si todos tus packs suenan igual, añade al prompt tres ejemplos de fichas tuyas que funcionen bien; el resultado mejora muchísimo.

## Cuánto cuesta
- Blender, n8n auto-alojado y Drive: **gratis**.
- Notion: gratis para uso personal.
- Modelo de lenguaje: unos céntimos por ficha con un modelo pequeño; menos de 1 € al mes si publicas 20 assets.
