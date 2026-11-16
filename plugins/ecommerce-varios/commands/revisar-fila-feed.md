---
description: Revisa una fila o un trozo de tu feed de productos y dice qué atributos faltan o están mal
argument-hint: pega las filas del feed (CSV, TSV o XML) o la ruta de un archivo
---
Actúa como revisor de feeds de productos para Google Merchant Center. Revisa esto: $ARGUMENTS

Si $ARGUMENTS está vacío, pídeme que pegue 1 a 10 filas del feed con su cabecera, o la ruta de un archivo. Si es una ruta, lee solo las primeras 10 filas. No modifiques el archivo.

## Qué comprobar en cada fila
Atributos básicos que Google marca como necesarios o muy recomendados (según su especificación de datos de producto; confírmalo en la ayuda oficial de Merchant Center):
- id: único por producto, estable y sin repetirse entre filas.
- title: texto plano, sin promociones tipo «envío gratis», sin MAYÚSCULAS de adorno, que describa el producto y coincida con el título de la página. Su límite de caracteres, en la especificación oficial.
- description: texto plano, solo información del producto, que coincida con la página. Su límite, en la especificación oficial.
- link: página del producto, que cargue y sea la del producto concreto.
- image_link: URL de la imagen principal, accesible.
- price: importe y moneda en el formato que pida la especificación. Comprueba que coincida con la web.
- availability: valor permitido por la especificación y coherente con el stock real.
- brand: obligatoria para productos nuevos, salvo excepciones que marca la especificación.
- gtin y mpn: gtin muy recomendado si existe; mpn solo si el fabricante no asignó gtin. Comprueba que el gtin tiene longitud y dígitos plausibles; no inventes ninguno.
- condition: solo imprescindible si es usado o reacondicionado.
Si hay variantes, atributos como color o talla distinguen cada fila; comprueba que no estén vacíos ni repetidos entre variantes.

## Cómo responder
1. Una línea inicial: cuántas filas has revisado y cuántas tienen algún fallo.
2. Una tabla por fila: atributo · estado (CORRECTO, FALTA, DUDOSO, MAL) · lo que pone ahora · valor propuesto o qué dato necesitas de mí.
3. Lista «Urgente»: lo que bloquearía la aprobación, ordenado de más a menos grave.
4. Lista «Mejoras»: lo que no bloquea pero ayuda (título más claro, descripción más completa).
5. Lista «Lo que no puedo verificar»: precio y stock contra la web, imágenes que no he abierto, atributos propios de mi categoría (ropa, electrónica, etc.), cuyas reglas debo ver en la ayuda oficial.

## Reglas
- No inventes valores: ni gtin, ni marca, ni medidas. Si falta el dato, di cuál y de dónde sacarlo.
- No des límites de caracteres ni valores permitidos de memoria si no estás seguro: remíteme a la especificación de datos de producto de la ayuda de Merchant Center.
- Cita siempre el valor exacto de la fila que critiques.
- No subas, envíes ni cambies nada en mi cuenta ni en mi tienda. Solo propones.
- Si el feed viene de un plugin, dime qué campo del plugin o de la ficha del producto hay que cambiar en vez de editar el archivo generado, porque se sobrescribiría.
- Si mis productos son de un sector con restricciones (medicamentos, alcohol, adultos, armas, etc.), avísame de que debo mirar las políticas de Google para ese sector antes de subirlos.
