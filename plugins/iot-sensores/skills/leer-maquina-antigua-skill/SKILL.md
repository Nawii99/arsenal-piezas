---
name: leer-maquina-antigua-skill
description: Extrae datos de una máquina o contador antiguo no inteligente (salida de pulsos, Modbus RTU, contacto de relé, señal analógica, pinza amperimétrica, lector óptico de contador) sin modificarlo ni perder la garantía. Úsala cuando un pequeño negocio quiera datos de producción, tiempo de actividad o consumo de equipos que no tienen app ni WiFi.
---

# Leer datos de una máquina que no es inteligente

## Qué hace

Te da el camino, de menos a más invasivo, para sacar datos de una máquina existente: qué mirar en la máquina, qué señal usar, qué hardware hace falta y cómo validar que lo que mides es real.

## Cuándo se activa

- «Quiero saber cuántas piezas hace esta máquina al día».
- Contadores de agua, luz o gas sin telemetría.
- Compresores, bombas, hornos, cámaras de frío, riegos.
- Una pyme que quiere un panel de producción y no va a cambiar la máquina.

## Qué preguntar antes de responder

1. Marca, modelo y año de la máquina. Pide foto de la placa de características y del cuadro.
2. ¿Qué dato quieres exactamente? (piezas, horas de marcha, consumo, temperatura, paradas).
3. ¿La máquina está en garantía o en contrato de mantenimiento del fabricante?
4. ¿Tiene manual? ¿Hay una salida de señal, un borne libre, un display, un puerto?
5. ¿Se puede parar la máquina para instalar y cuándo?
6. ¿Quién autoriza tocarla y hay electricista de la empresa?

## Método paso a paso

### 1. Busca la salida que ya existe (siempre primero)

Muchas máquinas tienen lo que necesitas y nadie lo sabe: salida de impulsos, contacto libre de tensión de «marcha» o «avería», puerto RS-485 con Modbus, salida 4-20 mA. Está en el manual, en la sección de conexiones o de comunicaciones. Pedir el manual al fabricante es gratis y ahorra días.

### 2. Escalera de invasividad, de menos a más

1. **Nada tocado**: pinza amperimétrica alrededor del cable de alimentación. Te dice si está en marcha, cuánto consume y, con un umbral, cuántos ciclos hace. Sin tocar la máquina, sin garantía en riesgo.
2. **Sensor externo pegado**: sensor de vibración, de proximidad inductivo, barrera óptica, sensor de temperatura de superficie, o un sensor óptico sobre el LED parpadeante del contador. Se pega, no se conecta.
3. **Señal existente leída**: contacto seco a una entrada digital, salida de impulsos a un contador, Modbus RTU por RS-485 en solo lectura.
4. **Intervención en cuadro**: relé auxiliar en paralelo con un contactor. Ya es trabajo de electricista y con permiso escrito.

### 3. Elige el sensor según el dato

- **Está encendida / apagada**: pinza de corriente o relé auxiliar.
- **Cuenta de piezas**: inductivo, óptico o el propio impulso de la máquina.
- **Consumo**: medidor con pinza en el cuadro.
- **Temperatura de proceso**: sonda de superficie o infrarrojo, nunca dentro sin permiso.
- **Nivel o presión**: sensor 4-20 mA en la línea existente si hay toma preparada.

### 4. Modbus RTU en la práctica

Si hay RS-485, pide el mapa de registros al fabricante. Necesitas: velocidad, paridad, dirección del esclavo y número de registro. Empieza leyendo, nunca escribiendo. Un fallo de escritura en un variador puede parar la producción. Usa un adaptador USB-RS485 y un cliente Modbus para probar antes de montar nada fijo.

### 5. Valida contra la realidad

Este paso es el que separa a un profesional de un aficionado: durante un turno, compara tu dato con el contador manual, el albarán o lo que diga el operario. Si tu sistema cuenta 480 y el operario dice 512, tienes un problema de umbral o de rebotes, no de programación. Ajusta y vuelve a validar.

### 6. Antirrebotes y falsos conteos

Los contactos mecánicos rebotan y cuentan de más. Filtra en firmware con un tiempo mínimo entre pulsos coherente con el ciclo real de la máquina. Si la máquina hace una pieza cada 2 segundos, ignora pulsos separados menos de 0,5 segundos.

## Formato exacto de la respuesta

1. **Qué se va a medir** y con qué precisión esperada.
2. **Opción recomendada** en la escalera de invasividad, con la razón.
3. **Lista de material** con función de cada pieza.
4. **Plan de instalación**: pasos, tiempo de parada necesario, quién debe estar presente.
5. **Plan de validación**: contra qué se compara, cuántas horas, criterio de aceptación (por ejemplo, error por debajo del 2 % en un turno).
6. **Permisos y riesgos**: qué hay que firmar antes de tocar nada.

## Errores típicos

- Abrir el cuadro de una máquina en garantía sin permiso escrito: se lo cobran al cliente y te lo cobra el cliente a ti.
- Contar pulsos sin filtro antirrebote y entregar cifras infladas.
- Escribir en registros Modbus para «probar».
- Instalar sin ver la máquina en marcha: los ciclos reales nunca son los del manual.
- Poner el sensor donde estorba al operario: lo desconecta a la semana.

## Avisos honestos

- Cualquier trabajo dentro del cuadro eléctrico de una máquina industrial es de electricista autorizado, con la máquina consignada. No lo hagas tú.
- Si la máquina es de seguridad crítica (prensas, hornos, elevadores) no toques nada que pueda interferir con sus enclavamientos.
- Di siempre al cliente que el sistema es de medición, no de control: no va a parar ni arrancar nada.
