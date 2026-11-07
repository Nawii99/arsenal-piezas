---
name: averias-bus-rs485-i2c
description: "Resuelve fallos intermitentes en buses cableados (Modbus RTU sobre RS-485, I2C, 1-Wire, CAN): terminación, polarización, masa común, apantallamiento, longitud del cable, pull-ups y ruido eléctrico de motores e inversores. Úsala cuando un sensor cableado se caiga al azar, devuelva valores basura o solo falle cuando arranca un motor."
---

# Averías en buses por cable: RS-485, I2C, 1-Wire

## Qué hace
Ordena el diagnóstico de un bus que falla a ratos, que es el fallo más caro de encontrar. Va del síntoma a la causa eléctrica con pruebas que puedes hacer con un polímetro.

## Cuándo se activa
Cuando un aparato por cable se desconecta sin patrón, aparecen errores CRC, lecturas absurdas, o el fallo coincide con arrancar un motor, un aire o una luz.

## Qué preguntar si falta información
1. Qué bus es: RS-485/Modbus RTU, I2C, 1-Wire, CAN, o no lo sabes.
2. Cuántos aparatos hay en el bus y de qué marcas.
3. Longitud total del cable y tipo (par trenzado, apantallado, manguera cualquiera).
4. Trazado: ¿va en línea o en estrella? ¿Comparte canaleta con cables de fuerza?
5. Velocidad configurada (9600, 19200, 115200) y paridad.
6. ¿El fallo coincide con algo? Hora, arranque de máquinas, lluvia, calor.

## Método
### 1. Topología: casi siempre el problema
- RS-485 y CAN son buses **en línea (daisy chain)**, de un extremo a otro, con ramas cortas (menos de 30 cm). En estrella funcionan «casi», y ese casi es tu avería intermitente.
- Si está en estrella, o lo recableas, o pones repetidores/hubs de bus.

### 2. Terminación y polarización (RS-485/CAN)
- Resistencia de 120 ohmios **solo en los dos extremos físicos** del bus, nunca en los del medio.
- Comprueba con el bus sin alimentar: midiendo entre A y B deberías ver unos 60 ohmios (dos de 120 en paralelo). Si ves 120, falta una; si ves 40 o menos, sobran.
- Polarización (pull-up/pull-down): en un solo punto del bus, normalmente el maestro. Doble polarización deforma los niveles.

### 3. Masa común
- A y B no bastan: hace falta referencia de masa entre equipos. Sin ella funciona hasta que dos equipos están en fases distintas o hay una derivación.
- Usa el tercer hilo del cable o la pantalla como referencia, con resistencia de 100 ohmios en serie si hay riesgo de bucles.
- **Pantalla conectada a tierra en un solo extremo**, normalmente en el cuadro. Conectarla en los dos crea un bucle de tierra que mete ruido.

### 4. Cable y ruido
- Par trenzado apantallado, impedancia en torno a 120 ohmios. La manguera de alarma o el cable de red pueden valer (par trenzado), el cable de altavoz no.
- Separación mínima de 20-30 cm de cables de fuerza; si tienen que cruzarse, que sea en ángulo recto.
- Variadores de frecuencia y contactores son la principal fuente de ruido en nave. Si el fallo coincide con arranques, es esto: filtros, separación y ferritas.
- Longitudes orientativas en RS-485: 1200 m a 9600 baudios, mucho menos a velocidades altas. Si tienes mucho cable, **baja la velocidad**: es el arreglo más rápido y más veces funciona.

### 5. I2C y 1-Wire, otra liga
- I2C está pensado para centímetros dentro de una placa, no para metros. Con más de 1-2 m ya sufre.
- Resistencias de pull-up: 4,7 kohmios es el valor típico; con cable largo o varios dispositivos, baja a 2,2 kohmios. Si hay varias placas cada una con sus pull-ups, quedan en paralelo y hay que quitarlas de todas menos una.
- Direcciones repetidas en el bus I2C: dos sensores iguales sin cambiar la dirección se pisan. Escanea el bus para ver qué direcciones responden.
- 1-Wire con DS18B20 aguanta decenas de metros si el cable es par trenzado y usas alimentación por los tres hilos (no el modo parásito) y pull-up de 4,7 kohmios, a veces menos.
- Lecturas de -127 o 85 en DS18B20 son el aviso de cable o alimentación mal.

### 6. Aislar el fallo
- Desconecta la mitad de los aparatos: si desaparece, está en la mitad que quitaste. Repite dividiendo.
- Cambia un aparato de sitio en el bus: si el fallo le sigue, es el aparato; si se queda en la posición, es el cableado.
- Baja la velocidad a la mitad. Si mejora, es un problema físico de bus.
- Registra errores durante 24-48 h con marca de tiempo y compáralos con el horario de las máquinas.

## Formato exacto de la respuesta
- **Síntoma y clasificación**: físico, de configuración o de dispositivo.
- **Comprobaciones en orden**, cada una con qué medir, con qué, y qué valor es correcto.
- **Causa más probable** y las dos alternativas.
- **Plan de arreglo** con material concreto.
- **Prueba de validación**: cuántas horas sin errores hacen falta para dar el caso por cerrado.

## Errores típicos
- Poner terminación en todos los aparatos «por si acaso».
- Cablear en estrella porque era más cómodo y culpar al sensor.
- Pantalla a tierra en los dos extremos.
- Compartir canaleta con la manguera del variador.
- Subir la velocidad para «ir más rápido» en un bus de 400 m.
- Alargar I2C con cable plano de 5 m y esperar que funcione.

## Avisos honestos
- Estos fallos requieren estar delante con un polímetro; a distancia solo se puede acotar.
- Si hay variadores o maquinaria industrial, la solución completa puede necesitar filtros y trabajo de un técnico eléctrico.
- Un bus que funciona «casi siempre» acabará fallando el peor día: no lo des por bueno hasta tener 48 h limpias.
