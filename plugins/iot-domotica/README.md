# arsenal-iot-domotica · IoT y hardware · Domótica

IoT y hardware · Domótica: 3 skills, 2 subagentes, 2 comandos / en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-iot-domotica@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| automatizar-precio-luz | Comando / | Diseña automatizaciones que muevan el consumo de la casa a las horas baratas de la luz, con reglas seguras para no fastidiar electrodomésticos. | `/automatizar-precio-luz` o `/arsenal-iot-domotica:automatizar-precio-luz` |
| plan-sin-internet | Comando / | Revisa una instalación domótica y te dice qué dejaría de funcionar si se cae internet o cierra el fabricante, y cómo blindar lo importante. | `/plan-sin-internet` o `/arsenal-iot-domotica:plan-sin-internet` |
| alertas-sin-falsos-positivos | Skill | Diseña las alertas de un sistema IoT para que avisen cuando hay que avisar y no despierten a nadie por tonterías, incluida la alerta de sensor mudo. | se activa sola cuando hace falta |
| automatizacion-sin-falsos-disparos | Skill | Arregla automatizaciones que se disparan solas o se quedan colgadas, con histéresis, retardos y condiciones bien puestas. | se activa sola cuando hace falta |
| salir-de-la-nube-domotica | Skill | Plan para que tus aparatos funcionen sin depender de la nube del fabricante, sin romper lo que ya tienes montado. | se activa sola cuando hace falta |
| automatizaciones-home-assistant | Subagente | Subagente que escribe automatizaciones de Home Assistant en YAML que no dan falsos disparos ni molestan a la familia, con su prueba de aceptación. | pídele a Claude «usa el subagente automatizaciones-home-assistant» |
| plan-supervivencia-domotica | Subagente | Revisa qué se rompe en tu casa inteligente sin internet, servidor o luz y monta copias, plan B. | pídele a Claude «usa el subagente plan-supervivencia-domotica» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
