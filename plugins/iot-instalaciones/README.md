# arsenal-iot-instalaciones · IoT y hardware · Instalaciones para clientes

IoT y hardware · Instalaciones para clientes: 5 comandos /, 2 skills, 2 subagentes en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-iot-instalaciones@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| dossier-entrega-cliente | Comando / | Genera el dossier de entrega de una instalación domótica: manual para el cliente, esquema de lo instalado, contraseñas y acta de conformidad. | `/dossier-entrega-cliente` o `/arsenal-iot-instalaciones:dossier-entrega-cliente` |
| inventario-firmware | Comando / | Monta el inventario de todos tus cacharros conectados con su firmware, y te dice cuáles actualizar, cuáles no tocar y cuáles ya están abandonados. | `/inventario-firmware` o `/arsenal-iot-instalaciones:inventario-firmware` |
| inventario-iot | Comando / | Levanta el inventario de todos los aparatos conectados de una casa o local, con su ficha, sus claves y qué pasa si falla cada uno. | `/inventario-iot` o `/arsenal-iot-instalaciones:inventario-iot` |
| mantenimiento-domotica | Comando / | Convierte una instalación ya entregada en un contrato de mantenimiento con cuota mensual, con qué incluye y qué se revisa cada mes. | `/mantenimiento-domotica` o `/arsenal-iot-instalaciones:mantenimiento-domotica` |
| presupuesto-domotica | Comando / | Prepara el presupuesto de una instalación domótica o de sensores para un cliente, con partidas, mano de obra, condiciones y letra pequeña. | `/presupuesto-domotica` o `/arsenal-iot-instalaciones:presupuesto-domotica` |
| importar-hardware-iot | Skill | Calcula el coste real de traer placas y sensores de fuera (IVA, aduanas, plazos) y qué responsabilidad asumes al importar. | se activa sola cuando hace falta |
| viabilidad-producto-iot | Skill | Analiza si tu idea de aparato conectado puede ser un producto vendible: coste de materiales, precio, certificación y qué probar primero. | se activa sola cuando hace falta |
| checklist-vender-cacharro | Subagente | Subagente que te dice qué hace falta para poder vender legalmente en España un aparato electrónico que has fabricado o montado tú. | pídele a Claude «usa el subagente checklist-vender-cacharro» |
| visita-tecnica-domotica | Subagente | Prepara la visita previa: checklist de qué mirar, qué preguntar y avisos de riesgos eléctricos. | pídele a Claude «usa el subagente visita-tecnica-domotica» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
