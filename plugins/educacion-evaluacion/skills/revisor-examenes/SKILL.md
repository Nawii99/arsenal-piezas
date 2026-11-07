---
name: revisor-examenes
description: "Revisa un examen ya redactado (preguntas, opciones y clave) y detecta los fallos más comunes antes de publicarlo: preguntas ambiguas, opciones absurdas fáciles de descartar, falta de variedad de dificultad, desajuste con lo que se ha enseñado y clave de corrección incompleta. Se activa cuando el usuario pide revisar, pulir o validar un examen."
---

## Qué hace
Recibe un examen ya escrito (preguntas con sus opciones, o preguntas de desarrollo) y devuelve una lista de problemas concretos, pregunta por pregunta, con una corrección propuesta para cada uno. No reescribe el examen entero sin que se le pida: señala y propone, decide el usuario.

## Qué preguntar antes de empezar
Si no viene en el mensaje, pregunta estas tres cosas antes de revisar nada: qué temario o unidad concreta han estudiado los alumnos, cuánto tiempo dura el examen, y si la clave de corrección ya existe o hay que generarla también.

## Paso a paso
1. Lee el examen completo antes de comentar nada, pregunta por pregunta no vale.
2. Por cada pregunta de opción múltiple: comprueba que ninguna opción se pueda descartar solo por estar mal escrita o ser absurda (ejemplo: una opción larga y detallada frente a tres cortas y vagas delata la correcta).
3. Comprueba que las preguntas no repiten todas el mismo nivel de dificultad: un examen entero de memorizar sin ninguna que pida aplicar o razonar es un fallo típico.
4. Comprueba que cada pregunta corresponde a algo que de verdad se ha explicado en el temario indicado, no a un tema relacionado pero no dado.
5. Comprueba que hay clave de corrección para todas las preguntas, incluidas las de desarrollo (con qué se considera respuesta correcta o parcial).
6. Calcula si el tiempo dado es realista: cuenta las preguntas de desarrollo como mínimo 3-4 minutos cada una y las de opción múltiple como 1 minuto, y avisa si no cuadra con la duración indicada.
7. Revisa el lenguaje de los enunciados: una pregunta con doble negación o redacción confusa no mide lo que se ha estudiado, mide si el alumno entendió la pregunta.

## Qué devolver
Una lista numerada igual al número de preguntas del examen. En cada línea: número de pregunta, el problema detectado (o 'sin problemas'), y la corrección propuesta en una frase. Al final, un resumen de tres líneas: nivel de dificultad general, si el tiempo es realista, y si falta clave de corrección.

## Qué NO hacer
No inventes que una pregunta está mal si no hay un motivo concreto que se pueda explicar al profesor. No cambies el enfoque pedagógico del examen (memorización vs. aplicación) sin que se pida, solo señala el desequilibrio si lo hay. No generes una clave de corrección para preguntas de desarrollo con una única respuesta cerrada: da criterios, no una frase exacta a copiar. No asumas el nivel educativo (primaria, secundaria, universidad, formación de adultos) si no te lo han dicho, pregúntalo.
