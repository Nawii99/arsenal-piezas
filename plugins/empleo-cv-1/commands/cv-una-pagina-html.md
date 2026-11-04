---
name: cv-una-pagina
description: Genera un currículum de una página en un solo archivo HTML listo para imprimir a PDF desde el navegador, a partir de los datos reales del usuario.
---

## Qué hace

Crea un archivo `cv.html` autocontenido (todo el estilo dentro, sin dependencias de internet) con los datos del usuario, pensado para caber en una página A4 y guardarse como PDF desde el navegador.

## Pregunta antes de empezar

1. Pide los datos: nombre, puesto objetivo, ciudad, email, teléfono, experiencia (empresa, puesto, fechas, qué consiguió), formación, herramientas e idiomas. Si el usuario tiene un archivo con sus datos o un CV viejo, léelo en vez de preguntar.
2. Pregunta si quiere enlace a LinkedIn o web propia. Si no lo da, no lo pongas.
3. Pregunta el idioma del CV. Por defecto, español de España.

## Paso a paso

1. Ordena la experiencia de más reciente a más antigua. Reescribe cada punto con verbo de acción y, si el usuario dio cifras, con cifras. Si no las dio, sin cifras.
2. Genera un único `cv.html` con CSS dentro del propio archivo: tipografía del sistema, tamaño A4 con `@page` y `@media print`, márgenes de unos 2 cm, texto negro sobre blanco, un solo acento de color como mucho.
3. Estructura: nombre y puesto arriba, contacto en una línea, luego experiencia, formación y habilidades. Sin foto, sin edad, sin estado civil: en España no hacen falta y pueden jugar en contra.
4. Todo en texto real, nada de texto dentro de imágenes ni columnas raras: así los sistemas de filtrado de candidaturas pueden leerlo.
5. Guarda el archivo y dile al usuario cómo sacar el PDF: abrir `cv.html` con doble clic, Ctrl+P, destino "Guardar como PDF", quitar encabezados y pies de página.
6. Si el contenido no cabe en una página, recorta con el usuario: fuera lo de hace más de [10-15] años o lo que no aporte al puesto. No reduzcas la letra por debajo de 10pt para que quepa.

## Qué devolver

La ruta absoluta del `cv.html` generado, las instrucciones de impresión en tres líneas y la lista de campos que quedaron como [PENDIENTE].

## Qué NO hacer

- No inventes empresas, fechas, títulos ni cifras. Lo que falte, [PENDIENTE] bien visible.
- No cargues fuentes, iconos ni CSS desde internet: el archivo tiene que funcionar sin conexión.
- No metas listas de palabras clave ocultas ni texto blanco sobre blanco: si lo detectan, descartan la candidatura.
- No pases de una página sin que el usuario lo pida.
