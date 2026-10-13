---
name: whatsapp-api-oficial-avisos-y-citas
description: Te guía para conectar tu negocio a la API oficial de WhatsApp (Cloud API de Meta) y dejar listos avisos de pedido, envío y cita con plantillas, flujo en n8n, pruebas y paso a una persona. Úsala cuando quieras mensajes de servicio directamente con Meta.
---

# Avisos de pedido y cita por WhatsApp con la API oficial de Meta

Esta skill te lleva de la mano para que tu negocio mande por WhatsApp los mensajes de servicio que más se usan: confirmación de pedido, aviso de envío, recordatorio de cita y respuesta fuera de horario. Usa la API oficial de WhatsApp (Cloud API) de Meta, sin plataforma intermedia.

Claude Code prepara los textos, el mapa del flujo y la receta de n8n. Los pasos dentro de la cuenta de Meta los haces tú, con la documentación oficial delante: [ENLACE A LA DOCUMENTACIÓN DE WHATSAPP CLOUD API]. Cuando algo lo haces tú, pone «tú». Las órdenes sin sujeto son para Claude.

Revisada en octubre de 2026. Meta cambia tarifas y condiciones con frecuencia: comprueba lo vigente.

## Qué es y qué no es

- Es tu número conectado directamente a Meta. No es la app de WhatsApp Business del móvil. Usa un número dedicado, o confirma en la documentación de Meta cómo convive con la app.
- Los mensajes de plantilla se cobran según categoría y país. Algunos de utilidad, enviados dentro de la ventana de 24 horas, pueden ser gratis. Mira la tarifa vigente: [TARIFA VIGENTE DE META].
- Dentro de las 24 horas siguientes al último mensaje del cliente puedes contestar con texto libre. Fuera de ese plazo, solo con una plantilla aprobada.
- Esta skill es para mensajes de servicio. Las promociones tienen reglas más estrictas. Empieza solo por avisos.

## Antes de empezar, pregunta

No empieces sin respuesta a las preguntas 1 a 4.

1. ¿Qué mensajes quieres enviar? Solo de servicio (pedido, envío, cita) o también promociones.
2. ¿Dónde están los datos? Tienda online, agenda de citas, hoja de cálculo. ¿Cómo llegan a n8n?
3. ¿Tienes cuenta de Meta para empresas y está verificada? ¿Qué número vas a usar y está libre de WhatsApp personal?
4. ¿Cómo se pide el permiso al cliente? Lo normal es una casilla sin marcar, junto al teléfono, en el pedido o en la reserva.
5. ¿Quién contesta cuando el cliente responde y en qué horario?
6. ¿Qué datos viajan en los mensajes? Pedido, nombre, fecha de la cita. Nunca datos de salud ni de pago.
7. ¿Quién es el responsable de esos datos: tú o tu cliente?

## Paso a paso

### A. La cuenta de Meta (lo haces tú)

1. Cuenta de Meta para empresas y verificación del negocio. Piden documentos de la empresa y puede tardar días.
2. Una app en Meta for Developers con el producto WhatsApp. Meta te da un número de prueba y te deja probar con los destinatarios que tú des de alta.
3. Añade tu número real y el nombre que verá el cliente.
4. Crea un acceso permanente (un usuario del sistema con su token) en lugar del temporal, que caduca pronto. Comprueba cómo se hace en la documentación de Meta.
5. Guarda el token en las credenciales de n8n o en un gestor de contraseñas. Nunca en el chat ni en un documento compartido.

### B. Las plantillas

6. Claude redacta una plantilla por situación, con texto corto y variables. Ejemplos para adaptar:
   - Pedido (utilidad): Hola {{1}}, hemos recibido tu pedido {{2}} de [NOMBRE DEL NEGOCIO]. Te avisaremos cuando salga. Si necesitas algo, responde a este mensaje.
   - Envío (utilidad): Hola {{1}}, tu pedido {{2}} ya está en camino con [TRANSPORTISTA]. Seguimiento: {{3}}
   - Cita (utilidad): Hola {{1}}, te recordamos tu cita en [NOMBRE DEL NEGOCIO] el {{2}} a las {{3}}. Botones: Confirmar | Cambiar.
7. Tú las envías a aprobar desde el panel de Meta y esperas. Si rechazan una, lee el motivo, reescríbela y vuelve a enviarla. No reenvíes el mismo texto.
8. Un aviso no debe llevar publicidad dentro. Si la lleva, Meta puede tratarlo como marketing.

### C. El flujo en n8n

Claude lo describe nodo por nodo y tú lo montas. n8n tiene nodos de WhatsApp Business Cloud para enviar y para recibir: [COMPRUEBA EL NOMBRE EXACTO EN TU VERSIÓN].

Flujo 1, aviso saliente:

9. Disparador: nuevo pedido, nueva cita o cambio de estado.
10. Filtro: el cliente marcó que acepta WhatsApp. Si no, el flujo termina aquí.
11. Ajuste del teléfono: formato internacional, por ejemplo +34 y el número sin espacios.
12. Nodo de WhatsApp: enviar la plantilla que toque, con sus variables.
13. Registro: se apunta en una hoja la fecha, el pedido y si se envió o falló.

Flujo 2, mensaje entrante:

14. Disparador de WhatsApp para recibir mensajes. Necesita que tu n8n sea accesible desde internet con HTTPS.
15. Si el texto es BAJA, se marca al cliente como «sin WhatsApp» y se confirma la baja.
16. Si es una pregunta frecuente, se responde con un texto fijo que hayas revisado.
17. En cualquier otro caso, se avisa a una persona (email o Telegram) con el mensaje y el teléfono.
18. Fuera de horario, se responde con «te contestamos el [DÍA Y HORA]».

### D. Pruebas, sin liarla

19. Con el número de prueba de Meta, manda cada plantilla a tu propio móvil.
20. Prueba estos casos: todo bien, teléfono mal escrito, cliente sin permiso, cliente que responde BAJA, mensaje fuera de horario y plantilla con una variable vacía.
21. Comprueba qué pasa cuando falla un envío: ¿queda registrado? ¿Se entera alguien?
22. Pasa a producción con los [NÚMERO DE PEDIDOS DE PRUEBA] primeros pedidos reales y vigílalos 48 horas.
23. Cada semana revisa los mensajes fallidos y la tarifa vigente.

## Qué devolver

1. Mapa de mensajes: situación | disparador | plantilla | categoría | permiso necesario.
2. Textos de las plantillas, listos para pegar en el panel de Meta.
3. Receta de n8n nodo por nodo, de los dos flujos.
4. Lista de pruebas con el resultado esperado de cada una.
5. Lista de comprobación de cuenta y de legalidad, con casillas.
6. Tabla de fallos frecuentes y qué hacer: plantilla rechazada, mensaje no entregado, token caducado, teléfono no válido.

## Qué NO hacer

- No pegues el token ni capturas donde se vea en el chat.
- No pruebes con clientes reales. Usa tu móvil y el de tu equipo, con su permiso.
- No uses un número personal.
- No metas publicidad en un aviso de pedido o de cita.
- No guardes en el flujo datos que no hagan falta: nada de DNI, datos de salud ni de pago.
- No dejes que una IA invente respuestas sobre pedidos, plazos o devoluciones. Si el flujo usa IA, que conteste solo con datos que le des, que avise de que es un asistente automático y que tenga salida a una persona. Meta limita los asistentes de IA de uso general en esta API: revisa las condiciones vigentes antes de montarlo.
- No des por hecho que tener el teléfono de alguien en un pedido es permiso para escribirle con publicidad.
- No sigas escribiendo a quien ha dicho BAJA.

## Qué revisa una persona antes de activarlo

- Tú, o quien responda del negocio: los textos de las plantillas y el coste mensual esperado.
- Tu política de privacidad: debe decir que los datos pasan por Meta. Pregunta a tu gestor por las transferencias de datos fuera de la UE.
- Si lo haces para un cliente, contrato de encargado del tratamiento (art. 28 del RGPD) y cuentas de Meta y de n8n a nombre del cliente.
- Las pruebas de la parte D, con el resultado anotado.
