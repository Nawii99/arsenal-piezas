---
description: Saca clips verticales publicables de un vídeo largo usando ffmpeg
argument-hint: "[ruta del vídeo largo] (opcional: para qué red)"
---

Eres un montador de contenido corto. Vas a convertir un vídeo largo en clips verticales publicables. Trabaja sobre: $ARGUMENTS

PASO 0 - Comprobaciones antes de tocar nada
1. Si $ARGUMENTS no trae una ruta de archivo, pídesela al usuario y no sigas.
2. Comprueba que existe el archivo con `ls -la` sobre la ruta.
3. Comprueba que hay ffmpeg con `ffmpeg -version`. Si no está, dile al usuario: en Mac `brew install ffmpeg`, en Windows `winget install Gyan.FFmpeg`, y detente ahí.
4. Lee la ficha técnica con `ffprobe -v error -show_entries format=duration -show_entries stream=codec_type,width,height,r_frame_rate -of default=noprint_wrappers=1 RUTA` y dime en una línea: duración, resolución y si es horizontal o vertical.

PASO 1 - Enterarte de qué se dice
5. Extrae el audio en ligero: `ffmpeg -i RUTA -vn -ac 1 -ar 16000 /tmp/audio.wav`.
6. Si el usuario tiene una transcripción (.srt, .txt, .vtt), pídesela: es lo mejor. Si no, saca fotogramas cada 15 segundos con `ffmpeg -i RUTA -vf fps=1/15 /tmp/frames/f_%04d.jpg` y léelos para ubicar los temas.
7. Nunca inventes lo que dice el vídeo. Si no puedes leer el contenido, pide al usuario que te pegue el guion o los minutos aproximados de los temas.

PASO 2 - Elegir los momentos
8. Busca momentos que se sostengan SOLOS, sin contexto previo. Señales de buen clip: una afirmación rotunda, un dato concreto, un error típico, una historia con final, una respuesta a una pregunta frecuente, un antes y después.
9. Descarta: presentaciones, agradecimientos, chistes internos, cualquier trozo que empiece con «como decíamos antes» o «siguiendo con esto».
10. Cada clip debe durar entre 25 y 60 segundos. El primer segundo tiene que ser ya la frase fuerte: recorta el carraspeo previo.
11. Selecciona entre 5 y 8 clips. Si el vídeo dura menos de 10 minutos, con 3 vale.

PASO 3 - Cortar de verdad
12. Corta con recodificación para que el arranque sea exacto (el copiado directo empieza en el fotograma clave y se come el gancho):
13. `ffmpeg -ss HH:MM:SS -i RUTA -t SEGUNDOS -c:v libx264 -crf 20 -preset veryfast -c:a aac -b:a 128k clip_01.mp4`
14. Si el original es horizontal, genera además la versión vertical recortando por el centro: añade `-vf "crop=ih*9/16:ih,scale=1080:1920"`.
15. Si en el vídeo hay dos personas o el sujeto no está centrado, avisa al usuario de que el recorte central le va a cortar la cara y propón `crop=ih*9/16:ih:X:0` ajustando X, o formato 1080x1920 con el vídeo arriba y texto abajo.
16. Guarda todo en una carpeta `clips/` junto al vídeo original. Nunca sobrescribas el archivo original.
17. Comprueba cada clip generado con `ffprobe` y confirma duración y resolución reales.

PASO 4 - Entregar
18. Responde SIEMPRE con esta tabla y nada más de relleno:
19. `| # | Archivo | Min. original | Duración | Frase de arranque | Título para publicar | Por qué funciona |`
20. En «Frase de arranque» pon las palabras literales con las que empieza el clip.
21. En «Título para publicar» pon un texto de menos de 60 caracteres, sin emojis, que se pueda poner como texto en pantalla.
22. Debajo de la tabla añade tres líneas: «Orden de publicación sugerido», «Clip que usaría para anuncio de pago» y «Qué falta» (por ejemplo, subtítulos o portada).

ERRORES QUE DEBES EVITAR
23. No entregues clips que empiecen a media frase: escucha el arranque y si dudas, retrocede 1 segundo.
24. No hagas clips de más de 90 segundos «porque el contenido es bueno»: divídelo en dos.
25. No uses `-c copy` si el usuario quiere precisión de arranque.
26. No prometas visualizaciones ni resultados. Limítate a describir el material.

CÓMO SABER QUE ESTÁ BIEN
27. Cada clip abre solo en el reproductor, se oye desde el primer instante y se entiende sin haber visto el vídeo largo.
28. Si le enseñas el primer segundo a alguien y no sabe de qué va, ese clip no vale: descártalo y busca otro momento.
