---
name: optimizar-modelo-3d-para-web
description: Reduce el peso de un modelo 3D (geometría, texturas, materiales) para que cargue rápido en web y móvil, usando gltf-transform/gltfpack con presupuestos concretos y comprobaciones de calidad. Úsala cuando un GLB/GLTF/FBX/OBJ pese demasiado, cargue lento en una web o vaya a tirones en un teléfono.
---

# Optimizar un modelo 3D para web y móvil

## Qué hace
Coge un modelo 3D pesado y lo deja en una fracción de su tamaño manteniendo un aspecto aceptable, con pasos concretos y comprobaciones para saber si te has pasado de recorte.

## Cuándo se activa
Cuando el usuario dice que su modelo tarda en cargar, pesa mucho, va a tirones en el móvil, o quiere subirlo a una web, a Sketchfab, a una ficha de producto o a un juego web.

## Qué preguntar antes de tocar nada
1. ¿Dónde se va a ver? Web de escritorio, móvil, visor de producto, juego, realidad aumentada.
2. ¿Qué formato tienes ahora y cuánto pesa? Pide el resultado de `ls -lh` o el tamaño del fichero.
3. ¿Se ve de cerca o de lejos? Un anillo que se gira en pantalla completa necesita más detalle que un sofá en miniatura.
4. ¿Tiene animación o esqueleto? Eso cambia qué se puede simplificar.
5. ¿Tienes los ficheros originales (Blender, texturas sueltas) o solo el exportado?
Si no contesta, asume: visor de producto en móvil, se ve de cerca, sin animación.

## Presupuestos que funcionan (referencia de oficio)
- Visor de producto en web: modelo entero por debajo de 5 MB descargados; ideal 1-3 MB.
- Geometría: 30.000-150.000 triángulos para un producto; por encima de 300.000 casi nunca se nota la diferencia en pantalla pequeña.
- Texturas: 2048x2048 para el objeto principal, 1024 para piezas secundarias, 512 para tornillos y detalles.
- Número de materiales: cuantos menos, mejor. Cada material extra es una llamada de dibujo más.
- Realidad aumentada en móvil: apunta a menos de 10 MB y menos de 100.000 triángulos.

## Método paso a paso
1. **Mide antes de tocar**: peso del fichero, triángulos, número de materiales, tamaño de cada textura. Sin esto no sabes si has mejorado.
2. **Convierte a GLB** si no lo está. El formato de la web es glTF binario (.glb). Desde Blender: File > Export > glTF 2.0, formato GLB, marcar +Y up.
3. **Limpia en el origen**: borra objetos que no se ven (interiores, cámaras, luces sueltas), aplica las transformaciones (escala 1,1,1), borra modificadores duplicados y elimina vértices sueltos.
4. **Reduce texturas antes que polígonos**. En casi todos los modelos pesados, el 80% del peso son imágenes. Baja resoluciones a potencias de dos y quita mapas que no aportan (un mapa de metalness todo negro se sustituye por un valor fijo).
5. **Comprime con herramientas estándar**: `npx gltf-transform optimize entrada.glb salida.glb --texture-compress webp` es el punto de partida. Para geometría, Draco (`--compress draco`) o gltfpack de meshoptimizer.
6. **Simplifica geometría solo si sigue pesando**: `gltf-transform simplify` con ratio 0.5 y error 0.001, y sube el ratio si aparecen agujeros o siluetas rotas.
7. **Une materiales y atlas** si hay muchos: `gltf-transform dedup` y `join` reducen llamadas de dibujo.
8. **Vuelve a medir** y compara capturas del antes y el después desde el mismo ángulo.

## Qué mirar para saber si está bien
- La silueta contra el fondo: si el borde se ve poligonal o dentado, has recortado demasiada geometría.
- Los textos y logotipos de las texturas: son lo primero que se emborrona al bajar resolución.
- Las normales: si aparecen manchas oscuras o caras negras, se han roto al simplificar.
- Carga real en móvil con datos, no en tu ordenador con fibra.

## Errores típicos
- Comprimir con Draco un modelo que va a usarse en realidad aumentada de iOS sin comprobar soporte del visor.
- Bajar todas las texturas a 512 y luego quejarse de que el producto parece de plástico.
- Simplificar un personaje con esqueleto sin cuidar los bucles de las articulaciones: se deforma feo al animar.
- Guardar encima del original. Trabaja siempre sobre una copia numerada.
- Confundir triángulos con caras: un cuadrado son dos triángulos y los visores cuentan triángulos.

## Formato de la respuesta
1. Tabla de antes y después: peso, triángulos, materiales, textura mayor.
2. Los comandos exactos ejecutados, en orden, listos para copiar.
3. Lista de recortes hechos y qué se ha perdido en cada uno.
4. Tres comprobaciones visuales concretas que el usuario debe hacer.
5. Un aviso claro si algún recorte es irreversible.

## Avisos honestos
- La compresión no arregla un modelo mal hecho: si el original tiene geometría sucia, saldrá basura más pequeña.
- Comprimir demasiado se nota en pantallas buenas; es preferible un modelo de 4 MB decente que uno de 800 KB que parece un juguete.
- Si el modelo es de un cliente, guarda el original intacto y entrega el optimizado como fichero aparte.
