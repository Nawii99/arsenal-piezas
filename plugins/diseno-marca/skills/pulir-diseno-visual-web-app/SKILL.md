---
name: pulir-diseno-visual-web-app
description: Revisa el diseño visual de una web, tienda o app (jerarquía, espacios, tipografía, color, contraste, botones y formularios) y propone cambios concretos ordenados por prioridad, o los aplica en una copia. Úsala cuando algo se vea desordenado, anticuado o poco claro y no sepas por dónde empezar.
---
# Pulido visual de una web o app
Qué hace: mira tu diseño como lo vería un visitante, dice qué falla y propone cambios concretos con medidas y colores. Si trabajas con Claude Code sobre el código de tu web, puede aplicarlos en una copia para que compares.
Qué no hace: no inventa una marca nueva y no promete más ventas. Un diseño más claro ayuda, pero cuánto solo lo sabes midiendo.
## Pregunta esto antes de empezar
1. ¿Qué es (web de servicios, tienda, página de captación, app) y qué quieres que haga el visitante (comprar, apuntarse, reservar, llamar)?
2. ¿Quién la usa y desde dónde? Sobre todo móvil u ordenador, edad aproximada y si hay personas con poca vista.
3. ¿Qué es intocable? Logo, colores de marca, tipografías de pago, textos legales, precios.
4. ¿Qué me enseñas? Lo ideal es una captura en móvil y otra en ordenador de cada pantalla importante. También sirve la dirección web o el código.
5. ¿Hay referencias que te gusten? Úsalas para entender el estilo, no para copiarlas.
6. Si hay código: trabaja siempre en una copia o rama aparte, nunca sobre la web publicada.
## Paso a paso
1. Describe en cinco líneas lo que ves, para comprobar que entiendes la pantalla. Si el usuario te corrige, ajusta.
2. Diagnóstico en seis apartados, cada uno con nota de 1 a 3 (1 = urge, 3 = bien) y una frase de motivo.
  - Jerarquía: ¿lo primero que se ve es lo que más importa? ¿Hay un solo botón principal por pantalla?
  - Espacio: ¿hay aire entre bloques? ¿Se alinean los elementos? Usa una escala fija (múltiplos de 4 u 8 px).
  - Tipografía: máximo dos familias, texto de cuerpo de 16 px o más, interlineado de 1,4 a 1,6 y líneas de unos 45 a 75 caracteres.
  - Color: un color principal, neutros y como mucho un acento. Calcula el contraste, no lo adivines. Mínimo WCAG 2.2 nivel AA: 4,5:1 para texto normal y 3:1 para texto grande y para bordes de botones o campos.
  - Componentes: botones, campos, tarjetas y enlaces iguales en toda la web. Zona táctil de al menos 24 px (WCAG 2.2). En móvil, 44 px o más es más cómodo.
  - Estados: ¿se ve dónde está el foco al navegar con teclado? ¿Hay estado de error, vacío y cargando?
3. Prioriza: máximo cinco cambios, ordenados por impacto y esfuerzo. Lo demás va a una lista «para otro día».
4. Propón paleta y tipografía con valores concretos (códigos hex, tamaños en px) y el contraste calculado de cada pareja texto y fondo. Si no puedes calcularlo, dilo.
5. Aplicar: con código, en una copia, un cambio cada vez, mostrando antes y después. Sin código, entrega instrucciones en lenguaje llano y un bloque de CSS para quien monte tu web.
6. Comprobar: en móvil y en ordenador, navegando solo con la tecla Tab y con el zoom al 200 %.
## Qué devolver, en este orden
1. Lo que has visto, en cinco líneas.
2. Tabla del diagnóstico: apartado, nota y motivo.
3. Los cinco cambios, cada uno con qué cambia, dónde, valores exactos y por qué.
4. Si has tocado código: lista de archivos cambiados y cómo volver atrás.
5. «Para que lo mire una persona»: marca, accesibilidad y textos legales.
## Qué NO hacer
- No rediseñes todo si te piden mejorar. Cambios pequeños y reversibles.
- No copies el diseño, el logo, las imágenes ni las tipografías de pago de otra marca. Comprueba la licencia de cada tipografía e imagen que propongas.
- No quites el contorno de foco ni bajes el contraste por estética.
- No uses solo el color para decir algo (un error que solo se distingue por ir en rojo).
- No toques textos legales, precios ni condiciones.
- No cambies la web publicada directamente. Copia, prueba y que decida una persona.
- No cargues tipografías desde servidores de terceros sin avisar: en la UE ha dado problemas de privacidad. Es más seguro alojarlas en tu propio sitio.
- No prometas más conversión. Para saber si funciona, compara antes y después con un tráfico parecido o haz una prueba A/B.
## Qué revisa una persona antes de usar el resultado
- Quien lleva la marca aprueba colores, tipografías y tono visual.
- Accesibilidad: la ley europea de accesibilidad (aplicable desde junio de 2025 a ciertos servicios, como el comercio electrónico) puede afectarte. Pregunta a tu asesor si entras y qué excepciones tienes. Una persona debe probar la web solo con teclado.
## Instalación (una sola vez)
Guarda este texto en un archivo llamado SKILL.md dentro de la carpeta .claude/skills/pulir-diseno-visual-web-app/ de tu proyecto, o en ~/.claude/skills/pulir-diseno-visual-web-app/ para tenerla en todos tus proyectos. Normalmente también puedes lanzarla escribiendo / y ese nombre.
