# Por qué se me caen los dispositivos…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Diagnostica paso a paso por qué los sensores, enchufes o bombillas inteligentes se desconectan o responden tarde, y te da el plan de arreglo ordenado.

## Qué es y qué hace

Prompt que diagnostica por capas por qué sensores, enchufes o bombillas inteligentes se desconectan o tardan. Con la tecnología, el router, la distancia y lo ya probado, devuelve un plan de arreglo ordenado de lo barato a lo caro. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con síntomas y modelo de router
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Aplica los pasos de uno en uno

## Cuándo usarla

Úsalo cuando una instalación ya montada falla: dispositivos que se van solos, órdenes que tardan, sensores que aparecen «no disponible» a ratos.

## Cómo ganar dinero con ella

Ahorra horas de prueba y error y evita comprar repetidores o cambiar aparatos que no eran el problema; también salva instalaciones de clientes ya cobradas.

- Diagnóstico remoto de redes domóticas inestables…
- Servicio de reparación de instalaciones que fallan…
- Revisión de red doméstica para dispositivos inteligentes…

**Precio orientativo:** 40–120 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como técnico de redes domésticas y radiofrecuencia especializado en instalaciones domóticas. Tu método es descartar por capas, de lo más barato y probable a lo más caro e improbable, y no cambiar nunca dos cosas a la vez.
Mi situación:
- Qué falla exactamente: [DESCRIPCIÓN: QUÉ APARATO, QUÉ HACE MAL]
- Cada cuánto pasa y a qué horas: [FRECUENCIA Y HORARIO]
- Cuándo empezó y qué cambió justo antes: [FECHA Y CAMBIOS]
- Tecnología de los aparatos que fallan: [WIFI / ZIGBEE / MATTER-THREAD / Z-WAVE / BLUETOOTH / NO LO SÉ]
- Router y operador: [MODELO Y OPERADOR]
- Cuántos aparatos conectados hay en total: [NÚMERO APROXIMADO]
- Distancia y obstáculos entre el aparato que falla y el router o pasarela: [METROS Y PAREDES]
- Qué he probado ya: [LO QUE HE INTENTADO]
Tu tarea: darme un diagnóstico ordenado y un plan de arreglo, no una lista de posibles causas al azar.
Trabaja así:
PASO 1. Clasifica el síntoma. No es lo mismo «se desconecta y vuelve solo», «responde con retraso de varios segundos», «desaparece para siempre hasta que lo reinicio» o «falla solo cuando hay gente en casa». Dime en cuál de esos cajones cae mi caso y qué familia de causas apunta cada uno.
PASO 2. Sospechosos habituales, ordenados por probabilidad para mi caso concreto, y no en general: saturación de la banda de 2,4 GHz, canal wifi solapado con el canal de la malla Zigbee o Thread, demasiados aparatos colgando del router del operador, dispositivos alimentados a pilas que se duermen y se pierden, falta de repetidores con corriente que hagan de nodo intermedio, microondas o cámaras cerca, alimentación insuficiente o fuente de mala calidad, firmware desactualizado, y router que separa mal las bandas o aísla clientes entre sí.
PASO 3. Pruebas de diagnóstico, una por una, cada una con: qué hago, cuánto espero antes de juzgar, qué resultado significa culpable y qué resultado significa inocente. Empieza siempre por la prueba más barata y reversible.
PASO 4. Explícame las tres cosas que casi todo el mundo tiene mal y que yo debo revisar sí o sí: que la red de 2,4 GHz tenga un nombre propio si el aparato no ve las redes mixtas, que el canal wifi esté en 1, 6 u 11 y no en automático saltando todo el día, y que la malla de radio no comparta hueco de espectro con el canal wifi que usa la casa.
PASO 5. Plan de arreglo en fases. Fase 1: cambios gratis. Fase 2: cambios de colocación y cableado. Fase 3: compras necesarias, y para cada compra dime qué problema resuelve y cómo sabré si mereció la pena.
PASO 6. Regla de oro de la prueba: cambio una sola cosa, apunto fecha y hora, y espero al menos [DÍAS DE OBSERVACIÓN] antes de tocar otra. Dame una tabla simple de registro de incidencias para ir apuntando.
Restricciones:
- Nunca me digas «reinicia el router y ya está» como solución final.
- No recomiendes comprar nada hasta que las pruebas gratuitas estén hechas.
- Si la causa probable es el router del operador, dímelo claro y dime qué pedirle al operador con palabras exactas.
- Explica cada término técnico con una comparación cotidiana la primera vez que lo uses.
Formato de la respuesta:
1) DIAGNÓSTICO MÁS PROBABLE en dos frases, con el porcentaje de confianza que le das.
2) TABLA DE SOSPECHOSOS: Causa | Por qué encaja con mi caso | Prueba que la confirma | Coste de descartarla.
3) PLAN DE PRUEBAS numerado, en el orden exacto en que las hago.
4) PLAN DE ARREGLO en tres fases con lo que cuesta cada una en tiempo y en dinero aproximado.
5) HOJA DE REGISTRO: tabla vacía Fecha | Hora | Qué falló | Qué había cambiado yo.
6) CUÁNDO RENDIRSE: en qué momento toca cambiar de tecnología o llamar a alguien, y qué le cuento a esa persona.
Criterios de calidad: está bien si cada prueba tiene un resultado interpretable, si el orden va de gratis a caro, y si al final del plan puedo decir con seguridad cuál era la causa en lugar de «parece que ahora va mejor».
```
