---
name: control-calidad-imagen
description: Runs a systematic quality check on AI-generated or heavily edited images before publishing (hands, text, logos, light and shadow coherence, product fidelity, edges, upscaling artefacts) with a viewing protocol and a pass/fail verdict. Use right before publishing, printing or sending any generated image, especially for ads and product listings.
---

# Control de calidad antes de publicar

## Qué hace
Aplica un protocolo de revisión en orden fijo. No es "mirar la imagen": es mirar cosas concretas, en un orden concreto, porque el ojo se acostumbra y deja de ver los fallos a los dos minutos.

## Cuándo se activa
Última parada antes de publicar, imprimir, enviar al cliente o meter en un anuncio de pago.

## Método
### 1. Protocolo de visionado (haz los cuatro pasos, en este orden)
- Al tamaño real de uso: en el móvil si va a redes, impreso a escala si va a papel. Lo primero es si funciona a ese tamaño.
- Al 100% y luego al 200%: aquí aparecen los dedos, las letras y las costuras.
- En espejo (voltea la imagen): el cerebro deja de completar y saltan las asimetrías.
- En blanco y negro: comprueba contraste y si el sujeto se separa del fondo.

### 2. Lista de revisión, por bloques
Anatomía: manos y número de dedos, orejas, dientes, simetría de ojos, dirección de la mirada, pies y calzado, número de extremidades en grupos.
Objetos: número de patas, asas, botones, ruedas; continuidad de líneas rectas (marcos de puerta, baldosas, estanterías); tornillos y bisagras que no llevan a ningún sitio.
Texto: cada letra, cada acento, cada número. También el texto de fondo (carteles, etiquetas, libros). Si no se puede leer bien, mejor que no haya texto.
Marca: tu logo generado siempre sale deformado. Si aparece, se compone encima, no se genera.
Luz y sombra: una sola fuente principal, todas las sombras hacia el mismo lado, reflejos coherentes con esa fuente, objetos que se apoyan de verdad (si no hay sombra de contacto, el objeto flota).
Materiales: el cristal debe refractar, el metal reflejar el entorno, la tela tener trama. Si todo parece plástico, falta descripción de material.
Bordes: halos claros alrededor del sujeto, pelo cortado a hachazo, fondo que se cuela entre los dedos.
Repetición: patrones clonados en el fondo, la misma cara dos veces entre la gente, baldosas que se repiten idénticas.
Fidelidad: ¿coincide con el producto real? Color, número de piezas, acabado, proporción.

### 3. Veredicto
- APTA: publica.
- CORREGIBLE: lista de retoques concretos y quién los hace.
- REGENERAR: qué cambiar en el prompt, una sola cosa por intento.

### 4. Segunda mirada
Si es una imagen importante, que la mire otra persona 10 segundos y te diga lo primero raro que vea. Es el detector más fiable que existe.

## Qué preguntar si falta información
- ¿Dónde se publica y a qué tamaño se verá?
- ¿Es una imagen comercial de un producto real? (sube el listón de fidelidad)
- ¿Va impresa? (pide resolución y modo de color)
- ¿Puedes pasarme la imagen y el prompt usado?

## Formato de la respuesta
1. Veredicto en una línea: APTA / CORREGIBLE / REGENERAR.
2. Tabla de hallazgos: zona, qué falla, gravedad (bloqueante, molesta, cosmética).
3. Instrucciones de corrección concretas, una por hallazgo.
4. Prompt corregido, si toca regenerar, con el cambio marcado.
5. Checklist de 10 puntos para que el usuario la aplique solo la próxima vez.

## Errores típicos
- Revisar solo en la pantalla del portátil y publicar en móvil: cambian el brillo, el tamaño y el recorte.
- Enamorarse de la primera versión y no querer ver los fallos.
- Corregir tres cosas a la vez en el prompt y no saber cuál era la que funcionaba.
- Ampliar con un upscaler para "arreglar" un fallo: lo amplía también.
- Aceptar un logo generado porque "casi se parece".

## Avisos honestos
- Ningún checklist sustituye mirar la imagen con calma al día siguiente. Si tienes tiempo, duerme antes de publicar.
- La IA mejora rápido en anatomía y texto, pero sigue fallando en coherencia de luz y en objetos con muchas piezas. Esos son los que más hay que revisar.
- Si la imagen ilustra un producto que vas a vender, la fidelidad no es estética, es legal: una imagen que promete lo que no entregas trae devoluciones y reclamaciones.
