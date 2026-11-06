---
name: estacion-meteorologica-esp32-en
description: Guide to building a homemade weather station with an ESP32 and a BME280 sensor, from the shopping list to seeing the data on your phone. It activates when the user wants to measure temperature, humidity, or pressure at home and has never touched a board.
---

# Weather station with ESP32

## What it does
It accompanies the user from start to finish: what to buy, how to connect the four wires, the code ready to upload, and how to see the data from an Android phone. All with an ESP32 board and a BME280 sensor (temperature, humidity, and pressure). No soldering, no breadboard.

## Before starting, ask
1. Have you already bought anything? If so, ask for the exact brand and model of the board and the sensor. If not, propose the list from step 1.
2. Windows, Mac, or Linux? It changes the USB driver.
3. Where do you want to see the data? (a) in the phone's browser inside the house, (b) on Telegram, (c) in a Google Sheet. Always start with (a); the rest is step 6.
4. Indoors or outdoors? Outdoors needs a waterproof box and the sensor in the shade. Propose starting indoors and moving outside once it works.

## Step by step

### 1. Shopping list
- ESP32 DevKit board (30 or 38 pins, with a micro-USB or USB-C connector). Approximate price: [check Amazon or an electronics store].
- BME280 sensor on an I2C module (4 pins: VIN, GND, SCL, SDA). Careful: the BMP280 is cheaper and does not measure humidity. If the listing does not clearly say "BME," it is probably a BMP.
- 4 female-to-female dupont jumper wires.
- USB data cable, not just a charging cable. This is failure number one: the board lights up but the computer does not see it.

### 2. Wiring (4 wires)
| BME280 | ESP32 |
|---|---|
| VIN | 3V3 |
| GND | GND |
| SCL | GPIO 22 |
| SDA | GPIO 21 |
Double-check before plugging in the USB. 3V3 works on all modules; 5V only if the module has a regulator.

### 3. Prepare the computer
- Install Arduino IDE 2.
- File > Preferences > Additional boards manager URLs: paste `https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json`.
- Tools > Board > Boards Manager > search "esp32" (Espressif) and install.
- Tools > Manage Libraries > install "Adafruit BME280 Library" and agree to install its dependencies.
- If the port does not appear when you connect the board, install the CP210x or CH340 driver depending on the chip the board has next to the USB (it is written on top).

### 4. Code
Generate a sketch that: connects to the user's WiFi (2.4 GHz; the ESP32 does not see 5 GHz networks), reads the BME280 every 30 seconds, and serves a simple web page with the three values at the board's IP. Leave the SSID and password on two clear lines at the top. Try the I2C address 0x76 and, if it fails, 0x77; if neither responds, have it say so in the Serial Monitor with a clear message.
Explain how to open the Serial Monitor at 115200 baud to see the IP the router gives it.

### 5. Upload and test
- Tools > Board: "ESP32 Dev Module". Tools > Port: the one that appeared when you connected it.
- Press Upload. If it stays at "Connecting....", hold down the BOOT button on the board until it starts writing percentages.
- Open the Serial Monitor, copy the IP, and open it in the phone's browser (same WiFi).

### 6. Next level, only if requested
- Send each reading to n8n by webhook and save it in Google Sheets.
- Telegram alert if humidity goes above a threshold.
- Outdoors: waterproof box with a ventilation grille, sensor in the shade and away from the wall, USB cable from inside the house.

## What to return
1. Shopping list with the exact names to type into the store's search.
2. Wiring table.
3. The complete sketch in a single .ino file, commented.
4. 5-point test checklist.
5. A "if something fails" section with the four typical errors: charge-only cable, 5 GHz network, I2C address, BOOT button.

## What NOT to do
- Do not propose soldering, a breadboard, or resistors in the first version. All dupont.
- Do not suggest a Raspberry Pi for this: it costs more and adds an operating system to maintain.
- Do not mix MicroPython and Arduino in the same answer. Arduino unless the user already uses Python.
- Do not deliver the code without warning that it contains the WiFi password and must not be shared or uploaded to GitHub.
- Do not invent prices or store links. Say where to look and what to type.
- Do not assume the sensor works: the first step of the code is to check that it responds.
