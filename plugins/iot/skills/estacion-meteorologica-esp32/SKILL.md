---
name: estacion-meteorologica-esp32
description: Guía para montar una estación meteorológica casera con ESP32 y un sensor BME280, desde la lista de compra hasta ver los datos en el móvil. Se activa cuando el usuario quiere medir temperatura, humedad o presión en casa y no ha tocado nunca una placa.
---

# Estación meteorológica con ESP32

## Qué hace
Acompaña al usuario de principio a fin: qué comprar, cómo conectar los cuatro cables, el código listo para subir y cómo ver los datos desde el móvil Android. Todo con una placa ESP32 y un sensor BME280 (temperatura, humedad y presión). Sin soldar, sin protoboard.

## Antes de empezar, pregunta
1. ¿Tienes ya algo comprado? Si sí, pide marca y modelo exacto de la placa y del sensor. Si no, propón la lista del paso 1.
2. ¿Windows, Mac o Linux? Cambia el driver USB.
3. ¿Dónde quieres ver los datos? (a) en el navegador del móvil dentro de casa, (b) en Telegram, (c) en una hoja de Google. Empieza siempre por (a); lo demás es el paso 6.
4. ¿Interior o exterior? Exterior necesita caja estanca y sensor a la sombra. Propón empezar en interior y salir fuera cuando funcione.

## Paso a paso

### 1. Lista de compra
- Placa ESP32 DevKit (30 o 38 pines, con conector micro-USB o USB-C). Precio orientativo: [consultar en Amazon.es o tienda de electrónica española].
- Sensor BME280 en módulo I2C (4 pines: VIN, GND, SCL, SDA). Ojo: el BMP280 es más barato y no mide humedad. Si el anuncio no dice claramente "BME", probablemente es BMP.
- 4 cables dupont hembra-hembra.
- Cable USB de datos, no solo de carga. Es el fallo número uno: la placa se enciende pero el ordenador no la ve.

### 2. Conexión (4 cables)
| BME280 | ESP32 |
|---|---|
| VIN | 3V3 |
| GND | GND |
| SCL | GPIO 22 |
| SDA | GPIO 21 |
Comprueba dos veces antes de enchufar el USB. 3V3 funciona en todos los módulos; 5V solo si el módulo lleva regulador.

### 3. Preparar el ordenador
- Instala Arduino IDE 2.
- Archivo > Preferencias > URLs adicionales de gestor de tarjetas: pega `https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json`.
- Herramientas > Placa > Gestor de tarjetas > busca "esp32" (Espressif) e instala.
- Herramientas > Administrar bibliotecas > instala "Adafruit BME280 Library" y acepta instalar sus dependencias.
- Si el puerto no aparece al conectar la placa, instala el driver CP210x o CH340 según el chip que tenga la placa junto al USB (está escrito encima).

### 4. Código
Genera un sketch que: se conecte al WiFi del usuario (2,4 GHz; el ESP32 no ve redes de 5 GHz), lea el BME280 cada 30 segundos y sirva una página web sencilla con los tres valores en la IP de la placa. Deja SSID y contraseña en dos líneas claras al principio. Prueba la dirección I2C 0x76 y, si falla, 0x77; si no responde ninguna, que lo diga por Monitor Serie con un mensaje en español.
Explica cómo abrir el Monitor Serie a 115200 baudios para ver la IP que le da el router.

### 5. Subir y probar
- Herramientas > Placa: "ESP32 Dev Module". Herramientas > Puerto: el que apareció al conectar.
- Pulsa Subir. Si se queda en "Connecting....", mantén pulsado el botón BOOT de la placa hasta que empiece a escribir porcentajes.
- Abre el Monitor Serie, copia la IP, ábrela en el navegador del móvil (misma WiFi).

### 6. Siguiente nivel, solo si lo pide
- Enviar cada lectura a n8n por webhook y guardarla en Google Sheets.
- Aviso por Telegram si la humedad pasa de un umbral.
- Exterior: caja estanca con rejilla de ventilación, sensor a la sombra y lejos de la pared, cable USB desde dentro de casa.

## Qué devolver
1. Lista de compra con los nombres exactos que hay que escribir en el buscador de la tienda.
2. Tabla de conexiones.
3. El sketch completo en un solo archivo .ino, comentado en español.
4. Checklist de prueba de 5 puntos.
5. Apartado "si algo falla" con los cuatro errores típicos: cable solo de carga, red 5 GHz, dirección I2C, botón BOOT.

## Qué NO hacer
- No propongas soldar, protoboard ni resistencias en la primera versión. Todo dupont.
- No sugieras Raspberry Pi para esto: cuesta más y añade un sistema operativo que mantener.
- No mezcles MicroPython y Arduino en la misma respuesta. Arduino salvo que el usuario ya use Python.
- No entregues el código sin avisar de que lleva la contraseña del WiFi dentro y no debe compartirse ni subirse a GitHub.
- No inventes precios ni enlaces de tienda. Di dónde buscar y qué escribir.
- No des por hecho que el sensor funciona: el primer paso del código es comprobar que responde.
