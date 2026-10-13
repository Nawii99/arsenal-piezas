# Entrega a cliente: marca de agua, compresión y enlace…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Deja el vídeo montado en una carpeta y sale con tu logo, comprimido para revisión, subido a una carpeta del cliente y con el correo de entrega ya enviado.

## Qué es y qué hace

Es una automatización de n8n con ffmpeg que vigila una carpeta de entrada, aplica tu logo como marca de agua, comprime el vídeo para revisión, lo sube a la carpeta del cliente en Drive, crea el enlace y envía el correo de entrega. Entra un vídeo montado y la fila del proyecto; sale una versión de revisión con enlace y el correo enviado. Requiere ffmpeg en n8n auto-alojado y credenciales de Drive y Gmail.

## Cómo usarla

1. Instala ffmpeg en n8n auto-alojado y añade el logo
2. Rellena la hoja de proyectos
3. Haz una entrega de prueba para ti
4. Activa el flujo para cada cliente

## Cuándo usarla

Úsalo cuando entregues vídeos a clientes y pierdas media hora por entrega exportando versiones de revisión, subiendo a Drive y escribiendo el mismo correo de siempre.

## Cómo ganar dinero con ella

Ahorra 20-30 min por entrega y evita el error caro: mandar el archivo final sin marca de agua antes de que te paguen.

- Entrega de vídeo automatizada para editores freelance con varios clientes a la vez.
- Versiones de revisión con marca de agua para agencias que cobran tras la aprobación.
- Plantilla de entrega con correo y carpeta para estudios de vídeo pequeños.

**Precio orientativo:** 120–300 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una carpeta de entrada, aplica tu logo como marca de agua, comprime el vídeo a un tamaño manejable para revisión, lo sube a la carpeta del cliente en Drive, crea el enlace y manda el correo de entrega con las instrucciones de revisión.
Para editores de vídeo, agencias y freelances que entregan varias piezas por semana.

## Lo que necesitas antes
- n8n auto-alojado con **ffmpeg** (imagen propia: `FROM n8nio/n8n`, `USER root`, `RUN apk add --no-cache ffmpeg`, `USER node`).
- Tu logo en PNG con fondo transparente, subido al contenedor o montado como volumen en `/data/logo.png`.
- Credenciales Google Drive y Gmail.
- Carpeta `1-Entrada` en Drive, y una hoja `Proyectos` con: `proyecto`, `cliente`, `email`, `carpeta_destino_id`, `estado`.
- Convención de nombres: `CLIENTE_proyecto_v2.mp4`.

## Los nodos, en orden
1. **Google Drive Trigger** — Event `File Created`, carpeta `1-Entrada`.
2. **Code** (identificar el proyecto):
```javascript
const n = $json.name.replace(/\.[^.]+$/, '');
const [cliente, proyecto, version] = n.split('_');
return [{ json: { id: $json.id, nombre: $json.name, cliente, proyecto, version: version || 'v1' } }];
```
3. **Google Sheets** (Get Row(s)) — Filters: `proyecto` = `{{ $json.proyecto }}`, primer resultado.
4. **Google Drive** (Download File) — binario `data`.
5. **Read/Write Files from Disk** (Write File) — `/tmp/entrada.mp4`.
6. **Execute Command** — marca de agua abajo a la derecha, escalado a 1080p y compresión de revisión:
```bash
ffmpeg -y -i /tmp/entrada.mp4 -i /data/logo.png -filter_complex "[1:v]scale=iw*0.12:-1,format=rgba,colorchannelmixer=aa=0.55[wm];[0:v]scale=-2:1080[bg];[bg][wm]overlay=W-w-40:H-h-40" -c:v libx264 -preset medium -crf 26 -c:a aac -b:a 128k -movflags +faststart /tmp/revision.mp4
```
7. **Execute Command** (opcional, dato para el correo) — `du -h /tmp/revision.mp4 | cut -f1`.
8. **Read/Write Files from Disk** (Read File) — `/tmp/revision.mp4`, propiedad `salida`.
9. **Google Drive** (Upload File) — Parent Folder: `{{ $('Google Sheets').item.json.carpeta_destino_id }}`, File Name `{{ $('Code').item.json.cliente }}_{{ proyecto }}_{{ version }}_REVISION.mp4`.
10. **Google Drive** (Share File) — Role `reader`, Type `anyone with the link` (o `user` con el email del cliente, más seguro).
11. **Gmail** (Send Message) — To: `{{ $('Google Sheets').item.json.email }}`. Asunto: `{{ proyecto }} — versión para revisión`. Cuerpo: enlace, instrucciones («apunta los cambios con el minuto exacto, en un solo mensaje») y la nota de que la versión final sin marca de agua se entrega tras el pago.
12. **Google Sheets** (Update Row) — `estado` = `enviado a revisión` con la fecha.
13. **Execute Command** — `rm -f /tmp/entrada.mp4 /tmp/revision.mp4`.

## Cómo probarla
- Prueba con un vídeo de 30 segundos y mira el resultado a pantalla completa: la marca de agua debe verse pero no molestar, y el logo no debe quedar pixelado (usa un PNG de al menos 400 px de ancho).
- Comprueba el peso: un minuto a crf 26 debería quedarse en 8-15 MB.
- Manda el primer correo a ti mismo cambiando el email en la hoja.

## Qué puede salir mal
- **Vídeos verticales**: el `scale=-2:1080` los deja altísimos. Usa `scale='if(gt(a,1),-2,1080)':'if(gt(a,1),1080,-2)'` para adaptarse a la orientación.
- **Sin audio**: si el vídeo no tiene pista de audio, ffmpeg falla con `-c:a aac`. Añade `-shortest` y prueba con `-map 0:v -map 0:a?`.
- **Vídeos largos**: una hora a crf 26 puede tardar 10-20 minutos; sube el timeout del flujo y usa `-preset veryfast` si te corre prisa.
- **Enlaces públicos**: si el contenido es sensible, comparte solo con el email del cliente en vez de «cualquiera con el enlace».
- **Nombres mal puestos**: si el archivo no sigue la convención, el Code devuelve valores vacíos; mete un **IF** que te avise en lugar de entregar mal.

## Cuánto cuesta
- 0 € de licencias: ffmpeg, n8n, Drive y Gmail.
- Un VPS de 4 GB (unos 10-12 €/mes) si procesas vídeos largos a diario; en tu propio ordenador, gratis.
