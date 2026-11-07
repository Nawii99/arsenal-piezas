---
name: metricas-de-tu-juego
description: Define los eventos de analítica, los embudos y las métricas de retención que un juego pequeño necesita de verdad, cómo nombrarlos e implementarlos y cómo convertir las cifras en decisiones. Úsala cuando un juego esté publicado o en pruebas y necesites saber dónde abandonan los jugadores y qué arreglar primero.
---

# Qué medir en tu juego y cómo leerlo

## Qué hace
Te da una lista corta de eventos que sí sirven, cómo nombrarlos, cómo montar el embudo y qué decisión tomar con cada número.

## Cuándo se activa
Cuando el usuario tiene el juego publicado o en pruebas y habla de retención, abandono, analítica, embudo, eventos o de que 'la gente lo descarga pero no juega'.

## Qué preguntar
1. ¿Dónde está publicado y cuántos jugadores nuevos entran al día, aunque sean pocos?
2. ¿Tienes ya alguna herramienta de analítica instalada?
3. ¿Qué decisión concreta quieres tomar con los datos? Sin decisión, no midas.
4. ¿El juego tiene tutorial, niveles, tienda?
5. ¿Es para menores? Cambia lo que puedes recoger.

## Las pocas métricas que importan de verdad
- **Retención D1 y D7**: porcentaje de jugadores nuevos que vuelven al día siguiente y a los siete días. Es el mejor indicador de si el juego engancha.
- **Embudo de arranque**: cuántos abren, cuántos empiezan la partida, cuántos terminan el tutorial, cuántos llegan al nivel 2. Cada escalón perdido es un problema concreto.
- **Duración de sesión y sesiones por día**.
- **Punto de abandono por nivel**: en qué nivel exacto deja de aparecer la gente.
- **Tasa de sesiones sin fallos**: si el juego peta, todo lo demás sobra.
- Si hay compras: porcentaje de jugadores que compran alguna vez y qué compran primero.

## Cómo se implementa
1. Elige herramienta gratuita: GameAnalytics es específica de juegos; PostHog o similares valen para juegos web. Evita montar tu propio sistema al principio.
2. Define un diccionario de eventos ANTES de programar: nombre, cuándo se dispara, propiedades. Nombres en minúsculas con guion bajo y jerarquía: `tutorial_paso_completado`, con propiedad `paso`.
3. No más de 15-20 eventos al principio. Más eventos no es más información, es más ruido.
4. Incluye siempre la versión del juego y la plataforma como propiedad: sin eso no puedes comparar antes y después de un parche.
5. Dispara el evento en el momento exacto, no al cargar la escena siguiente.
6. Prueba los eventos en una build de pruebas y comprueba que llegan y con qué valores. Un evento mal puesto contamina meses de datos.
7. Nada de datos personales: ni nombres, ni correos, ni identificadores que permitan reconocer a alguien. Si hay menores o público europeo, revisa el consentimiento y la política de privacidad.

## Cómo leer los números
- Mira siempre por cohorte de fecha de instalación, no el total acumulado.
- Con pocos jugadores, los porcentajes bailan mucho; no tomes decisiones con veinte personas.
- Compara solo una cosa cada vez: si cambias tutorial y precios a la vez, no sabrás qué funcionó.
- Los datos dicen dónde, no por qué. Cuando encuentres el escalón que falla, ve a ver jugar a alguien ahí.
- Regla práctica: primero arregla lo que rompe (fallos), luego lo que bloquea (embudo del primer día), luego lo que retiene (día 7), y solo después lo que monetiza.

## Errores típicos
- Medir cincuenta cosas y no mirar ninguna.
- Celebrar descargas: es la métrica más bonita y menos útil.
- Cambiar el nombre de un evento y perder la comparación histórica.
- Mirar medias en vez de distribuciones: la media de duración la desplaza un jugador que dejó el juego abierto toda la noche.
- Recoger datos sin avisar en la política de privacidad.

## Formato de la respuesta
1. Decisión que se quiere tomar y métricas que la responden.
2. Diccionario de eventos en tabla: nombre, cuándo, propiedades, para qué sirve.
3. Definición del embudo paso a paso.
4. Panel mínimo: qué gráficos mirar y con qué frecuencia.
5. Reglas de interpretación y umbrales de alerta.
6. Nota de privacidad y qué añadir a la política.

## Avisos honestos
- No doy cifras de referencia del sector como si fueran verdad: tus números buenos o malos se juzgan contra tus propias versiones anteriores.
- Con muy pocos jugadores, mirar a cinco personas jugar te dará más que cualquier panel.
- La analítica no arregla un juego que no gusta; solo te dice dónde duele.
