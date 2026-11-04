---
description: Planifica redirecciones 301 y una página 404 útil al reestructurar o mudar una web, según el hosting que se use
argument-hint: [qué cambia: dominio nuevo, URLs nuevas o rediseño]
---

Vas a preparar el plan de redirecciones para: $ARGUMENTS

## Paso 0: datos que necesitas
Pregunta y espera:
1. Lista de direcciones antiguas. Si no la tiene, explícale cómo sacarla: Google Search Console (informe de páginas), el sitemap.xml antiguo, o buscando site:sudominio.com en Google.
2. Lista de direcciones nuevas o el mapa de la web nueva.
3. Dónde está alojada: Netlify, Cloudflare Pages, Vercel, GitHub Pages, o hosting con Apache o Nginx.
4. Si cambia de dominio o solo de rutas.

## Paso 1: emparejar
Construye la tabla de correspondencias antigua a nueva. Reglas del oficio:
- Cada página antigua va a la página nueva más parecida en contenido, no a la portada. Redirigirlo todo a la home es lo que hace todo el mundo y Google lo trata casi como un error.
- Si no hay equivalente y la página no tenía valor, déjala morir con 404 a propósito y anótalo.
- Si el contenido se ha partido en dos páginas, elige la principal.
- Si el contenido se ha fusionado, todas las antiguas van a la nueva.
- Cuidado con las cadenas: si A va a B y B va a C, arregla para que A vaya directo a C.

## Paso 2: el tipo correcto
- 301 permanente: es lo que quieres casi siempre, traslada el valor de posicionamiento.
- 302 temporal: solo para cosas de verdad temporales, como una promoción.
- Nunca uses redirección por JavaScript ni meta refresh para esto: Google las trata peor y el visitante ve un parpadeo.

## Paso 3: el archivo según el hosting
Genera el archivo exacto que toca:
- Netlify y Cloudflare Pages: archivo _redirects en la raíz de publicación, una línea por regla con origen, destino y 301.
- Vercel: bloque redirects en vercel.json.
- Apache: reglas Redirect 301 en .htaccess.
- Nginx: bloques return 301.
- GitHub Pages: no admite redirecciones de servidor; explica la alternativa y sus límites con honestidad.
Añade la regla general si aplica: forzar https y unificar con www o sin www, eligiendo una sola versión.

## Paso 4: la página 404
Escribe el HTML de una página de error que sirva de algo: dice claramente que esa página ya no está, ofrece el buscador o los tres enlaces más útiles del sitio, mantiene el menú y el diseño de la web, y tiene un tono humano y corto. Nada de páginas en blanco con un número.
Indica cómo se activa en cada hosting (normalmente un archivo llamado 404.html en la raíz).

## Paso 5: comprobación
Explícale en pasos:
1. Abrir tres o cuatro direcciones antiguas en el navegador y ver que aterrizan donde toca.
2. Inventarse una dirección que no existe y ver la página 404.
3. En Search Console, enviar el sitemap nuevo y vigilar el informe de cobertura durante dos o tres semanas.
4. No borrar las redirecciones al cabo de un mes: tienen que quedarse al menos un año.

## Formato de respuesta
1. Tabla de correspondencias completa.
2. Lista de páginas que se dejan morir a propósito y por qué.
3. Archivo de redirecciones listo para copiar.
4. HTML de la página 404.
5. Los cuatro pasos de comprobación.

Pregunta antes de crear archivos en el proyecto.
