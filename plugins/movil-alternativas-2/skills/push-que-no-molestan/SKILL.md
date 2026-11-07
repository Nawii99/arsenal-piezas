---
name: push-que-no-molestan
description: "Crea una estrategia de notificaciones push para una app: momento de pedir el permiso, segmentación, calendario de mensajes, texto y límites de frecuencia. Úsala cuando el usuario vaya a añadir notificaciones push, tenga una baja tasa de aceptación, vea desinstalaciones tras enviarlas, o necesite textos para notificaciones."
---

# Notificaciones push que no queman

## Qué hace
Define cuándo pides el permiso, qué notificaciones existen, a quién van, cuándo se envían y con qué texto exacto.

## Cuándo se activa
Cuando el usuario habla de push, avisos, recordatorios en la app, permisos de notificaciones o de reactivar usuarios dormidos.

## Qué preguntar si falta información
1. ¿Qué hace la app y cada cuánto tiene sentido usarla?
2. ¿Qué acciones del usuario o del sistema pueden disparar un aviso?
3. ¿Tienes ya permisos concedidos y qué porcentaje?
4. ¿Qué herramienta usas para enviarlas?
5. ¿En qué franja horaria está tu público?

## Método
1. Separa dos familias: transaccionales (algo le ha pasado a este usuario: pedido enviado, mensaje recibido, cita mañana) y de marketing (novedades, promociones). Las primeras se toleran siempre; las segundas hay que ganárselas.
2. Permiso: nunca al abrir por primera vez. Pide el permiso justo después de una acción que crea expectativa ("te aviso cuando llegue la respuesta"). Antes del diálogo del sistema, pon una pantalla tuya con el porqué y un botón "Ahora no": si dicen que no ahí, puedes volver a preguntar más adelante; si dicen que no en el diálogo del sistema, ya no puedes.
3. Recuerda que en Android moderno también hace falta permiso explícito, y que si el usuario lo deniega dos veces el sistema lo bloquea.
4. Diseña el calendario por disparador, no por fecha: cada notificación nace de un evento del usuario. Escribe la lista: evento que la dispara, condición para no enviarla, retraso, y a dónde lleva al tocarla.
5. Texto: título de hasta 40 caracteres y cuerpo de hasta 120 aprox. (el sistema corta). Concreto y con el dato dentro: "Tu cita con Ana es mañana a las 10:00" gana a "Tienes una cita pendiente". Nada de mayúsculas ni de emojis de relleno.
6. Cada notificación abre la pantalla exacta relacionada (deep link), nunca la portada. Abrir la home es la forma más rápida de que te desactiven.
7. Pon topes: máximo 2-3 de marketing por semana, ninguna entre las 22:00 y las 8:00 salvo urgencia real, y una regla de "si ya abrió la app hoy, no le mandes el recordatorio".
8. Higiene: si alguien no abre 10 notificaciones seguidas, deja de mandarle marketing y quédate solo con las transaccionales.
9. Mide: permiso concedido, entregadas, abiertas (compara por tipo de mensaje, no en global), y sobre todo desinstalaciones en las 24 h siguientes a un envío masivo.

## Formato exacto de la respuesta
- PANTALLA DE PETICIÓN DE PERMISO: titular, dos frases, dos botones, y en qué momento aparece
- TABLA DE NOTIFICACIONES: nombre | tipo | disparador | espera | segmento | pantalla de destino | tope de frecuencia
- TEXTOS: título y cuerpo de cada una, con el contador de caracteres y las variables entre llaves
- REGLAS DE SILENCIO: horas, días y condiciones de exclusión
- SECUENCIA DE REACTIVACIÓN para usuarios dormidos, 3 mensajes
- MÉTRICAS Y UMBRALES para apagar una notificación

## Errores típicos
- Pedir el permiso en el primer segundo y quemarlo para siempre.
- Enviar la misma promoción a todos, incluidos los que acaban de comprar.
- Notificaciones que dicen "¡Te echamos de menos!" sin ningún motivo real.
- No poner deep link y soltar al usuario en la portada.
- Programar por hora del servidor y despertar a la mitad de tus usuarios.
- No dar ajustes de notificaciones dentro de la app: si no puede bajar el volumen, apaga todo o desinstala.

## Avisos honestos
- Cada envío masivo tiene coste: parte de la gente desactiva o desinstala. Ese coste solo se paga cuando el mensaje aporta algo.
- Las tasas de apertura varían muchísimo por sector; no te pongas objetivos copiados de un blog.
- Si mandas comunicaciones comerciales, necesitas base legal y una forma clara de darse de baja.
