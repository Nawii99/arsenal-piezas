---
name: cartel-con-texto
description: Creates posters, promo images and banners with readable, correctly spelled text inside the image, using the right generator, typographic hierarchy, contrast and a fallback compositing plan. Use when the user needs an image containing words: sale poster, cover, banner, event sign, shop window or a post with a headline.
---

# Cartel con texto que se lee

## Qué hace
Te da el prompt y la estructura para que la IA escriba bien las palabras, y te dice cuándo NO merece la pena intentarlo y es mejor montar el texto encima.

## Cuándo se activa
Cuando el encargo incluye texto visible dentro de la imagen: precios, nombre del negocio, un titular, un horario, un cartel de "se traspasa".

## Método
### 1. Decide la vía
- Vía A, texto generado: solo si el texto total son 7 palabras o menos y no lleva datos críticos. Usa un generador fuerte en tipografía (Ideogram, Flux, GPT Image). Midjourney sigue fallando con frases largas.
- Vía B, texto compuesto: genera la imagen SIN texto, con espacio libre reservado, y pon las letras encima en Canva, Figma o un HTML. Obligatoria si hay teléfono, precio, dirección, fechas o condiciones legales.

### 2. Jerarquía
Solo dos niveles visibles a distancia: TITULAR (3-5 palabras) y APOYO (una línea). Todo lo demás es letra pequeña y va en la vía B.

### 3. Prompt para la vía A
- Escribe el texto exacto entre comillas: the text "REBAJAS 40%" written in large bold letters.
- Describe la tipografía por familia, no por nombre comercial: grotesca condensada, serif de alto contraste, palo seco redondeada, letras de neón, tiza sobre pizarra.
- Di dónde va: centrado en el tercio superior, sobre la franja lisa de la izquierda.
- Pide zona limpia: clean flat background area behind the text, high contrast.
- Añade formato y proporción (1:1, 4:5, 9:16, A4 vertical).

### 4. Legibilidad, se comprueba así
- Contraste: texto y fondo deben separarse claramente; si dudas, pasa la imagen a blanco y negro y mira si el titular sigue leyéndose.
- Tamaño mínimo: en un cartel, la letra del titular debe medir aproximadamente 1 cm de alto por cada metro de distancia de lectura.
- Nunca texto sobre una zona con mucho detalle o degradado fuerte; pon una franja o una sombra suave detrás.

### 5. Revisión letra a letra
Lee el texto generado de derecha a izquierda para no autocompletar mentalmente. Vigila acentos, la ñ, dobles letras y los números.

## Qué preguntar si falta información
- Texto exacto que debe aparecer, palabra por palabra.
- ¿Impreso o pantalla? Si es impreso: tamaño y a qué distancia se lee.
- ¿Hay logo, teléfono, QR o condiciones legales?
- Fechas y precios: ¿son definitivos?
- Idioma. Si es en español, avisa: los generadores fallan más con acentos.

## Formato de la respuesta
1. Recomendación de vía (A o B) con la razón en una línea.
2. Prompt completo listo para copiar, en inglés, con el texto en español entre comillas.
3. Prompt alternativo del mismo cartel sin texto, para la vía B, indicando dónde queda el hueco.
4. Especificación tipográfica para montar encima: jerarquía, tamaños relativos, color y posición.
5. Checklist de revisión de 6 puntos antes de imprimir o publicar.

## Errores típicos
- Meter el texto largo en el prompt y aceptar lo que salga: aparecen letras inventadas y palabras a medias.
- Poner precio o teléfono generado por IA. Un dígito mal y pierdes llamadas o vendes a pérdida.
- Titular en mayúsculas muy largo: se lee peor que en mayúscula y minúscula.
- Fondo bonito y texto encima sin contraste: en el móvil desaparece.
- Olvidar el sangrado si va a imprenta: deja 3 mm extra por lado y no pongas nada importante a menos de 5 mm del borde.

## Avisos honestos
- Ningún generador escribe español con acentos de forma fiable al 100%. Revisa siempre.
- Si el cartel es de una promoción, en España la publicidad de precios y condiciones tiene requisitos de información; no me invento la letra pequeña, la pones tú.
- Para carteles que vas a usar mucho tiempo, monta el texto por separado: así lo cambias sin volver a generar la imagen.
