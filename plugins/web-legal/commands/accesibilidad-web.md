---
description: Audita la accesibilidad de una página web (contraste, alternativas de texto, teclado, semántica y formularios) y entrega los arreglos
argument-hint: [ruta del HTML o carpeta del proyecto]
---

Vas a auditar la accesibilidad de: $ARGUMENTS

Lee el HTML y el CSS antes de decir nada. No des un veredicto genérico: cada hallazgo debe apuntar a un archivo y una línea.

## Paso 1: estructura y semántica
- Un solo <h1> por página y jerarquía de encabezados sin saltos (no pasar de h2 a h4).
- Uso de <header>, <nav>, <main>, <footer> en vez de <div> para todo. Sin <main>, quien usa lector de pantalla no puede saltar al contenido.
- <html lang="es"> presente.
- Botones que son <div> con onclick: no se pueden pulsar con teclado. Cámbialos por <button>.
- Enlaces que son botones y botones que son enlaces: si navega, es <a>; si ejecuta algo, es <button>.

## Paso 2: imágenes y contenido no textual
- Todo <img> con alt. Si es decorativa, alt="" vacío, no ausente.
- Alt que describe la función, no el archivo: nada de alt="imagen1".
- Iconos que van solos en un botón: necesitan aria-label.
- Vídeos: menciona que necesitan subtítulos y no deben reproducirse con sonido automático.

## Paso 3: color y contraste
Calcula el contraste de las combinaciones texto-fondo que encuentres en el CSS. Umbrales: 4.5:1 para texto normal y 3:1 para texto grande a partir de 24px o 19px en negrita.
Señala especialmente: texto gris claro sobre blanco, texto blanco sobre amarillo o naranja, texto sobre imagen sin capa oscura, y el estado deshabilitado de los botones.
Comprueba también que la información no dependa solo del color: un error de formulario en rojo sin texto no lo ve quien no distingue el rojo.

## Paso 4: teclado y foco
- ¿Se puede llegar a todos los elementos con el tabulador y en un orden lógico?
- ¿Hay outline: none sin sustituto? Quitar el foco visible deja a la persona perdida. Propón un :focus-visible claro.
- Menús desplegables y ventanas modales que atrapan el foco o no se cierran con Escape.
- Enlace de salto al contenido al principio de la página.

## Paso 5: formularios
- Cada campo con <label> asociado, no solo placeholder. El placeholder desaparece al escribir.
- Errores explicados con texto, junto al campo, no solo con un borde rojo.
- Campos agrupados con <fieldset> y <legend> cuando son opciones relacionadas.

## Formato de respuesta
1. Veredicto en una frase y número de problemas por gravedad.
2. Tabla: Problema / Archivo y línea / A quién afecta / Gravedad (bloqueante, seria, menor).
3. Los arreglos de código, en bloques listos para pegar.
4. Combinaciones de color problemáticas con el ratio actual y una alternativa concreta en hexadecimal.
5. Prueba manual final en tres pasos: recorrer la página entera solo con el tabulador, aumentar el zoom del navegador al 200% y ver si todo se sigue leyendo, y quitar el ratón durante un minuto.

No cambies el diseño más de lo necesario. Pregunta antes de editar.
