---
name: corregir-lote-ejercicios
description: Corrige un lote de examenes o ejercicios de alumnos contra una rubrica y devuelve nota y feedback de cada uno. Se activa cuando el usuario pide corregir varios trabajos a la vez.
---

# Corregir lote de ejercicios

## Qué hace
Corrige automáticamente un grupo de exámenes, ejercicios o trabajos de alumnos comparando cada uno con una rúbrica de corrección. Da una nota y un comentario por alumno, y un resumen del grupo entero.

## Qué preguntar antes de empezar
- Dónde están los archivos de los alumnos (carpeta, y en qué formato: PDF, Word, texto, fotos escaneadas)
- Dónde está la rúbrica de corrección, o si hay que crearla primero
- La escala de notas (0-10, apto/no apto, letras)
- Si hay que anonimizar los nombres en el resultado final
- Si los archivos contienen datos de menores de edad, para no compartirlos fuera de esta conversación

## Paso a paso
1. Lee la rúbrica y confirma los criterios y sus pesos antes de tocar ningún examen.
2. Abre cada archivo de alumno uno a uno, en el mismo orden que están en la carpeta.
3. Para cada uno, aplica cada criterio de la rúbrica por separado, sin saltarte ninguno.
4. Si una parte del ejercicio está en blanco o falta, puntúala como 0 en ese criterio y anótalo.
5. Calcula la nota final según la fórmula de la rúbrica, normalmente una suma ponderada.
6. Escribe un comentario breve y constructivo para el alumno, y otro aparte solo para el profesor con dudas o incidencias.
7. Repite con todos los archivos antes de generar el resumen final.

## Qué devolver y en qué formato
- Una tabla en Markdown con: nombre del alumno, nota final, y referencia al archivo original.
- Un informe por alumno debajo de la tabla, con el desglose por criterio y los dos comentarios.
- Un resumen del grupo: nota media, cuántos aprueban, y qué criterio ha fallado más veces en general.

## Qué NO hacer
- No inventes ni completes respuestas que el alumno no ha escrito.
- No cambies los pesos ni los criterios de la rúbrica aunque te parezcan injustos.
- No pongas nota si no puedes leer el archivo: dilo y pide que se revise a mano.
- No compartas ni subas los datos de los alumnos a ningún sitio fuera de esta tarea.
- No corrijas con una rúbrica distinta a la que te ha dado el profesor sin avisar antes.
