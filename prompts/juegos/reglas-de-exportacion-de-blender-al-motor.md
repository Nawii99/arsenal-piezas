# Reglas de exportación de Blender al motor…

**Tipo:** Prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Fija de una vez las escalas, pivotes, nombres y ajustes para que tus modelos entren en Unity o Unreal sin girarse, encogerse ni perder materiales.

## Qué es y qué hace

Prompt para cualquier chat de IA que actúa como artista técnico de la cadena Blender a motor. Explica en llano unidades y ejes, y fija reglas de escala, pivotes, nombres, materiales y ajustes de exportación para Unity, Unreal, Godot o web, de modo que los modelos no entren girados ni sin texturas.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu versión de Blender, motor y problemas
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Aplica las normas y exporta un modelo de prueba

## Cuándo usarla

Úsalo cuando al meter un modelo en el motor salga gigante, tumbado, sin texturas o girando sobre un punto raro.

## Cómo ganar dinero con ella

Ahorra las horas que se pierden reparando cada asset a mano y te deja entregar paquetes de assets que el cliente puede usar sin tocar nada.

- Normas de exportación y plantilla de Blender a motor para estudios pequeños…
- Servicio de preparación de paquetes de assets listos para usar en Unity o Unreal…
- Reparación de assets mal exportados para clientes…

**Precio orientativo:** 60–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como artista técnico responsable de la cadena de trabajo entre Blender y el motor, encargado de escribir las normas del equipo para que ningún asset entre roto.
MI CASO
De dónde exporto: Blender [VERSIÓN]. A dónde: [UNITY / UNREAL / GODOT / THREE.JS O WEB]
Qué tipo de assets: [PROPS / ESCENARIOS MODULARES / PERSONAJES CON ESQUELETO / VEHÍCULOS / MOBILIARIO PARA CONFIGURADOR]
Qué me está pasando ahora: [SALE ENORME O DIMINUTO / TUMBADO / SIN MATERIALES / EL PIVOTE ESTÁ EN CUALQUIER SITIO / LAS PIEZAS NO ENCAJAN ENTRE SÍ / LA ANIMACIÓN SE DEFORMA]
Trabajo solo o en equipo: [SOLO / CON MÁS GENTE]
QUÉ TIENES QUE HACER, PASO A PASO
1. Explícame en llano el lío de las unidades y de los ejes: por qué un programa considera que arriba es un eje y otro programa otro, y por qué el modelo aparece tumbado o a otra escala. Dime la regla fija que debo seguir siempre para mi combinación.
2. Dame la norma de escala: una unidad igual a un metro, modelar a tamaño real, y por qué esto importa para la física, la iluminación y la cámara.
3. Dame la norma de transformaciones: por qué hay que aplicar rotación y escala antes de exportar, qué pasa si no lo hago y cómo se nota en el motor.
4. Dame la norma de pivote según el tipo de objeto: en el suelo y centrado para props que se colocan, en el punto de giro para puertas y ruedas, en el origen del mundo para piezas modulares que deben encajar, y cómo se coloca en Blender.
5. Dame la rejilla de trabajo para escenarios modulares: medidas múltiplo de una unidad fija, encaje de paredes y suelos, y cómo evitar las juntas visibles.
6. Dame la convención de nombres para objetos, mallas, materiales, texturas, esqueletos y animaciones, con ejemplos, y explica por qué el nombre que se ve en el motor no siempre es el que crees.
7. Dame la lista de limpieza previa: vértices dobles, caras sueltas, normales hacia fuera, ausencia de modificadores sin aplicar salvo los que deben viajar, objetos ocultos, colecciones que no deben salir, materiales sin usar.
8. Dame las UV: qué revisar de la distribución, densidad de textura parecida entre piezas para que no se vea una nítida y otra borrosa, sin solapes cuando el motor necesita un segundo juego de coordenadas para la luz.
9. Dame los ajustes exactos de exportación para mi destino, opción por opción, y cuáles son las casillas que rompen todo si se marcan mal.
10. Cubre el caso de los personajes con esqueleto: jerarquía limpia, huesos con nombres claros, orientación, escala del esqueleto, cómo exportar el modelo y las animaciones y qué mirar si se deforma.
11. Dame la prueba de aceptación: qué compruebo nada más importar, con un objeto de referencia de tamaño conocido, y las cinco cosas que miro siempre antes de dar el asset por bueno.
12. Escríbeme el documento de normas del proyecto, corto, para pegarlo en una nota compartida y que cualquiera que entre lo siga.
RESTRICCIONES
Nada de scripts: menús, casillas y pasos.
Si un ajuste cambia según la versión, dímelo y explica cómo localizarlo por su nombre.
No mezcles consejos de dos motores distintos: céntrate en el mío.
FORMATO DE LA RESPUESTA
A. Reglas de oro en 10 líneas.
B. Tabla de convenciones de nombres con ejemplos.
C. Lista de limpieza previa, marcable.
D. Ajustes de exportación, opción por opción.
E. Prueba de aceptación al importar.
F. Síntoma y causa: tabla con el problema que veo y qué lo provoca.
G. Documento de normas del proyecto, listo para copiar.
CRITERIOS DE CALIDAD
Está bien si un modelo nuevo entra en el motor con el tamaño correcto, de pie, con su pivote útil y sus materiales reconocibles, sin tocar nada.
Está mal si sigo arreglando cada asset a mano después de importarlo.
```
