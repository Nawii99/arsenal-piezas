# Plan a prueba de fallos: sin luz y sin internet…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Prompt que rediseña tu instalación para que siga siendo utilizable cuando se cae la conexión, el hub o la corriente, y para que nadie se quede encerrado ni a oscuras.

## Qué es y qué hace

Prompt que rediseña una instalación domótica para que siga siendo utilizable sin internet, sin hub o sin corriente, sin dejar a nadie encerrado ni a oscuras. Define modos de degradación y cómo actúa quien no conoce el sistema. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con sitio y componentes
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Prueba cortando internet y luz
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando ya tienes cosas automatizadas y quieres asegurarte de que un apagón o una caída de internet no deje la casa o el local inservible.

## Cómo ganar dinero con ella

Evita pérdidas por paradas (frío, riego, acceso, alarmas) y es un argumento de venta claro frente a instaladores que solo montan aparatos.

- Rediseño de instalaciones para que funcionen sin internet…
- Auditoría de continuidad en cerraduras y luces conectadas…
- Plan de contingencia para alquileres turísticos…

**Precio orientativo:** 80–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como diseñador de instalaciones domóticas con criterio de continuidad: para ti una instalación buena es la que degrada bien cuando algo se cae, no la que impresiona cuando todo va. Piensas en la persona que está allí en ese momento sin saber nada del sistema.

MI INSTALACIÓN
- Sitio y uso: [VIVIENDA HABITUAL / SEGUNDA RESIDENCIA / LOCAL / ALOJAMIENTO TURÍSTICO / NAVE]
- Sistema central: [HOME ASSISTANT EN X / HUB DE FABRICANTE / VARIAS APPS EN LA NUBE]
- Funciones automatizadas hoy, una por línea: [QUÉ HACE | DE QUÉ DEPENDE (internet, hub, nube del fabricante, WiFi)]
- Cosas críticas que no pueden parar: [FRÍO / RIEGO / ACCESO / CALEFACCIÓN / ALARMA / BOMBA / SERVIDOR]
- Quién está en el sitio cuando yo no estoy: [FAMILIA / EMPLEADOS / HUÉSPEDES / NADIE]
- Cortes que ya he sufrido: [DESCRIBE QUÉ PASÓ]
- Qué tengo de respaldo: [NADA / SAI / ROUTER 4G / GENERADOR / LLAVE FÍSICA]

LO QUE TIENES QUE HACER
1. Clasifica cada función en tres niveles: crítica (tiene que funcionar sí o sí), importante (puede esperar horas) y comodidad (puede caerse sin drama). Justifica cada clasificación en media línea.
2. Para cada función crítica, dime de qué depende hoy en cadena: aparato, red local, hub, internet, nube del fabricante y corriente. Señala el eslabón más débil.
3. Analiza cuatro escenarios uno a uno: se cae internet pero hay luz, se cae la luz pero vuelve en minutos, apagón largo de horas, y se rompe o se apaga el hub central. Para cada escenario: qué deja de funcionar hoy, qué consecuencia real tiene y qué debería ocurrir en su lugar.
4. Propón el rediseño con esta jerarquía: primero que el mando físico de siempre siga funcionando (interruptor, llave, válvula manual), segundo que la lógica crítica viva en el propio dispositivo y no en el servidor, tercero que la red local funcione sin internet, y solo al final los avisos por la nube. Explica cada cambio con lo que gana.
5. Añade las medidas de respaldo con criterio: qué merece la pena poner en un SAI y durante cuánto tiempo, cuándo compensa un router con tarjeta 4G, qué automatizaciones deben tener temporizador propio en el aparato, qué debe volver solo al arrancar y qué NUNCA debe arrancar solo tras un apagón por seguridad.
6. Define los avisos de recuperación: cómo me entero de que hubo corte, cuánto duró y qué quedó mal al volver. Incluye la comprobación de que las cosas volvieron a su estado correcto y no a un estado por defecto peligroso.
7. Escribe la HOJA DE EMERGENCIA para quien esté allí: 6 instrucciones en lenguaje de persona normal, con dónde está el cuadro, la llave física y el interruptor manual de cada cosa crítica.
8. Termina con un SIMULACRO: cómo probar cada escenario a propósito, en qué momento del día hacerlo y qué anotar.

RESTRICCIONES
- Nada de soluciones que dependan de que yo esté mirando el móvil.
- Ninguna función crítica puede quedar solo en manos de la nube de un fabricante.
- Si algo puede ser peligroso al rearrancar solo (calefactores, motores, puertas), márcalo en rojo y propón bloqueo manual.
- No compliques por gusto: si la solución es dejar un interruptor normal, dilo.

FORMATO DE RESPUESTA
A) TABLA DE FUNCIONES: Función | Nivel | De qué depende | Eslabón más débil.
B) LOS 4 ESCENARIOS, cada uno con: qué pasa hoy | consecuencia | qué debería pasar.
C) REDISEÑO en pasos ordenados por importancia, con lo que gana cada paso.
D) RESPALDOS recomendados y para qué exactamente.
E) AVISOS de corte y de recuperación.
F) HOJA DE EMERGENCIA de 6 líneas para colgar.
G) PLAN DE SIMULACRO con los 4 ensayos.

CRITERIOS DE CALIDAD
- ¿Puede una persona sin conocimientos manejar lo esencial durante un corte?
- ¿Ninguna función crítica depende de internet o de una nube ajena?
- ¿Está tratado el arranque tras el apagón, y no solo el apagón?
- ¿Existe una forma de probar todo esto sin esperar a que ocurra?
```
