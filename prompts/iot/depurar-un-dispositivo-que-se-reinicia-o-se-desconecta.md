# Depurar un dispositivo que se reinicia o se desconecta…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Un interrogatorio técnico guiado para averiguar por qué una placa ESP32, un Shelly o un sensor WiFi se cuelga, se reinicia solo o desaparece de la red.

## Qué es y qué hace

Prompt de interrogatorio técnico guiado para averiguar por qué un ESP32, Shelly o sensor WiFi se cuelga, reinicia o desaparece de la red. Empieza por alimentación y cableado, que causan la mayoría de cuelgues. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con dispositivo y síntomas
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Responde a sus preguntas y prueba paso a paso

## Cuándo usarla

Úsalo cuando un aparato funciona en el banco de pruebas pero falla al ponerlo en su sitio, o se cuelga cada pocas horas o días.

## Cómo ganar dinero con ella

Te ahorra horas de prueba y error y de piezas devueltas, y evita entregar a un cliente un montaje que fallará a la semana.

- Soporte técnico de dispositivos que se reinician…
- Revisión de instalaciones con Shelly y Sonoff…

**Precio orientativo:** 30–70 € por hora. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como técnico de electrónica y sistemas embebidos que lleva años depurando montajes con ESP32, ESP8266, Shelly, Sonoff y placas similares en instalaciones reales. Sabes que el 70 % de los cuelgues son de alimentación o de cableado, no de código ni de WiFi. Me explicas las cosas sin dar por hecho que sé electrónica.

QUÉ TENGO MONTADO
- Placa o dispositivo: [MODELO EXACTO]
- Firmware: [ESPHOME / TASMOTA / ARDUINO PROPIO / FIRMWARE DE FÁBRICA / OTRO]
- Qué tiene conectado: [SENSORES, RELÉS, TIRA LED, MOTOR, PANTALLA, ETC. CON MODELO]
- Cómo lo alimento: [CARGADOR DE MÓVIL DE X AMPERIOS / FUENTE DE X V Y A / USB DEL ORDENADOR / BATERÍA / POE]
- Longitud y tipo de cable de alimentación: [DESCRIPCIÓN]
- Dónde está instalado: [CAJA ESTANCA, DETRÁS DE UN INTERRUPTOR, EN EL EXTERIOR, EN EL CUADRO, ETC.]
- Temperatura del sitio: [FRÍO / NORMAL / CALIENTE / EXTERIOR]
- Síntoma exacto: [SE REINICIA / SE CUELGA SIN REINICIAR / PIERDE EL WIFI / EL SENSOR DA VALORES RAROS / SOLO FALLA CUANDO OCURRE X]
- Cada cuánto pasa y si hay patrón horario: [RESPUESTA]
- Distancia y obstáculos hasta el router WiFi: [RESPUESTA]
- ¿Funciona bien encima de la mesa con el USB del ordenador?: [SÍ / NO / NO LO HE PROBADO]

CÓMO QUIERO QUE LO ANALICES
1. Sepáralo en cuatro sospechosos y ordénalos por probabilidad para mi caso concreto: alimentación, cableado y conexiones, red WiFi, firmware o configuración.
2. Alimentación: explícame el concepto de pico de corriente y por qué un cargador que 'pone 2 A' puede no bastar cuando conmuta un relé o enciende una tira LED. Dime qué caída de tensión es sospechosa, qué condensador de desacoplo poner y dónde, y por qué un cable USB fino y largo tumba un ESP32.
3. Cableado: puntos típicos de fallo, soldaduras frías, regletas mal apretadas, masas separadas, cables de sensor demasiado largos, cables de datos pasando pegados a cables de 230 V.
4. WiFi: recuérdame que estas placas solo van en 2,4 GHz, cómo comprobar la potencia de señal recibida, qué valor es aceptable y qué valor es malo, y qué hace un router que separa mal las bandas o que tiene aislamiento de clientes activado.
5. Firmware: qué es un watchdog, qué es un reinicio por brownout y cómo distinguir en los mensajes de arranque un reinicio por falta de tensión de un reinicio por error de programa.
6. Dame un protocolo de pruebas en orden, de la más fácil a la más pesada, donde cada prueba descarte una familia entera de causas. Prueba de sustitución, prueba de aislamiento, prueba de carga.
7. Explícame cómo dejar el dispositivo registrando durante 24 horas para cazar un fallo intermitente y qué tres datos debo apuntar.

RESTRICCIONES DE SEGURIDAD
- Si algo de lo que propones implica 230 V, dilo con un aviso claro y recuérdame desconectar el magnetotérmico. Nada de trabajar con tensión.
- No propongas modificaciones internas de aparatos con certificación si eso anula la garantía o la seguridad: avísame antes.
- No des por sentado que tengo osciloscopio. Da alternativas con un multímetro de 20 euros y, si de verdad hace falta más, dilo.

FORMATO DE LA RESPUESTA
A) 'Sospechoso número uno' en dos líneas y por qué.
B) Tabla 'Pruebas': número | prueba | qué necesito | qué resultado significa culpable | qué resultado significa inocente.
C) 'Arreglos' ordenados por coste: arreglo | material | dificultad de 1 a 5 | riesgo.
D) 'Qué apuntar durante 24 horas' con el formato exacto de la tabla de registro.
E) 'Cuándo tirar la toalla y cambiar el aparato': criterios concretos.

CRITERIOS DE CALIDAD
- Cada prueba debe descartar cosas, no solo 'ver qué pasa'.
- Si el síntoma que te he dado ya apunta claramente a una causa, dilo en la primera línea en vez de darme un listado genérico.
- Nada de recomendarme comprar material antes de haber hecho al menos dos pruebas gratis.
```
