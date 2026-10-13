---
name: dimensionar-nodo-autonomo
description: Sizes battery, solar panel and duty cycle for a battery-powered or solar IoT node so it survives the worst month without site visits, using real current draw, sleep math, temperature derating and charging chemistry rules. Use when planning outdoor or remote sensors, LoRa nodes, or when batteries die far sooner than expected.
---

# Dimensionar un sensor autónomo con batería o solar

## Qué hace
Convierte el consumo real de un nodo en una batería y un panel concretos, con margen para el peor mes, y te dice cada cuánto puede enviar datos.

## Cuándo se activa
Cuando hay que poner un sensor donde no llega la corriente, o cuando las pilas duran mucho menos de lo prometido.

## Qué preguntar
1. ¿Qué placa y qué radio? (ESP32 con Wi-Fi, ESP32 con LoRa, módulo LoRaWAN dedicado)
2. ¿Cada cuánto tiene que mandar dato? Sé honesto: cada minuto y cada hora cambian el proyecto por completo.
3. ¿Provincia y orientación del sitio? Hace falta para las horas de sol del peor mes.
4. ¿Habrá sombra en invierno? Un muro o un árbol arruinan el cálculo.
5. ¿Cuántos días seguidos sin sol tiene que aguantar? En el norte, cuenta cinco.

## Método
### 1. Mide o estima el consumo en los dos estados
- Corriente en marcha, durante el envío, y cuánto dura ese envío en segundos.
- Corriente durmiendo. Aquí se juega todo: un ESP32 mal dormido gasta miliamperios en vez de microamperios, y eso son meses de diferencia.
- Sospecha siempre del regulador de tensión y de los LED de la placa: en muchas placas de desarrollo consumen más que el microcontrolador dormido.

### 2. Fórmula del consumo diario
Consumo medio en mA = (corriente activa × segundos activos + corriente en reposo × segundos en reposo) dividido entre los segundos del ciclo. Multiplica por 24 para tener mAh al día.

### 3. Elige la batería
- Capacidad necesaria = mAh al día × días de autonomía, y multiplica por dos como margen. La mitad de esa reserva se la comen el frío, el envejecimiento y la autodescarga.
- Li-ion 18650: barata y densa, pero no se puede cargar por debajo de 0 grados sin dañarla. Mal plan para exterior en invierno en el interior peninsular.
- LiFePO4: aguanta muchos más ciclos, es más segura y tolera mejor el calor. Pesa más y necesita cargador específico; los cargadores típicos de Li-ion no valen.
- Pilas de litio no recargables: para nodos de muy bajo consumo que solo despiertan unas veces al día, siguen siendo la opción más simple.

### 4. Elige el panel
- Horas de sol pico del peor mes: en España, cuenta entre 1,5 y 2,5 horas equivalentes en diciembre según zona y orientación.
- Potencia de panel = energía diaria necesaria en Wh dividida entre esas horas, y multiplica por 1,5 o 2 por suciedad, ángulo y nubes.
- Orienta al sur y con inclinación alta (cerca de la latitud más 15 grados) para favorecer el invierno, que es cuando falla.

### 5. Reduce consumo antes de comprar batería
Siempre sale más barato bajar el consumo que subir la batería: alarga el ciclo de envío, manda solo cuando el valor cambia, apaga el sensor entre lecturas con un transistor, y usa LoRa en vez de Wi-Fi si el dato es pequeño.

### 6. Verifica en el mundo real
Deja el nodo funcionando dos semanas midiendo su propia tensión de batería y registrándola. La curva de descarga real vale más que cualquier cálculo.

## Formato exacto de la respuesta
1. **Tabla de consumo**: estado, corriente, tiempo, aporte al total diario.
2. **Resultado**: mAh al día y autonomía estimada con la batería propuesta.
3. **Material recomendado**: batería, panel, regulador, caja, con precio orientativo.
4. **Ciclo de envío recomendado** y qué autonomía da cada alternativa.
5. **Supuestos usados**, escritos claramente para que se puedan discutir.
6. **Qué monitorizar** para detectar que se está quedando sin batería antes de que muera.

## Errores típicos
- Usar la capacidad nominal de la batería como si fuera aprovechable al cien por cien.
- Fiarse del consumo en reposo que pone el fabricante del chip, no el de la placa entera.
- Poner el panel horizontal: en invierno recoge muchísimo menos y se ensucia más.
- Meter la batería en una caja negra al sol: el calor la mata en un verano.

## Avisos honestos
- Todo cálculo de este tipo es una estimación; el margen de seguridad no es opcional.
- Las baterías de litio requieren protección contra sobrecarga y descarga profunda. No las conectes directamente sin circuito de protección.
