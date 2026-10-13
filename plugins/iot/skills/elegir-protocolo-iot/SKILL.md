---
name: elegir-protocolo-iot
description: Chooses the right wireless or wired protocol (Zigbee, Wi-Fi, Z-Wave, Thread/Matter, BLE, LoRa, KNX, Modbus) for a specific smart home or industrial sensing project, weighing range, battery life, cost and interference. Use when the user is planning a home automation or IoT install, asks which devices to buy, mentions Zigbee/Matter/LoRa, or has devices that do not work well together.
---

# Elegir el protocolo para un proyecto IoT

## Qué hace
Convierte la descripción de un proyecto (qué se quiere controlar, dónde y con qué presupuesto) en una recomendación clara de protocolo, con la lista de material y los motivos.

## Cuándo se activa
Cuando el usuario describe una instalación de domótica, pregunta qué comprar, o tiene un lío de marcas que no se hablan entre ellas.

## Qué preguntar antes de responder
Si falta alguno de estos datos, pregúntalos en una sola tanda y no inventes:
1. ¿Qué se controla o se mide exactamente? (luz, persianas, temperatura, riego, puerta, consumo, cámara)
2. ¿Cuántos puntos y a qué distancia máxima del punto central?
3. ¿Hay obra o hay que ir sin cables?
4. ¿Los dispositivos tendrán corriente o irán con pilas?
5. ¿Vivienda, local, nave o exterior/campo?
6. ¿Presupuesto aproximado y quién lo mantendrá después?

## Método
### 1. Clasifica cada punto en tres cubos
- Con corriente permanente (enchufes, luces, relés): pueden hacer de repetidor.
- Con pilas (sensores de puerta, movimiento, temperatura): mandan poco y duermen.
- Vídeo o mucho dato (cámaras, pantallas): necesitan ancho de banda de verdad.

### 2. Aplica las reglas del oficio
- Pilas: Zigbee, Z-Wave o Thread. Nunca Wi-Fi con pilas: dura semanas, no años.
- Vídeo: Wi-Fi 5 GHz o, mejor, cable con PoE. Zigbee no transporta vídeo.
- Más de 100-150 m sin cable y pocos datos al día (nivel de depósito, riego, contador en finca): LoRa o LoRaWAN.
- Obra nueva con presupuesto alto y necesidad de que dure 20 años: cable, KNX o incluso relés con Modbus RS485.
- Maquinaria industrial ya existente: casi seguro Modbus RTU por RS485.
- Etiquetas y presencia de personas a corta distancia: BLE.

### 3. Detalles que separan al que sabe
- Zigbee y Wi-Fi comparten la banda de 2,4 GHz: si el Wi-Fi está en canal 1, 6 u 11, pon Zigbee en canal 15, 20 o 25 y no lo dejes al azar.
- El coordinador Zigbee USB pegado al ordenador o a un puerto USB 3 da fallos: usa un alargador USB de 1 m y sepáralo.
- La malla Zigbee la forman los dispositivos enchufados. Si todos tus dispositivos son de pilas, no hay malla: pon al menos un enchufe o repetidor por planta.
- Z-Wave en Europa va en 868 MHz: atraviesa mejor las paredes y no choca con el Wi-Fi, pero es más caro y hay menos catálogo.
- Matter no es un protocolo de radio, es una capa de compatibilidad: por debajo va sobre Wi-Fi o sobre Thread, y Thread necesita un border router.
- No mezcles más de dos ecosistemas. Cada uno añade una app, una cuenta y un punto de fallo.

### 4. Comprueba la salida de humos
Antes de cerrar la lista, verifica que existe integración local (sin nube) con el sistema elegido. Si un dispositivo solo funciona con su nube, dilo claramente: el día que la marca cierre el servicio, el aparato es un pisapapeles.

## Formato exacto de la respuesta
1. **Resumen en una frase**: qué protocolo principal y por qué.
2. **Tabla**: Zona o función | Dispositivo recomendado | Protocolo | Alimentación | Precio orientativo.
3. **Cerebro del sistema**: qué hub o controlador y si es local o de nube.
4. **Puntos débiles del plan**: dos o tres riesgos reales (cobertura, marca sin integración, obra necesaria).
5. **Qué comprar primero**: el kit mínimo para probar antes de gastarlo todo.

## Errores típicos
- Comprar todo de golpe sin probar cobertura en el punto más lejano.
- Poner sensores de pilas en el garaje o el exterior y luego quejarse del alcance: el hormigón y el metal se comen la señal.
- Usar enchufes Wi-Fi baratos por decenas: saturan el router y agotan la tabla de clientes.
- Elegir por el precio del sensor sin mirar si hay repuesto dentro de dos años.

## Avisos honestos
- Los precios cambian; da órdenes de magnitud, no cifras cerradas.
- Ninguna instalación inalámbrica es tan fiable como un cable. Si el cliente necesita que algo funcione siempre (una alarma, una puerta de nave), dilo antes de vender.
- Toda intervención sobre el cuadro eléctrico o instalación fija corresponde a un instalador autorizado.
