---
name: tareas-criticas-service-bus-python
description: Convierte un proceso crítico (cobro, envío, factura) en tareas que pasan por Azure Service Bus con Python, con reintentos medidos, mensajes fallidos revisables y alarma a una persona. Úsala cuando algo no deba fallar en silencio y el usuario trabaje con Python.
---
# Tareas críticas con reintentos y alarma
## Qué hace
Pone una cola de Azure Service Bus entre quien pide una tarea (cobrar, enviar, emitir una factura) y quien la ejecuta. Si la ejecución falla, la tarea se reintenta con cabeza. Si sigue fallando, se aparta y avisa a una persona. Claude Code escribe y prueba el código en Python.
## Cómo instalarla (para ti, no para Claude)
Guarda este texto como `.claude/skills/tareas-criticas-service-bus-python/SKILL.md` en tu proyecto. Necesitas una cuenta de Azure y Python 3 instalado en el ordenador donde trabaje Claude Code.
## Primero, ¿lo necesitas de verdad?
Si el proceso ya funciona en n8n con reintentos y avisos de error, y el volumen es bajo, quizá no necesites Service Bus. Más piezas significan más cosas que se pueden romper. Comprueba si tu versión de n8n trae nodo para Service Bus; si no, hará falta código.
Tiene sentido si el volumen es alto, si varios programas deben reaccionar a la misma tarea o si la tarea debe esperar a una hora concreta. En otro caso, dilo y para aquí.
## Qué preguntar antes de empezar
Pregunta todo de una vez. Si falta algo importante, no empieces.
1. ¿Qué tarea es? Cobro, envío, factura o aviso. Cuéntame qué pasa de principio a fin.
2. ¿Qué pasa si se ejecuta dos veces? ¿Y si no se ejecuta nunca? ¿Cuál de las dos cosas es peor?
3. ¿Con qué sistema externo habla? Pasarela de pago, transportista o programa de facturación. ¿Admite una clave de idempotencia (una clave que evita repetir la operación)? Búscalo en su documentación.
4. ¿Cuántas tareas al día y con qué picos?
5. ¿Alguna debe ejecutarse a una hora concreta, como un aviso de cobro a las 9:00?
6. ¿A quién se avisa si algo falla y por qué canal, email o móvil?
7. ¿En qué región de Azure (UE si hay datos personales) y con qué tope de gasto? [TOPE EN EUROS]
## Paso a paso
1. Escribe la tarea en una frase y lista los pasos externos que tiene, como llamar a la pasarela de pago o a la mensajería. Cada paso externo es un posible fallo.
2. Decide qué lleva el mensaje: identificador de la tarea, tipo y datos mínimos. Y qué no lleva nunca: datos de tarjeta, contraseñas y datos sensibles.
3. Elige cola si la tarea la ejecuta un solo receptor, o tema con suscripciones si varios sistemas reaccionan al mismo hecho. El nivel Standard suele bastar para empezar. Compara precios en la calculadora de Azure.
4. Idempotencia. Cada tarea lleva un identificador único y estable. Al llamar al proveedor externo se envía esa clave para que repetir la llamada no cobre dos veces (Stripe, por ejemplo, la admite; mira la documentación de tu proveedor). Si no la admite, antes de reintentar un cobro hay que comprobar si el primero se hizo.
5. Código. Pide a Claude Code un script con el paquete oficial `azure-servicebus` de Python y, para entrar sin claves, `azure-identity`. Comprueba las versiones actuales. Debe llevar emisor, receptor, la función que ejecuta la tarea y la regla de dar el mensaje por terminado solo si la tarea salió bien.
6. Reintentos en dos niveles. Primero, reintento rápido dentro del programa para fallos pasajeros como la red: 2 o 3 veces con espera creciente. Después, si falla, el mensaje vuelve a la cola y Service Bus lo entrega otra vez hasta el máximo de entregas. Fija ese máximo según el caso: [NÚMERO]. En cobros, pocos.
7. Fallos que no merece la pena reintentar, como tarjeta rechazada o dirección inexistente. No se reintentan: van a la cola de mensajes fallidos con el motivo escrito.
8. Mensajes fallidos. Crea un proceso que lee esa cola, resume los fallos en una lista legible y avisa a la persona responsable. Nunca borra nada por su cuenta.
9. Tareas con hora. Si algo debe ejecutarse más tarde, usa mensajes programados de Service Bus en vez de un reloj propio. Service Bus trabaja con hora universal: convierte desde Europe/Madrid y ten en cuenta el cambio de hora de marzo y de octubre.
10. Tiempo de bloqueo. Si la tarea tarda más que el bloqueo del mensaje, Service Bus lo entrega a otro receptor y se ejecuta dos veces. Mide cuánto tarda la tarea y renueva el bloqueo o ajusta el tiempo.
11. Pruebas con datos de prueba y el entorno de pruebas del proveedor. Una tarea buena. Una que falla una vez y luego va bien. Una que siempre falla. La misma tarea enviada dos veces. El programa cortado a mitad.
12. Vigilancia. Crea una alerta en Azure Monitor sobre los mensajes en la cola de fallidos y sobre la antigüedad del mensaje más viejo. Comprueba que el aviso llega de verdad al móvil de la persona.
## Qué devolver
- La descripción de la tarea y de sus fallos posibles en una lista simple.
- La decisión sobre si hace falta Service Bus, con los motivos.
- El script de Python con comentarios en castellano, un archivo de ajustes de ejemplo sin claves y los pasos de Azure.
- Una tabla de pruebas con caso, resultado esperado y resultado real.
- Una lista titulada «Antes de usarlo con dinero real, que lo revise una persona» con la idempotencia con el proveedor de pago, el tope de reintentos, quién recibe la alarma y los datos personales que viajan en los mensajes.
## Qué NO hacer
- No hagas pruebas con cobros o envíos reales. Usa el entorno de pruebas del proveedor o importes de prueba.
- No reintentes un cobro sin clave de idempotencia o sin comprobar si ya se hizo. Puedes cobrar dos veces a un cliente.
- No reintentes sin límite ni sin espera. Puedes saturar al proveedor o bloquear el sistema.
- No metas datos de tarjeta, contraseñas ni datos sensibles en los mensajes.
- No pegues claves ni cadenas de conexión en el chat ni en el código.
- No dejes la cola de fallidos sin una persona responsable.
- No prometas «100 % de ejecución» ni «clientes que se quedan». Lo que se promete es que los fallos se ven.
- No lo pongas en producción sin que lo revise alguien con experiencia en Azure y en pagos.
