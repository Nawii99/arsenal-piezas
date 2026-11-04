---
name: avisos-por-sms-con-azure
description: Monta el envío de SMS con Azure Communication Services para avisos de pedido, recordatorios de cita y códigos de verificación, con modo de prueba, tope de gasto y consentimiento según la normativa española. Úsala cuando el usuario quiera enviar SMS desde su negocio o su web.
---
# Avisos por SMS con Azure
## Qué hace
Esta skill guía el montaje del envío de SMS con Azure Communication Services y escribe el pequeño programa que los manda. El usuario no toca código. Sí decide qué mensajes salen, a quién y con qué tope de gasto.
## Cómo instalarla (para ti, no para Claude)
Guarda este texto como `.claude/skills/avisos-por-sms-con-azure/SKILL.md` en tu proyecto. Necesitas una cuenta de Azure de pago por uso. Comprueba si una cuenta de prueba te permite conseguir remitente de SMS, porque a veces no.
## Primero, clasifica cada mensaje
- Aviso de servicio: pedido enviado, cita de mañana, cambio de horario. Va a quien ha comprado o contratado. Sin publicidad dentro.
- Código de verificación: solo al número que la persona acaba de escribir.
- Promocional: ofertas y descuentos. Necesita consentimiento previo y demostrable. Si el usuario no puede demostrarlo, no sigas con este tipo.
- Si un aviso de servicio lleva una oferta, pasa a ser promocional.
## Qué preguntar antes de empezar
Pregunta todo de una vez. Si falta algo importante, no empieces.
1. ¿Qué mensajes quieres enviar? Dame 2 o 3 ejemplos reales.
2. ¿A quién? ¿Cómo y cuándo te dieron su móvil? ¿Qué se les dijo en ese momento?
3. ¿A qué países? ¿Cuántos mensajes al mes, más o menos?
4. ¿Qué dispara el envío? Una tienda online, un formulario, n8n, una hoja de cálculo o hacerlo a mano.
5. ¿Qué lenguaje usa tu proyecto? Si no hay ninguno, propón Python o JavaScript por sencillez, y Java solo si el cliente ya lo usa.
6. ¿Cuánto es lo máximo que quieres gastar al mes? [TOPE EN EUROS]
7. ¿Existe ya un recurso de Communication Services en Azure? ¿A nombre de quién está la cuenta?
## Paso a paso
1. Clasifica cada mensaje con los tipos de arriba y di qué base legal se prevé. Si es promocional y no hay permiso demostrable, para aquí y explica por qué.
2. Crea el recurso en Azure. Explica los clics en lenguaje llano. Las pantallas del portal cambian: si algo no coincide, pide al usuario que describa lo que ve. Si aparece la opción, elige ubicación de datos en Europa.
3. Remitente. Mira qué tipos de remitente permite Azure para enviar a España (número, nombre de marca u otros). No des por hecho que se pueda conseguir uno español. Algunos exigen trámite y plazo. Lo que falte, apúntalo como [PENDIENTE].
4. Coste. Anota el precio por mensaje del país de destino en la página de precios de Azure: [PRECIO POR SMS]. Crea un presupuesto con aviso por email en Cost Management.
5. Claves. La cadena de conexión va en una variable de entorno o en un archivo de ajustes que NO se sube a ningún repositorio ni se pega en el chat. Si se filtra, se regenera en el portal.
6. Textos. Escribe cada plantilla en español, corta y con el nombre del negocio al principio. Cuenta los caracteres. Con tildes como á, í, ó, ú el SMS puede pasar a una codificación de 70 caracteres por tramo en lugar de 160 y costar más. El símbolo € y los emojis también influyen. Prueba el texto real y cuenta los tramos.
7. Programa. Pide a Claude Code que use el paquete oficial de Azure para SMS del lenguaje elegido: `azure-communication-sms` en Python, `@azure/communication-sms` en JavaScript o `com.azure:azure-communication-sms` en Java. Comprueba la versión actual.
8. El programa debe llevar un modo simulado que no envía, validación del número en formato internacional (+34 y nueve cifras), límite de envíos por hora y por día, consulta de la lista de bajas antes de cada envío y un registro de resultados sin datos sensibles.
9. Promocionales, solo con permiso demostrable. El mensaje se identifica como publicidad (la LSSI pide empezar con la palabra «publicidad» o «publi»; que lo confirme un asesor), dice quién envía y ofrece una baja sencilla y gratuita. Un enlace corto a una página de baja suele ser más seguro que pedir que respondan al SMS.
10. Códigos de verificación. Pon límite de intentos por número, caducidad corta del código y límite de códigos por número y por hora. Sin esos límites, alguien puede disparar miles de SMS a tu cargo (fraude por tráfico artificial de SMS). Que lo revise alguien con experiencia en seguridad antes de ponerlo en una web real.
11. Pruebas, siempre en este orden. Modo simulado. Un SMS a tu propio móvil. De 3 a 5 SMS a personas que saben que van a recibirlo. Revisar entrega, tramos usados y coste real. Solo entonces, el envío normal.
12. Operación. Tope diario, alerta de presupuesto en Azure y revisión semanal de errores y bajas.
## Qué devolver
- Una ficha por tipo de mensaje con el texto, a quién va, la base legal prevista, los caracteres y los tramos.
- La lista de pasos de Azure hechos y pendientes.
- El programa con comentarios en castellano y un archivo de ajustes de ejemplo sin claves reales.
- Un plan de pruebas con una casilla de resultado en cada paso.
- Una lista titulada «Antes de enviar, que lo revise una persona» con el consentimiento y su registro, los textos promocionales, los límites del código de verificación y el tope de gasto.
## Qué NO hacer
- No envíes ni un solo SMS real sin que el usuario lo confirme en esta conversación, con el número de mensajes y el coste estimado a la vista.
- No pegues, imprimas ni guardes claves o cadenas de conexión en el chat, en el código o en el repositorio.
- No envíes publicidad a quien no haya dado permiso, ni a listas compradas o sacadas de internet.
- No metas ofertas dentro de un aviso de servicio.
- No pongas datos sensibles en el SMS (salud, deudas, DNI, importes). Se leen en la pantalla bloqueada. En una clínica, no indiques la especialidad ni el motivo de la cita.
- No montes códigos de verificación sin límites de intentos y de envíos.
- No envíes de noche ni en festivos. Fija el horario: [HORARIO PERMITIDO].
- No sigas adelante si no hay tope de gasto.
- No prometas tasas de lectura ni de conversión.
