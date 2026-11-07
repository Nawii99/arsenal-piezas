---
name: comando-rubrica
description: Genera una rúbrica de evaluación (criterios x niveles) para una tarea concreta. Se activa con /comando-rubrica seguido de la descripción de la tarea y el curso.
---

# /comando-rubrica

Tarea a evaluar: $ARGUMENTS

Crea una rúbrica que el docente pueda usar tal cual para corregir esa tarea. Si en $ARGUMENTS falta el curso o el tipo de tarea, pregúntalo antes de escribir nada. Si falta el resto, usa lo que se indica por defecto.

## Cómo la construyes

1. Saca de la tarea entre 4 y 6 criterios. Cada criterio es UNA cosa observable ("Habla mirando al público", no "Comunicación"). Si el usuario menciona una competencia del currículo, úsala como criterio pero traducida a algo observable.
2. Usa 4 niveles con estos nombres, de mayor a menor: Excelente (4), Bien (3), En proceso (2), Necesita ayuda (1). Si el usuario pide otra escala o nombres, respétalos.
3. Escribe cada casilla como una descripción de lo que SE VE, no un adjetivo. Mal: "Buena pronunciación". Bien: "Se le entiende todo; duda en una o dos palabras".
4. Redacta primero la columna Excelente, después Necesita ayuda, y rellena las dos intermedias como pasos reales entre ambas. Así no salen cuatro casillas casi iguales.
5. Añade una columna final "Peso" con un porcentaje. Por defecto, reparto igual. Si el usuario dice qué es más importante, ajusta y comprueba que suma 100.
6. Debajo de la tabla, indica cómo pasar a nota de 0 a 10: suma de (nivel x peso) dividido entre 4. Pon un ejemplo con números.
7. Añade una versión para el alumnado: los mismos criterios en primera persona y en lenguaje de su edad ("Miro a mis compañeros cuando hablo"). Sirve para que sepan qué se les pide ANTES de hacer la tarea y para autoevaluarse.

## Qué devuelves

- Título: "Rúbrica: [tarea] - [curso]".
- Tabla en Markdown: primera columna criterios, luego los 4 niveles, última columna Peso.
- Fórmula de nota con ejemplo.
- Versión para el alumnado (lista con casillas [ ] para marcar).
- Dos frases de aviso al docente: qué criterio es más subjetivo y una sugerencia para que dos profesores corrijan parecido (por ejemplo, corregir juntos los dos primeros trabajos).

Si el usuario pide archivo, guárdalo como `rubrica-[tarea].md`. La tabla se pega directamente en Google Docs o Word y se convierte en tabla real.

## Qué NO hacer

- No pongas más de 6 criterios. Una rúbrica con 10 filas no la usa nadie corrigiendo 25 trabajos.
- No uses adjetivos vacíos en las casillas (bueno, regular, adecuado, correcto) sin decir qué se observa.
- No mezcles en un criterio dos cosas distintas ("ortografía y creatividad").
- No inventes referencias a decretos, leyes educativas o códigos de competencias concretos. Si el usuario los quiere, que los pegue él y los incorporas.
- No penalices en la rúbrica cosas que la tarea no pedía.
- No des por hecho el curso. Una rúbrica de 1º Primaria y una de 2º Bachillerato no se parecen en nada.
