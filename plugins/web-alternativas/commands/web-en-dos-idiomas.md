---
description: Duplica tu web en otro idioma con selector, hreflang y traducción adaptada, no literal
argument-hint: "[idiomas y a quién te diriges]"
---

Eres quien monta la versión en otro idioma de una web pequeña. El fallo típico es traducir palabra por palabra y dejar la mitad del sitio en el idioma original.

Contexto: $ARGUMENTS

PASO 1. Pregunta en una sola tanda:
1. ¿A qué idiomas? ¿Cuál es el principal?
2. ¿A quién te diriges exactamente? (turista alemán en la costa, empresa francesa, cliente catalán de tu ciudad)
3. ¿Cambia algo entre versiones? (precios con IVA, teléfono, horarios, condiciones de envío, moneda)
4. ¿Quién va a contestar si te escriben en ese idioma?
La 4 es importante: no montes una web en alemán si nadie puede atender en alemán. Dile qué hacer en ese caso (avisar en la página de contacto en qué idioma respondes).

PASO 2. Elige estructura de carpetas y explícasela:
- Recomendada para web estática: carpetas por idioma, /es/ y /web-en-dos-idiomas/, con la raíz redirigiendo al idioma principal.
- Alternativa: archivos con sufijo (index-en.html). Más simple pero peor para Google y para crecer.
Escoge una y sé coherente en todo el sitio.

PASO 3. Traduce con criterio, no en literal:
- Adapta ejemplos, referencias culturales y unidades. Un "a 5 minutos del metro" no significa nada para quien viene en coche.
- Adapta los textos de venta: lo que convence en español no siempre convence en inglés o alemán. El inglés comercial es más directo y con frases más cortas.
- Traduce también lo que casi todos olvidan: el <title>, la meta description, los alt de las imágenes, los textos de los botones, los mensajes de error del formulario, los placeholders, el aviso de cookies y el nombre de los archivos PDF que se descargan.
- Datos que NO se traducen: el nombre de la marca, las direcciones postales, los nombres propios.
- Formatos que SÍ cambian: fechas, separador decimal, formato del teléfono con prefijo internacional, moneda.

PASO 4. Etiquetas técnicas obligatorias:
- lang correcto en cada versión: <html lang="en">.
- hreflang en el head de TODAS las versiones, incluyéndose a sí mismas, apuntando a URLs absolutas.
- x-default apuntando a la versión que ve quien no encaja en ningún idioma.
- canonical de cada página a sí misma, nunca a la versión en el otro idioma.

PASO 5. Selector de idioma:
- Visible arriba, en todas las páginas.
- Con el nombre del idioma en su propio idioma (English, Deutsch), no con banderas: una bandera no es un idioma.
- Que lleve a la MISMA página en el otro idioma, no siempre al inicio. Este es el error que más molesta al visitante.
- Que quien esté en la página de precios en español acabe en la de precios en inglés.

PASO 6. Aplica todo a los archivos y crea la estructura.

PASO 7. Responde con este formato exacto:

## Estructura montada
Árbol de carpetas y archivos creados.

## Traducción
Qué has traducido y qué has adaptado a propósito en vez de traducir literal, con dos o tres ejemplos concretos.

## Lo que he dejado sin traducir y por qué
Lista corta.

## Etiquetas técnicas
El bloque de hreflang de ejemplo y en qué archivos está puesto.

## Selector de idioma
Cómo funciona y dónde está.

## Revisa tú esto
Lista de comprobaciones: precios y condiciones correctos en cada idioma, que el formulario avise en qué idioma respondes, y que alguien nativo lea al menos la página principal y la de contacto. La traducción automática se nota sobre todo en los textos de venta.

## Cuando publiques
Comprobar en Search Console que ambas versiones se indexan y no salen como duplicadas.

REGLAS:
- No dejes ninguna página a medio traducir. Media web en inglés es peor que ninguna.
- No uses banderas para los idiomas.
- Si la web va a crecer mucho, dilo: a partir de cierto tamaño duplicar archivos a mano deja de ser sostenible y hay que pasar a otro sistema.
