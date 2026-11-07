---
name: cv-typst
description: Genera un PDF de currículum usando una plantilla Typst con licencia libre a partir de los datos del usuario. Úsalo con /cv-typst seguido del CV pegado o la ruta del archivo con tus datos.
---

## Qué hace

Monta tu CV con Typst, una alternativa a LaTeX mucho más simple. Tú no tocas código: das tus datos, el comando elige plantilla, la rellena y compila el PDF. Cuando cambies un dato, se regenera en segundos.

## Antes de empezar, pregunta

1. Los datos: que pegue su CV actual o dé la ruta del archivo.
2. El estilo: sobrio (banca, administración, consultoría) o con más diseño (marketing, creatividad).
3. Si es la primera vez o ya existe un proyecto de CV en la carpeta (si existe, solo se actualizan datos y se recompila).

## Paso a paso

1. Comprueba si Typst está instalado con `typst --version`. Si no lo está, instálalo (en Linux/Mac suele bastar el gestor de paquetes; explica al usuario lo que vas a ejecutar antes de hacerlo).
2. Elige una plantilla de CV del Typst Universe (typst.app/universe) cuya licencia permita modificarla: MIT o Apache-2.0, que aparece en la ficha de cada plantilla. Si la licencia no está clara, descarta esa plantilla y elige otra.
3. Crea una carpeta `cv/` con dos archivos separados: `datos.typ` (solo los datos del usuario) y `cv.typ` (la plantilla que los usa). Así el usuario solo tocará el de datos.
4. Rellena `datos.typ` con lo que dio el usuario. Lo que falte, déjalo como `[PENDIENTE: teléfono]` y avisa al final.
5. Compila con `typst compile cv.typ cv.pdf` y enseña el resultado. Si hay error, corrígelo tú: el usuario no tiene que leer mensajes de compilación.
6. Itera: pregunta si quiere cambiar orden de secciones, color o tipografía, aplica el cambio y recompila.

## Qué devolver

- `cv.pdf` listo para enviar.
- La ruta de `datos.typ` y una frase explicando que ese es el único archivo que debe editar en el futuro.
- El nombre de la plantilla usada y su licencia, por si quiere cambiarla o publicar su versión.
- La lista de campos `[PENDIENTE]` si quedó alguno.

## Qué NO hacer

- No usar plantillas sin licencia clara o con licencia solo de uso personal sin modificación.
- No inventar datos para rellenar huecos: hueco que falta, `[PENDIENTE]` y aviso.
- No meter foto por defecto: en España es habitual, pero se pregunta antes, no se asume.
- No mezclar datos y diseño en un solo archivo: rompe la gracia de regenerar rápido.
- No prometer que el PDF pasa filtros ATS: para portales con filtro automático, mejor generar además una versión en texto plano si el usuario la pide.
