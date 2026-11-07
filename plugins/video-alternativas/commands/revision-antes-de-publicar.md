---
description: Lista de comprobación y exportación final de un vídeo antes de publicarlo, adaptada a la plataforma de destino
argument-hint: "[ruta del vídeo terminado y dónde se va a publicar]"
---

Eres control de calidad. Lo que revisas ahora vale más que cualquier retoque después, porque una vez publicado un anuncio no se cambia el archivo sin perder el historial.

## 1. Datos del archivo
Lee $ARGUMENTS. Si te da la ruta, pide que ejecute:
`ffprobe -v error -show_entries stream=codec_name,width,height,r_frame_rate,bit_rate -show_entries format=duration,size -of default=noprint_wrappers=1 ENTRADA.mp4`
y `ffmpeg -i ENTRADA.mp4 -af loudnorm=I=-14:TP=-1.5:LRA=11:print_format=summary -f null -`
Con esa salida compruebas resolución, fotogramas por segundo, duración, peso y volumen real. Si no puede, pregúntaselo.

## 2. Especificaciones por destino
Reels e Instagram: 1080x1920, 9:16, hasta 90 s para alcance, H.264, AAC, 30 fps.
TikTok: 1080x1920, hasta 3 minutos funciona bien, mismo códec.
YouTube: 1920x1080 o 3840x2160, 16:9, 24 o 30 fps según se grabó.
Shorts: 1080x1920 y por debajo de 3 minutos.
LinkedIn: 1080x1080 o 1080x1350 rinde mejor que vertical puro; subtítulos obligatorios, se ve sin sonido.
Anuncios en Meta: evita texto que ocupe más del 20% de la imagen y deja el mensaje en los primeros 3 segundos.

## 3. Zonas seguras (el fallo más caro)
En vertical, deja libres los 250 píxeles de arriba y los 400 de abajo: ahí van el usuario, la descripción, los botones y la música.
No pongas texto ni logotipos pegados a los bordes: mínimo 60 píxeles de margen.
Comprueba que los subtítulos quemados no caen debajo de la línea de la interfaz.

## 4. Revisión de contenido, por orden
Segundo 0-3: ¿hay gancho visual o alguien hablando de espaldas al tema? Si el vídeo empieza con logo o careta, quítalo.
¿Se entiende el vídeo sin sonido? Ponlo en silencio y míralo entero.
¿Hay subtítulos y están sincronizados hasta el final? Muchos se descuadran en el último tercio.
¿El audio tiene el mismo volumen de principio a fin? Comprueba el salto entre voz y música.
¿Los cortes tienen ritmo o hay un plano que se hace largo? Marca el minuto exacto.
¿Aparece algo que no debería? Notificaciones, nombres de clientes, matrículas, caras de terceros, marcas ajenas, música con derechos.
¿La llamada a la acción es una sola y está clara?
¿El último fotograma es un plano decente? Es la imagen que se queda congelada al acabar.

## 5. Exportación
Si hay que reexportar o comprimir, da el comando exacto:
`ffmpeg -i ENTRADA.mp4 -c:v libx264 -preset slow -crf 20 -pix_fmt yuv420p -c:a aac -b:a 192k SALIDA.mp4`
Para recortar a vertical desde horizontal: `ffmpeg -i ENTRADA.mp4 -vf "crop=ih*9/16:ih,scale=1080:1920" -c:a copy SALIDA.mp4` y avísale de que revise el encuadre después.
yuv420p es obligatorio: sin eso hay móviles y navegadores que ven el vídeo en negro.

## Formato exacto de respuesta
Bloque FICHA TÉCNICA: lo medido, con un OK o un aviso por línea.
Bloque SEMÁFORO: lista de comprobaciones con VERDE, ÁMBAR o ROJO y una línea de explicación. Los ROJO impiden publicar.
Bloque ARREGLOS: qué tocar, en qué minuto, y el comando o el paso de CapCut para cada cosa.
Bloque PUBLICACIÓN: ajustes recomendados para la plataforma y qué NO tocar al subir.
Bloque ARCHIVO: cómo nombrar y guardar el máster y las versiones, para reutilizarlo dentro de seis meses.

## Errores típicos
No des por bueno un vídeo que solo has visto en el ordenador: revísalo en el móvil.
No subas el archivo de la exportación rápida del editor: suele llevar marca de agua o bitrate bajo.
No cambies la relación de aspecto añadiendo bandas negras: recorta o rehaz el encuadre.

## Cómo saber si está bien
Está bien cuando no queda ningún ROJO, el vídeo se entiende en silencio, el volumen medido está a menos de 1 LUFS del objetivo, y al verlo en el móvil no hay ni un elemento tapado por la interfaz.
