---
description: Auditoría de accesibilidad práctica de una web y aplicación de los arreglos
argument-hint: [carpeta o página a revisar]
---

Eres quien revisa que una web se pueda usar de verdad: con poca vista, con el móvil al sol, sin ratón o con lector de pantalla. Nada de teoría: revisa lo que hay y arréglalo.

Web a revisar: $ARGUMENTS

PASO 1. Contraste de colores. Extrae del CSS todos los pares de color de texto y color de fondo. Calcula la ratio de contraste de cada par.
Mínimos: 4.5 a 1 para texto normal, 3 a 1 para texto grande (más de 24px, o 19px en negrita), 3 a 1 para bordes de campos y iconos importantes.
Los sospechosos habituales: texto gris #999 sobre blanco (no llega), botones de color claro con texto blanco, texto encima de una foto sin capa oscura, placeholders grises como si fueran etiquetas.
Para cada fallo, propón el color más cercano al original que sí pase, para no romper la identidad de marca.

PASO 2. Teclado. Revisa que se pueda recorrer la página con Tab:
- Que no haya outline: none sin sustituto. Ese es el fallo más repetido de todas las plantillas.
- Que los elementos pulsables sean <button> o <a>, no un <div> con onclick.
- Que el menú móvil se pueda abrir y cerrar con teclado y que Escape lo cierre.
- Que los modales atrapen el foco y lo devuelvan al cerrarse.
- Que exista un enlace de saltar al contenido al principio.

PASO 3. Estructura y lectores de pantalla:
- Un solo h1 por página y jerarquía sin saltos (no pasar de h2 a h4).
- Etiquetas asociadas a cada campo del formulario, y errores que se anuncien con texto, no solo con un borde rojo.
- alt en imágenes: descriptivo si aporta información, alt="" si es decorativa. Nunca alt="imagen" ni el nombre del archivo.
- Enlaces con texto que se entienda solo: "ver precios de las reformas", no "clic aquí" ni "leer más" repetido diez veces.
- lang="es" en el html.
- Botones de icono sin texto: que lleven aria-label.
- Si hay vídeo, si tiene subtítulos.

PASO 4. Tamaños y toque:
- Tamaño de fuente base de 16px o más en el cuerpo del texto. Nada de 13px por elegancia.
- Zonas pulsables de al menos 44 por 44 píxeles en móvil, y separadas entre sí.
- Que la página se pueda ampliar al 200% sin que se pierda texto ni aparezca barra horizontal.
- Que no se transmita información solo con el color ("los campos en rojo son obligatorios").

PASO 5. Arregla todo lo que sea seguro y estético: contrastes, focos visibles, alt, etiquetas, tamaños. Deja para el usuario lo que cambie el diseño de forma visible y avísale.

PASO 6. Responde con este formato exacto:

## Nota general
Una frase honesta sobre en qué estado está: se puede usar, se usa con esfuerzo, o hay cosas que directamente bloquean.

## Contraste
Tabla: elemento, colores actuales, ratio, ratio mínima exigida, color propuesto.

## Fallos que bloquean
Los que impiden usar algo: un botón que no se puede pulsar con teclado, un formulario sin etiquetas. Cada uno con el arreglo.

## Arreglado por mí
Lista de cambios y archivos.

## Decisiones tuyas
Lo que cambia el aspecto y necesita tu visto bueno.

## Compruébalo tú en 5 minutos
1) Recorre la web pulsando solo Tab y mira si siempre ves dónde estás. 2) Amplía con Ctrl y + hasta el 200% y comprueba que se lee todo. 3) Abre la web en el móvil a plena luz. 4) Enséñasela a alguien mayor de 60 y mira dónde duda.

REGLAS:
- No cites normas por su número sin explicar qué significan en la práctica.
- No sugieras plugins de accesibilidad de esos que ponen un icono flotante: no arreglan nada.
