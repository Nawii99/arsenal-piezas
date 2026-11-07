---
name: cableado-y-alimentacion
description: "Dimensiona fuentes de alimentación y cableado para una instalación de sensores o controladores: presupuesto de corriente, caída de tensión con la distancia, tipo de cable, PoE frente a alimentación local, fusibles y puesta a tierra. Úsala cuando un proyecto pase del escritorio a un edificio real, o cuando los dispositivos se reinicien al azar o se comporten de forma errática."
---

# Alimentación y cableado de una instalación

## Qué hace

Convierte una lista de dispositivos en un plan de alimentación y cableado que funcione: cuántos amperios necesitas, qué sección de cable, cuánto pierdes por distancia, dónde poner la fuente y qué proteger.

## Cuándo se activa

- Vas a alimentar varios sensores, relés o tiras LED desde una fuente.
- Hay que llevar 5 V o 12 V a 20 metros.
- Un dispositivo se reinicia solo, pierde WiFi al activar un relé, o el sensor da lecturas locas cuando arranca un motor.
- Estás decidiendo entre PoE y fuente local.

## Qué preguntar antes de responder

1. Lista de dispositivos con su tensión (5 V, 12 V, 24 V) y consumo en reposo y en pico.
2. Distancia desde la fuente a cada dispositivo.
3. ¿Interior o exterior? ¿Humedad, polvo, temperatura?
4. ¿Hay motores, contactores o máquinas grandes cerca?
5. ¿Se puede pasar cable nuevo o hay que aprovechar el existente?
6. ¿Es una instalación de cliente que debe quedar en caja y con protección?

## Método paso a paso

### 1. Presupuesto de corriente

Suma el consumo en pico de todo, no el medio. Un ESP32 en reposo consume poco, pero en el pico de transmisión WiFi pide bastante más, y ese pico es el que provoca los reinicios. Regla: fuente dimensionada al menos al 130-150 % del pico total. Una fuente al 100 % justa se calienta, envejece y falla.

### 2. Caída de tensión

Cuanto más baja la tensión, más te duele la distancia. A 5 V, 10 metros de cable fino ya te dejan al dispositivo por debajo de lo que necesita. Reglas prácticas: para tiradas largas, alimenta a 12 o 24 V y baja a 5 V con un convertidor junto al dispositivo; sube la sección del cable; o inyecta alimentación por los dos extremos en tiras LED. Si un dispositivo funciona con la fuente al lado y falla instalado, casi siempre es caída de tensión.

### 3. PoE cuando puedas

Un solo cable de red que lleva datos y corriente ahorra enchufes, es más fiable y llega a 100 metros. Es la mejor opción para cámaras, puntos de acceso y controladores fijos. Necesitas switch PoE o inyector, y comprobar el estándar de potencia que pide el aparato.

### 4. Elegir el cable

- Datos Ethernet: cable de par trenzado apantallado si va cerca de fuerza.
- RS-485/Modbus: par trenzado, obligatorio, con terminación al final del bus. Longitudes largas sí, pero en bus, nunca en estrella.
- Alimentación: sección acorde a corriente y distancia; ante la duda, sube una medida.
- Exterior: cable con protección UV y prensaestopas; el cable de interior en el jardín dura dos veranos.
- Nunca metas cable de señal en el mismo tubo que la fuerza si puedes evitarlo.

### 5. Protección

Fusible o magnetotérmico en el primario, fusible en la salida de la fuente si alimenta varias ramas, y protección diferencial en el cuadro. En exterior, descargador de sobretensiones si hay tormentas frecuentes: una tormenta te lleva la instalación entera.

### 6. Masas comunes

Si mezclas fuentes distintas, une las masas o tendrás lecturas locas y comunicaciones que fallan. Es el error clásico con sensores analógicos y con RS-485.

### 7. Cajas y montaje

Todo en caja: carril DIN si es cuadro, caja estanca con grado IP adecuado si es exterior o zona húmeda. Nada de fuentes colgando ni regletas al aire en casa de un cliente. Etiqueta cada cable en los dos extremos.

## Formato exacto de la respuesta

1. **Tabla de consumos**: dispositivo, tensión, consumo pico, distancia.
2. **Fuente o fuentes recomendadas** con tensión y amperaje, y el margen aplicado.
3. **Plan de cableado por tramos**: tipo de cable, sección, longitud, por dónde va.
4. **Protecciones** y dónde se colocan.
5. **Lista de material** con cantidades, incluyendo caja, prensaestopas, bornes y etiquetas.
6. **Comprobaciones finales**: tensión medida en el punto más lejano con todo encendido, prueba de 24 horas.

## Errores típicos

- Alimentar a 5 V a 15 metros con cable de teléfono.
- Elegir la fuente exacta al consumo medio y no al pico.
- Bus RS-485 cableado en estrella y sin terminación.
- No unir masas entre fuentes distintas.
- Alimentar tiras LED por un solo extremo y ver el otro extremo amarillento.
- Dejar la instalación con regletas y cinta aislante en casa de un cliente.

## Avisos honestos

- Todo lo que sea tocar el cuadro eléctrico, circuitos de 230 V o la instalación fija de un local debe hacerlo un instalador autorizado. Diseñar la parte de baja tensión y los sensores sí puedes; conectar a la red, no.
- Las fuentes muy baratas sin marca son la causa habitual de reinicios fantasma. Ahorrar diez euros ahí te cuesta horas de depuración.
- Si el edificio es antiguo y no sabes qué hay detrás de la pared, no taladres: pregunta y usa detector.
