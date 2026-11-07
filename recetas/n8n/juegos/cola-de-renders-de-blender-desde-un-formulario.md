# Cola de renders de Blender desde un formulario…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Mandas un archivo .blend y unos ajustes por un formulario, y tu ordenador o servidor lo renderiza solo y te avisa cuando está listo.

## Qué es y qué hace

Flujo de n8n con un formulario web donde se sube un archivo .blend y se eligen fotograma, resolución y motor. Guarda el archivo, lanza Blender en modo consola sin interfaz, sube el resultado a Google Drive y avisa por Telegram al terminar. Entran el .blend y los ajustes; sale el render y su enlace. Requiere n8n auto-alojado en el equipo con Blender instalado, porque usa el nodo Execute Command.

## Cómo usarla

1. 1. Instala n8n con Docker en el equipo con Blender
2. 2. Comprueba blender --version y crea el bot de Telegram
3. 3. Prueba con un render pequeño antes de abrir el formulario

## Cuándo usarla

Úsalo cuando renderizas seguido y pierdes tiempo abriendo Blender, poniendo la ruta y esperando delante de la pantalla, o cuando quieres que un cliente encargue renders sin tocar tu equipo.

## Cómo ganar dinero con ella

Convierte una tarea manual de 15 minutos por render en un envío de 30 segundos y permite encadenar trabajos de noche sin supervisión.

- Cola de render para estudios pequeños que aceptan encargos y quieren que el cliente dispare el render sin tocar el equipo.
- Servicio de render nocturno para freelancers 3D que cobran por render y necesitan un PC siempre disponible.
- Formulario de encargos de render para artistas que venden escenas y animaciones a sus clientes.

**Precio orientativo:** 150–350 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Levanta un formulario web donde subes un archivo .blend y eliges fotograma, resolución y motor. n8n guarda el archivo, lanza Blender en modo consola (sin interfaz), sube el resultado a Google Drive y te manda el enlace por Telegram cuando termina.
Para artistas 3D y estudios pequeños con un PC potente que quieren usarlo como granja de render casera, y para quien acepta encargos y quiere que el cliente dispare el render.

## Lo que necesitas antes
- **n8n auto-alojado** (esto NO funciona en n8n Cloud, porque hace falta el nodo «Execute Command»). Instálalo con Docker en el mismo equipo donde esté Blender, o instala n8n con npm directamente en la máquina.
- Blender instalado y accesible desde consola. En Windows la ruta suele ser `C:\Program Files\Blender Foundation\Blender 4.2\blender.exe`; en Linux, `/usr/bin/blender`. Compruébalo con `blender --version`.
- Carpeta de trabajo con permisos de escritura, por ejemplo `/data/renders`.
- Credencial de Google Drive (OAuth desde Google Cloud Console, habilitando «Google Drive API»).
- Un bot de Telegram: escribe a @BotFather, `/newbot`, copia el token; y saca tu chat_id escribiendo a @userinfobot.

## Los nodos, en orden
1. **Form Trigger** (n8n Form) — Campos: «archivo» (tipo File), «fotograma» (número, por defecto 1), «ancho» (por defecto 1920), «alto» (1080), «muestras» (128), «email_aviso» (opcional).
2. **Read/Write Files from Disk** (operación «Write») — Guarda el .blend recibido en `/data/renders/entrada/{{ $execution.id }}.blend`.
3. **Code** (renómbralo «Validar fotograma») — Mode: Run Once for Each Item. Convierte «fotograma» en número entero y para el flujo si no lo es (código abajo). Es el único dato del formulario que entra en el comando.
4. **Execute Command** — El comando de render (abajo, entero).
5. **IF** — Comprueba `{{ $json.exitCode }}` igual a `0`. Si no, salta a la rama de error.
6. **Read/Write Files from Disk** (operación «Read») — Lee `/data/renders/salida/{{ $execution.id }}_{{ String($('Validar fotograma').item.json.fotograma).padStart(4, '0') }}.png` como binario.
7. **Google Drive** («Upload File») — Sube el PNG a una carpeta «Renders» privada. No actives «Anyone with the link»: el render es trabajo de un cliente y no debe quedar público. Si el formulario trae `email_aviso`, añade un nodo **Google Drive** (Operation: Share) con Role `reader`, Type `user` y Email Address ese correo, para que solo esa persona lo abra; sin correo, el archivo queda solo para ti.
8. **Telegram** («Send Message») — `✅ Render listo ({{ $('Form Trigger').item.json.ancho }}x{{ $('Form Trigger').item.json.alto }}): {{ $json.webViewLink }}`.
9. **Telegram** (rama de error) — `❌ El render ha fallado. Salida: {{ $json.stderr }}`.

## El código de «Validar fotograma»
```js
const n = Number($('Form Trigger').item.json.fotograma);
if (!Number.isInteger(n) || n < 0 || n > 1048574) throw new Error('Fotograma no válido');
return { json: { fotograma: n } };
```

## El comando del nodo Execute Command
```bash
blender -b --disable-autoexec "/data/renders/entrada/{{ $execution.id }}.blend" \
  -o "/data/renders/salida/{{ $execution.id }}_" \
  -F PNG \
  -f {{ $('Validar fotograma').item.json.fotograma }} \
  -- --cycles-device CUDA
```
Si quieres forzar resolución y muestras sin tocar el archivo, añade un script Python de Blender con `-P /data/renders/ajustes.py` que contenga:
```python
import bpy, sys
e = bpy.context.scene
e.render.resolution_x = 1920
e.render.resolution_y = 1080
e.cycles.samples = 128
```

## Cómo probarla
- Primero prueba el comando en una terminal normal con un .blend de ejemplo. Si ahí no funciona, en n8n tampoco.
- Si n8n corre en Docker, el contenedor NO ve tu Blender del sistema: monta el volumen (`-v /data/renders:/data/renders`) e instala Blender dentro del contenedor, o instala n8n sin Docker.
- Sube una escena minúscula (un cubo) para validar todo el circuito antes de mandar la escena de verdad.

## Qué puede salir mal
- **Rutas con espacios**: pon siempre comillas alrededor de las rutas en el comando.
- **Timeout**: un render largo puede pasar del límite por defecto. En «Settings» del workflow sube «Execution Timeout» a 7200 segundos.
- **Nombre del archivo de salida**: Blender añade el número de fotograma con ceros (`_0001.png`). Si renderizas el fotograma 250 será `_0250.png`; por eso la lectura del paso 6 rellena con ceros el fotograma validado.
- **GPU**: si el servidor no tiene tarjeta gráfica, quita `--cycles-device CUDA` o tardará una eternidad.
- **Dos renders a la vez**: pon en Settings «Concurrency» a 1 para que no se peleen por la GPU.
- **Datos del formulario dentro del comando**: quien rellena el formulario puede mandar cualquier texto aunque el campo sea numérico; por eso el .blend se guarda con el ID de ejecución y «fotograma» pasa antes por «Validar fotograma».
- **Un .blend con scripts dentro**: el archivo lo sube otra persona y puede llevar Python que se ejecuta al abrirlo si Blender tiene activada la ejecución automática; `--disable-autoexec` lo impide.

## Cuánto cuesta
Gratis: Blender es libre, n8n auto-alojado es gratis, Drive gratis hasta 15 GB y Telegram gratis. El único coste real es la luz de tu equipo o el VPS con GPU si lo alquilas (desde unos 0,30 €/hora y solo mientras renderiza).
