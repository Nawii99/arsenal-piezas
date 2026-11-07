---
name: blockout-de-nivel
description: "Diseña el blockout en caja gris de un nivel antes del arte: métricas a escala humana, distribución, líneas de visión, puntos de referencia, ritmo, coberturas y legibilidad, además de cómo probarlo. Úsala antes de modelar el arte del escenario, o cuando un nivel resulte confuso, vacío o mal escalado."
---

# Blockout: diseñar el nivel en cajas grises

## Qué hace
Define el nivel con formas grises y medidas reales para probar el recorrido y el ritmo antes de meter una sola textura.

## Cuándo se activa
Cuando el usuario va a construir un escenario, un mapa, una sala o un nivel, o dice que su nivel se siente vacío, laberíntico o desproporcionado.

## Qué preguntar
1. ¿Qué hace el jugador aquí? Un verbo principal: explorar, esconderse, disparar, saltar, conversar.
2. ¿Cuánto quieres que dure el nivel?
3. ¿Vista en primera persona, tercera, cenital, lateral 2D? Cambia las medidas de todo.
4. ¿Cuáles son las capacidades del personaje: altura de salto, longitud de salto, velocidad, si trepa?
5. ¿Qué debe aprender el jugador en este nivel y qué ya sabe?

## Medidas de referencia (escala humana en metros)
- Personaje adulto: 1,8 m de alto, 0,6 m de ancho.
- Puerta: 1,0 x 2,2 m. Pasillo cómodo: 2 m. Pasillo agobiante a propósito: 1,2 m.
- Altura de techo interior: 3 m; una sala que quiera imponer, 6 m o más.
- Cobertura a media altura: 1,2 m. Cobertura completa: 2 m.
- Escalón cómodo: 0,2 m; rampa suave: menos de 30 grados.
- Todo se construye sobre una rejilla, normalmente de 0,5 m o 1 m: si no, luego el arte modular no encaja.
Ajusta estas medidas a las capacidades reales del personaje midiendo en el motor: cuánto salta y cuánto avanza saltando son los dos números que mandan.

## Método paso a paso
1. **Dibuja el plano en papel** primero: entrada, salida, tres o cuatro espacios principales y el camino que los une.
2. **Define el recorrido**: lineal, en bucle, en abanico. El bucle que devuelve al jugador a un sitio conocido es lo que más sensación de dominio da.
3. **Pon un punto de referencia visible**: una torre, una grúa, una luz, algo alto que se vea desde varios puntos y oriente sin mapa.
4. **Construye en gris** con cajas y colores planos: un color para suelo transitable, otro para muros, otro para lo interactivo, otro para lo mortal. Nada de texturas.
5. **Marca el ritmo**: alterna tensión y descanso. Un patrón que funciona es introducción tranquila, reto, respiro con recompensa, reto mayor, clímax, salida.
6. **Trabaja las líneas de visión**: desde cada entrada de sala, el jugador tiene que ver lo suficiente para decidir sin verlo todo. Prueba a ponerte en cada puerta y mirar.
7. **Guía sin carteles**: luz, contraste, líneas del suelo, movimiento y huecos abiertos llevan la mirada mejor que una flecha.
8. **Comprueba la navegación**: recorre el nivel a la velocidad real del juego, con cronómetro. Si tardas 40 segundos andando sin que pase nada, sobra distancia.
9. **Marca los espacios reservados**: dónde irán enemigos, objetos, sonido, y qué zonas son solo decorado.
10. **Prueba con alguien más** antes de tocar el arte. Si se pierde en gris, se perderá también con texturas bonitas.

## Cómo saber si el blockout está bien
- Un jugador nuevo llega al final sin instrucciones.
- Puede describir el nivel de memoria con tres formas.
- No hay callejones sin sentido ni geometría en la que uno se atasca.
- El tiempo real de recorrido se parece al objetivo.
- Puedes decir en una frase qué pasa en cada sala.

## Errores típicos
- Empezar por el arte y descubrir que la sala es demasiado grande cuando ya está terminada.
- Hacer todo a la misma altura: la variación vertical es lo que da personalidad.
- Salas del mismo tamaño una detrás de otra: el ritmo se aplana.
- Escalar a ojo sin una figura de referencia del personaje en la escena.
- No construir sobre rejilla y tener que rehacer el modular después.
- Iluminar el blockout de forma bonita y confundir eso con que el diseño funciona.

## Formato de la respuesta
1. Objetivo del nivel en una frase y verbo principal.
2. Plano descrito sala por sala con medidas en metros.
3. Mapa del recorrido y del ritmo, indicando tensión y descanso.
4. Lista de puntos de referencia y de guías visuales.
5. Lista de comprobaciones para hacer dentro del motor.
6. Qué queda pendiente para la fase de arte y qué no se debe tocar todavía.

## Avisos honestos
- El blockout no se hace una vez: se rehace tres o cuatro veces, y eso es señal de que va bien.
- Un nivel bonito con mal recorrido se siente peor que un nivel gris con buen recorrido.
- Si no puedes probarlo dentro del motor con el personaje real, las medidas son solo una hipótesis.
