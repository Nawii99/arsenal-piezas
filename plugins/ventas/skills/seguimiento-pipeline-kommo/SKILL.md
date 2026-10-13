---
name: seguimiento-pipeline-kommo
description: Revisa el embudo de Kommo, encuentra tratos parados o sin siguiente paso y prepara tareas y mensajes de seguimiento para que los apruebes tú. Se activa cuando pides revisar leads, tratos olvidados o el seguimiento de ventas en Kommo.
---
# Seguimiento de pipeline en Kommo
Kommo (antes amoCRM) es un CRM (el programa donde guardas clientes y tratos) con embudos de tratos, contactos, tareas y chats como WhatsApp. Esta skill mira tu embudo, te dice qué tratos se están enfriando y te deja preparado el siguiente paso. Lo que se envía o se cambia lo decides tú.
Para instalarla, guarda este archivo como .claude/skills/seguimiento-pipeline-kommo/SKILL.md dentro de tu proyecto.
## Cómo se conecta
La IA (Claude, Codex, Gemini o una IA local) no entra sola en Kommo. Necesita una de estas vías, de menos a más riesgo.
- Un archivo exportado de Kommo (CSV o Excel) con tus tratos, si el panel te deja exportarlos. Empieza por esta vía. Tiene poco riesgo porque la IA solo lee y no puede cambiar nada.
- Un flujo de n8n tuyo que lea Kommo y le pase los datos a la IA (n8n es una herramienta para conectar aplicaciones sin programar).
- Un conector MCP de Kommo de un proveedor de confianza (un enlace que deja a la IA usar tu Kommo). Mira qué permisos pide y, si puedes, dale solo permiso de lectura.
Las claves y los códigos de acceso van en la configuración del conector o de n8n. Nunca los pegues en el chat ni en este archivo.
## Si lo usas para el negocio de otra persona
- Si ves los contactos de otro negocio, eres encargado de tratamiento de sus datos personales.
- Firma con el cliente un contrato de encargado de tratamiento (RGPD) antes de acceder a sus contactos.
- Deja por escrito qué acceso te da y no copies sus datos fuera de esta sesión.
## Qué preguntar antes de empezar
- ¿Qué embudo (pipeline) revisamos y quién es el responsable de esos tratos?
- ¿Cuántos días sin actividad hacen que un trato esté parado? Si no lo sabes, propón [7] días y pide que lo confirme.
- ¿Qué etapas cuentan como abiertas? Las de ganado o perdido se ignoran.
- ¿Con qué tono escribes (cercano o formal), en qué idioma y por qué canal (email, WhatsApp, teléfono)?
- ¿Tienes automatizaciones puestas en las etapas, por ejemplo un Salesbot (un robot de Kommo) que escribe al cliente cuando se mueve el trato? Si no lo sabes, no muevas ningún trato.
- ¿De dónde vienen esos contactos? ¿Pidieron información o dieron permiso para que les escribas?
## Paso a paso
1. Lee los tratos abiertos del embudo. Para cada uno anota etapa, responsable, importe, fecha de la última actividad y si tiene una tarea pendiente.
2. Marca los problemas: sin actividad desde hace más días de los acordados, sin tarea futura, sin responsable, sin importe, contacto repetido (mismo teléfono o mismo email) o etapa que no cuadra con las notas. Marca también el contacto con etiqueta o nota de baja o de no contactar: excluye ese trato de los borradores.
3. Ordena por dinero en riesgo y por días parado. Empieza por lo que más importe tiene.
4. Para cada trato parado propón UNA sola acción: llamar, escribir, pedir una decisión o cerrarlo como perdido. Justifícala con lo que consta en las notas.
5. Redacta borradores de mensaje cortos, con una idea y una pregunta clara. Usa solo datos que estén en el CRM. Si falta un dato, deja [COMPLETAR].
6. Si el canal es WhatsApp, avisa en el borrador de que, pasado un tiempo desde el último mensaje del cliente (hoy 24 horas), solo se puede escribir con una plantilla aprobada por Meta. Las reglas y los costes de WhatsApp Business cambian [COMPRUEBA EN KOMMO O EN LA AYUDA DE WHATSAPP BUSINESS LA REGLA Y EL COSTE VIGENTES].
7. Presenta todo y espera. Pregunta «¿Qué tratos apruebo?».
8. Solo sobre lo aprobado, y solo si la conexión tiene permiso de escritura, crea tareas o notas una a una. Después vuelve a leer cada trato para comprobar que quedó bien.
## Qué devolver
- Resumen con tratos revisados, tratos parados, dinero total en riesgo (en la moneda de tu cuenta) y fecha del análisis.
- Tabla de tratos parados con las columnas trato, etapa, responsable, importe, días sin actividad, problema y acción propuesta.
- Un borrador de mensaje por trato, marcado como «NO ENVIADO».
- Lista de cambios hechos en Kommo (trato, qué se creó y cómo deshacerlo a mano) o la frase «ningún cambio».
- Dudas, con los datos que faltaban y los supuestos que has hecho.
## Qué NO hacer
- No envíes mensajes a clientes. Los textos son borradores y los envías tú desde Kommo.
- No borres tratos, contactos ni notas, y no los fusiones. Si hay duplicados, lístalos y que decida una persona.
- No muevas un trato de etapa ni lo marques como ganado o perdido sin permiso. Mover de etapa puede lanzar automatizaciones que escriban al cliente.
- No modifiques más de [20] registros por tanda.
- No inventes nada del cliente: ni conversaciones, ni promesas, ni importes.
- No escribas a quien pidió que no le contactes ni a quien no te haya dado permiso. La LSSI exige permiso previo en muchos casos y el RGPD protege esos datos.
- No saques datos personales de esta conversación ni los pegues en otras herramientas.
- No prometas que con esto cierras más ventas. Compara tus cifras de antes y después.
- No des consejos fiscales. Si cobras por este servicio, pregunta a tu gestor si tienes que repercutir IVA y a qué tipo en tu caso.
## Qué revisa una persona
- Cada mensaje, antes de enviarlo.
- Cada cambio de importe, de etapa o de responsable.
- La regla y el coste vigentes de WhatsApp Business, antes de escribir por ese canal.
- Si el CRM es de un cliente, el contrato de encargado de tratamiento, antes de acceder a sus contactos.
- Si dudas de que puedas escribir a una lista, consúltalo con tu gestor o con un abogado antes de contactar.
