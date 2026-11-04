---
name: cola-pedidos-service-bus-dotnet
description: Diseña, escribe y prueba el reparto de pedidos entre sistemas con Azure Service Bus en .NET, con orden por pedido, protección contra duplicados y mensajes fallidos controlados. Úsala cuando varios sistemas de una empresa deban procesar los mismos pedidos y el proyecto ya use .NET.
---
# Cola de pedidos en orden con Service Bus y .NET
## Qué hace
Azure Service Bus es un buzón entre programas. Un sistema deja un mensaje (por ejemplo, un pedido) y otros lo recogen cuando pueden. Esta skill decide si lo necesitas, diseña el flujo, escribe el código en .NET y lo prueba sin tocar pedidos reales.
## Cómo instalarla (para ti, no para Claude)
Guarda este texto como `.claude/skills/cola-pedidos-service-bus-dotnet/SKILL.md` en tu proyecto. Necesitas una cuenta de Azure y el SDK de .NET instalado en el ordenador donde trabaje Claude Code.
## Primero, ¿lo necesitas de verdad?
Service Bus tiene coste y mantenimiento. Muchas veces basta con otra cosa. Pregunta cuántos pedidos al día hay y cuántos sistemas los tocan.
Si son pocos pedidos y dos sistemas, puede bastar una cola sencilla en n8n, una tabla en una base de datos o la propia API de la tienda. Si es el caso, dilo claro y para aquí.
## Qué preguntar antes de empezar
Pregunta todo de una vez. Si falta algo importante, no empieces.
1. ¿Qué sistemas intervienen, quién envía, quién recibe y en qué orden?
2. ¿Qué significa «en orden» aquí? ¿Todos los pedidos, o los de un mismo pedido o cliente (creado, pagado, enviado)? Casi siempre es lo segundo.
3. ¿Qué pasa si un pedido se procesa dos veces? Factura doble, doble envío.
4. ¿Cuál es el volumen y cuándo hay picos (Black Friday, rebajas)?
5. ¿Existe ya un espacio de nombres de Service Bus? ¿En qué región? Si hay datos personales, región de la UE.
6. ¿Quién va a vigilar los errores cuando esté en marcha?
7. ¿Cuál es el tope de gasto mensual en Azure? [TOPE EN EUROS]
## Paso a paso
1. Dibuja el flujo en una lista simple. Quién envía, qué mensaje, quién recibe y qué pasa si falla. Confírmalo con el usuario.
2. Elige la pieza. Una cola si solo recibe un sistema. Un tema con suscripciones si varios sistemas necesitan el mismo pedido (almacén, facturación, aviso al cliente).
3. Nivel del servicio. Los temas, las sesiones y la detección de duplicados necesitan el nivel Standard o superior; el nivel Basic solo tiene colas. Premium cuesta bastante más y se usa con volúmenes altos. Mira los precios actuales en la calculadora de Azure antes de proponerlo.
4. Orden. Activa las sesiones y usa el número de pedido (o de cliente) como identificador de sesión. Así los mensajes de un mismo pedido llegan en orden y a un solo receptor a la vez. Se decide al crear la cola y después puede no poder cambiarse: confírmalo en la documentación.
5. Duplicados. Activa la detección de duplicados al crear la cola o el tema y pon a cada mensaje un identificador único y estable, por ejemplo número de pedido más tipo de evento.
6. Dilo claro: Service Bus entrega «al menos una vez». Un mensaje puede llegar repetido si el receptor tarda más que el tiempo de bloqueo o se cae. Por eso el receptor también debe aguantar repeticiones. Antes de crear una factura, comprueba si ya existe para ese pedido.
7. Acceso. Usa la identidad de Microsoft Entra (identidad administrada o inicio de sesión de Azure) mejor que una cadena de conexión con clave. Si usas clave, va en una variable de entorno y nunca en el chat ni en el repositorio.
8. Código. Pide un proyecto .NET con el paquete oficial `Azure.Messaging.ServiceBus`. Comprueba la versión actual y las versiones de .NET que soporta. Debe llevar emisor, receptor con sesiones, completar el mensaje solo cuando el trabajo terminó bien y un registro en texto claro de lo que pasa.
9. Mensajes fallidos. Configura el número máximo de entregas y la cola de mensajes fallidos (dead-letter). Un mensaje que falla varias veces va allí: no se pierde ni bloquea a los demás. Decide quién la revisa y cada cuánto.
10. Mensajes pequeños. El mensaje lleva el identificador del pedido y lo mínimo. Los datos grandes o personales se consultan en el sistema de origen. Pon una caducidad razonable a los mensajes.
11. Pruebas con datos inventados. Un pedido. Diez eventos del mismo pedido en orden. El mismo pedido enviado dos veces. Un receptor que se cae a mitad. Un mensaje que falla siempre. Anota qué esperabas y qué pasó.
12. Vigilancia. Crea una alerta en Azure Monitor si crecen los mensajes parados o los fallidos, con aviso por email a una persona concreta. Comprueba que el aviso llega.
## Qué devolver
- El esquema del flujo en una lista simple.
- La decisión «sí» o «no necesitas Service Bus» con los motivos.
- Si es que sí: el proyecto .NET con comentarios en castellano, un archivo de ajustes de ejemplo sin claves y la lista de recursos que hay que crear en Azure.
- Una tabla de pruebas con caso, resultado esperado y resultado real.
- Una lista titulada «Antes de ir a producción, que lo revise una persona con experiencia en Azure» con la seguridad de acceso, los datos personales en los mensajes, los límites, los costes y quién responde a las alertas.
## Qué NO hacer
- No prometas «cero pedidos perdidos» ni «cero duplicados». Un buen diseño reduce el riesgo; no lo elimina.
- No uses el modo de recibir y borrar al instante con pedidos. Si el receptor se cae, el pedido se pierde.
- No toques pedidos, facturas ni cobros reales durante las pruebas.
- No pegues claves ni cadenas de conexión en el chat ni en el código.
- No metas datos personales completos en los mensajes si basta con un identificador.
- No propongas Premium sin mirar el precio.
- No lo pongas en producción solo con pruebas locales.
- No borres mensajes de la cola de fallidos sin que una persona los haya mirado.
