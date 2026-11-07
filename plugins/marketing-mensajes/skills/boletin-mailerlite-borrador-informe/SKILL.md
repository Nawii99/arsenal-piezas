---
name: boletin-mailerlite-borrador-informe
description: "Prepara el borrador de un boletín para MailerLite, lo revisa con una lista de comprobación antes del envío y analiza los resultados después. Nunca envía: el envío lo haces tú. Se activa cuando pides escribir, segmentar o analizar una campaña de MailerLite."
---
# Boletín en MailerLite, de borrador a informe
MailerLite es una herramienta de email marketing con suscriptores, grupos, segmentos, campañas y automatizaciones. Esta skill te ayuda a preparar un envío y a leer sus resultados. La IA nunca envía. Solo prepara, y tú pulsas Enviar en MailerLite.
Para instalarla, guarda este archivo como .claude/skills/boletin-mailerlite-borrador-informe/SKILL.md dentro de tu proyecto.
## Cómo se conecta
- Sin conexión. La IA (Claude, Codex, Gemini o una IA local) escribe el texto y tú lo pegas en MailerLite. Para el análisis, exportas los informes en CSV. Es lo más seguro.
- Con la clave de la API o un conector MCP. La clave va en la configuración, nunca en el chat. Sirve para crear borradores y leer informes. El permiso de enviar campañas va desactivado y no se activa. Si no puedes comprobar qué permisos tiene la conexión, trabaja sin conexión.
- Plan gratuito. MailerLite tiene uno con límites de suscriptores y de envíos que cambian con el tiempo. Mira los actuales en su web antes de importar una lista [LÍMITE ACTUAL].
## Qué preguntar antes de empezar
- ¿La lista es tuya o de un cliente? Si es de un cliente, antes de tocar nada firmáis un contrato de encargado de tratamiento (RGPD) y pides acceso solo a lo necesario, por escrito.
- ¿Cuál es el objetivo del envío, en una frase, y qué UNA acción quieres que haga quien lo lea?
- ¿A quién va? Grupo o segmento, y cuántos suscriptores son.
- ¿Cómo se apuntó esa gente? Formulario con casilla, doble confirmación, compra, importación. Si no lo sabes, no sigas hasta aclararlo.
- ¿Qué ofreces y con qué condiciones reales? Precio (con IVA incluido si vendes a consumidores en España), fechas y plazas.
- ¿Qué tono, qué idioma, qué enlaces y qué fecha de envío?
- ¿Cómo fueron los últimos envíos, si los tienes?
## Paso a paso antes del envío
1. Mira el estado de la lista: suscriptores activos, bajas y rebotes recientes, y cuándo fue el último envío.
2. Propón 3 asuntos distintos, cortos, sin MAYÚSCULAS ni signos de más y sin engañar sobre el contenido. Propón también el texto de vista previa (preheader).
3. Escribe el cuerpo con un saludo, la idea en tres frases, un solo botón o enlace principal y una despedida. Que se lea bien en el móvil.
4. Pasa la lista de comprobación. Remitente reconocible, datos de quien envía, enlace de baja, enlaces que funcionan, precios y fechas correctos, nada que no puedas cumplir y ninguna urgencia falsa.
5. Prepara el borrador o el texto para pegar. Pídele a la persona que se envíe una prueba a sí misma y que la mire en el móvil y en el ordenador.
6. La IA no envía ni programa nada. Enséñale a la persona una última ficha con lista o segmento, número de destinatarios, fecha y hora, y asunto. Pulsar Enviar o Programar lo hace ella en MailerLite.
## Paso a paso después del envío
1. Espera al menos 48 horas.
2. Lee el informe. Entregados, clics, bajas, rebotes y quejas por spam.
3. Desconfía de las aperturas. Desde 2021 la protección de privacidad de Apple Mail puede marcar como abiertos correos que nadie ha leído. Juzga sobre todo por los clics y por lo que pasa después (ventas, respuestas).
4. Compara con tus envíos anteriores, no con cifras de internet.
5. Propón como máximo 3 cambios para el siguiente envío. Si probaste dos asuntos con una lista pequeña, di que la muestra es demasiado pequeña para sacar conclusiones.
6. Limpieza. Lista a quienes llevan [TU CRITERIO] meses sin hacer clic, sin comprar y sin responder. La apertura sola no sirve para retirar a nadie, porque la protección de privacidad de Apple Mail la falsea. Propón un email de reactivación y, si no responden, retirarlos. La retirada la haces tú.
## Qué devolver
- Ficha del envío con objetivo, público, asunto elegido, preheader y fecha propuesta.
- Texto del email listo para pegar.
- Lista de comprobación con el estado de cada punto (hecho, pendiente o dudoso).
- Tras el envío, informe en tabla con métrica, valor y comparación con el envío anterior, más tres acciones.
## Qué NO hacer
- No envíes ni programes ningún envío. Eso lo hace la persona en MailerLite, después de ver la ficha final.
- No pidas ni uses permiso de envío en la clave de la API o en el conector.
- No importes listas compradas ni contactos que no hayan aceptado recibir tu boletín. A clientes que ya compraron solo si encaja en la excepción de la LSSI, y eso se consulta antes.
- No vuelvas a añadir a quien se dio de baja ni a direcciones que rebotaron.
- No borres suscriptores ni grupos.
- No inventes testimonios, cifras, escasez ni urgencia («últimas plazas») que no sean ciertos. Es publicidad engañosa y puede acabar en sanción.
- No uses las aperturas como prueba de nada, ni para decidir a quién retirar de la lista.
- No metas datos personales de suscriptores en otras herramientas ni exportes la lista de un cliente fuera de MailerLite.
- No prometas que el boletín va a dar ventas.
## Qué revisa una persona
- El email completo, con los enlaces, los precios y las fechas, antes de enviarlo. Y quien pulsa Enviar es ella, no la IA.
- De dónde sale el permiso de la lista, si hay cualquier duda.
- Si la lista es de un cliente, el contrato de encargado de tratamiento (RGPD) y que el acceso sea solo el necesario. Lo revisa quien responda de los datos personales.
- Si el boletín habla de salud, dinero, inversión u otros temas delicados, una persona con conocimiento del tema, antes de enviarlo.
