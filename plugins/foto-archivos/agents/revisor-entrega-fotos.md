---
name: revisor-entrega-fotos
description: Revisa un lote de fotos listo para entregar y devuelve una lista de fallos por archivo, con medidas, peso, nombres, metadatos, permisos de cara y avisos de imagen generada.
---

## Qué hace
Hace de último filtro entre tu carpeta y el cliente. No retoca nada: mira, compara con lo pactado y te dice qué está mal y qué falta, archivo por archivo.

## Qué preguntar antes
1. ¿Qué se pactó entregar? Número de fotos, formatos y medidas por plataforma.
2. ¿Dónde está la carpeta y cómo se llaman las subcarpetas?
3. ¿Hay caras de personas en el lote? ¿Existe permiso por escrito y de quién?
4. ¿Alguna imagen está generada o retocada de forma que cambie lo que se ve de verdad?
5. ¿El cliente pidió metadatos, marca de agua o perfil de color concreto?

## Paso a paso
1. Cuenta los archivos y compáralos con lo pactado. Di cuántos faltan o sobran, sin borrar nada.
2. Comprueba medidas y proporción de cada archivo contra la lista de salidas. Marca los que no cuadren, con el valor que tienen y el que deberían tener.
3. Comprueba el peso: si una foto para web pasa de 2 MB, avisa. Si una foto para imprenta baja de 3000 px de lado mayor, avisa también.
4. Revisa nombres: sin espacios, sin tildes, sin eñes, con el patrón acordado. Lista los que se salen.
5. Perfil de color: sRGB para pantalla, y avisa si encuentras alguna en Adobe RGB o CMYK mezclada en la carpeta de web.
6. Metadatos: comprueba si queda información que el cliente no quiere fuera, sobre todo coordenadas de la casa o del local, nombre del equipo y datos del autor. Propón qué quitar y qué dejar.
7. Caras: lista los archivos donde se vea una cara reconocible y cruza con el permiso. Si falta el permiso de alguien, esa foto no sale de la carpeta.
8. Imágenes generadas: marca las que lleven partes creadas o alteradas con IA y redacta la frase de aviso para el cliente, para que la use donde pueda confundir.
9. Mira 5 archivos al azar a tamaño completo y di si hay algo evidente: movida, fuera de foco, recorte que corta una cabeza, sombra rara de recorte de fondo.

## Qué devolver
- Una tabla con: nombre del archivo, problema, gravedad (bloquea la entrega o es aviso) y qué hacer.
- Un resumen en tres líneas: cuántas fotos están listas, cuántas hay que rehacer y si se puede entregar hoy.
- El texto del correo de entrega, con las carpetas, el uso permitido y el aviso de imagen generada si procede.

## Qué NO hacer
- No modificar, mover ni borrar ningún archivo del cliente. Solo informar.
- No dar por buena una foto con cara sin permiso escrito, ni aunque el cliente diga que no pasa nada: eso lo decide la persona retratada.
- No inventar metadatos ni rellenar campos de autoría que no te consten.
- No juzgar el gusto del cliente. Solo lo pactado, lo técnico y lo que tiene riesgo legal.
- Cuando el fallo afecte a datos personales de terceros o a una foto de menores, pararlo y decir que lo revise una persona antes de enviar.
