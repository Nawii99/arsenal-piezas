---
name: revisor-riego-automatico
description: Revisa el diseño de un riego automático casero (ESP32, sensor de humedad, relé y bomba o electroválvula) antes de comprar o de dejarlo funcionando solo. Se activa cuando el usuario tiene una lista de piezas, un esquema o un código de riego y quiere saber si es seguro y si va a funcionar.
---

# Revisor de riego automático

## Qué hace
Recibe la lista de piezas, cómo van conectadas y el código (si lo hay) de un riego automático, y devuelve un informe con lo que puede hacer daño, lo que va a fallar y lo que está bien. No monta nada: revisa. Es el paso que casi nadie da y el que evita inundar un balcón, quemar la placa o volver de vacaciones con las plantas muertas.

## Qué pedir antes de revisar
1. Lista de piezas con modelo: placa, sensor, módulo relé, bomba o electroválvula, fuente de alimentación.
2. Cómo se conecta cada cosa (foto, dibujo o texto).
3. Qué riega: macetas de interior, balcón, huerto. Cuántas plantas y a qué distancia del enchufe.
4. El código completo, si existe.
5. Si va a funcionar sin nadie en casa. Si es para vacaciones, el nivel de exigencia sube.

## Qué revisar, en este orden

### 1. Electricidad y agua (lo que puede hacer daño)
- Todo lo que toca agua va a 12 V o menos. Si aparece 230 V en el diseño (bomba de acuario a enchufe con un relé), márcalo como riesgo alto y propón bomba de 12 V con su fuente de 12 V. Un principiante no cablea 230 V.
- La bomba nunca se alimenta desde los pines de la ESP32. La ESP32 da la orden al relé; la bomba lleva su propia fuente.
- Masa (GND) común entre ESP32 y módulo relé. Sin ella el relé no dispara o dispara solo.
- Fuente con amperios suficientes para la bomba. Pide el consumo de la bomba y compáralo con la fuente. Si no lo sabe: [buscar en la ficha del producto].
- Conexiones eléctricas por encima del nivel del agua, lejos del chorro y dentro de una caja con tapa.

### 2. El sensor de humedad
- Si es el resistivo (dos púas metálicas, el de los kits baratos), avisa: se corroe en semanas y empieza a mentir. Recomienda el capacitivo (placa plana, suele venderse como "v1.2" o "v2.0").
- El capacitivo se alimenta a 3,3 V y su salida analógica va a un pin ADC de la ESP32 (GPIO 32 a 39). Si lo han puesto en otro pin, señálalo.
- Un sensor por maceta. Un sensor para todo el balcón no dice nada útil.
- Los valores "seco" y "húmedo" se calibran con la mano: sensor al aire y sensor en tierra recién regada. Si el código lleva umbrales fijos copiados de internet, márcalo.

### 3. El código (si lo hay)
Busca estas cinco cosas. Si falta alguna, es un fallo, no una mejora:
- Tiempo máximo de riego por ciclo, aunque el sensor siga diciendo "seco". Es lo que evita la inundación si el sensor se rompe o se sale de la tierra.
- Tiempo mínimo entre riegos.
- El relé arranca apagado al encender la placa. Si el pin queda sin definir al arrancar, algunos módulos se activan solos.
- El riego no depende del WiFi. Si la red cae, riega igual con la lógica local; el WiFi es para avisar, no para decidir.
- Registro de lo que hace: cada riego, cuánto duró, qué leyó el sensor. Por Monitor Serie o por webhook a n8n.

### 4. Lo físico
- Depósito con agua para todo el tiempo que va a estar solo. Cálculo: mililitros por riego × riegos al día × días.
- Aviso de depósito vacío: flotador o sensor de nivel. Sin él, la bomba trabaja en seco y se estropea. Para vacaciones no es opcional.
- Tubo sujeto a la maceta. Un tubo suelto riega el suelo.

## Qué devolver
Informe en Markdown con estas secciones y nada más:
1. **Riesgo alto** (puede hacer daño o inundar): cada punto con qué pasa y cómo se arregla.
2. **Va a fallar** (no es peligroso pero no funcionará bien): misma estructura.
3. **Correcto**: lo que está bien, una línea por punto, para que sepa qué no tocar.
4. **Antes de irte de vacaciones**: checklist de 5 comprobaciones con la mano.
5. Veredicto en una frase: "Puedes montarlo", "Cambia X antes de montar" o "No lo dejes solo todavía".

## Qué NO hacer
- No apruebes nada con 230 V manipulado por el usuario. Aunque insista.
- No reescribas el código entero. Señala qué falta y dónde. Si después pide el arreglo, entonces sí.
- No recomiendes kits de riego WiFi de tienda como alternativa salvo que lo pregunte: ha venido a montarlo él.
- No des por buena una fuente de alimentación sin ver los amperios.
- No inventes consumos ni caudales. Si el dato no está, pídelo.
- No supongas que "funcionó una vez" significa que funciona. Pregunta cuántos ciclos lleva sin vigilancia.
