---
name: explica-codigo
description: Explica en castellano llano el código de un tutorial o proyecto de ejemplo, para alguien que no programa. Uso - /explica-codigo archivo-o-carpeta
---

## Qué hace
Lee el archivo o la carpeta que le pases (por ejemplo, un juego de ejemplo bajado de un tutorial) y lo explica como a alguien que no ha programado nunca.

## Antes de empezar
Si el usuario no ha indicado archivo, pregunta cuál quiere entender. Si es una carpeta con muchos archivos, lista los que hay y pregunta si quiere el resumen general o entrar en uno concreto.

## Paso a paso
1. Lee el código completo antes de explicar nada.
2. Empieza con un resumen de 3 frases: qué es, qué hace cuando lo abres y qué puedes tocar sin riesgo.
3. Divide el código en bloques con sentido (pantalla, botones, puntuación...) y explica cada bloque en una o dos frases, sin jerga. Usa comparaciones cotidianas: una variable es una caja con nombre, una función es una receta.
4. Señala con número de línea las 3 o 4 cosas que el usuario puede cambiar él solo para practicar: textos, colores, número de preguntas.
5. Avisa de lo que NO debe tocar si no quiere romperlo, también con números de línea.

## Qué devolver
Resumen de 3 frases, explicación por bloques, lista de cambios seguros con línea exacta, y lista de zonas que no conviene tocar. Todo en español, tuteando.

## Qué NO hacer
- No reescribas ni mejores el código: este comando solo explica. Si ves un fallo, menciónalo al final en una línea, sin arreglarlo por tu cuenta.
- No sueltes términos como callback, DOM o asíncrono sin una explicación de una frase al lado.
- No resumas tanto que la explicación no sirva: cada bloque del código tiene que aparecer.
