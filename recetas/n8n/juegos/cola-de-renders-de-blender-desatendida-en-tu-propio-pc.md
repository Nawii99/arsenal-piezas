# Cola de renders de Blender desatendida en tu propio PC…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Apuntas los trabajos de render en una hoja de cálculo y tu ordenador los va renderizando uno a uno por la noche, sube el resultado a Drive y te avisa cuando termina.

## Qué es y qué hace

Lee una hoja con los ficheros .blend pendientes y lanza Blender en modo consola en tu propio equipo, uno detrás de otro. Sube los fotogramas a Drive y marca cada trabajo como hecho. Entrada: hoja de cola y archivos .blend; salida: renders en Drive y estado actualizado. Necesita n8n instalado en la misma máquina que Blender, porque ejecuta comandos locales.

## Cómo usarla

1. Instalar n8n y Blender en la misma máquina
2. Crear la hoja cola-render y las carpetas
3. Probar un render corto en modo consola
4. Programar la cola nocturna

## Cuándo usarla

Cuando tienes varias escenas de Blender pendientes de render y te toca estar delante para lanzar la siguiente cada vez que acaba una.

## Cómo ganar dinero con ella

Aprovecha las 8 horas muertas de la noche: en vez de 2 renders al día haces 6, sin pagar granja de render (una granja cobra fácil 0,05-0,20 € por minuto de render).

- Montar la cola de renders de un estudio pequeño, cobrando la configuración y un soporte mensual.
- Ofrecer renders nocturnos a arquitectos o diseñadores que no tienen granja de render.
- Enseñar a artistas 3D a automatizar sus lotes de render en su propio equipo.

**Precio orientativo:** 200–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee una hoja con los ficheros .blend pendientes, lanza Blender en modo consola uno detrás de otro en tu propio equipo, sube los fotogramas a Drive y marca el trabajo como hecho. Para artistas 3D y estudios pequeños que renderizan en local y quieren exprimir noches y fines de semana.

## Lo que necesitas antes
- **n8n auto-alojado en el mismo ordenador que renderiza** (esto es imprescindible: el nodo Execute Command corre donde está n8n). Instálalo con `npm install -g n8n` o con Docker montando la carpeta de proyectos como volumen.
- Blender instalado y accesible desde la terminal. En Windows suele ser `C:\\Program Files\\Blender Foundation\\Blender 4.2\\blender.exe`; en Linux/Mac, `blender`. Comprueba con `blender --version`.
- Una carpeta de proyectos, por ejemplo `/home/tu/render/proyectos` y otra de salida `/home/tu/render/salida`.
- Google Sheet `cola-render` con columnas: `id`, `nombre`, `ruta_blend`, `frame_inicio`, `frame_fin`, `motor`, `muestras`, `estado`, `salida_drive`, `minutos`.
- Credenciales de Google Sheets y Drive en n8n, y un bot de Telegram (ver `@BotFather`).

## Los nodos, en orden
1. **Schedule Trigger** — Cron Expression: `0 22 * * *` (arranca a las 22:00). Añade un segundo Schedule a las `0 7 * * 6` si quieres que también tire los sábados por la mañana.
2. **Google Sheets** (llamado `Leer cola`) — Operation: `Get Row(s)`. Filter: columna `estado` equals `pendiente`. Options > Return All: activado.
3. **Split In Batches** (en n8n reciente se llama **Loop Over Items**) — Batch Size: `1`. Esto es lo que hace que se renderice de uno en uno y no se te caiga el equipo.
4. **Google Sheets** (llamado `Marcar en curso`) — Operation: `Update Row`, Column to Match On: `id`, columna `estado` = `renderizando`.
5. **Execute Command** (llamado `Render`) — Command: `blender -b "{{ $json.ruta_blend }}" -E {{ $json.motor }} -o "/home/tu/render/salida/{{ $json.nombre }}/frame_####" -F PNG -s {{ $json.frame_inicio }} -e {{ $json.frame_fin }} -a`. En Settings del nodo pon Timeout alto (por ejemplo 21600000 ms = 6 h) y activa **Continue On Fail** para que un render roto no pare la cola.
6. **IF** (llamado `¿Ha ido bien?`) — Number, valor izquierdo `{{ $json.exitCode }}`, operación `equals`, valor `0`.
7. **Execute Command** (rama true, llamado `Empaquetar`) — Command: `cd /home/tu/render/salida && zip -r "{{ $('Loop Over Items').item.json.nombre }}.zip" "{{ $('Loop Over Items').item.json.nombre }}"`. En Windows usa `powershell Compress-Archive`.
8. **Read/Write Files from Disk** — Operation: `Read File(s) From Disk`, File(s) Selector: `/home/tu/render/salida/{{ $('Loop Over Items').item.json.nombre }}.zip`.
9. **Google Drive** — Operation: `Upload File`, carpeta `renders-terminados`, File Name: `{{ $('Loop Over Items').item.json.nombre }}.zip`.
10. **Google Sheets** (llamado `Marcar hecho`) — Update Row por `id`: `estado` = `hecho`, `salida_drive` = `{{ $json.webViewLink }}`.
11. **Telegram** — Send Message: `✅ Render terminado: {{ $('Loop Over Items').item.json.nombre }} ({{ $('Loop Over Items').item.json.frame_fin - $('Loop Over Items').item.json.frame_inicio + 1 }} frames)\n{{ $json.webViewLink }}`.
12. **Google Sheets** (rama false del IF) — `estado` = `error`, y un Telegram con `{{ $json.stderr.slice(-500) }}` para ver el motivo.
13. Conecta la última salida de vuelta a la entrada de **Loop Over Items** para que coja el siguiente trabajo.

## Truco extra: cambiar las muestras sin abrir Blender
Si quieres forzar el número de muestras desde la hoja, guarda este fichero como `/home/tu/render/ajustes.py` y añade `--python /home/tu/render/ajustes.py` al comando, pasando el valor por variable de entorno `MUESTRAS`.
```python
import bpy, os
muestras = int(os.environ.get('MUESTRAS', '128'))
bpy.context.scene.cycles.samples = muestras
bpy.context.scene.render.resolution_percentage = 100
```

## Cómo probarla
- Mete una sola fila con una escena tonta de 3 frames y ejecuta el flujo a mano a mediodía.
- Antes de nada, copia el comando del nodo Execute Command tal cual en tu terminal y comprueba que Blender arranca. El 90 % de los fallos son la ruta al ejecutable o espacios sin comillas.
- Mira que el `exitCode` es 0 y que aparecen los PNG en la carpeta de salida.

## Qué puede salir mal
- **Timeout de n8n**: por defecto corta a los 5 minutos. Súbelo en el nodo y también con la variable `EXECUTIONS_TIMEOUT=-1` en el entorno de n8n.
- **n8n en Docker no ve Blender**: dentro del contenedor no está instalado. O instalas n8n directamente en el sistema, o montas el binario y las carpetas como volúmenes.
- **Se te llena el disco**: 500 frames en PNG 4K son decenas de GB. Añade un Execute Command final que borre la carpeta original tras subir el zip.
- **El PC se duerme**: en Windows desactiva la suspensión (`powercfg /change standby-timeout-ac 0`); en Linux, `systemd-inhibit`.
- **Trabajos zombis**: si cortas la ejecución, alguna fila queda en `renderizando` para siempre. Añade al inicio un Google Sheets que devuelva a `pendiente` todo lo que lleve más de 12 h en ese estado.

## Cuánto cuesta
- Blender: **gratis**. n8n auto-alojado: **gratis**. Sheets y Drive: gratis hasta 15 GB, y ahí sí puedes necesitar los 1,99 €/mes de 100 GB si subes secuencias pesadas.
- El coste real es la luz: un PC con GPU tirando 8 horas son ~3 kWh, sobre 0,45 € por noche. Muy por debajo de cualquier granja.
