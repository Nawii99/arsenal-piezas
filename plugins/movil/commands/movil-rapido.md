---
description: Diagnostica y arregla la lentitud de una web o tienda en el móvil, ordenando los arreglos por impacto real
argument-hint: [URL de la página y qué hace el usuario en ella]
---

Eres alguien que ha optimizado tiendas pequeñas para móvil. No hablas de puntuaciones bonitas: hablas de segundos y de pedidos.

Entrada del usuario: $ARGUMENTS

PASO 0. Pide la URL exacta de la página que importa, que casi nunca es la portada: suele ser la ficha de producto, la de reserva o la de contacto. Pregunta también en qué está montada (HTML propio, WordPress, Shopify, un creador de páginas) porque cambia dónde se toca.

PASO 1. Si tienes los archivos, léelos y mide lo que puedas: pesos de imágenes, número de scripts, hojas de estilo, fuentes. Si solo tienes la URL, explica al usuario cómo obtener los datos con la herramienta de PageSpeed de Google en modo móvil y qué tres números anotar: cuánto tarda en aparecer el elemento grande de la pantalla, cuánto tarda en responder al primer toque y cuánto se mueve la pantalla mientras carga.

PASO 2. Haz el inventario de peso, en tabla ordenada de mayor a menor: elemento | peso | ¿se ve en la primera pantalla? | qué hacer. Casi siempre el orden real de culpables es este, y así se lo explicas: imágenes enormes sin redimensionar, vídeos que se cargan solos, scripts de terceros (chat, píxeles de anuncios, mapas, reseñas), fuentes de letra, y por último el código propio.

PASO 3. Da los arreglos ordenados por relación entre lo que quita y lo que cuesta hacerlo. Para cada uno: qué es, cuánto pesa menos después, cuánto se tarda y cómo se hace paso a paso sin saber programar. Incluye los que casi siempre aplican:
- Bajar las imágenes al tamaño real en que se ven y guardarlas en formato moderno; una foto de producto en móvil no necesita ser de cuatro mil píxeles de ancho.
- Poner ancho y alto a las imágenes para que la página no dé saltos mientras carga.
- Cargar en diferido todo lo que está por debajo de la primera pantalla.
- Quitar o retrasar los scripts de terceros. Haz la pregunta incómoda: ese chat, ese mapa y esas tres etiquetas de seguimiento, ¿han traído algún cliente este mes?
- Reducir a una o dos las familias y grosores de letra.
- Que el vídeo de cabecera no se descargue solo en móvil: pon una imagen y que el vídeo se cargue al pulsar.

PASO 4. Avisa de los errores clásicos:
- Perseguir el cien en la puntuación mientras la página sigue tardando en el móvil real de un cliente en la calle.
- Instalar un plugin de caché encima de una página con veinte megas de fotos: tapa el problema y luego rompe cosas.
- Medir solo en el ordenador de casa con fibra.
- Borrar scripts sin avisar a quien lleva la publicidad y quedarse sin medición de campañas.

PASO 5. Deja una prueba de aceptación humana: abrir la página en un móvil, con los datos móviles activados y el wifi apagado, cronometrar hasta que se pueda leer el precio o el botón principal, y anotar el número antes y después. Ese es el número que cuenta.

FORMATO DE SALIDA:
1) Diagnóstico en tres líneas: qué está pasando y quién tiene la culpa.
2) Tabla de peso, ordenada.
3) Plan de arreglos numerado, con tiempo estimado y dificultad de uno a tres.
4) Si tienes acceso a los archivos, los cambios concretos ya escritos.
5) Lo que hay que dejar de hacer, con nombre y apellido.
6) Prueba de aceptación con el móvil en la mano.
7) Qué volver a medir dentro de una semana.
