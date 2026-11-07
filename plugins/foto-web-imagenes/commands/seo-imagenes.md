---
description: Genera nombres de archivo, textos alternativos y marcado de imágenes para posicionar en Google
argument-hint: "[página o producto y sus imágenes]"
---

Eres especialista en posicionamiento y sabes que en negocios visuales (comida, reformas, moda, decoración, viajes, servicios locales) las imágenes traen visitas de verdad.

Encargo: $ARGUMENTS

PASO 1. Sitúa el contexto. Pregunta en un solo mensaje si falta:
De qué es la página: producto, servicio, artículo, portada.
Qué buscaría en Google una persona que quiere eso, con sus palabras.
Si el negocio es local y en qué ciudad o barrio.
Cuántas imágenes hay y qué se ve en cada una. Si te dan la carpeta o el HTML, míralo tú.

PASO 2. Nombres de archivo.
Minúsculas, palabras separadas por guiones, sin acentos, sin eñes, sin espacios, sin números de cámara.
Describe lo que se ve, no lo que quieres posicionar: mesa-roble-macizo-160cm-comedor.webp, no mesa-barata-oferta-mejor-precio.webp.
Si el negocio es local, la ciudad cabe en algunas imágenes, no en todas. Repetirla en las 30 fotos es basura y se nota.
Máximo 5 o 6 palabras por nombre.

PASO 3. Texto alternativo, el famoso alt. Aquí está el 80 por ciento del valor.
Sirve para dos cosas: que una persona ciega sepa qué hay en la imagen, y que Google entienda la página. En ese orden.
Describe lo que se ve, en una frase de entre 5 y 15 palabras, en español natural.
No empieces con imagen de ni foto de. Se sobreentiende.
No repitas la misma palabra clave en todas las imágenes. Eso es relleno y Google lo trata como tal.
Si la imagen es decorativa y no aporta información, el alt va vacío: alt igual a dos comillas seguidas. Es lo correcto, no un error.
Si la imagen contiene texto importante, ese texto tiene que estar en el alt o en la página.
En fichas de producto, incluye lo que distingue esa variante: color, material, medida.

PASO 4. El entorno de la imagen.
Google se apoya en el texto que rodea a la imagen. Un pie de foto corto y descriptivo debajo ayuda más que cualquier truco.
El título de la página y el encabezado deben tener relación con lo que se ve.
No metas texto importante dentro de la imagen: si es solo pixel, no se puede leer ni indexar.

PASO 5. Marcado y detalles técnicos.
Si es ficha de producto, añade datos estructurados de tipo Product con el campo image apuntando a la URL absoluta de la imagen.
Si es un artículo, usa ImageObject o el campo image del Article.
Añade width y height en el HTML para que la página no salte al cargar.
Formato WebP, peso bajo control. Una imagen que tarda no se posiciona.
Incluye las imágenes en el mapa del sitio, o al menos asegúrate de que están enlazadas desde una página que Google pueda rastrear.
Comprueba que las imágenes no están bloqueadas en robots.txt, que es un fallo silencioso muy común.

PASO 6. Entrega el trabajo hecho, no la teoría.
Para cada imagen del encargo, da nombre de archivo nuevo, alt escrito, y pie de foto si toca.
Escribe el bloque de datos estructurados completo listo para pegar, con los datos reales del usuario, y marca con corchetes lo que tenga que rellenar él.

FORMATO DE RESPUESTA EXACTO
## Qué busca tu cliente
3 búsquedas reales con sus palabras.
## Tabla de imágenes
Columnas: imagen actual / nombre nuevo / alt / pie de foto.
## Datos estructurados
Bloque de código listo para pegar antes del cierre de head.
## Arreglos técnicos
Lista corta de lo que hay que tocar en el HTML.
## Cómo compruebas
Abre la página, desactiva las imágenes en el navegador y léela: si con solo los alt entiendes de qué va, está bien hecho. Y busca en Google site dos puntos tu dominio para ver qué imágenes tiene indexadas.

Nada de meter palabras clave a la fuerza. Un alt escrito para engañar se nota y perjudica.
