---
name: triaje-casos-service-cloud
description: Ordena los casos de atención al cliente de Salesforce Service Cloud por urgencia y tema, resume cada conversación y deja borradores de respuesta para que una persona los revise y envíe. Úsala cuando haya una cola de casos o mensajes de varios canales.
---

# Triaje de casos y borradores de respuesta en Service Cloud

## Qué hace
- Lee la cola de casos de Service Cloud (email, formulario web, chat, redes o WhatsApp, según lo que tengas conectado).
- Ordena los casos por urgencia y tema, y resume cada uno en dos líneas con lo que ya se sabe del cliente.
- Separa los casos que no debe contestar una máquina sin que una persona los vea antes.
- Escribe borradores de respuesta usando solo la política escrita y los artículos de ayuda (Knowledge) que le des.
- No envía, no cierra casos y no cambia estados, prioridades ni dueños.

## Riesgos y costes reales
- Service Cloud es de pago por usuario [consulta tu contrato].
- Un borrador mal revisado puede prometer un reembolso, un plazo o una garantía que la empresa no ofrece. Por eso lo envía una persona.
- Los casos contienen datos personales y a veces datos de pago o de salud. Se tratan con cuidado (ver más abajo).

## Antes de empezar, pregunta
1. Cómo accedo a los casos. Escribe /mcp para ver si hay un conector de Salesforce. Si no, vale una exportación o los casos pegados en el chat.
2. Qué canales entran hoy y cuántos casos hay. Trabajo por tandas pequeñas [FIJA TÚ EL TAMAÑO DE LA TANDA].
3. Política escrita de devoluciones, garantías, plazos de respuesta, horarios y tono. Si no existe, marco [POLÍTICA PENDIENTE] y no la invento.
4. Qué categorías y prioridades usáis. Si no hay, propongo urgente, normal y baja.
5. Idiomas de los clientes y quién revisa y envía cada borrador.
6. Si en los casos hay datos de pago, de salud o de menores.

## Paso a paso
1. Leo la tanda y te digo cuántos casos hay y cuáles no he podido leer bien.
2. Clasifico cada caso: tema, urgencia con el motivo en una frase, canal, ánimo del cliente (tranquilo, molesto, muy molesto) y si necesita persona (sí o no, y por qué).
3. En los que necesitan persona no redacto respuesta final. Escribo una nota para tu compañero con lo que ha pasado y lo que falta.
4. En el resto busco la respuesta en la política o en Knowledge. Si la hay, escribo el borrador: reconoce el problema, da la solución o el siguiente paso concreto, un plazo que conste en la política y una despedida. Indico de qué artículo o política sale.
5. Si no hay respuesta en lo que me diste, no la invento. Escribo [FALTA INFORMACIÓN] y las preguntas que habría que hacer al cliente.
6. Si tres casos o más cuentan el mismo problema, lo marco como posible incidencia para el responsable.
7. Preparo el informe final.

## Qué devolver
- Una tabla con una fila por caso: número, canal, tema, urgencia, ¿necesita persona?, ¿borrador listo? y siguiente paso.
- Debajo, los borradores numerados igual que la tabla.
- Al final, los problemas que se repiten y los artículos de ayuda que faltarían.
- Todo en Markdown. Datos del cliente, los justos para identificar el caso.

## Qué NO hacer
- No enviar respuestas, no cerrar casos y no cambiar estado, prioridad ni dueño sin una orden clara.
- No prometer reembolsos, compensaciones, plazos de entrega, garantías ni excepciones que no estén en la política escrita.
- No dar consejo legal, médico ni financiero a clientes.
- No culpar al cliente ni discutir con él en el tono del borrador.
- No confirmar datos de una cuenta ni dar información de un cliente a otra persona. Para datos de cuenta, se pide la verificación que use vuestro procedimiento.
- No copiar en los borradores números de tarjeta, DNI ni contraseñas que el cliente haya pegado en el caso. Márcalo y avisa a la persona responsable de protección de datos.
- No hacerse pasar por una persona. Si un cliente habla con un sistema automático, hay que avisarle (Reglamento de IA de la UE, art. 50). Confirma con tu asesor el estado de aplicación.

## Cuándo pedir una persona sí o sí
- Reclamación formal, hoja de reclamaciones, OMIC o consumo, mención de un abogado, o queja pública en redes o prensa.
- Solicitudes sobre datos personales (acceso, rectificación, supresión, portabilidad). El plazo legal es corto, normalmente un mes.
- Sospecha de fraude, de suplantación o de fuga de datos. Ante una brecha de seguridad el aviso a la AEPD tiene un plazo de 72 horas, así que avisa ya al responsable.
- Problemas de seguridad física o de salud, y clientes en situación vulnerable o menores.
- Antes de usar el resultado, una persona con capacidad de decisión lee cada borrador y confirma importes, fechas y política aplicada.

## Dónde se guarda
- Guárdala como .claude/skills/triaje-casos-service-cloud/SKILL.md dentro de tu proyecto, o en la carpeta .claude de tu usuario para usarla en todos.
- Se activa sola cuando le pides ordenar casos o preparar respuestas, o la llamas escribiendo /triaje-casos-service-cloud.
