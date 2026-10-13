---
name: auditoria-wifi-24-para-iot
description: Audits a home or small-business Wi-Fi network for IoT reliability: 2.4 GHz channels, band steering, DHCP pool, IGMP/mDNS, isolation and AP placement, and outputs the exact router settings to change. Use when smart plugs, cameras or bulbs keep dropping off, refuse to pair, or respond slowly.
---

# Auditoría de Wi-Fi 2,4 GHz para dispositivos IoT

## Qué hace
Revisa la red desde el punto de vista de los cacharros baratos (que son tontos y frágiles) y te da una lista de ajustes concretos para tu router o punto de acceso. No es una auditoría de velocidad: es de estabilidad y emparejamiento.

## Cuándo se activa
Cuando algo IoT se desconecta solo, no se deja emparejar desde el móvil, va con retardo de segundos, o cuando vas a instalar más de 15-20 aparatos en el mismo sitio.

## Qué preguntar si falta información
1. Router o AP: marca y modelo, y si es el del operador o uno propio.
2. ¿Wi-Fi mallada (mesh) o repetidores? ¿Cuántos y de qué marca?
3. ¿La red de 2,4 y la de 5 GHz tienen el mismo nombre (SSID) o distinto?
4. Cuántos aparatos hay conectados en total y cuántos son IoT.
5. Qué falla exactamente: no empareja, se cae a ratos, o va lento.
6. Vivienda o local, metros cuadrados, plantas y tipo de paredes.

## Método
### 1. Lo que rompe el IoT casi siempre
- **SSID único para 2,4 y 5 GHz**: el móvil está en 5 GHz y el aparato solo habla 2,4; muchos procesos de emparejamiento fallan por eso. Solución: crear un SSID separado solo para 2,4 GHz, o desactivar 5 GHz durante el emparejamiento.
- **Canal saturado**: en 2,4 GHz solo hay tres canales que no se pisan: 1, 6 y 11. Cualquier otro solapa. Fija uno de los tres a mano; el automático cambia de canal y tira los aparatos.
- **Ancho de canal 40 MHz en 2,4**: ocupa el doble y genera choques. Ponlo en 20 MHz.
- **WPA3 solo o modo mixto mal implementado**: muchos ESP8266/ESP32 antiguos solo entienden WPA2-PSK. Deja WPA2, o WPA2/WPA3 mixto si el router lo hace bien.
- **Aislamiento de clientes (AP isolation) o red de invitados**: rompe el descubrimiento; el móvil no ve el aparato.
- **Pool de DHCP pequeño**: 30 aparatos y un rango de 20 direcciones. Amplía el rango y alarga la concesión (24 h o más).
- **Bandas dirigidas (band steering) y roaming agresivo (802.11r/k/v)**: útil para portátiles, veneno para bombillas. Desactívalo en la red IoT.
- **Modo de ahorro/DTIM alto o bajo**: si los sensores de pila tardan en responder, sube DTIM a 3; si se caen, bájalo.
- **mDNS/Bonjour e IGMP snooping**: si tienes VLAN o mesh, sin ellos no aparecen Chromecast, HomeKit ni impresoras.

### 2. Comprobaciones que puedes hacer sin ser técnico
- Instala una app de análisis Wi-Fi en Android (en iPhone no dejan) y mira: qué canales usan los vecinos, y cuánta señal llega donde está cada cacharro.
- Regla práctica: por debajo de -70 dBm empieza a fallar; por debajo de -80 dBm no cuentes con ello.
- Haz un ping continuo a un aparato problemático durante 10 minutos y anota si hay pérdidas.
- Mira en el router la lista de clientes: si un aparato aparece y desaparece, es cobertura o DHCP; si nunca aparece, es emparejamiento o banda.

### 3. Colocación
- El router en alto, en el centro, nunca dentro de un mueble, ni encima del cuadro eléctrico, ni pegado al microondas o al monitor de bebé.
- Un AP por planta suele bastar en vivienda; en local con tabiques o cámaras frigoríficas, mide antes.
- Los repetidores por Wi-Fi parten el ancho de banda: si puedes, tira cable o usa PLC hasta un segundo AP.

### 4. Segmentación (si el cliente lo pide)
- VLAN o red separada para IoT está bien por seguridad, pero requiere permitir mDNS entre redes y saber lo que haces. Si no, deja una única red y bloquea el acceso a internet de lo que no lo necesite.

## Formato exacto de la respuesta
- **Resumen del problema** en dos líneas.
- **Ajustes a cambiar**: tabla con Ajuste / Valor actual / Valor recomendado / Por qué.
- **Pasos en orden**, del más probable al menos, con lo que hay que reiniciar en cada uno.
- **Cómo saber si ha funcionado**: prueba concreta y qué debe pasar (por ejemplo, cero desconexiones en 48 h).
- **Si sigue fallando**: siguiente paso (AP extra, cambiar a Zigbee, cable).

## Errores típicos
- Cambiar diez cosas a la vez y no saber cuál lo arregló. Cambia una, prueba, sigue.
- Poner el mismo canal que el vecino más fuerte.
- Meter 40 dispositivos en un router de operador y culpar a los dispositivos.
- Renombrar el SSID después de instalar todo: te toca reemparejarlo entero.

## Avisos honestos
- Si hay más de 25-30 aparatos Wi-Fi, el arreglo de verdad es pasar los sensores a Zigbee o Thread, no seguir tocando el router.
- Algunos routers de operador no dejan separar bandas ni fijar canal; ahí la solución es poner el router en modo puente y un AP propio.
- Cambiar de SSID o de contraseña obliga a reconfigurar aparato por aparato: avísale al cliente antes, no después.
