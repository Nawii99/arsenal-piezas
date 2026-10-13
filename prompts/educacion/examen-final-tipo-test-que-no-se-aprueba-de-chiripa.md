# Examen final tipo test que no se aprueba de chiripa…

**Tipo:** Prompt · **Área:** Formación · **Licencia:** CC BY 4.0

Construye un examen de opción múltiple con preguntas bien hechas, distractores creíbles y corrección automática, más el criterio de aprobado.

## Qué es y qué hace

Prompt para cualquier chat de IA que construye un examen tipo test serio. Crea la tabla de especificaciones, reparte preguntas por nivel, redacta distractores creíbles y devuelve clave de corrección y criterio de aprobado. Ejemplo: examen de 30 preguntas para un certificado.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Pega el temario y rellena los [corchetes]
3. Revisa las preguntas y cárgalas en tu plataforma o formulario

## Cuándo usarla

Cuando quieras cerrar tu formación con una evaluación seria, dar un certificado o filtrar quién pasa a un nivel avanzado.

## Cómo ganar dinero con ella

Un examen serio permite cobrar por la certificación y la hace defendible ante empresas que pagan la formación de sus empleados.

- Exámenes de certificación para academias…
- Bancos de preguntas con corrección automática para formadores…
- Evaluación final de formaciones bonificadas para empresas…

**Precio orientativo:** 120–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como técnico en evaluación educativa especializado en pruebas objetivas. Conoces las reglas clásicas de construcción de ítems de opción múltiple y detectas al instante las pistas involuntarias que permiten acertar sin saber la materia.

CONTEXTO
Formación: [NOMBRE Y TEMA]
Contenidos que entran en el examen: [PEGA EL TEMARIO O EL ÍNDICE DE MÓDULOS]
Qué debe ser capaz de hacer quien apruebe: [DESCRÍBELO COMO TAREAS PROFESIONALES]
Número de preguntas y tiempo: [POR EJEMPLO: 30 preguntas en 40 minutos]
Se hace en: [PLATAFORMA, FORMULARIO, PAPEL]
Consecuencia de aprobar: [CERTIFICADO, ACCESO A NIVEL 2, NADA]

QUÉ TIENES QUE HACER
1. Construye primero la tabla de especificaciones: reparte las preguntas entre los contenidos según su peso real en la práctica profesional, no según cuántas páginas ocupan. Justifica el reparto.
2. Dentro de cada contenido, reparte las preguntas por nivel: recordar, comprender y aplicar. Al menos la mitad deben ser de aplicar, con un caso o situación en el enunciado.
3. Escribe cada pregunta con enunciado completo y cuatro opciones. El enunciado debe plantear el problema entero, de forma que se pueda entender sin leer las opciones.
4. Los tres distractores tienen que ser errores que la gente comete de verdad en tu materia. Para cada distractor, escribe entre paréntesis el error de razonamiento que representa. Si no sabes qué error representa, la opción está mal hecha y hay que sustituirla.
5. Cumple estas reglas y márcalo al final: todas las opciones de longitud parecida, sin ninguna de las anteriores ni todas las anteriores, sin negaciones dobles, sin siempre ni nunca en los distractores, y la respuesta correcta repartida por igual entre las cuatro posiciones.
6. Marca 5 preguntas como Ancla: las imprescindibles. Quien falle esas no aprueba aunque llegue a la nota.
7. Fija la nota de corte y explica el razonamiento del corte en función de lo que está en juego, no con un 5 automático. Indica si penalizas el error y por qué.
8. Escribe la hoja de respuestas con la letra correcta y una explicación de dos líneas por pregunta, útil como material de repaso.
9. Redacta las instrucciones que lee el alumno antes de empezar y el mensaje de resultado para aprobado y para suspenso, este último con qué repasar según qué preguntas falló.

RESTRICCIONES
Español de España, tuteo en las instrucciones, neutro en los enunciados.
Nada de preguntas trampa ni de detalles memorísticos irrelevantes para el trabajo real.
Cada pregunta se responde en menos de un minuto.

FORMATO DE RESPUESTA
Tabla de especificaciones.
Las preguntas numeradas con sus opciones.
Anexo del corrector con respuesta, error que representa cada distractor y explicación.
Apartado de nota de corte y preguntas ancla.
Instrucciones y mensajes de resultado.
Lista de comprobación final donde tú mismo verificas las reglas del punto 5 y avisas de las preguntas que las incumplen.

CRITERIOS DE CALIDAD
El examen está bien si alguien que no ha hecho el curso saca alrededor de un 25 por ciento, que es lo que da el azar.
Está mal si una persona lista sin conocimientos puede acertar leyendo solo las opciones.
Después de escribirlo, léelo como si fueras un alumno espabilado buscando pistas, y dime en qué preguntas encontrarías el truco.
```
