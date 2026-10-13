# Cortador de clips verticales para Reels y TikTok…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

A partir de una lista de marcas de tiempo en una hoja de cálculo, corta un vídeo largo en clips, los reencuadra a formato vertical 9:16 y los deja en una carpeta de Drive.

## Qué es y qué hace

Es una automatización de n8n con ffmpeg que lee en una hoja los minutos de inicio y fin de cada clip, corta el vídeo largo, lo recorta a formato vertical 9:16 y lo guarda en Drive. Entra un vídeo largo y una tabla de marcas de tiempo; sale una carpeta con clips verticales listos para Reels, TikTok o Shorts. Solo funciona en n8n auto-alojado, porque necesita ejecutar ffmpeg.

## Cómo usarla

1. Monta n8n auto-alojado con ffmpeg
2. Rellena la hoja con archivo, inicio y fin
3. Ejecuta el flujo
4. Revisa los clips antes de publicar

## Cuándo usarla

Úsalo cuando grabes podcasts, directos o vídeos largos y necesites sacar 5-10 verticales de cada uno sin abrir el editor de vídeo para cada corte.

## Cómo ganar dinero con ella

Sustituye 30-45 min de recortes manuales por vídeo largo y evita pagar 20-30 €/mes a herramientas tipo repurpose automático.

- Clips verticales para podcasters y formadores que graban una vez y publican muchas veces.
- Recortes de directos para creadores que quieren Shorts sin editar a mano.
- Servicio de verticales mensuales para negocios con vídeos largos de entrevistas.

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lees una hoja con `archivo`, `inicio`, `fin` y `nombre_clip`, y por cada fila el flujo corta ese trozo del vídeo original, lo recorta a 1080x1920 y lo sube a Drive.
Para podcasters, formadores y cualquiera que grabe una vez y publique diez veces.

## Lo que necesitas antes
- n8n **auto-alojado** (esto no funciona en n8n Cloud, hace falta ejecutar comandos). Dockerfile propio: `FROM n8nio/n8n` + `USER root` + `RUN apk add --no-cache ffmpeg` + `USER node`.
- Credencial de Google Drive OAuth2 y Google Sheets OAuth2.
- Una hoja con columnas: `archivo` (nombre exacto en Drive), `inicio` (formato `00:12:30`), `fin` (`00:13:05`), `nombre_clip`, `estado`.

## Los nodos, en orden
1. **Manual Trigger** (o **Schedule Trigger** una vez al día a las 07:00, zona `Europe/Madrid`).
2. **Google Sheets** (Get Row(s)) — Filters: `estado` = `pendiente`.
3. **Split In Batches** (Loop Over Items) — Batch Size `1`. Así procesas un clip cada vez y no saturas la CPU.
4. **Google Drive** (Search Files/Folders) — Query String: `{{ $json.archivo }}`, para sacar el ID.
5. **Google Drive** (Download File) — By ID `{{ $json.id }}`, binario `data`.
6. **Read/Write Files from Disk** (Write File) — `/tmp/origen.mp4`, Input Binary Field `data`.
7. **Execute Command** — el corte y el reencuadre en un solo comando:
```bash
ffmpeg -y -ss {{ $('Split In Batches').item.json.inicio }} -to {{ $('Split In Batches').item.json.fin }} -i /tmp/origen.mp4 -vf "crop=ih*9/16:ih,scale=1080:1920,setsar=1" -c:v libx264 -preset veryfast -crf 23 -c:a aac -b:a 128k /tmp/{{ $('Split In Batches').item.json.nombre_clip }}.mp4
```
8. **Read/Write Files from Disk** (Read File) — `/tmp/{{ $('Split In Batches').item.json.nombre_clip }}.mp4`, propiedad `clip`.
9. **Google Drive** (Upload File) — carpeta `Clips verticales`, Input Binary Field `clip`, File Name `{{ ... }}.mp4`.
10. **Google Sheets** (Update Row) — `estado` = `listo`.
11. Conecta la salida de vuelta al **Split In Batches** para que siga con la siguiente fila.

## Variante: la cara centrada, no el centro del vídeo
Si el que habla no está centrado, cambia el filtro por un recorte desplazado. Un **Code** antes del Execute Command te calcula el `crop` según una columna `lado` (`izquierda`, `centro`, `derecha`):
```javascript
const lado = $json.lado || 'centro';
const w = 'ih*9/16';
let x = '(iw-ih*9/16)/2';
if (lado === 'izquierda') x = '0';
if (lado === 'derecha') x = 'iw-ih*9/16';
return [{ json: { ...$json, filtro: `crop=${w}:ih:${x}:0,scale=1080:1920,setsar=1` } }];
```
Y en el comando pon `-vf "{{ $json.filtro }}"`.

## Cómo probarla
- Empieza con un vídeo de 2 minutos y una sola fila con un corte de 15 segundos.
- Abre el clip en el móvil: tiene que ocupar toda la pantalla y no verse deformado.
- Comprueba que el audio no va desplazado; si lo va, mueve el `-ss` detrás del `-i` (más lento pero exacto al fotograma).

## Qué puede salir mal
- **Tiempos de ejecución**: sube `EXECUTIONS_TIMEOUT` en n8n; un vídeo de una hora tarda varios minutos en descargarse.
- **Disco lleno**: borra `/tmp` al final con un **Execute Command** `rm -f /tmp/origen.mp4 /tmp/*.mp4`.
- **Permisos**: si el Execute Command dice `permission denied`, es que el contenedor corre con usuario `node`; escribe siempre en `/tmp`.
- **Cuota de Drive**: descargar el mismo vídeo largo 8 veces (una por clip) es lento; mejor descarga una vez fuera del bucle y guarda `/tmp/origen.mp4` para todas las filas del mismo archivo.

## Cuánto cuesta
- 0 € de software: n8n y ffmpeg son gratis.
- Un VPS de 2 vCPU y 4 GB (unos 10 €/mes) va sobrado; en un ordenador propio, gratis.
