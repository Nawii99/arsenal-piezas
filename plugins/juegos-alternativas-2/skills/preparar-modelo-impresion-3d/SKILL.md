---
name: preparar-modelo-impresion-3d
description: "Audita y prepara un modelo 3D para impresión FDM o de resina: geometría estanca, grosor de paredes, voladizos, tolerancias, orientación, escala y exportación a STL/3MF. Úsala antes de enviar un modelo a la impresora o de venderlo como archivo imprimible."
---

# Preparar un modelo para impresión 3D

## Qué hace
Somete un modelo a la revisión que hace un profesional antes de imprimir, encuentra lo que va a fallar y te da los arreglos concretos.

## Cuándo se activa
Cuando el usuario habla de imprimir en 3D, STL, laminador, resina, FDM, Prusa, Bambu, Elegoo, soportes o de vender archivos imprimibles.

## Qué preguntar
1. ¿Impresora de filamento (FDM) o de resina? Cambia todo.
2. ¿Tamaño final de la pieza en milímetros y volumen de impresión de la máquina?
3. ¿La pieza es decorativa o funcional (tiene que encajar, soportar peso, girar)?
4. ¿Es una pieza suelta o un conjunto con partes que encajan?
5. ¿Lo vas a imprimir tú o lo mandas a un servicio?

## Reglas de oficio que se aplican
- Grosor mínimo de pared: 1,2 mm en FDM (unos tres perímetros de boquilla 0,4) y 0,8-1 mm en resina. Detalles finos por debajo se rompen o desaparecen.
- Voladizos: por encima de 45 grados respecto a la vertical necesitan soportes. Un chaflán de 45 grados evita soportes en la base.
- Agujeros: los agujeros horizontales salen ovalados; diséñalos en forma de gota o taladra después.
- Tolerancias de encaje: 0,2 mm de holgura para un encaje suave, 0,1 mm para uno a presión en FDM; en resina, 0,05-0,1 mm.
- Detalles grabados: mínimo 0,4 mm de ancho y 0,4 mm de profundidad para que se lean.
- El modelo debe ser cerrado y sin geometría interna suelta: sin agujeros, sin caras invertidas, sin caras duplicadas, sin autointersecciones.
- Escala: los ficheros de impresión se interpretan en milímetros. Un modelo exportado desde Blender en metros aparece 1000 veces más pequeño.

## Método paso a paso
1. Importa el modelo y comprueba unidades y dimensiones reales.
2. Pasa la revisión de malla: en Blender, activa el complemento 3D Print Toolbox y ejecuta Check All. Anota agujeros, caras degeneradas, grosor insuficiente y voladizos.
3. Arregla en este orden: cerrar agujeros, recalcular normales hacia fuera, eliminar geometría suelta e interior, unir sólidos que se tocan con una unión booleana real.
4. Corrige grosores finos engrosando esas zonas, no escalando toda la pieza.
5. Decide la orientación de impresión: la cara más bonita hacia arriba o alejada de los soportes, y las capas perpendiculares al esfuerzo principal si es funcional.
6. Si la pieza no cabe en la máquina, córtala por un plano discreto y añade pasadores de alineación de 4-5 mm con 0,2 mm de holgura.
7. Exporta en 3MF si el laminador lo admite (guarda unidades y colores) o en STL binario si te lo piden así.
8. Abre el fichero en el laminador y mira la vista previa por capas: ahí se ven islas flotantes, capas huérfanas y tiempos absurdos.

## Cómo saber si está bien
- El laminador no muestra avisos de malla no manifold.
- La vista previa no tiene islas sueltas en el aire sin soporte.
- El tiempo y el material estimados son razonables para el tamaño.
- Si es funcional, imprime primero una pieza de prueba solo con la zona de encaje: ahorra horas.

## Errores típicos
- Escalar la pieza al final y dejar paredes por debajo del mínimo.
- Reparar con herramientas automáticas y no volver a mirar: suelen redondear detalles finos.
- Diseñar encajes con medida exacta sin holgura: no entran nunca.
- Exportar con modificadores no aplicados y que falte la mitad del detalle.
- Vender un STL sin haberlo impreso ni una vez.

## Formato de la respuesta
1. Informe de revisión con lista de problemas encontrados y su gravedad.
2. Arreglo concreto para cada problema, con el paso exacto en Blender o en el laminador.
3. Recomendación de orientación, soportes, altura de capa y relleno.
4. Advertencias de piezas que van a fallar aunque el fichero esté correcto.
5. Si va a venderlo: qué incluir en el paquete (3MF preconfigurado, STL, foto de la pieza impresa, instrucciones de montaje).

## Avisos honestos
- Ninguna revisión sustituye a una impresión de prueba. Antes de vender un archivo, imprímelo.
- Las piezas impresas en FDM se parten por la unión de capas: si tiene que aguantar esfuerzo, oriéntala pensando en eso o cambia de tecnología.
- Vender modelos derivados de personajes o marcas con derechos es ilegal aunque los hayas modelado tú.
