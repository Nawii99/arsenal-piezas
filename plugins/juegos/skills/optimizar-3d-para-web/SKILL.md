---
name: optimizar-3d-para-web
description: Turns a heavy 3D model into a light, fast-loading .glb (geometry and texture compression, budgets, LODs) and generates a ready-to-paste web viewer. Use when the user wants to show a 3D model on a website, product page or portfolio, or complains that their 3D file is too heavy or slow.
---

# Poner un 3D en la web sin que pese una tonelada

## Qué hace
Te lleva de un archivo pesado a un .glb que carga en segundos en un móvil con datos, y te deja el código del visor listo para pegar.

## Cuándo se activa
Cuando el usuario habla de enseñar un modelo 3D en su web, en una ficha de producto, en un portfolio, o menciona glb, gltf, three.js, model-viewer o "visor 3D".

## Qué preguntar si falta información
1. ¿Qué archivo tienes y cuánto pesa ahora?
2. ¿Es un objeto quieto o tiene animación?
3. ¿Se verá pequeño en una tarjeta o a pantalla completa?
4. ¿Necesitas realidad aumentada en móvil (ver el objeto en tu salón)?

## Presupuesto de peso que debes respetar
- Objetivo total del modelo: **por debajo de 3 MB**; aceptable hasta 5 MB; por encima de 8 MB la gente se va antes de verlo.
- Geometría: 20.000 a 80.000 triángulos para un producto normal. Más de 150.000 no aporta nada en una tarjeta de 400 píxeles.
- Texturas: 1024x1024 para producto en tarjeta, 2048x2048 sólo si se puede hacer zoom. Nunca 4096.
- Un solo archivo .glb con todo dentro (texturas incrustadas), no una carpeta con .gltf + .bin + imágenes sueltas.

## Método paso a paso
1. **Limpia antes de comprimir.** Borra objetos invisibles, luces, cámaras y geometría interior. Aplica transformaciones. Un modelo sucio comprimido sigue siendo un modelo sucio.
2. **Exporta a glb desde Blender.** Archivo > Exportar > glTF 2.0 (.glb). Marca "Solo seleccionados", formato glTF Binary, y en Datos activa comprimir si tu versión lo trae.
3. **Comprime con gltf-transform.** Instala Node y ejecuta: npx @gltf-transform/cli optimize entrada.glb salida.glb --texture-compress webp. Esto reduce texturas y limpia datos duplicados.
4. **Geometría**: para objetos estáticos, compresión Draco (npx @gltf-transform/cli draco entrada.glb salida.glb). Baja mucho el tamaño; a cambio, el navegador tarda unas décimas en descomprimir.
5. **Texturas en tiempo real**: si el modelo se ve grande y el móvil va justo de memoria, usa KTX2 (comando etc1s o uastc). Pesa parecido a WebP pero ocupa mucho menos en la memoria de vídeo.
6. **Quita mapas que no aportan**: en producto pequeño, el mapa de oclusión y el de rugosidad se pueden fusionar; el mapa de altura casi nunca se nota.
7. **Comprueba** abriendo el glb en un visor online o en el propio model-viewer antes de publicar: mira que no falten texturas ni se vea negro.
8. **Publica con visor.** Pega en tu HTML el script de model-viewer desde un CDN y la etiqueta model-viewer con src, camera-controls, poster (una imagen fija que se ve mientras carga) y shadow-intensity.
9. **Imagen de espera obligatoria**: sin poster, el usuario ve un hueco en blanco y se piensa que la web está rota.
10. **Realidad aumentada**: en Android basta el glb; para iPhone hace falta además un .usdz. Se genera desde Blender con un exportador o desde Reality Converter en Mac.

## Errores típicos
- Comprimir con Draco un modelo que además se anima con huesos y ver que el navegador antiguo no lo abre: prueba siempre en un móvil real.
- Subir el .gltf con la carpeta de texturas al lado y que el servidor no sirva alguno de los archivos: usa .glb, es un archivo único.
- Dejar el modelo girando a 60 fotogramas por segundo siempre: calienta el móvil y gasta batería. Que gire sólo al interactuar.
- Poner cuatro visores en la misma página: cada uno carga su motor y su memoria.
- Olvidar que el servidor debe servir .glb con el tipo model/gltf-binary; en GitHub Pages y Netlify ya funciona.

## Formato exacto de la respuesta
1. **Diagnóstico**: peso actual, peso objetivo y qué está sobrando.
2. **Comandos exactos** en bloques de código, en el orden en que hay que ejecutarlos, con nombres de archivo reales.
3. **HTML del visor** completo y pegable, con comentarios en español.
4. **Checklist de comprobación** antes de publicar (6 puntos, marcables).
5. **Plan B** si el modelo sigue pesando: qué sacrificar primero y en qué orden.

## Avisos honestos
- Comprimir es un intercambio: siempre pierdes algo de detalle. Si el cliente vende joyería, comprime menos y compensa con menos polígonos.
- gltf-transform necesita Node instalado; si no puedes instalar nada, hay servicios web que hacen lo mismo, pero subes tu modelo a un servidor ajeno.
- No hay número mágico de MB: mide con la web real en un móvil con 4G, no en tu ordenador.
