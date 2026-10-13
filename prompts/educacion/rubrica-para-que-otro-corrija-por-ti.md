# Rúbrica para que otro corrija por ti…

**Tipo:** Prompt · **Área:** Formación · **Licencia:** CC BY 4.0

Convierte tu criterio de profesor en una rúbrica y un guion de corrección tan claros que un ayudante pueda corregir igual que tú.

## Qué es y qué hace

Prompt para cualquier chat de IA que convierte tu criterio de corrección en una rúbrica con 4 a 6 criterios observables y un guion que otra persona pueda aplicar igual que tú. Admite entregas de ejemplo y devuelve rúbrica, pesos y casos límite. Ejemplo: formar a un ayudante corrector.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Pega la tarea y dos entregas de ejemplo y rellena los [corchetes]
3. Prueba la rúbrica con tu ayudante y ajusta

## Cuándo usarla

Cuando ya no llegas a corregir todo, vas a meter a un ayudante o quieres que las correcciones sean coherentes entre ediciones.

## Cómo ganar dinero con ella

Te libera horas de corrección que puedes dedicar a vender o grabar, y permite delegar la parte más cara de tu tiempo a alguien más barato sin bajar la calidad.

- Rúbricas delegables para equipos de corrección…
- Manual de corrección para academias con varios tutores…
- Estandarización de criterios entre ediciones de un curso…

**Precio orientativo:** 100–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como coordinador académico con experiencia formando correctores. Sabes que una rúbrica solo funciona si dos personas distintas puntúan igual el mismo trabajo, y que la mayoría de rúbricas fallan porque usan palabras como adecuado o suficiente sin definirlas.

CONTEXTO
Formación: [NOMBRE Y TEMA]
Ejercicio o entrega que hay que corregir: [DESCRIBE LA TAREA CON DETALLE]
Qué debe demostrar el alumno con esa entrega: [OBJETIVO REAL]
Tiempo máximo que quiero que se dedique a corregir cada entrega: [POR EJEMPLO: 8 minutos]
Quién va a corregir: [YO, UN AYUDANTE JUNIOR, OTRO PROFESOR]
Nivel de exigencia: [EXPLICA SI ES UN CURSO INICIÁTICO O UNA CERTIFICACIÓN SERIA]
Te pego dos entregas de ejemplo, una buena y una regular: [PEGA AQUÍ; si no tienes, dímelo y trabajamos sin ellas]

QUÉ TIENES QUE HACER
1. Define entre 4 y 6 criterios de evaluación. Cada criterio debe ser observable en la entrega, no en la cabeza del alumno. Prohibido criterios como creatividad o esfuerzo si no los aterrizas en algo visible.
2. Para cada criterio, escribe cuatro niveles con descripciones de conducta observable: no presente, insuficiente, correcto, excelente. Cada descripción debe decir qué se ve en el trabajo, con ejemplos concretos del tema de mi curso.
3. Asigna peso a cada criterio y justifica el reparto en una línea. Los criterios que no afectan al resultado profesional llevan poco peso.
4. Marca cuáles son criterios eliminatorios: fallos que hacen que la entrega se devuelva sin puntuar aunque el resto esté bien.
5. Escribe el guion de corrección paso a paso que seguirá el ayudante: en qué orden mira las cosas, dónde no debe meterse, y qué hacer ante casos raros.
6. Redacta tres plantillas de devolución al alumno: entrega excelente, entrega correcta con mejoras, entrega a repetir. Cada una con esta estructura: qué has conseguido, qué falta exactamente, el siguiente paso concreto, y una frase de cierre. Deja los huecos entre corchetes.
7. Escribe la prueba de calibración: coge la entrega de ejemplo y corrígela tú aplicando la rúbrica, mostrando la puntuación de cada criterio y el porqué. Eso servirá de patrón para el ayudante.
8. Añade cinco frases prohibidas en las devoluciones y su alternativa.

RESTRICCIONES
Español de España, tuteo con el alumno, usted nunca.
Nada de puntuaciones con decimales ni fórmulas complicadas.
La rúbrica entera tiene que caber en una hoja para poder tenerla al lado.

FORMATO DE RESPUESTA
Tabla de la rúbrica: criterios en filas, los cuatro niveles en columnas, peso en la última columna.
Lista de criterios eliminatorios.
Guion de corrección numerado.
Las tres plantillas de devolución completas.
Ejemplo corregido con el razonamiento visible.
Apartado Cómo comprobar que dos correctores puntúan igual, con un procedimiento concreto de tres pasos.

CRITERIOS DE CALIDAD
La rúbrica está bien si dos personas distintas dan la misma puntuación con menos de un nivel de diferencia en cada criterio.
Está mal si alguna descripción de nivel podría aplicarse a dos niveles distintos.
Revisa tu propia rúbrica al final y señala cualquier descripción ambigua que hayas escrito, y reescríbela.

Pregunta lo que te falte antes de empezar, máximo tres preguntas.
```
