# Publicar en YouTube solo con dejar el vídeo en Drive…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Dejas el MP4 en una carpeta de Google Drive con el título en el nombre del archivo y se sube solo a YouTube como privado, listo para revisar y publicar.

## Qué es y qué hace

Vigila una carpeta de Google Drive y, en cuanto aparece un MP4 nuevo, lo sube a tu canal como privado con título, descripción y etiquetas tomados del nombre del archivo. Entran el vídeo y las credenciales de Drive y YouTube; sale el vídeo subido, listo para revisar y programar. Pensado para creadores y equipos donde el editor no es quien gestiona el canal.

## Cómo usarla

1. Verifica el canal y activa Drive y YouTube Data API
2. Crea la credencial OAuth de aplicación web
3. Define la convención de nombre de archivo
4. Prueba con un vídeo corto privado

## Cuándo usarla

Úsalo cuando editas vídeos en el ordenador y pierdes tiempo cada semana subiéndolos a mano a YouTube, o cuando el que edita no es la misma persona que gestiona el canal.

## Cómo ganar dinero con ella

Ahorra unos 15-20 minutos por vídeo de subida y espera, y evita el clásico «se me olvidó subirlo». Con 8 vídeos al mes son 2 horas.

- Entrega de vídeos a canales de clientes con subida automática a privado para revisión…
- Flujo de publicación para academias con varios editores y un solo canal…
- Configuración de subida automática para creadores que editan por su cuenta…

**Precio orientativo:** 100–250 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una carpeta de Google Drive y, en cuanto aparece un vídeo nuevo, lo sube a tu canal de YouTube como **privado** con título, descripción y etiquetas sacadas del nombre del archivo. Pensado para creadores, academias y negocios que publican vídeo de forma habitual y quieren que subir deje de ser una tarea manual.

## Lo que necesitas antes
- Cuenta de n8n (plan gratuito en la nube o auto-alojado con Docker).
- Cuenta de Google con Drive y un canal de YouTube ya verificado (sin verificar no puedes subir vídeos de más de 15 minutos).
- Credenciales de Google OAuth: entra en console.cloud.google.com, crea un proyecto, en «APIs y servicios» activa **Google Drive API** y **YouTube Data API v3**, ve a «Credenciales» → «Crear credenciales» → «ID de cliente OAuth» → tipo «Aplicación web», y pega como URI de redirección la que te muestra n8n al crear la credencial de Google.
- Una carpeta en Drive llamada por ejemplo `01-SUBIR-A-YOUTUBE` y otra `02-SUBIDOS`.
- Una hoja de Google Sheets con las columnas: `fecha`, `archivo`, `video_id`, `url`, `estado`.

## Los nodos, en orden
1. **Google Drive Trigger** — Credencial de Google. Evento: `File Created`. Poll Times: cada 15 minutos. Folder: selecciona `01-SUBIR-A-YOUTUBE`. Marca «Watch subfolders» en No.
2. **IF** — Condición String → valor 1: `{{ $json.name }}`, operación «ends with», valor 2: `.mp4`. Así ignoras miniaturas, PDFs o archivos sueltos que caigan en la carpeta.
3. **Google Drive** (rama true) — Resource: `File`, Operation: `Download`. File ID: `{{ $json.id }}`. Output Binary Field: `data`.
4. **Code** — Modo «Run Once for Each Item». Parte el nombre del archivo en título y etiquetas (ver código abajo).
5. **YouTube** — Resource: `Video`, Operation: `Upload`. Binary Property: `data`. Title: `{{ $json.titulo }}`. Description: `{{ $json.descripcion }}`. Region Code: `ES`. Category ID: `22` (People & Blogs) o `27` (Education). En Options añade: Privacy Status = `private`, Tags = `{{ $json.tags }}`, Default Language = `es`, Notify Subscribers = false.
6. **Google Drive1** — Operation: `Move`. File ID: `{{ $('Google Drive Trigger').item.json.id }}`. Destino: carpeta `02-SUBIDOS`. Así no se vuelve a subir nunca.
7. **Google Sheets** — Operation: `Append`. Columnas: fecha `{{ $now.format('yyyy-MM-dd HH:mm') }}`, archivo `{{ $('Google Drive Trigger').item.json.name }}`, video_id `{{ $json.id }}`, url `https://youtu.be/{{ $json.id }}`, estado `privado`.
8. **Gmail** — Operation: `Send`. Para: tu correo. Asunto: `Vídeo subido: {{ $('Code').item.json.titulo }}`. Cuerpo con el enlace para que solo tengas que entrar, revisar y darle a público.

## El código del nodo Code
```javascript
// Nombre esperado: 2026-03-14_Como-elegir-camara__camara,principiantes,video.mp4
const nombre = $('Google Drive Trigger').item.json.name;
const limpio = nombre.replace(/\.mp4$/i, '');
const partes = limpio.split('__');
let base = partes[0];
const tags = partes[1] ? partes[1].split(',').map(t => t.trim()) : ['video'];
base = base.replace(/^\d{4}-\d{2}-\d{2}_/, '');
const titulo = base.replace(/[-_]+/g, ' ').trim().slice(0, 95);
const descripcion = titulo + '\n\nSuscríbete para más vídeos como este.\n\n#' + tags.join(' #');
return { json: { titulo, descripcion, tags } };
```

## Cómo probarla
1. Desactiva el flujo y pulsa «Execute Workflow» con un MP4 de prueba de 20 segundos ya puesto en la carpeta.
2. Comprueba en YouTube Studio que aparece como privado, con el título correcto y las etiquetas.
3. Mira que el archivo se ha movido a `02-SUBIDOS` y que hay una fila nueva en la hoja.
4. Solo cuando eso salga bien tres veces seguidas, activa el flujo.

## Qué puede salir mal
- **Cuota de la YouTube Data API**: cada subida cuesta 1.600 unidades de las 10.000 diarias gratis. Son unas 6 subidas al día. Si necesitas más, pide ampliación de cuota en la consola de Google.
- **Vídeos grandes**: en n8n cloud hay límite de memoria. Para archivos de más de 1 GB usa n8n auto-alojado y sube en la configuración `N8N_PAYLOAD_SIZE_MAX`.
- **Duplicados**: si no mueves el archivo, el trigger puede volver a dispararlo. El paso 6 es obligatorio, no opcional.
- **Canal no verificado**: YouTube rechaza subidas largas y las deja en «procesando» para siempre. Verifica el canal con tu móvil antes.
- **Zona horaria**: pon en Settings del workflow el timezone `Europe/Madrid` o las fechas de la hoja saldrán con dos horas menos.

## Cuánto cuesta
Gratis: n8n gratuito, Drive, Sheets y la cuota diaria de YouTube. Se paga solo si superas los 15 GB de Drive (2 €/mes por 100 GB) o si pasas de las ejecuciones del plan gratis de n8n (desde 20 €/mes, o 0 € auto-alojando en un VPS de 5 €/mes).
