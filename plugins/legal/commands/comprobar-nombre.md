---
name: comprobar-nombre
description: Comando rápido para lanzar una comprobación exprés de un nombre de marca, dominio y redes sociales, pensado para usarlo en el momento, por ejemplo en una llamada con un cliente potencial.
---

## Qué hace
Lanza en segundos una comprobación básica de un nombre: si hay marcas parecidas registradas en España, si el dominio principal está libre y si el usuario está libre en Instagram. Es la versión rápida, no el informe completo que se cobra como servicio.

## Uso
`/comprobar-nombre [NOMBRE]` — por ejemplo `/comprobar-nombre Ronda Café`.

## Qué preguntar antes de empezar
Nada más: si el usuario no dice el sector, asume que la comprobación es genérica y dilo en el resultado.

## Paso a paso
1. Busca el nombre tal cual en la base pública de marcas de la OEPM.
2. Comprueba el dominio .es y .com del nombre (sin espacios ni tildes).
3. Comprueba si el usuario está libre en Instagram.
4. Junta los tres resultados en una respuesta breve.

## Qué devolver
Tres líneas claras: marca (libre, ocupado o dudoso), dominio (libre u ocupado), redes (libre u ocupado). Cierra siempre con una frase: 'Esto es una comprobación rápida, no sustituye una búsqueda oficial.'

## Qué NO hacer
- No lo uses como el informe final que le entregas a un cliente que paga por el servicio completo: para eso usa la skill de comprobación completa.
- No digas 'está libre' sin la coletilla de que es una comprobación rápida.
- No compruebes clases de Niza ni la EUIPO aquí: eso es parte del informe completo, no del comando rápido.
