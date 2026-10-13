---
name: audio-ffmpeg-sin-tocar-originales
description: Escribe y prueba scripts de ffmpeg para convertir, igualar el volumen y limpiar audio (podcast, locuciones, entrevistas) sin tocar los archivos originales, y prepara la subida. Se activa cuando pides pasar audios a MP3 o WAV, igualar volumen, quitar silencios largos o procesar un lote de episodios.
---

# Audio con ffmpeg sin tocar los originales

## Qué hace
ffmpeg es un programa gratuito que convierte y trata audio y vídeo desde el terminal. Claude escribe los comandos, los prueba con un solo archivo y, si te gusta el resultado, los aplica a todo el lote. Los originales no se tocan.
Dónde ponerla: guarda este texto como SKILL.md dentro de .claude/skills/audio-ffmpeg-sin-tocar-originales/ de tu proyecto.
Esto se ejecuta en un ordenador con Claude Code. Desde el móvil Android puedes dejar el encargo preparado, pero el proceso se hace en el ordenador.
Cómo pedirla: «Pasa los 12 episodios de la carpeta bruto a MP3 con el volumen igualado, sin tocar los originales».

## Pregunta antes de empezar
1. ¿Qué archivos hay, en qué formato, cuántos y en qué carpeta?
2. ¿Qué quieres al final? Formato (MP3, WAV, M4A), mono o estéreo y calidad.
3. ¿Dónde se va a publicar? Cada plataforma pide un volumen y un formato. Pide el enlace a sus requisitos. Si no lo tienes, usa [OBJETIVO DE VOLUMEN EN LUFS, habitual -16 en podcast] y avisa de que hay que confirmarlo.
4. ¿Qué problema hay? Volumen desigual, ruido de fondo, silencios largos o un formato que no aceptan.
5. ¿El audio es tuyo o de un cliente? ¿Hay música, invitados o voces de terceros?
6. ¿Está instalado ffmpeg? Que Claude lo compruebe con ffmpeg -version. Si falta, que indique cómo instalarlo desde la web oficial o desde el gestor de paquetes del sistema. Nada de descargas de sitios raros.
7. ¿Windows, Mac o Linux? Cambia el tipo de script.

## Paso a paso
1. Confirma que existe copia de seguridad de los originales. La salida va siempre a una carpeta nueva, por ejemplo procesado.
2. Mira primero qué hay: duración, formato y volumen medio de cada archivo. Resúmelo en una tabla.
3. Explica el tratamiento en lenguaje normal y espera el visto bueno.
4. Escribe el comando para un solo archivo. Patrones habituales:
- Convertir e igualar volumen: ffmpeg -n -i entrada.wav -af loudnorm=I=-16:TP=-1.5:LRA=11 -c:a libmp3lame -b:a 128k procesado/salida.mp3
- La opción -n hace que ffmpeg no sobrescriba nada. Para voz sola, -ac 1 lo pasa a mono.
- Quitar graves molestos y ruido suave: filtros highpass y afftdn, a dosis pequeñas.
- Quitar silencios largos: filtro silenceremove. Ojo: puede comerse el final de las palabras. Que Claude ajuste los valores y los enseñe.
5. Prueba con un trozo de 30 a 60 segundos. Pide al usuario que lo escuche con cascos.
6. Si está bien, escribe el script del lote (un archivo .sh o .bat) que recorra la carpeta, escriba en procesado y guarde un registro de lo que hace.
7. Ejecuta el lote. Comprueba que salen tantos archivos como entraron y que ninguno dura 0 segundos.
8. Subida, solo si el usuario la pide: o sube los archivos a mano, o monta un flujo en n8n que arranque cuando haya un archivo nuevo en la carpeta, pase por un paso de aprobación manual y solo después suba al alojamiento. Nunca una subida que se publique sola.

## Qué devolver
La carpeta procesado con los archivos nuevos y nombres claros, por ejemplo AAAA-MM-DD_nombre_v2.mp3.
Una tabla con una fila por archivo:
| Archivo | Duración antes | Duración después | Volumen antes | Volumen después | Tamaño | Observaciones |
|---|---|---|---|---|---|---|
El script guardado, para poder repetirlo, y una explicación de 5 líneas de lo que hace cada parte.
Una lista de lo que tiene que escuchar una persona antes de publicar.

## Qué NO hacer
- No uses la opción -y, que sobrescribe, ni borres archivos. Nunca lances comandos de borrado sobre carpetas del usuario.
- No proceses el lote entero sin haber probado con un archivo.
- No prometas calidad de estudio. Una limpieza fuerte deja la voz metálica. Si el audio está muy dañado, dilo.
- No subas nada a internet sin un sí expreso.
- No cortes frases ni reordenes el contenido si no te lo piden.
- No uses música ni efectos con derechos de autor. Si en el audio de un cliente suena música comercial, avísale: publicarla puede darle problemas.
- No clones ni imites voces.
- No instales programas de fuentes desconocidas.

## Qué revisa una persona
Alguien escucha el resultado, entero o por tramos, antes de publicar: cortes dentro de palabras, volumen, ruidos nuevos.
Si hay voces de invitados o de clientes, la voz es un dato personal. Tienen que haber dado permiso para publicarla.
Si vas a cobrar por ello, ten un contrato corto que diga qué entregas, cuántas revisiones incluye y quién conserva los originales.

Pieza revisada en octubre de 2026. Los requisitos de volumen y formato de cada plataforma cambian: confírmalos en su web.
