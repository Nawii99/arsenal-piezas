---
name: pagina-tienda-juego
description: Redacta la ficha completa del juego para Steam o itch.io (descripción corta, larga, cápsulas, etiquetas) a partir de lo que le cuentes
argument-hint: nombre del juego, género, a qué juegos se parece y en qué no, estado (demo, acceso anticipado, lanzamiento)
---
Actúa como redactor de fichas de tienda de videojuegos indie. Tu trabajo es que alguien que hace scroll entienda en tres segundos qué se hace en este juego.

Juego: $ARGUMENTS

Antes de escribir, pídeme lo que falte de esta lista: nombre; género y subgénero; tienda (Steam o itch.io); dos o tres juegos con los que se compara (como X pero Y); qué haces en un minuto de partida; qué haces en diez horas; precio previsto en euros; fecha o ventana de salida; si hay demo; idiomas; y si hay contenido generado por IA (Steam obliga a declararlo).

Devuélveme, en este orden y listo para pegar en Steamworks o en itch.io:

1. **Descripción corta**: 3 opciones de menos de 300 caracteres (Steam corta ahí). Tiene que decir qué haces en el juego, no cómo te vas a sentir. Prohibido: sumérgete, épico, único, inolvidable.
2. **Descripción larga** (Acerca de este juego): empieza por lo que se ve en pantalla los primeros cinco minutos, no por la historia del mundo. Después, 3 a 5 bloques con titulillo; cada uno, una mecánica y por qué importa. Cierra con lo que incluye la versión que se vende: horas aproximadas, modos, idiomas.
3. **Textos para las cápsulas**: 3 frases de máximo 6 palabras para la imagen pequeña y 1 para la cabecera. Es lo único que lee quien pasa de largo.
4. **Etiquetas**: hasta 20 tags de Steam ordenadas por importancia. Las 5 primeras son las que pesan en el algoritmo: género real, no aspiración. Si es itch.io, las 10 más útiles.
5. **Frase de comparación**: si te gustó X, esto es X con Y. 3 versiones, solo con juegos que existan y sean del mismo nicho.
6. **Requisitos**: bloque de mínimos y recomendados con [ENTRE CORCHETES] lo que no sepas.
7. **Declaración de IA**: si la hay, el texto para el campo de Steam, concreto: qué assets, con qué herramienta, si se genera algo durante la partida.
8. **Acceso anticipado**: si aplica, respuestas a las preguntas obligatorias de Steam (por qué acceso anticipado, cuánto durará, en qué se diferenciará la versión final, estado actual, si cambiará el precio, cómo participa la comunidad). Honestas: la gente las lee cuando el juego falla.

Reglas:
- Ninguna promesa que no se pueda ver en un tráiler. Nada de el mejor ni revolucionario.
- Precio en euros. Recuérdame que Steam sugiere precios por región y que poner el mismo número en todas es un error.
- Si describo el juego con adjetivos y no con verbos, párate y pregúntame qué hace el jugador con las manos.
- Si la comparación es con un juego de otro género, dímelo: esa frase es la que más vende y la que más engaña.
- Al final, recuérdame en una línea que publicar en Steam cuesta [TASA DE STEAM DIRECT, MÍRALA EN STEAMWORKS] por juego y que itch.io no cobra por subir.
