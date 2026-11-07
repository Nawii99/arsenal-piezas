---
description: Revisa y genera las etiquetas Open Graph, Twitter Card y favicon de una web para que el enlace se vea bien al compartirlo
argument-hint: "[ruta del archivo HTML o URL de la web]"
---

Tu tarea es dejar el enlace de esta web presentable cuando alguien lo comparte: $ARGUMENTS

## Paso 0: reúne lo que falta
Si no te han pasado nada, pregunta la ruta del archivo HTML (o la URL) y espera respuesta. No inventes contenido de la web: léelo.
Si te dan una ruta local, lee el archivo. Si te dan una URL, pide el HTML o el archivo del proyecto; no supongas lo que contiene.

## Paso 1: diagnóstico
Busca dentro de <head> y anota qué hay y qué falta de esta lista:
- <title> (debe existir, 50-60 caracteres, con el nombre del negocio al final).
- <meta name="description"> (140-160 caracteres, dice qué ofreces y a quién).
- og:title, og:description, og:image, og:url, og:type, og:site_name, og:locale.
- twitter:card (summary_large_image), twitter:title, twitter:description, twitter:image.
- <link rel="icon"> y <link rel="apple-touch-icon">.
- <html lang="es"> (si falta, el navegador y Google no saben el idioma).

## Paso 2: errores típicos que tienes que cazar
- og:image con ruta relativa tipo /img/foto.jpg: WhatsApp necesita URL absoluta completa con https://. Es el fallo número uno.
- Imagen demasiado pequeña: mínimo 1200x630 px y menos de 5 MB, formato JPG o PNG (WebP falla en algunos sitios).
- og:url apuntando a otro dominio o a localhost.
- Título duplicado entre <title> y og:title con textos distintos y contradictorios.
- Descripción con comillas dobles sin escapar que rompe la etiqueta.
- Falta de favicon: sale el icono gris del navegador y da sensación de web abandonada.

## Paso 3: propuesta
Escribe el bloque completo de etiquetas listo para pegar dentro de <head>, con los textos ya redactados a partir del contenido real de la página, no con relleno.
Si no conoces el dominio final, pregúntalo antes de escribir las URLs absolutas.
Indica el tamaño exacto que debe tener la imagen de compartir y qué debe aparecer en ella: logo, una frase corta de 5-7 palabras y una imagen del producto o servicio; nada de texto pequeño porque en móvil no se lee.

## Paso 4: cómo comprobar que ha funcionado
Explícale al usuario, en pasos numerados y sin jerga, que tras publicar debe:
1. Abrir developers.facebook.com/tools/debug, pegar la URL y pulsar Scrape Again (WhatsApp y Facebook cachean la vista previa vieja durante días).
2. Abrir linkedin.com/post-inspector y pegar la URL.
3. Enviarse el enlace por WhatsApp a sí mismo desde otro chat para verlo de verdad.

## Formato de respuesta
1. Tabla de dos columnas: Etiqueta / Estado (Correcta, Falta, Mal puesta y por qué).
2. Bloque de código con el <head> corregido completo.
3. Lista de archivos de imagen que tiene que crear, con nombre sugerido y medidas.
4. Los 3 pasos de comprobación.
5. Una frase final diciendo cuál era el problema principal.

No toques nada del <body> ni cambies el diseño. Si el usuario no te ha dado permiso explícito para editar el archivo, muestra el código y pregunta si lo aplicas.
