---
name: gorgias-clasificar-tickets-y-borradores
description: Ordena los tickets de soporte de Gorgias por tipo y urgencia y prepara borradores de respuesta basados en la política de la tienda. Úsala cuando la bandeja de una tienda online se llena de mensajes repetidos. No envía respuestas ni concede reembolsos.
---

# Bandeja de soporte de tienda online en Gorgias

Lee los tickets abiertos, los clasifica y deja un borrador de respuesta para cada uno que se pueda contestar con datos reales. Lo difícil o delicado lo pasa a una persona.

## Lo que haces tú, una sola vez
- Guarda este texto en `.claude/skills/gorgias-clasificar-tickets-y-borradores/SKILL.md`.
- Conecta Gorgias con un conector MCP y mira con `/mcp` que aparece activo. Si la herramienta deja crear una clave con permisos limitados, empieza solo con lectura.
- Prepara por escrito la política de la tienda: envíos, plazos, devoluciones, cambios, garantía y tono. Sin ese texto, la skill clasifica pero no redacta respuestas.
- Comprueba que esa política respeta lo que la ley da al consumidor en España, como el derecho de desistimiento en compras online y la garantía legal. Pregunta a tu asesor qué plazos te aplican [TU ASESOR].
- Los mensajes de los clientes llevan datos personales y pasan por Claude. La política de privacidad de la tienda debe contarlo.

## Qué preguntar antes de empezar
1. ¿De qué tienda se trata y qué vende?
2. ¿Dónde está la política de la tienda? Que la pegue aquí o indique el archivo.
3. ¿Qué tono usa la marca (cercano, formal, tuteo o usted)?
4. ¿Cuántos tickets revisar en esta tanda? Si no hay preferencia, empieza por 20.
5. ¿Puedes etiquetar tickets en Gorgias o solo leerlos?
6. ¿Qué casos van siempre a una persona? Añádelos a la lista del final.
7. ¿Quién aprueba y envía las respuestas?

## Paso a paso
1. Comprueba la conexión. Si no hay herramientas de Gorgias, para y dilo. No inventes tickets.
2. Trae los tickets abiertos, los más antiguos primero, hasta el tope acordado. Si la lista es larga, usa un subagente para que trabaje aparte y no llene la conversación.
3. Para cada ticket anota: tipo (estado del pedido, devolución, cambio, producto dañado, factura, duda de producto, reclamación u otro), urgencia (alta, media o baja), idioma y si el cliente parece enfadado.
4. Separa los que van directos a una persona (mira «Cuándo parar»). Para esos no redactes respuesta. Resume el caso en dos líneas.
5. Para el resto, redacta un borrador usando solo lo que consta en el ticket, en el pedido y en la política. Si falta un dato, como el número de seguimiento, escribe [DATO QUE FALTA] o pídeselo al cliente dentro del propio borrador.
6. Si el usuario te dejó etiquetar, aplica solo etiquetas. Guarda los borradores como nota interna, nunca como respuesta enviada.
7. Cuenta qué temas se repiten. Si uno aparece varias veces, propón una respuesta guardada para ese tema y espera el OK del usuario.

## Qué devolver
1. Tabla: Ticket | Tipo | Urgencia | Acción (borrador o persona) | Motivo.
2. Los borradores, uno debajo de otro, con el número de ticket en el título.
3. Los casos para persona, con resumen de dos líneas y el motivo.
4. Los tres temas más repetidos de la tanda y qué respuesta guardada convendría.
5. La lista de datos que faltaron para poder contestar.

## Qué NO hacer
- No envíes respuestas, no cierres tickets ni cambies su estado.
- No concedas reembolsos, descuentos, cambios ni excepciones. Tampoco los prometas.
- No inventes el estado de un pedido, plazos ni números de seguimiento.
- No pidas al cliente tarjeta, contraseñas ni documentos de identidad.
- No mezcles datos de un cliente con los de otro.
- No culpes al transportista ni al cliente sin datos.
- No des consejos médicos, legales ni de seguridad de producto.
- No copies datos personales fuera de esta sesión.

## Cuándo parar y pasar el caso a una persona
- Amenaza de reclamación formal, de acudir a consumo, a un abogado o a la prensa.
- Disputa de pago o contracargo con el banco.
- Producto que ha podido causar daño o que parece peligroso.
- Petición de acceso, rectificación o borrado de datos personales. El plazo legal es corto (un mes). No la dejes dormir.
- Cliente menor de edad, en situación delicada o que insulta.
- Importes por encima de [IMPORTE QUE FIJES].
- Cualquier caso donde la política no diga claro qué hacer.

## Qué revisa una persona antes de usar el resultado
- Cada borrador, antes de enviarlo. Las dos primeras semanas, todos. Después, una muestra [CUÁNTOS REVISAS].
- Que ninguna respuesta prometa algo que la tienda no cumple.
- Que la política que usó Claude sigue vigente.
- Que las etiquetas puestas son correctas.
