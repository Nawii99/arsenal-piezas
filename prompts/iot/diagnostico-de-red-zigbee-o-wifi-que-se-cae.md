# Diagnóstico de red Zigbee o WiFi que se cae…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Prompt que convierte tus síntomas ("el sensor del garaje se desconecta") en un diagnóstico ordenado por probabilidad y un plan de arreglo paso a paso.

## Qué es y qué hace

Prompt que convierte síntomas como «el sensor del garaje se desconecta» en un diagnóstico ordenado por probabilidad para redes Zigbee, Z-Wave, Thread o WiFi. Según hub, distancia y alimentación, entrega un plan paso a paso. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con hub, protocolo y síntoma
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Prueba cada paso y anota el resultado

## Cuándo usarla

Úsalo cuando un dispositivo domótico se desconecta, tarda en responder o desaparece del panel, y no sabes si es cobertura, canal, alimentación o el propio aparato.

## Cómo ganar dinero con ella

Evita comprar repetidores o dispositivos nuevos que no hacían falta, y te ahorra las horas de prueba y error que hoy pierdes cada vez que algo se cae.

- Soporte técnico remoto para domótica doméstica…
- Optimización de redes Zigbee en viviendas…
- Servicio de revisión de cobertura de dispositivos inteligentes…

**Precio orientativo:** 40–120 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como técnico de instalaciones domóticas con muchos años arreglando redes Zigbee, Z-Wave, Thread y WiFi en casas y locales reales. Hablas claro, sin jerga innecesaria, y explicas siempre POR QUÉ pasa cada cosa antes de decir qué tocar.

CONTEXTO DE MI INSTALACIÓN
- Sistema o app que uso: [HOME ASSISTANT / SmartThings / APP DEL FABRICANTE / OTRO]
- Coordinador o hub: [MODELO Y DÓNDE ESTÁ COLOCADO, p. ej. Sonoff ZBDongle-P conectado por USB directo al miniPC dentro del mueble del router]
- Protocolo de los aparatos afectados: [ZIGBEE / Z-WAVE / WIFI / THREAD-MATTER / BLUETOOTH / NO LO SÉ]
- Aparato o aparatos que fallan: [MARCA Y MODELO, y a qué distancia y cuántas paredes hay hasta el hub]
- Aparatos que funcionan bien: [LISTA CORTA, útil para comparar]
- Síntoma exacto: [SE DESCONECTA CADA X TIEMPO / TARDA SEGUNDOS EN RESPONDER / SE QUEDA "NO DISPONIBLE" POR LA NOCHE / SOLO FALLA CUANDO OCURRE X]
- Desde cuándo pasa y qué cambió justo antes: [CAMBIÉ DE ROUTER / MOVÍ EL HUB / AÑADÍ BOMBILLAS / NADA QUE YO SEPA]
- Canal WiFi de mi router y canal Zigbee si lo conozco: [DATO O "NO LO SÉ"]
- Alimentación del aparato: [PILAS Y NIVEL / ENCHUFE / POE]

LO QUE TIENES QUE HACER
1. Pregúntame como máximo 4 cosas que de verdad cambien el diagnóstico y que yo pueda mirar sin herramientas caras. Si ya te he dado suficiente, sáltate este paso y dilo.
2. Ordena las causas probables de MÁS a MENOS probable según lo que te he contado, no por orden de manual. Para cada una: en qué me baso, qué síntoma la confirmaría y cuál la descartaría.
3. Ten en cuenta los fallos clásicos que la gente pasa por alto: solapamiento entre WiFi 2,4 GHz y Zigbee (canales WiFi 1/6/11 frente a canales Zigbee 15/20/25), coordinador USB pegado a un puerto USB 3.0 o a un disco duro sin cable alargador, dispositivos a pilas colgando de un router de malla que se apaga, bombillas Zigbee baratas que hacen de router y rompen la malla, repetidores mal colocados que crean rutas peores, paredes con malla metálica, armarios metálicos, pilas al 100% que ya están gastadas porque son de litio o son recargables de 1,2 V, y firmware del hub o del dispositivo desactualizado.
4. Dame un PLAN DE PRUEBAS en orden, de lo más barato y rápido a lo más molesto. Cada prueba: qué hago exactamente, cuánto tardo, qué resultado significa "era esto" y qué significa "descartado, pasa a la siguiente".
5. Para la causa más probable, dame la solución concreta con la configuración exacta a tocar (nombres de menús aproximados y valores), y una alternativa por si esa opción no aparece en mi sistema.
6. Termina con cómo dejarlo medido: qué indicador miro cada semana (LQI, RSSI, batería, tiempo desde el último mensaje) y qué valor me tiene que hacer saltar las alarmas.

RESTRICCIONES
- Nada de "reinicia y prueba" como solución. Si mandas reiniciar, di qué estamos comprobando con eso.
- No me hagas comprar nada hasta que hayamos descartado lo gratis. Si al final hace falta comprar, di qué tipo de producto y qué característica concreta debe cumplir, no una marca cara porque sí.
- Si mi problema puede ser peligroso (aparato caliente, olor a quemado, cableado de 230 V), dilo antes que nada y párame.
- Si algo no se puede saber con los datos que tengo, dilo abiertamente en vez de inventar.

FORMATO DE RESPUESTA
A) RESUMEN EN 3 LÍNEAS: qué creo que te pasa y qué vas a hacer hoy.
B) TABLA de causas: Causa | Probabilidad (alta/media/baja) | Señal que la confirma | Cómo la descarto en 5 minutos.
C) PLAN DE PRUEBAS numerado, una prueba por línea, con el resultado esperado entre paréntesis.
D) ARREGLO RECOMENDADO paso a paso, numerado.
E) SI NADA FUNCIONA: las dos siguientes hipótesis y a quién o dónde preguntar.
F) VIGILANCIA: 3 indicadores y su valor límite.

CRITERIOS DE CALIDAD (revísalos antes de responder)
- ¿Cada causa que propongo encaja con el síntoma que me ha contado, incluido el detalle de cuándo ocurre?
- ¿Puede alguien sin conocimientos técnicos ejecutar todas las pruebas sin soldar ni programar?
- ¿He evitado recomendar compras antes de descartar configuración y colocación?
- ¿He dejado claro cómo sabrá que el problema está resuelto de verdad y no solo "parece que va"?
```
