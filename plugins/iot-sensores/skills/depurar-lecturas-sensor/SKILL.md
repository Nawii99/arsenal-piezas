---
name: depurar-lecturas-sensor
description: Resuelve problemas de sensores electrónicos que dan lecturas ruidosas, congeladas, con deriva o imposibles, revisando alimentación, masa, longitud de cable, resistencias pull-up, direcciones I2C, límites del ADC y ruido eléctrico de motores y relés. Úsala cuando un sensor funcione en el banco pero falle ya instalado, dé picos, ceros o valores que se desvían poco a poco.
---

# Depurar un sensor que da lecturas raras

## Qué hace
Aplica el diagnóstico clásico de electrónica para separar si el problema es de alimentación, de cableado, de ruido o del propio sensor, sin comprar piezas a ciegas.

## Cuándo se activa
Cuando el usuario describe valores imposibles, picos, ceros intermitentes, un sensor que se cuelga tras horas o una medida que se va desviando.

## Qué preguntar
1. ¿Qué sensor y qué interfaz? (analógico, I2C, 1-Wire, pulsos, 4-20 mA)
2. ¿Cuánto cable hay entre el sensor y la placa, y de qué tipo?
3. ¿Qué alimenta el conjunto? Fuente, marca, amperaje, y si es compartida con motores o relés.
4. ¿Qué valores ves exactamente? Pega diez lecturas seguidas.
5. ¿Funciona en la mesa y falla instalado, o falla siempre?

## Método, en este orden
### 1. Alimentación (la causa del 40 por ciento de los casos)
- Mide la tensión con el sistema en marcha y en el momento del fallo, no en reposo.
- Una caída por debajo del margen del sensor durante medio segundo basta para colgarlo.
- Las fuentes de móvil viejas y los cables USB finos y largos no dan corriente: el Wi-Fi del ESP32 pide picos de cientos de miliamperios.
- Pon 100 nF cerámico junto al sensor y 100 a 470 µF electrolítico en la entrada de alimentación de la placa. Es barato y arregla muchos misterios.

### 2. Masa común
Si el sensor se alimenta de una fuente y la placa de otra, las masas deben estar unidas. Sin masa común, la lectura analógica no significa nada.

### 3. Niveles lógicos
3,3 V frente a 5 V. Un sensor de 5 V puede dañar una entrada de 3,3 V, y una salida de 3,3 V a veces no llega a nivel alto en un dispositivo de 5 V. Usa adaptador de nivel, no un divisor improvisado en buses rápidos.

### 4. Cable y distancia
- I2C está pensado para centímetros, no metros. Con más de un metro: baja la frecuencia a 50 kHz, sube las pull-ups o cambia de tecnología.
- Para tiradas largas usa 1-Wire con cable de par trenzado, RS485 o un lazo de 4-20 mA, que es el estándar industrial precisamente porque el ruido no lo afecta.
- Cable de sensores y cable de fuerza nunca en la misma canaleta ni en paralelo. Si tienen que cruzarse, que lo hagan en ángulo recto.

### 5. Ruido de motores, relés y contactores
Cada vez que arranca un motor o cae un relé se genera un pico. Síntoma clásico: el sensor solo falla cuando funciona la bomba. Soluciones: relé de estado sólido, red RC o diodo de rueda libre en la bobina, optoacoplar la señal, y separar físicamente el circuito de control del de potencia.

### 6. Direcciones y buses
Dos sensores I2C con la misma dirección se pisan. Escanea el bus para ver qué direcciones responden. Si aparece y desaparece, es contacto o alimentación.

### 7. El ADC del ESP32
No es lineal en los extremos y su referencia varía entre placas. Para medidas serias, usa un convertidor externo dedicado o calibra con dos puntos conocidos.

### 8. Deriva lenta
Si el valor se va con las semanas: condensación dentro de la caja, polvo en el sensor óptico, autocalentamiento por estar pegado a la placa, o sensor de bajo coste que simplemente envejece. Separa el sensor de la electrónica y ventila la caja con un respiradero por abajo.

## Formato exacto de la respuesta
1. **Sospechoso número uno** y por qué encaja con los síntomas.
2. **Pruebas ordenadas**, cada una con: qué hacer, qué medir, qué resultado confirma o descarta.
3. **Arreglo recomendado** con material concreto y coste aproximado.
4. **Cómo comprobar que ha quedado bien**: qué debe verse durante 24 horas.

## Errores típicos
- Filtrar por software un problema eléctrico: el dato malo sigue siendo malo, solo está disimulado.
- Cambiar el sensor tres veces sin medir la alimentación.
- Usar la protoboard como instalación definitiva: los contactos se oxidan y fallan meses después.

## Avisos honestos
- Sin un multímetro barato no se puede diagnosticar nada; es la herramienta mínima.
- Si hay 230 V implicados o el sensor está dentro de un cuadro, la manipulación corresponde a personal autorizado.
