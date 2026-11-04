---
name: rescatar-foto-mala
description: Diagnoses a bad photograph, says what can and cannot be fixed, gives free step-by-step corrections and calls out when reshooting is cheaper. Use when the user has dark, blurry, yellow, noisy or low-resolution photos and no better ones.
---

# Rescatar una foto mala

## Qué hace
Analiza qué le pasa exactamente a una foto, separa lo recuperable de lo irrecuperable y da el procedimiento concreto con herramientas gratuitas. Y si no tiene arreglo, lo dice con claridad y explica cómo repetirla bien.

## Cuándo se activa
Cuando el usuario pide arreglar, mejorar, aclarar, enderezar o «salvar» una foto, o dice que las fotos que le ha pasado el cliente son malas.

## Diagnóstico: mira esto y en este orden
1. ¿Está movida o desenfocada? Amplía al 100% y busca un borde con contraste. Si el borde es una estela, es movimiento: NO tiene arreglo. Si es un borde blando pero simétrico, es desenfoque: tampoco.
2. ¿Está quemada? Mira el histograma pegado al extremo derecho. Un blanco a 255 no tiene información: no se recupera detalle, solo se puede oscurecer todo el conjunto.
3. ¿Está subexpuesta? Si es sombra oscura pero no negro puro, sí se recupera, a cambio de ruido.
4. ¿Tiene dominante de color? Foco amarillo, fluorescente verde, sombra azul. Se arregla casi siempre con el balance de blancos.
5. ¿Tiene ruido? Puntitos de color en las zonas oscuras. Se reduce, a cambio de perder detalle fino.
6. ¿Le falta resolución? Menos de 1000 px de lado para una ficha de producto es poco. Se puede ampliar 2x con IA de forma decente; a 4x ya se inventa detalle.
7. ¿Está torcida o con líneas caídas? Se arregla con rotación y corrección de perspectiva. Es lo más fácil y lo que más mejora la sensación de profesionalidad.
8. ¿Es un JPEG reenviado por WhatsApp? Entonces tiene bloques de compresión y poca resolución. Pide siempre el original.

## Método de corrección (Photopea, GIMP o darktable, todo gratis)
1. Trabaja sobre una copia. Nunca sobre el único archivo que existe.
2. Endereza y corrige perspectiva primero. Todo lo demás va después.
3. Balance de blancos: cuentagotas sobre algo que sepas que es gris o blanco neutro en la escena.
4. Exposición y contraste con curvas, no con el deslizador de brillo. El brillo aplana; la curva respeta los tonos.
5. Levanta sombras y baja luces altas con moderación. Si las sombras quedan grises y sin negro, la foto se ve lavada: deja siempre algún punto de negro real.
6. Reduce ruido antes de enfocar, nunca al revés.
7. Enfoca al final, con máscara de enfoque suave. Si aparece un halo claro alrededor de los bordes, te has pasado.
8. Recorta para arreglar el encuadre y quitar lo que sobra. Un recorte inteligente arregla más fotos que cualquier filtro.
9. Exporta a sRGB y al tamaño que necesites.

## Qué preguntar si falta información
- ¿Tienes el archivo original de la cámara o el móvil, o solo el que llegó por mensajería?
- ¿Para qué es: ficha de producto, redes, impresión, cartel grande? La exigencia cambia mucho.
- ¿Se puede repetir la foto o el objeto, el local o el momento ya no existe?
- ¿Cuántas fotos tienen el mismo problema? Si es una tanda entera, el ajuste se hace una vez y se copia a todas.

## Formato exacto de la respuesta
1. Diagnóstico por defecto, con veredicto claro para cada uno: recuperable, recuperable a medias, irrecuperable.
2. Veredicto global: sirve tal cual / sirve con estos retoques / hay que repetirla.
3. Pasos de corrección en orden, con la herramienta y el ajuste concreto.
4. Cómo saber que está bien: blancos que no tiran a azul ni a amarillo, pieles no naranjas, negros con algo de negro real, sin halos de enfoque, sin manchas de color en las sombras.
5. Si hay que repetirla, la receta de cómo hacerla bien en cuatro líneas.

## Errores típicos
- Subir la nitidez para arreglar una foto movida: solo consigues bordes crujientes y feos.
- Ampliar con IA una foto ya mala: se amplían los defectos y aparecen texturas plastificadas.
- Aplicar un filtro de Instagram encima para «disimular»: se nota y encima destruye el color de tu producto.
- Corregir el color a ojo en una pantalla mal calibrada y con el modo noche activado.
- Subir sombras al máximo hasta que la foto queda gris y sin cuerpo.
- Editar sobre el JPEG una y otra vez, guardando encima: cada guardado añade pérdida.

## Avisos honestos
- Repetir la foto suele costar menos tiempo que rescatarla, sobre todo si el objeto lo tienes delante.
- Los ampliadores con IA inventan detalle. Para una cara conocida o un texto legible eso es un problema, no una mejora.
- Ninguna edición devuelve información que no está en el archivo. Lo quemado y lo movido no vuelven.
