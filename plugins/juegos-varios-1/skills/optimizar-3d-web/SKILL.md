---
name: optimizar-3d-web
description: Optimises a 3D model for the web - polygon and texture budget, glTF/GLB export, Draco and KTX2 compression, model-viewer embed code and AR support - and verifies it loads fast on mobile. Use when the user wants a 3D product viewer on a website and the file is too heavy or stutters.
---

# Modelo 3D listo para la web

## Qué hace

Coge un modelo pesado de Blender, ZBrush, un escaneo o un CAD y lo deja en un .glb ligero que carga en móvil, con el código del visor para pegar en la web y soporte de realidad aumentada.

## Cuándo se activa

Cuando el usuario habla de enseñar un producto en 3D en su web, de un visor 360, de realidad aumentada en una ficha de producto, de glTF, GLB, three.js o model-viewer.

## Qué preguntar

1. Archivo de partida y de dónde viene (escaneo, CAD, escultura, asset de juego).
2. ¿Se ve entero de lejos o el usuario podrá acercarse mucho?
3. ¿Hace falta que se pueda ver en AR en el móvil?
4. ¿Hay variantes (colores, materiales) que haya que poder cambiar?
5. Dónde se va a incrustar: WordPress, Shopify, HTML propio.

## Método

### 1. Objetivos de presupuesto

- Peso final del .glb: por debajo de 5 MB para producto normal, ideal 1-3 MB. Por encima de 15 MB en móvil vas a perder gente.
- Triángulos: 30.000-150.000 según cuánto se acerque el usuario. Para un producto que gira, con 50.000 sobra casi siempre.
- Texturas: 2048 en la pieza principal, 1024 para el resto. Una sola textura por material siempre que puedas.

### 2. Limpieza de la malla

- Borra lo que no se ve: interiores, tornillos escondidos, geometría bajo la base.
- Reduce con decimate o retopología según venga: los escaneos y el CAD teselado bajan mucho sin que se note.
- Aplica todas las transformaciones y comprueba que las normales miran hacia fuera.
- Si vienes de CAD, vigila el suavizado: las curvas teseladas a lo bruto se ven facetadas.

### 3. Texturas y materiales

- Empaqueta oclusión, rugosidad y metalicidad en un solo mapa de tres canales (ORM). Ahorra un archivo entero.
- El color base va en sRGB; normal, rugosidad y metalicidad en lineal. Confundirlos es el fallo más frecuente y hace que todo se vea plástico o lavado.
- Funde materiales que sean iguales. Cada material extra es una llamada de dibujado más.

### 4. Exportar y comprimir

- Exporta a .glb (un solo archivo, texturas dentro).
- Comprime la geometría con Draco o meshopt, y las texturas a KTX2 o, como mínimo, a WebP o JPEG de calidad ajustada.
- La herramienta habitual para esto es gltf-transform o gltfpack; también hay procesadores web. Deja siempre una copia sin comprimir por si hay que rehacer.

### 5. Incrustar el visor

- La forma más simple es la etiqueta model-viewer de Google: cargas su script y pones una etiqueta con src, camera-controls, poster y ar.
- Pon siempre un poster: una imagen que se ve mientras carga, así la web no parece rota.
- Para iOS en AR hace falta además un archivo .usdz; se puede generar aparte y enlazar con ios-src.
- Carga el visor solo cuando entre en pantalla si está más abajo en la página.

### 6. Comprobación final

- Ábrelo en un móvil real con datos, no solo en tu wifi.
- Mide el tiempo hasta que se ve el modelo. Si pasa de 3-4 segundos, sigue recortando.
- Gira el modelo entero: busca caras negras, texturas estiradas y agujeros.

## Formato de la respuesta

1. Diagnóstico del archivo original: peso, triángulos, texturas y qué sobra.
2. Plan de recorte con objetivos numéricos.
3. Comandos concretos de compresión, con los parámetros explicados en cristiano.
4. Código HTML del visor listo para pegar, comentado.
5. Checklist de comprobación en móvil.
6. Qué hacer si hace falta AR en iPhone.

## Errores típicos

- Subir texturas PNG de 4K: ahí se va casi todo el peso.
- Optimizar la malla y olvidarse de las texturas, que suelen pesar más.
- Poner el mapa de normales como sRGB y no entender por qué el relieve se ve raro.
- No aplicar escala y que el modelo aparezca gigante o microscópico en AR.
- Probar solo en el portátil.

## Avisos honestos

- Un modelo muy detallado no se puede dejar en 2 MB sin perder detalle: hay que elegir. Lo honesto es enseñar la comparación antes y después.
- La realidad aumentada en iOS y en Android se comporta distinto; prueba en los dos antes de prometérselo a un cliente.
