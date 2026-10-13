# Economía y progresión de tu juego…

**Tipo:** Prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Diseña las monedas, los precios internos, el ritmo de progreso y los puntos de venta de tu juego, con números concretos y una hoja de cálculo para ajustarlos.

## Qué es y qué hace

Prompt para cualquier chat de IA que actúa como diseñador de economía de videojuegos. Entran tu género, modelo de negocio, duración de sesión y recursos; salen el mapa de monedas, precios internos, ritmo de progreso y una tabla para ajustar los números en una hoja de cálculo. Ejemplo: calibrar un idle móvil gratis con compras.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu juego y modelo de negocio
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Pasa las tablas a una hoja de cálculo y pruébalas

## Cuándo usarla

Úsalo cuando tu juego tenga recursos, mejoras, tienda o compras dentro y no sepas cuánto debe costar cada cosa ni cada cuánto premiar al jugador.

## Cómo ganar dinero con ella

Una economía bien calibrada es lo que hace que un juego gratuito o con compras genere ingresos sin que la gente se sienta estafada.

- Consultoría de economía y progresión para estudios indie que lanzan un juego con compras…
- Revisión de balance de un juego móvil existente con informe y tabla de ajustes…
- Taller de diseño de economía para equipos pequeños de videojuegos…

**Precio orientativo:** 150–600 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como diseñador de sistemas y economía de videojuegos que ha calibrado juegos con progresión y tienda. Piensas en números, curvas y en la sensación del jugador a la vez, y tienes criterio ético: no diseñas trampas.

CONTEXTO
Mi juego: [NOMBRE, GÉNERO Y QUÉ HACE EL JUGADOR EN UNA PARTIDA]
Modelo de negocio: [GRATIS CON COMPRAS / PAGO ÚNICO CON CONTENIDO EXTRA / GRATIS CON ANUNCIOS / SUSCRIPCIÓN / AÚN NO LO SÉ]
Duración de una sesión típica: [MINUTOS]
Cuántas sesiones al día espero: [NÚMERO]
Qué puede conseguir el jugador: [LISTA DE RECURSOS, MEJORAS, PERSONAJES, SKINS, NIVELES]
Cuánto quiero que dure el juego: [HORAS O DÍAS HASTA 'terminarlo']
Plataforma: [MÓVIL / PC / CONSOLA / NAVEGADOR]
Tono: quiero una economía justa; no quiero pay-to-win ni presión abusiva.

LO QUE TIENES QUE HACER
1. Define el mapa de recursos: qué monedas o materiales existen, para qué sirve cada uno y por qué no sobra ninguno. Si hay dos que hacen lo mismo, dilo y elimina uno.
2. Para cada recurso, define las fuentes (de dónde entra) y los sumideros (dónde se gasta), y comprueba que están equilibrados.
3. Da la curva de precios y de recompensas con números concretos por nivel o por día, en tabla.
4. Marca los momentos clave del jugador: los primeros 5 minutos, el final de la primera sesión, el día 3 y el día 7, y qué debe sentir y tener en cada uno.
5. Si hay compras, di qué se vende, a qué precio y por qué ahí, respetando que pagar acorte tiempo o dé cosmética, nunca poder que rompa el juego.
6. Dame las palancas que puedo tocar después para ajustar sin rehacer nada.

CONOCIMIENTO DEL OFICIO QUE DEBES APLICAR
Todo recurso necesita entrada y salida. Si entra más de lo que sale, la economía se infla y el jugador deja de valorar las recompensas; si sale más de lo que entra, se atasca y abandona.
Moneda blanda (se consigue jugando, se gasta en mejoras normales) y moneda dura (escasa, se compra o se gana muy despacio, se gasta en atajos o cosmética). No las mezcles en la misma tienda sin motivo.
Las curvas de coste suelen crecer más rápido que las recompensas, y ahí está el punto de fricción donde el jugador se plantea pagar o dejarlo: colócalo a conciencia y no antes de que se haya enganchado.
La primera hora tiene que ser generosa: victorias rápidas, desbloqueos frecuentes y ninguna pantalla de espera. La sensación de progreso se construye con muchos pasos pequeños, no con un salto lejano.
Un buen ritmo alterna recompensas seguras (siempre que haces X) con recompensas variables (a veces cae algo mejor). Las variables enganchan pero, usadas sin freno, queman y generan mala reputación.
Precios reales: los tramos habituales en tienda son de importe pequeño para la compra de entrada, medio para el pack normal y alto para el pack grande; el pack intermedio suele destacarse para que parezca el sensato. Sé transparente sobre el valor.
Evita: energía o vidas que bloqueen el juego sin alternativa, cofres con probabilidades ocultas, precios que cambian según lo que gastas, ofertas con cuenta atrás falsa. Además de ser turbios, en la UE hay reglas cada vez más estrictas sobre transparencia en compras dentro del juego y sobre menores.
Comprueba tu economía simulando a mano tres jugadores: el que juega 10 minutos al día, el que juega 2 horas y el que paga. Los tres deben llegar a algún sitio.

RESTRICCIONES
Da números concretos, no rangos vagos.
No prometas ingresos ni cifras de negocio.
Todo lo que propongas debe poder llevarlo yo a una hoja de cálculo sencilla.

FORMATO DE LA RESPUESTA
A) MAPA DE RECURSOS: tabla Recurso | Para qué sirve | Fuentes | Sumideros | Riesgo de inflación.
B) CURVA DE PROGRESIÓN: tabla por nivel o por día con Tiempo acumulado | Qué desbloquea | Coste | Recompensa por sesión.
C) LOS MOMENTOS CLAVE: minuto 1, minuto 5, fin de la primera sesión, día 3, día 7.
D) TIENDA (si aplica): qué se vende, precio, argumento y por qué no rompe el equilibrio.
E) SIMULACIÓN DE TRES JUGADORES: qué le pasa a cada uno en la primera semana.
F) HOJA DE CÁLCULO: dime exactamente qué columnas crear y qué fórmula lleva cada una.
G) PALANCAS DE AJUSTE ordenadas de menos a más arriesgada.
H) LÍNEAS ROJAS: qué no haré nunca en esta economía.

CRITERIOS DE CALIDAD
Cada número está justificado por el tiempo de sesión y la duración objetivo que te he dado.
No hay ningún recurso sin sumidero ni ninguna compra que dé ventaja injusta.
Puedo montar la hoja de cálculo hoy y ver el efecto de cambiar un valor.
```
