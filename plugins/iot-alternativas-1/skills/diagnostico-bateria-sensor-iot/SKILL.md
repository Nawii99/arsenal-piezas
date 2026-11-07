---
name: diagnostico-bateria-sensor-iot
description: Diagnostica por qué un sensor IoT alimentado por batería se descarga demasiado rápido y estima una autonomía realista a partir del ciclo de trabajo, la radio y la autodescarga. Úsala cuando un sensor Zigbee, BLE, LoRaWAN o Wi-Fi gaste pilas en exceso, al planificar la duración de la batería antes de comprar hardware, o cuando un cliente se queje de cambiar las pilas con demasiada frecuencia.
---

# Diagnóstico de batería en sensores IoT

## Qué hace
Toma los datos de tu sensor y te dice, con números, dónde se va la energía y qué cambiar. Distingue entre un problema de diseño (el aparato es así), de configuración (envía demasiado) y de instalación (frío, cobertura mala, pila equivocada).

## Cuándo se activa
Cuando alguien dice que un sensor de pilas dura poco, cuando hay que estimar autonomía antes de comprar, o cuando un cliente pide garantía de duración.

## Qué preguntar si falta información
1. Modelo exacto del sensor y protocolo (Zigbee, BLE, Wi-Fi, LoRaWAN, Z-Wave, Matter/Thread).
2. Tipo de pila y cantidad: CR2032, CR2450, AA/AAA alcalina o litio, 18650, ER14505.
3. Cada cuánto reporta y si envía además por cambio de valor.
4. Dónde está: interior, exterior, cámara frigorífica, cuadro metálico.
5. Distancia al router/coordinador/gateway y si hay repetidores por medio.
6. Cuánto duró realmente y desde cuándo lo mides.

## Método
### 1. Presupuesto de energía
- Anota la capacidad útil de la pila: CR2032 unos 200-230 mAh, pero con picos de radio la capacidad aprovechable baja bastante; AA alcalina ~2000-2500 mAh; AA litio ~3000 mAh y aguanta el frío; 18650 ~2500-3000 mAh.
- Reserva un 20-30% de margen: la electrónica deja de funcionar antes de vaciar la pila porque la tensión cae.
- Suma tres consumos: reposo (µA), medida (mA durante ms) y transmisión (decenas de mA durante ms). El que casi siempre manda es el número de transmisiones al día.
- Autonomía aproximada en días = capacidad útil en mAh / consumo medio diario en mAh.

### 2. Buscar los sospechosos habituales
- **Wi-Fi para sensores de pila**: casi siempre es el fallo. Cada despertar cuesta asociarse a la red. Si es Wi-Fi y reporta cada minuto, no hay pila que valga.
- **Reporta demasiado**: temperatura cada 10 s no aporta nada. Con cada 5-10 min o por cambio de 0,5 grados sobra.
- **Mala cobertura**: si el nodo tiene que reintentar, multiplica el gasto. Mira LQI/RSSI y el número de reintentos.
- **Repetidor malo**: enchufes Zigbee baratos como router de la malla provocan reintentos constantes.
- **Frío**: a 0 grados o menos, la pila alcalina y la CR2032 pierden capacidad; con litio el problema baja mucho.
- **Pila de mala calidad o vieja**: las CR2032 de bazar dan la mitad. Las alcalinas se autodescargan y tienen riesgo de fuga.
- **LED o zumbador activados** en configuración: pequeños, pero constantes.
- **Firmware con bug de sueño**: si el consumo en reposo es de mA en vez de µA, el aparato no duerme.

### 3. Medir de verdad si hay dudas
- Con un medidor de consumo USB no vale: los picos son de milisegundos. Necesitas un medidor con muestreo rápido o una resistencia shunt.
- Truco barato: pon dos sensores iguales, uno con la configuración actual y otro con la propuesta, y compara la caída del nivel de batería a los 15 días.
- Anota el porcentaje de batería cada día: la curva de una pila de litio es plana y cae de golpe, no te fíes del porcentaje como si fuera un depósito.

### 4. Plan de arreglo, por orden de rentabilidad
1. Bajar la frecuencia de reporte y activar reporte por cambio de valor.
2. Cambiar el tipo de pila (litio en vez de alcalina, CR2450 en vez de CR2032 si cabe).
3. Mejorar cobertura: acercar el coordinador, añadir un repetidor decente, sacar el gateway del cuadro metálico.
4. Cambiar de protocolo: sensores de pila en Zigbee/Thread/LoRa, nunca en Wi-Fi.
5. Alimentar por cable el que sea crítico (puerta principal, alarma de frío).

## Formato exacto de la respuesta
- **Situación**: aparato, protocolo, pila, cada cuánto reporta, autonomía real.
- **Tabla de energía**: reposo, medida, transmisión, transmisiones al día, consumo medio diario, autonomía estimada.
- **Diagnóstico**: causa principal y causas secundarias, ordenadas.
- **Plan**: lista numerada de cambios con la autonomía nueva estimada para cada uno.
- **Cómo comprobarlo**: qué medir y en cuántos días sabrás si ha funcionado.
- **Compra recomendada**: pilas concretas y, si toca, hardware alternativo.

## Errores típicos
- Fiarse del porcentaje de batería que reporta el aparato: muchos lo calculan mal.
- Cambiar la pila y no cambiar la configuración: vuelves a estar igual en dos meses.
- Poner CR2032 recargables LIR2032: dan 3,6 V y menos capacidad, pueden estropear el sensor.
- Mezclar pilas nuevas y usadas en un aparato de dos pilas.
- Culpar a la pila cuando el problema es que el nodo pierde la red y reintenta sin parar.

## Avisos honestos
- Las estimaciones son estimaciones: el fabricante mide en laboratorio a 20 grados y sin reintentos. Divide su cifra por dos y te acercarás más.
- Si vendes autonomía a un cliente, ponlo por escrito con condiciones (temperatura, frecuencia de reporte, marca de pila) o te lo comerás tú.
- Abrir un sensor para medir consumo suele romper la garantía.
