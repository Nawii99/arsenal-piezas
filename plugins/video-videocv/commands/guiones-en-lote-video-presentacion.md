---
name: guiones-en-lote-video-presentacion
description: Genera varios guiones de vídeo de presentación a partir de una lista de personas (CSV o tabla), uno por archivo y con la misma estructura, y una hoja de control. Úsalo cuando tengas que preparar guiones en serie para un equipo, una clase o una tanda de candidatos.
---
# Guiones de vídeo en lote

Argumentos recibidos: $ARGUMENTS
(Es la ruta de tu lista, por ejemplo equipo.csv. Si está vacío, pregunta cuál es.)

## Dónde guardarlo
Guarda este archivo como `.claude/commands/guiones-en-lote.md` dentro de la carpeta de tu proyecto. Para tenerlo en todos tus proyectos, guárdalo en `~/.claude/commands/`. Luego escribe `/guiones-en-lote-video-presentacion equipo.csv` en Claude Code.

## Qué hace
Lee una lista de personas y escribe un guion de vídeo de presentación para cada una. Todos con la misma estructura, cada uno en su archivo, y una hoja de control al final. Para un solo guion no hace falta: pídeselo a Claude directamente.

## Qué necesitas
- Una lista en CSV (Excel te deja guardarlo así), o una tabla en un archivo de texto. Una fila por persona.
- Columnas útiles: nombre, puesto o curso, dos o tres cosas que hace o ha hecho, qué busca o qué ofrece, y una columna «consentimiento» con sí o no.
- Todo lo que salga en un guion tiene que estar en esa lista. Claude no sabe nada más de esas personas.

## Antes de empezar, pregunta (una sola vez para toda la tanda)
1. Para qué es el vídeo: presentación de empleado nuevo, de alumno, de candidato u otra.
2. Dónde se va a ver: web interna, LinkedIn, Reels, TikTok, YouTube, WhatsApp.
3. Duración objetivo por vídeo, en segundos. Calcula unas 130 palabras por minuto hablado. Es orientativo: ajústalo tras la primera grabación.
4. Tono: cercano, profesional o formal. Tuteo o usted.
5. Quién revisa los guiones antes de grabar.
6. Si existe `guiones/ajustes.md`, léelo y pregunta solo lo que falte. Guarda ahí las respuestas para la próxima vez.

## Paso a paso
1. Abre la lista. Cuenta las filas y enseña las columnas que has encontrado. Pide confirmación.
2. Señala problemas antes de escribir nada: filas repetidas, campos vacíos, filas sin consentimiento o con «no».
3. Salta las filas sin consentimiento claro. Anótalas en la hoja de control como «saltada».
4. Escribe un único guion de prueba, el de la primera fila válida. Enséñalo y espera. No sigas hasta que digan que vale o te den cambios.
5. Aplica los cambios a la plantilla y genera el resto, uno a uno, sin mezclar datos de unas personas con los de otras.
6. Si hay más de 20 filas, trabaja en tandas de 10 y para a preguntar al acabar cada tanda.
7. Guarda cada guion en `guiones/AAAA-MM-DD/NN-nombre-apellido.md`, sin tildes ni espacios. Si el archivo ya existe, no lo pises: añade `-v2`.
8. Revisa cada guion contra su fila. Cada dato tiene que estar en la lista, las palabras tienen que cuadrar con la duración y no puede haber frases de promesa como «el mejor» o «te garantizo». Corrige lo que falle.
9. Crea `guiones/AAAA-MM-DD/_control.md` con una tabla: número, persona, palabras, duración estimada, datos por confirmar y estado (listo, revisar o saltada).

## Estructura de cada guion
- Cabecera: persona, duración objetivo, plataforma y fecha.
- Gancho (primeros 5 segundos): una frase que diga quién es y qué aporta.
- Cuerpo: dos o tres ideas sacadas de su fila, una frase corta cada una.
- Cierre: una invitación concreta, como escribirle, ver su trabajo o contactar.
- Texto en pantalla: nombre y puesto, y como mucho una frase más.
- Indicaciones de plano entre corchetes, solo si ayudan a grabar. Ejemplo: [plano medio, mirando a cámara].
- Datos por confirmar: lista de lo que has tenido que dejar como [FALTA: ...].

## Qué devolver
En el chat, al terminar: cuántos guiones has hecho, cuántos saltados y por qué, cuántos tienen datos por confirmar y la ruta de la carpeta. No pegues los guiones enteros en el chat.

## Lanzarlo desde la terminal (opcional)
Cuando ya lo hayas probado a mano, puedes repetirlo sin abrir la conversación. Claude Code tiene un modo sin pantalla, por ejemplo: `claude -p "Sigue las instrucciones de .claude/commands/guiones-en-lote.md con el archivo equipo.csv"`.
- En ese modo no puede preguntarte. Por eso necesita que `guiones/ajustes.md` ya esté hecho.
- Hay que darle permiso para escribir archivos. Que lo configure alguien técnico; no abras permisos amplios por probar.
- Cada ejecución gasta de tu plan o de tu API. Prueba con dos filas antes de lanzar la lista entera.
- Si no te apañas con la terminal, usa solo el modo normal. Funciona igual.

## Qué NO hacer
- No inventes cargos, logros, cifras, estudios ni opiniones. Si falta algo, escribe [FALTA: ...].
- No busques a esas personas en internet ni completes su perfil con datos de fuera de la lista.
- No uses datos de menores si no consta la autorización de sus padres o tutores. Si hay cursos de menores y no hay columna de autorización, para y pregunta.
- No modifiques ni borres la lista original.
- No publiques, envíes ni subas nada a redes ni a la web. Solo escribes archivos.
- No prometas resultados, como «con este vídeo te contratarán».
- No repitas la misma frase de gancho en todos los guiones: se nota.

## Cuándo pedir a una persona
- Salir en un vídeo afecta al derecho a la propia imagen y a la protección de datos. Cada persona tiene que saber para qué se usará su vídeo y haber dado su permiso.
- En una empresa, el consentimiento de un empleado tiene matices, porque la relación de trabajo no es entre iguales. Que lo revise quien lleve la protección de datos.
- Si cobras por esto, el cliente decide qué datos de su gente te pasa. Pídele que lo confirme por escrito y borra la lista cuando acabes el encargo.
