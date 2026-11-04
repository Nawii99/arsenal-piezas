---
name: ficha-de-trabajo-clase
description: Crea una ficha de ejercicios imprimible (una o dos caras) a partir de tema, curso y minutos disponibles. Se activa cuando el usuario pide una ficha, hoja de ejercicios, actividad de repaso o tarea para casa.
---

# Ficha de trabajo para clase

Produces una ficha que un docente puede imprimir y repartir sin retocarla. Ejercicios variados, enunciados claros, espacio para responder y soluciones en hoja aparte.

## Antes de empezar, pregunta (solo lo que falte)

1. Tema concreto. No vale "matemáticas": hace falta "suma de fracciones con distinto denominador".
2. Curso y etapa. Usa los nombres del sistema español: Infantil, Primaria (1º a 6º), ESO (1º a 4º), Bachillerato, FP.
3. Minutos que tendrán para hacerla. Marca el número de ejercicios: unos 2-3 minutos por ejercicio sencillo, 5-8 por uno de razonar.
4. Para qué es: repaso en clase, deberes, evaluación inicial o refuerzo para quien va más flojo.
5. Si hay alumnado con necesidades de apoyo (dislexia, TDAH, recién llegados con poco español). Si lo hay, ajusta lo que se indica más abajo.

Si el usuario ya ha dado todo esto, no preguntes: empieza.

## Paso a paso

1. Escribe el objetivo de aprendizaje en una frase ("Al terminar, el alumno sabe..."). Va al principio de la ficha, en pequeño, para el docente.
2. Diseña los ejercicios en escalera de dificultad:
   - Primer tercio: mecánicos, para coger confianza.
   - Segundo tercio: aplicar en un caso con contexto (compra, recetas, deportes, situaciones de aquí).
   - Último tercio: uno o dos de razonar o explicar con sus palabras.
3. Varía el formato: rellenar huecos, unir con flechas, verdadero/falso con justificación, problema abierto, dibujar o completar una tabla. No pongas diez ejercicios iguales.
4. Deja espacio real para responder. Indica con líneas (____) o con un recuadro dónde escribir. Un ejercicio de desarrollo necesita al menos 4-5 líneas.
5. Añade un ejercicio final opcional marcado como "Si te sobra tiempo" para quien acaba antes.
6. Escribe las soluciones en una sección separada con un salto de página antes, para que el docente pueda imprimir solo la primera parte.
7. Si hay alumnado con necesidades de apoyo: frases más cortas, un solo verbo por instrucción, ejemplo resuelto al inicio de cada bloque, y marca qué ejercicios son los imprescindibles con un asterisco.
8. Revisa cada solución haciendo el ejercicio tú de nuevo. Si un resultado no te cuadra, corrige el enunciado, no la solución.

## Qué devuelves

Un único bloque en Markdown con esta estructura:

- Cabecera: título de la ficha, curso, asignatura, línea para nombre y fecha.
- Objetivo (una frase, en cursiva).
- Ejercicios numerados, con espacio para responder.
- Ejercicio extra "Si te sobra tiempo".
- Salto de página (línea con `---`) y sección SOLUCIONES con una explicación breve donde no sea obvio.
- Al final, fuera de la ficha, dos líneas para el docente: cuántos minutos se estima y qué ejercicio suele costar más.

Si el usuario quiere el archivo, escríbelo como `ficha-[tema]-[curso].md`. Desde ahí se pasa a Word o a Google Docs pegando el texto; las tablas de Markdown se convierten bien.

## Qué NO hacer

- No metas más ejercicios de los que caben en el tiempo indicado. Mejor 6 bien hechos que 15 a medias.
- No uses contextos de otros países (dólares, millas, Thanksgiving). Euros, kilómetros, cosas de aquí.
- No inventes datos históricos, científicos o fechas si no estás seguro. Ponlos como [DATO A COMPROBAR] y avisa al docente.
- No incluyas nombres de alumnos reales ni pidas datos personales para personalizar.
- No escribas las soluciones mezcladas con los ejercicios. Siempre en sección aparte.
- No pongas enunciados con dobles negaciones ni con dos preguntas dentro de la misma frase.
- No copies ejercicios de libros de texto con derechos. Si el usuario pega uno, úsalo solo como referencia de nivel.
