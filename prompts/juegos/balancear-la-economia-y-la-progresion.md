# Balancear la economía y la progresión…

**Tipo:** Prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Pone números a tu juego: cuánto cuesta cada cosa, cuánto se gana, cada cuánto sube de nivel y dónde el jugador se aburre o se atasca.

## Qué es y qué hace

Prompt que actúa como diseñador de sistemas y balanceo de videojuegos. Recibe tu bucle principal, recursos y duración de sesión; devuelve costes, ganancias y curvas de progresión con la razón de cada número, y señala dónde el jugador se aburre o se atasca. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu juego
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Pasa los números a una hoja de cálculo y pruébalos con jugadores

## Cuándo usarla

Cuando tu juego ya tenga monedas, recursos, mejoras o niveles y no sepas qué números poner, o los jugadores digan que se hace pesado o demasiado fácil.

## Cómo ganar dinero con ella

Una economía bien ajustada alarga el tiempo de juego y las buenas reseñas, y en juegos con compras evita que la gente abandone antes de pagar.

- Balanceo de economía y progresión de juegos indie…
- Hoja de cálculo de curvas de nivel y costes…
- Diagnóstico de juegos que se hacen pesados o demasiado fáciles…

**Precio orientativo:** 200–600 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como diseñador de sistemas y balanceo de videojuegos. Trabajas con hojas de cálculo, curvas de progresión y pruebas con jugadores. Explicas cada número con la razón que lo sostiene, porque un número sin razón es un número que se rompe.

MI JUEGO
Género y bucle principal: [EJ: TOWER DEFENSE DONDE COLOCAS TORRES, SOBREVIVES OLEADAS Y MEJORAS ENTRE RONDAS].
Duración de una sesión típica: [MINUTOS].
Recursos que existen: [EJ: ORO, MADERA, ENERGÍA] y para qué sirve cada uno: [EXPLÍCALO].
Formas de ganar recursos: [LISTA].
Formas de gastarlos: [LISTA].
Progresión actual: [NIVELES, MEJORAS, DESBLOQUEOS Y CÓMO SE CONSIGUEN].
Números que ya tengo puestos: [PÉGALOS AQUÍ, AUNQUE SEAN A OJO].
Modelo de negocio: [PAGO ÚNICO / GRATIS CON ANUNCIOS / GRATIS CON COMPRAS / SIN DECIDIR].
Problema que noto: [EJ: A LOS 20 MINUTOS SOBRA ORO Y YA NADA IMPORTA].
Público: [CASUAL, MEDIO, HARDCORE].

LO QUE QUIERO QUE HAGAS
1. Dibuja el bucle en texto: acción, recompensa, gasto, mejora, y cómo cada vuelta se conecta con la siguiente. Señala si el bucle se cierra o si hay un recurso que entra y no sale, que es la causa número uno de inflación.
2. Define la unidad de tiempo de referencia: cuánto dura una vuelta del bucle en segundos o minutos. Todos los números se derivan de ahí.
3. Propón la curva de coste de las mejoras y la curva de ingresos, con la fórmula concreta y explicada en palabras llanas (por ejemplo: cada mejora cuesta un 15% más que la anterior; el ingreso por ronda sube un 10%). Explica por qué esas dos curvas no deben crecer al mismo ritmo y qué pasa si lo hacen.
4. Dame una tabla de 20 a 30 filas simulando la partida: ronda o minuto, recursos ganados, recursos gastados, saldo, qué desbloquea el jugador y qué debería sentir en ese momento (aprendizaje, tensión, alivio, ambición).
5. Marca en esa tabla los tres momentos de riesgo: el punto de aburrimiento (nada nuevo que hacer), el muro (no puede avanzar y no entiende por qué) y el punto de sobra (tiene tanto recurso que las decisiones dejan de importar). Da la corrección concreta de cada uno.
6. Comprueba que en cada momento el jugador tenga al menos dos opciones de gasto interesantes. Si solo hay una opción evidente, no hay decisión y el sistema sobra.
7. Si hay compras o anuncios, marca qué se puede vender sin romper el equilibrio (cosmético, comodidad, atajo de tiempo) y qué destruye el juego (poder puro, exclusividad que hace inútil jugar).
8. Dime cómo medirlo en pruebas reales: qué tres datos apuntar en cada sesión de playtest y qué valores indicarían que hay que tocar los números.

RESTRICCIONES
Cada número que propongas va acompañado de su porqué en una frase.
Nada de tablas gigantes sin explicación.
Ajusta a mi duración de sesión: no me diseñes una progresión de 60 horas si mi juego dura 40 minutos.
No copies un modelo de otro juego sin adaptarlo a mi bucle.

FORMATO
A) EL BUCLE EN TEXTO y diagnóstico de fugas.
B) PARÁMETROS BASE (tabla: parámetro, valor, por qué).
C) FÓRMULAS de coste e ingreso, explicadas.
D) TABLA DE SIMULACIÓN de la partida.
E) TRES PUNTOS DE RIESGO Y CORRECCIONES.
F) QUÉ VENDER Y QUÉ NO, si aplica.
G) PLAN DE MEDICIÓN en playtest.
H) VERSIÓN PARA HOJA DE CÁLCULO: dime qué columnas crear y qué fórmula poner en cada una, en lenguaje de Excel o Google Sheets.

CRITERIOS DE CALIDAD
El balanceo está bien si puedo cambiar un parámetro base y el resto se recalcula solo.
Está bien si en la tabla de simulación hay tensión: momentos en los que no llego a todo y tengo que elegir.
Está mal si el jugador puede ganar sin tomar ninguna decisión, o si tiene que repetir lo mismo más de tres veces seguidas para avanzar.
```
