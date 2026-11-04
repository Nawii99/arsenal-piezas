---
name: elegir-conectividad-iot
description: Chooses the right connectivity for an IoT project (WiFi, Zigbee, BLE, LoRaWAN, NB-IoT/LTE-M, 4G, wired RS-485/Ethernet) by comparing range, power draw, data volume and true yearly cost. Use before buying hardware, when deciding how sensors or devices will connect in a client or personal project.
---

# Elegir la conectividad de un proyecto IoT

## Qué hace

Te lleva de «tengo que medir X en Y sitio» a una decisión de tecnología justificada, con el coste al año y el plan B si falla. Es la decisión más cara de deshacer, así que se toma antes de comprar.

## Cuándo se activa

Cuando alguien pregunta «¿esto lo hago con WiFi o con LoRa?», cuando hay que llevar datos desde una nave, una finca, un contenedor o varios locales, o cuando el cliente pide medir algo lejos del router.

## Qué preguntar antes de responder

1. ¿Qué se mide y cada cuánto? (temperatura cada 15 min no es lo mismo que vídeo).
2. ¿Cuántos bytes por mensaje y cuántos mensajes al día, aproximadamente?
3. ¿Distancia del dispositivo más lejano al punto con internet, y qué hay en medio? (paredes, campo abierto, metal, sótano).
4. ¿Hay enchufe donde va el sensor o va con pila? ¿Autonomía mínima aceptable?
5. ¿Hace falta actuar (encender algo) o solo leer? Actuar exige latencia baja.
6. ¿Cuánto tolera el cliente que se pierdan datos? ¿Un dato perdido es molesto o es un problema?
7. ¿Es un sitio ajeno donde no puedes tocar el router (nave alquilada, comunidad, casa del cliente)?

## Método paso a paso

### 1. Clasifica el proyecto en una de estas cuatro cajas

- **Dentro de un edificio, con enchufe, hay WiFi tuyo**: WiFi 2,4 GHz o Zigbee.
- **Dentro de un edificio, a pila, muchos puntos**: Zigbee o Z-Wave. Nunca WiFi a pila.
- **Fuera del edificio o hasta varios kilómetros, poco dato, a pila**: LoRaWAN.
- **Sitio ajeno, un solo punto, no controlas la red**: 4G/LTE-M/NB-IoT con SIM propia.

### 2. Aplica los límites reales, no los del folleto

- WiFi 2,4 GHz: 20-40 m en interior con paredes. A pila, semanas, no meses. Si necesitas años de autonomía, descártalo.
- Zigbee: 10-20 m por salto en interior, mallado hasta 3-4 saltos. Necesita dispositivos a corriente que hagan de repetidores.
- BLE: 5-15 m, ideal para etiquetas y balizas, no para telemetría continua.
- LoRaWAN: 2-5 km en urbano, 10-15 km en campo abierto con línea de vista. Pero muy poco dato: unos 50-200 bytes por mensaje y pocos mensajes por hora. No sirve para vídeo ni para actuar en tiempo real.
- NB-IoT / LTE-M: cobertura de operador, muy bajo consumo, ideal para un punto suelto lejos. Depende de que haya cobertura ahí: hay que comprobarlo en el sitio, no fiarse del mapa.
- Cable (Ethernet, PoE, RS-485/Modbus): lo más fiable siempre. Si puedes pasar cable, pasa cable.

### 3. Calcula el coste al año, no el de compra

Suma: hardware + gateway si hace falta + SIM o suscripción por dispositivo y año + reposición de pilas + horas de mantenimiento previstas. Una solución 4G con 12 SIM sale carísima frente a una LoRaWAN con un gateway propio; una LoRaWAN con un solo sensor es absurda porque el gateway no se amortiza.

### 4. Regla del gateway

Un gateway LoRaWAN propio se justifica a partir de más o menos 5-8 dispositivos o si vas a repetir el proyecto en otros clientes. Con uno o dos sensores, sale mejor 4G o red comunitaria.

### 5. Define el plan B

¿Qué pasa si se cae internet? Decide si el dispositivo guarda datos localmente y los reenvía, o si simplemente se pierden. Esto va escrito en la propuesta, no se improvisa después.

## Formato exacto de la respuesta

1. **Recomendación principal** en una frase, con la razón dominante.
2. **Tabla comparativa** de 3 opciones: tecnología, alcance real, autonomía esperada, coste inicial, coste anual, riesgo principal.
3. **Lista de material** por opción, en categorías genéricas (sensor, gateway, antena, fuente).
4. **Comprobación previa obligatoria**: qué medir en el sitio antes de comprar (cobertura, distancia, obstáculos).
5. **Plan B** y qué pasa con los datos si hay corte.

## Errores típicos

- Elegir LoRa por moda cuando el sensor está a 30 metros y hay enchufe.
- Sensores WiFi a pila: duran semanas y el cliente te llama cada mes.
- Fiarse del mapa de cobertura del operador sin ir al sitio con un móvil a comprobar señal en el punto exacto, a la altura exacta.
- No contar la SIM en el presupuesto y comerte el coste durante años.
- Montar en la red WiFi del cliente sin permiso escrito: el día que cambian de router, el sistema muere y te culpan a ti.

## Avisos honestos

- Ninguna tecnología inalámbrica es 100 % fiable. Si el dato es crítico (frío de un restaurante, alarma), diseña con aviso de «sensor mudo» y cable siempre que puedas.
- LoRaWAN tiene límites legales de tiempo en el aire en Europa: no puedes enviar cada segundo, aunque el equipo te deje configurarlo.
- Las SIM IoT baratas pueden dejar de dar servicio; ten un segundo proveedor identificado antes de firmar mantenimiento.
