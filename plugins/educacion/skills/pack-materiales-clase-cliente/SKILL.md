---
name: pack-materiales-clase-cliente
description: Genera un pack completo de materiales de clase (presentación, ficha, rúbrica, juego) a partir del encargo de un profesor o academia, con formato de entrega para cobrarlo como servicio. Se activa cuando el usuario pide crear materiales educativos para un cliente o alumno concreto.
---

# Pack de materiales de clase para entregar a un cliente

## Qué hace

Toma un encargo (tema, curso, duración, tipo de alumnado) y devuelve un pack de cuatro piezas listas para maquetar en Canva, Genially o Google Slides:

1. Guion de presentación, diapositiva a diapositiva.
2. Ficha de trabajo para el alumno con solucionario aparte.
3. Rúbrica de evaluación con niveles y criterios.
4. Juego de repaso con reglas y materiales necesarios.

Todo con lenguaje de aula en España (LOMLOE: situaciones de aprendizaje, competencias específicas, criterios de evaluación) y con una hoja de entrega que el cliente entiende sin explicaciones.

## Qué preguntar antes de empezar

No generes nada hasta tener estas cinco respuestas. Si falta alguna, pregúntala. Si el usuario no la sabe, propón un valor y márcalo como [SUPUESTO].

- Etapa y curso exactos (por ejemplo, 5º de Primaria, 2º ESO, FP Básica). No aceptes "niños" o "adolescentes".
- Tema y qué tiene que saber hacer el alumno al terminar, en una frase.
- Duración de la sesión o sesiones (una clase de 50 minutos no es lo mismo que una semana).
- Si hay alumnado con necesidades específicas de apoyo educativo (NEAE) o si hay que ofrecer una versión adaptada.
- Herramienta donde lo va a maquetar el cliente: Canva, Genially, PowerPoint, Google Slides o papel. Cambia el formato de salida.

Pregunta también, aunque no bloquee el trabajo, si el cliente ya usa un libro de texto. Si lo usa, el material tiene que encajar con su secuencia, no competir con ella.

## Paso a paso

1. Resume el encargo en tres líneas y confírmalo con el usuario antes de seguir. Aquí se evitan la mayoría de las repeticiones.
2. Redacta el objetivo de aprendizaje en formato LOMLOE: una competencia específica y uno o dos criterios de evaluación del currículo de la comunidad autónoma del cliente. Si no sabes cuál es la comunidad, pregunta. Si no tienes acceso al currículo concreto, escribe [CRITERIO DE EVALUACIÓN A CONFIRMAR CON EL DOCENTE] en lugar de inventarlo.
3. Presentación: entre 8 y 15 diapositivas. Para cada una: título, texto que aparece en pantalla (máximo 30 palabras), qué dice el profesor (notas del orador) e idea visual descrita con palabras. Nunca pegues URL de imágenes.
4. Ficha: entre 6 y 10 actividades, de menor a mayor dificultad. La última siempre es de aplicación o creación, no de repetir. Solucionario en una sección separada, para que el cliente lo recorte antes de imprimir.
5. Rúbrica: 4 niveles (Inicial, En proceso, Conseguido, Avanzado) y entre 3 y 5 criterios. Cada celda describe una conducta observable, no un adjetivo. "Usa tres fuentes y las cita" sí; "buen trabajo" no.
6. Juego: nombre, número de jugadores, duración, materiales, reglas en menos de 10 pasos, cómo se gana y una variante para hacerlo más fácil o más difícil. Debe poder jugarse con papel y tijeras si no hay pantallas.
7. Si se pidió versión adaptada, genera la ficha y la rúbrica adaptadas al final, no mezcladas con las originales.
8. Cierra con la hoja de entrega (formato abajo).

## Qué devolver y con qué formato

Un único documento Markdown con este orden y estos títulos exactos, para que el usuario pueda pegarlo en Google Docs y enviarlo:

- `# Pack: [TEMA] — [CURSO]`
- `## Hoja de entrega` con: qué contiene, para qué sesión, qué tiene que hacer el cliente para usarlo (maquetar, imprimir, adaptar), licencia de uso y datos de contacto del autor. Deja la licencia en dos opciones para que el usuario elija: uso en su centro sin límite pero sin reventa, o uso libre con atribución.
- `## 1. Presentación` con tabla: nº, título, texto en pantalla, notas del orador, idea visual.
- `## 2. Ficha del alumno` y después `## 2b. Solucionario`.
- `## 3. Rúbrica` en tabla.
- `## 4. Juego de repaso`.
- `## 5. Versión adaptada` solo si se pidió.
- `## Pendientes de confirmar` con todos los [SUPUESTO] y [A CONFIRMAR] del documento en una lista. Este bloque es lo que se envía al cliente antes de facturar.

## Qué NO hacer

- No inventes criterios de evaluación ni códigos de competencias si no los tienes delante. Un profesor los detecta a la primera y pierdes el cliente.
- No incluyas imágenes, iconos o URL de bancos de imágenes. Describe la imagen. Las imágenes con derechos son el problema legal más habitual al vender materiales; el cliente debe usar sus propias licencias de Canva, Genially o bancos libres.
- No copies fragmentos de libros de texto ni de materiales de editoriales, aunque el cliente los pegue en el encargo. Reformula siempre.
- No pongas textos de más de 30 palabras en una diapositiva. Si hace falta más, va a las notas del orador.
- No generes el pack entero si el encargo es ambiguo. Pregunta. Una hora de preguntas ahorra tres de rehacer.
- No uses rúbricas con adjetivos (bueno, regular, malo). Cada celda tiene que ser observable.
- No prometas que el material "cumple la LOMLOE" o "está aprobado". Eso lo decide el docente y la inspección, no un documento.
- No firmes ni añadas datos del autor si el usuario no los ha dado. Deja [NOMBRE Y CONTACTO DEL AUTOR].
