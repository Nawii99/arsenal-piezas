---
name: escanear-producto-con-movil
description: Guides a full photogrammetry / LiDAR scan of a real object using only a phone, covering shooting technique, lighting, capture patterns, cleanup and export to a usable 3D model. Use when someone wants to turn a real product, part or sculpture into a 3D model without buying a scanner.
---

# Escanear un objeto real con el móvil

## Qué hace
Te da el plan de captura y de limpieza para convertir un objeto físico en un modelo 3D que sirva para tu web, para imprimir o para vender, usando solo el móvil y aplicaciones gratuitas.

## Cuándo se activa
Cuando el usuario menciona escanear, fotogrametría, digitalizar un producto, LiDAR, Polycam, Scaniverse, RealityScan o Luma.

## Qué preguntar
1. ¿Qué objeto es, de qué tamaño y de qué material? Es la pregunta clave.
2. ¿Para qué es el modelo: web, impresión 3D, vídeo, videojuego?
3. ¿Tienes iPhone Pro con LiDAR o Android normal?
4. ¿Puedes moverte alrededor del objeto o está pegado a una pared?
5. ¿Necesitas medidas exactas o solo que se parezca?

## Qué se escanea bien y qué no (esto es lo importante)
- Bien: objetos mates, con textura, con relieve. Piedra, madera, tela, cerámica sin brillo, comida, esculturas, piezas mecánicas pintadas.
- Regular: objetos de un solo color liso; hay que añadir referencias alrededor.
- Mal: cristal, espejo, cromados, líquidos, plástico brillante negro, pelo fino, hojas finas. Si insiste, la salida es mate en spray temporal o polvos de talco.

## Método paso a paso
1. **Prepara el sitio**: luz difusa e igual por todos lados. Día nublado en exterior o interior con luz indirecta. Cero sol directo, cero sombras duras.
2. **No muevas el objeto**: si giras el objeto sobre una mesa, el programa se lía con el fondo. Si tienes que hacerlo, usa fondo liso y enmascara después.
3. **Patrón de captura**: tres vueltas completas alrededor, a tres alturas: por debajo del objeto mirando hacia arriba, a la altura del objeto, y desde arriba en picado.
4. **Solape**: cada foto debe compartir un 60-80% con la anterior. En la práctica, un paso lateral pequeño entre disparo y disparo.
5. **Cantidad**: 60-150 fotos para un objeto de sobremesa. Menos de 40 casi siempre falla.
6. **Enfoque y ajustes**: enfoque manual bloqueado si la app lo permite, exposición bloqueada, evita el modo retrato y el zoom digital.
7. **La parte de abajo**: haz una segunda sesión con el objeto boca abajo y une los dos escaneos después, o acepta que la base quedará plana.
8. **Procesa**: usa la calidad media primero para comprobar que ha salido; la alta tarda mucho y si hay fallo has perdido el tiempo.
9. **Limpia**: recorta el suelo y el fondo, tapa agujeros, y si es para web haz retopología o simplificación con texturas horneadas.
10. **Escala**: pon una regla o una moneda en la escena y usa la herramienta de medida de la app para fijar el tamaño real.

## Cómo saber si el escaneo está bien
- Gira el modelo: si hay zonas hinchadas o derretidas es que faltan fotos de ese ángulo.
- Mira los bordes finos: si desaparecen, el objeto era demasiado delgado para fotogrametría.
- Comprueba la medida real con un calibre o una cinta y compárala con el modelo.
- Mira la textura al 100%: si está borrosa, faltaba luz o hubo trepidación.

## Errores típicos
- Escanear con el sol moviéndose: las sombras quedan grabadas en la textura.
- Dar vueltas demasiado rápido y con pocas fotos.
- Usar flash: crea brillos distintos en cada foto y arruina la reconstrucción.
- Escanear con fondo liso blanco sin referencias: el programa no encuentra puntos comunes.
- Confiar en el modelo tal cual sale para imprimir: casi siempre hay que cerrar agujeros.

## Formato de la respuesta
1. Diagnóstico del objeto: escaneable, difícil o imposible, y por qué.
2. Plan de captura concreto: número de vueltas, alturas, número aproximado de fotos, luz.
3. App recomendada según su móvil y el uso final.
4. Pasos de limpieza y exportación con formato de salida.
5. Plan B si el objeto es de los difíciles (modelar a mano a partir de medidas y fotos de referencia).

## Avisos honestos
- La fotogrametría no da precisión de metrología: no la uses para piezas que deban encajar al milímetro sin comprobar medidas a mano.
- Muchas apps guardan tus escaneos en su nube y algunas tienen límites en el plan gratis; comprueba si puedes exportar OBJ o GLB antes de invertir tiempo.
- Escanear productos ajenos con marca registrada y venderlos como modelo puede meterte en un lío legal.
