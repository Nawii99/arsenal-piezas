---
name: seo-imagenes
description: Writes file names, alt text, captions and image metadata so pictures rank in Google Images and support the page's SEO. Use when the user publishes photos on a site, blog or product page, wants traffic from image search, or is told their images lack alt text.
---

# SEO de imágenes

## Qué hace
Convierte un montón de fotos sin nombre en imágenes que Google entiende: nombre de archivo, texto alternativo, pie de foto, contexto alrededor y, si toca, sitemap de imágenes. Sirve igual para una tienda que para un blog.

## Cuándo se activa
Cuando el usuario habla de alt, texto alternativo, Google Imágenes, posicionar fotos, accesibilidad de imágenes, o va a publicar una galería, una ficha de producto o un artículo con fotos.

## El conocimiento del oficio
- Google lee el nombre del archivo. `IMG_20240712_113045.jpg` no dice nada; `silla-roble-macizo-comedor.jpg` sí.
- Nombres en minúsculas, con guiones medios, sin acentos ni eñes, sin espacios ni caracteres raros.
- El alt describe la imagen para quien no la ve, en una frase natural de 8 a 15 palabras, por debajo de 125 caracteres.
- El alt no es un cajón de palabras clave. `silla roble comprar silla barata silla oferta` te penaliza y suena fatal en un lector de pantalla.
- Imagen puramente decorativa (una línea, un fondo): `alt=""` vacío. Es lo correcto, no un olvido.
- El pie de foto sí lo lee la gente y es de lo más leído de una página. Aprovéchalo para decir algo útil, no para repetir el alt.
- Google se apoya muchísimo en el texto que rodea a la imagen: un párrafo relevante justo encima o debajo vale más que veinte etiquetas.
- Una sola imagen por página puede ser la «imagen destacada»; ponla al principio y que sea original.
- Fotos propias posicionan mejor que fotos de banco que están en otras diez mil webs.
- Si el texto importante va dentro de la imagen (precios, condiciones), Google no lo lee y quien use lector de pantalla tampoco. Ponlo en HTML.

## Método paso a paso
1. Define la búsqueda real de cada imagen: qué escribiría alguien en Google para llegar a ella.
2. Renombra el archivo con 3-5 palabras, la principal delante. Si hay variantes, añade sufijo: `-frontal`, `-detalle`, `-en-uso`.
3. Escribe el alt describiendo lo que se ve y añadiendo contexto útil: material, color, uso, lugar. Ejemplo: `Silla de roble macizo con asiento tapizado en lino gris, en un comedor luminoso`.
4. Escribe pie de foto solo cuando aporte: medida, precio, quién aparece, dónde se hizo.
5. Comprueba que la imagen está cerca del párrafo del que habla.
6. Añade datos estructurados si es producto o receta (`Product`, `Recipe`) con el campo `image` apuntando a URLs absolutas y a imágenes de al menos 1200 px.
7. Si la web tiene muchas imágenes, genera un sitemap de imágenes o comprueba que el plugin ya las incluye.
8. Verifica en Google Search Console, informe de Rendimiento, filtrando por tipo de búsqueda «Imagen», a las pocas semanas.

## Qué preguntar si falta información
- ¿Qué vende o de qué trata la página donde van estas imágenes?
- ¿Qué buscaría un cliente para encontrar esto? Pide 2-3 ejemplos en sus palabras.
- ¿Son fotos propias o de banco de imágenes?
- ¿Aparecen personas identificables o marcas de terceros?

## Formato exacto de la respuesta
Una tabla, una fila por imagen, con estas columnas: imagen original, nombre de archivo nuevo, alt propuesto, pie de foto (o «no hace falta»), y dónde colocarla en la página. Debajo, el HTML de una de ellas ya montado como ejemplo, y si procede el fragmento de datos estructurados.

## Errores típicos
- Copiar el mismo alt en las diez fotos de la ficha.
- Alt de dos palabras: `silla`. No sirve ni para SEO ni para accesibilidad.
- Empezar el alt con «Imagen de» o «Foto de»: sobra, ya se sabe que es una imagen.
- Renombrar los archivos después de publicarlos y romper todos los enlaces. Renombra antes de subir.
- Meter el nombre de la marca en todos los archivos y en todos los alt hasta cansar.
- Confiar en que el plugin de SEO ponga el alt solo: casi siempre repite el título de la entrada.

## Avisos honestos
- El SEO de imágenes trae visitas, pero suelen convertir peor que una búsqueda de texto. Es un canal de apoyo, no el principal.
- Los resultados tardan semanas, no días.
- Ninguna optimización compensa una foto fea o repetida de un banco de imágenes gratuito.
