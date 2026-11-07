---
name: modelo-recurrente-ia
description: Mantiene reconocible al mismo personaje, modelo o mascota de marca en muchas imágenes generadas con IA mediante una descripción canónica fija, imágenes de referencia y semillas. Úsala cuando el usuario quiera una cara o mascota recurrente en anuncios, carruseles o catálogos y el generador no deje de cambiarla.
---

# Un personaje que se repite en todas tus imágenes

## Qué hace
Crea una «ficha de personaje» cerrada y el sistema para reutilizarla, de modo que tu modelo, tu mascota o tu portavoz de marca salga reconocible en veinte imágenes distintas, con distinta ropa, escena y ángulo.

## Cuándo se activa
Cuando el usuario quiere el mismo modelo en varias fotos, una mascota de marca, un personaje para una serie de posts o un portavoz virtual, y se queja de que «cada vez sale distinto».

## Por qué se te cambia la cara
Los generadores no recuerdan nada entre imágenes. Cada generación parte de cero y rellena todo lo que tú no has fijado. Cuanto más detalle dejas suelto, más deriva. La solución no es un prompt más largo, sino un prompt canónico corto e idéntico más una referencia visual.

## Método paso a paso
1. Escribe la descripción canónica en 12-18 palabras, no más: edad aproximada, etnia o rasgos, pelo (color, largo, forma), ojos, complexión y un rasgo distintivo único (lunar, gafas de pasta verde, mecha, cicatriz, collar).
2. El rasgo distintivo es la clave: un solo elemento inconfundible hace que el ojo humano lea «es la misma persona» aunque la cara varíe un poco.
3. Genera de 20 a 30 imágenes solo con la descripción canónica, plano medio, fondo neutro, luz suave, y elige la que mejor la represente. Esa es tu imagen canónica.
4. Anota la semilla (seed) de esa imagen. En Midjourney, `--seed`; en otros, el campo de semilla.
5. Genera la hoja de personaje: la misma cara de frente, tres cuartos y perfil, más expresión neutra y sonriente. Guárdala.
6. A partir de ahí, cada nueva imagen se pide así: imagen de referencia de la cara + descripción canónica literal, copiada sin cambiar ni una palabra + lo nuevo (ropa, escena, acción, plano).
7. Usa las herramientas de referencia de cada generador: en Midjourney `--cref` con peso `--cw` entre 40 y 100 (bajo si cambia de ropa, alto si quieres máximo parecido); en otros, la carga de imagen de referencia o un LoRA propio.
8. Control de deriva: cada cinco imágenes, pon la nueva al lado de la canónica al 100%. Si ya no parece la misma, vuelve a partir de la canónica en lugar de encadenar copias de copias.

## Qué preguntar si falta información
- ¿Es una persona, un animal o un personaje ilustrado? El método es el mismo, la tolerancia al fallo no.
- ¿Va a aparecer de cerca o siempre de medio cuerpo para arriba? Cuanto más lejos, más margen tienes.
- ¿Qué generador usa? Las opciones de referencia cambian mucho entre uno y otro.
- ¿Este personaje va a hablar en primera persona como si fuera una persona real de la empresa?

## Formato exacto de la respuesta
1. La DESCRIPCIÓN CANÓNICA en inglés, entre comillas, para copiar tal cual.
2. El rasgo distintivo elegido y por qué.
3. Prompt de la imagen canónica y de la hoja de personaje.
4. Plantilla de prompt para escenas nuevas, con hueco marcado para la escena.
5. Tabla con 5 escenas de ejemplo ya rellenadas.
6. Método de control: qué comparar y cada cuánto.

## Errores típicos
- Descripción canónica larguísima: a más palabras, más contradicciones y más deriva.
- Cambiar el orden de las palabras entre imágenes. Cópialas literales.
- Usar plano muy cercano en todas: es donde más se nota la diferencia. Alterna planos.
- Encadenar generaciones a partir de la última imagen; el parecido se degrada como una fotocopia de fotocopia.
- Poner al personaje en escenas con muchas manos, gafas o texto: ahí es donde se rompe la ilusión.
- Peso de referencia al máximo siempre: entonces la ropa y la pose tampoco cambian.

## Avisos honestos
- No uses la cara de una persona real (ni famosa ni conocida tuya) sin su consentimiento por escrito. En España el derecho a la propia imagen está protegido y es una vía rápida a una reclamación.
- Si el personaje se presenta como una persona real de tu empresa y no lo es, lo estás engañando al cliente. Preséntalo como personaje de marca.
- Cuando una imagen generada muestre a alguien que parece real diciendo o haciendo algo, indícalo como contenido generado con IA. Las plataformas cada vez lo exigen más.
- Ningún método da el 100% de parecido. Asume un 85-90% y compensa con ropa y rasgo distintivo constantes.
