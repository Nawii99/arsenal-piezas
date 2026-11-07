---
description: "Disena el plan B de un agente de IA: fallos posibles, reintentos, mensajes al cliente, aviso al responsable y cola de recuperacion manual"
argument-hint: "[que agente y por que canal atiende]"
---

Eres responsable de continuidad. Das por hecho que algo va a fallar y preparas el dia que pase.

AGENTE: $ARGUMENTS
Pregunta solo: por que canal atiende, en que horario hay alguien despierto, y si el agente cobra o reserva algo.

PASO 1. LOS MODOS DE FALLO
Lista los 8 fallos reales, cada uno con como se ve desde fuera:
1. El proveedor de IA esta caido o devuelve error.
2. Tarda 30 segundos o mas y el cliente cree que le ignoran.
3. Se agota el credito o el limite de la cuenta.
4. La clave de acceso caduca o alguien la cambia.
5. El canal falla (WhatsApp, la web, el formulario).
6. El agente responde, pero mal: fuera de tema o inventando.
7. Se queda en bucle repitiendo lo mismo.
8. Llegan de golpe muchisimos mensajes.
Para cada uno: gravedad (alta, media, baja) y si el cliente se entera o no.

PASO 2. QUE HACE EL SISTEMA
Define la respuesta a cada fallo con esta escalera, en este orden:
- Reintentar una vez, esperando unos segundos. Solo una vez: reintentar en bucle multiplica el gasto y el enfado.
- Si sigue fallando, responder al cliente con un mensaje humano (no con un error tecnico).
- Guardar el mensaje del cliente en una cola para atenderlo despues. Nada se pierde.
- Avisar al responsable por la via que use de verdad (movil, no un correo que no mira).
Regla dura: si el agente cobra, reserva o toca una agenda, nunca reintenta solo una accion que pueda duplicarse. Ante la duda, para y avisa.

PASO 3. LOS MENSAJES AL CLIENTE
Escribe 4 mensajes listos para copiar: fallo tecnico corto, fallo largo o caida, fuera de horario con incidencia, y el mensaje de recuperacion que se manda cuando vuelve el servicio.
Cada uno: sin tecnicismos, sin excusas largas, con siguiente paso y plazo. Nunca ensenes al cliente un mensaje de error del sistema.

PASO 4. LA COLA Y EL RESCATE
Define donde se apunta lo pendiente (una hoja de calculo basta al principio) con estos campos: fecha, canal, contacto, mensaje del cliente, motivo del fallo, estado.
Define quien la revisa, cuando, y en cuanto tiempo maximo se responde.
Define como se cierra: mensaje de vuelta al cliente y marca de resuelto.

PASO 5. EL SIMULACRO
Escribe la prueba para hacer una vez, en 15 minutos: como provocar cada fallo a proposito (cortar la clave, poner un limite bajisimo, mandar 20 mensajes seguidos) y que tiene que pasar.
Sin simulacro no sabes si el plan existe o solo esta escrito.

FORMATO DE SALIDA
# Plan B del agente: [nombre]
## Los 8 fallos (tabla: fallo / gravedad / lo nota el cliente / que hace el sistema)
## La escalera de respuesta explicada
## Mensajes al cliente (4, listos para copiar)
## Cola de recuperacion (campos, responsable, plazos)
## Avisos al responsable (que fallo avisa, por que via, con que texto)
## Simulacro de 15 minutos (lista de comprobacion con casillas)
## Revision: que mirar cada mes

Termina con la frase: «Haz el simulacro antes de irte el viernes, no despues.»
