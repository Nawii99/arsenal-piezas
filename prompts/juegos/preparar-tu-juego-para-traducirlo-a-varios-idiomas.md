# Preparar tu juego para traducirlo a varios idiomas…

**Tipo:** Prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Te deja los textos listos para traducir sin romper la interfaz: claves, marcadores, límites de caracteres, glosario y control de calidad.

## Qué es y qué hace

Prompt para cualquier chat de IA que actúa como responsable de localización. Explica por qué los textos deben salir del código y diseña la tabla de traducción: claves, texto original, contexto, límite de caracteres y una columna por idioma, con convención de claves, marcadores y control de calidad.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con motor, idiomas y dónde están los textos
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Migra los textos a la tabla y envíala a traducir

## Cuándo usarla

Úsalo antes de mandar a traducir tu juego o app 3D, o cuando los textos estén metidos a pelo dentro del proyecto.

## Cómo ganar dinero con ella

Abre mercados enteros con poco coste y evita pagar dos veces la traducción por haberla encargado con los textos mal preparados.

- Preparación técnica de textos para localizar juegos y apps 3D…
- Migración de textos del código a tablas de traducción para indies…
- Control de calidad lingüístico de builds traducidas…

**Precio orientativo:** 100–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como responsable de localización de videojuegos: has preparado proyectos pequeños para traducirse a varios idiomas y sabes dónde se rompe todo.
MI JUEGO
Tipo y plataforma: [GÉNERO, PC / MÓVIL / WEB]. Motor: [UNITY / UNREAL / GODOT / OTRO]
Idioma original: [ESPAÑOL / INGLÉS]. Idiomas a los que quiero llegar: [LISTA]
Cantidad de texto aproximada: [PALABRAS O PANTALLAS]
Dónde están los textos ahora: [DENTRO DEL CÓDIGO / EN LA ESCENA / EN UN ARCHIVO / NO LO SÉ]
Quién traduce: [TRADUCTOR PROFESIONAL / IA + REVISIÓN / COMUNIDAD]
QUÉ TIENES QUE HACER, PASO A PASO
1. Explícame en llano por qué los textos tienen que salir del código y vivir en una tabla con claves, y qué pinta tiene esa tabla: clave, texto original, contexto, límite de caracteres, y una columna por idioma.
2. Dame la convención de claves con ejemplos de mi juego: agrupadas por pantalla, legibles, sin acentos ni espacios, estables aunque cambie el texto.
3. Explícame la regla de no trocear frases: por qué juntar dos mitades de frase con una variable en medio rompe otros idiomas, y cómo se escribe bien con marcadores nombrados.
4. Dame las reglas de plural y de género, con ejemplos de frases que fallan y su versión segura.
5. Dime cuánto se estira el texto al traducir y qué hacer con la interfaz: qué idiomas ocupan bastante más que el español, cómo poner límites de caracteres por campo, cuándo permitir dos líneas y cuándo reducir el tamaño de letra automáticamente.
6. Avísame de las fuentes tipográficas: caracteres que faltan y salen como cuadrados, alfabetos que necesitan otra fuente, y por qué hay que probar cada idioma con su fuente real antes de dar por bueno nada.
7. Ayúdame a escribir la columna de contexto, que es la que hace buena o mala una traducción: quién habla, tono, si es un botón o una frase de diálogo, qué pasa en pantalla, si la palabra es verbo o sustantivo.
8. Prepara el glosario del juego: nombres propios que no se traducen, términos de mecánicas que deben ser siempre iguales, tratamiento de tú o de usted, y cómo escribir los nombres de los botones de teclado y mando.
9. Dime qué NO se traduce y hay que marcar como bloqueado: claves internas, nombres de archivos, comandos, marcas.
10. Dame el control de calidad final: revisar en pantalla y no en la hoja, capturas de cada pantalla en cada idioma, buscar textos cortados, comillas y espacios raros, números y fechas, y una prueba de cambio de idioma en caliente.
11. Dame el flujo de trabajo si traduzco con IA: cómo pasarle el contexto y el glosario, cómo pedir que respete los marcadores y los límites, y por qué hace falta un hablante nativo repasando al menos la interfaz y la tienda.
RESTRICCIONES
No des porcentajes de expansión inventados con dos decimales: da rangos y di que hay que probar.
Adapta los ejemplos al género de mi juego.
No propongas herramientas de pago sin dar una alternativa gratuita.
FORMATO DE LA RESPUESTA
A. Estructura de la tabla de textos, con 5 filas de ejemplo rellenadas con frases de mi juego.
B. Reglas de escritura para textos traducibles, en lista corta.
C. Tabla de idiomas con sus riesgos: expansión, fuente, dirección de escritura, cosas a vigilar.
D. Glosario inicial con 15 términos de mi juego.
E. Instrucciones para el traductor o para la IA, listas para pegar.
F. Lista de comprobación final de 12 puntos.
CRITERIOS DE CALIDAD
Está bien si puedo enviar un solo archivo y recibir la traducción sin tener que tocar el proyecto.
Está mal si el traductor tiene que preguntarme el contexto de la mitad de las frases.
```
