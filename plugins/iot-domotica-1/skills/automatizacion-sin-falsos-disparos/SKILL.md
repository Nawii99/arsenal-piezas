---
name: automatizacion-sin-falsos-disparos
description: Redesigns flaky home-automation rules using hysteresis, debounce, minimum on-time, presence conditions and state machines, and produces corrected logic in plain language plus Home Assistant YAML. Use when lights turn off with people in the room, heating oscillates, an alarm triggers for no reason, or a rule fires twice.
---

# Automatizaciones que no se disparan solas

## Qué hace
Coge una automatización que se porta mal y la reescribe con las técnicas que usan los que llevan años en esto: histéresis, antirrebote, tiempo mínimo, condiciones de contexto y estados. Devuelve la lógica explicada y el YAML listo para Home Assistant.

## Cuándo se activa
Cuando una regla se dispara sin motivo, se dispara dos veces, no se dispara, o el aparato oscila encendiendo y apagando.

## Qué preguntar si falta información
1. Qué automatización es y qué debería hacer, en una frase.
2. Qué hace mal exactamente y cada cuánto.
3. Qué sensores y actuadores intervienen (modelo).
4. Sistema: Home Assistant, Node-RED, la app del fabricante, Alexa rutinas.
5. Si tienes el código o la captura de la regla actual.
6. Quién vive ahí: mascotas, niños, turnos de noche.

## Método
### 1. Identificar el patrón de fallo
- **Oscilación (tiritona)**: enciende y apaga cada poco. Falta histéresis o tiempo mínimo.
- **Se apaga contigo dentro**: el sensor PIR solo detecta movimiento, no presencia. Falta redetección, retardo largo o un sensor mmWave.
- **Se dispara dos veces**: el disparador salta con cualquier cambio de atributo, o hay dos automatizaciones haciendo lo mismo.
- **Falso positivo en alarma**: PIR con corrientes de aire, mascota, sol directo, o sensor de puerta con imán mal alineado.
- **No se dispara nunca**: la condición usa un estado que nunca existe ('on' contra 'ON'), o el sensor está 'unavailable'.
- **Se dispara al reiniciar**: al arrancar, todos los sensores cambian de estado y disparan todo.

### 2. Las herramientas del oficio
- **Histéresis**: nunca uses el mismo número para encender y apagar. Encender el humidificador por debajo de 45% y apagarlo por encima de 55%, no los dos en 50%.
- **Antirrebote (debounce)**: exige que la condición se mantenga X segundos antes de actuar. En Home Assistant, la cláusula `for:` del disparador.
- **Tiempo mínimo encendido/apagado**: protege compresores y relés. Un frigorífico o un aire no deben reencenderse antes de 3-5 minutos.
- **Condición de contexto**: hora, si hay alguien en casa, si la luz ya está encendida a mano, luminosidad exterior.
- **Bandera de intervención manual**: si alguien tocó el interruptor, la automatización no manda durante 30 minutos. Esto es lo que hace que la familia no odie el sistema.
- **Máquina de estados**: para casos con secuencia (ausente, llegando, presente, dormido) usa una variable de estado en vez de veinte reglas sueltas.
- **Modo de ejecución**: en Home Assistant elige `single` con `max_exceeded: silent` para evitar disparos solapados, o `restart` cuando quieras reiniciar el temporizador (típico en luz por movimiento).

### 3. Reescribir la regla
- Enuncia primero la regla en una frase: cuándo, con qué condiciones, qué hace, cuándo deshace.
- Añade siempre la condición de que el sensor no esté 'unavailable' ni 'unknown'.
- Separa encendido y apagado en dos automatizaciones cuando la lógica de apagar sea distinta.
- Para luz por movimiento: disparador de movimiento con modo `restart`, apagado por el mismo temporizador, condición de luminosidad, y excepción si la luz se encendió a mano.

### 4. Probar antes de dejarlo
- Fuerza el disparo manualmente y mira la traza (en Home Assistant, Trazas te dice qué condición cortó).
- Deja registro 48 h y cuenta disparos: si son muchos más de los esperados, sigue habiendo rebote.
- Prueba el caso raro: reinicio del sistema, sensor caído, dos personas, medianoche.

## Formato exacto de la respuesta
- **Diagnóstico** del patrón de fallo, con la evidencia.
- **Regla reescrita en castellano**, una frase por comportamiento.
- **Código** en YAML de Home Assistant (o el sistema que use), completo y pegable.
- **Parámetros a ajustar**: tabla con Valor / Para qué sirve / Rango sensato.
- **Cómo probarlo**: tres pruebas concretas y el resultado esperado de cada una.
- **Qué mirar en 48 h** para dar por cerrado.

## Errores típicos
- Poner el retardo de la luz en 1 minuto: en un salón se apaga siempre.
- Meter la condición de luminosidad usando el sensor de una bombilla que la propia automatización enciende: se retroalimenta.
- Automatizar la calefacción sin tiempo mínimo y freír el relé o la caldera.
- Tener la misma automatización duplicada en la app del fabricante y en Home Assistant peleando entre ellas.
- Usar `state` en vez de `numeric_state` y comparar textos como si fueran números.

## Avisos honestos
- Ninguna automatización sustituye a un sistema de alarma homologado ni a un detector de humo certificado. Complementa, no reemplaza.
- Si controlas calefacción o riego, deja siempre un modo manual accesible y explícalo a quien vive allí.
- Cuanta más lógica metas, más difícil es de mantener: mejor cinco reglas que se entienden que una gigante.
