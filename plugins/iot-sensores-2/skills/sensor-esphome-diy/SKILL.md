---
name: sensor-esphome-diy
description: Generates a complete, working ESPHome YAML configuration for an ESP32 or ESP8266 sensor node and explains flashing, GPIO pitfalls, filtering and OTA safety. Use when the user wants to build their own sensor, mentions ESPHome, ESP32, ESP8266, DIY smart devices, or wants to replace an expensive commercial sensor.
---

# Fabricar un sensor propio con ESPHome

## Qué hace
Produce el fichero YAML completo de ESPHome para un nodo concreto, elige los pines correctos, añade filtrado de lecturas y explica cómo grabarlo y actualizarlo sin ladrillar la placa.

## Cuándo se activa
Cuando el usuario quiere medir o detectar algo con hardware barato y no quiere programar en C.

## Qué preguntar
1. ¿Qué mide o detecta exactamente y con qué precisión le vale?
2. ¿Qué placa tiene? (ESP32 genérico, ESP32-C3, ESP8266 D1 mini, placa de la marca X)
3. ¿Qué sensor concreto? Modelo exacto: DHT22, BME280, DS18B20, SCT-013, final de carrera, etc.
4. ¿Alimentado por USB o por pilas?
5. ¿Cada cuánto necesita el dato? Cada 10 segundos y cada 10 minutos son proyectos distintos.

## Método
### 1. Elige el sensor con criterio
- Temperatura y humedad de interior fiables: BME280 por I2C. El DHT11 es basura, el DHT22 es aceptable pero lento y se autocalienta.
- Temperatura de tubería, depósito o exterior: DS18B20, va por un solo cable y admite varios en el mismo bus.
- Presencia real: mmWave. Movimiento a secas: PIR barato.
- Consumo eléctrico: pinza SCT-013 con resistencia de carga o un módulo con chip dedicado. Nunca abras el cuadro sin instalador.

### 2. Pines: la lista negra del ESP32
- GPIO 6 a 11: van a la memoria flash, no se tocan.
- GPIO 0, 2, 12, 15: condicionan el arranque, evítalos para entradas con pull-up externo.
- Los pines del ADC2 no leen cuando el Wi-Fi está activo. Para lecturas analógicas usa ADC1 (GPIO 32 a 39).
- GPIO 34 a 39 son solo entrada, no tienen resistencia interna.

### 3. Estructura del YAML
Incluye siempre: `substitutions` con nombre y sala, `esphome`, `esp32` o `esp8266`, `wifi` con `ap` de reserva, `captive_portal`, `logger`, `api` con clave de cifrado, `ota` con contraseña, y los sensores. Añade un `binary_sensor` de estado y un `sensor` de calidad de señal para poder diagnosticar después.

### 4. Filtrado, que es lo que separa un juguete de un sensor
- Añade `filters` con `median` o `sliding_window_moving_average` a cualquier lectura analógica.
- Usa `delta` o `throttle` para no inundar la base de datos con un dato por segundo.
- En sensores de temperatura, un `offset` de calibración comparado con un termómetro de referencia.

### 5. Pilas y sueño profundo
Si va con pilas necesitas `deep_sleep`. Cuidado: mientras duerme no se puede actualizar por aire. Configura siempre una ventana de espera al arrancar, o un pin que al puentearlo evite dormir. Si no, para cambiar el firmware tendrás que desmontarlo y usar el cable.

### 6. Grabar la primera vez
La primera grabación va por USB. Con navegador Chrome o Edge se puede usar el instalador web de ESPHome. Muchas placas chinas llevan chip CH340 y necesitan controlador. Si no aparece el puerto, casi siempre es el cable: hay cables USB solo de carga, sin datos.

## Formato exacto de la respuesta
1. **Lista de material** con cantidades y precio orientativo.
2. **Conexiones** en tabla: Pin del sensor | Pin de la placa | Nota.
3. **YAML completo** listo para pegar, comentado en español.
4. **Pasos de grabación** numerados.
5. **Cómo comprobar que va bien**: qué valores esperas ver y qué indica que algo falla.
6. **Mejoras para la versión 2**: caja, alimentación, protección.

## Errores típicos
- Alimentar un sensor de 5 V con 3,3 V y luego pelearse con lecturas erráticas.
- Olvidar las resistencias de pull-up de I2C o del DS18B20 (4,7 kΩ).
- No poner un condensador de desacoplo cerca del sensor: reinicios aleatorios.
- Guardar la clave de la API y la contraseña OTA solo en el portátil: si lo pierdes, el aparato es inaccesible por aire.

## Avisos honestos
- Nada de 230 V dentro de una caja improvisada. Si el proyecto toca la red eléctrica, usa módulos certificados y caja adecuada, y que lo conecte un instalador.
- Un montaje casero no lleva marcado CE y no se puede vender como producto. Para uso propio o instalado como parte de un servicio, es otra conversación: consúltala antes.
