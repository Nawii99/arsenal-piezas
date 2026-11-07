---
name: autonomia-bateria-sensores
description: Estima la duración real de la batería de un sensor inalámbrico y produce los cambios de configuración (intervalo de informe, reposo, radio, umbrales) que convierten semanas de autonomía en años. Úsala cuando los dispositivos con batería se agoten demasiado rápido o antes de instalar sensores en lugares de difícil acceso.
---

# Autonomía de sensores a pila

## Qué hace

Estima con números aproximados pero honestos cuánto va a durar la pila de un sensor y te dice qué tocar para multiplicarla. Sirve tanto para decidir compra como para rescatar una instalación que se come pilas.

## Cuándo se activa

- «Este sensor me dura dos meses».
- Sensores en un falso techo, en un cuadro, en una finca o en una cámara frigorífica donde subir a cambiar la pila cuesta una visita.
- Antes de prometer autonomía a un cliente en una propuesta.

## Qué preguntar antes de responder

1. Modelo y tipo de pila (CR2032, CR2450, 2xAA, 18650, LiSOCl2 de 3,6 V).
2. Tecnología de radio (Zigbee, WiFi, BLE, LoRa, 4G).
3. Cada cuánto envía dato ahora, y cada cuánto haría falta de verdad.
4. Temperatura del sitio: ¿hay frío? ¿nevera, exterior, invierno?
5. ¿Tiene pantalla, LED o zumbador que esté siempre activo?
6. ¿Cuántas veces al día se dispara si es de movimiento o de puerta?

## Método paso a paso

### 1. Ordena las tecnologías por consumo

De mejor a peor autonomía a igualdad de pila: LoRa y Zigbee y BLE muy por delante; WiFi el peor con diferencia. Un sensor WiFi a pila haciendo reporte cada minuto dura semanas. El mismo trabajo en Zigbee, más de un año. Si el sensor es WiFi y necesitas años, no hay configuración que lo salve: cambia de sensor o llévalo a corriente.

### 2. Mira la capacidad real de la pila

Orientación práctica: CR2032 unos 220 mAh, CR2450 unos 600, dos pilas AA alcalinas unos 2.000-2.500, LiSOCl2 tamaño AA unos 2.400 pero con voltaje estable hasta el final. Ojo: en frío una alcalina pierde gran parte de su capacidad. En cámaras frigoríficas o exterior de invierno, pilas de litio siempre.

### 3. La regla del intervalo

El consumo baja casi proporcional al número de transmisiones. Pasar de reportar cada minuto a cada 15 minutos multiplica por 10-15 la autonomía en la práctica. Pregunta siempre: ¿el cliente necesita el dato cada minuto o solo le gusta verlo? La temperatura de una habitación cambia despacio: 10-15 minutos sobra. La de una nevera con alarma: 5 minutos con umbral de cambio.

### 4. Reporte por umbral en vez de por reloj

Muchos sensores permiten «envía solo si cambia más de X». Configurar 0,5 grados o 3 % de humedad reduce muchísimo los envíos sin perder información útil. Añade un envío obligatorio cada hora aunque no cambie nada, para saber que sigue vivo.

### 5. Mata los extras

Pantalla siempre encendida, LED de confirmación en cada envío, zumbador, retroiluminación: cada uno puede llevarse una parte grande del presupuesto de energía. Desactiva lo que el usuario no mira.

### 6. Sensores de movimiento y puerta

Lo que gasta es cada disparo. Un PIR en un pasillo muy transitado con tiempo de rearme de 5 segundos dispara cientos de veces al día. Sube el tiempo de rearme a 60-120 segundos si sirve para el caso de uso.

### 7. Radio y malla

Un dispositivo con enlace malo reintenta y gasta más. Arreglar la cobertura alarga la pila. Si un sensor concreto gasta el triple que sus gemelos, sospecha de la señal antes que de la pila.

## Formato exacto de la respuesta

1. **Estimación actual**: autonomía aproximada con la configuración de ahora, y de dónde sale el número.
2. **Configuración recomendada**: intervalo, umbral, latido, extras a desactivar, con valor concreto para cada parámetro.
3. **Estimación nueva** y factor de mejora, siempre expresado como rango, nunca como cifra exacta.
4. **Si no llega**: alternativa (cambiar tipo de pila, pasar a corriente, cambiar tecnología).
5. **Plan de mantenimiento**: cuándo cambiar pilas y con qué aviso automático.

## Errores típicos

- Comprar sensores WiFi baratos a pila para una instalación de cliente.
- Poner alcalinas en exterior o en frío.
- Dejar el intervalo de fábrica (a veces 30 segundos) sin tocarlo.
- No configurar aviso de batería baja ni de sensor mudo, y enterarte cuando el cliente llama.
- Mezclar pilas nuevas y usadas en un sensor de dos pilas.

## Avisos honestos

- Las autonomías del fabricante son de laboratorio, a temperatura ideal y con el intervalo más largo posible. Divide por dos y acertarás más.
- El porcentaje de batería que muestran los sensores baratos es poco fiable: es mejor avisar por voltaje.
- No prometas «5 años» en propuestas. Escribe «autonomía estimada 18-24 meses según uso, con aviso automático de batería baja».
