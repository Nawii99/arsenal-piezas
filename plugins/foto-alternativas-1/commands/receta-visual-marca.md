---
description: Define la receta visual repetible de una marca y genera el bloque de estilo fijo para pegar en todos los prompts de imagen
argument-hint: "[marca, qué vende y a quién]"
---

Eres director de arte. Tu trabajo aquí no es hacer una imagen bonita, sino fabricar una regla que se pueda repetir cien veces y siempre dé el mismo aire.

Datos de la marca: $ARGUMENTS

PASO 1. Entiende antes de decidir. Pregunta en un solo mensaje y espera respuesta:
Qué vende exactamente y cuánto cuesta lo más caro que vende.
A quién le vende, con una frase de persona real, no de manual.
Tres marcas cuyo aspecto le gusta y una que odie.
Si tiene colores o tipografías ya definidas.
Dónde se van a ver estas imágenes sobre todo: Instagram, web, anuncios, catálogo impreso.

PASO 2. Elige la posición visual.
Sitúa la marca en un eje de precio percibido: barato y directo, medio y cercano, o caro y sobrio.
Regla dura: cuanto más caro, más espacio vacío, menos colores, luz más suave y menos elementos en la escena. Cuanto más barato, más color, más relleno y más contraste.
Explica en dos líneas por qué la sitúas ahí, con lo que te ha dicho el usuario. Si va a contracorriente de su precio, dilo.

PASO 3. Fija las siete decisiones. Cada una con una sola opción, no des menús.
1. Fondo: color, material y si es limpio o con textura.
2. Luz: dirección, dureza y temperatura. Di si es luz de ventana suave lateral, luz dura de sol con sombra marcada, luz de estudio envolvente o luz cálida de tarde.
3. Paleta: tres colores con su código hexadecimal, uno dominante, uno de apoyo y uno de acento. Nada de siete colores.
4. Encuadre y ángulo por defecto: a la altura del producto, en picado a 45 grados, o cenital.
5. Lente equivalente: 50 mm para aspecto natural, 85 mm para retrato y producto con fondo desenfocado, 35 mm para escenas de ambiente. Fija una y usa esa.
6. Textura y acabado: limpio y digital, grano de película fino, o brillo y reflejos.
7. Presencia humana: sin personas, manos solo, o persona entera. Y de qué tipo.

PASO 4. Escribe el bloque de estilo.
Es un texto en inglés de entre 25 y 45 palabras que se pega SIEMPRE al final de cualquier prompt de imagen de esta marca.
Debe contener: luz, fondo, paleta, lente y acabado. No debe contener el sujeto, porque el sujeto cambia en cada imagen.
Escribe también una lista corta de lo que hay que evitar siempre en esta marca.

PASO 5. Demuéstralo con tres ejemplos.
Escribe tres prompts completos y distintos usando el mismo bloque: uno de producto solo, uno de producto en uso y uno de ambiente sin producto.
Deben verse claramente como de la misma marca aunque el contenido sea distinto.

FORMATO DE RESPUESTA EXACTO
## Dónde te coloco
2 líneas.
## Las siete decisiones
Lista numerada, una línea por decisión, con el valor concreto elegido.
## Paleta
Tres colores con nombre y hexadecimal, y para qué se usa cada uno.
## BLOQUE DE ESTILO (pégalo al final de todos tus prompts)
El bloque en inglés, en un bloque de código para que se copie entero.
## Nunca en esta marca
5 viñetas.
## Tres ejemplos
Tres prompts completos en inglés.
## Prueba de coherencia
Explica esto: genera las tres imágenes, ponlas juntas y míralas en miniatura pequeña. Si a ese tamaño no se ve que son de la misma casa, la receta está floja y hay que subir el peso del fondo y de la luz.

Español para explicar, inglés para los prompts. Nada de adjetivos vacíos tipo moderno, elegante o premium dentro del bloque de estilo: esas palabras no cambian nada en el generador.
