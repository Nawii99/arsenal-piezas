# Rúbrica y feedback a alumnos…

**Tipo:** Prompt · **Área:** Formación · **Licencia:** CC BY 4.0

Crea la rúbrica de corrección de una entrega y el texto de feedback personalizado, útil y no genérico, para cada nivel de resultado.

## Qué es y qué hace

Prompt para cualquier chat de IA que crea una rúbrica de corrección con 4 a 6 criterios observables y 4 niveles por criterio, más textos de feedback personalizados por nivel. Entra la descripción de la entrega y el nivel del alumnado; sale la rúbrica y los comentarios. Ejemplo: corregir proyectos finales de un curso.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Rellena los [corchetes] con la entrega y la escala
3. Aplica la rúbrica y adapta los comentarios a cada alumno

## Cuándo usarla

Úsalo cuando tengas que corregir trabajos de alumnos y quieras que la corrección sea justa, rápida y que de verdad enseñe.

## Cómo ganar dinero con ella

Corregir con rúbrica te lleva un tercio del tiempo y sube la percepción de valor de tu formación, que es lo que sostiene el precio.

- Rúbricas y banco de feedback para academias y formadores…
- Servicio de corrección de entregas con informe por alumno…
- Estandarización de la evaluación para centros de formación pequeños…

**Precio orientativo:** 80–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como evaluador experto en formación práctica de adultos. Sabes que un feedback genérico tipo buen trabajo, sigue así no enseña nada y quema tu reputación.
Vas a crear la rúbrica y los textos de feedback para corregir una entrega.
CONTEXTO:
- Entrega que corrijo: [DESCRIBE LA TAREA]
- Qué debía demostrar el alumno: [RESULTADO DE APRENDIZAJE]
- Nivel del alumnado: [NIVEL]
- Cómo entregan: [FORMATO]
- Cuánto tiempo puedo dedicar a cada corrección: [MINUTOS]
- Si se pone nota: [SÍ / NO] y escala: [ESCALA]
CONSTRUYE:
PASO 1. CRITERIOS: entre 4 y 6, ni uno más. Cada uno debe ser observable en la entrega. Evita criterios como calidad general, esfuerzo o creatividad si no puedes describirlos por escrito.
PASO 2. NIVELES: para cada criterio describe 4 niveles (no logrado, en camino, logrado, excelente) con una descripción de lo que se VE en la entrega, no de lo que el alumno siente. Nada de descripciones que solo se diferencien por adverbios: distinto contenido, no distinto adjetivo.
PASO 3. PESOS: reparte el peso de cada criterio y justifica en una frase por qué ese es el que más pesa.
PASO 4. UMBRAL: qué hace falta como mínimo para dar la entrega por válida. Define también el criterio eliminatorio, si lo hay.
PASO 5. BANCO DE FEEDBACK: para cada criterio y cada nivel, una frase de feedback reutilizable que diga qué pasa, por qué importa y qué hacer en la próxima versión. Deja huecos entre corchetes para personalizar con un detalle real de la entrega.
PASO 6. PLANTILLA DE DEVOLUCIÓN al alumno con esta estructura: lo que ya funciona (2 puntos concretos), lo que hay que cambiar (máximo 2, ordenados por impacto), el arreglo exacto del punto más importante con un ejemplo, y una sola pregunta que le haga pensar.
PASO 7. Tres versiones completas de devolución de ejemplo: una entrega floja, una correcta y una muy buena, con la corrección escrita entera para que yo vea el tono.
PASO 8. ERRORES DEL CORRECTOR a evitar: corregir estilo cuando el criterio es de fondo, señalar 10 cosas a la vez, comparar con otros alumnos, escribir en negativo sin dar salida.
RESTRICCIONES:
- Máximo 2 cambios pedidos por entrega: más de dos no se aplican.
- Todo el feedback en tuteo, directo y sin condescendencia.
- Nunca corrijas nada que no esté recogido en un criterio de la rúbrica.
- La corrección completa de una entrega debe caber en el tiempo que te he dicho.
FORMATO DE RESPUESTA: tabla de rúbrica (criterio, peso, 4 niveles descritos), umbral de aprobado, banco de frases de feedback, plantilla de devolución y las tres devoluciones de ejemplo.
CRITERIOS DE CALIDAD: dos correctores distintos darían la misma nota; el alumno sabe exactamente qué tocar primero; ninguna frase del feedback serviría igual para cualquier trabajo.
```
