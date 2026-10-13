# Prueba de nivel para segmentar alumnos…

**Tipo:** Prompt · **Área:** Formación · **Licencia:** CC BY 4.0

Crea el cuestionario de diagnóstico que pasas antes de empezar, para saber de qué pie cojea cada alumno y adaptar el contenido.

## Qué es y qué hace

Prompt para cualquier chat de IA que diseña una prueba de nivel de 7 minutos antes de una formación. Con el temario y el público, lista prerrequisitos duros y blandos, define perfiles de alumno y devuelve preguntas y criterio para asignar itinerario. Ejemplo: cuestionario previo a un curso con alumnos mixtos.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Rellena los [corchetes] con tu formación y temario
3. Pasa la prueba en un formulario y segmenta a los alumnos

## Cuándo usarla

Úsalo cuando vayas a impartir una formación y no sepas el nivel real de la gente que se ha apuntado.

## Cómo ganar dinero con ella

Reduce abandonos y devoluciones porque nadie se aburre ni se pierde, y te ahorra horas de clases que no hacían falta.

- Test de diagnóstico de entrada para academias y cursos…
- Segmentación de alumnos y rutas de aprendizaje para formadores…
- Formulario de nivel conectado a un formulario online para escuelas…

**Precio orientativo:** 80–220 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como diseñador instruccional con experiencia en formación para adultos y en evaluación diagnóstica.
Voy a impartir esta formación: [TEMA Y TÍTULO DE LA FORMACIÓN].
Público: [A QUIÉN VA DIRIGIDA: PROFESIÓN, EDAD APROXIMADA, POR QUÉ SE APUNTAN].
Formato: [ONLINE GRABADO / DIRECTO / PRESENCIAL] y duración total: [HORAS O SEMANAS].
Resultado final que promete la formación: [QUÉ SABRÁ HACER EL ALUMNO AL TERMINAR].
Temario provisional por módulos: [PEGA AQUÍ TU TEMARIO].
Tu tarea: diseñar una prueba de nivel previa que se conteste en 7 minutos y me diga a quién tengo delante.
Trabaja en este orden y enséñame cada paso.
PASO 1. Lista los prerrequisitos reales: qué tiene que saber o tener ya alguien para seguir la formación sin ahogarse.
Separa prerrequisitos duros (sin esto no puede empezar) de blandos (le costará más, pero puede).
PASO 2. Define 3 perfiles de alumno probables: nombre del perfil, qué sabe ya, qué le falta, qué le da miedo, qué espera llevarse.
PASO 3. Escribe la prueba con estas secciones y este número de preguntas.
Sección A, situación de partida: 4 preguntas cerradas sobre contexto (sector, herramientas que ya usa, tiempo semanal disponible, si lo hace por cuenta propia o en empresa).
Sección B, conocimiento real: 6 preguntas de opción múltiple sobre el contenido, no de teoría memorística sino de qué haría en una situación concreta.
Cada pregunta de la sección B con 4 opciones: una correcta, una que es el error típico de principiante, una plausible pero incompleta y una claramente falsa.
Marca la respuesta correcta y explica en una línea qué revela cada opción incorrecta sobre el nivel del alumno.
Sección C, objetivo personal: 2 preguntas abiertas cortas, una sobre qué problema concreto quiere resolver y otra sobre qué ha intentado ya sin éxito.
Sección D, una sola pregunta de autoevaluación del 1 al 5 sobre lo cómodo que se siente con el tema.
PASO 4. Crea la tabla de corrección: rangos de puntuación de la sección B, perfil asignado a cada rango y qué hago con ese alumno.
Para cada perfil indica: por qué módulo debe empezar, qué módulo puede saltarse, qué material de refuerzo le mando antes de empezar.
PASO 5. Escribe el mensaje de resultados que recibe el alumno: 6 líneas, tono cercano, sin humillar al que ha sacado poco, con su ruta recomendada.
PASO 6. Dime qué haría yo con las respuestas agregadas: 3 decisiones concretas que puedo tomar sobre el temario si la mayoría sale de un perfil.
RESTRICCIONES.
Nada de preguntas trampa ni de vocabulario técnico que el alumno aún no tiene que conocer.
Ninguna pregunta que se pueda contestar bien solo por sentido común, o no mide nada.
No pidas datos personales innecesarios: ni edad exacta, ni ingresos, ni nada que no vaya a usar.
Máximo 13 preguntas en total, si te sales, quita.
Español de España, tuteando al alumno.
FORMATO DE SALIDA.
1) Prerrequisitos en dos listas. 2) Los 3 perfiles en tabla. 3) La prueba completa lista para copiar en un formulario, con las opciones y la respuesta correcta marcada. 4) Tabla de corrección. 5) Mensaje de resultados por perfil. 6) Las 3 decisiones sobre el temario.
CRITERIOS DE CALIDAD, revísalos antes de darme la respuesta.
Cada pregunta de la sección B tiene que servir para decidir algo: si la respuesta no cambia lo que hago con ese alumno, sobra.
Los distractores tienen que ser errores que la gente comete de verdad en este tema, no rellenos absurdos.
La prueba se contesta en 7 minutos: cuéntalos y dime tu estimación.
Al final, señala las 2 preguntas más flojas de tu propia prueba y propón una alternativa mejor para cada una.
```
