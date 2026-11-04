---
name: presentaciones-powerpoint-notas-plantilla
description: Crea o edita presentaciones de PowerPoint (.pptx) con notas del ponente y, si existe, la plantilla de la empresa. Úsala cuando pidas una presentación, una propuesta para un cliente, un informe de resultados o cambios en un .pptx que ya tienes.
---

# Presentaciones de PowerPoint con notas y plantilla

## Qué hace
Monta un archivo .pptx que se abre en PowerPoint, Keynote o Google Slides. Puede partir de cero, de tu plantilla o de una presentación que ya existe y quieres retocar. Si lo pides, cada diapositiva lleva sus notas del ponente.

## Antes de empezar, pregunta y espera la respuesta
1. ¿Hay que crear una presentación nueva o editar una que ya existe? Si existe, ¿en qué carpeta está?
2. ¿Para quién es y qué debe hacer esa persona al terminar? (aprobar un presupuesto, entender un informe, apuntarse a algo...)
3. ¿Cuánto dura contada en voz alta? Como máximo, una diapositiva por minuto.
4. ¿Tienes plantilla o manual de marca (colores, tipografías, logo)? Si no, propón una paleta de 2 o 3 colores y una sola tipografía.
5. ¿Qué material tienes ya? Textos, cifras, imágenes, un documento. Las cifras que falten no se inventan: se dejan marcadas.
6. ¿Quieres notas del ponente? ¿Cortas o desarrolladas?
7. ¿Hay datos personales o confidenciales de otras personas en el material? Si es así, quita lo que no haga falta antes de dárselo a la herramienta.

## Paso a paso
1. Resume en 3 líneas lo que has entendido y espera el visto bueno antes de crear nada.
2. Propón el guion como lista numerada con el título de cada diapositiva. El título debe decir la conclusión (por ejemplo, «Podemos recortar el gasto un [X] %») y no solo el tema («Gasto»). Espera el visto bueno.
3. Prepara el entorno. Es posible que Claude Code necesite instalar una librería de Python llamada python-pptx para escribir archivos .pptx. Te pedirá permiso: acepta eso y nada que no entiendas.
4. Si hay plantilla, usa sus diseños de diapositiva (los «layouts») en vez de dibujar cajas a mano. Así la marca queda bien y luego se puede cambiar. Trabaja siempre sobre una copia de la plantilla.
5. Construye las diapositivas con estas reglas:
  - Una idea por diapositiva.
  - Máximo 5 o 6 líneas de texto y letra de 18 puntos o más en el cuerpo.
  - Buen contraste entre texto y fondo.
  - Un gráfico, un mensaje. Las tablas solo si ayudan.
  - Las imágenes llevan texto alternativo (una descripción corta).
  - Cada cifra lleva su fuente y su fecha, en pequeño al pie.
6. Notas del ponente: por diapositiva, qué decir en 2 a 4 frases, cómo enlazar con la siguiente y, si hay cifras, de dónde salen. No repitas palabra por palabra lo que ya está en la diapositiva.
7. Si es una edición, cambia solo lo que has pedido. Respeta formato, orden y notas existentes. Guarda con otro nombre (por ejemplo, informe-v2.pptx).
8. Comprueba el resultado. Si hay LibreOffice instalado, conviértelo a PDF o imágenes y busca texto cortado, solapado o fuera de la diapositiva. Si no puedes comprobarlo a la vista, dilo claramente y pide que lo abras tú.

## Qué devolver
- La ruta del archivo .pptx nuevo. Si hubo edición, el original queda intacto.
- Una tabla con: número, título, mensaje principal y si lleva notas.
- La lista de huecos: cifras, nombres, fechas y precios marcados como [DATO A CONFIRMAR].
- Si es una propuesta con precios: indica en cada precio si va con IVA o sin IVA.
- Un aviso si no pudiste revisar el aspecto visual.

## Qué NO hacer
- No inventar cifras, clientes, testimonios, logos ni casos de éxito. Si falta un dato, deja [DATO A CONFIRMAR] bien visible.
- No sobrescribir el archivo original ni la plantilla.
- No llenar la diapositiva de párrafos para leerlos en voz alta. Lo largo va a las notas o a un anexo.
- No usar logos, fotos o tipografías con derechos ajenos sin licencia. Si usas imágenes de stock, anota de dónde son.
- No enviar el archivo por correo ni subirlo a ningún sitio. Eso lo haces tú.
- No dejar comentarios internos ni opiniones sobre el cliente. Las notas del ponente viajan dentro del archivo: si compartes el .pptx, las verá quien lo abra.

## Qué revisa una persona antes de usarlo
- Todas las cifras, nombres, fechas y precios, contra su fuente.
- Que las notas del ponente y las propiedades del archivo (autor, comentarios) no contengan nada interno si lo vas a enviar.
- Que los compromisos (plazos, precios, condiciones) los has decidido tú y no la herramienta.

## Cómo activarla
Guarda este texto como SKILL.md dentro de una carpeta con el nombre de la skill, en .claude/skills/ de tu proyecto. Luego, en Claude Code, escribe algo como: «Prepara una presentación de 10 diapositivas para [CLIENTE] con notas del ponente».
