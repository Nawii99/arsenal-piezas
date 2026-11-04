---
name: alertas-sin-falsos-positivos
description: Designs IoT alerting that fires only when it matters: thresholds with hysteresis, sustained-condition rules, dead-sensor watchdogs, escalation chains, quiet hours and acknowledgement. Use when building temperature, flood, door or machine-stop alerts, or when a client has started ignoring notifications.
---

# Alertas que sirven de algo

## Qué hace

Convierte «avísame si pasa algo» en un conjunto de reglas concretas: umbral, tiempo, a quién, por qué canal, qué hacer si nadie responde y cómo detectar que el propio sensor ha muerto.

## Cuándo se activa

- Cámaras de frío, congeladores, acuarios, servidores, calderas.
- Detección de inundación, humo, puertas abiertas, paradas de máquina.
- Cualquier instalación donde el cliente diga «me llegan demasiados avisos» o «no me llegó el aviso».

## Qué preguntar antes de responder

1. ¿Qué pasa si el problema no se detecta? Ponle euros y tiempo. Eso define la urgencia.
2. ¿Cuánto tiempo puede estar la condición mal antes de ser un problema de verdad?
3. ¿Quién recibe el aviso a las 3 de la madrugada y quién a las 11 de la mañana?
4. ¿Qué canal tiene esa persona siempre encima? (llamada, WhatsApp, Telegram, correo, sirena local).
5. ¿Hay alguien que pueda actuar de noche o el aviso solo sirve para el día siguiente?
6. ¿Ha habido falsos avisos antes y por qué?

## Método paso a paso

### 1. Clasifica cada aviso en tres niveles

- **Crítico**: hay dinero o seguridad en juego y hay que actuar ya. Llamada o sirena. Ejemplo: congelador por encima de -12 grados durante 30 minutos.
- **Aviso**: hay que mirarlo hoy. Mensaje push. Ejemplo: batería baja, humedad alta.
- **Informativo**: resumen diario, nunca notificación suelta. Ejemplo: puerta abierta 40 veces hoy.

La mayoría de sistemas fallan porque todo es crítico.

### 2. Umbral con histéresis

Nunca uses el mismo valor para disparar y para reponer. Si avisas al pasar de 8 grados, repón a 6. Sin histéresis, un sensor oscilando alrededor del umbral genera 40 mensajes en una hora y el cliente silencia el chat para siempre.

### 3. Condición sostenida, no instantánea

Casi ningún dato instantáneo merece alarma. Exige que la condición se mantenga X minutos. Una puerta de cámara abierta 2 minutos es normal (están cargando); 15 minutos no lo es. Un pico de temperatura al abrir es normal; media hora por encima, no.

### 4. Ventanas horarias y contexto

«Puerta del local abierta» no es alarma a las 10:00 y sí lo es a las 4:00. Escribe las reglas con horario, día de la semana y estado (abierto/cerrado, vacaciones).

### 5. Sensor mudo: la alerta que casi nadie pone

Un sensor que deja de enviar no genera ninguna alarma de temperatura, porque no hay dato. Es el fallo silencioso más peligroso. Regla obligatoria: si un sensor crítico no reporta en el triple de su intervalo normal, avisa. Lo mismo para el gateway y para la conexión a internet.

### 6. Escalado y confirmación

Si el aviso crítico no se confirma en 10 minutos, avisa a la segunda persona. Si tampoco, a la tercera o llamada telefónica. Y que se pueda confirmar («recibido») para que pare de insistir. Sin confirmación, o insiste eternamente o se da por bueno sin que nadie lo haya visto.

### 7. Redundancia del canal

Si el aviso viaja por internet y lo que ha fallado es internet, no llega. Para lo crítico añade un camino independiente: SIM 4G en el gateway, sirena local, o aviso por SMS desde otro sitio que vigile que el sistema sigue vivo.

### 8. Prueba real, con el cliente delante

Provoca la condición de verdad: mete el sensor en un vaso de agua caliente, abre la puerta, desconecta el sensor. Cronometra cuánto tarda en llegar el aviso y a quién llega. Sin esta prueba no está entregado.

## Formato exacto de la respuesta

1. **Tabla de alertas**: nombre, condición exacta con valor y tiempo, nivel, destinatario, canal, ventana horaria, condición de reposición.
2. **Reglas de sensor mudo** para cada dispositivo crítico y para el gateway.
3. **Cadena de escalado** con tiempos y personas.
4. **Guion de prueba de aceptación**: cada alerta, cómo provocarla, resultado esperado, tiempo máximo.
5. **Resumen diario o semanal** que sustituye a los avisos informativos.

## Errores típicos

- Alarma a la primera lectura fuera de rango, sin tiempo sostenido.
- Sin histéresis: cascada de mensajes.
- Todo por correo, que nadie mira de noche.
- Ningún aviso de sensor caído.
- Avisar al dueño de todo y a nadie más: si está de viaje, no hay sistema.
- Entregar sin probar provocando la condición real.

## Avisos honestos

- Si el aviso protege género o personas, esto no sustituye a un sistema de alarma homologado ni a un termógrafo certificado si hay obligación sanitaria.
- Deja por escrito que el aviso depende de internet, luz y del móvil del cliente, y que puede fallar. Que quede claro antes, no después del incidente.
- Un sistema de avisos sin alguien que responda no protege nada: si nadie puede ir de noche, dilo y ajusta expectativas.
