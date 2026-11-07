---
name: licencias-assets-skill
description: Lleva el registro de licencias de cada asset (arte, música, sonido, fuentes, código) del juego y dice si se puede vender con él dentro. Se activa al añadir un asset o antes de publicar en una tienda.
---
# Licencias de assets

## Qué hace
Cada vez que metes algo en el juego que no has hecho tú, apunta de dónde viene, con qué licencia y a qué te obliga. Al final tienes una tabla que responde en un minuto a dos preguntas: ¿puedo vender esto? y ¿a quién tengo que acreditar? Es lo que te va a pedir Steam, un publisher o un abogado. Reconstruirlo un año después es un infierno.

## Qué preguntar antes de empezar
1. ¿Dónde está el archivo de registro? Si no existe, créalo en `docs/LICENCIAS.md` con la tabla vacía y avisa.
2. Del asset nuevo: nombre, autor, URL exacta de donde se descargó, texto de la licencia tal como aparece en esa página, fecha y precio pagado si lo hubo.
3. ¿Se va a vender el juego? ¿Se va a modificar el asset? Cambia lo que se puede hacer.
4. ¿Lo ha generado una IA? Steam obliga a declararlo en la ficha de la tienda.

## Paso a paso
1. Clasifica la licencia en uno de estos grupos:
   - CC0 o dominio público: todo permitido, sin crédito obligatorio. Ejemplo: los packs de Kenney.
   - CC BY: uso comercial sí, crédito obligatorio con nombre del autor, título, enlace y licencia.
   - CC BY-SA: como BY, pero lo que derives debe llevar la misma licencia. Es un problema en un juego comercial: pregunta antes de usarlo.
   - Cualquier licencia con NC (no comercial): no se puede vender el juego con eso dentro. Fuera.
   - Fuentes SIL OFL: usarlas en el juego sí; vender la fuente suelta no.
   - Tiendas de assets (Unity Asset Store, Fab, itch.io, Humble Bundle): cada tienda tiene su licencia. Lo habitual es que puedas usarlo en tus productos, que no puedas redistribuir el asset suelto y que necesites una licencia por persona del equipo. Copia el enlace a los términos concretos.
   - Gratis sin licencia escrita: no es CC0. Sin texto de licencia no hay permiso. Marca como pendiente y no lo metas en la build de tienda.
2. Añade una fila a la tabla con estas columnas: archivo en el proyecto, autor, origen (URL), licencia, comercial sí/no, crédito obligatorio sí/no, modificable sí/no, coste en euros, fecha, generado por IA sí/no, nota.
3. Guarda una copia de la página de la licencia (PDF o captura) en `docs/licencias/`. Las páginas cambian y desaparecen, y lo que vale es lo que decía el día que lo descargaste.
4. Si el crédito es obligatorio, añade la línea a `CREDITOS.md` con el formato que pida el autor. Si no pide ninguno: Título - Autor - licencia - enlace.
5. Antes de publicar, haz la revisión: lista todo lo que esté en pendiente, NC o SA y di que no se publica hasta resolverlo.

## Qué devolver
- La fila nueva de la tabla, lista para pegar.
- Un veredicto en una línea: puedes venderlo / puedes venderlo si acreditas así: ... / no lo uses.
- Si el veredicto es no, dos o tres alternativas con licencia limpia en la misma categoría. Solo de sitios conocidos: Kenney, OpenGameArt filtrando por CC0, Freesound filtrando por CC0, Google Fonts. No inventes packs que no existen.

## Qué NO hacer
- No des por buena la licencia que pone alguien que ha resubido el asset a otro sitio. Busca la fuente original.
- No conviertas un no dice nada en un se puede. Solo se puede si lo dice.
- No des consejo legal. Si hay dinero serio, un publisher o un contrato de por medio, di que lo revise un abogado.
- No borres filas. Si dejas de usar un asset, márcalo como retirado con fecha. Puede seguir en builds antiguas que la gente ya tiene.
- No metas en un juego música con licencia para vídeos o para streaming. Son usos distintos y suelen estar excluidos.
- No aceptes un asset con licencia NC porque el juego sea gratis ahora. El día que cobres, aunque sea un euro, tienes que quitarlo.
