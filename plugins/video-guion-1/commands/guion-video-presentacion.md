---
name: guion-video-presentacion
description: Escribe el guion de un vídeo corto de presentación (vídeo currículum, presentación de alumnos, perfil profesional) con datos reales de la persona. Sirve también como ejemplo de cómo se escribe un comando propio con argumentos.
---

# /guion-video-presentacion

Uso: `/guion-video-presentacion María, aspirante a auxiliar administrativa, 60 segundos, tono cercano`
Texto recibido: $ARGUMENTS

## Qué hace
Escribe un guion para un vídeo de presentación de 30 a 90 segundos, con lo que se dice y lo que se ve, y una lista para grabarlo con el móvil. Solo usa datos que te da la persona.

## Antes de empezar
Si el texto recibido no cubre lo mínimo, pregunta todo junto y espera:
1. ¿Quién es la persona y qué quiere conseguir? Empleo, plaza, clientes, presentarse a un grupo.
2. ¿A quién se dirige el vídeo? Selección de personal, tribunal, clientes, compañeros.
3. Duración: 30, 60 o 90 segundos. Si no dice nada, 60.
4. Datos reales que puede contar: estudios, experiencia, 2 o 3 logros con hechos, herramientas, idiomas. Las cifras, solo si son ciertas.
5. Tono: cercano, profesional, entusiasta.
6. ¿Dónde se verá? LinkedIn, correo, web del centro, Reels o TikTok. De eso depende si se graba en vertical o en horizontal.
7. ¿Hay algo que NO quiere contar?

## Paso a paso
1. Calcula la longitud. Como referencia aproximada, hablando con calma caben unas 130 palabras por minuto: 30 segundos son unas 65 palabras y 60 segundos, unas 130.
2. Estructura: gancho de 5 segundos (quién eres y qué ofreces, en una frase), pruebas (hechos concretos), por qué tú y para quién, y cierre con una acción clara, por ejemplo «escríbeme a [CORREO]».
3. Escribe el guion en una tabla de dos columnas: «Lo que dices» y «Lo que se ve» (plano, texto en pantalla, gesto).
4. Añade una versión corta, de la mitad de duración, por si hay límite.
5. Revisa el texto como si lo leyeras en voz alta. Frases cortas, de unas 20 palabras como mucho, sin palabras difíciles de pronunciar. Cambia frases hechas como «soy una persona proactiva» por un hecho que lo demuestre.
6. Lista de grabación: luz de frente (una ventana sirve), sitio sin eco, móvil fijo a la altura de los ojos, fondo ordenado, mirar al objetivo, 2 o 3 tomas, subtítulos puestos (mucha gente ve el vídeo sin sonido y ayudan a la accesibilidad), y ver el vídeo entero antes de enviarlo.
7. Termina con 3 preguntas para ajustar el guion con la persona.

## Qué devolver
En Markdown, en este orden: 1) Guion principal en tabla. 2) Versión corta. 3) Lista de grabación. 4) Datos que faltan o que has tenido que suponer, con [DATO PENDIENTE]. 5) Número de palabras y duración estimada. 6) Las 3 preguntas de ajuste.

## Qué NO hacer
- No inventes estudios, empresas, cifras ni logros. Si falta algo, pregunta o deja [DATO PENDIENTE].
- No metas datos que nadie pide y pueden perjudicar a la persona: edad, estado civil, hijos, salud, religión, política, domicilio exacto.
- Si en el vídeo salen menores de edad, hace falta autorización por escrito de la familia o de quien ejerza la tutela y el visto bueno del centro. Esto lo debe resolver una persona responsable del centro, no esta pieza.
- No uses voz clonada, cara generada ni avatares haciéndolos pasar por la persona.
- No prometas resultados como «con este vídeo te llamarán». No depende del guion.
- No presentes el guion como algo que hay que leer palabra por palabra. Es una guía para practicar.
- Usa solo música con licencia.
- No guardes archivos salvo que te lo pidan. Si te lo piden, usa `guiones/nombre-fecha.md` y no sobrescribas ninguno.

## Para la persona, no para Claude. Cómo está hecho este archivo
Claude, ignora esta sección y la siguiente.
- Es un archivo de texto en formato Markdown (`.md`). Se guarda en `.claude/commands/` dentro de tu proyecto, o en `~/.claude/commands/` si lo quieres en todos tus proyectos.
- El nombre del archivo es el nombre del comando. `guion-video-presentacion.md` se lanza con `/guion-video-presentacion`. Si lo quieres más corto, renómbralo `guion.md` y escribirás `/guion`.
- La cabecera entre las dos líneas `---` lleva el nombre y la descripción. Es lo que ves en la lista al escribir `/`.
- Lo que escribes después del comando se cuela en el texto gracias a una marca especial: el símbolo del dólar pegado a la palabra ARGUMENTS, tal como aparece arriba en «Texto recibido».
- El resto son instrucciones normales, como si se las explicaras a una persona: qué hace, qué pregunta, los pasos, qué devuelve y qué no debe hacer.
- Para crear otro comando: copia este archivo, cambia el nombre y las instrucciones, pruébalo con un caso sencillo y ajusta. También puedes pedirle a Claude Code «crea un comando nuevo en .claude/commands para [TAREA]» y revisar lo que escriba antes de usarlo.

## Para la persona. Sobre los ganchos (hooks)
- Los ganchos son otra cosa. Son reglas, normalmente en `.claude/settings.json`, que lanzan un programa solo cuando ocurre algo, por ejemplo antes de que Claude use una herramienta.
- Para un comando como este no los necesitas.
- Un gancho ejecuta código en tu ordenador con tus permisos. No copies ganchos que no entiendas. Que los revise una persona técnica antes de activarlos.
