---
name: fotos-producto-ia
description: El lenguaje profesional de la fotografía con IA. Úsala siempre que el usuario pida un prompt de imagen, una foto de producto, una imagen para redes o anuncios, o mencione Midjourney, Flux, Ideogram o generadores de imágenes. Aplica automáticamente planos, ángulos, lentes, luz y medidas correctas.
---

# Fotos de producto con IA

Al construir cualquier prompt de imagen para marketing, combina SIEMPRE estos 6 ingredientes en este orden: sujeto → plano → ángulo → lente → iluminación → estilo → formato. El prompt va en inglés; la explicación al usuario, en castellano.

## 1. Plano (cuánto se ve)
- `extreme close-up shot` — detalle extremo: texturas, logos, gotas.
- `close-up shot` — el producto llena la imagen.
- `medium shot` — producto con algo de contexto.
- `full shot` — escena completa o cuerpo entero.
- `flat lay` — composición vista desde arriba (combinar con top-down).
- `macro photography` — para detalles minúsculos con fondo desenfocado.

## 2. Ángulo (desde dónde mira la cámara)
- `eye level shot` — neutro, honesto; el estándar de catálogo.
- `low angle shot` — desde abajo: el producto parece importante, imponente.
- `high angle shot` — desde arriba: cercano, accesible.
- `top-down view / overhead shot` — cenital para flat lays y comida.
- `three-quarter view` — el ángulo clásico de producto (muestra frente y lateral).
- `dutch angle` — inclinado: dinamismo, para anuncios llamativos.

## 3. Lente y cámara (el look)
- `85mm f/1.8, shallow depth of field` — fondo desenfocado cremoso, look premium.
- `35mm lens` — natural, estilo reportaje/lifestyle.
- `100mm macro lens` — nitidez extrema en detalle.
- `bokeh background` — luces desenfocadas detrás.
- `tilt-shift` — efecto miniatura.

## 4. Iluminación (el ambiente)
- `soft studio lighting, softbox` — luz limpia de estudio, sin sombras duras.
- `golden hour lighting` — cálida, atardecer, lifestyle.
- `rim lighting` — borde de luz que separa el producto del fondo, premium.
- `dramatic side lighting` — sombras marcadas, carácter.
- `neon lighting` — moderno, nocturno, tecnológico.
- `natural window light` — casero, honesto, artesanal.

## 5. Estilo
- `professional product photography` — el básico imprescindible.
- `editorial style` — revista, sofisticado.
- `lifestyle photography` — en uso, con personas.
- `UGC style photo, shot on iPhone` — aspecto casero creíble para anuncios.
- `minimalist, clean background` — fondo limpio para catálogo.

## 6. Formato según destino (crítico — no inventar)
- Feed cuadrado: `--ar 1:1`
- Instagram feed vertical: `--ar 4:5`
- Stories / Reels / TikTok: `--ar 9:16`
- YouTube / web horizontal: `--ar 16:9`
- Pinterest: `--ar 2:3`
(`--ar` es sintaxis de Midjourney; en otros generadores, indicar "vertical 9:16 format" en texto o elegir la medida en la interfaz.)

## Plantilla base

`[producto + superficie/entorno], [plano], [ángulo], [lente], [iluminación], [estilo], high resolution --ar [medida]`

Ejemplo: `amber glass skincare bottle on wet black slate, water droplets, close-up shot, three-quarter view, 85mm f/1.8 shallow depth of field, rim lighting, professional product photography, high resolution --ar 4:5`

## Reglas

- Pregunta siempre el destino de la imagen si no lo dicen: la medida depende de eso.
- Un concepto por imagen: no mezclar golden hour con neon.
- Para texto dentro de la imagen (logos, etiquetas legibles) recomendar Ideogram o Recraft, que lo hacen mejor.
- Ofrece siempre 2-3 variantes con concepto distinto, no la misma con sinónimos.
