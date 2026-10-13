# Preparar tu juego para traducirlo a otros idiomas…

**Tipo:** Prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Organiza los textos de tu juego para traducirlos sin romper la interfaz: glosario, límites de longitud, contexto por frase y orden de idiomas por interés.

## Qué es y qué hace

Prompt para cualquier chat de IA que prepara los textos de un juego para traducirlos. Entra el tipo de juego, el motor y los idiomas; sale el orden de idiomas recomendado, glosario, límites de longitud por texto, contexto por frase y comprobaciones para que la interfaz no se rompa al traducir.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu juego, motor e idiomas
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Entrega la tabla resultante al traductor o a la IA

## Cuándo usarla

Úsalo antes de mandar a traducir tu juego o app 3D, o si vas a traducirlo con IA y quieres que no salgan frases sin sentido en el menú.

## Cómo ganar dinero con ella

Abrir tu juego a inglés y a un par de idiomas más multiplica el público al que puedes venderlo con un coste bajo.

- Preparación de textos para localización de juegos indie con glosario y límites…
- Gestión de traducción con revisión humana de menús y fichas de tienda…
- Auditoría de textos cortados y claves de traducción en un juego terminado…

**Precio orientativo:** 100–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como responsable de localización de videojuegos con experiencia en estudios pequeños. Has traducido juegos a varios idiomas con presupuestos mínimos y sabes qué provoca textos cortados, frases sin sentido y capturas ridículas en las tiendas.

CONTEXTO
Juego: [NOMBRE, GÉNERO Y TONO: serio, humorístico, infantil, oscuro]
Idioma original: [ESPAÑOL / INGLÉS / OTRO]
Cantidad de texto aproximada: [POCAS FRASES DE MENÚ / VARIOS MILES DE PALABRAS / DIÁLOGOS EXTENSOS]
Dónde aparece el texto: [MENÚS, BOTONES, TUTORIAL, DIÁLOGOS, OBJETOS, LOGROS, FICHA DE TIENDA, SUBTÍTULOS]
Motor: [UNITY / UNREAL / GODOT / RENPY / WEB / OTRO]
Idiomas que me planteo: [LISTA O 'ACONSÉJAME']
Presupuesto para traducción: [NADA, LO HAGO CON IA / ALGO PARA REVISIÓN HUMANA / TENGO PRESUPUESTO]
Plataformas donde vendo: [STEAM / ITCH / MÓVIL / CONSOLA]

LO QUE TIENES QUE HACER
1. Recomiéndame el orden de idiomas según el tipo de juego y las plataformas, explicando el criterio (tamaño del mercado del género, coste de traducción, alfabeto que obliga a cambiar la fuente).
2. Dime cómo debe estar organizado el archivo de textos: qué columnas, qué es una clave, cómo se nombra y qué error hace que todo se rompa.
3. Construye el glosario del juego: términos propios que deben traducirse siempre igual o no traducirse nunca.
4. Dame las reglas de longitud: cuánto puede crecer un texto al traducirlo y qué hago con los botones.
5. Escribe el prompt exacto que debo usar para traducir con IA cada bloque, con el contexto que hay que darle.
6. Dame el plan de revisión con lo que tengo, y la lista de comprobación visual dentro del juego.

CONOCIMIENTO DEL OFICIO QUE DEBES APLICAR
Nunca se traduce una lista de frases sueltas sin contexto: la misma palabra corta puede ser un verbo o un sustantivo, y en otros idiomas cambia por completo. Cada frase necesita una nota de dónde aparece y quién la dice.
Crecimiento del texto: al traducir desde inglés, el alemán y el ruso pueden crecer bastante, el francés y el español también; el chino y el japonés se acortan. Deja margen en los botones o usa texto que se ajuste automáticamente.
Nunca partas una frase en trozos que se peguen luego: en otros idiomas el orden cambia. Usa una frase completa con un hueco variable, y explica qué va en ese hueco.
Cuidado con los plurales y con el género: 'Has conseguido 1 objetos' es el error más visible. Prevé formas separadas para singular y plural y evita construcciones que dependan del género en español si el original es inglés.
Fuentes tipográficas: comprueba que la fuente tiene acentos, eñes, caracteres alemanes, cirílico o caracteres asiáticos según los idiomas elegidos, o el texto saldrá con cuadrados.
Pseudolocalización: antes de traducir nada, sustituye todos los textos por versiones alargadas y con acentos raros y juega. Todo lo que se corte o desaparezca es un fallo de interfaz que hay que arreglar antes de gastar en traducción.
Nombres propios, marcas y términos inventados del juego: decide de una vez si se traducen o no y anótalo en el glosario. Cambiar de criterio a mitad es lo que hace que un juego parezca chapucero.
Prioridad de traducción cuando hay poco dinero: primero la ficha de tienda y las capturas, luego los menús y el tutorial, y por último los diálogos. Una ficha bien traducida vende más que un juego entero traducido a medias con la ficha en español.
Traducción con IA: funciona razonablemente si le das el glosario, el tono, el límite de caracteres y el contexto de cada frase, y si la revisa una persona nativa aunque sea por encima. Sin eso, salen frases correctas pero fuera de tono.

RESTRICCIONES
No inventes datos de mercado con cifras: habla en términos de prioridad y criterio.
Todo lo que propongas tiene que poder hacerse en una hoja de cálculo normal.
Adáptalo a mi motor si te lo he dicho.

FORMATO DE LA RESPUESTA
A) ORDEN DE IDIOMAS RECOMENDADO con el motivo de cada uno y el coste relativo.
B) ESTRUCTURA DEL ARCHIVO DE TEXTOS: tabla con las columnas exactas y una fila de ejemplo rellena.
C) GLOSARIO inicial del juego a partir de lo que te he contado, con la columna 'no traducir'.
D) REGLAS DE LONGITUD Y DE INTERFAZ, en lista.
E) PROMPT DE TRADUCCIÓN listo para pegar, con los huecos que debo rellenar.
F) PLAN DE PSEUDOLOCALIZACIÓN: cómo hacerlo sin programar y qué buscar.
G) CHECKLIST DE REVISIÓN EN PANTALLA: 15 puntos que debo mirar jugando en cada idioma.
H) ERRORES CLÁSICOS aplicados a mi juego.

CRITERIOS DE CALIDAD
El sistema evita los tres fallos visibles: texto cortado, plurales mal y términos traducidos de dos formas distintas.
El plan es realista con mi presupuesto.
Puedo empezar hoy montando la hoja de textos con tus columnas.
```
