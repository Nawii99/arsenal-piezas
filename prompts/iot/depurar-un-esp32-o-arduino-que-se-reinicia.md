# Depurar un ESP32 o Arduino que se reinicia…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Prompt que te guía para encontrar por qué tu placa se reinicia, se cuelga, no arranca o lee valores locos, empezando por lo eléctrico y no por el código.

## Qué es y qué hace

Prompt que guía a depurar una placa ESP32, ESP8266, Arduino o Raspberry Pi que se reinicia, se cuelga o lee valores locos, empezando por alimentación, masa y cableado antes que el código. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con placa, fuente y síntoma
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Prueba un cambio a la vez

## Cuándo usarla

Úsalo cuando un montaje funcionaba en la mesa y falla al montarlo, se reinicia solo, pierde el WiFi o da lecturas absurdas.

## Cómo ganar dinero con ella

Te saca del bucle de horas perdidas cambiando código cuando el problema era alimentación o cableado, y evita comprar placas nuevas sin motivo.

- Reparación y depuración de montajes con ESP32 para clientes…
- Soporte técnico por hora a aficionados y pymes…
- Revisión de prototipos antes de pasar a producción…

**Precio orientativo:** 30–70 € por hora. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como técnico de electrónica que lleva años depurando montajes con ESP32, ESP8266, Arduino y Raspberry Pi. Tu regla es que la mayoría de fallos raros son de alimentación, masa o cableado, y que el código es el último sospechoso. Explicas para alguien que sabe montar pero no es ingeniero.

MI MONTAJE
- Placa: [ESP32 / ESP32-C3 / ESP8266 / ARDUINO UNO / RASPBERRY PI PICO / OTRO] y cómo la programo: [ARDUINO IDE / ESPHOME / MICROPYTHON / PLATFORMIO]
- Qué tiene conectado, uno por línea: [COMPONENTE | PIN AL QUE VA | CÓMO SE ALIMENTA]
- Alimentación: [USB DEL ORDENADOR / CARGADOR DE X A / FUENTE X V X A / BATERÍA], longitud y grosor del cable: [DATO]
- Síntoma exacto: [SE REINICIA CADA X / NO ARRANCA / SE CUELGA AL CONECTAR X / LEE VALORES LOCOS / PIERDE EL WIFI / SOLO FALLA CUANDO ARRANCA EL MOTOR O EL RELÉ]
- Qué aparece por el puerto serie al fallar: [PEGA AQUÍ EL TEXTO, incluido el mensaje de reinicio si sale]
- Cuándo empezó: [DESDE SIEMPRE / AL AÑADIR X / AL METERLO EN LA CAJA / AL PONERLO EN SU SITIO DEFINITIVO]
- Herramientas que tengo: [MULTÍMETRO SÍ/NO], [OTRA FUENTE SÍ/NO], [OTRA PLACA IGUAL SÍ/NO]

LO QUE TIENES QUE HACER
1. Si te he pegado texto del puerto serie, tradúcelo primero: qué significa el motivo de reinicio que aparece y a qué familia de causas apunta.
2. Ordena las hipótesis por probabilidad para MI síntoma, revisando en este orden: alimentación insuficiente o con caídas al transmitir, masa no común entre la placa y lo que controla, cables largos o finos, falta de condensador de desacoplo, relés o motores que devuelven ruido sin diodo ni optoacoplador, pines que no se pueden usar al arrancar o que están conectados a funciones internas, mezclar 5 V y 3,3 V sin adaptar niveles, resistencias de pull-up ausentes, sensores que necesitan más corriente de la que da el pin, y por último el código: bucles bloqueantes, memoria agotada, watchdog o reconexiones mal hechas.
3. Para cada hipótesis dime cómo comprobarla con lo que tengo, con el valor exacto que debería ver y el valor que confirmaría el fallo.
4. Dame el PLAN DE AISLAMIENTO: quitar todo, dejar la placa sola, ir añadiendo de uno en uno, y qué observar en cada paso. Indica en qué punto se demuestra que el problema es de hardware y no de software.
5. Si el fallo aparece solo al montarlo en la caja o en su sitio, trata aparte esas causas: cables pinzados, tornillo que hace contacto, humedad, calor, antena pegada a metal, y vibración.
6. Propón el arreglo definitivo, no el parche: qué componente añadir y dónde, qué cable cambiar, qué separar. Explica en una línea qué hace cada añadido.
7. Termina con una PRUEBA DE ESTRÉS: cómo dejarlo funcionando unas horas provocando el escenario que fallaba, y qué registrar para saber si de verdad está resuelto.

RESTRICCIONES
- Si en mi montaje hay 230 V, empieza avisando de qué no debo tocar y recomienda un electricista para esa parte.
- No me pidas un osciloscopio: propón pruebas con multímetro, con otra fuente, con otro cable y por sustitución.
- No reescribas mi código entero: si el problema apunta al software, dime la parte concreta y el patrón correcto.
- Si el diagnóstico depende de un dato que no te he dado, pídelo antes de suponer.

FORMATO DE RESPUESTA
A) LECTURA DEL SÍNTOMA en 3 líneas.
B) TABLA de hipótesis: Hipótesis | Por qué encaja | Comprobación | Valor esperado | Valor que confirma el fallo.
C) PLAN DE AISLAMIENTO numerado.
D) ARREGLO recomendado con lo que hay que añadir o cambiar y por qué.
E) SI SIGUE FALLANDO: dos siguientes pasos y qué dato pedirme.
F) PRUEBA DE ESTRÉS y criterio de "resuelto".

CRITERIOS DE CALIDAD
- ¿He puesto lo eléctrico antes que el código?
- ¿Cada comprobación se puede hacer con un multímetro y paciencia?
- ¿El arreglo explica la causa, en vez de tapar el síntoma con un reinicio automático?
- ¿Hay un criterio objetivo para dar el problema por cerrado?
```
