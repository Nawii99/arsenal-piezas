---
name: prompt-3d-ia
description: Escribe prompts e imágenes de referencia para generadores 3D con IA (Meshy, Tripo, Rodin, Hunyuan3D) y detalla el proceso de limpieza que necesita el resultado en bruto antes de poder usarse. Úsala cuando el usuario quiera un modelo 3D rápido sin saber modelar, para prototipos, objetos de fondo o impresión 3D.
---

# Prompts para generadores 3D con IA

## Qué hace

Prepara la entrada correcta para un generador 3D (que casi siempre es una imagen, no un texto) y explica qué hacer con lo que sale, que nunca viene listo para usar.

## Cuándo se activa

Cuando el usuario menciona generar un 3D con IA, Meshy, Tripo, Rodin, Hunyuan3D, text-to-3D o image-to-3D.

## Qué preguntar

1. Para qué es la pieza: prototipo visual, prop de fondo en un juego, impresión 3D, render de producto.
2. ¿Tiene que animarse o moverse?
3. Estilo: realista, estilizado, low poly.
4. ¿Hay una referencia real (foto del objeto) o hay que inventarlo?

## Método

### 1. Elegir la vía: imagen antes que texto

La generación a partir de imagen da resultados mucho más controlables que la de texto. Si no tienes foto, genera primero una imagen con un generador de imágenes y usa esa imagen como entrada del generador 3D. Ese doble paso es la diferencia entre algo usable y una masa deforme.

### 2. Cómo debe ser la imagen de referencia

- Objeto completo, sin recortes, centrado.
- Fondo liso y bien contrastado con el objeto (blanco o gris neutro).
- Vista de tres cuartos, ligeramente por encima; nada de perspectivas extremas.
- Iluminación plana y difusa, sin sombras duras ni brillos fuertes: las sombras se quedan pegadas en la textura.
- Si es un personaje, en pose de T o A, brazos separados del cuerpo, sin objetos tapando.

### 3. Estructura del prompt de imagen previa

[Objeto concreto] + [material y acabado] + [estilo] + fondo gris neutro, iluminación de estudio difusa, vista de tres cuartos, objeto completo dentro del encuadre, sin sombras duras, sin texto ni marcas de agua.

### 4. Ajustes típicos del generador 3D

- Pide topología de cuadriláteros si la herramienta lo ofrece: se puede editar después.
- Marca la simetría si el objeto es simétrico.
- Genera texturas PBR si la herramienta lo permite; si no, tendrás solo color base.
- Genera 3-4 variantes y elige: es más rápido que corregir una mala.

### 5. Limpieza obligatoria de lo que sale

- Escala: casi nunca viene a tamaño real. Ponlo a 1 unidad = 1 metro y comprueba con un cubo de referencia.
- Orientación y pivote: recolócalo en el origen, apoyado en el suelo.
- Malla: suele venir triangulada, densa y con topología caótica. Para render está bien; para animar hay que retopologizar.
- Agujeros y masas sueltas: cierra huecos y borra trozos flotantes.
- Textura: viene con la luz de la foto horneada. Si vas a iluminar la escena, pinta o desatura esos brillos, o quedará doble sombra.
- Las partes que no se ven en la foto de referencia salen inventadas: revisa la trasera siempre.

### 6. Para qué sirve y para qué no

- Sirve: props de fondo, bocetos rápidos para enseñar a un cliente, bases para esculpir encima, piezas para impresión 3D, decorados.
- No sirve todavía: personaje protagonista, piezas que necesiten precisión de medidas, objetos con texto o logos legibles, mallas listas para riggear sin retoque.

## Formato de la respuesta

1. Prompt de la imagen de referencia, listo para copiar.
2. Prompt o ajustes para el generador 3D.
3. Lista de comprobación de la malla resultante.
4. Pasos de limpieza en Blender, en orden, con el nombre del modificador o herramienta en cada paso.
5. Veredicto honesto: si para este caso concreto conviene más generar o modelar a mano.

## Errores típicos

- Usar una foto con fondo complejo: el generador se traga el fondo.
- Esperar un modelo riggeado y animable.
- Meter la malla generada tal cual en un juego: se come el rendimiento por triángulos innecesarios.
- No revisar la parte trasera del objeto antes de entregarlo a un cliente.

## Avisos honestos

- Las condiciones de uso comercial cambian según la herramienta y el plan de pago: revisa la licencia antes de vender nada hecho con esto.
- Si el resultado lo publicas en una tienda como Steam, puede que tengas que declarar que hay contenido generado con IA.
