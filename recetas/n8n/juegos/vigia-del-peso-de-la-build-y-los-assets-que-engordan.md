# Vigía del peso de la build y los assets que engordan…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Después de cada compilación mide cuánto ocupa la build y qué archivos son los más pesados, lo compara con la anterior y avisa si ha engordado de golpe.

## Qué es y qué hace

Flujo de n8n que, tras cada compilación, mide el tamaño total de la carpeta de la build, saca los 20 archivos más grandes y lo compara con la medición anterior guardada en Google Sheets. Entra la ruta de la carpeta compilada; sale una fila con el peso, la variación y un aviso en Discord si ha crecido de golpe. Necesita n8n auto-alojado en la misma máquina donde se compila, para leer el disco.

## Cómo usarla

1. 1. Instala n8n en la máquina de compilación
2. 2. Indica la ruta de tu carpeta de builds
3. 3. Ajusta el umbral de aviso en MB tras la primera semana

## Cuándo usarla

Úsalo cuando tu juego crece sin control, la descarga ya asusta a los jugadores y no sabes qué versión metió los 400 MB de más.

## Cómo ganar dinero con ella

Detectar hoy una textura sin comprimir de 300 MB cuesta cinco minutos; descubrirla tres meses después obliga a rehacer medio pipeline de assets.

- Control de peso de builds para estudios que temen que la descarga pase de los 2 GB sin que nadie lo note.
- Auditoría de assets pesados para equipos de arte que reciben texturas sin comprimir de freelancers.
- Medición semanal de peso para proyectos con compilación frecuente y varios desarrolladores.

**Precio orientativo:** 150–350 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recorre la carpeta de la build compilada, suma el tamaño total, saca los 20 archivos más grandes y compara con la medición anterior guardada en una hoja.
Para el equipo que compila varias veces por semana y quiere que el peso sea un dato visible, no una sorpresa el día del lanzamiento.

## Lo que necesitas antes
n8n **auto-alojado en la máquina donde se compila** (necesitas leer el disco). En Windows va bien con Docker Desktop montando la carpeta de builds como volumen.
La ruta de tu carpeta de builds, por ejemplo `/builds/mijuego_win64` o `C:\builds\mijuego`.
Credenciales de Google Sheets OAuth2 y un webhook de Discord.
Una hoja `builds` con columnas: `fecha`, `version`, `mb_total`, `archivos`, `variacion_mb`, `top20`.

## Los nodos, en orden
1) **Schedule Trigger** — `0 20 * * 1-5` (de lunes a viernes a las 20:00). Si compilas con un script, mejor sustitúyelo por un **Webhook** que llames al final de la compilación.
2) **Execute Command** — lista archivos y tamaños. En Linux o Mac: `find /builds/mijuego_win64 -type f -printf "%s|%p\n"`. En Windows con PowerShell: `powershell -Command "Get-ChildItem -Recurse -File 'C:\builds\mijuego' | ForEach-Object { $_.Length.ToString() + '|' + $_.FullName }"`.
3) **Google Sheets** (`Get Row(s)`) — pestaña `builds`, para leer la medición anterior.
4) **Code** — hace las cuentas y compara.
5) **Google Sheets** (`Append Row`) — guarda la medición de hoy.
6) **IF** — `{{ $json.variacion_mb }}` mayor que `100` (ajústalo a tu proyecto).
7) **Discord** — mensaje de aviso con el listado de los 20 archivos más pesados.

## El trozo de código (nodo Code)
```javascript
const salida = $('Execute Command').first().json.stdout || '';
const archivos = salida.split('\n')
  .map(l => l.trim())
  .filter(Boolean)
  .map(l => { const [t, ...r] = l.split('|'); return { bytes: parseInt(t, 10) || 0, ruta: r.join('|') }; })
  .filter(a => a.bytes > 0);
const totalMb = Math.round(archivos.reduce((s, a) => s + a.bytes, 0) / 1048576);
const top = archivos.sort((a, b) => b.bytes - a.bytes).slice(0, 20)
  .map(a => Math.round(a.bytes / 1048576) + ' MB  ' + a.ruta.split(/[\\/]/).slice(-3).join('/'));
const previas = $('Google Sheets').all();
const anterior = previas.length ? Number(previas[previas.length - 1].json.mb_total) || 0 : totalMb;
return [{ json: {
  fecha: new Date().toISOString().slice(0, 16).replace('T', ' '),
  version: 'auto',
  mb_total: totalMb,
  archivos: archivos.length,
  variacion_mb: totalMb - anterior,
  top20: top.join('\n')
} }];
```

## Cómo probarla
Ejecuta el comando del paso 2 directamente en la consola y comprueba que salen líneas del estilo `1048576|/builds/.../data.pak`.
Lanza el flujo dos veces seguidas: la segunda debe dar variación 0.
Copia a mano un archivo grande dentro de la carpeta de builds y vuelve a lanzarlo: tiene que saltar el aviso en Discord.

## Qué puede salir mal
Si n8n va en Docker y no ve la carpeta, tienes que montarla: `-v C:\builds:/builds` en el arranque del contenedor.
En Windows, `find` no existe: usa la variante de PowerShell que está arriba y respeta las comillas.
Rutas con espacios: el separador `|` del comando evita el lío que darían los espacios.
La primera ejecución no tiene con qué comparar y da variación 0; es lo esperado.
Si tu build genera archivos temporales, excluye esas carpetas añadiendo `-not -path "*/Temp/*"` al find.

## Cuánto cuesta
Gratis del todo: n8n auto-alojado, Sheets y Discord.
No consume ni API de pago ni almacenamiento en la nube, solo lee el disco local.
