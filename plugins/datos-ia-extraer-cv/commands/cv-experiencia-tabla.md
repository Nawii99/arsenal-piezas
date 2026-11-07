---
name: cv-experiencia-tabla
description: Comando que coge el texto de un currículum y convierte solo el bloque de experiencia laboral en una tabla cronológica limpia (empresa, puesto, fechas, duración); se usa cuando hay que rellenar a mano un formulario de un portal de empleo.
---

# /cv-experiencia-tabla

Saca del CV solo la experiencia laboral y la deja en una tabla ordenada por fecha, lista para copiar campo a campo en un formulario de InfoJobs, LinkedIn o similar.

## Antes de empezar, pregunta

- El texto del CV (pégalo entero, el comando busca solo el bloque de experiencia).
- Si quiere las fechas más recientes primero o en orden cronológico ascendente.
- Si necesita la duración en meses o en años y meses.

## Paso a paso

1. Localiza el bloque de experiencia laboral, aunque no tenga un título claro tipo "Experiencia".
2. Para cada puesto extrae: empresa, cargo, fecha de inicio, fecha de fin (o "actualidad"), y duración calculada.
3. Si una fecha solo trae el año, complétala como enero de ese año y avisa de que es una aproximación.
4. Ordena las filas según lo que haya pedido el usuario.
5. Si dos puestos se solapan en fechas, déjalos tal cual pero añade una nota al final avisando del solape.

## Qué devolver

Una tabla Markdown con columnas: Empresa, Puesto, Inicio, Fin, Duración. Debajo, un aviso si hay fechas aproximadas o solapadas.

## Qué NO hacer

- No mezcles formación ni cursos en esta tabla, solo experiencia laboral.
- No corrijas ni completes el nombre de la empresa si no está claro en el CV; cópialo tal cual.
- No calcules antigüedad total salvo que el usuario lo pida aparte.
