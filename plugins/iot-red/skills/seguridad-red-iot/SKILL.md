---
name: seguridad-red-iot
description: "Refuerza la seguridad de una instalación IoT/hogar inteligente: segmentación de red, eliminar la exposición a internet, credenciales por defecto, firmware y privacidad de cámaras, sin romper lo que ya funciona. Úsala antes de entregar una instalación a un cliente, o cuando cámaras, timbres y dispositivos baratos compartan red con ordenadores de empresa."
---

# Asegurar una instalación IoT

## Qué hace

Revisa una instalación ya montada y la deja razonablemente segura, con cambios ordenados de mayor a menor riesgo y con el aviso claro de qué se puede romper al aplicarlos. No usa herramientas de ataque: es una revisión de configuración.

## Cuándo se activa

- Antes de entregar una instalación a un cliente.
- Cuando hay cámaras IP, videoporteros o enchufes de marca desconocida.
- Cuando alguien ha abierto puertos en el router para «verlo desde fuera».
- Cuando el cliente pregunta si le pueden espiar.

## Qué preguntar antes de responder

1. ¿Qué router hay y quién lo controla? ¿Es del operador con configuración limitada?
2. ¿Hay cámaras? ¿De qué marca y con qué app o nube?
3. ¿Hay algún puerto abierto o DDNS configurado?
4. ¿La instalación comparte red con ordenadores de trabajo, TPV o caja?
5. ¿Hay WiFi de invitados y para qué se usa?
6. ¿Quién tiene las contraseñas y cómo se guardan?
7. ¿Es un domicilio o un local con empleados o público?

## Método paso a paso

### 1. Cerrar la exposición a internet (lo más urgente)

Ningún dispositivo IoT debe tener un puerto abierto hacia internet. Ni cámara, ni grabador, ni hub. Sustituye la apertura de puertos por acceso mediante VPN del router, Tailscale o similar, o por la nube del fabricante si es de confianza. Comprueba también UPnP: desactívalo en el router, porque abre puertos solo.

### 2. Contraseñas de fábrica

Cambia todas: cámara, grabador, hub, panel de alarma, WiFi de administración. Contraseñas distintas por dispositivo, guardadas en un gestor. Entrega al cliente una hoja de credenciales y quédate una copia solo si él lo autoriza por escrito.

### 3. Separar redes

Ideal: una red o VLAN solo para IoT, sin acceso a la red de ordenadores. Si el router no permite VLAN, la versión pobre pero válida es usar la red de invitados con aislamiento de clientes para los dispositivos que no necesitan hablar entre sí. Aviso importante: muchos protocolos de descubrimiento (Chromecast, impresoras, HomeKit, Sonos) dejan de funcionar entre redes distintas. Prueba antes de irte.

### 4. Firmware

Actualiza todo lo que tenga actualización, empezando por router, cámaras y grabador. Si un dispositivo lleva años sin actualizaciones del fabricante, márcalo como material a sustituir y dilo por escrito.

### 5. Cámaras y privacidad

Encuadre: nada de vía pública ni de la casa del vecino. En un local con trabajadores, hay obligaciones legales de información y no se puede grabar en zonas de descanso ni aseos. Cartel informativo visible y registro de la finalidad. Si el cliente pide grabar audio, avisa de que es mucho más restrictivo. Si la cámara es de marca desconocida con nube en el extranjero, plantea alternativa con grabación local.

### 6. Cuentas y accesos

Una cuenta por persona, nunca la del instalador compartida. Doble factor donde exista. Y lo que casi nadie hace: un procedimiento para quitar el acceso a alguien que se va (empleado, exsocio, expareja).

### 7. Copias y recuperación

Copia de la configuración del hub y del grabador, guardada fuera del sitio. Si el sistema se pierde, ¿cuánto tiempo cuesta rehacerlo? Si la respuesta es «un día entero», haz copia.

## Formato exacto de la respuesta

1. **Lista de riesgos encontrados**, cada uno con: qué es, qué podría pasar, gravedad alta/media/baja.
2. **Plan de arreglo en tres bloques**: hoy (crítico), esta semana, y mejoras.
3. **Para cada cambio**: qué se toca, qué puede dejar de funcionar y cómo comprobarlo después.
4. **Hoja de entrega al cliente**: dispositivos, usuarios con acceso, dónde están las credenciales, qué hacer si pasa algo.
5. **Lo que no se ha revisado**, dicho claramente.

## Errores típicos

- Abrir el puerto 80 o el 554 «para ver la cámara desde el móvil».
- Dejar el usuario admin con contraseña admin en el grabador.
- Meter todo en la red de invitados y romper la tele, la impresora y los altavoces sin probarlo.
- Poner el mismo WiFi para el TPV del negocio y para los enchufes chinos.
- Guardar las contraseñas del cliente en una nota del móvil.

## Avisos honestos

- Esto es una revisión de configuración, no una auditoría profesional ni un test de intrusión. No sustituye a un especialista si el cliente maneja datos sensibles.
- Segmentar bien exige un router decente. Con el router del operador a veces solo se puede hacer la mitad; dilo en vez de fingir.
- La parte legal de las cámaras (RGPD, laboral) tiene consecuencias serias: si hay empleados, que lo revise un asesor.
