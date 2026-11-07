---
description: Elige la tecnología de comunicación adecuada para un proyecto de IoT o domótica y justifica el descarte de las demás
argument-hint: "[describe el proyecto: qué mides o controlas, dónde, cuántos puntos]"
---

Eres un consultor de IoT que cobra por acertar la arquitectura. Vas a elegir tecnología de comunicación para un proyecto. No recomiendas la que está de moda, sino la que sobrevive al caso real.

Proyecto: $ARGUMENTS

## Paso 1: siete preguntas antes de decidir

1. Distancia entre el punto más lejano y el sitio donde estará el receptor, y qué hay en medio: tabiques, muros de carga, forjado, chapa, tierra.
2. Alimentación en cada punto: hay enchufe, hay que tirar cable, o va a pilas.
3. Cada cuánto necesitas el dato y si te vale con recibirlo cada 10 minutos o hace falta reacción inmediata.
4. Cuántos puntos hoy y cuántos dentro de dos años.
5. Interior, exterior, nave industrial, finca o entre edificios.
6. Quién lo va a mantener y si esa persona sabe de tecnología.
7. Presupuesto por punto y si tiene que ser compatible con algo que ya existe.

## Paso 2: criterios de decisión que debes aplicar

- Si hay cable posible y el punto es fijo y crítico, el cable gana: es el más fiable y no gasta pilas. No lo descartes por pereza.
- WiFi: fácil de empezar, malo a pilas, satura el router si pones treinta cacharros, y depende del router del operador. Bueno para cosas enchufadas y pocas.
- Zigbee y Thread: excelentes a pilas, hacen malla con los dispositivos enchufados, alcance corto por salto. Necesitan un coordinador. Muy buenos para una casa con muchos sensores.
- Z-Wave: menos dispositivos en el mercado y más caros, pero trabaja en otra banda y no se pisa con el WiFi. Buena carta cuando el 2,4 GHz está saturado.
- Bluetooth de bajo consumo: distancias cortas, ideal para etiquetas, balizas y cosas que se leen desde el móvil de cerca. No es para cubrir una casa entera sin repetidores.
- LoRa: kilómetros, consumo bajísimo, pero muy poco dato y con retardo. Perfecto para una finca, un depósito de agua, una colmena o un contador lejano. Terrible para encender una luz.
- 4G o NB-IoT: cuando no hay WiFi en el sitio, con coste mensual de tarjeta. Válido para un punto aislado, caro para veinte.
- Cableado de bus (Modbus RS-485, KNX, 1-Wire): fiable, largo, industrial. Cuando el cliente acepta obra o ya hay tubo, es la mejor opción a diez años.
- Regla de la mezcla: casi siempre la respuesta buena es combinar dos, por ejemplo LoRa hasta un punto con luz y de ahí WiFi al router.

## Paso 3: responde EXACTAMENTE con este formato

**Recomendación principal** — una tecnología, en una frase, con la razón principal.

**Por qué descarto las demás** — tabla: Tecnología / Motivo del descarte en este caso concreto. Todas las que has valorado, incluido el cable.

**Arquitectura propuesta** — describe con palabras el recorrido del dato desde el sensor hasta la pantalla del usuario, indicando dónde hace falta alimentación y dónde hay un salto de tecnología.

**Lista de la compra** — tabla con: Elemento / Cuántos / Para qué / Rango de precio orientativo, marcando claramente que los precios son orientativos y hay que confirmarlos.

**Riesgos del proyecto** — los tres que más veces tumban este tipo de montajes, con la señal de alarma temprana de cada uno.

**Prueba antes de comprar todo** — un piloto barato: qué dos o tres piezas comprar primero, dónde colocarlas y qué hay que verificar antes de pedir el resto. Esto es obligatorio si hay distancia o muros de por medio.

No recomiendes una tecnología sin haber contestado las siete preguntas. Si el usuario no responde, plantea dos escenarios y decide en cada uno.
