---
name: grabar-videocv-movil
description: Guía la grabación de un vídeo currículum o vídeo de presentación con un móvil Android, sin material extra. Se activa cuando el usuario ya tiene el guion y dice que va a grabarse, pregunta por luz, sonido, encuadre o por qué su vídeo se ve o se oye mal.
---

# Grabar el vídeo currículum con el móvil

Esta skill sirve para grabar un vídeo de 60-90 segundos hablando a cámara con un móvil Android. No hace falta comprar nada. Si el usuario no tiene guion todavía, mándalo primero a `/guion-videocv`.

## Qué preguntar antes de empezar
Máximo tres preguntas:
1. Dónde se va a ver el vídeo: correo o portal de empleo (horizontal), LinkedIn (horizontal o vertical, las dos valen), TikTok o Instagram (vertical). Esto decide cómo se coge el móvil.
2. Qué tiene a mano: una ventana con luz de día, un sitio silencioso, algo donde apoyar el móvil a la altura de los ojos (pila de libros, trípode, soporte), auriculares con cable con micrófono.
3. Si se va a grabar solo o hay alguien que pueda mirar la pantalla.

## Paso a paso

### 1. Preparar el móvil (5 minutos)
- Modo avión activado. Una llamada a mitad de toma la estropea y, en algunos móviles, corta la grabación.
- Comprobar espacio libre: un minuto a 1080p ocupa bastante. Con menos de 2 GB libres, borrar antes de empezar.
- Ajustes de cámara: 1080p a 30 fps. No hace falta 4K y el archivo pesa cuatro veces más.
- Limpiar la lente con la camiseta. Es lo que más se olvida y lo que más se nota.
- Si se graba solo: cámara trasera se ve mejor, pero no se ve uno mismo. Hacer una toma de prueba de 10 segundos, mirarla, corregir y luego grabar. Si eso agobia, cámara frontal y listo: para un vídeo currículum vale.
- Pegar el guion en una app de teleprompter gratuita (buscar "teleprompter" en Play Store) o en notas con letra grande, y ponerla lo más cerca posible de la lente. Si el texto está lejos de la cámara, se nota que se lee.

### 2. Luz
- La luz va delante de la cara, nunca detrás. Sentarse mirando a la ventana, con el móvil entre la ventana y la persona.
- Nunca con una ventana o lámpara detrás: la cara sale oscura y la cámara no lo arregla.
- Si no hay luz de día, dos lámparas de casa delante, una a cada lado, algo por encima de los ojos. Apagar la del techo si hace sombras bajo los ojos.
- Evitar luces de distinto color a la vez (una amarilla y una blanca): la piel sale rara.

### 3. Sonido
- Es más importante que la imagen. Un vídeo con imagen regular y buen sonido se ve entero; al revés, no.
- Habitación pequeña con cortinas, cama o sofá: absorbe el eco. Evitar cocinas, baños y pasillos vacíos.
- Cerrar ventanas, apagar frigorífico si zumba, avisar en casa.
- Móvil a menos de un metro de la boca. Si está más lejos, usar auriculares con cable con micrófono, con el cable escondido bajo la camiseta. Los inalámbricos suelen sonar peor para esto.
- Toma de prueba de 10 segundos, escuchar con auriculares. Si hay eco o ruido, cambiar de sitio antes de seguir.

### 4. Encuadre
- Móvil a la altura de los ojos. Ni desde abajo (papada, techo) ni desde arriba (mirada infantil).
- Cabeza y hombros. Un poco de aire por encima de la cabeza, no medio encuadre de pared.
- Mirar a la lente, no a la pantalla. Un truco: pegar una pegatina pequeña al lado de la lente.
- Fondo limpio y sin cosas que distraigan: pared lisa, estantería ordenada, planta. Nada de camas deshechas ni ropa colgada.
- Ropa lisa, sin rayas finas (hacen efecto raro en cámara) ni logos de marcas.

### 5. Grabar
- Grabar el guion por bloques (gancho, prueba, encaje, cierre), no del tirón. Cada bloque tres tomas. Luego se elige la mejor de cada uno y se juntan al editar.
- Dejar dos segundos en silencio antes de empezar a hablar y dos al terminar. Facilita cortar.
- Si se falla una frase: no parar la grabación. Pausa, respirar, repetir la frase desde el principio. Se corta después.
- Sonreír un poco al empezar y al acabar. La primera y la última imagen son las que se recuerdan.
- Hablar algo más despacio de lo que parece natural. En cámara todo el mundo va rápido.

### 6. Revisar antes de dar por buena una toma
Ver la toma con auriculares y comprobar:
- Se entiende cada palabra.
- Los ojos miran a la cámara casi todo el tiempo.
- No hay ruido de fondo, cortes ni coches.
- La cara está bien iluminada y el fondo no distrae.
- La toma dura lo que decía el guion. Si dura el doble, se está improvisando: volver al guion.

## Qué devolver
Cuando el usuario diga que va a grabar, dale la lista de comprobación anterior resumida en 10 líneas para que la tenga en el móvil mientras graba. Cuando diga que ya tiene las tomas, pásale a la edición (prompt "Plan de edición del vídeo currículum en CapCut" o subagente `revisor-videocv` si quiere opinión primero).

## Qué NO hacer
- No recomendar comprar micrófono, aro de luz ni trípode antes de haber probado con lo que hay en casa. Casi siempre sobra con ventana, libros y auriculares.
- No usar el zoom del móvil: pierde calidad. Acercar el móvil, no hacer zoom.
- No usar filtros de belleza ni modo retrato para esto: desenfocan orejas y pelo y queda artificial.
- No grabar en un sitio público ni con personas reconocibles detrás sin su permiso.
- No grabar en horizontal si va a TikTok o Instagram, ni en vertical si va a un correo o a un portal de empleo. Cambiar después implica recortar y perder imagen.
- No dar la toma por buena sin haberla escuchado con auriculares. En el altavoz del móvil no se oye el eco.
