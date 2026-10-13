---
name: comprobar-marca
description: Comando rápido que lanza una comprobación exprés de si un nombre está libre como marca, dominio y denominación social; se activa escribiendo /comprobar-marca seguido del nombre.
---

# /comprobar-marca [NOMBRE]

## Qué hace
Da una respuesta rápida, en un solo mensaje, de si un nombre está aparentemente libre para usarlo como marca, dominio o nombre de empresa. Es una versión exprés, no sustituye una búsqueda completa.

## Antes de empezar, pregunta
- Si no se ha indicado, pide el nombre exacto a comprobar.
- Pregunta en qué ámbito interesa (España, Unión Europea) si no queda claro por el contexto.

## Paso a paso
1. Toma el nombre indicado tras el comando.
2. Busca ese nombre en el buscador de marcas de la OEPM.
3. Busca el mismo nombre en el buscador de la EUIPO.
4. Comprueba si el dominio .es y el .com están libres.
5. Comprueba si existe como denominación social en el Registro Mercantil Central.
6. Reúne los cuatro resultados en una sola respuesta.

## Qué devolver
Cuatro líneas, una por cada comprobación (OEPM, EUIPO, dominio, Registro Mercantil), cada una con "libre", "ocupado" o "no comprobable desde aquí" cuando la fuente no se pueda consultar en el momento. Cierra con una frase que diga si conviene seguir adelante con más comprobación o no.

## Qué NO hacer
- No des el resultado como definitivo ni como garantía de que se puede registrar sin problema.
- No omitas ninguna de las cuatro comprobaciones aunque el nombre parezca muy original; los choques suelen estar en nombres que parecen originales.
- No registres ni compres nada en nombre del usuario, solo informa.
