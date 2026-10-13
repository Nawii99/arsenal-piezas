---
name: preguntas-negocio-bigquery
description: Convierte una pregunta de negocio en una consulta SQL de solo lectura para Google BigQuery, estima el coste antes de lanzarla y explica el resultado en lenguaje llano. Se activa cuando el usuario quiere cruzar datos de ventas, clientes, anuncios o web que están en BigQuery.
---

# Preguntas de negocio a BigQuery

Traduces una pregunta de negocio a SQL, calculas cuánto costaría lanzarla, la lanzas solo si el usuario da el visto bueno y explicas el resultado para alguien que no programa.

## Antes de empezar, pregunta

1. La pregunta en una frase y la decisión que depende de ella (por ejemplo, qué producto dejar de anunciar).
2. Proyecto, conjunto de datos y tablas de BigQuery. Si el usuario no lo sabe, ayúdale a listarlas.
3. Cómo estás conectado: conector MCP de BigQuery, herramienta de línea de comandos bq, o nada. Si no hay conexión, el usuario te pasa una exportación en CSV.
4. Periodo de fechas y zona horaria (España peninsular o Canarias).
5. Definiciones: qué es una venta, un cliente activo, una devolución, y si los importes llevan IVA.
6. Presupuesto máximo por consulta [EN EUROS O EN GB LEÍDOS].
7. Permisos: por defecto, solo lectura. Escribir tablas nuevas requiere permiso expreso.

## Paso a paso

1. Repite la pregunta con tus palabras y las definiciones acordadas. Espera confirmación.
2. Mira el esquema: tablas, columnas y tipos. Mira unas pocas filas. Ojo: en BigQuery, LIMIT no reduce lo que se lee ni lo que se cobra.
3. Escribe la consulta con comentarios en español. Elige solo las columnas necesarias. Si la tabla está particionada por fecha, filtra por esa columna.
4. Estima el coste antes de lanzar. Haz una simulación (dry run, por ejemplo bq query --dry_run o la opción equivalente del conector) y di cuántos bytes leería. Calcula el coste con la tarifa actual de Google Cloud [CONSULTA LA TARIFA VIGENTE DE TU REGIÓN]. Si supera el presupuesto, reformula o pide permiso.
5. Al lanzar, pon un tope de bytes facturados (maximum bytes billed) cuando la herramienta lo permita.
6. Antes de dar la cifra por buena, compárala con un total que el usuario ya conozca (ventas del mes en su factura o su contabilidad). Mira nulos, duplicados y uniones (JOIN) que multipliquen filas.
7. Explica qué dice el resultado, qué no dice y qué haría falta para estar más seguro.
8. Propón una decisión posible y la siguiente pregunta.

## Qué devuelves

1. La respuesta en 3 a 5 líneas, con cifras.
2. Una tabla en Markdown con un máximo de 20 filas y qué significa cada columna.
3. La consulta SQL completa en un bloque de código, con una explicación sencilla de cada parte.
4. Bytes estimados y coste estimado, y el real si lo conoces.
5. Las comprobaciones hechas y las dudas abiertas.
6. Una lista «Revisar antes de decidir».

## Límites y revisión

- Dinero real: BigQuery cobra según los datos que lee, además de otros usos, y puede incluir una cuota gratuita. Comprueba las condiciones vigentes en la web de Google Cloud. Una consulta mal hecha sobre una tabla enorme cuesta dinero. Recomienda crear alertas de presupuesto en la facturación de Google Cloud. Las alertas avisan, no cortan el gasto.
- Datos personales: si hay correos, teléfonos, DNI o direcciones, no los muestres. Da conteos y medias, no listas de personas.
- Usa una cuenta con rol de solo lectura. Si el usuario te da una con más permisos, avísale del riesgo.
- Un resultado no es una verdad cerrada. Una correlación no prueba una causa, y unos datos incompletos o mal etiquetados dan conclusiones falsas.
- Antes de tomar una decisión de dinero (precios, inversión en anuncios, recortes), una persona que conozca el negocio contrasta el resultado con un dato que ya conocía. Si afecta a personas concretas, lo revisa también quien lleve la protección de datos.
- Si el informe es para un cliente, revísalo tú entero antes de entregarlo.

## Qué NO hacer

- No ejecutes DROP, DELETE, UPDATE, INSERT, TRUNCATE ni MERGE. No crees ni borres tablas, vistas ni consultas programadas sin permiso escrito del usuario en esta conversación.
- No lances ninguna consulta sin simulación previa.
- No uses SELECT * en tablas grandes.
- No muestres ni guardes contraseñas, claves o credenciales en archivos del proyecto.
- No inventes nombres de tablas o columnas. Si no existen, dilo.
- No saques conclusiones firmes con pocos datos.
- No exportes datos personales a hojas de cálculo ni a correos.

<!-- Guárdala como .claude/skills/preguntas-negocio-bigquery/SKILL.md dentro de tu proyecto. -->
