---
name: diagnosticar-red-iot
description: Diagnoses unstable smart home devices that disconnect, lag or vanish from the app, walking through Wi-Fi band, channel, DHCP, isolation, mDNS and mesh issues in a fixed order. Use when devices drop off the network, only work sometimes, fail to be added, or stop responding after a few hours.
---

# Diagnosticar una red con dispositivos que se caen

## Qué hace
Guía un diagnóstico ordenado, de lo más barato a lo más caro, para averías de conectividad en instalaciones domóticas, sin cambiar material a ciegas.

## Cuándo se activa
Cuando alguien dice: se desconecta solo, tarda en encender, no lo encuentra la app, funciona a veces, o se cae siempre por la noche.

## Qué preguntar primero
1. ¿Falla un dispositivo, un grupo o todos?
2. ¿Desde cuándo y qué cambió ese día (router nuevo, actualización, mueble, obra)?
3. ¿Cada cuánto se cae? Anota si es un patrón horario.
4. Marca y modelo del router u operador, y si hay repetidores o malla.
5. ¿El dispositivo es de Wi-Fi, Zigbee o de pilas?

## Método paso a paso
### Paso 1: separa el síntoma
- Falla uno solo: casi siempre alimentación, distancia o el propio aparato.
- Fallan todos a la vez y a la misma hora: red, router o corte de corriente.
- Fallan los de pilas: batería, malla o interferencia.

### Paso 2: la banda
Casi todos los cacharros baratos (ESP8266, ESP32, enchufes, bombillas) solo ven 2,4 GHz. Si el router emite un único nombre de red para 2,4 y 5 GHz, muchas veces no se dejan añadir. Solución: crear temporalmente una red solo 2,4 GHz para el alta, o desactivar la banda de 5 GHz cinco minutos.

### Paso 3: el canal y el ancho
- Con el móvil, mira qué canales usan los vecinos. En 2,4 GHz solo valen 1, 6 y 11.
- Pon el ancho de canal en 20 MHz en 2,4 GHz. Los 40 MHz en esa banda causan más problemas de los que resuelven.
- Baja la potencia de emisión si tienes malla: a máxima potencia los dispositivos se agarran a un nodo lejano y no saltan.

### Paso 4: direcciones y DHCP
- Si se caen todos cada 12 o 24 horas justas, sospecha del tiempo de concesión DHCP o de un rango agotado. Amplía el rango.
- Reserva IP por MAC para los dispositivos importantes (hub, NAS, cámaras). No pongas IP fija en el aparato si no la sacas del rango DHCP: acabarás con dos aparatos con la misma IP.

### Paso 5: aislamiento y descubrimiento
- El aislamiento de clientes o modo invitado rompe el descubrimiento: la app no encuentra nada aunque haya internet. Desactívalo en la red donde vivan los dispositivos.
- Si has separado los cacharros en otra red o VLAN, el descubrimiento por mDNS no cruza sola: hay que activar el reflector mDNS o Avahi. Si no, Chromecast, impresoras y HomeKit dejan de aparecer.

### Paso 6: si es Zigbee
- Mira la calidad de enlace de cada dispositivo en el mapa de red del hub. Un valor bajo y estable indica falta de repetidores.
- Los dispositivos con corriente hacen de repetidor: añade un enchufe intermedio antes de cambiar el sensor.
- Cambia el canal Zigbee lejos del canal Wi-Fi. Ojo: al cambiar de canal muchos dispositivos hay que volver a emparejarlos.

### Paso 7: alimentación
Fuentes de alimentación baratas y cables USB largos y finos provocan reinicios que parecen fallo de red. Mide la tensión con el aparato funcionando, no en reposo.

## Formato exacto de la respuesta
1. **Hipótesis principal** en una frase.
2. **Plan de pruebas numerado**, de lo más barato a lo más caro, con lo que debe pasar si la hipótesis es correcta.
3. **Cómo confirmar** cada paso (qué mirar, qué valor es normal).
4. **Plan B** si la hipótesis falla.
5. **Qué anotar** para el historial del cliente.

## Errores típicos
- Reiniciar el router y dar el problema por resuelto sin registrar nada.
- Cambiar el dispositivo antes de mirar la cobertura y la alimentación.
- Meter tres repetidores del bazar: multiplican los problemas de itinerancia.
- Actualizar el firmware en mitad del diagnóstico y perder la pista de la causa.

## Avisos honestos
- Hay averías intermitentes que solo se cazan dejando un registro varios días. Es legítimo cobrar esa espera.
- Si el router es del operador y está muy limitado, a veces la única solución real es poner un punto de acceso propio.
