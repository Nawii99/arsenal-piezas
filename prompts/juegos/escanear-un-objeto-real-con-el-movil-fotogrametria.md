# Escanear un objeto real con el móvil (fotogrametría)

**Tipo:** Prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Plan de captura para convertir un objeto o un espacio en modelo 3D usando solo tu móvil, con los errores que arruinan el escaneo.

## Qué es y qué hace

Prompt para cualquier chat de IA que actúa como técnico de fotogrametría. Evalúa si tu objeto es buen candidato y devuelve el plan de captura con el móvil, errores a evitar y consejos de limpieza posterior. Ejemplo: digitalizar productos de una tienda para su web o un visor AR.

## Cómo usarla

1. Copia el prompt
2. Describe el objeto y tu equipo en los [corchetes]
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Haz la sesión de fotos siguiendo el plan y procesa en tu software

## Cuándo usarla

Úsalo antes de escanear un producto, una pieza, una estatua o una habitación con el móvil, para no tener que repetir la sesión de fotos.

## Cómo ganar dinero con ella

Te abre un servicio muy vendible: digitalizar el catálogo de una tienda o un taller para su web, sin comprar equipo caro.

- Digitalización 3D de catálogo de tiendas para su web con visor…
- Escaneo de piezas de taller o artesanía para fichas interactivas…
- Captura de espacios o estatuas para patrimonio y turismo local…

**Precio orientativo:** 30–120 € por pieza. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como técnico de fotogrametría y escaneo 3D con experiencia en captura con móvil y en limpieza posterior de mallas.
QUÉ QUIERO ESCANEAR
Objeto o espacio: [DESCRIBE: TAMAÑO APROXIMADO, MATERIAL, COLOR, SI BRILLA O ES TRANSPARENTE]
Dónde puedo capturarlo: [EXTERIOR / INTERIOR CON VENTANA / TIENDA CON FOCOS / MESA EN CASA]
Con qué: móvil [MODELO], ¿trípode? [SÍ/NO], ¿plato giratorio? [SÍ/NO]
Para qué será el modelo: [FICHA DE PRODUCTO EN WEB / VISOR AR / RENDER / IMPRESIÓN 3D / JUEGO]
Software que puedo usar: [APP DE ESCANEO DEL MÓVIL / MESHROOM GRATIS / REALITY SCAN / OTRO]
QUÉ TIENES QUE HACER, PASO A PASO
1. Dime primero, sin rodeos, si mi objeto es buen candidato. Explica qué se escanea mal: cristal, espejos, metal pulido, negro absoluto, pelo fino, hojas finas, superficies lisas sin textura, y qué truco hay para cada caso (polvo mate temporal, cambiar la luz, texturizar el fondo).
2. Dame el plan de luz: por qué la luz difusa y sin sombras duras es la buena, cómo conseguirla en mi sitio, y por qué el objeto y la luz no deben moverse entre fotos.
3. Dame el plan de fotos: cuántas anillos de altura, cuántas fotos por vuelta, cuánto solape entre fotos, distancia y qué parte del encuadre debe ocupar el objeto.
4. Dame los ajustes de cámara del móvil: bloquear enfoque y exposición, evitar el zoom digital, evitar el modo retrato y el HDR agresivo, disparar con temporizador si no hay trípode, no usar el gran angular en objetos pequeños.
5. Explica el error clásico del plato giratorio con fondo liso y cómo evitarlo, y cuándo conviene mover la cámara en vez del objeto.
6. Dime cómo dar escala real al modelo: colocar una regla o dos marcas a distancia conocida, y cómo se usan después.
7. Dame el orden del procesado: descartar fotos movidas, alinear, malla, textura, y qué hacer si la alineación falla.
8. Dame la lista de limpieza posterior: quitar el suelo y el fondo, tapar agujeros, suavizar solo donde toca, reducir la malla a un presupuesto razonable para mi destino, hornear color y detalle a la versión ligera.
9. Dime cómo saber si el resultado vale: comparar medidas reales con las del modelo, buscar deformaciones tipo plátano en objetos alargados, revisar si la textura tiene sombras pegadas y qué hacer si las tiene.
10. Dame un plan B si el escaneo sale mal: qué partes se modelan a mano en Blender y cuánto tardo.
RESTRICCIONES
Nada de suponer que tengo cámara réflex ni luces de estudio.
Da números concretos de fotos, ángulos y solape, no consejos vagos.
Si mi objeto es de los imposibles, dilo en la primera línea y propón otro camino.
FORMATO DE LA RESPUESTA
A. Veredicto: fácil, difícil o imposible, y por qué.
B. Preparación del sitio y del objeto: lista de 8 puntos.
C. Guion de captura: tabla con Vuelta, Altura de cámara, Nº de fotos, Qué debe verse.
D. Ajustes del móvil, en una lista corta.
E. Procesado y limpieza, paso a paso.
F. Control de calidad: 6 comprobaciones con lo que debe salir.
G. Errores típicos y cómo se ven en el resultado.
CRITERIOS DE CALIDAD
Está bien si el modelo mide lo mismo que el objeto real, no tiene agujeros visibles desde los ángulos de uso y la textura no lleva sombras quemadas.
Está mal si hay que repetir la sesión de fotos.
```
