---
name: hojas-de-calculo-revisables
description: Crea o edita archivos Excel (.xlsx) y CSV con fórmulas que se recalculan, formato claro y gráficos sencillos, siempre sobre una copia. Úsala cuando pidas una hoja de cálculo, una plantilla, un cuadro de ventas o gastos, o arreglar un Excel o CSV desordenado.
---

# Hojas de cálculo revisables

Instalación: guarda este texto en un archivo llamado SKILL.md dentro de la carpeta .claude/skills/hojas-de-calculo-revisables/ de tu proyecto. Claude Code la usa cuando le pides una hoja de cálculo; si quieres forzarla, nómbrala en tu petición.

## Qué hace
- Crea archivos .xlsx y .csv desde cero o a partir de los datos que le des.
- Edita un archivo que ya tengas, pero siempre trabajando sobre una copia.
- Pone fórmulas de verdad, no números pegados, para que la hoja se actualice sola cuando cambies un dato.
- Da formato legible y añade gráficos sencillos solo si ayudan a decidir algo.
- Al terminar te cuenta qué ha comprobado y qué tienes que mirar tú.

## Antes de empezar, pregunta
1. ¿Qué decisión o qué cuenta quieres sacar de esta hoja? Si no está claro, la hoja saldrá confusa.
2. ¿De dónde vienen los datos? Un archivo, texto pegado, una exportación de otra herramienta.
3. ¿Dónde la vas a abrir? Excel, Hojas de cálculo de Google, LibreOffice o el móvil.
4. Si es un CSV, ¿para qué programa? En España Excel espera punto y coma como separador y coma decimal; si no, todo sale en una sola columna.
5. ¿Hay datos personales (nombres, emails, teléfonos, NIF)? Si los hay, se trabaja solo en tu equipo y con las columnas imprescindibles.
6. ¿Hay IVA, retenciones u otros impuestos? Pregunta qué tipo se aplica en cada caso; no lo supongas.

## Paso a paso
1. Mira los datos antes de tocar nada: columnas, filas, celdas vacías, fechas en formatos mezclados, números guardados como texto, duplicados. Cuéntaselo al usuario en cinco líneas como máximo.
2. Haz una copia del archivo con otro nombre (por ejemplo, ventas_v2.xlsx). El original no se toca.
3. Reparte el trabajo en pestañas: Datos (lo que se escribe), Cálculos (las fórmulas) y Resumen (lo que se lee). Si la hoja es muy sencilla, basta una.
4. Pon los supuestos en celdas con etiqueta (por ejemplo, «Tipo de IVA») y haz que las fórmulas apunten a esas celdas. Nunca escribas un 21 dentro de una fórmula.
5. Escribe fórmulas. Dentro del archivo se guardan con nombre en inglés (SUM, IF, VLOOKUP) aunque tu Excel las muestre en español (SUMA, SI, BUSCARV). Lo gestiona Claude; tú no lo notas.
6. Usa ROUND donde haya dinero, a dos decimales, para que lo que ves coincida con lo que se suma.
7. Códigos postales con cero inicial (08001), teléfonos y NIF se guardan como texto, no como número, o se pierde el cero.
8. Da formato: fechas en dd/mm/aaaa, importes con dos decimales y símbolo €, cabecera fija, anchos legibles y pocos colores.
9. Gráficos solo si responden a una pregunta concreta. Título claro, ejes con nombre, sin efectos 3D.
10. Si el entregable es un CSV: separador punto y coma, coma decimal, UTF-8 con BOM para que se vean bien las tildes y la ñ, y sin fórmulas (un CSV solo guarda valores).
11. Recalcula y comprueba. Un archivo creado por código no trae los resultados calculados hasta que un programa de hojas de cálculo lo abre. Si hay LibreOffice en el equipo, pide que lo abra, recalcule y busque errores (#REF!, #DIV/0!, #NAME?, #VALUE!). Contrasta dos o tres totales con una cuenta hecha aparte.
12. Si no se ha podido recalcular, dilo claramente. En el móvil Android algunas vistas previas muestran celdas vacías; abre el archivo con la app de Excel o con Hojas de cálculo de Google.

## Qué devolver
- La ruta del archivo creado o editado.
- Una tabla corta con tres columnas: pestaña, para qué sirve y qué celdas se rellenan a mano.
- Los supuestos usados y en qué celda están.
- Las comprobaciones hechas y su resultado (por ejemplo, «0 errores de fórmula; el total de ventas coincide con la suma hecha aparte»).
- Lo que no se ha podido comprobar.
- Qué debe revisar una persona antes de usar la hoja.

## Qué NO hacer
- No sobrescribas el original.
- No inventes datos para rellenar huecos. Si falta un dato, deja la celda vacía y márcala.
- No pegues el resultado de una fórmula como número fijo sin avisar.
- No uses macros (VBA, archivos .xlsm) ni enlaces a otros archivos salvo petición expresa: abren riesgos de seguridad y no funcionan en el móvil.
- No copies a una celda un texto que empiece por =, +, - o @ si viene de formularios o de terceros: Excel puede ejecutarlo como fórmula. Guárdalo como texto.
- No presentes la contraseña de una hoja como protección de datos. La protección de Excel se salta con facilidad y no vale para datos sensibles.
- No subas datos de clientes a webs externas ni los pegues en servicios que no hayas elegido tú.
- No des por buenos cálculos fiscales. Excel admite 1.048.576 filas por hoja; si hay más datos, parte el archivo o usa una base de datos.

## Cuándo pedir a una persona
- Si la hoja va a servir para impuestos (modelos 303, 130 u otros), para facturar o para calcular nóminas, que la revise tu gestor antes de usarla: tipo de IVA, retenciones, redondeos y periodos.
- Si contiene datos personales, que la persona responsable de protección de datos confirme qué columnas sobran y quién puede abrirla.
- Si vas a tomar una decisión de dinero importante basándote en la hoja, que otra persona rehaga una cuenta a mano.
