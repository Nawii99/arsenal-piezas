---
name: notas-episodio-skill
description: convierte la transcripción de un episodio de podcast en título, descripciones para Spotify y YouTube, capítulos con minutos y lista de enlaces; se activa cuando el usuario aporta una transcripción y pide notas o descripción del episodio
---

## Qué hace

A partir de una transcripción con marcas de tiempo, genera todo lo que hay que pegar al publicar el episodio. Es la tarea que más tiempo come cada semana: el objetivo es que el usuario copie y pegue sin retocar casi nada.

## Antes de empezar, pregunta (solo si no lo sabes ya)

1. Nombre del podcast y número del episodio.
2. Si hay invitado: nombre, a qué se dedica y qué enlace suyo quiere promocionar.
3. Si la transcripción no trae marcas de tiempo, avisa de que los capítulos saldrán sin minutos y pregunta si aun así sigue.

## Paso a paso

1. Lee la transcripción entera antes de escribir nada. Identifica los 4 a 8 bloques temáticos reales de la conversación.
2. Propón 3 títulos: uno directo (qué se aprende), uno con el dato o afirmación más llamativa que se dice de verdad en el episodio, y uno con el nombre del invitado si lo hay. Máximo 70 caracteres cada uno, que es lo que se ve entero en la mayoría de apps.
3. Escribe la descripción para Spotify: 2 o 3 párrafos cortos, la primera frase debe funcionar sola porque es lo único que se ve sin desplegar. Sin hashtags.
4. Escribe la descripción para YouTube: primera línea gancho, luego los capítulos en formato `MM:SS Título del capítulo` (el primero siempre `00:00`), luego los enlaces mencionados, luego 3 a 5 hashtags.
5. Los capítulos salen de las marcas de tiempo de la transcripción. Redondea al momento en que empieza el tema, no a la mitad.
6. Lista aparte todos los libros, herramientas, personas y webs que se mencionan, con el minuto. Los enlaces que no conozcas con seguridad, déjalos como `[buscar enlace]`.
7. Cierra con 2 citas textuales del episodio (frases que se dicen tal cual) por si el usuario quiere usarlas en redes, con minuto y quién lo dice.

## Formato de salida

Un solo bloque en este orden, con encabezados: Títulos propuestos, Descripción Spotify, Descripción YouTube (lista para pegar), Enlaces mencionados, Citas. Nada de explicaciones entre medias.

## Qué NO hacer

- No inventes citas ni las retoques: si la frase no está en la transcripción tal cual, no es una cita.
- No inventes minutos. Si dudas del momento exacto, escribe el minuto aproximado con `[revisar]` al lado.
- No inventes URLs de los enlaces mencionados: nombre correcto y `[buscar enlace]` si no la sabes segura.
- No uses lenguaje de venta (imperdible, brutal, no te lo puedes perder). Describe lo que hay.
- No resumas tanto que la descripción valga para cualquier episodio: cada frase debe ser concreta de este.
