# arsenal-iot-instalaciones · IoT y hardware · Instalaciones para clientes

IoT y hardware · Instalaciones para clientes: 12 comandos /, 6 subagentes, 3 skills en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-iot-instalaciones@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| acta-entrega | Comando / | El acta de entrega de una instalación domótica: qué va, cómo se usa, claves y garantía. | `/acta-entrega` |
| aislar-dispositivos-espia | Comando / | Revisa qué cámaras, enchufes y aspiradoras de tu casa hablan con servidores fuera y te monta el plan para aislarlos sin quedarte sin funciones. | `/aislar-dispositivos-espia` |
| arreglar-wifi-iot | Comando / | Ordena tu red WiFi para que bombillas, enchufes y cámaras no se desconecten cada dos por tres. | `/arreglar-wifi-iot` |
| calcular-alimentacion | Comando / | Dimensiona la fuente de alimentación y el grosor del cable para tiras LED, relés o sensores, para que no se caiga la tensión ni se caliente nada. | `/calcular-alimentacion` |
| contar-clientes | Comando / | Monta un contador de personas o de paso en un negocio con sensores baratos y saca informes de horas punta para decidir horarios y personal. | `/contar-clientes` |
| dossier-entrega-cliente | Comando / | Genera el dossier de entrega de una instalación domótica: manual para el cliente, esquema de lo instalado, contraseñas y acta de conformidad. | `/dossier-entrega-cliente` |
| inventario-firmware | Comando / | Monta el inventario de todos tus cacharros conectados con su firmware, y te dice cuáles actualizar, cuáles no tocar y cuáles ya están abandonados. | `/inventario-firmware` |
| inventario-iot | Comando / | Levanta el inventario de todos los aparatos conectados de una casa o local, con su ficha, sus claves y qué pasa si falla cada uno. | `/inventario-iot` |
| mantenimiento-domotica | Comando / | Convierte una instalación ya entregada en un contrato de mantenimiento con cuota mensual, con qué incluye y qué se revisa cada mes. | `/mantenimiento-domotica` |
| mantenimiento-remoto | Comando / | Monta el servicio de mantenimiento mensual de instalaciones domóticas: qué monitorizas, qué revisas cada mes y qué informe mandas al cliente. | `/mantenimiento-remoto` |
| politica-alertas | Comando / | Diseña qué avisos debe mandar tu sistema y cuáles no, con umbrales y retardos, para que las alertas importantes no se pierdan entre el ruido. | `/politica-alertas` |
| presupuesto-domotica | Comando / | Prepara el presupuesto de una instalación domótica o de sensores para un cliente, con partidas, mano de obra, condiciones y letra pequeña. | `/presupuesto-domotica` |
| entrega-y-manual-cliente | Skill | Prepara la entrega de una instalación al cliente: prueba de aceptación, manual en su idioma, credenciales y lo que hay que firmar para cerrar el proyecto. | se activa sola cuando hace falta |
| inventario-y-entrega-instalacion | Skill | Documenta una instalación domótica para poder mantenerla, cobrarla y traspasarla: nombres, plano, credenciales y acta de entrega. | se activa sola cuando hace falta |
| leer-maquina-antigua-skill | Skill | Saca datos de una máquina o instalación vieja que no es inteligente (contador, horno, compresor, bomba) sin modificarla ni perder la garantía. | se activa sola cuando hace falta |
| depurador-esp32 | Subagente | Subagente que diagnostica placas ESP32 y ESP8266 que se reinician, no arrancan o pierden el wifi, leyendo los mensajes del puerto serie. | pídele a Claude «usa el subagente depurador-esp32» |
| diagnostico-red-zigbee | Subagente | Subagente que arregla redes Zigbee o de malla donde los sensores se caen, tardan o aparecen como no disponibles. | pídele a Claude «usa el subagente diagnostico-red-zigbee» |
| dossier-entrega-instalacion | Subagente | Convierte una instalación domótica terminada en dossier: inventario, esquema, manual del cliente y mantenimiento. | pídele a Claude «usa el subagente dossier-entrega-instalacion» |
| manual-entrega-instalacion | Subagente | Subagente que redacta el manual de entrega de una instalación: cómo se usa, dónde está cada cosa, qué hacer si falla y qué cubre tu garantía. | pídele a Claude «usa el subagente manual-entrega-instalacion» |
| piloto-de-sensores-subagente-revisor | Subagente | Sensores auditados: medibles, que alguien puede mantener, respeta privacidad. | pídele a Claude «usa el subagente piloto-de-sensores-subagente-revisor» |
| presupuesto-instalacion-iot | Subagente | Subagente que convierte lo que quiere el cliente en lista de materiales, horas de trabajo y un presupuesto con partidas, condiciones y opciones. | pídele a Claude «usa el subagente presupuesto-instalacion-iot» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
