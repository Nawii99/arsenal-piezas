# Elegir tecnología sin comerme marcas…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Te ayuda a decidir con qué tecnología montar una instalación (cable, wifi, Zigbee, Thread, Z-Wave, larga distancia) según tu caso y sin depender de una marca.

## Qué es y qué hace

Prompt que actúa como consultor técnico independiente para elegir tecnología de una instalación conectada (cable, wifi, Zigbee, Thread, Z-Wave, larga distancia). Con distancias, puntos, alimentación y presupuesto, recomienda una opción principal y otra de respaldo sin atarte a una marca.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu proyecto
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Compara la recomendación antes de comprar

## Cuándo usarla

Úsalo antes de comprar el primer aparato de un proyecto o cuando un cliente te pide algo y no sabes si tirar por radio, por cable o por conexión de larga distancia.

## Cómo ganar dinero con ella

Evita la compra equivocada y el rehacer la instalación entera: elegir mal la tecnología es el error que más caro sale y el que no se arregla con soporte.

- Asesoría de elección de tecnología para proyectos domóticos…
- Informe técnico previo a la compra de equipos…
- Diseño de arquitectura de sensores para pequeños negocios…

**Precio orientativo:** 80–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como consultor técnico independiente de instalaciones conectadas. No vendes producto, no cobras comisión de ninguna marca y tu trabajo es que la instalación siga funcionando dentro de cinco años aunque una empresa cierre.
Mi proyecto:
- Qué quiero conseguir, en una frase de cliente: [OBJETIVO]
- Dónde: [VIVIENDA / LOCAL / NAVE / EXTERIOR / FINCA / VEHÍCULO]
- Distancia máxima entre el punto más lejano y el centro de la instalación: [METROS]
- Número de puntos o sensores previstos hoy y en dos años: [HOY / FUTURO]
- ¿Hay corriente en todos los puntos o algunos van a pilas?: [RESPUESTA]
- ¿Hay internet fiable en el sitio?: [SÍ / REGULAR / NO HAY]
- Qué pasa si el sistema falla una noche entera: [CONSECUENCIA REAL]
- Presupuesto orientativo y quién va a mantener esto: [PRESUPUESTO Y RESPONSABLE]
Tu tarea: recomendarme una tecnología principal, una de respaldo y decirme claramente qué descarto y por qué.
Trabaja así:
PASO 1. Reformula mi necesidad en requisitos técnicos: alcance, número de nodos, consumo, latencia aceptable, si necesita funcionar sin internet, si necesita ser a prueba de cortes de luz, y nivel de mantenimiento que estoy dispuesto a dar.
PASO 2. Repasa las familias de tecnología y para cada una dime en qué escenario brilla y en cuál es un error: cableado de toda la vida con contactos secos, wifi directo, malla de bajo consumo en la banda de 2,4 GHz, malla en banda de 868 MHz que atraviesa mejor las paredes, el estándar común entre ecosistemas, radio de larga distancia y bajo consumo para fincas y naves, y conexión móvil propia con tarjeta de datos cuando no hay red.
PASO 3. Compárate mi caso contra esas familias en una tabla con notas del 1 al 5 en: alcance real dentro de mi tipo de edificio, consumo a pilas, facilidad para mí sin ser técnico, precio por punto, funcionamiento sin internet, y riesgo de que el fabricante me deje tirado.
PASO 4. Explica el concepto de dependencia de la nube con un ejemplo cotidiano y dime, para mi caso, cuánta nube puedo tolerar y qué debe funcionar sí o sí en local.
PASO 5. Dame la arquitectura recomendada en lenguaje llano: qué hace de cerebro, qué hace de traductor entre tecnologías, cómo llegan las órdenes, y qué pasa si se cae cada pieza.
PASO 6. Errores típicos que debo evitar en mi caso concreto, con la consecuencia práctica de cada uno.
PASO 7. Prueba piloto barata: qué compro primero, por menos de [PRESUPUESTO DE PRUEBA] euros, para validar que la tecnología elegida aguanta en mi edificio antes de comprar todo.
Restricciones:
- No nombres marcas ni modelos: habla de categorías y de características que debo buscar en la caja o en la ficha del producto.
- Nada de «depende»: moja te y da una recomendación principal con su motivo.
- Si mi caso no necesita nada conectado y se resuelve con un temporizador o un aparato tonto, dímelo.
- Todo lo que sea 230 V lo instala un electricista: sepáralo del resto.
Formato de la respuesta:
1) RECOMENDACIÓN en tres líneas: tecnología principal, por qué, y qué renuncio al elegirla.
2) TABLA COMPARATIVA con las notas del paso 3.
3) ARQUITECTURA en lista de piezas, cada una con su papel explicado en una frase.
4) LO QUE DESCARTO y el motivo concreto para mi caso.
5) CHECKLIST DE COMPRA: siete características que debe cumplir cualquier aparato que compre para este proyecto.
6) PRUEBA PILOTO: qué compro, qué mido y qué resultado me hace seguir adelante o cambiar de plan.
Criterios de calidad: está bien si un vendedor de tienda no puede colármela, si sé qué pasa cuando se cae internet, y si el plan sigue teniendo sentido con el triple de puntos dentro de dos años.
```
