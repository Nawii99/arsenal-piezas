# arsenal-iot-varios · IoT y hardware · Más de iot y hardware

IoT y hardware · Más de iot y hardware: 5 subagentes, 4 comandos /, 3 skills en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-iot-varios@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| depurar-montaje | Comando / | Te guía paso a paso para encontrar por qué un montaje electrónico no funciona, con el multímetro y sin quemar nada más. | `/depurar-montaje` |
| firmware-esphome | Comando / | Escribe la configuración de ESPHome para un ESP32 o ESP8266 que haga una tarea concreta, con pines, calibración y avisos de seguridad. | `/firmware-esphome` |
| leer-datasheet | Comando / | Coge la hoja de datos de un componente o módulo y te saca en claro lo que necesitas para conectarlo sin quemarlo. | `/leer-datasheet` |
| leer-maquina-antigua | Comando / | Te dice cómo sacar datos de una máquina, contador o caldera que no es inteligente, sin tocar sus tripas ni perder la garantía. | `/leer-maquina-antigua` |
| flasheo-firmware-con-vuelta-atras | Skill | Cambia el firmware de un cacharro (Tasmota, ESPHome) con un plan de rescate para no dejarlo muerto. | se activa sola cuando hace falta |
| medir-ahorro-electrico-real | Skill | Mide el consumo real de tus aparatos y calcula si un cambio se paga solo, con tu tarifa y sin cuentos. | se activa sola cuando hace falta |
| viabilidad-producto-iot | Skill | Analiza si tu idea de aparato conectado puede ser un producto vendible: coste de materiales, precio, certificación y qué probar primero. | se activa sola cuando hace falta |
| checklist-vender-cacharro | Subagente | Subagente que te dice qué hace falta para poder vender legalmente en España un aparato electrónico que has fabricado o montado tú. | pídele a Claude «usa el subagente checklist-vender-cacharro» |
| depurador-bus-i2c-spi | Subagente | Subagente que te saca del atasco cuando un sensor no responde por I2C o SPI, con un método de descarte ordenado en vez de ir a ciegas. | pídele a Claude «usa el subagente depurador-bus-i2c-spi» |
| diagnostico-averia-placa | Subagente | Subagente que te guía con el multímetro para averiguar por qué una placa o un aparato no arranca, sin pegar tiros al aire. | pídele a Claude «usa el subagente diagnostico-averia-placa» |
| limites-de-seguridad-230v | Subagente | Subagente que te dice qué puedes tocar tú, qué tiene que hacer un instalador autorizado y cómo montar la parte de red eléctrica sin jugártela. | pídele a Claude «usa el subagente limites-de-seguridad-230v» |
| sacar-dispositivos-de-la-nube | Subagente | Subagente que planifica cómo pasar aparatos que dependen de la app del fabricante a control local, sin quedarte con ladrillos. | pídele a Claude «usa el subagente sacar-dispositivos-de-la-nube» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
