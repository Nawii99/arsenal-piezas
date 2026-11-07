---
name: auditar-facturas-abogados
description: "Revisa facturas de abogados externos contra la hoja de encargo o el presupuesto: tarifas, horas, gastos, impuestos y tendencias por asunto. Úsala cuando una empresa quiera comprobar lo que le cobran sus despachos antes de pagar o renegociar."
---

# Auditoría de facturas de abogados externos

Dónde va: guárdala como .claude/skills/auditar-facturas-abogados/SKILL.md dentro de tu carpeta de trabajo. Se activa cuando pides algo parecido; también puedes nombrarla.

## Qué hace
Compara lo que cobra un despacho con lo que se pactó y señala lo que merece una pregunta. Es una revisión de cifras. No es asesoramiento jurídico y no decide qué es un cobro indebido.

## Riesgos que debes saber antes de empezar
- Las facturas de abogados pueden describir asuntos delicados: litigios, despidos, operaciones. Es información confidencial de la empresa y puede estar protegida por secreto profesional. Antes de pasar el detalle a Claude Code, pide permiso a quien responda de lo jurídico en la empresa. Si no lo tienes, tapa nombres y descripciones y deja fechas, horas, importes y códigos de asunto.
- Si eres externo, firma antes un acuerdo de confidencialidad y, si hay datos personales, un contrato de encargado de tratamiento (artículo 28 del RGPD).
- Encontrar una diferencia no prueba un error. Puede haber pactos posteriores o verbales. Siempre se pregunta antes al despacho.

## Qué preguntar antes de empezar (todo junto)
1. ¿Qué documentos hay? Hoja de encargo, presupuesto, contrato marco, tarifas pactadas, reglas de la empresa para proveedores jurídicos, facturas y detalle de horas.
2. ¿Qué periodo y qué asuntos se revisan?
3. ¿Cómo se pactó el cobro? Por horas, precio cerrado, por fases, iguala o éxito. ¿Hay tope o presupuesto máximo?
4. ¿Qué tarifa tiene cada categoría (socio, asociado, junior, paralegal)?
5. ¿Hay reglas escritas? Por ejemplo, no cobrar tiempo de secretaría, límite de asistentes a reuniones o aprobación previa de gastos. Si no las hay, uso criterios orientativos y lo digo claramente.
6. ¿Quién decide qué se pregunta o se negocia?
7. ¿Desde qué importe quieres revisión a mano? [UMBRAL EN EUROS]

## Paso a paso
1. Inventario de documentos: qué hay y qué falta. Si no hay hoja de encargo ni tarifas, solo puedes revisar forma y cuentas. Dilo al principio del informe.
2. Pasa los datos a una tabla: factura, fecha, asunto, concepto, horas, tarifa, importe, gastos, IVA y retención. No inventes ninguno.
3. Comprobaciones de forma: datos obligatorios del Reglamento de facturación (Real Decreto 1619/2012), numeración, que las cuentas cuadren, IVA, retención de IRPF cuando proceda y suplidos con justificante.
4. Comprobaciones contra lo pactado: tarifa por persona frente a la acordada, subidas de tarifa a mitad de asunto, total frente a presupuesto o tope, fases facturadas por adelantado, gastos no previstos o sin justificante y provisiones de fondos sin descontar.
5. Comprobaciones del detalle de horas, si hay: el mismo trabajo en dos facturas; varias personas en una misma reunión; tareas administrativas cobradas como jurídicas; entradas siempre redondeadas hacia arriba; descripciones vagas como «estudio del asunto»; más de [N] horas al día de una misma persona; trabajo de formación de un junior; tareas de poco nivel cobradas a tarifa de socio.
6. Presenta cada punto de los dos pasos anteriores como «a aclarar», no como error. Solo un fallo de suma o de cálculo es un error.
7. Tendencias: por asunto, por mes y por persona, con horas, importe y porcentaje del total, frente al presupuesto. Señala desviaciones superiores a [UMBRAL EN %]. Con pocas facturas, di que no hay datos suficientes para hablar de tendencia.
8. Importe en duda en tres columnas: seguro (error de cálculo o contra una tarifa escrita), probable (contra una regla documentada) y a preguntar (criterio). No lo sumes como «ahorro»: no es dinero recuperable.
9. Borrador de mensaje al despacho: tono neutro, preguntas numeradas y un plazo razonable de [PLAZO]. Lo envía una persona de la empresa.

## Qué devolver y con qué formato
Markdown con tablas, importes en euros con dos decimales y fechas DD/MM/AAAA. En este orden:
1. Resumen de seis líneas: alcance, documentos usados, número de facturas, importe revisado, importe en duda en las tres columnas y qué falta.
2. Tabla de hallazgos: número, factura, qué se ve, pacto o regla en que se apoya, importe, nivel y pregunta para el despacho.
3. Tabla de tendencias.
4. Borrador de mensaje al despacho.
5. Lista «Para decidir una persona».

## Qué NO hacer
- No decir que hay fraude, mala fe o cobro indebido. Usa «diferencia» o «a aclarar».
- No inventar tarifas, pactos ni reglas. Lo que no esté escrito se presenta como criterio orientativo.
- No interpretar contratos ni opinar sobre si el trabajo era necesario o sobre la estrategia del caso. Eso lo decide un abogado.
- No pagar, rechazar, devolver ni enviar nada.
- No mezclar datos de empresas distintas en un mismo informe.
- No prometer ahorros.
- No usar un hallazgo en una disputa abierta sin que lo vea el abogado de la empresa.

## Cuándo pasar a una persona
- Diferencias por encima de [UMBRAL EN EUROS].
- Disputa abierta con el despacho o honorarios de éxito.
- Dudas sobre secreto profesional.
- Despachos de otro país, donde los impuestos cambian.
- Los colegios de abogados suelen tener un cauce para consultas sobre honorarios: pregunta al colegio del despacho.
