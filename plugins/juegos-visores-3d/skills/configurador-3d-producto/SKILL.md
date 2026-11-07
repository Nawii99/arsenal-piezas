---
name: configurador-3d-producto
description: Crea un visor/configurador 3D interactivo de producto para una web con el componente model-viewer, con variantes de material, puntos de interés, RA en móvil e imágenes de respaldo. Úsala cuando alguien quiera mostrar un producto en 3D en su web, dejar que los clientes cambien colores o acabados, o sustituir fotos estáticas por una vista interactiva.
---

# Configurador 3D de producto para tu web

## Qué hace
Genera el HTML completo de un visor 3D que se puede pegar en cualquier página: girar el producto, cambiar color o acabado, ver medidas y abrirlo en realidad aumentada desde el móvil.

## Cuándo se activa
Cuando el usuario quiere enseñar un producto en 3D en su web, montar un selector de acabados, o pregunta cómo poner un modelo GLB en una página.

## Qué preguntar
1. ¿Tienes ya el modelo en GLB? Si no, pregunta de dónde sale (encargo, escaneo, banco de modelos).
2. ¿Qué variantes hay? Colores, materiales, tamaños, piezas opcionales.
3. ¿Las variantes son solo cambio de color o cambia la forma?
4. ¿Dónde se va a insertar? WordPress, Shopify, HTML propio, Notion.
5. ¿Quieres que al elegir variante cambie el precio o el enlace de compra?

## Cómo se hace de verdad
- La forma más sencilla y sin coste es el componente `<model-viewer>` de Google: una etiqueta HTML y un script. No necesitas saber programar en 3D.
- Las variantes de color se resuelven de dos maneras: cambiando el color base del material desde JavaScript (rápido, ideal para colores planos) o con variantes de materiales guardadas dentro del propio GLB desde Blender (mejor cuando cambia la textura, no solo el tono).
- Si cambia la forma (con brazos / sin brazos), lo limpio es un GLB por variante y cargarlos al vuelta de clic, no un mega-modelo con todo escondido dentro.
- La realidad aumentada funciona sola en Android con el mismo GLB; en iPhone hace falta además un fichero USDZ, que se genera desde Reality Converter o desde Blender con exportador USD.

## Método paso a paso
1. Prepara el modelo: escala real en metros, origen en la base del objeto, mirando al frente en -Z, materiales con nombres claros (`cuerpo`, `patas`, `tapizado`).
2. Optimiza el peso antes de publicar: por debajo de 5 MB. Si pesa más, aplica primero la optimización de modelos.
3. Escribe el HTML con `<model-viewer>` incluyendo: `camera-controls`, `auto-rotate` suave, `shadow-intensity`, `ar` y `poster` con una imagen fija.
4. Añade los botones de variante y el JavaScript que cambia material o carga otro GLB.
5. Añade puntos calientes (hotspots) para señalar medidas o detalles: son etiquetas ancladas a un punto del modelo.
6. Pon siempre una imagen de respaldo por si el navegador no carga el 3D, y un texto alternativo.
7. Prueba en móvil real con datos móviles, no solo en el ordenador.

## Detalles que separan lo profesional de lo cutre
- Iluminación: usa un HDRI neutro de estudio; sin él el producto se ve plano y gris.
- Ángulo inicial: nunca de frente puro; tres cuartos y ligeramente por encima vende mucho más.
- Zoom limitado para que no puedan meterse dentro del modelo y ver el interior vacío.
- Sombra de contacto activada: sin ella el objeto parece flotar.
- Un cartel discreto de 'arrastra para girar' los primeros segundos; mucha gente no sabe que es interactivo.

## Errores típicos
- Subir el modelo con escala en centímetros: en realidad aumentada aparece un sofá del tamaño de un edificio.
- Origen del modelo en el centro en vez de en la base: en AR se hunde en el suelo.
- Cargar los cinco GLB de variantes al abrir la página; carga solo el primero y el resto bajo demanda.
- Olvidar el `poster`: la página se ve en blanco mientras carga.
- Usar un modelo con licencia que no permite uso comercial en una tienda.

## Formato de la respuesta
1. Un bloque HTML completo y comentado, listo para pegar.
2. Instrucciones de dónde pegarlo según su plataforma.
3. Lista de lo que debe preparar en el modelo antes (escala, origen, nombres de material).
4. Checklist de prueba en móvil y escritorio.
5. Alternativa sencilla si no tiene modelo 3D todavía.

## Avisos honestos
- Un visor 3D no sustituye a buenas fotos: complementa. Mantén al menos una foto real como imagen principal.
- Si tu web es Shopify o WordPress con plantilla cerrada, quizá haya que insertar el visor en un bloque HTML personalizado o mediante iframe.
- La realidad aumentada en iPhone requiere el fichero extra USDZ; si no lo tienes, el botón de AR no funcionará y es mejor ocultarlo.
