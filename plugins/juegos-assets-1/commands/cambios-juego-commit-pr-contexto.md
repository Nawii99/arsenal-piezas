---
name: cambios-juego
description: Prepara commits limpios, la descripción de un PR y un resumen del estado del repositorio en proyectos de videojuegos con muchos assets. Úsalo antes de subir cambios o de sacar una versión pública. Se usa con commit, pr o contexto como primer argumento.
---
# Cambios de juego, commit, PR y contexto

Argumentos recibidos: $ARGUMENTS
(La primera palabra elige el modo, que puede ser commit, pr o contexto. Si no hay ninguna, pregunta cuál.)

## Dónde guardarlo
Guarda este archivo como `.claude/commands/cambios-juego.md` en el repositorio del juego. Se usa con `/cambios-juego commit`, `/cambios-juego pr` o `/cambios-juego contexto`.

## Qué hace
- Modo commit: revisa los cambios pendientes, los separa por tipo (código, assets, configuración) y propone uno o varios commits con un mensaje claro.
- Modo pr: escribe la descripción de la Pull Request y una lista de comprobación para versiones públicas.
- Modo contexto: resume en una página el estado del repositorio para quien llega nuevo o para retomar mañana. Solo lee.

## Antes de empezar, pregunta (una vez)
1. Motor: Unity, Godot, Unreal, libGDX u otro.
2. Idioma de los mensajes de commit, español o inglés, y si hay guía de estilo en CONTRIBUTING.
3. Rama principal y si se trabaja con PR o directamente.
4. Si el repositorio es público o privado.
5. Si está instalado Git LFS, que sirve para archivos pesados.
6. Quién revisa los PR.
Al final pregunta si quiere que anotes las respuestas en `CLAUDE.md`. Si dice que no, no lo toques.

## Paso a paso, modo commit
1. Ejecuta `git status` y `git diff --stat`. No uses `git add -A` ni `git add .` a ciegas.
2. Agrupa los archivos: código, assets (imágenes, audio, modelos, escenas), configuración y generados.
3. Los generados (build, Library, Temp, .godot, Intermediate y similares) no se suben. Si aparecen, avisa y propón añadirlos a `.gitignore`.
4. Alertas antes de proponer nada.
   - Archivo de más de 50 MB, que GitHub avisa, o de más de 100 MB, que GitHub rechaza. Propón Git LFS, pero no lo montes tú.
   - Claves de firma (.keystore, .jks), `google-services.json`, `.env` o tokens. No se suben nunca.
   - Assets sin autor o sin licencia anotados: música, fuentes, sprites, sonidos.
   - Si es Unity: un asset sin su `.meta` o un `.meta` sin su asset.
5. Propón los commits: un tema por commit, con código y assets separados. Título de 72 caracteres como máximo, en imperativo. Si hace falta, un cuerpo breve que explique el porqué.
6. Enseña la lista de archivos de cada commit y su mensaje. Espera un «sí» antes de ejecutar `git commit`.
7. No hagas `git push`. Termina diciendo: «Los commits están en local. Súbelos tú cuando quieras».

## Paso a paso, modo pr
1. Mira la rama actual, la rama base y los commits que se van a incluir (`git log` y `git diff` contra la base).
2. Escribe la descripción con estos apartados.
   - Qué cambia para quien juega, en una o dos frases.
   - Qué cambia por dentro.
   - Cómo probarlo: nivel o escena, plataforma y pasos.
   - Capturas o vídeo: indica cuáles hacen falta y pon [ADJUNTAR]. No las inventes.
   - Assets nuevos: nombre, autor, licencia y enlace.
   - Riesgos: partidas guardadas que dejan de funcionar, rendimiento, tamaño de la build.
3. Si el PR va a una versión pública, añade esta lista y marca solo lo que hayas podido comprobar.
   - Licencias del material de terceros revisadas.
   - Sin claves ni datos privados en los commits del PR.
   - Número de versión y notas de cambios para jugadores.
   - Probada en un dispositivo real, no solo en el editor.
   - Si el juego lleva anuncios, analítica o pide datos: política de privacidad y consentimiento listos.
   - Si juegan menores: clasificación por edades revisada.
4. Si `gh` (GitHub CLI) está instalado y te lo piden, ofrece crear el PR con `gh pr create`. Pide confirmación antes: en un repositorio público, el PR lo ve todo el mundo. Si no, entrega el texto para pegar.

## Paso a paso, modo contexto
1. Solo lectura. Rama actual, últimos 10 commits, cambios sin guardar, ramas abiertas y, si `gh` está disponible, PR abiertos.
2. Estructura: qué carpetas hay y para qué sirve cada una, según sus nombres y el README. Tamaño aproximado de las carpetas de assets.
3. Cómo abrir y ejecutar el juego, si lo dice el README. Si no, di que no está documentado.
4. Pendientes que se vean en el código o en los commits (TODO, FIXME). Máximo 10.

## Qué devolver
- Modo commit: tabla con commit, archivos, mensaje y alertas. Después, qué has ejecutado y qué queda en local.
- Modo pr: texto listo para pegar en el PR, con los [ADJUNTAR] marcados, y aparte la lista de lo que no has podido comprobar.
- Modo contexto: una página como máximo, con apartados cortos y sin jerga.

## Qué NO hacer
- No hagas `git push`, `--force`, `reset --hard`, `rebase` ni `commit --amend` sobre cambios ya subidos.
- No uses `--no-verify` para saltarte comprobaciones.
- No instales Git LFS ni cambies `.gitattributes` sin permiso. Pasar a LFS archivos que ya están en el historial reescribe la historia. Eso lo hace una persona que sepa, con copia de seguridad.
- No borres assets ni ramas.
- No subas claves, aunque te lo pidan con prisa. Para y avisa.
- No inventes licencias ni autores de assets. Si no consta, escribe [SIN LICENCIA CONSTADA].
- No afirmes que la build funciona si no la has probado.

## Cuándo pedir a una persona
- Si una clave ya se subió al repositorio: cámbiala en el servicio de origen. Borrar el archivo no basta, porque queda en el historial.
- Si el historial pesa demasiado o hay archivos de más de 100 MB atascados: un técnico con Git LFS.
- Si vas a publicar con música, fuentes o gráficos de terceros sin licencia clara, puede ser un problema de derechos de autor. Pide permiso al autor o consulta a un abogado antes de publicar.
