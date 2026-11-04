---
name: colas-azure-pedidos-dotnet
description: Evalúa si un negocio necesita Azure Service Bus y, si es así, diseña el mapa de mensajes y genera el código en C# (.NET) con reintentos, mensajes fallidos y pruebas. Actívala cuando pidas colas, mensajería entre sistemas, Service Bus o repartir pedidos entre aplicaciones.
---

# Pedidos entre sistemas con Azure Service Bus (.NET)

## Qué hace
Azure Service Bus es un servicio de mensajería. Un sistema deja un mensaje («pedido 123 pagado») y otros lo recogen cuando pueden.
Esta skill hace dos cosas en este orden. Primero te dice si lo necesitas. Después, si lo necesitas, diseña y genera el código en C#.
Trabaja en modo plan de Claude Code (Mayús+Tab cambia de modo) y no crees archivos hasta que el usuario apruebe el diseño.

## Glosario en cristiano (explícalo así al usuario)
- Cola: un buzón con un solo destinatario.
- Tema y suscripción: un tablón donde un sistema publica y varios se suscriben, cada uno con su propio buzón.
- Mensaje fallido (dead-letter): buzón aparte donde acaban los mensajes que no se pudieron procesar tras varios intentos, para que una persona los mire.
- Sesión: sirve para que los mensajes de un mismo pedido se procesen en orden.
- Idempotente: que procesar dos veces el mismo mensaje da el mismo resultado que procesarlo una.

## Lo más importante
La entrega no es «nunca se pierde ni se duplica». Por defecto es «al menos una vez»: Azure intenta no perder mensajes, pero puede entregar el mismo más de una vez.
Evitar cobros o envíos dobles es trabajo del código que procesa, no de Azure. Dilo al usuario con estas palabras.

## Qué preguntar antes de empezar
1. ¿Qué sistemas intervienen y quién mantiene cada uno?
2. ¿Qué pasa hoy cuando un pedido se pierde o se duplica? ¿Cuántas veces al mes y cuánto cuesta?
3. ¿Cuántos mensajes al día esperas, ahora y dentro de un año?
4. ¿Algún paso mueve dinero (cobro, devolución) o envía algo físico?
5. ¿Hay cuenta de Azure y quién la administra? ¿En qué región, dentro de la UE?
6. ¿Hay un desarrollador .NET que revisará el código? Para producción es un requisito.
7. ¿Cuál es el presupuesto mensual máximo? [EUROS]

## Paso a paso
1. Frena y responde primero a esto: ¿hace falta Service Bus? Compara con opciones más simples: una tabla en la base de datos con estado pendiente o hecho, las colas de Azure Storage, o n8n con reintentos. Recomienda la más simple que cubra el caso. Decir que no hace falta es una respuesta válida y entonces te paras.
2. Si hace falta, dibuja el mapa de mensajes en una tabla: nombre del mensaje, quién lo publica, quién lo consume, qué datos lleva y qué pasa si falla.
3. Los mensajes llevan identificadores (número de pedido), no datos personales completos.
4. Elige el nivel según la documentación actual de Azure, y confírmalo antes de decidir. En general, Basic solo tiene colas. Standard añade temas, detección de duplicados y sesiones. Premium da recursos dedicados.
5. El precio es [PRECIO: mira la tabla oficial de Azure Service Bus]. Explica el coste en términos simples y sin inventar cifras.
6. Para cada consumidor define cuántos intentos se hacen antes de mandar el mensaje a fallidos (revisa el valor por defecto), cuánto puede esperar un mensaje y cómo se evita procesarlo dos veces (guardar el identificador del pedido al terminar).
7. Genera el código con el paquete oficial Azure.Messaging.ServiceBus. No uses los paquetes antiguos. Lee antes la documentación actual.
8. Autenticación con Microsoft Entra ID mejor que con cadena de conexión. Si usas cadena de conexión, va en una variable de entorno y se trata como una contraseña.
9. Cada consumidor confirma el mensaje solo cuando terminó bien. Si falla por algo temporal, lo devuelve para reintentar. Si falla por algo permanente, lo manda a fallidos con el motivo escrito.
10. Pruebas en un entorno de pruebas, nunca en producción: mensaje normal, mensaje repetido, consumidor caído, mensaje mal formado y pico de mensajes. Anota el resultado de cada una.
11. Escribe el plan de cuando algo falla, para personas: dónde mirar, a quién avisar, cómo reprocesar los fallidos y qué hacer si hay muchos.
12. Propón una alerta cuando haya mensajes en fallidos o la cola crezca más de lo normal.

## Qué devolver
1. Respuesta a ¿hace falta?: sí, no o depende, con tres razones.
2. Mapa de mensajes (tabla).
3. Decisiones tomadas (nivel, intentos, caducidad, sesiones) con el motivo en lenguaje llano.
4. Código con LEEME, solo si hacía falta.
5. Resultado de las pruebas.
6. Plan de cuando algo falla.
7. Estimación de coste con los supuestos y los precios [por confirmar].

## Qué revisa una persona antes de producción
- Un desarrollador .NET: código, gestión de errores y manejo de credenciales.
- Quien lleve las cuentas, si algún paso cobra o devuelve dinero: que un mensaje repetido no cobra dos veces.
- Quien responda de la protección de datos: qué datos viajan en los mensajes y dónde se guardan.

## Qué NO hacer
- No afirmes «cero pedidos perdidos» ni «cero duplicados».
- No uses el modo que borra el mensaje al recibirlo en pasos importantes: si el consumidor falla a mitad, el mensaje se pierde.
- No metas datos personales completos en el mensaje.
- No pegues claves en el chat ni las subas al repositorio.
- No pruebes en producción.
- No pongas esto en marcha con dinero o clientes reales sin que lo revise un desarrollador.
- No subas a Premium por si acaso.
- No dejes recursos de prueba encendidos en Azure: siguen costando.
