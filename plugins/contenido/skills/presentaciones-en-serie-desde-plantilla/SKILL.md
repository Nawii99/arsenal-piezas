---
name: presentaciones-en-serie-desde-plantilla
description: Genera varias presentaciones de Google Slides a partir de una plantilla y una tabla de datos, una fila por presentación. Úsala cuando pidan propuestas, informes u ofertas repetidas con datos distintos, o rellenar una plantilla de Slides en bloque.
---
# Presentaciones en serie desde una plantilla de Slides

## Para ti, que no programas
- Dónde guardarla: en la carpeta de tu proyecto crea la carpeta .claude/skills/presentaciones-en-serie-desde-plantilla/ y guarda este texto dentro con el nombre SKILL.md. Si la quieres en todos tus proyectos, usa la carpeta .claude/skills de tu usuario.
- Cómo se usa: escribe algo como «Genera una presentación por cada fila de mi tabla con esta plantilla» y contesta a las preguntas.
- Conexión: necesita un conector a Google Drive y Google Slides (un servidor MCP, o una receta de n8n que te monte alguien). Sin conexión no puede crear archivos. En ese caso te devuelve el texto de cada diapositiva ya relleno y lo pegas tú. Dilo desde el principio.

## Qué hace
Coge una plantilla de Google Slides con marcadores del tipo {{CLIENTE}} y una tabla con los datos. Hace una copia de la plantilla por cada fila, sustituye los marcadores, quita las diapositivas que no aplican y devuelve los enlaces. No envía nada a nadie.

## Antes de empezar, pregunta (todo en un mensaje)
1. ¿Cuál es la plantilla? Pide el enlace de Slides.
2. ¿Dónde están los datos? Una hoja de cálculo o una tabla pegada, con una fila por presentación.
3. ¿Qué marcador va con qué columna? Si no lo sabes, lo propones tú y la persona confirma.
4. ¿En qué carpeta de Drive se guardan las copias y cómo se llaman? Propón un nombre del tipo «Propuesta - Cliente - 2026-10».
5. ¿Cuántas presentaciones son? Si son más de [10], se hacen por tandas.
6. ¿Llevan precios, descuentos o datos personales? ¿Quién puede ver esa carpeta?
7. ¿Qué formato de números y fechas? Por defecto, el de España: 1.250,50 € y 31/10/2026.

## Paso a paso
1. Lee la plantilla. Lista los marcadores que encuentres. Busca diapositivas marcadas como OPCIONAL en las notas del orador. Si no hay ninguna, pregunta cuáles se pueden quitar según los datos.
2. Cruza marcadores y columnas en una tabla. Avisa de los marcadores sin dato y de las columnas sin marcador. Para y espera confirmación.
3. Haz una copia de la plantilla. Nunca trabajes sobre el original.
4. Prueba con UNA fila. Genera esa presentación, devuelve el enlace y espera el visto bueno antes de seguir.
5. Genera el resto por tandas de [10]. Si una falla, apúntala y sigue con las demás. Si el conector se queda sin cuota, para y avisa.
6. Al terminar, comprueba cada presentación. No debe quedar ningún «{{» sin sustituir. Los textos no deben salirse de su caja. El nombre debe ser el de su fila. Los importes deben coincidir con la tabla.
7. Si falta un dato, deja visible en la diapositiva el texto [REVISAR: nombre del dato] y apúntalo en los avisos. No lo rellenes tú.

## Qué devolver
- Una tabla en Markdown con estas columnas: Nº | Cliente | Enlace | Estado (Lista, Revisar o Falló) | Avisos.
- Debajo, la lista de cosas que una persona tiene que mirar antes de enviar.
- Si algo no se pudo hacer, dilo claro y explica por qué.

## Qué NO hacer
- No modifiques la plantilla original ni borres presentaciones que ya existan. Las pruebas las borra la persona, no tú.
- No compartas archivos, no cambies permisos y no mandes enlaces por correo ni por chat. Eso lo hace la persona.
- No inventes datos que falten. No calcules precios, descuentos ni IVA por tu cuenta. Copia lo que diga la tabla.
- No mezcles datos de dos clientes. Cada presentación lleva solo los datos de su fila.
- No metas imágenes ni logos sacados de internet sin permiso de uso.
- No generes más de [10] presentaciones seguidas sin que la persona lo confirme.

## Qué revisa una persona antes de enviar
- Abre cada presentación entera, no solo la primera. Mira nombres, cifras, precios, fechas y condiciones.
- Si es una oferta con precios o plazos, quien la firma responde de lo que pone. Esta skill no sustituye esa lectura.
- Si la tabla tiene datos personales de terceros, usa solo los necesarios y guarda las copias en una carpeta con acceso limitado.

Última revisión del texto: octubre de 2026. Los menús de Google cambian. Si algo no coincide, dilo y no adivines.
