---
name: flasheo-firmware-con-vuelta-atras
description: Planifica y ejecuta el flasheo seguro de firmware en dispositivos ESP8266/ESP32 (Tasmota, ESPHome, copia de seguridad de fábrica, OTA) con copia de seguridad, recuperación y vuelta atrás, además del rescate de dispositivos bloqueados. Úsala antes de flashear un enchufe inteligente, bombilla o placa de desarrollo, o cuando un dispositivo haya dejado de arrancar tras una actualización.
---

# Flasheo de firmware con plan de vuelta atrás

## Qué hace
Te lleva paso a paso a cambiar el firmware de un aparato sin quedarte con un ladrillo: copia de seguridad primero, método adecuado al modelo, y procedimiento de rescate si algo sale mal.

## Cuándo se activa
Antes de flashear cualquier cosa, al actualizar una flota de dispositivos, o cuando un aparato dejó de arrancar tras una actualización.

## Qué preguntar si falta información
1. Modelo exacto y, si puedes, el lote o la revisión de la placa (los fabricantes cambian el chip sin cambiar el nombre).
2. ¿Qué chip lleva? ESP8266, ESP8285, ESP32, o ya un BK7231/RTL8710 (estos no admiten Tasmota clásico).
3. ¿Está montado en pared o lo tienes en la mano?
4. ¿Tienes adaptador USB-serie de 3,3 V, pinzas o soldador?
5. ¿Qué buscas: control local, más funciones, o quitar la nube?
6. ¿Es de un cliente o tuyo? (en cliente, el riesgo de dejarlo muerto no es aceptable sin repuesto).

## Método
### 1. Antes de tocar nada
- Comprueba si el modelo está en las listas de dispositivos soportados de Tasmota o ESPHome, y con qué plantilla (template) de pines.
- Compra dos unidades: una de sacrificio para probar. Es la diferencia entre un experimento y un desastre.
- **Haz copia del firmware original** con `esptool.py read_flash 0x0 0x400000 copia.bin` (ajusta el tamaño). Es la única vuelta atrás real.
- Anota qué versión y qué configuración tenía.

### 2. Elegir método
- **Por aire (OTA), sin abrir**: si el modelo admite algún método de liberación por red para su chip y versión, es lo más cómodo. Los fabricantes lo van cerrando, así que depende del firmware que traiga.
- **Por cable serie**: siempre funciona pero hay que abrir y acceder a los pines TX, RX, GND, 3V3 y GPIO0.
- **Tuya-Convert y similares**: solo con firmware antiguo; hoy casi nunca.

### 3. Flasheo por serie, bien hecho
- Alimenta a **3,3 V y nunca a 5 V** en los pines lógicos: quemarías el chip.
- La alimentación del adaptador USB-serie suele ser flojísima. Para ESP32 usa una fuente aparte de 3,3 V con al menos 500 mA y une las masas.
- **Desconecta el aparato de la red de 230 V mientras esté con el cable serie.** Nunca las dos cosas a la vez: hay módulos sin aislamiento galvánica y puedes freír el portátil o electrocutarte.
- Para entrar en modo flasheo: GPIO0 a masa antes de dar alimentación, soltar después.
- Borra antes: `esptool.py erase_flash`, luego escribe el nuevo binario.
- Si falla la conexión: baja la velocidad a 115200, prueba a cambiar TX/RX (es el error más común), y comprueba que el adaptador tiene driver instalado.

### 4. Primera configuración
- Conéctalo a la Wi-Fi, ponle nombre siguiendo tu convención y **cambia la contraseña de administración**.
- Aplica la plantilla de pines correcta antes de conectarlo a nada real: con la plantilla equivocada un relé puede quedarse pegado.
- Prueba en el banco con una lámpara antes de montarlo en la pared.

### 5. Actualizaciones posteriores
- Actualiza siempre de uno en uno y espera 24 h antes de tocar el resto de la flota.
- Guarda copia de la configuración (en Tasmota, el fichero de configuración; en ESPHome, tu YAML es la copia).
- En saltos de versión grandes, pasa por la versión intermedia recomendada: saltar demasiado puede corromper la configuración.

### 6. Rescate de un aparato muerto
- Si no arranca: normalmente sigue vivo por serie. Borra y vuelve a escribir la copia original.
- Bucle de reinicio: casi siempre es alimentación insuficiente o plantilla de pines mal.
- No aparece el puerto: driver del adaptador (CH340, CP2102) o cable USB que solo lleva alimentación.
- Si el chip no responde a nada por serie, es hardware: se acabó.

## Formato exacto de la respuesta
- **Ficha del aparato**: chip, soportado sí/no, método recomendado, plantilla de pines.
- **Material necesario** con lo que hay que comprar.
- **Procedimiento numerado**, con los comandos exactos.
- **Punto de no retorno** claramente marcado: qué paso es el irreversible.
- **Plan de rescate** paso a paso.
- **Comprobación final**: qué debe funcionar antes de montarlo.

## Errores típicos
- Flashear sin copia del original y no poder devolver el aparato.
- Alimentar el módulo desde el USB-serie y que se reinicie a mitad de escritura.
- Tener el aparato enchufado a la red mientras se flashea.
- Confiar en que el modelo es el mismo que el del tutorial de hace dos años.
- Montar en pared antes de probar en la mesa.

## Avisos honestos
- Flashear anula la garantía y, en aparatos que van a 230 V, puedes quedarte sin el respaldo del fabricante ante un incidente.
- Muchos enchufes y bombillas nuevos ya no llevan chip ESP: no hay forma sencilla de liberarlos.
- Si el aparato controla algo crítico o va empotrado en obra, valora comprar directamente hardware pensado para control local en vez de liberar.
