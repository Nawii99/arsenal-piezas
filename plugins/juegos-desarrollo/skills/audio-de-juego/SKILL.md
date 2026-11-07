---
name: audio-de-juego
description: "Planifica y produce el diseño de sonido de un juego pequeño con herramientas de IA y grabación casera: lista de sonidos, bucles de música sin cortes, capas, nomenclatura, objetivos de volumen y ajustes de importación al motor. Úsala cuando un juego no tenga audio, suene amateur, tenga bucles de música con chasquidos o efectos con volúmenes muy desiguales."
---

# El sonido de tu juego, sin ser técnico de audio

## Qué hace
Te da la lista de sonidos que necesita tu juego, cómo conseguirlos, cómo dejarlos a un volumen coherente y cómo montar bucles de música que no se noten.

## Cuándo se activa
Cuando el usuario habla de música, efectos, SFX, ambiente, bucles, volumen o dice que su juego suena raro o vacío.

## Qué preguntar si falta información
1. ¿Qué género y qué tono: tenso, alegre, retro, realista?
2. ¿Cuántas acciones distintas hace el jugador?
3. ¿Motor y si tienes middleware (casi seguro que no, y no lo necesitas al principio).
4. ¿Vas a monetizar? (cambia las licencias que puedes usar)

## La lista mínima que necesita cualquier juego
1. Sonido de interfaz: pasar por encima de un botón, pulsar, atrás, error.
2. Acción principal del jugador (saltar, disparar, golpear), con 3-4 variaciones para que no canse.
3. Retroalimentación de impacto: dar y recibir.
4. Recompensa: moneda, subida de nivel, logro.
5. Ambiente en bucle por escena (viento, taberna, ciudad).
6. Música: menú, juego, tensión, victoria/derrota.
7. Transiciones: entrar y salir de menú, pausa.
Sin los cuatro primeros el juego se siente muerto por mucha música que le pongas.

## Método paso a paso
1. **Haz el inventario de eventos**: una fila por cada cosa que ocurre en pantalla y podría sonar. Marca cuáles suenan muchas veces por minuto: esos necesitan variaciones.
2. **Consigue el material**: bancos con licencia clara (comprueba siempre uso comercial), generadores por IA a partir de descripción, o grábalo tú. El móvil en una habitación con cortinas graba mejor de lo que te imaginas.
3. **Grabación casera**: acércate a 15-20 cm, grábalo 5 veces y quédate con la mejor toma, evita habitaciones vacías con eco. Un puñetazo es una toalla golpeada; unos pasos en nieve son almidón de maíz en una bolsa.
4. **Capas**: un buen efecto son 2 o 3 sonidos juntos. Un golpe = impacto grave (cuerpo) + chasquido agudo (ataque) + cola (reverberación). Un cofre = madera + metal + brillo.
5. **Recorta el silencio del principio**: un efecto que empieza 80 milisegundos tarde se siente lento aunque el jugador no sepa por qué. Corta hasta que el sonido empiece en el primer fotograma.
6. **Bucles sin clic**: en el editor (Audacity o similar), corta en cruce por cero, aplica un fundido de 5-10 milisegundos en los extremos y, en música, superpone la cola del final sobre el principio. Comprueba reproduciendo el bucle diez veces seguidas.
7. **Volúmenes coherentes**: normaliza todos los efectos a un pico de -3 dB y luego ajusta a oído en el motor. La música ambiente de fondo debe quedar entre 8 y 12 dB por debajo de los efectos importantes.
8. **Nivel general**: si vas a hacer tráiler, deja la mezcla final alrededor de -16 LUFS integrados para plataformas de vídeo, con picos por debajo de -1 dBTP para que no distorsione al comprimir.
9. **Formatos**: efectos cortos sin comprimir (WAV) y descomprimidos en memoria; música y ambientes largos en OGG o MP3 con carga en streaming. Esto ahorra memoria y evita tirones.
10. **Nombres**: SFX_UI_Click_01.wav, SFX_Player_Jump_02.wav, MUS_Menu_Loop.ogg, AMB_Bosque_Loop.ogg. Los números de dos dígitos te permiten elegir variación al azar.
11. **En el motor**: agrupa en buses (Música, Efectos, Interfaz, Ambiente) desde el primer día, y da al jugador tres deslizadores de volumen. Es lo primero que busca un jugador con la casa en silencio.
12. **Variación**: cada vez que suene un efecto repetitivo, elige uno de sus 3-4 archivos y varía el tono un poco (por ejemplo entre 0,95 y 1,05). Esto solo ya elimina la sensación de robot.

## Errores típicos
- Poner música épica y ningún efecto de interfaz: el juego sigue sintiéndose muerto.
- Un solo archivo para el paso del personaje: a los dos minutos taladra.
- Efectos grabados a distinto volumen y ajustados uno a uno sin referencia: cada escena suena distinta.
- Bucles de música con un silencio de medio segundo al final del archivo: se oye el bache en cada vuelta.
- Sonido en estéreo para efectos que van posicionados en el mundo 3D: hay que exportarlos en mono para que el motor los coloque.
- Usar música con licencia que da problemas cuando un streamer juega tu juego.

## Formato exacto de la respuesta
1. **Tabla de eventos sonoros** con prioridad, número de variaciones y tipo.
2. **Cómo conseguir cada sonido**: fuente recomendada y, si aplica, descripción exacta para el generador por IA.
3. **Recetas de capas** para los 5 efectos más importantes.
4. **Guía de bucle** paso a paso en el editor.
5. **Tabla de niveles**: qué volumen relativo lleva cada grupo.
6. **Convención de nombres** y estructura de carpetas.
7. **Ajustes de importación** en su motor.

## Avisos honestos
- Comprueba siempre la licencia comercial de lo que descargues o generes; en audio es donde más reclamaciones aparecen.
- Los valores de LUFS y dB son referencias del oficio para que no te pases; el oído manda y hay que escuchar en altavoces normales y en auriculares baratos.
- El audio es de las cosas que más mejoran la percepción del juego por hora invertida: si vas justo de tiempo, prioriza interfaz e impacto sobre música.
