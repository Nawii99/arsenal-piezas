---
name: ficha-estilo-visual
description: Builds a reusable visual style sheet (lighting, background, palette, lens, framing, grading) and turns it into a fixed prompt block so every AI image looks like the same brand. Use when the user's generated images look inconsistent, when starting a catalog, website or social account, or when they ask how to keep a coherent look across images.
---

# Ficha de estilo visual

## Qué hace
Convierte un montón de imágenes sueltas en un sistema. Sacas seis decisiones fijas y las conviertes en un bloque de texto que pegas en TODOS tus prompts. A partir de ahí solo cambia el producto.

## Cuándo se activa
Cuando el usuario habla de "que todas mis fotos parezcan de la misma marca", empieza catálogo o redes, o se queja de que cada imagen sale de un estilo.

## Método
1. Pide 5-10 imágenes de referencia que le gusten (de otras marcas vale) y 1 foto real de su producto. Si no tiene referencias, pregúntale qué tres marcas admira visualmente.
2. Extrae los seis ejes. No inventes: descríbelos mirando las referencias.
   - Luz: dura o suave, dirección (lateral 45º, cenital, contraluz), sombras marcadas o difusas.
   - Fondo y superficie: color exacto, material (papel mate, mármol, madera clara, cemento), con o sin degradado.
   - Paleta: 3 colores + 1 acento. Dilos en nombre y en hex aproximado.
   - Óptica: distancia focal equivalente (50 mm neutro, 85 mm para producto y retrato, 35 mm para ambiente) y apertura (f/8 todo nítido, f/2.8 fondo desenfocado).
   - Encuadre: plano (cenital, frontal, tres cuartos), cuánto aire deja alrededor, dónde cae el producto.
   - Acabado: contraste, saturación, grano, dominante de color (cálida, fría, neutra).
3. Escribe el BLOQUE FIJO: 40-60 palabras que contengan esos seis ejes y ninguna palabra sobre el producto.
4. Escribe la PARTE VARIABLE: una plantilla corta donde solo entra producto, material y acción.
5. Prueba de coherencia: genera mentalmente tres prompts con tres productos muy distintos usando el mismo bloque. Si alguno pide cambiar el bloque, el bloque está mal.
6. Añade la lista de prohibiciones (negative prompt): lo que nunca debe salir en tus imágenes.

## Qué preguntar si falta información
- ¿Qué vendes y a quién? (una marca de bebé y una de herramientas no comparten luz)
- ¿Dónde se van a ver estas imágenes: web, Instagram, marketplace, impreso?
- ¿Tienes colores de marca o logo ya definidos?
- ¿Qué generador usas? (Midjourney entiende bien el estilo, Flux e Ideogram piden más literalidad)

## Formato de la respuesta
1. Tabla "Ficha de estilo" con las seis filas: Luz, Fondo, Paleta, Óptica, Encuadre, Acabado.
2. BLOQUE FIJO entre comillas, listo para copiar.
3. Plantilla completa: BLOQUE FIJO + [producto] + [acción] + parámetros técnicos.
4. Tres ejemplos ya montados con productos distintos del usuario.
5. Lista de prohibidos.
6. Checklist de coherencia: 5 preguntas de sí/no para revisar cualquier imagen nueva.

## Errores típicos
- Poner adjetivos de marca en vez de decisiones visuales: "elegante" no es nada, "luz lateral suave sobre papel gris claro" sí.
- Cambiar dos ejes a la vez cuando algo no sale: cambia uno y vuelve a generar.
- Olvidar el fondo. El fondo es lo que más delata que las imágenes son de sitios distintos.
- Meter el color de marca como color de la luz: tiñe el producto y falsea el material.

## Avisos honestos
- Con la misma ficha, dos generadores dan resultados distintos. Fija uno y quédate en él para el mismo catálogo.
- Las semillas y las referencias de estilo ayudan, pero no garantizan copia exacta: la coherencia real la da el bloque fijo, no el azar.
- Si tu producto es muy identificable (una etiqueta, un logo), la IA lo va a deformar. Ahí toca foto real o retoque encima.
