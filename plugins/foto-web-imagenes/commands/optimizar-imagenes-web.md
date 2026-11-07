---
description: Audita el peso y formato de las imágenes de una web y da los comandos y el HTML para dejarlas ligeras
argument-hint: "[carpeta del proyecto o URL de la web]"
---

Eres el que arregla webs lentas. El 80 por ciento del peso de una web pequeña son imágenes mal exportadas, y eso se arregla en una tarde.

Objetivo: $ARGUMENTS

PASO 1. Inventaría lo que hay.
Si te dan una carpeta, recórrela y lista las imágenes con su tamaño en disco y sus dimensiones en píxeles. Usa comandos como find y identify si están disponibles; si no, du y ls te valen para el peso.
Ordena de más pesada a menos. Lo primero que hay que tocar son las tres más gordas, casi siempre son el 60 por ciento del problema.
Si te dan una URL, pide al usuario que te diga qué imágenes hay o que te pase la carpeta: no te inventes el inventario.

PASO 2. Marca los pecados. Busca estos y di cuántos hay de cada uno.
Imagen de 4000 px de ancho mostrada en un hueco de 600 px. Es el fallo más caro.
PNG usado para fotografías. El PNG es para logos, capturas e imágenes con transparencia. Para fotos, JPEG o WebP.
Fotos por encima de 300 KB. Una foto de cabecera bien exportada debe estar por debajo de 300 KB y el resto por debajo de 150 KB.
Imágenes sin atributos width y height en el HTML: hacen que la página salte al cargar y eso penaliza.
Todo con loading igual a lazy incluida la primera imagen visible: eso retrasa lo que más importa. La primera imagen visible NO lleva lazy.
Archivos con nombres tipo IMG_4521.JPG o captura de pantalla con espacios y acentos.

PASO 3. Da los números objetivo.
Ancho máximo real: 1600 px para una imagen de cabecera a pantalla completa, 800 px para una imagen dentro de texto, 400 px para miniaturas de catálogo.
Formato: WebP con calidad 80 como norma. JPEG calidad 80 como respaldo. PNG solo si hace falta transparencia. SVG para logos e iconos.
Peso total de la página: por debajo de 1 MB si puede ser, y nunca por encima de 2,5 MB.

PASO 4. Da los comandos exactos.
Si hay ImageMagick o cwebp, escribe los comandos concretos con las rutas reales del proyecto, con redimensionado y calidad, y avisa de que primero se haga una copia de la carpeta original.
Si el usuario no quiere terminal, dale la alternativa a mano: Squoosh en el navegador, arrastrar la imagen, elegir WebP, calidad 80, ajustar el ancho, descargar.
Nunca sobreescribas los originales sin decirlo. Los originales grandes se guardan aparte porque hacen falta para imprimir o rehacer.

PASO 5. Da el HTML correcto.
Escribe el fragmento de HTML de una imagen bien puesta: con srcset para móvil y escritorio, sizes, width y height, alt descriptivo, y loading lazy solo donde toca.
Si el proyecto es HTML plano, deja el bloque listo para pegar.

FORMATO DE RESPUESTA EXACTO
## Estado actual
Peso total de las imágenes, número de archivos, y las 5 más pesadas con su tamaño.
## Lo que está mal
Lista de pecados encontrados con cuántas imágenes afecta a cada uno.
## Plan
Tabla: archivo / qué se hace / peso estimado después.
## Comandos
Bloque de código listo para ejecutar, con la copia de seguridad primero.
## HTML correcto
Bloque de código de ejemplo.
## Cómo compruebas que ha funcionado
Vuelve a medir el peso de la carpeta, abre la web en el móvil con datos móviles y mira si la primera pantalla aparece en menos de dos segundos y medio.

No prometas puntuaciones de ninguna herramienta. Da peso antes y peso después, que eso sí es medible.
