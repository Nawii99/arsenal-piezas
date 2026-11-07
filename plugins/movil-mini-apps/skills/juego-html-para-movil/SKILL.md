---
name: juego-html-para-movil
description: Crea un juego sencillo en un solo archivo HTML que se juega en el navegador de un móvil Android. Se activa cuando el usuario pide un juego o una app de práctica sin saber programar.
---

## Qué hace
Genera un juego completo en UN solo archivo HTML (con el CSS y el JavaScript dentro), listo para abrirlo en el Chrome del móvil sin instalar nada.

## Antes de empezar, pregunta
1. Qué tipo de juego quiere: quiz de preguntas, memoria de parejas, adivinar el número o reflejos (tocar cuando cambie el color). Si duda, recomienda el quiz: es el más fácil de personalizar después.
2. El tema o contenido (por ejemplo, preguntas sobre su sector para usarlo con clientes o en redes).
3. Si es solo para él o para enseñárselo a otras personas.

## Paso a paso
1. Escribe el juego entero en un archivo llamado juego.html. Todo dentro: nada de archivos separados ni librerías externas.
2. Botones y textos grandes: los botones, de al menos 48 píxeles de alto, porque se juega con el dedo, no con ratón.
3. Incluye la etiqueta viewport para que se vea bien en pantalla de móvil.
4. Guarda la puntuación con localStorage para que no se pierda al cerrar el navegador.
5. Al terminar, explica en dos frases cómo pasarlo al móvil: enviárselo a sí mismo por correo o Telegram, descargar el archivo y abrirlo con Chrome.
6. Si quiere compartirlo, explica cómo subirlo gratis a Netlify Drop o GitHub Pages y pasar el enlace.

## Qué devolver
El archivo juego.html completo, una lista de 3 pasos para probarlo en el móvil, y una frase que diga qué línea tocar para cambiar las preguntas o los textos sin miedo a romper nada.

## Qué NO hacer
- No uses frameworks, npm ni nada que haya que instalar: el usuario no programa.
- No des el código por trozos ni digas cosas como añade esto donde corresponda. Archivo completo, siempre.
- No propongas publicar en Google Play: exige cuenta de desarrollador (25 dólares, pago único) y empaquetar la app, y para aprender no hace falta.
- No uses jerga sin explicarla. Cada palabra técnica, con una frase de explicación al lado.
