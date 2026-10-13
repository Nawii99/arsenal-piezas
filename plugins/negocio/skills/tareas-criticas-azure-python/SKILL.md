---
name: tareas-criticas-azure-python
description: Monta en Python un trabajador que procesa tareas críticas como cobros o envíos desde una cola de Azure Service Bus, con reintentos limitados, buzón de fallidos, registro y alertas al móvil. Actívala cuando una tarea en segundo plano no pueda fallar en silencio.
---

# Tareas críticas con colas de Azure (Python)

## Qué hace
Ayuda a que una tarea importante (cobrar, enviar, emitir una factura) se haga una vez, o falle avisando a una persona.
Claude escribe el trabajador en Python. Tú decides qué tareas se tocan y quién mira las alertas.
Una cola de Azure Service Bus es un buzón donde se dejan las tareas pendientes. El trabajador las coge una a una.
Empieza en modo plan de Claude Code (Mayús+Tab cambia de modo).

## Lo más importante
Azure entrega cada mensaje «al menos una vez». Puede llegar repetido. Si la tarea es cobrar, el código debe saber que ya cobró.
Eso se llama idempotencia. Sin ella, esta skill no sirve para tareas que mueven dinero.

## Qué preguntar antes de empezar
1. ¿Qué tarea es exactamente? ¿Se puede deshacer?
2. ¿Qué pasa si se hace dos veces? ¿Y si no se hace nunca?
3. ¿Cuántas tareas al día y cuántas a la vez en el peor momento?
4. ¿Dónde va a ejecutarse el trabajador? Azure Functions, un contenedor o un servidor propio. Compara opciones: Functions ya gestiona parte del confirmar y reintentar, revisa la documentación actual.
5. Si hay cobros, ¿qué pasarela de pago usas y tienes entorno de pruebas con dinero de mentira?
6. ¿Quién mirará las alertas y en cuánto tiempo debe responder? [HORAS]
7. ¿Hay un desarrollador Python que revisará el código?

## Paso a paso
1. Rellena una ficha por tarea: qué hace, si es reversible, qué pasa si se duplica, qué pasa si se pierde y quién se entera.
2. Define para cada tarea una clave única que la identifique, por ejemplo número de pedido más tipo de acción. Muchas pasarelas de pago, como Stripe, admiten una clave así para no cobrar dos veces. Úsala.
3. Comprueba si de verdad hace falta una cola. Si basta con una tabla de pendientes en una base de datos o un flujo de n8n con reintentos, dilo y para.
4. Genera el trabajador con el SDK oficial azure-servicebus y azure-identity. Lee antes su documentación actual. Autenticación con Microsoft Entra ID cuando sea posible. Si hay cadena de conexión, en variable de entorno.
5. Lógica del trabajador: coge el mensaje, mira en el registro si esa clave ya está hecha, hace la acción, anota el resultado y solo entonces confirma el mensaje.
6. Errores temporales (la pasarela no responde): reintento con esperas cada vez más largas y un máximo de intentos. Errores permanentes (datos mal): al buzón de fallidos con el motivo escrito.
7. Registro de auditoría: clave de la tarea, hora, resultado e intentos. Sin datos personales de más.
8. Pruebas con dinero de mentira: mensaje repetido, caída a mitad de la acción, error permanente y pasarela caída. Anota qué pasó en cada una.
9. Alertas: aviso cuando haya mensajes en fallidos o la cola crezca. Debe llegar a tu móvil (correo, Telegram u otra vía). Haz un simulacro de 5 fallos y confirma que los avisos llegan.
10. Pide a un subagente revisor que lea el código buscando errores silenciados, reintentos sin límite y claves escritas dentro.

## Qué devolver
- Tabla de tareas con su ficha de riesgo.
- Código con LEEME en español sencillo.
- Resultado de las pruebas, una por una.
- Plan de cuando algo falla, para personas: dónde mirar, quién actúa, cómo reprocesar un fallido uno a uno y con qué OK.
- Hoja de costes con supuestos y precios [por confirmar en la tabla oficial de Azure].

## Qué revisa una persona antes de producción
- Un desarrollador Python: código, errores y manejo de credenciales.
- Quien lleve la contabilidad, si hay cobros o devoluciones: que un mensaje repetido no cobra dos veces y que los importes cuadran.
- Quien responda de seguridad y protección de datos: qué datos se guardan en el registro y quién accede.

## Qué NO hacer
- No ejecutes cobros reales en las pruebas.
- No hagas reintentos sin límite.
- No silencies errores con un «ignorar» para que no moleste. Un error callado es el que luego cuesta dinero.
- No reprocesar fallidos en bloque sin mirarlos uno a uno.
- No guardes ni manejes datos de tarjeta. Los gestiona la pasarela de pago.
- No pegues claves en el chat ni las subas al repositorio.
- No toques producción sin copia de seguridad ni OK expreso del usuario.
- No prometas que nada falla. Promete, como mucho, que se enterará alguien.
