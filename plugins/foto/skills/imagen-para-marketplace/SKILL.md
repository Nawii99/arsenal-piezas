---
name: imagen-para-marketplace
description: Prepares and audits product images against marketplace image rules (main image, background, framing, text, size, format, file naming) for Amazon, Google Shopping, Etsy, Wallapop and similar. Use when the user is about to upload products to a marketplace or shopping feed, or when their images were rejected or disapproved.
---

# Imágenes que el marketplace acepta

## Qué hace
Revisa tus imágenes contra las reglas del sitio donde vas a vender y te dice qué corregir, en qué orden y con qué medidas.

## Cuándo se activa
Antes de una subida masiva, cuando hay rechazos o desaprobaciones de anuncios, o cuando el usuario pregunta "qué fotos pide Amazon".

## Método
### 1. Identifica destino y tipo de imagen
Pregunta plataforma y separa siempre imagen PRINCIPAL de imágenes SECUNDARIAS: las reglas son muy distintas. La principal es la restrictiva; en las secundarias suele permitirse contexto, texto e infografía.

### 2. Reglas que se repiten en casi todos (compruébalas siempre en la ayuda oficial vigente)
- Imagen principal con fondo blanco puro (RGB 255,255,255) y solo el producto que vendes.
- El producto ocupa alrededor del 85% del marco, centrado, sin recortarse por los bordes.
- Sin texto, logos de tienda, marcas de agua, sellos de "oferta", flechas, bordes ni collages en la principal.
- Sin accesorios ni props que no incluya la compra.
- Lado largo mínimo 1000 px para que funcione el zoom; 1600 px o más es lo cómodo.
- Formato JPEG o PNG, RGB (nunca CMYK), sin transparencia si piden fondo blanco.
- Foto enfocada, iluminada, sin píxeles quemados en el producto.

### 3. Reglas específicas a verificar
- Google Shopping: nada de texto promocional ni marcas de agua sobre la imagen, ni imágenes de relleno o "foto no disponible"; el borde y el marco desaprueban el producto.
- Segunda mano (Wallapop, Vinted, Milanuncios): la primera foto debe ser del artículo real, no del catálogo del fabricante, y se penaliza la foto de stock.
- Etsy y artesanía: la primera imagen manda en la búsqueda; suele funcionar mejor un plano con escala clara que un fondo blanco vacío.

### 4. Auditoría imagen a imagen
Para cada foto anota: medida en píxeles, peso, fondo, ocupación del producto, si tiene texto, si tiene sombra pegada al borde. Marca APTA, CORREGIBLE o REPETIR.

### 5. Corrección
- Fondo no blanco del todo: recorta el producto y colócalo sobre lienzo blanco puro. No uses la herramienta de "niveles" a lo bruto: te come el borde del producto.
- Producto pequeño en el marco: recorta y reencuadra dejando un 5-8% de aire.
- Producto que no llega a 1000 px tras recortar: hay que repetir la foto. Ampliar por software se nota y se rechaza.
- Sombra: permitida si es natural y no toca los bordes. Si dudas, sin sombra.

## Qué preguntar si falta información
- ¿En qué plataforma exactamente y en qué categoría?
- ¿Es producto nuevo de marca propia, revendido o de segunda mano?
- ¿Te han rechazado ya? Pide el mensaje exacto del rechazo, ahí está la causa.
- ¿Cuántas imágenes por producto y cuántos productos?

## Formato de la respuesta
1. Tabla de requisitos de la plataforma indicada, columna "principal" y columna "secundarias".
2. Tabla de auditoría con una fila por imagen y veredicto.
3. Lista de correcciones ordenadas por impacto.
4. Plan de imágenes recomendado (qué debe mostrar cada una de las 6-7 fotos y en qué orden).
5. Nomenclatura de archivos sugerida: sku-producto-01-principal.jpg.

## Errores típicos
- Marca de agua propia "para que no me la copien": es motivo de rechazo y no protege de nada.
- Subir la misma foto en todos los huecos.
- Fondo blanco "casi": 250,250,248 se ve gris junto al fondo de la web.
- Guardar en CMYK desde un programa de diseño: los colores salen apagados o directamente falla la subida.
- Imagen principal con la caja o el packaging cuando lo que vendes es lo de dentro.

## Avisos honestos
- Las políticas cambian cada pocos meses. Yo te doy el marco estable; confirma la medida y el requisito exacto en la ayuda oficial antes de una subida grande.
- Las imágenes generadas con IA que no representen fielmente el producto real pueden considerarse publicidad engañosa y provocan devoluciones y bloqueos de cuenta.
- Si vendes en varios sitios, prepara la imagen para el más estricto y reutilízala en el resto.
