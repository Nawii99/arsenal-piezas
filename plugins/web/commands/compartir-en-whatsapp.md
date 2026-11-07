---
description: Configura las etiquetas de vista previa (Open Graph, Twitter Card, favicon) para que tu enlace se vea bien al compartirlo
argument-hint: "[ruta de la web y URL pública]"
---

Eres quien deja el enlace de una web presentable cuando se comparte. Este detalle lo ignora casi todo el mundo y se nota mucho en las visitas.

Datos del usuario: $ARGUMENTS

PASO 1. Abre los HTML del proyecto y mira qué hay ya en el <head>. Anota qué falta de esta lista:
- <title> propio de cada página, de 45 a 60 caracteres.
- meta description de 120 a 155 caracteres.
- og:title, og:description, og:image, og:url, og:type, og:locale (es_ES), og:site_name.
- twitter:card con valor summary_large_image, y twitter:title, twitter:description, twitter:image.
- favicon en varios tamaños y apple-touch-icon de 180x180.
- theme-color.
- canonical con la URL definitiva.

PASO 2. Pregunta lo mínimo, en una tanda:
1. URL pública definitiva de la web (con https y sin barra final).
2. Nombre de la marca tal cual quiere que aparezca.
3. ¿Tiene ya una imagen que quiera usar de portada? Si no, se la vas a especificar.

PASO 3. Reglas que tienes que aplicar sí o sí, porque son los fallos típicos:
- og:image tiene que ser una URL ABSOLUTA y completa (https://dominio.com/imagen.jpg). Con una ruta relativa WhatsApp no la coge. Este es el fallo número uno.
- Tamaño de la imagen: 1200 x 630 píxeles, menos de 300 KB, en JPG o PNG. WhatsApp corta a cuadrado en algunos sitios: no pongas texto pegado a los bordes.
- El texto de la imagen tiene que leerse en un recuadro pequeño: pocas palabras y grandes.
- Cada página con su propio título y su propia descripción. Copiar el mismo en todas es tirar visitas.
- Comprueba que la imagen existe de verdad en la ruta indicada.

PASO 4. Escribe el bloque de <head> completo para cada página del sitio, ya relleno con los datos reales, y aplícalo a los archivos. No dejes marcadores sin sustituir salvo que falte un dato, y si falta, señálalo claramente.

PASO 5. Si no tiene imagen de portada, dale la especificación exacta para generarla o hacerla: medidas, qué debe aparecer (logo, una frase de 4 a 7 palabras, fondo con contraste alto), y un prompt de imagen listo para usar si la va a generar con IA.

PASO 6. Responde con este formato exacto:

## Cómo se ve ahora
Una o dos frases sobre lo que aparecería hoy al compartir el enlace.

## Lo que he puesto
El bloque de head aplicado, resumido en lista, y en qué archivos.

## La imagen de portada
Medidas, peso máximo, qué debe verse y dónde guardarla. Si hace falta generarla, el prompt.

## Compruébalo así
Pasos numerados: 1) sube los cambios, 2) abre el validador de Facebook (developers.facebook.com/tools/debug) y pulsa Scrape Again, 3) abre el de LinkedIn (linkedin.com/post-inspector), 4) mándate el enlace a ti mismo por WhatsApp desde otro número o a un grupo tuyo.
Explica que WhatsApp y Facebook guardan la vista previa en caché: si ya compartiste el enlace antes, hay que forzar el refresco con el validador o el cambio no se verá.

## Truco
Un solo consejo: añadir ?v=2 al final del enlace para forzar una vista previa nueva cuando la caché no suelta.

REGLAS:
- No toques el diseño de la web, solo el head.
- No inventes la URL pública: si no la sabes, pregúntala.
- Nada de listas de 30 metaetiquetas inútiles: solo las que se usan de verdad.
