# Rúbrica y juez para medir si la IA lo hace bien…

**Tipo:** Prompt · **Área:** Datos e IA · **Licencia:** CC BY 4.0

Crea un banco de 20 casos de prueba y una rúbrica puntuable para comprobar objetivamente si tu asistente responde bien, y un prompt de juez para valorarlo.

## Qué es y qué hace

Prompt que crea un banco de 20 casos de prueba, una rúbrica y un prompt de juez. Entran la tarea del asistente y qué es una respuesta perfecta o inaceptable; sale una rúbrica con escala 0-2 por criterio y el prompt para puntuar respuestas. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Rellena los [corchetes] con tu asistente
3. Pasa los 20 casos y puntúa con el juez
4. Compara versiones con los números

## Cuándo usarla

Úsalo cuando tengas que decidir entre dos versiones de un prompt o de un bot, o justificarle a un cliente que su asistente funciona.

## Cómo ganar dinero con ella

Deja de discutir por sensaciones: puedes demostrar mejoras a un cliente con números, que es lo que permite cobrar el mantenimiento mensual.

- Informes de evaluación de asistentes con puntuaciones para clientes…
- Justificación con datos de mejoras en mantenimiento mensual…
- Rúbricas de calidad para bots de atención…

**Precio orientativo:** 150–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como evaluador de sistemas de IA. Diseñas pruebas medibles para que dejar de opinar y empezar a puntuar.

QUÉ VOY A EVALUAR
Tarea del asistente: [REDACTAR CORREOS / RESPONDER DUDAS / RESUMIR / CLASIFICAR / OTRA]
Prompt o instrucciones actuales: [PEGA AQUÍ]
Qué es para mí una respuesta perfecta: [DESCRÍBELO]
Qué es para mí una respuesta inaceptable: [DESCRÍBELO]
Público final de la respuesta: [CLIENTE, YO, PROVEEDOR...]
Ejemplos reales de entrada, si los tengo: [PEGA 2 O 3 O ESCRIBE 'NINGUNO']

QUÉ TIENES QUE HACER
1. Convierte mi idea de respuesta perfecta en 5 o 6 criterios independientes y observables. Nada de calidad general: cosas como respeta el formato, no inventa datos, responde a lo preguntado, tono correcto, longitud, acción clara al final.
2. Para cada criterio, escribe la escala de 0 a 2 con la descripción exacta de qué es un 0, un 1 y un 2. Que dos personas distintas puntúen igual.
3. Pondera los criterios según lo que importa en mi negocio y explica el porqué de cada peso.
4. Construye el banco de 20 casos de prueba: 12 normales del día a día, 5 casos límite y 3 casos trampa donde la respuesta correcta es reconocer que no se puede responder.
5. Fija la nota de corte: a partir de qué puntuación considero que el asistente sirve para clientes reales.
6. Escribe un prompt de juez, listo para copiar, que evalúe una respuesta contra la rúbrica y devuelva puntuación por criterio, total y el motivo en una línea por criterio.
7. Añade la advertencia de qué NO detecta este método y en qué casos tengo que mirar yo con mis ojos.

RESTRICCIONES
Nada de criterios subjetivos sin descripción de niveles.
Los casos trampa tienen que ser realistas, no absurdos.
No mezcles dos cosas en un mismo criterio.

FORMATO DE SALIDA
Tabla RÚBRICA: Criterio | Qué es 0 | Qué es 1 | Qué es 2 | Peso.
Tabla CASOS: Nº | Tipo | Entrada de prueba | Qué debe aparecer en la respuesta | Qué la haría fallar.
Sección NOTA DE CORTE con el número y el razonamiento.
Sección PROMPT DE JUEZ: bloque de texto plano copiable, con hueco para pegar la respuesta a evaluar.
Sección HOJA DE RESULTADOS: las columnas exactas que debo poner en una hoja de cálculo para ir apuntando.
Sección LÍMITES DEL MÉTODO: máximo 5 líneas.

CRITERIOS DE CALIDAD
Los criterios no se solapan entre sí.
Cualquier persona podría puntuar el mismo caso y dar la misma nota.
El prompt de juez pide justificación breve y prohíbe inventarse criterios nuevos.
Los casos trampa comprueban de verdad que el asistente sabe decir que no lo sabe.
```
