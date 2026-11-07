---
name: mockup-producto-diseno
description: Coloca un diseño, etiqueta o logo sobre un mockup de producto realista (camiseta, taza, tarro, caja, rótulo) con perspectiva, iluminación y área de impresión correctas. Úsala cuando el usuario quiera mostrar cómo quedaría su obra antes de fabricar, validar un diseño o vender antes de tener existencias.
---

# Mockup: tu diseño puesto sobre el producto

## Qué hace
Coge un diseño plano (logo, ilustración, etiqueta, texto) y lo coloca de forma creíble sobre un producto: camiseta, sudadera, taza, bote de cristal, caja, bolsa, rótulo o furgoneta. Te da tanto la vía con IA como la vía de montaje manual, y el criterio para que no cante que es un montaje.

## Cuándo se activa
Cuando el usuario menciona mockup, maqueta, «cómo quedaría mi logo en», merchandising, packaging, etiqueta, print on demand, camisetas, rótulo o quiere validar un diseño antes de fabricar.

## Lo que hace creíble un mockup
- Perspectiva: el diseño debe seguir la forma del objeto. En una taza se curva, en una camiseta ondula con los pliegues, en una caja sigue las tres caras.
- Deformación con la tela: en tejido, el arte se rompe con las arrugas. Un rectángulo perfectamente plano sobre una camiseta arrugada delata el montaje.
- Luz coherente: si la foto tiene la luz por la izquierda, el diseño también tiene que estar más oscuro por la derecha. Modo de fusión Multiplicar o Luz suave al 85-95% en vez de Normal.
- Tamaño real: el error más común es poner el logo gigante. Un pecho de camiseta suele llevar de 8 a 12 cm de ancho; una serigrafía frontal grande, de 25 a 30 cm.
- Textura del material: el diseño impreso sobre algodón nunca es liso ni saturadísimo; baja un poco la opacidad y añade el grano del tejido.
- Zona segura de impresión: separa el arte de costuras, asas, cierres y bordes al menos 1 cm.

## Método con IA
1. Genera el producto sin diseño, limpio, con espacio despejado para el arte: describe material, color, luz, fondo, ángulo y plano.
2. Prompt base de ejemplo: `photograph of a folded heather grey cotton t-shirt on a light concrete surface, soft window light from the left, 50mm lens, shallow depth of field, empty chest area, product photography`.
3. Con el resultado, coloca el arte encima con Photopea, GIMP o Canva y aplica la deformación.
4. Si usas relleno generativo o edición por zonas, marca solo la zona del pecho o de la etiqueta y describe el diseño con palabras exactas; el texto largo saldrá mal.
5. Los generadores no reproducen bien tu logotipo. Nunca pidas «pon mi logo»: genera el producto vacío y pega tu archivo real encima.

## Método manual en 6 pasos (Photopea o GIMP, gratis)
1. Abre la foto del producto y coloca el arte como capa nueva.
2. Escálalo a la medida real en centímetros calculada sobre el producto.
3. Edición > Transformación > Deformar para seguir la curva o los pliegues.
4. Cambia el modo de capa a Multiplicar si el producto es claro, o a Trama si es oscuro.
5. Baja la opacidad al 85-92% y, si hay tejido, aplica un mapa de desplazamiento con la propia foto en escala de grises.
6. Comprueba en miniatura: si a 200 px de ancho parece pegado, algo falla.

## Qué preguntar si falta información
- ¿Qué producto exacto y en qué color y material?
- ¿Tienes el arte en vectorial (SVG, PDF, AI) o solo en JPEG? Para imprimir hace falta vectorial o 300 ppp al tamaño real.
- ¿El mockup es para enseñar en redes, para una ficha de venta o para el proveedor?
- ¿Sabes el área de impresión que admite tu proveedor?

## Formato exacto de la respuesta
1. Prompt del producto vacío, listo para copiar.
2. Medidas concretas del arte sobre ese producto, en centímetros y en píxeles.
3. Pasos de montaje con el modo de fusión y la opacidad recomendados.
4. Checklist de credibilidad: perspectiva, arrugas, luz, tamaño, zona segura, bordes.
5. Aviso de si ese mockup vale para vender o solo para enseñar internamente.

## Errores típicos
- Logo demasiado grande y demasiado centrado: parece un producto de feria.
- Diseño en modo Normal, con blancos puros que tapan las sombras de la tela.
- Usar un mockup gratuito con marca de agua o con licencia que no permite uso comercial.
- Presentar el mockup como si fuera una foto real del producto en una ficha de venta.
- Arte a 72 ppp que se ve nítido en pantalla y sale pixelado al imprimir.

## Avisos honestos
- Un mockup no garantiza que el proveedor pueda imprimir eso: los colores en tejido oscuro, los degradados finos y los dorados suelen dar problemas. Pide siempre una muestra física antes de una tirada.
- Si vendes con la foto de un mockup, di en la ficha que es una recreación. Vender con imagen simulada como si fuera real da lugar a devoluciones y a reclamaciones.
- Comprueba la licencia de cualquier plantilla de mockup que descargues: muchas gratuitas prohíben el uso comercial.
