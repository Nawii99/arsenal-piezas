---
name: fotogrametria-con-movil
description: "Guía un flujo completo de fotogrametría con el móvil: elección del objeto, iluminación, patrón de disparo, procesado, limpieza, decimación, baking de normales y exportación para venta o uso en un motor. Úsala cuando el usuario quiera convertir un objeto real en modelo 3D solo con un teléfono, o sus escaneos salgan informes, deformados o inservibles."
---

# Escanear objetos reales con el móvil

## Qué hace
Te enseña a fotografiar bien un objeto, procesarlo y dejar el modelo limpio y ligero, que es donde falla todo el mundo.

## Cuándo se activa
Cuando el usuario quiere digitalizar objetos reales, menciona fotogrametría, escaneo 3D, Polycam, RealityScan, LiDAR, o sus escaneos salen deformes.

## Qué preguntar si falta información
1. ¿Qué objeto y de qué tamaño?
2. ¿Para qué: vender el modelo, visor de producto en web, juego, impresión 3D?
3. ¿Móvil con LiDAR (iPhone Pro) o cámara normal?
4. ¿Puedes moverte alrededor del objeto o está fijo contra una pared?

## Qué se escanea bien y qué no
- **Bien**: piedra, madera, ladrillo, tela mate, cerámica, comida, esculturas, objetos con textura y detalle irregular.
- **Regular**: objetos oscuros uniformes, superficies muy lisas de un solo color.
- **Mal o imposible**: cristal, espejos, cromados, agua, plásticos muy brillantes, pelo fino, objetos completamente negros. Solución de taller: espray mate temporal (talco o espray de escaneo), sabiendo que hay que limpiar después.

## Método paso a paso
1. **Luz**: día nublado o sombra abierta. La luz dura crea sombras que se quedan pegadas a la textura para siempre. Nada de flash.
2. **Coloca el objeto** sobre una superficie con textura (una alfombra, un periódico, cartón con manchas), no sobre blanco liso: el programa necesita puntos de referencia.
3. **Muévete tú, no el objeto.** Si giras el objeto sobre un plato, el fondo cambia y el reconstructor se vuelve loco (salvo que uses fondo neutro y máscaras).
4. **Patrón de disparo**: tres vueltas completas alrededor, a tres alturas: por encima (unos 45 grados hacia abajo), a la altura del objeto, y desde abajo. Entre 60 y 150 fotos para un objeto pequeño.
5. **Solape**: cada foto debe compartir un 60-80% con la anterior. En la práctica: un paso corto entre disparo y disparo.
6. **Enfoque y ajustes**: bloquea el enfoque y la exposición si tu app lo permite, para que todas las fotos tengan la misma luz. Evita el zoom digital.
7. **Los bajos**: si necesitas la parte de abajo, haz un segundo escaneo con el objeto volteado y luego une las dos mitades en Blender.
8. **Procesa** con una app de escaneo por fotos (Polycam, RealityScan, Meshroom si vas por ordenador y gratis del todo). Elige calidad alta y ten paciencia: puede tardar de 10 minutos a una hora.
9. **Limpieza en Blender**: borra el suelo y las manchas flotantes, cierra agujeros, y comprueba la escala midiendo algo real. Truco: pon una regla o una moneda en la escena al fotografiar y escala el modelo para que coincida.
10. **Reduce**: el escaneo bruto puede tener millones de triángulos. Objetivo según destino: 5.000-20.000 para tiempo real, 50.000-150.000 para render de producto. Usa el modificador Decimate (versión Collapse) o retopología si el objeto se va a animar.
11. **Hornea el detalle**: antes de reducir, guarda una copia densa; después, hornea un mapa de normales de la copia densa sobre la ligera. Así el modelo ligero conserva el relieve.
12. **Limpia la textura**: quita sombras marcadas con un ajuste de niveles o pintando encima; una textura con sombra pintada delata el escaneo y hace que no se pueda iluminar en otro entorno.
13. **Exporta**: GLB para web, FBX para motores, OBJ si es para impresión (y comprueba que la malla esté cerrada y sea manifold en ese caso).

## Errores típicos
- Escanear con sol directo y obtener un modelo con sombras cocidas.
- Dar sólo una vuelta a la altura de los ojos: la parte de arriba sale como una masa fundida.
- Mover el objeto entre fotos sin querer (mesas que se mueven, mascotas, viento en la tela).
- Procesar y quedarse ahí: el escaneo bruto no es un producto vendible, la limpieza es el 70% del trabajo.
- Escala inventada: sin referencia física, el modelo importado sale a un tamaño aleatorio.
- Intentar escanear objetos brillantes y culpar a la app.

## Formato exacto de la respuesta
1. **Viabilidad del objeto**: si se puede escanear bien y qué precauciones tomar.
2. **Plan de disparo**: número de vueltas, alturas, número aproximado de fotos, condiciones de luz.
3. **Ajustes de procesado** recomendados.
4. **Guion de limpieza en Blender**, paso a paso con nombres de herramientas.
5. **Objetivo de polígonos y texturas** según el destino.
6. **Checklist de entrega** si lo vas a vender.

## Avisos honestos
- Las apps de escaneo cambian de precios y de límites gratuitos con frecuencia; comprueba antes de basar un negocio en una concreta.
- Si escaneas objetos de museos, esculturas ajenas o productos de marca, comprueba si puedes venderlos: puede haber derechos.
- La fotogrametría da modelos realistas pero sucios. Si necesitas un modelo limpio y editable, sale más a cuenta modelarlo.
