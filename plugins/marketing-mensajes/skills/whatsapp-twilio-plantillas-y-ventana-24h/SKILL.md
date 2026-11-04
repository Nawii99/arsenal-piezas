---
name: whatsapp-twilio-plantillas-y-ventana-24h
description: Prepara envíos de WhatsApp con Twilio cumpliendo la ventana de 24 horas, las plantillas aprobadas y el permiso de cada contacto, y los lanza por lotes solo con confirmación. Se activa cuando el usuario quiere avisar o escribir a varios clientes por WhatsApp usando Twilio.
---

# WhatsApp con Twilio: plantillas, ventana de 24 horas y envío por lotes

Esta skill ordena un envío de WhatsApp a varios clientes. Primero planifica y simula. Solo envía si el usuario escribe un «sí, envía» después de ver la simulación y de que una prueba pequeña haya salido bien.

## Las reglas que mandan (explícalas con palabras sencillas)

- Ventana de 24 horas: cuando un cliente escribe, hay 24 horas para contestarle con texto libre. Pasado ese tiempo, solo se puede empezar una conversación con una plantilla aprobada por WhatsApp.
- Plantilla: un mensaje con huecos ({{1}}, {{2}}) que Meta revisa antes de dejarlo usar. Tiene categoría: utilidad (aviso de un pedido o cita en curso), marketing (promociones) o autenticación (códigos). Si indicas una categoría y el contenido es de otra, Meta puede cambiarla.
- Coste: cada categoría se cobra distinto y Twilio puede añadir su propia tarifa [mira la tarifa vigente de Meta y de Twilio para España].
- Permiso previo (opt-in): el contacto tiene que haber aceptado recibir mensajes por WhatsApp. Lo exige WhatsApp y, si el mensaje es comercial, la ley (LSSI y RGPD).
- Calidad y límites: si muchas personas te bloquean o te marcan como spam, Meta baja el límite diario de contactos nuevos y puede restringir el número. Se pierde el canal [mira el límite actual en el administrador de Meta].
- Las bajas las gestiona quien envía. No des por hecho que la plataforma lo hace por ti [comprueba cómo lo trata tu configuración].

## Antes de empezar, pregunta

- ¿Qué se quiere comunicar y a quién? Aviso de pedido, recordatorio de cita, promoción u otra cosa.
- ¿Cómo y cuándo aceptó cada contacto recibir WhatsApp? ¿Dónde se guarda esa prueba?
- ¿Hay ya un número de WhatsApp conectado a Twilio y plantillas aprobadas? ¿Cuáles?
- ¿Cuántos contactos son y en qué formato están (Excel, CSV, CRM)?
- ¿En qué idiomas?
- ¿Quién paga el gasto, la cuenta del usuario o la de un cliente? ¿Hay un tope de gasto?

## Paso a paso

1. Clasifica el mensaje. Si avisa de algo que el cliente ya pidió, es utilidad. Si ofrece, recomienda o promociona, es marketing. Si dudas, trátalo como marketing. No disfraces una promoción de aviso.
2. Revisa los contactos. Teléfonos en formato internacional (+34 y nueve cifras en España; en Twilio van como whatsapp:+34...). Quita duplicados, quita los que no tienen permiso registrado y quita las bajas. Devuelve cuántos quedan, cuántos descartas y por qué.
3. Mira la ventana. Si el cliente escribió en las últimas 24 horas, vale texto libre. Si no, plantilla.
4. Redacta la plantilla. Debe entenderse sin contexto, llevar el nombre del negocio, no abusar de mayúsculas ni de signos y no prometer lo que no se puede cumplir. Si es marketing, añade cómo darse de baja. Pon un ejemplo para cada hueco, porque Meta lo pide al revisar.
5. Modelos para adaptar. Utilidad: «Hola {{1}}, tu pedido {{2}} ha salido hoy con {{3}}. Puedes seguirlo aquí: {{4}}. Si necesitas algo, responde a este mensaje. [NOMBRE DEL NEGOCIO]». Marketing: «Hola {{1}}, en [NOMBRE DEL NEGOCIO] tenemos {{2}} hasta el {{3}}. Si no quieres recibir más mensajes, responde BAJA».
6. Plan por lotes. Primero 3 a 5 mensajes a números del equipo, o al sandbox de Twilio, que es su entorno de pruebas (ahí cada persona debe unirse antes con un código). Después un lote pequeño y, si todo va bien, el resto. Entre lotes, mira fallos y bajas.
7. Fija un tope de gasto, un horario razonable (evita noches y domingos [decídelo con el cliente]) y quién atiende las respuestas.
8. Simulación sin enviar. Enseña tres mensajes ya rellenados, el total de contactos, la categoría y el coste estimado con esta fórmula: contactos × [TARIFA DE META] + contactos × [TARIFA DE TWILIO]. Pide confirmación.
9. Envío, solo con confirmación y solo si la cuenta de Twilio está conectada (por ejemplo, mediante un conector MCP o con n8n, que tiene nodo de Twilio). Si no hay conexión, entrega el archivo listo y las instrucciones para hacerlo a mano.
10. Después del envío, revisa estados y errores por contacto. Los más habituales: 63016 (fuera de ventana, hay que usar plantilla), 63015 (en el sandbox, el contacto no se ha unido), 63024 (destinatario no válido) y 63049 (Meta decidió no entregar un mensaje de marketing). Confírmalos en la documentación de errores de Twilio.
11. Apunta a quien se dé de baja y exclúyelo de los envíos futuros desde ese momento.

## Qué devolver

Un plan de envío con estas partes:

- Resumen: qué, a quién, cuándo y en qué categoría.
- Contactos válidos y descartados, con el motivo.
- Texto de la plantilla con sus huecos y un ejemplo para cada uno.
- Calendario por lotes y tope de gasto.
- Coste estimado con la fórmula y las tarifas entre corchetes.
- Lista de comprobaciones para la persona.
- Archivo CSV de salida con las columnas telefono, nombre, variable_1, variable_2 y estado.
- Tras el envío: informe con entregados, fallos con su código, bajas y respuestas pendientes.

## Qué NO hacer

- No envíes nada sin un «sí» claro después de la simulación y de la prueba.
- No escribas a contactos sin permiso registrado. Ni listas compradas, ni teléfonos sacados de webs o de redes. Riesgo: denuncia ante la Agencia Española de Protección de Datos, bloqueo del número y pérdida de los chats.
- No uses herramientas que imitan WhatsApp Web para envíos masivos. Pueden bloquear el número.
- No presentes una promoción como aviso de servicio.
- No insistas a quien no responde ni a quien se dio de baja.
- No metas datos sensibles (salud, deudas, DNI) en el texto. Se puede leer en la pantalla de bloqueo.
- No pidas ni aceptes claves o tokens de Twilio en el chat.
- No prometas cifras de respuesta ni de ventas.
- No conectes un asistente de IA de uso general a la API de WhatsApp. Desde enero de 2026 las condiciones de Meta lo limitan. Un bot de atención del propio negocio es otra cosa [confirma en las condiciones vigentes].

## Qué revisa una persona antes de enviar

- Que cada contacto tiene permiso y que se puede demostrar.
- El texto de la plantilla, antes de mandarla a aprobar.
- El coste total y el tope de gasto.
- Quién atiende las respuestas y en cuánto tiempo.
- Si el envío es comercial, la identificación del remitente y la baja, con una gestoría o un abogado.

## Dónde se guarda

Guarda este texto como SKILL.md en la carpeta .claude/skills/whatsapp-twilio-plantillas-y-ventana-24h/ de tu proyecto.
