# Guía de estilo visual para que todo encaje…

**Tipo:** Prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Define las reglas de arte de tu proyecto (paleta, formas, materiales, luz, escala) para que modelos hechos en momentos distintos parezcan del mismo mundo.

## Qué es y qué hace

Prompt que actúa como director de arte de videojuegos. Recibe proyecto, cámara y referencias visuales; devuelve reglas concretas de paleta, formas, materiales, luz y escala que puede seguir cualquier artista o IA generadora de imágenes para que todo parezca del mismo mundo. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tus referencias
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Comparte la guía con tu equipo o artistas

## Cuándo usarla

Cuando tu juego o tu escena parezca un batiburrillo: modelos que no pegan entre sí, colores desiguales, o cuando vayas a encargar arte a otra persona.

## Cómo ganar dinero con ella

Un aspecto coherente es lo que hace que un proyecto parezca profesional y se pueda vender o cobrar más, y evita rehacer assets que no pegan.

- Guía de estilo visual para juegos y escenas 3D…
- Documento de arte para encargar assets a terceros…
- Revisión de coherencia visual de un proyecto…

**Precio orientativo:** 200–600 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como director de arte de videojuegos. Tu trabajo es convertir un gusto difuso en reglas concretas que cualquiera pueda seguir, incluida una persona sin formación artística o una IA generadora de imágenes.

CONTEXTO
Proyecto: [NOMBRE, GÉNERO, PLATAFORMA].
Cámara y perspectiva: [PRIMERA PERSONA / TERCERA / ISOMÉTRICA / LATERAL 2.5D / CENITAL].
Referencias visuales que me gustan: [3-6, DICIENDO QUÉ ME GUSTA EXACTAMENTE DE CADA UNA].
Referencias que NO quiero parecerme: [1-3 Y POR QUÉ].
Sensación que busco: [EJ: ACOGEDOR Y NOSTÁLGICO, O SUCIO Y OPRESIVO].
Ambientación y época: [DESCRÍBELA].
Mis limitaciones: [SOY UNA PERSONA, NO SÉ DIBUJAR, USO ASSETS COMPRADOS, MÓVIL DE GAMA BAJA].
Qué tengo ya hecho: [DESCRIBE LOS ASSETS EXISTENTES].

LO QUE TIENES QUE PRODUCIR
1. DECLARACIÓN DE ESTILO en tres frases: qué se ve, qué se siente y qué NO es. La tercera parte es la más útil.
2. PALETA. Entre 6 y 10 colores con su código hexadecimal y su papel asignado: dominantes del entorno, materiales, acentos de interacción (lo que el jugador puede usar), peligro, y colores prohibidos. Regla de reparto aproximado de superficie. Explica cómo garantizo que el jugador distinga lo interactivo del decorado sin depender solo del color, por accesibilidad.
3. LENGUAJE DE FORMAS. Qué formas dominan (redondeadas, angulosas, verticales), qué silueta tiene cada familia de objetos, y la regla de legibilidad: un objeto debe reconocerse por su sombra negra recortada. Da la regla de proporción de personajes y de escala del mundo en metros, con las alturas de referencia (persona, puerta, mesa, escalón, pasillo) para que nada quede raro.
4. MATERIALES Y ACABADO. Nivel de detalle en las texturas, si hay desgaste y dónde, si el borde de las cosas está achaflanado, brillo y rugosidad típicos por familia de material, y qué resolución de textura usar según el tamaño del objeto en pantalla.
5. LUZ Y ATMÓSFERA. Esquema de luz principal, hora del día, temperatura de color, contraste, presencia de niebla o polvo, y cómo la luz guía la mirada del jugador hacia donde debe ir.
6. INTERFAZ. Tipografía (una o dos familias), tamaños mínimos legibles en pantalla pequeña, iconografía, y cómo se integra con el estilo del mundo.
7. FICHA DE REGLAS DE UNA PÁGINA que pueda pegar en la pared, con los sí y los no en dos columnas.
8. PROMPT BASE PARA GENERAR CONCEPT ART con IA, con las palabras exactas de estilo, encuadre, luz y paleta, más tres variaciones para distintos tipos de escena y la lista de términos a excluir.
9. PRUEBA DE COHERENCIA: cómo comprobar si un asset nuevo encaja. Por ejemplo, ponerlo junto a tres existentes, mirar la silueta en negro, mirar la miniatura pequeña, comprobar la escala junto al personaje y comprobar que sus colores están en la paleta.

RESTRICCIONES
Nada de vaguedades tipo «estilo estilizado y bonito»: cada regla debe poder comprobarse mirando.
Ten en cuenta mis limitaciones: no propongas un estilo que exija texturas pintadas a mano si no sé pintar.
Un estilo con menos detalle bien ejecutado gana siempre a uno realista mal ejecutado: dímelo si es mi caso.

FORMATO
A) DECLARACIÓN DE ESTILO.
B) PALETA (tabla: color, hexadecimal, uso, porcentaje aproximado).
C) FORMAS, SILUETAS Y ESCALA (con tabla de alturas de referencia).
D) MATERIALES.
E) LUZ Y ATMÓSFERA.
F) INTERFAZ.
G) FICHA DE UNA PÁGINA: SÍ / NO.
H) PROMPTS DE CONCEPT ART.
I) PRUEBA DE COHERENCIA en checklist.

CALIDAD
La guía está bien si otra persona puede hacer un objeto nuevo sin preguntarme nada y encaja.
Está bien si al mirar una captura en miniatura el proyecto se reconoce.
Está mal si las reglas se pueden aplicar a cualquier juego: eso significa que no has elegido nada.
```
