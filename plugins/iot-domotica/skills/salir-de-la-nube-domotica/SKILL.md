---
name: salir-de-la-nube-domotica
description: Planifica una migración por fases de dispositivos de hogar inteligente desde las nubes de los fabricantes al control local (Home Assistant, Zigbee2MQTT, ESPHome, Matter), con matriz de riesgos, qué es reversible y qué se rompe. Úsala cuando alguien tema el cierre de una app, quiera que la casa funcione sin internet, o un cliente exija no depender de terceros.
---

# Salir de la nube: control local de tu domótica

## Qué hace
Hace inventario de lo que tienes, marca qué se puede liberar y cómo, en qué orden hacerlo y qué se pierde por el camino. Termina con un plan por fases con vuelta atrás en cada una.

## Cuándo se activa
Cuando el fabricante anuncia cierre o cambio de app, cuando alguien quiere que la casa funcione sin internet, cuando hay preocupación por privacidad, o antes de una instalación nueva para elegir bien.

## Qué preguntar si falta información
1. Lista de aparatos: marca, modelo y app que usan.
2. Qué hay ahora de cerebro: nada, Alexa/Google, app del fabricante, algún hub.
3. ¿Tienes un ordenador que pueda estar encendido siempre (mini PC, Raspberry, NAS)?
4. Qué automatizaciones son críticas: calefacción, riego, alarma, persianas.
5. Nivel de manitas: ¿te da miedo abrir un aparato o soldar?
6. ¿Es tu casa o la de un cliente? (cambia la tolerancia al riesgo).

## Método
### 1. Clasificar cada aparato en cuatro cajones
- **Ya es local**: Zigbee, Z-Wave, Thread/Matter, Modbus, KNX. Solo necesitas un coordinador propio y emparejarlo ahí.
- **Local con puente**: aparatos que hablan en local aunque vengan con nube (Shelly con MQTT, Tasmota, algunos Aqara vía Zigbee, Philips Hue por su puente).
- **Liberable cambiando firmware**: muchos aparatos con ESP8266/ESP32 admiten Tasmota o ESPHome. Ojo: los fabricantes cambiaron el chip a modelos no flasheables, hay que mirar el lote concreto.
- **Cautivo**: cámaras con nube obligatoria, robots aspiradores, aires acondicionados con módulo propietario, cerraduras con cuenta. Aquí o hay integración no oficial (que puede romperse) o toca sustituir el aparato.

### 2. Elegir el cerebro
- Home Assistant es el estándar de facto y el que más integraciones tiene. Se puede instalar en un mini PC de segunda mano, en una Raspberry 4/5 con SSD (no en tarjeta microSD, se corrompen) o en un NAS.
- Complementos habituales: Zigbee2MQTT o ZHA para Zigbee (con antena USB y alargador para separarla del USB3), Mosquitto para MQTT, ESPHome para tus propios cacharros.
- Matter no te libera solo: sigue necesitando un controlador y muchos aparatos exponen menos funciones por Matter que por su app.

### 3. Orden de migración (importante)
1. Monta el cerebro y déjalo conviviendo con lo actual, sin tocar nada.
2. Migra primero lo que no es crítico: una bombilla, un enchufe de un flexo.
3. Después los sensores.
4. Luego lo crítico (calefacción, riego), y solo cuando lleve dos semanas estable.
5. Deja para el final o descarta lo cautivo.

### 4. Antes de tocar nada
- Apunta contraseñas Wi-Fi, cuentas y qué app controla qué.
- Haz copia de seguridad del hub actual si la tiene.
- Guarda las cajas y el manual de emparejamiento: reemparejar suele necesitar el botoncito de reset.
- Un aparato emparejado en un sitio no puede estarlo en dos: al pasarlo a Zigbee2MQTT desaparecerá de la app original.

### 5. Lo que se pierde al salir de la nube
- Control desde fuera de casa: hay que montar acceso remoto (VPN tipo WireGuard/Tailscale, o suscripción de nube propia). No abras puertos a pelo.
- Asistentes de voz: se pueden reconectar, pero requiere configuración.
- Funciones de IA del fabricante (detección de personas en cámaras, por ejemplo).
- Actualizaciones automáticas: ahora las haces tú, y hay que hacerlas.

## Formato exacto de la respuesta
- **Inventario clasificado**: tabla Aparato / Cajón / Cómo se libera / Riesgo / Reversible sí-no.
- **Cerebro recomendado** con hardware concreto y por qué.
- **Plan por fases** con lo que se hace en cada una, cuánto tarda y cómo volver atrás.
- **Lista de compra** mínima.
- **Lo que vas a perder** y qué alternativa hay.
- **Prueba de aceptación**: corta internet una hora y comprueba que luces, calefacción y persianas siguen funcionando.

## Errores típicos
- Migrarlo todo un domingo y quedarte sin luz ni calefacción el lunes.
- Instalar Home Assistant en microSD y perderlo todo a los seis meses.
- Poner la antena Zigbee pegada al puerto USB 3.0 o al SSD: interferencias garantizadas y culpa a los sensores.
- Abrir el puerto 8123 al exterior. Eso es regalar la casa.
- Flashear un aparato sin comprobar antes el chip y dejarlo muerto.

## Avisos honestos
- Las integraciones no oficiales dependen de voluntarios y de que el fabricante no cambie la API. Pueden dejar de funcionar en cualquier actualización.
- Si es la casa de un cliente, te conviertes en su soporte técnico de por vida. Ponlo en el contrato o cobra mantenimiento.
- Trabajar con 230 V no es cosa de manitas: interruptores dentro de la caja y cuadros los toca un electricista.
