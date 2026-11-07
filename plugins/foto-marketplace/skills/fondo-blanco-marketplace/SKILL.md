---
name: fondo-blanco-marketplace
description: Produce imágenes de producto que cumplen las normas de los marketplaces, con fondo blanco puro o transparente, encuadre y resolución correctos. Úsala cuando el usuario suba productos a Amazon, eBay, Wallapop, Etsy o Shopify, cuando le hayan rechazado imágenes de anuncios, o cuando necesite recortar fondos de fotos hechas con el móvil.
---

# Fondo limpio para marketplaces

## Qué hace
Convierte fotos de producto normales en imágenes que cumplen las reglas de cada marketplace: fondo blanco puro o transparente, producto bien encuadrado, resolución suficiente para el zoom y sin elementos prohibidos. Te da los pasos concretos, los comandos y la forma de comprobar que ha quedado bien.

## Cuándo se activa
Cuando el usuario habla de recortar fondos, quitar el fondo, fondo blanco, imágenes rechazadas, ficha de producto en Amazon/eBay/Etsy/Wallapop/Shopify, o de preparar fotos para subirlas a una tienda.

## Las reglas reales (memorízalas, son la mitad del trabajo)
- Amazon, imagen principal: fondo blanco puro RGB 255,255,255. Un blanco «casi blanco» tipo #F6F6F6 se ve gris al lado del fondo de la página y es motivo de rechazo.
- Amazon: el producto debe ocupar el 85% o más del encuadre, sin texto, logotipos, marcas de agua, bordes, ni accesorios que no se vendan.
- Amazon: lado largo mínimo 1000 px para que funcione el zoom; lo recomendable es 1600-2000 px. Perfil de color sRGB, JPEG o PNG.
- Imágenes secundarias de Amazon: ahí sí puedes usar ambiente, detalle, escala y texto. La restricción dura es solo la principal.
- eBay y Wallapop: lado largo recomendado 1600 px, sin bordes, sin texto añadido, sin marcos decorativos.
- Etsy: primera imagen horizontal o cuadrada, se recorta a 4:5 en móvil, así que no pegues el producto al borde.
- Shopify y web propia: cuadrado 2048x2048 o 1600x1600, todas las fotos del catálogo con el mismo formato y el producto al mismo tamaño relativo.

## Método paso a paso
1. Revisa el original antes de tocar nada: si está movido, quemado o por debajo de 1000 px de lado largo, recortar el fondo no lo salva. Dilo y propon repetir la foto.
2. Recorta el fondo con una herramienta gratuita: rembg en tu ordenador (`rembg i entrada.jpg salida.png`), Photopea (selección de objeto + refinar borde) o remove.bg en su plan gratuito.
3. Revisa el recorte a tamaño 100%, no en miniatura. Los fallos aparecen en pelo, asas, transparencias, cristal y objetos oscuros sobre fondo oscuro.
4. Pon el PNG recortado sobre un fondo gris medio temporal para cazar halos blancos y restos del fondo antiguo. Lo que no se ve sobre blanco sí se ve sobre gris.
5. Añade una sombra de contacto suave debajo del producto. Sin ella el objeto parece flotar y la ficha se ve amateur. Una elipse difuminada al 15-25% de opacidad basta.
6. Monta el resultado sobre lienzo blanco cuadrado con margen: `magick recorte.png -background white -alpha remove -alpha off -resize 1700x1700 -gravity center -extent 2000x2000 -colorspace sRGB -quality 90 final.jpg`.
7. Comprueba el blanco con el cuentagotas en las cuatro esquinas: tiene que dar 255,255,255 exacto.
8. Nombra los archivos con orden: `marca-producto-01-principal.jpg`, `-02-detalle.jpg`, `-03-escala.jpg`. Te ahorra media hora al subir.

## Qué preguntar si falta información
- ¿A qué plataforma va y cuál es la imagen principal? Las normas cambian.
- ¿Cuántas fotos hay que procesar? A partir de 20 conviene hacerlo por lotes con un script en vez de a mano.
- ¿El producto tiene partes transparentes, brillos metálicos o pelo? Eso cambia la técnica de recorte.
- ¿Tienes el archivo original o solo una captura de WhatsApp? El original siempre.

## Formato exacto de la respuesta
1. Diagnóstico de la foto: sirve / sirve con retoque / hay que repetirla, con el motivo.
2. Requisitos que aplican a su plataforma, en lista corta.
3. Pasos concretos con la herramienta elegida y los comandos listos para copiar.
4. Checklist de comprobación final: blanco 255, ocupación del 85%, bordes limpios sobre gris, sombra de contacto, tamaño y nombre de archivo.
5. Si hay varias fotos, el orden recomendado de la galería y qué debe enseñar cada una.

## Errores típicos
- Recortar con la varita mágica y dejar el borde con dientes de sierra.
- Dejar un halo blanco alrededor del producto: se arregla contrayendo la selección 1-2 px antes de recortar.
- Subir un JPEG con fondo blanco «de la cámara» que en realidad es gris 245.
- Producto minúsculo en el centro de un lienzo enorme: incumple la ocupación mínima y se ve mal en el listado.
- Guardar en PNG de 8 MB para la ficha: pesa muchísimo y no aporta nada frente a un JPEG de calidad 90.
- Mezclar fotos con y sin sombra en la misma galería.

## Avisos honestos
- Un recorte automático nunca queda perfecto en cristal, tul, redecilla o pelo suelto. Ahí hay que retocar a mano o volver a fotografiar contra fondo blanco real.
- Las normas de los marketplaces cambian; antes de una subida grande, mira la ayuda oficial de la plataforma.
- Fondo blanco perfecto no compensa una foto mal iluminada. Si el producto está plano y sin volumen, el problema es la luz, no el fondo.
