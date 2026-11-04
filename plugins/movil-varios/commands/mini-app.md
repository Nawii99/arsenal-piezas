---
name: mini-app
description: Crea una app o un juego completo en un solo archivo HTML que funciona en el navegador del movil, sin instalar nada. Escribe /mini-app seguido de tu idea.
---

## Qué hace
Convierte una idea en una app que funciona: un quiz, una calculadora, un juego de repaso, un contador. Todo en UN solo archivo `index.html` que se abre con Chrome, en el ordenador o en un Android.

## Qué preguntar antes de empezar
Si el usuario no lo ha dicho ya, pregunta solo esto y sigue:
1. Qué tiene que hacer la app, en una frase.
2. Quién la va a usar y si será sobre todo en móvil.
3. Si lleva datos propios (preguntas, precios, textos), pídelos ahora. No los inventes.

## Paso a paso
1. Escribe todo en un único archivo `index.html`: estructura, estilos y código juntos. Sin librerías externas, sin conexión a internet, sin cuentas.
2. Diseña para pantalla de móvil primero: botones grandes, letra legible, nada que dependa de pasar el ratón por encima.
3. Si la app guarda algo (puntuaciones, respuestas), usa la memoria del navegador (localStorage) y avisa dentro de la propia app de que los datos se quedan en ese móvil y se pierden si se borran los datos de Chrome.
4. Pon los textos que el usuario querrá cambiar (preguntas, títulos, precios) todos juntos al principio del archivo, marcados con un comentario que diga CAMBIA ESTO.
5. Guarda el archivo y explica cómo probarlo en el móvil: subirlo a Google Drive o enviárselo por Telegram a Mensajes guardados, descargarlo en el móvil y abrirlo con Chrome desde la app Archivos.
6. Si quiere compartirla con más gente, que arrastre el archivo a Netlify Drop (app.netlify.com/drop): da un enlace público y tiene plan gratuito.

## Qué devolver
- El archivo `index.html` completo, creado en la carpeta actual.
- Tres líneas de instrucciones: cómo abrirlo, qué puede cambiar sin miedo y dónde está marcado.
- Dos o tres mejoras posibles, por si quiere una segunda vuelta.

## Qué NO hacer
- No uses librerías que se descargan de internet: si el móvil va sin cobertura, la app tiene que seguir funcionando.
- No partas el proyecto en varios archivos. Un archivo o nada.
- No metas datos inventados: si faltan las preguntas o los precios, para y pídelos.
- No la vendas como sitio para guardar datos de clientes: sin servidor no hay copia de seguridad, y si son datos personales entra en juego el RGPD.
