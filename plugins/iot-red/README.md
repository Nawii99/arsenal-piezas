# arsenal-iot-red · IoT y hardware · Redes y conectividad IoT

IoT y hardware · Redes y conectividad IoT: 4 skills, 3 comandos /, 1 subagente en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-iot-red@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| aislar-dispositivos-espia | Comando / | Revisa qué cámaras, enchufes y aspiradoras de tu casa hablan con servidores fuera y te monta el plan para aislarlos sin quedarte sin funciones. | `/aislar-dispositivos-espia` o `/arsenal-iot-red:aislar-dispositivos-espia` |
| canales-inalambricos | Comando / | Diagnostica interferencias entre el WiFi, el Zigbee y el Thread de una casa y te dice qué canal poner en cada cosa para que deje de fallar. | `/canales-inalambricos` o `/arsenal-iot-red:canales-inalambricos` |
| diagnosticar-red-zigbee | Comando / | Encuentra por qué tus dispositivos Zigbee o Z-Wave se desconectan, tardan o responden a medias, y te da el plan de arreglo por orden de impacto. | `/diagnosticar-red-zigbee` o `/arsenal-iot-red:diagnosticar-red-zigbee` |
| auditoria-wifi-24-para-iot | Skill | Revisa tu red de casa o del local para que los cacharros IoT dejen de desconectarse, y te da los ajustes exactos del router. | se activa sola cuando hace falta |
| diagnosticar-red-iot | Skill | Ordena el diagnóstico cuando los dispositivos inteligentes se desconectan solos, tardan en responder o desaparecen de la app. | se activa sola cuando hace falta |
| elegir-protocolo-iot | Skill | Qué sistema (Zigbee, Wi-Fi, Z-Wave) para tu instalación según distancia, batería y presupuesto. | se activa sola cuando hace falta |
| seguridad-red-iot | Skill | Asegura una instalación con cámaras y aparatos conectados: separar redes, cerrar accesos desde internet y quitar contraseñas de fábrica, sin romper lo que ya funciona. | se activa sola cuando hace falta |
| arquitecto-mqtt | Subagente | Diseña la estructura de mensajes MQTT de tu instalación: nombres ordenados, retención y descubrimiento. | pídele a Claude «usa el subagente arquitecto-mqtt» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
