---
description: Diseña la estrategia de notificaciones push de una app o web: momento de pedir permiso, mensajes, frecuencia y métricas para medirlo
argument-hint: [qué app es y qué quieres conseguir con las notificaciones]
---

Vas a diseñar las notificaciones push de: $ARGUMENTS

Escribes en español de España y tuteas. Piensa como responsable de retención, no como programador.

PASO 1. Pregunta lo necesario:
- ¿Qué hace el usuario dentro de la app y cada cuánto tendría sentido que volviera?
- ¿Qué quieres conseguir: que vuelva, que termine algo que dejó a medias, que compre o que no se le olvide una cita?
- ¿Tienes horarios o eventos naturales, como una reserva, un pedido o una entrega?
- ¿Es app instalada o web instalada en el móvil?

PASO 2. Resuelve primero el permiso, que es donde casi todo el mundo se equivoca:
- Nunca pidas el permiso en la primera pantalla, nada más abrir. Se deniega y en iPhone la ventana del sistema solo se muestra una vez: si te dicen que no, ya solo se puede cambiar entrando en los ajustes del móvil.
- Pide el permiso justo después de que el usuario haga algo que da sentido al aviso: reservar, seguir un pedido, activar un recordatorio.
- Antes de la ventana del sistema, pon una pantalla tuya explicando en una frase qué le vas a mandar y cada cuánto. Si dice que no en tu pantalla, no lances la del sistema y podrás volver a preguntar más adelante.
- Recuerda que en Android 13 y posteriores también hace falta pedir permiso, y que en iPhone la web instalada solo puede notificar si se añadió a la pantalla de inicio.

PASO 3. Clasifica los avisos en tres familias y no las mezcles:
- TRANSACCIONALES: algo que le ha pasado a él. Pedido enviado, cita mañana, mensaje recibido. Son las mejor aceptadas.
- ÚTILES: recordatorios y avances que ayudan a terminar algo que empezó.
- COMERCIALES: promociones y novedades. Son las que queman. Como mucho una a la semana, y con opción de desactivarlas por separado.

PASO 4. Escribe los mensajes. Para cada uno entrega: nombre del aviso, cuándo se dispara, título de máximo 40 caracteres, cuerpo de máximo 120 caracteres, a qué pantalla lleva al pulsar y familia a la que pertenece. Reglas de redacción: una idea por mensaje, el beneficio o el dato concreto delante, nada de mayúsculas gritando, nada de intriga vacía tipo «no te vas a creer esto», y usa el nombre o el dato del usuario si lo tienes.

PASO 5. Pon las reglas de convivencia y déjalas escritas:
- Máximo de avisos por usuario y semana, y dilo con un número.
- Franja horaria permitida y respeto a la zona horaria del usuario. Nada entre las 22:00 y las 9:00 salvo transaccionales.
- Silencio automático si el usuario ya ha entrado hoy o ya ha hecho la acción que ibas a recordarle.
- Un ajuste dentro de la app para elegir qué familias quiere recibir. Sin eso, la única salida del usuario es desactivarlo todo o desinstalar.

PASO 6. Define qué medir y con qué señales de alarma: porcentaje de permisos aceptados, porcentaje de avisos abiertos por familia, desactivaciones tras cada campaña y desinstalaciones en las 48 horas siguientes. Di que si un aviso baja del umbral de apertura habitual dos veces seguidas, se retira, no se reescribe una tercera vez.

ERRORES TÍPICOS: mandar la misma promoción a todo el mundo, avisar de algo que el usuario ya ha hecho, mandar a la portada en vez de a la pantalla concreta del aviso, y no probar cómo se ve el texto cortado en una pantalla pequeña.

FORMATO DE SALIDA: tabla con los avisos (nombre, disparador, título, cuerpo, destino, familia), bloque de reglas de convivencia, bloque de métricas y calendario de la primera semana de un usuario nuevo.
