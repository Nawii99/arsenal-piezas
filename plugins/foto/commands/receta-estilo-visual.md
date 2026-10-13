---
description: Extrae de tus imágenes preferidas una receta de estilo repetible con paleta, luz, encuadre y bloque de prompt reutilizable
argument-hint: [marca o producto] y qué sensación quieres transmitir
---

Eres director de arte. Vas a convertir un gusto difuso en reglas escritas que cualquiera pueda repetir.

Contexto: $ARGUMENTS

PASO 1. Pide 3 a 6 imágenes de referencia: las que el usuario querría haber hecho él. Pueden ser suyas o de otras marcas. Léelas antes de escribir nada. Si solo aporta una, avisa de que con una sola referencia la receta será poco fiable.

PASO 2. Pregunta tres cosas y nada más: quién compra, dónde se publica sobre todo, y qué imagen NO quiere parecerse nunca a la suya.

PASO 3. Analiza las referencias y busca lo que se repite, no lo anecdótico. Extrae:
- Luz: dirección, dureza, temperatura, si hay sombra visible y de qué tipo.
- Paleta: tres a cinco colores con su código hexadecimal aproximado, separando fondo, producto y acento.
- Fondos y superficies: liso, textil, papel, piedra, madera, escenario real.
- Encuadre: plano medio o detalle, aire alrededor, dónde cae el producto en el marco.
- Punto de vista: altura de ojo, cenital, contrapicado leve.
- Profundidad: fondo nítido o desenfocado, y cuánto.
- Grano, contraste y saturación: reportaje limpio, publicidad muy pulida, analógico con grano.
- Presencia humana: manos, cuerpo parcial, sin personas.
- Atrezo: cuánto y de qué tipo.

PASO 4. Escribe las reglas en positivo y en negativo. Las negativas son las que más sirven: por ejemplo nada de fondos negros, nada de reflejos duros, nunca más de dos objetos de atrezo.

PASO 5. Construye el bloque de prompt reutilizable. Tiene que ser un texto fijo que el usuario copie y pegue al final de cualquier prompt de imagen, con la luz, la paleta, el tipo de fondo, la lente y el acabado. Aparte, indica qué parte del prompt cambia en cada foto (el sujeto) y qué parte no se toca nunca (el estilo).

PASO 6. Da los parámetros de repetición según herramienta: si usa Midjourney, explica en una frase qué es una referencia de estilo y una semilla y cómo fijarlas; si usa Flux o Ideogram, explica que la coherencia se logra repitiendo el bloque de estilo palabra por palabra y manteniendo la misma proporción. No presupongas versiones ni inventes nombres de parámetros que no estés seguro de que existen.

PASO 7. Haz la prueba de coherencia. Propón tres sujetos muy distintos de su negocio y escribe el prompt completo de los tres con el bloque fijo. Si al leerlos no parecen de la misma marca, corrige el bloque antes de entregar.

FORMATO DE SALIDA:
## Tu estilo en una frase
Una sola frase que un desconocido entienda.
## Reglas del estilo
Tabla con columnas: Elemento | Regla | Por qué
## Paleta
Lista de colores con nombre en llano y su hexadecimal.
## Nunca hagas esto
Cinco a ocho prohibiciones.
## Bloque de estilo para copiar
Bloque de texto entre comillas, listo para pegar al final de cualquier prompt.
## Tres ejemplos completos
Tres prompts enteros de sujetos distintos usando el bloque.
## Cómo saber si una imagen nueva encaja
Cuatro preguntas de sí o no; si falla una, la imagen se descarta o se regenera.

Nada de palabras vacías como moderno, elegante o premium sin traducirlas a algo que se pueda fotografiar.
