# Podcast a audiograma vertical para redes…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Cada vez que publicas un episodio de podcast, saca un fragmento, le monta una onda de audio animada sobre tu plantilla y te deja tres audiogramas verticales listos para Reels y TikTok.

## Qué es y qué hace

Detecta cada episodio nuevo de tu feed RSS, lo descarga, lo transcribe, pide a la IA tres fragmentos citables y con ffmpeg genera tres vídeos verticales con onda de audio, carátula y subtítulos. Entran el feed y un fondo 1080x1920; salen tres MP4 listos para Reels y TikTok. Requiere n8n auto-alojado con ffmpeg y una clave de transcripción.

## Cómo usarla

1. Instala ffmpeg y fuentes en el contenedor
2. Prepara el fondo vertical con tu marca
3. Conecta el RSS y la clave de transcripción
4. Revisa el primer lote antes de automatizar

## Cuándo usarla

Úsalo cuando tienes podcast solo de audio y las redes te exigen vídeo, o cuando quieres promocionar cada episodio sin abrir el editor.

## Cómo ganar dinero con ella

Sustituye 45 minutos por episodio de montaje repetitivo. Con un episodio semanal son 40 horas al año.

- Audiogramas de podcast para marcas y consultores, entregados por episodio…
- Pack mensual de clips verticales para podcasts que no tienen equipo de edición…
- Plantilla y configuración de audiogramas para podcasters que quieren promocionarse en redes…

**Precio orientativo:** 30–90 € por episodio. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Detecta episodio nuevo en tu feed RSS, lo transcribe, pide a la IA los tres fragmentos más citables, y con ffmpeg genera un vídeo vertical con forma de onda, la carátula y los subtítulos incrustados. Para podcasters, consultores y negocios con formato entrevista.

## Lo que necesitas antes
- n8n **auto-alojado** con ffmpeg instalado (imagen Docker con `apt-get install -y ffmpeg fonts-dejavu`).
- El feed RSS de tu podcast (te lo da Ivoox, Spotify for Podcasters, Anchor…).
- Clave de OpenAI para Whisper (transcripción) y para elegir fragmentos.
- Una imagen de fondo vertical 1080x1920 con tu marca, guardada en /data/podcast/fondo.png.

## Los nodos, en orden
1. **RSS Feed Trigger** — URL de tu feed, Poll Times cada 1 hora.
2. **Execute Command** — descarga el audio: `curl -L -o /data/podcast/ep.mp3 "{{ $json.enclosure.url }}"`.
3. **Execute Command** — recorta a los primeros 20 minutos para no pagar de más en la transcripción: `ffmpeg -y -i /data/podcast/ep.mp3 -t 1200 -ar 16000 -ac 1 /data/podcast/ep16.mp3`.
4. **Read/Write Files from Disk** (Read) — carga ep16.mp3 como binario.
5. **OpenAI** (Audio → Transcribe a Recording) — modelo whisper-1, Response Format «verbose_json» para tener tiempos.
6. **AI Agent** — prompt: «De esta transcripción con tiempos, elige 3 fragmentos de entre 30 y 55 segundos que se entiendan solos y enganchen. Devuelve JSON: [{inicio_seg, fin_seg, gancho}]. Nada más.»
7. **Code** — parsea el JSON y saca un item por fragmento.
8. **Split In Batches** — 1 a 1.
9. **Execute Command** — el render con ffmpeg.
10. **Google Drive** (Upload) a «Audiogramas» y **Gmail** con los enlaces.

## El comando del nodo 9
```bash
ffmpeg -y -ss {{ $json.inicio_seg }} -t {{ $json.fin_seg - $json.inicio_seg }} -i /data/podcast/ep.mp3 -loop 1 -i /data/podcast/fondo.png -filter_complex "[0:a]showwaves=s=1080x300:mode=cline:colors=white[w];[1:v][w]overlay=0:1300:shortest=1,drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf:text='{{ $json.gancho }}':fontcolor=white:fontsize=54:x=(w-text_w)/2:y=400:line_spacing=14[v]" -map "[v]" -map 0:a -c:v libx264 -pix_fmt yuv420p -c:a aac -shortest /data/podcast/audiograma_{{ $runIndex }}.mp4
```

## Cómo probarla
Lanza a mano con un episodio antiguo. Revisa que el fragmento elegido no empiece a media palabra: si pasa mucho, pide a la IA que use solo tiempos de inicio de frase de la transcripción. Mira el vídeo en el móvil, que es donde se va a ver.

## Qué puede salir mal
- **Texto con comillas o acentos en drawtext**: rompe el comando. Limpia el gancho en un nodo Code con `.replace(/[':\\]/g,'')`.
- **Fuente no encontrada**: comprueba la ruta real con `fc-list | grep DejaVu`.
- **Whisper caro con episodios largos**: por eso se recorta a 20 minutos; 0,006 $ el minuto.
- **RSS que dispara dos veces**: si tu feed cambia la fecha al editar, guarda los GUID procesados en una hoja y filtra.

## Cuánto cuesta
ffmpeg y n8n, gratis (VPS de 6-10 €/mes). Whisper: unos 0,12 € por episodio de 20 minutos. La IA de selección, céntimos.
