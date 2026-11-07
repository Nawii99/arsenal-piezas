---
name: texto-legible-en-imagen
description: Produce imágenes cuyo texto se lee correctamente (promociones, carteles, tarjetas de precio, portadas, etiquetas), eligiendo el generador y la forma de prompt adecuados, o generando un fondo limpio y añadiendo encima tipografía real. Úsala cuando la IA devuelva letras deformadas o con faltas.
---

# Texto legible dentro de una imagen

## Qué hace
Resuelve el problema más frustrante de la imagen con IA: que el texto salga mal. Te dice cuándo pedirle el texto al generador, cómo pedírselo para que acierte, y cuándo es mejor generar el fondo y poner el texto tú encima.

## Cuándo se activa
Cuando el usuario quiere un cartel, una promo, una portada, una etiqueta, un banner, un precio o cualquier imagen con palabras dentro, o se queja de que «la IA escribe mal».

## La decisión que hay que tomar primero
- Texto corto y decorativo (una o dos palabras, un nombre en una etiqueta): puede pedirse al generador.
- Texto que debe ser exacto (precio, fecha, teléfono, condiciones, nombre de marca): NO se lo pidas al generador. Genera el fondo sin texto y pon la tipografía real encima. Es más rápido, sale perfecto y puedes cambiar el precio en diez segundos sin volver a generar.
- Esta es la regla que más tiempo ahorra de toda la habilidad.

## Si se lo pides al generador
1. Usa un generador que maneje texto: Ideogram y Flux son claramente mejores en tipografía que la mayoría.
2. Pon el texto entre comillas y en la posición que quieras: `a poster with the text "OFERTA" in bold sans-serif at the top`.
3. Máximo cinco palabras. A partir de ahí la tasa de error se dispara.
4. Palabras en mayúsculas fallan menos que en minúsculas.
5. Evita acentos, eñes y signos de apertura (¿ ¡): son los que peor salen. Si el texto lleva ñ o tildes, casi siempre conviene el camino manual.
6. Describe la tipografía: `bold condensed sans-serif`, `elegant serif`, `handwritten marker`. Sin esto el generador improvisa.
7. Pide espacio libre: `clean empty area at the bottom third` te deja sitio para añadir texto después aunque el generador falle.
8. Genera 4 variantes y lee el texto letra a letra. La ortografía se comprueba, no se supone.

## Si pones el texto tú encima (recomendado)
1. Genera el fondo con zona despejada y sin patrones justo donde irá el texto.
2. Monta en Canva, Photopea o incluso en un HTML sencillo si vas a hacer muchas versiones.
3. Jerarquía: un solo mensaje principal grande, un apoyo mediano y un dato pequeño. Tres niveles como máximo.
4. Contraste: texto claro sobre zona oscura o al revés. Si no llega, pon una capa de color al 30-50% detrás del texto, no un borde de contorno.
5. Tamaño mínimo legible en móvil: el titular debe leerse cuando la imagen mide 200 px de ancho. Prueba reduciéndola.
6. Zona segura: deja un 8% de margen por cada lado. En Stories e Historias, evita el 15% superior e inferior, que lo tapan la interfaz y los botones.
7. Máximo dos tipografías. Si dudas, una sola en dos pesos.

## Qué preguntar si falta información
- ¿Cuál es el texto exacto, palabra por palabra? Pídelo escrito, no interpretado.
- ¿Dónde se publica y en qué proporción: 1:1, 4:5, 9:16, horizontal?
- ¿Hay tipografía y colores de marca?
- ¿Va a haber varias versiones (precios distintos, ciudades distintas)? Entonces, montaje manual sí o sí.

## Formato exacto de la respuesta
1. Recomendación: generador o montaje manual, con el motivo en una línea.
2. Prompt del fondo, en inglés, con la zona despejada indicada.
3. El texto final ya redactado, con la jerarquía marcada: TITULAR / apoyo / dato pequeño.
4. Especificaciones de montaje: proporción, tamaños relativos, colores, márgenes.
5. Prueba de legibilidad: reducir a 200 px y comprobar que el titular se lee.

## Errores típicos
- Meter tres mensajes en un cartel. Uno gana, tres no lee nadie.
- Texto sobre la parte más ocupada de la foto.
- Contorno negro grueso alrededor de las letras para «que se lea»: se lee, pero parece de 2008.
- Tipografías de fantasía en el cuerpo del texto.
- Dar por buena una imagen sin leer el texto letra a letra: aparecen palabras casi correctas que el ojo completa solo.
- Poner el precio dentro de la imagen generada y tener que regenerar todo cuando cambie.

## Avisos honestos
- Las tipografías tienen licencia. Para uso comercial usa Google Fonts o fuentes con licencia comercial explícita.
- El texto en imagen no lo lee Google ni un lector de pantalla: repite la información clave en el texto de la publicación o en la página.
- Meta ya no rechaza anuncios por exceso de texto en la imagen, pero sigue mostrando menos los creativos saturados de letra. Menos texto rinde mejor.
