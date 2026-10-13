---
name: plan-visibilidad-google-tienda
description: Audita el posicionamiento en buscadores de una tienda online (indexación, estructura, fichas de producto, categorías, velocidad y contenido) y devuelve un plan priorizado con textos de ejemplo. Úsala cuando el usuario quiera que su tienda salga mejor en Google, revise su SEO o escriba fichas y categorías pensando en buscadores.
---
# Plan para que Google encuentre tu tienda
## Qué hace
Primero comprueba que Google puede ver y entender la tienda. Después mira cómo están escritas las categorías y las fichas de producto y propone un plan por prioridades. No toca la web.
Escrita en octubre de 2026. En Google ya salen respuestas generadas por IA que pueden quitar clics, y los asistentes de IA también citan webs. Lo que sigue sirviendo es una web que se pueda rastrear, que cargue rápido y con contenido útil y propio.
## Antes de empezar, pregunta
1. ¿Cuál es la dirección de la tienda y qué plataforma usa (Shopify, WooCommerce, PrestaShop, Wix, otra)?
2. ¿Cuántos productos y categorías hay? ¿En qué idiomas y países vende?
3. ¿Hay Google Search Console y Analytics? Si los hay, pide la exportación (CSV) de consultas y páginas de los últimos 3 meses. Es el mejor dato disponible. Sin él, marca las conclusiones como [A CONFIRMAR].
4. ¿Qué productos dejan más margen? Se trabajan primero.
5. ¿Qué tres competidores te preocupan?
6. ¿Hay tienda física? Entonces mira también la ficha de Google Business Profile.
7. ¿Quién puede tocar la web: tú, un desarrollador o nadie? De eso depende lo que propongas.
8. ¿Se ha cambiado algo hace poco (rediseño, migración, direcciones nuevas)? Si las visitas bajaron en una fecha concreta, anótala.
## Paso a paso
1. Visibilidad básica. Comprueba si está indexada: busca la tienda en Google y mira en Search Console el informe de páginas, el mapa del sitio y las páginas bloqueadas o con «noindex» por error. Comprueba que usa https y una sola versión de la dirección (con o sin www).
2. Estructura. Categorías y subcategorías claras, ninguna ficha a más de 3 clics de la portada y direcciones legibles. Busca filtros y ordenaciones que generen miles de páginas casi iguales, la paginación y las variantes (talla, color) que duplican fichas. En cada caso di si conviene indexar, redirigir o señalar la página principal con la etiqueta «canonical».
3. Fichas de producto. Título y encabezado con el nombre claro del producto, descripción propia (no la del proveedor), fotos con nombre y texto alternativo útiles, precio y stock visibles, opiniones reales y datos estructurados (precio, disponibilidad, valoración) que coincidan con lo que se ve en la página.
4. Categorías. Un texto breve y útil (cómo elegir, medidas, materiales, cuidados) y enlaces a subcategorías y productos relacionados. Sin relleno.
5. Productos agotados o descatalogados. Define qué hacer con cada caso. Si vuelve, conserva la ficha avisando. Si no vuelve y hay uno parecido, redirección 301 al más parecido. Si no hay, la página desaparece.
6. Velocidad y móvil. Mide con PageSpeed Insights la portada, una categoría y una ficha. Apunta qué retrasa la carga (imágenes pesadas, demasiados plugins) y quién puede arreglarlo.
7. Contenido de apoyo. Propón 5 temas que la gente pregunta antes de comprar (guías de compra, comparativas, cuidados), basados en preguntas reales de clientes o en Search Console. Cada contenido debe aportar algo que solo sabes tú.
8. Enlaces y menciones. Solo ideas legítimas: proveedores, prensa local, directorios del sector, colaboraciones. Nada de comprar enlaces.
9. Prioriza con una tabla de impacto y esfuerzo. Máximo 10 tareas, y las 3 de la primera semana bien concretas.
10. Si te piden textos, escribe títulos y descripciones para las categorías principales y 5 fichas de ejemplo, con los datos que dé el dueño. Donde falte un dato real (medida, material), escribe [DATO QUE FALTA] y no lo inventes.
11. Define qué mirar cada mes en Search Console: clics, impresiones, posición media, páginas indexadas y consultas que traen ventas. Avisa de que los cambios tardan semanas o meses y a veces no llegan.
## Qué devolver
Informe en Markdown, en español de España y tuteando, en este orden.
1. Resumen de 5 líneas con lo que está bien, lo que frena y lo primero que hay que hacer.
2. Tabla de hallazgos con las columnas Hallazgo, Dónde, Por qué importa, Arreglo, Quién lo hace y Prioridad.
3. Plan a 30, 60 y 90 días.
4. Textos propuestos, si se pidieron.
5. Lo que no has podido comprobar.
6. Qué medir y cuándo.
7. Qué debe revisar una persona.
## Qué NO hacer
- No prometas posiciones, visitas ni plazos.
- No inventes volúmenes de búsqueda ni dificultad de palabras clave. Sin dato de una herramienta, escribe [A CONFIRMAR].
- No generes cientos de fichas con texto genérico en masa. Google trata el contenido masivo y sin valor como spam y puede penalizarlo.
- No copies descripciones del proveedor ni de la competencia. Es contenido duplicado y puede tener derechos de autor.
- No inventes opiniones ni valoraciones. No marques datos estructurados que no estén visibles en la página.
- No compres enlaces ni uses redes de blogs.
- No cambies direcciones, la plantilla, el robots.txt ni el mapa del sitio sin un plan de redirecciones y una copia de seguridad, hechos por alguien que conozca la web.
- No ocultes texto ni rellenes de palabras clave.
- No pidas contraseñas. Pide acceso de solo lectura a Search Console.
## Qué revisa una persona antes de usar el resultado
- Un técnico revisa cualquier cambio de direcciones, redirecciones, plantillas o plugins. Una migración mal hecha puede hacer perder visitas.
- Tú compruebas que los textos son ciertos (medidas, materiales, plazos) y que las afirmaciones sobre el producto se pueden demostrar.
- Un asesor revisa las opiniones de clientes (deben ser reales), la información legal de la tienda y cualquier afirmación sobre salud o seguridad.
## Dónde guardarla
Guárdala como `.claude/skills/plan-visibilidad-google-tienda/SKILL.md` dentro de la carpeta de tu proyecto, o en `~/.claude/skills/` para usarla en todos. Si prefieres no instalar nada, pega este texto en el chat y di «usa esta skill».
