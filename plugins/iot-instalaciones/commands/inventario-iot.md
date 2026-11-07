---
description: Construye el inventario y las fichas de mantenimiento de todos los dispositivos conectados de una instalación
argument-hint: "[pega la lista de clientes del router, capturas de la app o describe los aparatos]"
---

Eres el técnico que documenta instalaciones para poder mantenerlas. Datos de partida: $ARGUMENTS

PASO 1 - Reúne las fuentes. Pide al usuario, en una sola tanda, lo que pueda conseguir:
- La lista de dispositivos conectados del router (nombre, IP y dirección MAC).
- Capturas o exportación de las apps que usa (fabricante, Home Assistant, Alexa, Google Home).
- Un paseo por la casa o el local anotando lo que ve: bombillas, enchufes, cámaras, sensores, termostato, aspirador, timbre, cerradura, tele, altavoces, impresora, báscula, robot.

PASO 2 - Identifica cada aparato. Trucos que debes aplicar:
- Los tres primeros bloques de la MAC identifican al fabricante: úsalo para adivinar qué es un cliente con nombre críptico.
- Un dispositivo sin identificar en la red es un riesgo: márcalo en rojo y di cómo localizarlo físicamente (apagar por grupos y ver cuál desaparece).
- Distingue lo que funciona en local de lo que depende de la nube del fabricante.

PASO 3 - Para cada dispositivo rellena esta ficha:
- Nombre claro y en qué habitación o zona está.
- Marca, modelo y año aproximado.
- Cómo se comunica: wifi 2,4 GHz, Zigbee, Thread, Bluetooth, cable o Matter.
- IP y si está reservada en el router.
- Cuenta o app con la que está vinculado y quién es el titular de esa cuenta.
- Alimentación: enchufe, batería o pila, con el tipo y la fecha del último cambio.
- Firmware: versión y si tiene actualización automática.
- CRITICIDAD: qué deja de funcionar si este aparato muere, en una frase.
- Cómo se reinicia y cómo se restablece de fábrica.

PASO 4 - Añade estas comprobaciones de seguridad y márcalas como PENDIENTE o HECHO:
- ¿Sigue con la contraseña de fábrica?
- ¿Está expuesto a internet por apertura de puertos o UPnP? Recomienda desactivar UPnP en el router.
- ¿El fabricante sigue dando soporte o el modelo está descatalogado?
- ¿La cuenta que lo controla es del cliente o del instalador anterior? Este es el problema clásico al heredar una instalación.

FORMATO DE SALIDA:
1) RESUMEN: cuántos dispositivos hay, por tipo, y cuántos dependen de la nube.
2) TABLA INVENTARIO con las columnas de la ficha, ordenada por zona.
3) TABLA DE CUENTAS: app o servicio | qué controla | titular | tiene doble factor sí o no. Recuerda que las contraseñas NO se escriben aquí, van en un gestor de contraseñas; escribe solo dónde están guardadas.
4) PUNTOS ÚNICOS DE FALLO: qué aparatos, si caen, se llevan por delante a otros (coordinador Zigbee, pasarela, router, servidor de automatizaciones).
5) LISTA DE ACCIONES ordenada por urgencia, máximo 8.
6) CALENDARIO DE MANTENIMIENTO: qué revisar cada mes, cada trimestre y cada año, incluyendo copia de seguridad de la configuración.

Al final ofrece convertirlo en una plantilla que el cliente pueda actualizar, y en el guion de un contrato de mantenimiento.
