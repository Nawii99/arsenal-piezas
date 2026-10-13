---
name: parte-diario-cuenta-highlevel
description: Lee una cuenta de HighLevel y prepara un parte diario de oportunidades paradas, conversaciones sin contestar y citas, o una revisión mensual de automatizaciones, etiquetas y usuarios. Úsala cuando pidan revisar HighLevel o GoHighLevel. Solo lee y propone, nunca envía ni activa nada.
---
# Parte diario y revisión de cuenta en HighLevel

## Para ti, que no programas
- Dónde guardarla: en la carpeta de tu proyecto crea la carpeta .claude/skills/parte-diario-cuenta-highlevel/ y guarda este texto dentro con el nombre SKILL.md.
- Cómo se usa: escribe «Hazme el parte diario de la cuenta [NOMBRE DE LA CUENTA]» o «Haz la revisión mensual».
- Conexión: un conector a HighLevel (servidor MCP o receta de n8n) con el acceso mínimo posible, o datos exportados. Si te piden la clave de toda la agencia, no la des. Crea un acceso limitado a esa subcuenta.

## Qué hace
Tiene dos modos. El parte diario mira qué oportunidades llevan días sin movimiento, qué conversaciones nadie ha contestado y qué citas hay. La revisión mensual mira los flujos automáticos, las etiquetas y los usuarios. En los dos casos lee y propone. No envía, no activa y no borra.

## Antes de empezar, pregunta (todo en un mensaje)
1. ¿Qué cuenta? Nombre exacto de la agencia o de la subcuenta. ¿Tienes permiso del titular para trabajar con ella?
2. ¿Qué modo: parte diario, revisión mensual o preparar una acción concreta?
3. ¿Qué embudos y etapas hay? ¿Cuántos días sin actividad se consideran «parado»? [DÍAS]
4. ¿Quién atiende cada tipo de contacto?
5. ¿Qué puedes hacer: solo leer, o también crear tareas y notas internas con confirmación? Por defecto, solo leer.
6. ¿Qué canal y qué horario están permitidos para contactar con clientes (correo, SMS, WhatsApp, llamada)?
7. Si es la subcuenta de un cliente, ¿hay un acuerdo escrito sobre qué se puede tocar?

## Modo 1. Parte diario
1. Identifica la cuenta y confirma que trabajas en la correcta. Una subcuenta es un cliente. No mezcles datos entre subcuentas.
2. Lee las oportunidades abiertas por etapa, las conversaciones sin responder, las tareas vencidas y las citas de hoy y mañana.
3. Clasifica cada elemento en HOY, ESTA SEMANA o VIGILAR.
4. Para cada oportunidad parada, di el motivo más probable según lo que se ve: sin respuesta nuestra, sin respuesta del contacto o sin próxima tarea. No inventes el motivo.
5. Propón el siguiente paso concreto y un borrador corto de mensaje.
6. Enseña el parte y espera.
7. Con el OK de cada elemento, y solo si hay permiso, crea tareas o notas internas. Los mensajes los envía una persona.

## Modo 2. Revisión mensual
1. Lista los flujos de trabajo (workflows) activos: qué los dispara, qué envían (correo, SMS, llamada, WhatsApp) y cuántos contactos han pasado por ellos el último mes, si el dato está.
2. Marca los que envían mensajes solos. Comprueba que respetan la baja, el consentimiento y el horario.
3. Busca etiquetas y campos duplicados o sin uso, embudos que nadie mira y usuarios con acceso que ya no deberían tenerlo.
4. Devuelve una lista de riesgos y mejoras por prioridad. No cambies nada.

## Qué devolver
- Parte diario: una tabla con Contacto | Etapa | Días parado | Motivo probable | Siguiente paso | Nº de borrador. Debajo, los borradores numerados.
- Revisión mensual: una tabla con Flujo | Qué lo dispara | Qué envía | Estado | Riesgo | Propuesta. Debajo, la lista de riesgos.
- Siempre al final, un apartado «Necesita decisión tuya» con las preguntas abiertas.

## Qué NO hacer
- No envíes SMS, correos ni WhatsApp y no lances llamadas. No añadas contactos a campañas ni a flujos.
- No actives, pauses ni edites flujos de trabajo. Un flujo mal activado puede escribir a miles de personas a la vez y gastar el saldo de la cuenta. Un mensaje enviado no se recupera.
- No cambies etapas, importes ni responsables sin OK.
- No borres contactos, oportunidades, etiquetas ni campos.
- No toques facturación, saldo, números de teléfono, usuarios, permisos ni claves.
- No copies datos de una subcuenta a otra.
- No sumes oportunidades abiertas como si fueran ventas. Oportunidad no es ingreso.
- No pegues claves de acceso en el chat.

## Qué revisa una persona antes de usar el resultado
- Quien lleva la cuenta lee el parte y envía los mensajes él mismo.
- El titular del negocio aprueba cualquier mensaje a muchos contactos a la vez.
- Enviar SMS, hacer llamadas y mandar correos suele gastar saldo de la cuenta. Mira la tarifa y los límites de tu plan. [TARIFA]
- Los mensajes y las llamadas comerciales tienen reglas en España: consentimiento, baja fácil y listas de exclusión. Consúltalo con quien lleve lo legal antes de automatizar nada.

Última revisión del texto: octubre de 2026. HighLevel cambia nombres de menús y planes con frecuencia. Si algo no coincide, dilo y no adivines.
