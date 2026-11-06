---
name: imagenes-rapidas-web-skill
description: Optimises website images end to end: target dimensions per slot, WebP/AVIF conversion, weight budgets, srcset and lazy loading, SEO-friendly file names and alt text. Use when a site loads slowly, before publishing a landing page, or when uploading many photos to a shop or blog.
---

# Imágenes ligeras para web

## Qué hace
Te dice a qué tamaño y peso debe estar cada imagen de tu web, cómo convertirlas y cómo nombrarlas para que además ayuden en Google.

## Cuándo se activa
Web lenta, PageSpeed en rojo, landing nueva, tienda con muchas fotos, blog con imágenes pesadas, o el aviso de "sirve imágenes en formatos de nueva generación".

## Método
### 1. Medidas por hueco (la regla de oro: sube la imagen al tamaño en que se ve, no más)
- Cabecera a ancho completo: 1600-1920 px de ancho.
- Imagen dentro del texto de un blog: 1200 px de ancho.
- Ficha de producto: 1200-1600 px de lado largo (más si hay zoom).
- Miniatura de listado: 400-600 px.
- Logo y avatares: 200-400 px, o SVG si es vectorial.

### 2. Formato
- Fotografía: WebP. AVIF si tu web lo soporta y quieres exprimir más.
- Gráficos planos, capturas con texto, logos: PNG o mejor SVG.
- JPEG solo como respaldo. GIF, nunca: usa vídeo mp4 o WebP animado.

### 3. Presupuesto de peso
- Cabecera: por debajo de 200 KB.
- Imagen de contenido: 80-150 KB.
- Miniatura: menos de 40 KB.
- Página completa: intenta que todas las imágenes juntas no pasen de 1 MB.
Si no llegas, baja calidad al 75-80% antes de bajar resolución: casi nunca se nota.

### 4. Herramientas gratis
Squoosh (navegador, una a una, la que mejor te enseña el antes y después), o la conversión por lotes de tu editor. En WordPress, un plugin de conversión a WebP hace el trabajo, pero comprueba que no te destroce la calidad por defecto.

### 5. Nombres y alt
- Nombre de archivo: palabras separadas por guiones, sin acentos ni ñ, describiendo la imagen: mesa-roble-macizo-comedor.webp. Nada de IMG_4821.
- Alt: describe la imagen para alguien que no la ve, en una frase natural. No metas la palabra clave a la fuerza. Si la imagen es decorativa, alt vacío.
- Title no hace falta. Caption solo si aporta.

### 6. Carga
- Todas las imágenes con width y height declarados: evita que la página "salte" al cargar.
- loading="lazy" en todo salvo la primera imagen visible, que debe cargarse con prioridad.
- srcset para servir la versión pequeña al móvil.

## Qué preguntar si falta información
- ¿Con qué está hecha la web: WordPress, Shopify, HTML propio, un constructor?
- ¿Puedes tocar el código o solo subir por el panel?
- ¿Cuántas imágenes hay que arreglar?
- ¿Tienes ya una medición de velocidad? (pásame el resultado)

## Formato de la respuesta
1. Tabla de huecos: hueco, medida en píxeles, formato, peso máximo.
2. Pasos de conversión concretos para la herramienta que use.
3. Ejemplos de nombres de archivo y de alt, buenos y malos, con sus imágenes reales.
4. Fragmento de HTML de ejemplo con srcset, lazy y dimensiones, listo para copiar si puede tocar código.
5. Checklist de comprobación tras publicar.

## Errores típicos
- Subir la foto de 4000 px tal cual y dejar que el navegador la reduzca: pesa igual.
- Comprimir dos veces el mismo JPEG: aparecen bloques y halos.
- Poner lazy loading a la imagen principal de la portada: empeora la métrica que quieres arreglar.
- Alt copiado y pegado igual en 40 imágenes.
- Renombrar archivos ya publicados sin redirigir: se rompen los enlaces y pierdes las que estaban posicionadas en Google Imágenes.

## Avisos honestos
- Las imágenes suelen ser la mitad del problema de velocidad, pero no todo: fuentes, scripts y plugins también pesan. Mide antes y después.
- Si conviertes a WebP en masa con un plugin, guarda copia de los originales. Algunos plugins sobreescriben.
- No hay un número mágico de peso: lo que importa es cuánto tarda en verse la primera pantalla en un móvil con conexión normal.
