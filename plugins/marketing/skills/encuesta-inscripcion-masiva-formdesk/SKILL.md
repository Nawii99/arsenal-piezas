---
name: encuesta-inscripcion-masiva-formdesk
description: Diseña una encuesta o formulario de inscripción, ayuda a montarlo en Formdesk, planifica el envío en oleadas con recordatorios y resume las respuestas, cuidando la protección de datos. Úsala cuando tengas que recoger datos de muchas personas sin perseguirlas una a una.
---
# Encuesta o inscripción masiva con Formdesk
Esta skill te acompaña de principio a fin: qué preguntar, cómo montarlo en Formdesk, cuándo y cómo enviarlo, y qué hacer con las respuestas. Claude redacta y planifica. Los envíos los haces tú con tu herramienta de correo.

## Instalación (para la persona, no para Claude)
- Guarda este texto como SKILL.md dentro de .claude/skills/encuesta-inscripcion-masiva-formdesk/ de tu proyecto, o de ~/.claude/skills/encuesta-inscripcion-masiva-formdesk/ para todos tus proyectos.
- Necesitas una cuenta en Formdesk. Mira qué incluye tu plan (límite de respuestas, envío de emails, lógica condicional) en tu panel: [LÍMITES DE TU PLAN]. No lo des por supuesto.
- Si existe un conector MCP para Formdesk, Claude puede crear el formulario por ti: [COMANDO O URL DEL CONECTOR]. Si no existe, Claude te da una ficha de montaje y lo montas tú.

## Pregunta esto antes de empezar
1. ¿Qué decisión vas a tomar con las respuestas? Si no hay decisión, probablemente no hace falta la encuesta.
2. ¿Qué tipo es? Opinión, inscripción a un evento, recogida de datos de clientes, solicitud de presupuesto u otra.
3. ¿Quién responde y cuántas personas son más o menos? ¿Cómo las vas a contactar y tienes permiso para escribirles?
4. ¿Es anónima o con nombre? Dilo claramente en el formulario.
5. ¿Cuál es la fecha límite y cuándo necesitas los resultados?
6. ¿Responden menores, empleados o pacientes? Cambia las reglas (mira «Qué NO hacer»).
7. ¿En qué idioma y con qué tono?

## Paso a paso
1. Convierte el objetivo en entre 3 y 7 preguntas. Para cada una, pregunta: ¿qué haré con esta respuesta? Si no hay respuesta, se quita.
2. Redacta el formulario. Título claro; introducción con quién la hace, para qué, cuánto tarda, quién verá las respuestas y hasta cuándo; preguntas fáciles primero y datos personales al final; obligatorias solo las imprescindibles; sobre todo preguntas cerradas y una o dos abiertas; una idea por pregunta y sin sugerir la respuesta.
3. Entrega la ficha de montaje: número, texto, tipo de respuesta, opciones, obligatoria sí o no, y la lógica condicional (si responde X, mostrar Y). Si hay conector, lista sus herramientas y crea el formulario solo tras el OK del usuario. No inventes nombres de menús ni botones de Formdesk. Si no sabes dónde está algo, dilo.
4. Prueba el formulario con 2 o 3 personas, midiendo el tiempo. Corrige lo que no entiendan. Pruébalo también en el móvil.
5. Plan de envío en oleadas: oleada 0 con 3 a 5 personas de prueba; oleada 1 con el resto; recordatorio 1 a los [3 O 4] días solo a quien no ha respondido; recordatorio 2 final antes de cerrar. Nunca más de dos recordatorios. Pon fechas concretas.
6. Redacta la invitación y los recordatorios: cortos, con asunto claro, quién escribe, cuánto tarda, fecha límite, enlace y cómo no recibir más mensajes.
7. Mientras corre, pide al usuario el recuento de respuestas, calcula la tasa y sugiere si conviene recordar o ampliar plazo.
8. Al cerrar, prepara el resumen: respuestas recibidas sobre invitadas; resultados por pregunta; temas de las respuestas abiertas, con citas solo si no identifican a nadie; y los límites del análisis (pocas respuestas, respondieron los más motivados).

## Qué devolver
- Un resumen de una página con objetivo, público y decisión que se tomará.
- La ficha del formulario en una tabla.
- El calendario de envíos con fechas.
- Los textos de invitación y recordatorios.
- Al cierre, el informe de resultados. Si vas a analizar respuestas con Claude, quita antes nombres y emails.

## Qué NO hacer
- No envíes correos ni crees envíos masivos. No uses listas compradas ni de personas que no te conocen.
- No pidas datos que no vayas a usar. Tampoco datos sensibles (salud, ideología, religión, orientación sexual) sin consultarlo antes con un especialista.
- No prometas anonimato si el formulario guarda el email, la IP o un enlace personal por cada persona.
- Con menores, en España hace falta el consentimiento de padres o tutores por debajo de los 14 años. Mejor evitar encuestar a menores.
- No presiones («última oportunidad»), no mandes más de dos recordatorios y no recuerdes a quien ya respondió o pidió que no le escribas.
- No saques conclusiones fuertes con pocas respuestas. Cada porcentaje va con el número de personas que respondieron.
- No pegues respuestas con datos personales en herramientas sin base para ello. Anonimízalas antes.
- Si ofreces premio o sorteo, tiene sus propias reglas en España (promociones, impuestos). Consúltalo antes.

## Qué revisa una persona antes de usar el resultado
- El texto de información de protección de datos y la política de privacidad: quien lleve lo legal en tu negocio (RGPD y LOPDGDD).
- Que hay contrato de encargado de tratamiento con Formdesk y que sabes dónde guarda los datos.
- Si la encuesta es para trabajadores (clima laboral, evaluación), recursos humanos o un asesor laboral, y los representantes de los trabajadores si corresponde.
- Los números del informe, contrastados con las respuestas en bruto antes de presentarlos a un cliente.
