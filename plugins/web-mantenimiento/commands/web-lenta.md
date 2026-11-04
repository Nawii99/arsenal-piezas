---
description: Analiza el peso y la velocidad de una web estática y entrega un plan de optimización ordenado por impacto
argument-hint: [ruta de la carpeta del proyecto o del HTML]
---

Vas a analizar la velocidad de: $ARGUMENTS

## Paso 1: mide antes de opinar
Con las herramientas del sistema, calcula el peso real de los archivos del proyecto y ordénalos de mayor a menor. Mira especialmente la carpeta de imágenes, las fuentes y los JavaScript.
Suma el peso total de lo que carga la página de inicio. Una landing sencilla debería quedarse por debajo de 1 MB; si pasa de 3 MB, hay un problema gordo y casi siempre son imágenes.
No inventes puntuaciones de PageSpeed: tú analizas los archivos, y le explicas al usuario cómo sacar la puntuación oficial.

## Paso 2: revisa las imágenes, que es donde está el 80% del problema
- Imágenes de más de 300 KB: candidatas claras.
- Imágenes servidas mucho más grandes de como se ven: una foto de 4000 px mostrada a 600 px es peso tirado.
- Formato: PNG usado para fotografías (debería ser JPG o WebP).
- Falta de loading="lazy" en todo lo que está por debajo del primer pantallazo. Ojo: nunca lo pongas en la imagen principal de arriba, la retrasa.
- Falta de width y height en el HTML, que provoca el salto de la página al cargar.

## Paso 3: fuentes, scripts y CSS
- Fuentes de Google cargadas por enlace externo: propón descargarlas y servirlas locales, y cargar solo los grosores que se usan de verdad. Cargar 6 grosores cuando usas 2 es tirar peso.
- font-display: swap para que el texto se vea mientras carga la fuente.
- Librerías enteras cargadas para un detalle: un carrusel entero, jQuery para dos líneas, iconos completos por un icono. Señálalo.
- Scripts en el head sin defer: bloquean el dibujado. Propón defer o moverlos antes de cerrar body.
- CSS sin usar: si el proyecto carga un framework completo para tres clases, dilo.
- Vídeos autoplay de fondo: el mayor asesino de velocidad en móvil.

## Paso 4: plan ordenado
Ordena los arreglos por relación impacto/esfuerzo, del más rentable al menos. Estima el ahorro en KB de cada uno con los números reales que has medido, sin exagerar.
Da el comando exacto para redimensionar y convertir imágenes si el sistema tiene las herramientas, o explica cómo hacerlo con una web de conversión gratuita, paso a paso y sin jerga.

## Formato de respuesta
1. Peso total actual y los 5 archivos más pesados con su tamaño.
2. Tabla: Arreglo / Ahorro estimado / Esfuerzo (bajo, medio, alto) / Riesgo de romper algo.
3. Los cambios de código concretos, en bloques listos para pegar.
4. Instrucciones para las imágenes: qué archivo, a qué anchura, a qué formato.
5. Cómo comprobar: abrir pagespeed.web.dev, pegar la URL, mirar la pestaña de móvil (no la de escritorio) y apuntar la nota antes y después.

Prioriza siempre lo que se puede hacer sin tocar el diseño. Pregunta antes de editar archivos.
