---
name: presupuesto-condiciones
description: Genera un presupuesto de servicios con alcance, exclusiones, condiciones de pago, validez y cláusulas de cambios y cancelación, listo para enviar y aceptar por escrito.
argument-hint: qué vas a hacer, para quién, por cuánto y en cuánto tiempo
---
Actúa como alguien que lleva años presupuestando servicios a pymes en España y ha cobrado tarde demasiadas veces. Tu trabajo es que este presupuesto deje todo cerrado antes de empezar.

Contexto que te doy: $ARGUMENTS

Antes de escribir nada, comprueba que tienes esto. Si falta algo, pregúntamelo en una sola tanda de preguntas:

1. Quién presupuesta (mi nombre o marca, NIF, email) y quién recibe (nombre, empresa si la hay).
2. Qué entrego exactamente, en entregables contables (por ejemplo, '3 diseños de post', '1 web de 5 páginas', '4 horas de consultoría').
3. Precio: total cerrado o por horas. Si me lo has dado sin IVA, lo indico. Si no me lo has dicho, pregunta.
4. Plazo de entrega y qué necesito del cliente para cumplirlo (accesos, textos, fotos).
5. Cuántas rondas de cambios incluye el precio.

Con eso, escribe el presupuesto en Markdown con esta estructura exacta:

**Cabecera**: 'PRESUPUESTO Nº [NÚMERO]', fecha, datos de quien lo emite y de quien lo recibe.

**1. Qué incluye**: lista de entregables, uno por línea, con cantidades. Sin verbos vagos como 'gestión' o 'apoyo': si no se puede contar, no es un entregable.

**2. Qué NO incluye**: lista explícita de lo que la gente suele dar por hecho en este tipo de trabajo y no está en el precio (por ejemplo, hosting, licencias de fotos, publicidad de pago, textos, mantenimiento posterior). Mínimo 4 puntos adaptados al servicio.

**3. Precio**: tabla con concepto, importe sin IVA, IVA al 21 % y total. Si el servicio tuviera otro tipo de IVA o exención, marcarlo como [CONFIRMAR CON GESTOR]. Si soy autónomo y el cliente es empresa, añade una línea que diga que la factura llevará la retención de IRPF que corresponda.

**4. Forma de pago**: por defecto, 50 % a la aceptación del presupuesto y 50 % a la entrega, por transferencia. El trabajo no empieza hasta recibir el primer pago. Los entregables finales se envían al recibir el segundo. Si el importe es pequeño (menos de [IMPORTE]), 100 % por adelantado.

**5. Plazo**: fecha o número de días laborables contados desde que se reciba el primer pago Y el material del cliente. Aclarar que los retrasos del cliente en entregar material desplazan la fecha el mismo número de días.

**6. Cambios y revisiones**: el número de rondas incluidas. Cada ronda extra se cobra a [PRECIO POR RONDA O POR HORA]. Cambiar el alcance (añadir cosas que no están en el punto 1) requiere presupuesto nuevo o anexo firmado.

**7. Cancelación**: si el cliente cancela después de empezar, el primer pago no se devuelve y se factura el trabajo hecho hasta ese día. Si cancelo yo, devuelvo lo no trabajado.

**8. Propiedad y uso**: el cliente recibe los derechos de uso de los entregables una vez pagado el total. Hasta entonces, el trabajo es mío. Me reservo el derecho a mostrar el trabajo en mi portfolio salvo que el cliente diga lo contrario por escrito.

**9. Validez**: este presupuesto vale 15 días desde la fecha de emisión. Pasado ese plazo, puede cambiar.

**10. Aceptación**: una frase de aceptación y espacio para nombre, fecha y firma. Añade una nota de que responder 'acepto' a este email con el presupuesto adjunto también vale como aceptación, y que es recomendable guardar ese email.

Al final del documento, fuera del presupuesto, añade un bloque corto 'Antes de enviarlo' con tres avisos:

- Un presupuesto aceptado por escrito es un contrato. Si hay cláusulas que no vas a cumplir (como no empezar sin cobrar), quítalas, no las dejes de adorno.
- Si el cliente es un particular (consumidor), algunas cláusulas de cancelación pueden no valer: tiene derecho de desistimiento de 14 días en contratos a distancia salvo excepciones. Marcar [REVISAR SI ES CONSUMIDOR].
- Esto es una plantilla de trabajo, no asesoramiento legal. Para importes altos o clientes grandes, que lo mire un abogado.

Tono del presupuesto: claro, directo, sin jerga legal donde no haga falta. Frases cortas. Nada de 'el proveedor se compromete a realizar sus mejores esfuerzos'.

Si además te pido 'versión para cobrar', añade un párrafo aparte explicando cómo ofrecer esto como servicio: preparar presupuestos y condiciones para otros autónomos que no saben qué poner, con un precio fijo por documento o un pack de plantillas personalizadas con su marca. Recuerda que ese servicio también lleva IVA al 21 %.
