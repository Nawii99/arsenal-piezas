---
name: red-zigbee-inestable
description: Diagnostica redes mesh Zigbee/Z-Wave inestables (cortes, latencia, dispositivos que pasan a no disponibles) y elabora un plan de reparación ordenado que cubre conflictos de canal, ubicación de routers, interferencias USB y dispositivos con batería. Úsala cuando los dispositivos inteligentes se desconecten, respondan despacio o se caigan de forma repetida en una instalación doméstica o de un negocio pequeño.
---

# Red Zigbee o Z-Wave inestable

## Qué hace

Coge los síntomas de una instalación que falla y saca la causa más probable, en orden de probabilidad real, con las pruebas concretas para confirmarla y el arreglo. No adivina: te hace medir antes de gastar.

## Cuándo se activa

- Dispositivos que aparecen como «no disponible» y vuelven solos.
- Órdenes que tardan 3-10 segundos o llegan a medias (una bombilla sí, otra no).
- Sensores de puerta o movimiento que se pierden cada pocos días.
- Todo iba bien y empeoró después de añadir dispositivos o mover el coordinador.

## Qué preguntar antes de responder

1. ¿Qué coordinador o hub? (Sonoff ZBDongle-E/P, SkyConnect, Conbee II, hub de marca, Z-Wave...)
2. ¿Cuántos dispositivos y cuántos son de pila? (los de pila NO repiten señal).
3. ¿Dónde está físicamente el coordinador? ¿Enchufado directo al ordenador o al hub, o con alargador USB?
4. ¿Qué canal Zigbee usa y qué canal usa el WiFi de 2,4 GHz del router?
5. ¿Fallan siempre los mismos dispositivos o cambia? ¿Están lejos, en garaje, sótano o dentro de caja metálica?
6. ¿Metros y paredes entre coordinador y los que fallan?

## Método paso a paso

### 1. Separar el WiFi del Zigbee (causa nº1)

Zigbee y el WiFi de 2,4 GHz comparten banda. Regla práctica: WiFi canal 1 con Zigbee 15, 20, 25 o 26; WiFi canal 11 con Zigbee 11 o 15. Nunca dejes el router en «canal automático»: fíjalo. Cambiar el canal Zigbee obliga a reemparejar algunos dispositivos (los de pila casi siempre), así que hazlo con tiempo, no un viernes a las 20:00.

### 2. Alejar el coordinador del ruido USB

Los puertos USB 3.0 y los SSD emiten justo en 2,4 GHz. Si el dongle está pinchado directamente al mini-PC o al Raspberry, sácalo con un alargador USB 2.0 de 1-2 metros y súbelo. Este cambio, solo, arregla una parte enorme de los casos y cuesta menos de 10 euros. Nunca lo dejes detrás del televisor, dentro del rack, ni encima del router.

### 3. Contar routers de malla

Los dispositivos enchufados a corriente (enchufes inteligentes, bombillas, relés) repiten la señal. Los de pila no. Regla: al menos un dispositivo a corriente cada 8-10 metros y uno por planta, y nunca más de 3 saltos hasta el coordinador. Si toda la instalación es de pila, la malla no existe y vas a tener fallos siempre.

### 4. Descartar bombillas malas repetidoras

Algunas bombillas baratas repiten fatal y arrastran a los vecinos. Si los fallos se concentran en dispositivos que cuelgan de una bombilla concreta, quítala de la ruta.

### 5. Mirar el mapa de red y el LQI

En Zigbee2MQTT o ZHA hay un mapa. Interpretación práctica: LQI por debajo de 50 es enlace pobre, por encima de 100 va bien. Un dispositivo colgando directamente del coordinador desde el otro extremo de la casa es sospechoso de enlace forzado.

### 6. Pilas y sensores mudos

Un sensor que informa 2,6 V en una pila CR2032 ya está fallando aunque marque 30 %. Cambia pilas de golpe una vez al año en instalaciones de cliente y anótalo.

### 7. Reemparejar en el sitio, nunca al lado del hub

Empareja el dispositivo en su ubicación definitiva para que elija bien su ruta. Emparejar al lado del coordinador y luego moverlo es el error clásico.

## Formato exacto de la respuesta

1. **Diagnóstico probable** (máximo 3 causas, ordenadas por probabilidad, con el porqué).
2. **Pruebas para confirmar** (una por causa, con qué mirar y qué resultado confirma o descarta).
3. **Plan de arreglo por orden de coste**: primero lo gratis (canal, posición), luego lo barato (alargador USB, enchufe repetidor), luego lo caro (más dispositivos, cambiar coordinador).
4. **Material a comprar**, si hace falta, con tipo genérico y para qué sirve.
5. **Cómo saber que está arreglado**: 7 días sin ningún «no disponible», respuesta por debajo de 1 segundo, LQI mínimo por encima de 60 en todos.

## Errores típicos

- Cambiar el hub por uno más caro sin haber tocado el canal ni la posición: 200 euros tirados.
- Añadir «repetidores» de pila: no existen, los de pila no repiten.
- Poner el coordinador en el mismo cajón que el router.
- Cambiar canal sin avisar al cliente y dejar la mitad de la casa desemparejada.
- Culpar al WiFi cuando el problema es una bombilla repetidora defectuosa.

## Avisos honestos

- El Zigbee no atraviesa bien hormigón armado ni suelos radiantes. Si hay que cruzar un forjado grueso, a veces la solución es un segundo hub o pasar a cable, no insistir.
- Algunos dispositivos muy baratos son simplemente malos: si uno falla siempre y el resto va bien, cámbialo.
- No prometas al cliente «cero cortes». Promete un umbral medible y déjalo por escrito.
