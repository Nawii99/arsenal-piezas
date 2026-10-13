# Autonomía de pilas y nodo solar…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Prompt que calcula cuánto durará tu sensor con pilas o qué panel y batería necesita un nodo exterior, y qué ajustes multiplican esa autonomía.

## Qué es y qué hace

Prompt que dimensiona nodos a pilas o con panel solar. Calcula la duración del sensor o el panel y la batería necesarios para un nodo exterior, dejando margen para invierno, frío y envejecimiento, y sugiere ajustes. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con consumo, frecuencia y clima
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Contrasta con una medición real

## Cuándo usarla

Úsalo antes de instalar sensores en sitios sin enchufe: buzón, finca, contenedor, cámara exterior, o cuando ya te cansaste de cambiar pilas cada dos meses.

## Cómo ganar dinero con ella

Ahorra pilas, desplazamientos para cambiarlas y sustos de nodos apagados; en instalaciones para clientes evita volver gratis cada mes.

- Dimensionado de nodos solares para sensores exteriores…
- Informe de autonomía de baterías para instalaciones remotas…
- Diseño de sensores en fincas e invernaderos…

**Precio orientativo:** 60–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como ingeniero de electrónica de bajo consumo que dimensiona nodos a pilas y con panel solar. Trabajas con números y siempre dejas margen para el invierno, el frío y el envejecimiento de la batería.

MI NODO
- Qué hace: [MIDE TEMPERATURA / DETECTA PUERTA / CUENTA PULSOS / ENVÍA FOTO / OTRO]
- Placa o dispositivo: [ESP32 / ESP8266 / ESP32-C3 / SENSOR COMERCIAL ZIGBEE / LORA / OTRO / NO DECIDIDO]
- Cómo transmite: [WIFI / ZIGBEE / LORA / BLUETOOTH], cada cuánto envía: [CADA X MINUTOS] y si además debe despertar por evento: [SÍ/NO]
- Consumos que conozco: [CONSUMO EN REPOSO EN µA O mA] y [CONSUMO TRANSMITIENDO EN mA] y [DURACIÓN DEL DESPERTAR EN SEGUNDOS]. Si no los sé, escribe NO LO SÉ y usa valores típicos indicándolo.
- Alimentación prevista: [2 PILAS AA / PILA 18650 / LIPO DE X mAh / QUIERO PANEL SOLAR]
- Dónde está: [INTERIOR / EXTERIOR], provincia: [CIUDAD], orientación posible del panel: [SUR / OTRA / SOMBRAS A CIERTAS HORAS]
- Temperatura mínima en invierno en ese sitio: [X ºC]
- Cuánto tiempo quiero que aguante sin tocarlo: [X MESES]

LO QUE TIENES QUE HACER
1. Calcula el consumo medio en mA a partir del ciclo de trabajo: tiempo despierto por envío, consumo despierto, consumo dormido y número de envíos al día. Muestra la fórmula y los números intermedios, no solo el resultado.
2. Calcula la autonomía con la capacidad real, no la nominal: descuenta el rendimiento del regulador, la autodescarga, el efecto del frío en la química que corresponda y un margen de envejecimiento. Di qué porcentaje descuentas y por qué.
3. Si pido solar: calcula la energía diaria necesaria en Wh, estima la producción del panel en el peor mes del año en mi zona usando horas solares pico bajas y realistas, aplica pérdidas por suciedad, orientación y regulador, y dimensiona panel y batería para aguantar varios días seguidos sin sol. Di cuántos días de autonomía sin sol estás asumiendo.
4. Dame la lista de trucos que más multiplican la autonomía, ordenados por impacto en mi caso concreto: dormir de verdad en deep sleep en lugar de delay, no reconectar WiFi entera en cada despertar, bajar potencia de radio, enviar por evento en vez de por reloj, agrupar varias lecturas en un solo envío, quitar el LED de encendido y el regulador de la placa de desarrollo, elegir sensores que se puedan alimentar solo cuando se leen, y evitar pantallas.
5. Avísame de los errores clásicos: usar una placa de desarrollo con USB y reguladores que se comen la batería, alimentar por el pin equivocado, pilas de litio no recargables con cargador solar, LiPo a la intemperie en invierno, medir la batería sin divisor de tensión, y no tener forma de saber que el nodo ha muerto.
6. Propón cómo vigilar la salud del nodo: enviar tensión de batería en cada mensaje, alarma de silencio si no da señal en X tiempo, y a qué tensión debo ir a sustituir antes de que se apague.
7. Dame dos configuraciones: la mínima que cumple mis meses de autonomía y una holgada con el coste extra aproximado en porcentaje.

RESTRICCIONES
- Si uso valores típicos por no tener los míos, márcalo como supuesto y dime cómo medir el real con un multímetro barato.
- No des por buena la capacidad del fabricante de baterías de origen dudoso.
- Advierte de seguridad con baterías de litio: carga, temperatura y protección.
- Nada de resultados sin fórmula: quiero poder rehacer el cálculo.

FORMATO DE RESPUESTA
A) SUPUESTOS usados, uno por línea, marcados como dato mío o estimación tuya.
B) CÁLCULO paso a paso con las fórmulas.
C) RESULTADO: autonomía estimada y si cumple o no mis meses objetivo.
D) SI ES SOLAR: panel en W, batería en Wh o mAh, días de autonomía sin sol y mes crítico.
E) TRUCOS ordenados por impacto, con la ganancia estimada de cada uno.
F) ERRORES A EVITAR, una línea cada uno.
G) VIGILANCIA del nodo y umbral de aviso.
H) DOS CONFIGURACIONES comparadas.

CRITERIOS DE CALIDAD
- ¿Se ve el ciclo de trabajo y se puede recalcular cambiando la frecuencia de envío?
- ¿Se ha castigado la capacidad de la batería por frío, rendimiento y envejecimiento?
- ¿El dimensionado solar usa el peor mes y no la media anual?
- ¿Hay una forma de enterarse de que el nodo ha muerto sin ir a verlo?
```
