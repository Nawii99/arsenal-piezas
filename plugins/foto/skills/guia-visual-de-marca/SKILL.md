---
name: guia-visual-de-marca
description: Builds a reusable visual style sheet and prompt block so every generated image looks like it comes from the same brand. Use when generated images look inconsistent, when starting to produce content at volume, or when several people generate images for the same brand.
---

# Guía visual: que todo parezca de la misma marca

## Qué hace
Define en una página los seis o siete parámetros visuales de tu marca y los convierte en un bloque de texto que pegas al final de cualquier prompt de imagen. Resultado: todas tus fotos, aunque sean de productos distintos, parecen de la misma casa.

## Cuándo se activa
Cuando el usuario dice que sus imágenes «no pegan entre sí», que el feed se ve desordenado, cuando va a producir muchas imágenes seguidas, o cuando quiere que otra persona genere imágenes con su estilo.

## Los parámetros que hay que fijar (y solo estos)
1. Luz: tipo, dirección y dureza. Ejemplo: `soft diffused window light from the left, gentle falloff`.
2. Temperatura de color: cálida, neutra o fría. Se nota más que ninguna otra cosa y es lo primero que rompe la coherencia.
3. Fondo: material y color exactos. `warm beige microcement`, `matte off-white paper`, `dark walnut wood`.
4. Paleta: dos colores dominantes y un acento, con su código HEX.
5. Óptica y encuadre: distancia focal y ángulo habitual. `50mm, eye level, medium shot` o `85mm, slight top-down`.
6. Textura y acabado: limpio de estudio, grano de película suave, contraste medio, negros levantados o negros profundos.
7. Presencia humana: sin personas, solo manos, personas de cuerpo entero. Elige una y mantenla.

## Método paso a paso
1. Reúne de 10 a 15 imágenes que te gusten y que puedan convivir. Pueden ser de otras marcas; se copia el clima, no el diseño.
2. Descarta hasta quedarte con 6. Las que sobreviven a esa criba definen tu estilo de verdad.
3. Escribe en una frase qué tienen en común esas 6. Si no puedes, es que no lo tienen y hay que volver a elegir.
4. Rellena los siete parámetros con palabras concretas, nada de «moderno», «elegante» o «premium»: eso no lo entiende ningún generador ni ningún diseñador.
5. Monta el bloque de estilo: una sola línea con luz + fondo + paleta + óptica + acabado. Ese bloque va al final de todos tus prompts, detrás del sujeto.
6. Prueba de fuego: genera cinco sujetos completamente distintos con el mismo bloque, ponlos en cuadrícula de 5 y mira si parecen hermanos. Si uno desentona, ajusta un solo parámetro y repite.
7. Fija la semilla (seed) cuando el generador lo permita y anótala. Con la misma semilla y el mismo bloque, la coherencia sube mucho.
8. Guarda dos o tres imágenes aprobadas como referencia de estilo para usarlas como imagen de referencia en los generadores que lo admitan.

## Qué preguntar si falta información
- ¿Tiene ya colores de marca, tipografía o logo? Pide los HEX.
- ¿Qué vende y a quién? Un estilo de luz dura y contraste alto no vale para una clínica infantil.
- ¿Dónde se van a ver estas imágenes: Instagram, web, anuncios, catálogo impreso?
- ¿Hay algo prohibido: personas, animales, ciertos colores, competencia directa a la que no parecerse?

## Formato exacto de la respuesta
1. Ficha de estilo: los siete parámetros, uno por línea, en español y con su equivalente en inglés para el prompt.
2. El BLOQUE DE ESTILO en una sola línea en inglés, listo para copiar y pegar.
3. Tres ejemplos completos de prompt con sujetos distintos usando ese bloque.
4. Lista de lo que NUNCA debe aparecer en las imágenes de esta marca.
5. Prueba de coherencia: qué mirar en la cuadrícula de 5 para decidir si está bien.

## Errores típicos
- Cambiar dos o tres parámetros a la vez cuando algo no gusta: luego no sabes qué lo arregló.
- Usar adjetivos vagos que cada generador interpreta de una manera.
- Poner el bloque de estilo delante del sujeto: pierde peso y el generador se centra en el ambiente.
- Cambiar de generador a mitad de una serie: el mismo prompt da otra cosa. Termina la serie donde la empezaste.
- Mezclar imágenes reales y generadas con climas distintos en el mismo feed.
- Definir la guía y no usarla. Guárdala en un archivo y pégala siempre.

## Avisos honestos
- La coherencia perfecta no existe con generadores: espera un 80% y retoca el 20% restante con ajustes de color en la edición.
- Copiar el estilo de una marca concreta y nombrarla en el prompt es un terreno resbaladizo; inspírate en el clima, no en la marca.
- Si tu marca aún no sabe qué es, la guía visual no lo va a resolver. Antes hace falta decidir a quién le hablas.
