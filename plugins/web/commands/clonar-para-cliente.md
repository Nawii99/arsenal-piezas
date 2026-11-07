---
description: Adapta una web existente a un cliente nuevo cambiando marca, colores, textos y datos de contacto sin romper la estructura
argument-hint: "[ruta de la web original y nombre del negocio nuevo]"
---

Vas a adaptar una web existente a un cliente nuevo: $ARGUMENTS

## Paso 0: entrevista corta al usuario
Pregunta y espera respuesta antes de tocar nada:
1. Ruta de la web original y ruta o nombre de la copia nueva.
2. Nombre del negocio nuevo y a qué se dedica en una frase.
3. Ciudad o zona donde trabaja.
4. Teléfono, WhatsApp, correo y dirección si tiene local.
5. Colores de marca o logo si los tiene; si no, dilo y propón tres combinaciones.
6. Qué servicios o productos vende y a qué precio o desde qué precio.
7. Qué acción quiere que haga el visitante.

## Paso 1: copia limpia
Duplica la carpeta entera a la ruta nueva. Nunca edites encima del original: es la forma más rápida de perder la plantilla que te da de comer.
Enseña el árbol de archivos de la copia antes de seguir.

## Paso 2: inventario de lo que hay que cambiar
Recorre todos los archivos y haz una lista de todo lo que pertenece al negocio anterior:
- Nombre del negocio en textos, <title>, meta descripción y og:.
- Teléfonos, correos, direcciones, enlaces de WhatsApp, perfiles sociales.
- NIF, nombre fiscal y datos en las páginas legales. Esto se olvida siempre y es lo más grave: publicar la web de un cliente con el NIF de otro.
- IDs de analítica, píxeles y códigos de formularios del cliente anterior. Si se quedan, los datos del cliente nuevo se van a la cuenta del viejo.
- Imágenes con el logo o las fotos del negocio anterior.
- Testimonios y casos reales del cliente anterior: hay que quitarlos, no reciclarlos.
Presenta esta lista como tabla antes de cambiar nada y pide confirmación.

## Paso 3: cambios de marca
- Colores: localiza dónde están definidos. Si hay variables CSS, cambia solo las variables. Si están repartidos a pelo por el archivo, propón extraerlos a variables en :root primero.
- Tipografía: cámbiala solo si el usuario lo pide.
- Logo: sustituye el archivo manteniendo el mismo nombre y proporciones, o ajusta el CSS si cambian.

## Paso 4: textos
Reescribe los textos con la información real del negocio nuevo. Nada de dejar frases genéricas de plantilla ni Lorem ipsum. Si falta información, marca [FALTA: ...] en la respuesta y pregúntalo al final, no lo rellenes con humo.
Adapta el titular principal al oficio y la zona concretos, porque un titular genérico no vende.

## Paso 5: repaso final antes de entregar
Busca en toda la copia el nombre del negocio anterior, su teléfono y su dominio. Si aparece una sola vez, no está terminado. Enseña el resultado de esa búsqueda como prueba.

## Formato de respuesta
1. Árbol de la copia nueva.
2. Tabla de sustituciones: Qué había / Qué has puesto / En qué archivos.
3. Lista de [FALTA] pendientes.
4. Resultado de la búsqueda final del nombre y teléfono antiguos.
5. Siguiente paso sugerido: publicar y apuntar el dominio.

Confirma con el usuario antes de escribir en disco.
