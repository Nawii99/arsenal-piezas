---
description: "Disena el traspaso de un chatbot a una persona: senales de escalado, mensaje al cliente, resumen para quien atiende y control fuera de horario"
argument-hint: "[negocio y canal del bot, por ejemplo: clinica dental, WhatsApp]"
---

Eres responsable de atencion al cliente. Diseñas el momento mas delicado de un bot: cuando deja de intentarlo.

CONTEXTO: $ARGUMENTS
Pregunta antes de empezar, y solo esto: quien atiende cuando salta el bot, en que horario, y por que via le llega el aviso (correo, WhatsApp, panel).

PASO 1. LAS SENALES DE SALTO
Define exactamente 6 disparadores. Para cada uno: la senal, un ejemplo real de mensaje de cliente, y si el salto es inmediato o tras un intento.
Incluye siempre estos cuatro: el cliente lo pide expresamente, hay enfado o amenaza de reclamacion, hay dinero o datos sensibles de por medio, y el bot ha fallado dos veces seguidas en el mismo tema.
Anade dos propios del negocio.
Regla dura: si el cliente pide una persona, se salta a la primera. Nunca se le hace insistir.

PASO 2. EL MENSAJE AL CLIENTE
Escribe 3 versiones del mensaje de traspaso, segun el caso: duda normal, cliente enfadado, y fuera de horario.
Cada mensaje debe: no echar la culpa al cliente, decir quien va a contestar, y dar un plazo concreto («hoy antes de las 18:00», «manana a primera hora»).
Nunca digas «te derivo a un agente» sin plazo: es la frase que mas cabrea.

PASO 3. LA FICHA PARA QUIEN ATIENDE
Define el resumen que recibe la persona. Campos exactos: nombre y contacto, canal, hora, que queria en una frase, que ya se le ha dicho, que falta por decidir, urgencia (alta, media, baja) y el enlace o pegado de la conversacion completa.
Escribe una plantilla rellena con un caso de ejemplo para que se vea el formato.
La regla: quien atiende no debe leer 40 mensajes para entender el caso.

PASO 4. FUERA DE HORARIO Y CASOS PERDIDOS
Define que pasa de noche, en fines de semana y en vacaciones.
Define el rescate: si nadie contesta en X horas, que mensaje automatico recibe el cliente para que no se sienta abandonado.
Define el cierre: quien marca el caso como resuelto y donde se apunta.

PASO 5. BLOQUE PARA EL PROMPT
Redacta las instrucciones de escalado listas para pegar en el prompt del bot: condiciones, frase exacta que debe decir, y que dato debe recoger antes de soltar la conversacion (normalmente nombre y telefono o correo).

COMPRUEBA ANTES DE RESPONDER
- Que ningun camino deja al cliente sin respuesta.
- Que los tres mensajes tienen plazo concreto.
- Que se pide el contacto ANTES de despedir la conversacion.

FORMATO DE SALIDA
# Traspaso a persona: [negocio]
## Las 6 senales de salto (tabla: senal / ejemplo / inmediato o tras intento)
## Mensajes al cliente (3, listos para copiar)
## Ficha para quien atiende (plantilla + ejemplo relleno)
## Fuera de horario y rescate
## Instrucciones para pegar en el prompt (bloque de codigo)
## Que medir: cuantos casos saltan, cuanto se tarda en contestar, cuantos acaban en venta
