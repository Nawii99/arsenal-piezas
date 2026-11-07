# Cola de renders en tu propio PC (granja casera)

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Deja los archivos .blend en una carpeta de Drive y tu ordenador los renderiza de uno en uno por la noche, sube el resultado y te avisa cuando termina.

## Qué es y qué hace

Flujo de n8n que vigila una carpeta de Google Drive, descarga cada archivo .blend nuevo y lo renderiza con Blender en modo consola, uno detrás de otro. Sube el resultado a Drive y envía un correo al terminar. Entran los .blend y los ajustes de render; sale el archivo renderizado y un aviso. Necesita n8n auto-alojado en el mismo ordenador donde está instalado Blender, porque usa comandos locales.

## Cómo usarla

1. 1. Instala n8n auto-alojado en el equipo con Blender
2. 2. Comprueba con blender --version que responde
3. 3. Crea las carpetas de Drive y deja la cola activa de noche

## Cuándo usarla

Úsalo cuando acumulas renders pesados, tu PC es el único que tienes y quieres aprovechar las horas muertas sin quedarte tú lanzando trabajos a mano.

## Cómo ganar dinero con ella

Convierte tu ordenador en una granja de render nocturna: aprovechas 8 horas gratis al día en vez de pagar servicios de render en la nube.

- Granja de render casera para freelancers 3D que quieren dejar la cola puesta al irse a dormir.
- Configuración de render nocturno para estudios de dos personas que reciben archivos de clientes por Drive.
- Mantenimiento de la cola y soporte remoto para artistas que quieren su PC trabajando de noche sin tocarlo.

**Precio orientativo:** 150–350 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una carpeta de Google Drive, se descarga cada archivo `.blend` que aparece y llama a Blender en modo consola para renderizarlo, uno detrás de otro.
Para el freelance de 3D o el estudio de dos personas que trabaja con Blender y quiere dejar la cola puesta al irse a dormir.

## Lo que necesitas antes
n8n **auto-alojado en el mismo ordenador que tiene Blender**. Esto no funciona con n8n Cloud, porque necesita ejecutar programas de tu máquina.
Blender instalado y accesible desde la consola. En Windows suele estar en `C:\Program Files\Blender Foundation\Blender 4.2\blender.exe`; en Linux basta con `blender`.
Comprueba que funciona: abre la consola y escribe `blender --version`. Si no responde, añade la carpeta de Blender al PATH del sistema.
Credenciales de Google Drive OAuth2 y de Gmail OAuth2 en n8n.
En Drive, crea dos carpetas: `render_pendiente` y `render_terminado`. Apunta sus IDs (el trozo largo de la URL cuando las abres).
En tu PC, crea las carpetas locales `C:\cola\entrada` y `C:\cola\salida`.
Importante: en la instalación de n8n activa la variable de entorno `NODES_EXCLUDE` vacía y asegúrate de que el nodo Execute Command está disponible (viene por defecto en auto-alojado).

## Los nodos, en orden
1) **Schedule Trigger** — `Custom (Cron)` con expresión `0 23 * * *` para que arranque a las 23:00.
2) **Google Drive** (operación `File/Folder > Search`) — carpeta `render_pendiente`, filtro por nombre que contenga `.blend`.
3) **Split In Batches** (renómbralo «Lote») — tamaño de lote `1`. Esto es la clave: renderiza de uno en uno y no funde el PC.
4) **Google Drive** (operación `Download`) — el archivo del lote actual.
5) **Read/Write Files from Disk** (operación `Write`) — ruta `C:\cola\entrada\{{ $('Lote').item.json.id }}.blend`, campo binario `data`. En disco el archivo se llama con su ID de Drive, no con el nombre que trae.
6) **Execute Command** — comando de render (ver abajo). En Settings del nodo sube el `Timeout` a 21600000 ms (6 horas) o desactívalo.
7) **Code** — comprueba que se ha generado algún fotograma y prepara el nombre de salida. El nombre original del `.blend` (`$('Lote').item.json.name`) solo se usa aquí, como nombre del archivo que se sube a Drive.
8) **Read/Write Files from Disk** (operación `Read`) — lee de `C:\cola\salida` los archivos que empiezan por `{{ $('Lote').item.json.id }}_`.
9) **Google Drive** (operación `Upload`) — a la carpeta `render_terminado`.
10) **Google Drive** (operación `Delete`) — borra el `.blend` de `render_pendiente` para que no se repita.
11) **Gmail** (operación `Send`) — asunto `Render terminado: {{ $('Lote').item.json.name }}` (tras el Delete, `$json` ya no trae el nombre).
12) Conecta la salida de Gmail de vuelta al **Split In Batches** para que coja el siguiente trabajo.

## El comando del nodo Execute Command
```bash
"C:\Program Files\Blender Foundation\Blender 4.2\blender.exe" -b --disable-autoexec "C:\cola\entrada\{{ $('Lote').item.json.id }}.blend" -o "C:\cola\salida\{{ $('Lote').item.json.id }}_####" -F PNG -x 1 -a
```
En Linux o Mac sería: `blender -b --disable-autoexec "/home/tu/cola/entrada/{{ $('Lote').item.json.id }}.blend" -o "/home/tu/cola/salida/{{ $('Lote').item.json.id }}_####" -F PNG -x 1 -a`
`-b` es sin interfaz, `--disable-autoexec` impide que se ejecuten los scripts de Python que lleve dentro el `.blend`, `-o` la ruta de salida, `-F PNG` el formato, `-x 1` añade la extensión y `-a` renderiza toda la animación. Para un solo fotograma cambia `-a` por `-f 1`.

## Cómo probarla
Prueba primero el comando a pelo en la consola con un `.blend` pequeño de 10 fotogramas a resolución baja. Si ahí funciona, funcionará en n8n.
Ejecuta el flujo con un solo archivo en la carpeta y mira la pestaña de salida del Execute Command: Blender escribe ahí todo su registro.
Comprueba que el archivo desaparece de `render_pendiente` al acabar; si no, el flujo se repetirá cada noche con el mismo trabajo.

## Qué puede salir mal
Rutas con espacios o con eñes: usa siempre comillas alrededor de la ruta y evita tildes en los nombres de archivo.
Texturas enlazadas que no encuentra: guarda el `.blend` con `Archivo > Datos externos > Empaquetar recursos` antes de subirlo.
Si el render tarda más que el timeout del nodo, n8n lo corta a medias. Sube el timeout y desactiva en n8n la limpieza automática de ejecuciones largas.
Dos ejecuciones solapadas saturan la memoria: por eso Split In Batches va a 1 y el flujo se realimenta al terminar cada trabajo.
Si el PC se apaga o se suspende no hay render: desactiva la suspensión automática en las opciones de energía.
Un nombre de archivo con comillas o símbolos (`a" & del ...`) ejecutaría órdenes en tu PC si entrase en el comando: por eso en disco y en el comando solo se usa el ID de Drive, y el nombre original va únicamente al archivo subido y al correo.
Un `.blend` puede llevar scripts de Python que se ejecutan al abrirlo si tu Blender tiene activada la ejecución automática: por eso el comando lleva `--disable-autoexec`.
Correo con el asunto vacío: tras el Delete `$json` ya no trae el nombre; por eso el asunto lo lee de «Lote».

## Cuánto cuesta
Blender es gratis, n8n auto-alojado es gratis, Drive gratis hasta 15 GB (los renders pesan, ojo).
Lo único que pagas es la luz. Un render nocturno de 8 horas con una gráfica de gama media ronda los 30-50 céntimos.
