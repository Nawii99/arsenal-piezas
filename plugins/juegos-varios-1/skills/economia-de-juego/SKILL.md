---
name: economia-de-juego
description: Designs and balances a game economy: currencies, faucets and sinks, progression curve, reward pacing, shop pricing and optional monetisation, with a spreadsheet model to simulate it. Use when a game has coins, upgrades, shops or progression that feels too fast, too grindy or broken.
---

# Diseñar la economía de tu juego

## Qué hace
Define de dónde sale el dinero del juego, a dónde va, cuánto tarda el jugador en progresar y cómo se monetiza sin ser abusivo, con números que puedes simular antes de programarlo.

## Cuándo se activa
Cuando el usuario habla de monedas, oro, gemas, mejoras, tienda dentro del juego, progresión, farmeo, pase de batalla o cuando dice que su juego 'se hace pesado' o 'se acaba enseguida'.

## Qué preguntar
1. ¿Cómo se gana dinero de verdad: venta única, gratis con anuncios, gratis con compras, sin monetizar?
2. ¿Cuánto dura una partida y cuántas sesiones al día esperas?
3. ¿Qué hace el jugador con los recursos: mejorar, desbloquear, personalizar?
4. ¿Hay competición entre jugadores? Si la hay, vender ventaja rompe el juego.
5. ¿Cuál es el momento en el que quieres que el jugador sienta que ha progresado de verdad?

## Los conceptos que hay que manejar
- **Grifos**: todo lo que mete recursos (recompensa de nivel, botín, misiones diarias, anuncio visto).
- **Sumideros**: todo lo que los saca (compras, mejoras, reparaciones, consumibles). Sin sumideros suficientes, el jugador se sienta sobre una montaña de oro y pierde el interés.
- **Moneda blanda**: se gana jugando, abundante, para el día a día.
- **Moneda dura**: escasa, se compra o se da con cuentagotas, para lo aspiracional. Nunca mezcles las dos en el mismo sumidero salvo con conversión clara.
- **Curva de progreso**: el coste de cada mejora sube de forma geométrica (por ejemplo, coste siguiente = coste anterior por 1,15) y la ganancia sube de forma parecida pero un poco más lenta; ese hueco es lo que crea el ritmo.
- **Tiempo hasta**: el número que de verdad importa es cuántos minutos de juego cuesta cada cosa, no cuántas monedas.

## Método paso a paso
1. Lista todas las cosas que el jugador puede querer, ordenadas por deseo.
2. Asigna a cada una un 'tiempo hasta' objetivo: la primera mejora en el minuto 2, la primera grande en la sesión 1, la aspiracional en la semana 2.
3. Calcula la ganancia por minuto de cada grifo y ajusta los precios para que cuadren con esos tiempos.
4. Monta la hoja de cálculo: una fila por nivel de progreso, columnas de ganancia acumulada, coste de la siguiente mejora, tiempo estimado. Mira la columna de tiempo: si crece de golpe, ahí es donde la gente abandona.
5. Añade sumideros de sobra para los jugadores más avanzados: cosméticos, mejoras infinitas con coste creciente, apuestas de riesgo.
6. Define la monetización opcional: comodidad y personalización sí, ventaja competitiva no. Ahorro de tiempo, pases de contenido, aspectos.
7. Pon topes: límite de gasto que tiene sentido, nada de cajas aleatorias opacas, probabilidades visibles si hay azar.
8. Prueba con jugadores reales y mide dónde se detiene la progresión.

## Señales de que la economía está rota
- El jugador acumula recursos que no gasta: faltan sumideros.
- Nadie llega al contenido del final: la curva sube demasiado.
- Todo se desbloquea en dos horas: falta profundidad, no precio.
- Una estrategia da mucho más que las demás: hay un exploit.
- Los jugadores hablan de 'muro de pago': has puesto un sumidero obligatorio en el sitio equivocado.

## Errores típicos
- Poner los precios a ojo y ajustar solo cuando ya está programado.
- Inflar recompensas para que el jugador se sienta bien y romper la escala tres horas después.
- Añadir una segunda moneda sin necesidad; complica sin aportar.
- Copiar la economía de un juego enorme con equipos de analistas y miles de jugadores.
- Diseñar para el jugador que juega 8 horas al día e ignorar al que juega 20 minutos.

## Formato de la respuesta
1. Mapa de la economía: lista de grifos y sumideros con su valor por minuto.
2. Tabla de progresión con niveles, costes, ganancia y tiempo estimado.
3. Fórmulas exactas de las curvas, listas para copiar en la hoja de cálculo o en el código.
4. Propuesta de monetización con lo que se vende y lo que nunca se vende.
5. Lista de métricas a vigilar cuando esté en manos de jugadores.
6. Riesgos de equilibrio y qué palanca tocar primero si algo falla.

## Avisos honestos
- Ninguna hoja de cálculo sustituye a ver jugar a gente: los números te dan el punto de partida, no la respuesta.
- Las mecánicas de azar de pago están reguladas de forma distinta según el país y hay restricciones para menores; infórmate antes de incluirlas.
- No prometo ingresos. La economía bien hecha evita que espantes jugadores; vender depende de muchas más cosas.
