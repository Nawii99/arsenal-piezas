---
name: revision-minutas-abogados-externos
description: Revisa facturas y minutas de abogados externos contra la hoja de encargo para detectar errores de suma, tarifas distintas a las pactadas, partidas dudosas, suplidos sin justificar, IVA y retención. Úsala cuando vayas a pagar o auditar honorarios de un despacho. No da opinión jurídica.
---
# Revisión de minutas de abogados externos
Qué hace: ordena la factura de un despacho línea por línea, la compara con lo que se pactó por escrito y devuelve una lista de dudas para preguntar al despacho. No decide si un honorario es justo o abusivo. Eso lo valora un abogado.
Cómo se usa: se activa sola con peticiones de este tema, o la llamas escribiendo /revision-minutas-abogados-externos.
## Confidencialidad, antes de subir nada
- Las descripciones de una minuta pueden revelar estrategia, nombres de terceros y datos personales. Comprueba que tu empresa permite usar Claude con esos documentos.
- Si revisas facturas de un cliente tuyo, necesitas con él un acuerdo de confidencialidad y, si hay datos personales, un contrato de encargado del tratamiento (artículo 28 del RGPD).
- Siempre que puedas, cambia nombres de personas y de la contraparte por iniciales antes de subir el archivo.
## Pregunta antes de empezar
- ¿Eres quien paga o revisas por encargo de quien paga?
- ¿Tienes la hoja de encargo, el presupuesto o el correo donde se pactaron los honorarios? Sin eso solo se puede revisar la coherencia interna de la factura, y se avisa de ello.
- ¿Los honorarios son por horas, a tanto alzado, por fases, con tope o con parte a éxito? ¿Qué tarifa hay por categoría (socio, asociado, junior)?
- ¿Qué periodo cubre la factura? ¿Hay otras facturas del mismo asunto ya pagadas?
- ¿Hay suplidos o provisiones de fondos (procurador, tasas, notaría, peritos) y sus justificantes?
- ¿El asunto está en conflicto con el despacho? Si es así, la revisión solo sirve de apoyo para que la vea un abogado.
## Paso a paso
1. Apunta las condiciones pactadas: tarifa por categoría, tope o presupuesto, importes fijos, política de gastos y periodicidad. Lo que no esté escrito se marca como «no consta».
2. Pasa la factura a una tabla con fecha, persona o categoría, descripción, tiempo, tarifa e importe. Si el PDF es una imagen, la lectura puede fallar: enseña la tabla y pide que se compruebe con el original antes de seguir.
3. Verifica la aritmética con un script o una hoja de cálculo, no de cabeza: cada línea (tiempo por tarifa), suma de la base, IVA, retención y total. Enseña el cálculo y repítelo desde cero al final.
4. Pasa estos controles. Tarifa aplicada frente a la pactada. Categoría que no cuadra con la tarea (tareas sencillas a tarifa de socio). Tiempos mínimos por tarea que nadie pactó. La misma tarea apuntada dos veces o por dos personas. Reuniones o correos internos del propio despacho. Descripciones vagas como «estudio del asunto». Trabajo fuera del encargo. Total por encima del presupuesto o del tope. Fechas fuera del periodo. Suplidos sin justificante.
5. Revisa los datos de la factura: nombre y NIF de emisor y destinatario, numeración, fecha, descripción, base, tipo y cuota de IVA, y retención de IRPF si procede. No des por buenos ni por malos el tipo de IVA ni la retención: anota la pregunta para el gestor, porque dependen de quién emite y de a quién.
6. Clasifica cada hallazgo en tres grupos. Error objetivo (suma mal, tarifa distinta a la pactada por escrito). Pregunta al despacho (hace falta una aclaración). Para valoración de un abogado (por ejemplo, si las horas son razonables para ese trabajo). De cada uno indica la línea o el número de factura, qué se observa y el importe afectado.
7. Redacta un borrador de correo al despacho, en tono neutro, pidiendo aclaraciones sobre las partidas del segundo grupo. Sin acusaciones ni amenazas. Se entrega para que lo revise y lo envíe una persona.
## Qué devolver
1. Resumen: importe total facturado, importe con dudas y número de partidas revisadas.
2. Tres listas de hallazgos: error objetivo, pregunta al despacho y para valoración de un abogado.
3. Cálculo «si se aceptaran las correcciones», marcado como hipotético.
4. Borrador de correo.
5. Documentos que faltan para completar la revisión.
Todo en español llano y con los importes en euros con dos decimales.
## Qué NO hacer
- No digas que un honorario es abusivo, ilegal ni demasiado alto. Cuenta lo que observas y la pregunta que procede.
- No inventes tarifas medias de mercado ni porcentajes de ahorro. Si hace falta una referencia, que la aporte el usuario con su fuente [FUENTE].
- No pagues, rechaces ni envíes nada: ni facturas ni correos.
- No rellenes datos que no estén en el documento.
- No des por buena una factura porque las sumas cuadren: puede estar mal descrita o ir más allá de lo pactado.
- No subas documentos con secreto profesional a herramientas que tu empresa no haya autorizado.
## Quién revisa antes de usar el resultado
- Un abogado (el de la empresa o uno independiente) revisa los hallazgos del tercer grupo y decide si se reclama algo.
- Tu gestor revisa el IVA y la retención.
- Si el desacuerdo es serio, pregunta a tu Colegio de Abogados si tiene un procedimiento para consultas sobre honorarios [confirma en tu colegio].
- Quien autoriza el pago decide. La skill no decide por nadie.
