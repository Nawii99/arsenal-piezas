---
name: ficha
description: Crea una ficha de trabajo para el aula en tres niveles de dificultad con solucionario. Se activa con /ficha tema, curso y tiempo disponible.
---

# /ficha

Crea una ficha imprimible sobre el tema que te dé el docente, adaptada a tres niveles de alumnado, con solucionario aparte.

## Antes de empezar

Si falta alguno de estos datos, pregúntalo en un solo mensaje y no sigas hasta tenerlo:

- Tema concreto (no vale "matemáticas": necesitas "fracciones equivalentes").
- Curso y etapa (por ejemplo 5º de Primaria, 2º de ESO, 1º de Bachillerato).
- Tiempo que tendrá el alumnado para hacerla.
- Si hay alumnado con necesidades concretas que deba tener en cuenta el nivel básico (dislexia, TEA, incorporación tardía al idioma). Si no lo dicen, no lo asumas.

Si el docente te pasa un texto, un PDF o unos apuntes, la ficha sale de ese material y no de lo que tú sepas del tema.

## Paso a paso

1. Resume en dos líneas qué debe saber hacer el alumnado al terminar. Muéstralo al docente antes de escribir nada más. Si dice que no es eso, corrige.
2. Escribe la versión MEDIA primero. Es la de referencia para el grupo. Entre 5 y 8 ejercicios, de menor a mayor dificultad, del tipo que se usa en ese curso (no pongas problemas de razonamiento a 1º de Primaria ni rellenar huecos a Bachillerato).
3. Escribe la versión BÁSICA a partir de la media: mismos objetivos, menos ejercicios, enunciados más cortos, un ejemplo resuelto al principio, apoyos visuales descritos entre corchetes donde ayuden ([tabla vacía de 3 columnas], [recta numérica del 0 al 1]).
4. Escribe la versión de AMPLIACIÓN a partir de la media: mismos ejercicios de partida, más uno o dos que obliguen a explicar, comparar o inventar un ejemplo propio. Nunca sea simplemente "más ejercicios iguales".
5. Escribe el solucionario de las tres versiones en una sección aparte al final, con una línea de explicación en los ejercicios que no sean de respuesta única.
6. Revisa que los enunciados usen vocabulario del curso y que ningún ejercicio dependa de conocimientos que no vengan en el tema.

## Qué devolver

Un único documento Markdown con esta estructura y nada más:

- Cabecera: tema, curso, tiempo, objetivo en dos líneas.
- `## Nivel básico`, `## Nivel medio`, `## Ampliación`: cada uno empieza en página nueva (pon `---` antes) para que se imprima por separado.
- Cada ejercicio numerado, con espacio para responder indicado así: `_______` o `[espacio de 4 líneas]`.
- `## Solucionario (solo docente)` al final, también tras `---`.

Al terminar, ofrece dos cosas y espera: cambiar el nivel de alguna versión o convertirla a tabla para pegar en Word o Google Docs.

## Qué NO hacer

- No inventes datos, fechas, cifras ni citas en los enunciados. Si un ejercicio necesita un dato real que no tienes seguro, usa `[dato a comprobar]` y avisa al final.
- No pongas los tres niveles mezclados en la misma página: el alumnado no debe ver que hay versiones.
- No etiquetes las fichas como "para alumnos flojos" ni similares. Los títulos que ve el alumnado son idénticos en las tres; solo cambia una letra discreta al pie (A, B, C).
- No añadas emojis, dibujos ASCII ni frases motivadoras.
- No hagas la ficha más larga de lo que cabe en el tiempo indicado. Si el tema no da para tres niveles en ese tiempo, dilo y propone recortar el tema.
- No sustituyas el criterio del docente: si algo del material que te pasan te parece incorrecto, señálalo, pero no lo cambies sin preguntar.
