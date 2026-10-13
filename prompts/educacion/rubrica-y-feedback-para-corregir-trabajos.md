# Rúbrica y feedback para corregir trabajos…

**Tipo:** Prompt · **Área:** Formación · **Licencia:** CC BY 4.0

Monta la rúbrica con la que corriges los ejercicios de tus alumnos y genera un feedback útil, coherente y rápido de escribir.

## Qué es y qué hace

Prompt para cualquier chat de IA que construye una rúbrica ponderada con 4 o 5 criterios y niveles descritos por lo que se ve, y un sistema de feedback rápido de escribir. Entran la tarea, el nivel y el tiempo por entrega; salen rúbrica, pesos y frases de comentario. Ejemplo: corregir 20 ejercicios en una tanda.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Rellena los [corchetes] con el ejercicio y las entregas por tanda
3. Usa la rúbrica y el banco de frases al corregir

## Cuándo usarla

Úsalo cuando tengas que corregir entregas de alumnos y cada corrección te lleve media hora o te salgan desiguales.

## Cómo ganar dinero con ella

Te permite corregir muchas más entregas por hora manteniendo la calidad, que es lo que separa una formación cara de una barata.

- Rúbricas y bancos de comentarios para formadores y tutores…
- Servicio de corrección de ejercicios para cursos de terceros…
- Plantillas de evaluación para centros de formación pequeños…

**Precio orientativo:** 70–220 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como formador con experiencia en evaluación por rúbricas y en dar feedback a adultos que pagan por aprender.
Formación: [NOMBRE Y TEMA].
Ejercicio que tienen que entregar los alumnos: [DESCRIBE LA TAREA CON DETALLE].
Qué demuestra el alumno si lo hace bien: [HABILIDAD CONCRETA].
Nivel del alumnado: [PRINCIPIANTE / INTERMEDIO / MIXTO].
Cuántas entregas corrijo por tanda: [NÚMERO] y tiempo que puedo dedicar a cada una: [MINUTOS].
Tu tarea: construir la rúbrica y el sistema de feedback.
PASO 1. Descompón la tarea en 4 o 5 criterios observables, no más. Nada de criterios vagos tipo creatividad o esfuerzo.
Cada criterio tiene que poder verse en la entrega sin conocer al alumno.
Asigna un peso en porcentaje a cada criterio y justifica el reparto en una línea.
PASO 2. Para cada criterio escribe 4 niveles de desempeño descritos por lo que se ve, no por adjetivos.
Nivel 4 logrado, nivel 3 casi, nivel 2 en camino, nivel 1 aún no. Describe cada nivel con un ejemplo concreto de cómo se ve en esta tarea.
Prohibido describir niveles con muy bien, bien, regular, mal. Tienen que ser descripciones de hechos observables.
PASO 3. Escribe la lista de los 6 errores más frecuentes que vas a encontrar en estas entregas, y para cada uno: por qué lo comete la gente y la frase exacta de corrección que se lo explica.
PASO 4. Crea la plantilla de feedback con esta estructura fija: qué has conseguido (2 líneas concretas y citadas de su trabajo), qué falla y por qué importa (1 problema, el más grave, no cinco), el arreglo exacto (qué cambiar, paso a paso), el siguiente reto (1 frase).
Regla de oro del feedback: un solo problema principal por entrega. Si señalas cinco, no arregla ninguno.
PASO 5. Dame 3 ejemplos completos de feedback ya escrito, uno para una entrega buena, uno para una regular y uno para una muy floja, usando la plantilla y sonando a persona, no a formulario.
En el caso de la entrega muy floja, muéstrame cómo se dice la verdad sin hundir a nadie: primero lo que sí funciona, luego el fallo, luego el camino de salida.
PASO 6. Dame el atajo: 8 frases de corrección reutilizables para los errores más comunes, listas para pegar y personalizar cambiando dos palabras.
RESTRICCIONES.
Nada de halagos vacíos como buen trabajo o sigue así, no enseñan nada.
No corrijas cosas que no estaban pedidas en el enunciado.
No uses jerga pedagógica con el alumno: la rúbrica es para mí, el feedback es para él.
Español de España, tuteando al alumno, tono de alguien que quiere que aprenda, no que se rinda.
FORMATO DE SALIDA.
1) Tabla de la rúbrica: criterios en filas, los 4 niveles en columnas, peso en porcentaje. 2) Lista de errores frecuentes con su frase de corrección. 3) Plantilla de feedback. 4) Los 3 ejemplos completos. 5) Las 8 frases reutilizables.
CRITERIOS DE CALIDAD, compruébalos tú antes de responder.
Dos formadores distintos usando esta rúbrica sobre la misma entrega tendrían que llegar a la misma nota, más o menos: si un criterio deja demasiado a la opinión, reescríbelo.
Cada nivel de la rúbrica se distingue del de al lado por algo que se puede ver, no por una cuestión de grado.
El feedback completo de una entrega se escribe en menos de [MINUTOS] usando la plantilla: si no, simplifícala.
Termina señalando el criterio más difícil de evaluar de tu propia rúbrica y cómo lo harías más objetivo.
```
