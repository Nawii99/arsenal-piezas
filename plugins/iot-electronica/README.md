# arsenal-iot-electronica · IoT y hardware · Electrónica, firmware y montaje

IoT y hardware · Electrónica, firmware y montaje: 6 subagentes, 3 comandos /, 2 skills en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-iot-electronica@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| depurar-montaje | Comando / | Te guía paso a paso para encontrar por qué un montaje electrónico no funciona, con el multímetro y sin quemar nada más. | `/depurar-montaje` o `/arsenal-iot-electronica:depurar-montaje` |
| elegir-caja-y-cableado | Comando / | Elige la caja, el grado de protección, la fuente de alimentación y la sección de cable para que tu montaje aguante fuera del escritorio. | `/elegir-caja-y-cableado` o `/arsenal-iot-electronica:elegir-caja-y-cableado` |
| firmware-esphome | Comando / | Escribe la configuración de ESPHome para un ESP32 o ESP8266 que haga una tarea concreta, con pines, calibración y avisos de seguridad. | `/firmware-esphome` o `/arsenal-iot-electronica:firmware-esphome` |
| averias-bus-rs485-i2c | Skill | Encuentra por qué un bus Modbus, RS485 o I2C falla a ratos: terminaciones, tierras, longitudes y apantallado. | se activa sola cuando hace falta |
| flasheo-firmware-con-vuelta-atras | Skill | Cambia el firmware de un cacharro (Tasmota, ESPHome) con un plan de rescate para no dejarlo muerto. | se activa sola cuando hace falta |
| depurador-bus-i2c-spi | Subagente | Subagente que te saca del atasco cuando un sensor no responde por I2C o SPI, con un método de descarte ordenado en vez de ir a ciegas. | pídele a Claude «usa el subagente depurador-bus-i2c-spi» |
| depurador-esp32 | Subagente | Subagente que diagnostica placas ESP32 y ESP8266 que se reinician, no arrancan o pierden el wifi, leyendo los mensajes del puerto serie. | pídele a Claude «usa el subagente depurador-esp32» |
| diagnostico-averia-placa | Subagente | Subagente que te guía con el multímetro para averiguar por qué una placa o un aparato no arranca, sin pegar tiros al aire. | pídele a Claude «usa el subagente diagnostico-averia-placa» |
| limites-de-seguridad-230v | Subagente | Subagente que te dice qué puedes tocar tú, qué tiene que hacer un instalador autorizado y cómo montar la parte de red eléctrica sin jugártela. | pídele a Claude «usa el subagente limites-de-seguridad-230v» |
| seleccionador-componentes | Subagente | Subagente que elige los componentes de tu prototipo electrónico, saca la lista de compra con alternativas y detecta lo que no encaja. | pídele a Claude «usa el subagente seleccionador-componentes» |
| traductor-de-datasheet | Subagente | Lee la hoja de datos de un sensor y te da conexionado, avisos de tensión y código mínimo que funciona. | pídele a Claude «usa el subagente traductor-de-datasheet» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
