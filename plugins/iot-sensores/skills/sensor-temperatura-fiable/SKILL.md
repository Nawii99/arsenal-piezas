---
name: sensor-temperatura-fiable
description: "Diagnostica y corrige lecturas erróneas de temperatura y humedad: autocalentamiento, ubicación, elección de sensor (DHT22, SHT31/SHT41, BME280, DS18B20, PT100), calibración de offset y validación frente a una referencia. Úsala cuando un sensor marque de más, la humedad parezca incorrecta, o antes de instalar sensores en una cámara frigorífica, invernadero, almacén o en la casa de un cliente."
---

# Sensores de temperatura y humedad que miden de verdad

## Qué hace
Detecta por qué tu sensor miente y te da la colocación, el modelo y la calibración correctas. Termina con un procedimiento de comprobación que puedes enseñar a un cliente.

## Cuándo se activa
Cuando una lectura no cuadra con un termómetro de referencia, cuando la humedad da 99% o 20% siempre, cuando hay que sensorizar una cámara, un invernadero, una nave o una vivienda.

## Qué preguntar si falta información
1. Modelo del sensor y de la placa (muchos vienen integrados en un módulo con un ESP que calienta).
2. Dónde está colocado exactamente: altura, pared, dentro de caja, cerca de qué.
3. ¿Está alimentado por USB o por pila?
4. Qué lectura da y con qué la comparas.
5. Rango que necesitas medir y precisión que te exigen.
6. ¿Hay condensación, agua, polvo o productos de limpieza cerca?

## Método
### 1. Autocalentamiento: la causa número uno
- Si el sensor comparte caja con un ESP32 o un módulo Wi-Fi, la propia electrónica calienta entre 1 y 4 grados. Cuanto más reporta, más calienta.
- Señal de que es esto: al arrancar mide bien y en 10-20 minutos sube y se queda arriba.
- Arreglos: separar el sensor de la placa con un cable corto, hacer agujeros en la caja abajo y arriba (convección), bajar la frecuencia de medida, dormir el micro entre medidas, o pasar a un sensor externo por cable.
- Nunca metas el sensor en una caja hermética negra al sol.

### 2. Colocación
- Interior de vivienda: 1,2-1,5 m de altura, pared interior, lejos de radiadores, ventanas, cocinas, focos y de la corriente de la puerta.
- Cámara frigorífica: cerca del producto, no en la salida del evaporador (marcaría 3-4 grados menos que el producto) ni pegado a la puerta.
- Exterior: siempre en abrigo ventilado y a la sombra; al sol te miente 10 grados o más.
- Invernadero: a la altura del cultivo, con pantalla contra radiación.
- Nunca dentro del cuadro eléctrico ni encima de una fuente de alimentación.

### 3. Elegir el sensor
- **DHT11**: no lo uses para nada serio, ±2 grados y humedad muy mala.
- **DHT22/AM2302**: aceptable en aficionado, se degrada con los años y con condensación.
- **SHT31 / SHT41 / SHT45**: precisión buena en temperatura y humedad, es la elección sensata hoy. Con filtro si hay polvo.
- **BME280**: bueno, pero su humedad se desplaza si le dan compuestos volátiles (limpiadores, pintura).
- **DS18B20**: solo temperatura, sonda estanca por cable, ideal para agua, frío y tuberías. Va por 1-Wire y admite varios en un cable.
- **PT100/PT1000 o termopar**: cuando te exigen trazabilidad o rangos extremos.

### 4. Calibración práctica
- Compara siempre con una referencia decente puesta al lado durante 2 horas, con las dos en el mismo sitio y sin corrientes.
- Aplica un desplazamiento fijo (offset) en el software: es lo normal y suficiente para uso doméstico y de negocio.
- Humedad: prueba de sal. Sal común humedecida en un bote cerrado con el sensor dentro da 75% de humedad a 20-25 grados tras 8-12 horas. Anota la desviación.
- Repite la calibración una vez al año, o cada seis meses si hay polvo o vapores.

### 5. Validar la instalación
- Deja el sensor 48 h grabando y mira la curva: debe seguir el día y la noche con suavidad. Escalones bruscos o serrucho apuntan a interferencias, cable largo o alimentación pobre.
- Valores imposibles repetidos (-127, 0, 85) en DS18B20 significan problema de cable o de resistencia de pull-up.

## Formato exacto de la respuesta
- **Diagnóstico**: causa más probable con la prueba que lo confirma.
- **Colocación correcta**, descrita para que la haga alguien sin conocimientos.
- **Sensor recomendado** con modelo y por qué, y alternativa barata.
- **Calibración**: pasos, valor de offset a aplicar y dónde se pone.
- **Comprobación final**: qué debe verse en 48 h para dar por bueno el trabajo.
- **Mantenimiento**: cada cuánto revisar.

## Errores típicos
- Calibrar con el termómetro del móvil o con el del horno.
- Aplicar offset sin dejar estabilizar: acabas compensando el autocalentamiento con un número que cambia según la hora.
- Cable de sonda de 20 m sin apantallar y en la misma canaleta que la fuerza.
- Poner el sensor de la calefacción en la habitación más fría y sorprenderte de que el resto de la casa hierva.
- Sensor de humedad tras una obra o una pintada: tarda días en recuperarse.

## Avisos honestos
- Ningún sensor barato te sirve como registro legal. Para cadena de frío o cumplimiento normativo necesitas equipo con certificado de calibración.
- Los sensores de humedad se degradan siempre; a los 2-3 años hay que revisarlos o cambiarlos.
- La precisión que pone el fabricante es sobre el sensor desnudo, no sobre tu caja con un ESP dentro.
