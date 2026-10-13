---
name: recontacto-clientes-finerworks
description: Revisa en solo lectura los clientes y pedidos de tu cuenta de Finerworks, detecta a quién toca escribir (sin respuesta, sin actividad, con incidencia) y deja borradores de mensaje para que los apruebes. Úsala para preparar el seguimiento semanal de clientes.
---
# Recontacto de clientes con Finerworks
Esta skill te dice a quién toca escribir esta semana y te deja el mensaje preparado. No envía nada y no cambia nada en tu cuenta sin que lo apruebes.

## Instalación (para la persona, no para Claude)
- Guarda este texto como SKILL.md dentro de la carpeta .claude/skills/recontacto-clientes-finerworks/ de tu proyecto, o dentro de ~/.claude/skills/recontacto-clientes-finerworks/ si la quieres en todos tus proyectos.
- Necesitas un conector MCP de Claude Code con tu cuenta de Finerworks. Se añade con el comando claude mcp add; pídele a Claude Code que te guíe. Conector que vas a usar: [COMANDO O URL DEL CONECTOR].
- Crea la clave de acceso con los permisos mínimos que permita el servicio (solo lectura si existe esa opción). No la pegues nunca en el chat.
- Mientras pruebas, usa el modo plan de Claude Code (se cambia con Mayús+Tab): solo propone y no ejecuta nada.
- Para usarla, escribe algo como: Prepara el seguimiento de clientes de Finerworks de los últimos [NÚMERO] días.

## Primero, comprueba qué tienes delante
La descripción habla de un CRM, pero Finerworks se conoce sobre todo como servicio de impresión de arte bajo demanda (impresión, lienzos, enmarcado). Eso cambia lo que se puede seguir, así que no des nada por hecho.
- Lista qué herramientas ofrece la conexión. No supongas que existen contactos, notas ni tareas.
- Si solo hay pedidos y datos de envío, el seguimiento será de pedidos y de clientes que ya han comprado. Dilo al principio.
- Si no puedes ver ni clientes ni pedidos, para aquí y explica qué falta. No inventes datos.

## Pregunta esto antes de empezar
1. ¿Qué periodo reviso? Por ejemplo, los últimos [NÚMERO] días.
2. ¿Qué significa «toca escribir»? Propón: cliente sin pedido desde hace [NÚMERO] días, pedido con problema o devuelto, pedido enviado sin confirmación de recepción, consulta sin responder.
3. ¿Cómo hablas con tus clientes? Tú o usted, cercano o formal, y cómo firmas.
4. ¿Puedo guardar notas en la cuenta o solo leer? Por defecto, solo leer.
5. ¿A quién no hay que escribir? Quien se ha dado de baja, quien ha reclamado, quien ha pedido no recibir mensajes.

## Paso a paso
1. Haz el inventario de la conexión en solo lectura. Cuenta en tres líneas qué puedes ver y qué no.
2. Trae los clientes y pedidos del periodo. Si son muchos, trabaja por tandas de [NÚMERO] y avisa del total.
3. Aplica los criterios acordados. Para cada cliente apunta el motivo concreto, con fecha (por ejemplo: pedido enviado el [FECHA], sin respuesta desde entonces).
4. Clasifica en cuatro grupos: Urgente (incidencia o reclamación), Esta semana, Puede esperar y No contactar.
5. Para Urgente y Esta semana, escribe un borrador corto: saludo, motivo, una sola petición clara y despedida. Sin presión, sin falsas urgencias y sin descuentos que no existan.
6. Si el usuario te ha dado permiso de escritura, enséñale la nota exacta que vas a guardar en cada ficha y espera su OK. Si no, deja las notas dentro del informe.

## Qué devolver
Un informe en Markdown con estas partes:
- Resumen: clientes revisados, cuántos hay en cada grupo y qué datos no has podido ver.
- Tabla con las columnas Cliente, Último pedido o contacto, Motivo, Grupo y Acción propuesta.
- Un borrador por cada cliente de Urgente y Esta semana, listo para copiar.
- Dudas: datos que faltan o se contradicen (mismo cliente con dos emails, pedidos sin cliente).
- Si el usuario lo pide, guárdalo en un archivo seguimiento-finerworks-FECHA.md dentro de la carpeta del proyecto.

## Qué NO hacer
- No envíes correos ni mensajes a nadie. Solo borradores.
- No crees, modifiques ni canceles pedidos. Si la cuenta es de impresión, un pedido puede fabricarse, enviarse y cobrarse, y eso cuesta dinero real.
- No borres ni fusiones clientes. No cambies direcciones ni datos de contacto.
- No contactes a quien se haya dado de baja o haya reclamado, salvo para resolver esa reclamación.
- No inventes datos. Si falta una fecha o un motivo, escribe [DATO QUE FALTA].
- No metas en notas ni en mensajes datos de salud, ideología, religión u otros datos sensibles.
- No copies listas de clientes a otras herramientas sin que el usuario lo pida.

## Qué revisa una persona antes de usar el resultado
- Cada mensaje, antes de enviarlo. Si es comercial (ofertas, novedades), la ley española (LSSI, art. 21) exige consentimiento previo o una relación contractual previa con productos similares, y una forma fácil de darse de baja. Si dudas, pregunta a tu gestor o a un abogado.
- Que los datos personales se usan para lo que el cliente espera (RGPD y LOPDGDD). La Agencia Española de Protección de Datos es quien sanciona.
- Que fechas, importes y estados de pedido del informe coinciden con tu cuenta. Claude puede equivocarse al leer o resumir.
