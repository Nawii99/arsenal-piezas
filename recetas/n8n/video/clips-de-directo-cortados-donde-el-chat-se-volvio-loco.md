# Clips de directo cortados donde el chat se volvió loco…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Analiza el chat de un directo terminado de Twitch o YouTube, encuentra los tres minutos con más mensajes por segundo y genera cortes verticales listos para subir.

## Qué es y qué hace

Tras un directo, descarga el histórico del chat de Twitch o YouTube, calcula la densidad de mensajes por ventana de 30 segundos, localiza los tres picos y exporta clips verticales de 45 segundos con ffmpeg. Entran el VOD y el chat; sale un vídeo 9:16 por pico. Requiere n8n auto-alojado con ffmpeg instalado, pensado para streamers y negocios con directos o webinars largos.

## Cómo usarla

1. Instala ffmpeg y yt-dlp en el servidor
2. Crea la aplicación de desarrollador de Twitch
3. Descarga el VOD a /data/clips
4. Programa el disparador nocturno y revisa los clips

## Cuándo usarla

Úsalo cuando haces directos largos y sabes que dentro hay 3 o 4 momentazos, pero no te apetece revisar tres horas de grabación para encontrarlos.

## Cómo ganar dinero con ella

Sustituye 2-3 horas de revisión y montaje por vídeo en directo. Cada clip publicado es tráfico gratis hacia el canal.

- Cortes de directos y webinars para empresas, entregados en 48 horas con subtítulos…
- Gestión de clips para streamers: detección de momentos y publicación en redes…
- Montaje de resúmenes verticales de eventos para marcas y ponentes…

**Precio orientativo:** 60–200 € por directo. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cuando termina un directo, descarga el histórico del chat, calcula la densidad de mensajes en ventanas de 30 segundos, coge los tres picos y usa ffmpeg para exportar clips de 45 segundos recortados a 9:16. Para streamers y negocios que hacen directos, webinars o presentaciones en vivo.

## Lo que necesitas antes
- n8n **auto-alojado** (esto necesita ffmpeg en el servidor: `apt install ffmpeg` y usar la imagen de Docker con ffmpeg añadido). En n8n Cloud no puedes ejecutar comandos.
- Cuenta de desarrollador de Twitch: dev.twitch.tv/console → «Register Your Application» → copia Client ID y Client Secret.
- El VOD del directo descargado o accesible en disco (con `yt-dlp` o la descarga desde Twitch).
- Carpeta local de trabajo, por ejemplo /data/clips.

## Los nodos, en orden
1. **Schedule Trigger** — cada día a las 03:00 (los directos ya han acabado).
2. **HTTP Request** — POST https://id.twitch.tv/oauth2/token con client_id, client_secret y grant_type=client_credentials. Devuelve el access_token.
3. **HTTP Request** — GET https://api.twitch.tv/helix/videos?user_id=TU_ID&type=archive&first=1, headers `Client-Id` y `Authorization: Bearer {{token}}`. Saca el VOD de ayer.
4. **Code** (renómbralo «Validar VOD») — se queda con el primer vídeo de la respuesta, para el flujo si su ID no es solo números y rehace la URL a partir del ID. Código abajo.
5. **Execute Command** — descarga el VOD: `yt-dlp -o /data/clips/{{ $json.id }}.mp4 {{ $json.url }}`.
6. **Execute Command** — descarga el chat: `chat_downloader {{ $('Validar VOD').first().json.url }} --output /data/clips/{{ $('Validar VOD').first().json.id }}.json` (pip install chat-downloader).
7. **Read/Write Files from Disk** (Read) — lee el JSON del chat; queda como binario en `data` y el nodo 8 lo lee de ahí.
8. **Code** — cuenta mensajes por ventana de 30 s y devuelve los 3 picos con su segundo de inicio.
9. **Split In Batches** — 1 a 1.
10. **Execute Command** — el corte con ffmpeg.
11. **Google Drive** (Upload) — antes lee el clip con **Read/Write Files from Disk** (Read) desde `/data/clips/clip_{{ $('Split In Batches').item.json.inicio }}.mp4` (Execute Command no devuelve el archivo) y sube cada clip a la carpeta «Clips pendientes».
12. **Telegram** — te avisa con los enlaces y el minuto original de cada corte.

## El código del nodo 4
```js
const r = $input.first().json;
const v = (r.data || [])[0] || r;
const id = String(v.id || '');
if (!/^\d+$/.test(id)) throw new Error('ID de VOD inesperado: ' + id.slice(0, 40));
return [{ json: { id, url: `https://www.twitch.tv/videos/${id}` } }];
```

## El código del nodo 8
```js
const raw = (await this.helpers.getBinaryDataBuffer(0, 'data')).toString('utf8');
const msgs = JSON.parse(raw).map(m => Math.floor(m.time_in_seconds / 30));
const cuenta = {};
for (const v of msgs) cuenta[v] = (cuenta[v] || 0) + 1;
const picos = Object.entries(cuenta)
  .sort((a,b) => b[1] - a[1])
  .filter((p, i, arr) => arr.slice(0,i).every(q => Math.abs(q[0]-p[0]) > 4))
  .slice(0,3);
return picos.map(([v, n]) => ({ json: { inicio: Math.max(0, v*30 - 25), mensajes: n } }));
```

## El comando del nodo 10
```bash
ffmpeg -ss {{ $json.inicio }} -i /data/clips/{{ $('Validar VOD').first().json.id }}.mp4 -t 45 -vf "crop=ih*9/16:ih,scale=1080:1920" -c:v libx264 -preset veryfast -c:a aac /data/clips/clip_{{ $json.inicio }}.mp4
```

## Cómo probarla
Coge un VOD que ya conozcas y en el que sepas dónde está el momentazo. Ejecuta solo hasta el nodo 8 y comprueba que el segundo detectado coincide. El `-25` del código es el margen para empezar antes de la reacción, ajústalo a tu ritmo.

## Qué puede salir mal
- **Recorte mal centrado**: el crop coge el centro. Si estás a la izquierda del encuadre, cambia a `crop=ih*9/16:ih:200:0`.
- **Picos pegados**: el filtro exige 2 minutos de separación entre picos; súbelo si te salen tres clips del mismo momento.
- **Espacio en disco**: un VOD de 3 horas son 6-10 GB. Borra el original al terminar con un Execute Command final.
- **Token de Twitch**: caduca cada 60 días; el nodo 2 lo pide nuevo cada vez, así que no te afecta.
- **Datos de la API dentro del comando**: el ID y la URL del VOD llegan de fuera y van sin comillas a la shell; por eso «Validar VOD» solo acepta un ID numérico y rehace la URL, en vez de pasar la que devuelve la API.
- **El chat o el clip no llegan al nodo siguiente**: Read/Write Files deja el JSON como binario y Execute Command no devuelve archivos; por eso el nodo 8 lee el binario y cada clip se lee del disco antes de subirlo.

## Cuánto cuesta
Todo gratis salvo el servidor: un VPS con 4 GB de RAM y 80 GB de disco por 6-10 €/mes aguanta esto. La API de Twitch no cobra.
