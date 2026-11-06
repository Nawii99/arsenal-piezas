---
name: optimizar-imagenes-web-skill
description: Resizes, converts and compresses images for the web and writes the correct responsive HTML. Use when a site or online shop loads slowly, when PageSpeed flags images, or when the user does not know what size, format or quality to export.
---

# Imágenes ligeras para tu web

## Qué hace
Toma las fotos que tienes y las deja en el tamaño, formato y peso correctos para una web, y te da el HTML exacto para insertarlas sin que la página dé saltos ni tarde en cargar.

## Cuándo se activa
Cuando el usuario menciona web lenta, PageSpeed, Lighthouse, LCP, peso de las imágenes, WebP, AVIF, o va a publicar una landing, un catálogo o un portfolio con fotos.

## Pesos y tamaños de referencia
- Imagen grande de cabecera: 1920 px de ancho, por debajo de 200 KB.
- Foto de producto en ficha: 1200-1600 px de lado, por debajo de 150 KB.
- Foto dentro de un artículo: 1200 px de ancho, por debajo de 120 KB.
- Miniatura de listado: 400-600 px, por debajo de 40 KB.
- Logo o icono: SVG si es vectorial; si no, PNG pequeño.
- Regla práctica: exporta al doble del tamaño en que se ve en pantalla, nunca más. Subir un JPEG de 6000 px para un hueco de 600 px es el error número uno.

## Formatos
- AVIF: el más ligero, ideal para fotos. Compatible con navegadores actuales.
- WebP: casi igual de bueno y con soporte total desde hace años. Es la apuesta segura.
- JPEG: fallback universal, calidad 75-82. Por encima de 85 solo añades peso.
- PNG: solo si necesitas transparencia real. Para fotos, nunca.
- SVG: logos, iconos y formas planas. Pesa nada y escala infinito.

## Método paso a paso
1. Haz inventario: `ls -lhS carpeta/` para ver cuáles son las más pesadas. Casi siempre tres o cuatro archivos son el 80% del problema.
2. Redimensiona antes de comprimir. Comprimir una imagen enorme no arregla nada.
3. Convierte por lotes con ImageMagick: `magick mogrify -path salida/ -resize 1600x1600\> -strip -colorspace sRGB -quality 80 -format webp *.jpg`. El `\>` evita agrandar las que ya son pequeñas.
4. `-strip` quita metadatos, incluida la geolocalización de las fotos del móvil. Importante si son fotos de tu casa o tu local.
5. Genera las variantes para srcset: 400, 800, 1200 y 1600 px de ancho.
6. Inserta el HTML con anchura y altura declaradas para que no baile el diseño: `<img src="foto-1200.webp" srcset="foto-400.webp 400w, foto-800.webp 800w, foto-1200.webp 1200w" sizes="(max-width: 700px) 100vw, 700px" width="1200" height="800" alt="descripción real" loading="lazy" decoding="async">`.
7. La primera imagen visible (la de cabecera) NO lleva `loading="lazy"`; llévale `fetchpriority="high"`. Es justo la contraria del resto.
8. Mide después: PageSpeed Insights o Lighthouse en el navegador. Objetivo razonable: LCP por debajo de 2,5 s en móvil.

## Qué preguntar si falta información
- ¿Dónde está montada la web: HTML propio, WordPress, Shopify, Wix? En Shopify y Wix la plataforma ya redimensiona y solo hay que subir un original razonable.
- ¿Cuántas imágenes son y de qué tamaño salen de la cámara o el móvil?
- ¿Hay fotos con transparencia o solo fotografías normales?
- ¿Tienes acceso a la terminal o prefieres una herramienta web tipo Squoosh?

## Formato exacto de la respuesta
1. Tabla corta: archivo, peso actual, peso objetivo, tamaño de salida y formato.
2. Los comandos exactos, listos para pegar, con la carpeta de salida separada de la de originales.
3. El bloque HTML de ejemplo ya rellenado con sus nombres de archivo.
4. Qué medir después y qué número mirar.

## Errores típicos
- Sobrescribir los originales. Trabaja siempre en una carpeta `optimizadas/` aparte.
- Convertir a WebP y dejar el `src` apuntando al JPEG viejo: no cambia nada.
- Olvidar `width` y `height`: la página da saltos al cargar y Google lo penaliza.
- Poner `loading="lazy"` también en la imagen de cabecera y empeorar el LCP.
- Comprimir a calidad 50 y llenar de manchas los degradados y los cielos.
- Subir capturas de pantalla en PNG de 3 MB cuando un WebP de 80 KB se ve igual.

## Avisos honestos
- Si la web es lenta por scripts, fuentes o un tema pesado, optimizar imágenes ayuda pero no lo arregla todo. Mide primero.
- AVIF comprime mejor pero tarda más en generarse y algunos gestores antiguos no lo aceptan; con WebP vas sobrado.
- Guarda siempre los originales en una carpeta aparte o en la nube: de una imagen comprimida no se vuelve atrás.
