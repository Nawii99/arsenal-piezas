# Adelgazar un modelo 3D pesado para web, móvil o AR…

**Tipo:** Prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Coge un modelo que va a tirones o pesa demasiado y te da el plan exacto para bajarlo de peso sin que se note en pantalla.

## Qué es y qué hace

Prompt para cualquier chat de IA que actúa como artista técnico 3D. Con los datos del modelo (triángulos, texturas, materiales, peso y destino), fija un presupuesto objetivo y entrega un plan ordenado de reducción de peso para web, móvil o AR sin pérdida visible. Ejemplo: bajar un GLB de zapatilla para un visor web.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con los datos del modelo
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Aplica el plan en Blender o tu programa y mide el resultado

## Cuándo usarla

Úsalo cuando un modelo 3D tarde en cargar en la web, vaya lento en el móvil o el cliente te diga que el visor no le funciona.

## Cómo ganar dinero con ella

Te permite vender configuradores y visores 3D que cargan rápido, y aceptar encargos de optimización, un trabajo que muchos artistas evitan.

- Servicio de optimización de modelos 3D para tiendas online y visores web…
- Paquete de modelos ligeros GLB para configuradores de producto…
- Auditoría de rendimiento de assets 3D para apps móviles y AR…

**Precio orientativo:** 40–150 € por pieza. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como artista técnico 3D con años de experiencia optimizando assets para web, móvil y realidad aumentada, acostumbrado a explicárselo a gente sin perfil técnico.
MI CASO
Qué es el modelo: [DESCRIBE: MUEBLE, ZAPATILLA, COCHE, PERSONAJE, ESCENA COMPLETA]
Datos que sé de él: triángulos [NÚMERO O NO LO SÉ], número de objetos y materiales [NÚMERO], texturas y su tamaño [EJ: 6 TEXTURAS DE 4096], peso del archivo [MB], formato [FBX / OBJ / GLB / BLEND]
Dónde tiene que funcionar: [WEB EN MÓVIL / VISOR AR EN EL NAVEGADOR / JUEGO MÓVIL / UNREAL O UNITY EN PC]
Qué falla ahora: [TARDA EN CARGAR / VA A TIRONES / SE VE BORROSO / SE CUELGA]
Cómo se ve en pantalla: [OCUPA MEDIA PANTALLA / SE VE DE LEJOS / SE PUEDE GIRAR Y ACERCAR MUCHO]
QUÉ TIENES QUE HACER, PASO A PASO
1. Dame primero el presupuesto objetivo para mi caso: triángulos, número de materiales, resolución de texturas y peso final del archivo, con un rango razonable y el motivo de cada número.
2. Explícame en llano de qué depende que vaya lento: cantidad de triángulos, número de materiales y llamadas de dibujo, tamaño de las texturas en memoria, transparencias apiladas, sombras en tiempo real y modelos ocultos que siguen cargados.
3. Ordena las acciones por relación esfuerzo/beneficio, de la que más peso quita con menos trabajo a la que menos.
4. Para cada acción dime: qué hago, en qué programa (Blender es la opción gratuita), qué botón o modificador equivale, y el error típico que la estropea.
5. Cubre al menos: unir objetos que comparten material, quitar geometría interior que nunca se ve, reducir densidad con retopología o decimado controlado, arreglar normales invertidas, fusionar materiales en un atlas de texturas, bajar resolución de texturas por canal, quitar canales inútiles, hornear detalle a un mapa de normales.
6. Dime qué texturas puedo bajar más sin que se note (rugosidad, metalidad, oclusión suelen aguantar la mitad de resolución que el color) y cuáles no.
7. Explícame los LOD: cuántos niveles necesito para mi caso y a qué porcentaje de triángulos.
8. Dame el formato y compresión de salida adecuados para mi destino, con los ajustes concretos que debo marcar al exportar.
9. Dime cómo comprobar si va bien: qué mirar antes y después, cuántos segundos debería tardar en cargar y qué herramientas gratuitas del navegador o del programa me lo dicen.
10. Avísame de los daños colaterales: siluetas que se rompen al decimar, UV que se estiran, deformaciones raras si el modelo tiene esqueleto, bordes duros que aparecen al fusionar vértices.
RESTRICCIONES
No supongas que sé usar nodos ni scripts: describe los pasos como una receta.
Si te faltan datos del modelo, dime cómo obtenerlos en Blender en dos clics antes de seguir.
No me digas simplemente que use un decimado al 50%: dime cuánto y en qué partes.
FORMATO DE LA RESPUESTA
A. Diagnóstico en 5 líneas: qué te sobra y por qué va lento.
B. Tabla de presupuesto: Métrica, Ahora, Objetivo, Cómo llegar.
C. Plan de trabajo numerado con tiempo estimado por paso.
D. Ajustes de exportación exactos.
E. Lista de comprobación final de 8 puntos para dar el modelo por bueno.
F. Qué NO tocar en este modelo concreto para no romperlo.
CRITERIOS DE CALIDAD
Está bien si el modelo carga rápido y, comparando capturas antes y después a la distancia real de uso, no se aprecia la diferencia.
Está mal si has ganado peso perdiendo la silueta o si las texturas se ven pastosas.
```
