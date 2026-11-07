---
name: subtitulos-srt-2
description: Convierte una transcripción en un archivo de subtítulos .srt bien troceado, listo para importar en CapCut, DaVinci Resolve o Kdenlive. Se activa con "/subtitulos-srt-2" seguido de la transcripción o el enlace al vídeo.
---

## Qué hace
Coge una transcripción (con o sin marcas de tiempo) y la convierte en un archivo .srt con los tiempos y el texto trocado en líneas legibles, para que no tengas que escribir los subtítulos a mano ni ajustar cada bloque uno a uno dentro del editor.
Esto es lo que más tiempo ahorra en vídeos para redes: subtitular a mano un vídeo de 5 minutos puede llevar más de media hora.

## Qué preguntar antes de empezar
- ¿La transcripción ya trae marcas de tiempo? Si no las trae, pide al usuario que las saque del subtitulado automático de YouTube, CapCut o Whisper, porque sin ellas no se puede generar un .srt fiable.
- ¿El vídeo es para redes verticales (Reels, TikTok, Shorts) o para YouTube horizontal? Cambia el máximo de caracteres por línea: 30 para vertical, 42 para horizontal.
- ¿Quiere el usuario los subtítulos en mayúsculas o con formato normal? Muchos formatos de redes usan mayúsculas.

## Paso a paso
1. Divide el texto en bloques de máximo 2 líneas, respetando el límite de caracteres acordado.
2. Asigna a cada bloque su tiempo de inicio y fin a partir de las marcas de la transcripción; si un bloque no llega a 1 segundo en pantalla, alárgalo hasta 1 segundo aunque se solape un poco con el siguiente audio.
3. Numera los bloques en orden, empezando en 1.
4. Genera el archivo en formato .srt estándar: número de bloque, tiempo en formato 00:00:00,000 --> 00:00:00,000, texto, línea en blanco.

## Qué devolver y en qué formato
El contenido completo del archivo .srt en un bloque de código, listo para copiar y guardar como archivo .srt. Indica al usuario cómo importarlo: en CapCut, Subtítulos > Importar; en DaVinci Resolve, arrastrar el .srt a la línea de tiempo; en Kdenlive, Proyecto > Añadir clip de subtítulos.

## Qué NO hacer
- No resumas ni cambies el texto de la transcripción: transcribe fielmente, aunque haya muletillas, salvo que el usuario pida limpiarlas.
- No generes tiempos que se solapen entre bloques consecutivos, salvo el ajuste mínimo del paso 2: rompe la reproducción en varios editores.
- No entregues el .srt sin revisar que el último bloque no se corte antes de que acabe el audio.
