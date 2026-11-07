---
name: rubrica-correccion
description: Crea una rúbrica de evaluación para una tarea de un curso y redacta comentarios para cada alumno según ella. Úsala cuando el usuario necesite calificar, corregir o revisar entregas de alumnos, ejercicios prácticos o deberes, o quiera criterios coherentes para evaluar el trabajo.
---

# Rúbrica y corrección de entregas

## Qué hace
Dos cosas, en este orden: (1) construye la rúbrica del ejercicio, es decir la tabla de criterios con la que se corrige; (2) con esa rúbrica ya hecha, corrige entregas concretas y redacta el feedback para el alumno.

## Cuándo se activa
Cuando el usuario habla de corregir, evaluar, puntuar, revisar prácticas, dar nota, dar feedback a alumnos, o dice que tarda muchísimo en corregir.

## Qué preguntar si falta información
Pregunta solo lo imprescindible, máximo cuatro cosas de una vez:
1. ¿Qué se pide exactamente en el ejercicio? (pega el enunciado tal cual)
2. ¿Qué nivel tienen los alumnos: primer contacto, intermedio, profesionales?
3. ¿La nota es numérica (0-10), apto/no apto, o solo feedback sin nota?
4. ¿Cuánto tiempo puedes dedicar a cada corrección?
Si no contesta, asume: nivel principiante, 0-10, 10 minutos por entrega, y dilo al empezar.

## Método para construir la rúbrica
Paso 1. Saca del enunciado los OBJETIVOS reales. Un enunciado bien hecho tiene entre 3 y 5. Si el enunciado pide siete cosas, el problema es el enunciado y hay que decírselo.
Paso 2. Convierte cada objetivo en un criterio observable. Un criterio vale si dos correctores distintos puntúan casi igual mirando la entrega. «Creatividad» no vale. «Propone al menos dos alternativas y justifica la elegida» sí vale.
Paso 3. Pesos. Reparte 100 puntos entre los criterios. Regla de oficio: lo que de verdad enseña el ejercicio se lleva el 60-70%; presentación y forma, nunca más del 15%. Si la ortografía pesa más que el fondo, has hecho una rúbrica de secretaría, no de formación.
Paso 4. Niveles. Usa cuatro por criterio y descríbelos con conducta, no con adjetivos: Excelente / Correcto / Insuficiente / No presentado. Escribe qué se ve en la entrega en cada nivel, no «muy bien / bien / regular».
Paso 5. Define el aprobado. Marca el mínimo (ej. 50 puntos) y los criterios eliminatorios, si los hay: aquellos que si están en «Insuficiente» suspenden aunque el total sume. Esto evita la discusión clásica de «pero si tengo 6».
Paso 6. Prueba la rúbrica con una entrega real antes de usarla con todos. Si al corregir necesitas inventar un criterio nuevo, la rúbrica estaba incompleta: arréglala antes de seguir, no a mitad de la tanda.

## Método para corregir una entrega
Paso 1. Lee la entrega entera una vez sin puntuar. No corrijas mientras lees por primera vez.
Paso 2. Puntúa criterio a criterio, en el orden de la rúbrica, y anota la evidencia: la frase, la línea o el trozo concreto que justifica el nivel.
Paso 3. Escribe el feedback con esta estructura fija: (a) una frase de lo que ha hecho bien de verdad, concreta; (b) los dos errores que más le lastran, con la evidencia y con la corrección hecha, no solo señalada; (c) UNA acción para la siguiente entrega; (d) la nota y el desglose.
Paso 4. Ojo con el orden de corrección: si corriges siempre en el mismo orden alfabético, los últimos reciben peor nota por cansancio. Baraja el orden y descansa cada 8-10 entregas.

## Formato exacto de la respuesta
Cuando construyas la rúbrica, devuelve:
- Tabla en Markdown con columnas: Criterio | Peso | Excelente | Correcto | Insuficiente | No presentado
- Debajo: «Aprobado a partir de X puntos» y la lista de criterios eliminatorios.
- Debajo: «Frases de feedback listas» — 3 frases reutilizables por criterio y nivel, para copiar y pegar.
Cuando corrijas una entrega, devuelve:
- Bloque «Puntuación»: una línea por criterio con puntos obtenidos sobre el peso y la evidencia entre comillas.
- Bloque «Feedback para el alumno»: texto seguido, tuteando, entre 120 y 200 palabras, listo para pegar en el email o en la plataforma.
- Bloque «Nota final»: número y una línea de veredicto.

## Errores típicos
- Rúbricas de 12 criterios: nadie las usa a la tercera corrección. Máximo 6.
- Niveles descritos con adjetivos vacíos: no reducen la discusión con el alumno, que es para lo que sirve la rúbrica.
- Feedback que solo dice lo que está mal. Sin una acción concreta el alumno repite el fallo.
- Copiar el mismo párrafo a todos: se nota en cuanto dos alumnos lo comparan, y lo comparan siempre.
- Puntuar el esfuerzo. El esfuerzo no se ve en la entrega; se ve el resultado.

## Avisos honestos
- Una rúbrica no elimina las reclamaciones, las hace defendibles. Guarda la rúbrica publicada ANTES de la entrega: si la enseñas después, la reclamación la ganan ellos.
- Si el curso es oficial o reglado, los criterios de evaluación pueden estar fijados por normativa; esta rúbrica es para formación privada.
- No puedo corregir lo que no veo: si la entrega es un vídeo, un audio o un archivo que no me pasas en texto, pídeme la corrección sobre lo que sí puedas pegar o descríbemelo tú.
