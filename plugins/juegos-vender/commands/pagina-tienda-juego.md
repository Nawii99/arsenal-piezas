---
name: pagina-tienda-juego
description: Genera el borrador de la página de tienda de un juego (itch.io o Steam) a partir de una descripción corta. Se activa con /pagina-tienda seguido de la descripción del juego y la tienda elegida.
---

# Qué hace

Toma lo que el usuario cuenta de su juego y devuelve todos los textos que pide la ficha de la tienda, más la lista de imágenes y vídeo que tiene que preparar y una lista de lo que aún falta para poder pulsar «publicar». Escribe en español de España salvo que el usuario pida otro idioma; si el juego se vende fuera, propone hacer también la versión en inglés.

# Qué preguntar antes de empezar

Si el usuario no lo ha dicho en el comando, pregunta esto en un solo mensaje:

1. Tienda: **itch.io** o **Steam**. Si duda, explica en dos líneas: itch.io es gratis, se publica en el día y se queda con el porcentaje que tú elijas (por defecto un 10 %). Steam cobra [100 USD] por juego para darlo de alta (se devuelve si el juego pasa de [1.000 USD] de ventas), se queda un 30 % y la ficha tarda días en ser revisada.
2. Género y a qué se parece: «es un roguelike tipo X con estética Y».
3. Qué hace el jugador durante los primeros cinco minutos. Esto es lo que vende, no la historia.
4. Duración aproximada y si tiene final.
5. Plataformas (Windows, Mac, Linux, navegador, Android).
6. Precio pensado en euros, o gratis, o «paga lo que quieras».
7. ¿Hay ya tráiler, capturas o GIF? Cuántos y de qué.

# Paso a paso

1. Extrae el gancho: una sola cosa que hace este juego que otros no. Si el usuario no la sabe, propón tres y que elija.
2. Escribe la **frase corta** (la que sale en listados y búsquedas). Máximo 120 caracteres en itch.io; en Steam el campo corto admite hasta 300, pero se lee mejor por debajo de 150. Verbo, qué haces, qué lo hace distinto.
3. Escribe la **descripción larga** con esta estructura y sin adjetivos vacíos:
   - Dos frases con el gancho.
   - Lista de 4 a 6 puntos de «qué vas a hacer» (mecánicas concretas, no promesas).
   - Un párrafo de tono y estética.
   - Datos prácticos: duración, plataformas, idiomas, mando o teclado.
   - Si es early access o demo, decirlo aquí y qué falta.
4. Propón las **etiquetas**: en itch.io hasta 10; en Steam hasta 20, y las cinco primeras son las que más pesan. Mezcla género, mecánica, estética y tema. Nada de etiquetas que no describan el juego para «llegar a más gente»: la tienda penaliza el rebote.
5. Lista las **imágenes** que hay que preparar, con medidas:
   - itch.io: portada [630x500] px, capturas sin límite fijo, admite GIF.
   - Steam: cápsula pequeña, cápsula principal, cabecera, imagen de biblioteca y fondo; las medidas exactas cambian y hay que mirarlas en la documentación de Steamworks del día. Mínimo 5 capturas a 1920x1080 y un tráiler.
   Para cada captura, di qué debe mostrarse: momento de juego real, con interfaz, sin pantallas de menú. La primera captura es la más vista.
6. Escribe el **guion del tráiler** en 30-60 segundos: los primeros 5 segundos ya son juego, nada de logos al principio.
7. Añade la sección de **créditos y licencias**: recuerda al usuario que si usa assets con CC-BY o fuentes de terceros, aquí va la atribución. Si tiene el archivo `LICENCIAS.md`, se pega.
8. Cierra con la **lista de lo que falta** antes de publicar.

# Qué devolver

Un solo documento Markdown con estos bloques, cada uno listo para copiar en el campo correspondiente de la tienda:

```
## Frase corta
## Descripción larga
## Etiquetas (en orden de importancia)
## Imágenes que preparar (una línea por imagen: qué muestra y medida)
## Guion del tráiler
## Créditos y licencias
## Falta antes de publicar
```

En «Falta antes de publicar» incluye siempre: build probada en cada plataforma marcada, precio puesto en euros con IVA incluido (las tiendas lo añaden ellas según el país del comprador, pero el usuario debe saber que en su panel verá el neto), datos fiscales rellenos en la tienda (Steam y itch.io piden formulario fiscal; un autónomo en España tendrá que declarar esos ingresos), y página de política de reembolsos o enlace a la de la tienda.

# Qué NO hacer

- No escribas «el mejor», «único», «increíble», «adictivo». Si el juego es bueno, se nota en los puntos concretos.
- No inventes características que el usuario no ha mencionado. Si la descripción se queda corta, pregunta.
- No metas etiquetas que no correspondan solo para aparecer en más búsquedas.
- No pongas medidas de imagen de Steam como si fueran fijas: di la última que conozcas y manda comprobar en Steamworks.
- No propongas un precio. Si el usuario no lo tiene, sugiere que mire tres juegos parecidos en la misma tienda y decida él.
- No escribas la ficha en inglés sin que se pida. Si se pide, haz las dos, no una mezcla.
