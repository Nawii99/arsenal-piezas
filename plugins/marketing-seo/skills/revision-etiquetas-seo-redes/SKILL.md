---
name: revision-etiquetas-seo-redes
description: Revisa las etiquetas ocultas de una página web (título, descripción, canonical, robots, Open Graph, Twitter Cards y JSON-LD), explica qué falla y propone el arreglo exacto. Úsala cuando una URL salga fea al compartirla en redes o no aparezca en Google como esperas.
---
# Revisión de etiquetas SEO y vistas previas en redes
Las etiquetas son datos ocultos en el código de cada página. Google y las redes las leen para saber qué título, qué texto y qué imagen enseñar. Esta skill las revisa, te dice qué está mal y qué cambiar.

## Instalación (para la persona, no para Claude)
- Guarda este texto como SKILL.md dentro de .claude/skills/revision-etiquetas-seo-redes/ de tu proyecto, o de ~/.claude/skills/revision-etiquetas-seo-redes/ para todos tus proyectos.
- No necesita claves ni cuentas. Claude descarga el código público de cada URL. Te pedirá permiso para ejecutar comandos.
- Si la web está en una carpeta de tu ordenador, ábrela en Claude Code. Si no, basta con pasarle las direcciones.

## Pregunta esto antes de empezar
1. ¿Qué URLs reviso? Máximo [NÚMERO] de una vez. Si hay muchas, empieza por la portada, dos páginas de servicio o producto y un artículo.
2. ¿Con qué está hecha la web? WordPress, Shopify, Wix, Webflow, a mano u otra. De eso depende dónde se arregla cada cosa.
3. ¿Puedes editarla tú o solo verla? ¿Hay una versión de pruebas?
4. ¿Qué problema ves? Imagen cortada, título distinto, Google muestra otro texto. ¿Qué idioma y país son el objetivo? Por ejemplo, es-ES.
5. ¿Hay páginas que NO deban salir en Google a propósito? Gracias, carrito, zona privada.

## Paso a paso
1. Descarga el código original de cada URL (por ejemplo con curl), sin pasar por un navegador. Las redes sociales no ejecutan JavaScript: si una etiqueta se añade después, para ellas no existe.
2. Anota la URL final tras las redirecciones y el código de respuesta (200, 301, 404...). Haz una sola petición por URL, sin ráfagas. Si la web bloquea la descarga, dilo y no lo fuerces.
3. Revisa por bloques:
- Título y descripción: que existan, que no se repitan en otras páginas y que cuenten qué es la página. Orientativo: título de hasta unos 60 caracteres y descripción de hasta unos 155. Google puede reescribirlos.
- Canonical: una sola, con la dirección completa, apuntando a la versión correcta (https, con o sin www, sin parámetros). Que no apunte a otra página por error.
- Robots: busca noindex y nofollow en la etiqueta meta y en la cabecera X-Robots-Tag. Mira /robots.txt y comprueba que no bloquea páginas que sí quieres posicionar. Un noindex olvidado tras una web de pruebas es una causa clásica de «no sale en Google».
- Open Graph: og:title, og:description, og:image, og:url y og:type. La imagen con dirección completa, visible sin iniciar sesión y, como referencia, de 1200 x 630 píxeles.
- Twitter o X Cards: twitter:card (summary_large_image para imagen grande) y el resto. Si faltan, X suele usar los datos de Open Graph.
- JSON-LD: que el JSON sea válido, que el tipo (Organization, LocalBusiness, Product, Article, BreadcrumbList) corresponda a la página y que los datos coincidan con lo que se ve en pantalla: precio, dirección, teléfono, horarios.
- Idioma: atributo lang y, si hay varias versiones, hreflang.
4. Prioriza: Crítico (bloquea la indexación o rompe la vista previa), Importante y Mejora.
5. Propón el arreglo según su sistema: en WordPress, el campo del plugin SEO que use (Yoast, Rank Math u otro); en Shopify, los campos SEO de la página o el producto; en Wix o Webflow, los ajustes SEO de la página; si está hecha a mano, el fragmento de código.
6. Explica cómo comprobar después. Las redes guardan en caché la vista previa vieja, así que hay que refrescarla con el depurador de Facebook para compartir o con el Post Inspector de LinkedIn. Para JSON-LD, la prueba de resultados enriquecidos de Google. Para ver cómo ve Google una URL, Search Console. En X, prueba con un borrador sin publicar.

## Qué devolver
- Resumen de 3 a 5 líneas con lo más grave.
- Una tabla por URL con las columnas Etiqueta, Estado (bien, falta o mal), Valor actual y Propuesta.
- Fragmentos listos para copiar, solo de lo que hay que cambiar.
- Una lista «Después de arreglar, comprueba» con las herramientas anteriores.
- Lo que no has podido revisar: páginas con acceso privado, contenido que solo aparece con JavaScript, URLs que bloquean la descarga.

## Qué NO hacer
- No edites archivos de la web ni plugins sin enseñar antes el cambio y sin copia de seguridad. Un robots o un canonical mal puestos pueden hacer desaparecer páginas de Google.
- No quites un noindex ni cambies robots.txt en una web en producción sin que una persona lo apruebe.
- No inventes valoraciones, estrellas, premios, precios ni reseñas en JSON-LD. Marcar datos falsos o que no se ven en la página puede acabar en una sanción manual de Google y en pérdida de visibilidad.
- No añadas FAQPage ni HowTo esperando resultados enriquecidos: Google los limitó en 2023.
- No prometas posiciones ni tráfico.
- No llenes títulos de palabras clave repetidas, ni copies etiquetas de otra web, ni uses el mismo texto e imagen en todas las páginas.
- No lances un rastreo masivo sobre una web ajena. Para una revisión puntual de páginas públicas basta con descargar cada una.

## Qué revisa una persona antes de usar el resultado
- Quien lleva la web comprueba que nombre, precios y datos de contacto de las etiquetas son los reales y coinciden con el aviso legal.
- Quien lleva la web decide qué páginas deben salir en Google y cuáles no, antes de tocar noindex, canonical o robots.txt.
- Después de publicar los cambios, mira que la página sigue funcionando y que la vista previa se actualiza.
