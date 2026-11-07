---
name: cierre-facturacion-despacho
description: "Prepara el cierre mensual de facturación de un despacho de abogados: qué se puede facturar, borradores de facturas para revisar, errores en facturas ya hechas, cobros atrasados y previsión de caja. Úsala a fin de mes, cuando te pasen horas, hojas de encargo o un listado de facturas pendientes."
---

# Cierre mensual de facturación para despachos

Dónde va: guárdala como .claude/skills/cierre-facturacion-despacho/SKILL.md dentro de tu carpeta de trabajo. Se activa cuando pides algo parecido; también puedes nombrarla.

## Qué hace
Ordena el cierre de facturación de un despacho pequeño. Trabaja solo con los datos que le des: horas, hojas de encargo, facturas emitidas y cobros. Te devuelve un informe y borradores. No emite facturas, no las envía y no reclama nada a nadie. Eso lo hace una persona del despacho.

## Riesgos que debes saber antes de empezar
- Un despacho tiene deber de secreto profesional y trata datos personales (RGPD). Si usas Claude Code, lo que le pases se procesa fuera de tu ordenador. Antes de pasar datos reales, confirma por escrito con el responsable del despacho que está permitido.
- Pasa lo mínimo: código de asunto (por ejemplo A-014), fechas, horas e importes. Sin nombres de clientes y sin contar de qué va el asunto.
- Si trabajas para un despacho que no es el tuyo, necesitas un contrato de encargado de tratamiento (artículo 28 del RGPD) antes de recibir ningún dato.
- Esto no es contabilidad oficial ni asesoramiento fiscal. Los impuestos los decide el gestor del despacho.

## Qué preguntar antes de empezar (todo junto, no una a una)
1. ¿Mes y año del cierre?
2. ¿De dónde salen las horas y los gastos? Excel, CSV o el programa del despacho. Pide el archivo.
3. ¿Cómo se cobra cada asunto? Por horas, minuta fija, provisión de fondos, iguala o éxito. Pide la hoja de encargo o un resumen por asunto.
4. ¿Qué serie y numeración usan y cuál fue la última factura emitida?
5. ¿Quién emite y firma las facturas? ¿Quién autoriza las reclamaciones de cobro?
6. ¿Qué IVA y qué retención de IRPF aplican? No lo supongas. Normalmente depende del tipo de cliente, pero lo confirma el gestor.
7. ¿Qué plazos de pago hay pactados y qué política de recordatorios tienen?
Si no saben algo, anótalo como [PENDIENTE] y sigue. No rellenes huecos con suposiciones.

## Paso a paso
1. Trabaja siempre sobre copias de los archivos. Nunca sobre los originales.
2. Inventario facturable. Una tabla con una fila por asunto: asunto, forma de cobro, horas del mes, tarifa pactada, importe calculado, gastos y suplidos con justificante, provisión recibida y qué falta. Calcula importes solo si la tarifa consta por escrito. Si no, [PENDIENTE].
3. Borradores de facturas. Un borrador por asunto con algo que facturar: concepto genérico (sin desvelar estrategia), base, IVA, retención si procede y total. Márcalo como BORRADOR. Separa honorarios de suplidos. Si dudas de cómo tratar un suplido o una provisión en impuestos, escribe [PREGUNTAR AL GESTOR].
4. Revisión de facturas ya hechas o en borrador. Comprueba: número y serie correlativos sin saltos ni repetidos; fecha de expedición y de la operación; nombre, NIF y domicilio de emisor y cliente; descripción clara; base, tipo de IVA, cuota y total que cuadran; retención coherente con el cliente; importe igual a la hoja de encargo o a horas por tarifa; ningún trabajo facturado dos veces; cliente y asunto correctos. Los datos obligatorios están en el Reglamento de facturación (Real Decreto 1619/2012): comprueba la versión vigente.
5. Antigüedad de saldos. Agrupa lo pendiente por vencimiento: sin vencer, 1 a 30 días, 31 a 60, 61 a 90 y más de 90. Da el total por tramo y los cinco clientes con más deuda.
6. Borradores de recordatorio en tres tonos: cordial, firme y último aviso antes de pasarlo al responsable. Sin amenazas. Cada uno con la factura, el importe, el vencimiento y cómo pagar con [DATOS BANCARIOS DEL DESPACHO].
7. Previsión de caja a 30, 60 y 90 días en tres escenarios: prudente (solo lo vencido y confirmado), esperado y optimista. Las salidas (nóminas, alquiler, seguros, cuotas, impuestos) las pone el despacho. Si no las da, di que es una previsión de entradas y no de caja.
8. Cierra con una lista de decisiones que debe tomar una persona.

## Qué devolver y con qué formato
Markdown, importes en euros con dos decimales y fechas DD/MM/AAAA. En este orden:
1. Resumen de cinco líneas: total a facturar, total pendiente de cobro, facturas con errores, importe vencido a más de 60 días y datos que faltan.
2. Tabla del inventario facturable.
3. Borradores de facturas, uno por asunto, marcados BORRADOR.
4. Tabla de errores: factura, error detectado y qué comprobar.
5. Tabla de antigüedad de saldos.
6. Recordatorios propuestos.
7. Previsión de caja con los supuestos escritos.
8. Lista «Para decidir una persona».
Toda cifra sale de los datos recibidos. Si no sale de ahí, no la pongas.

## Qué NO hacer
- No emitir, enviar, anular ni modificar facturas. Una factura emitida no se borra: se corrige con una rectificativa y eso lo decide el gestor.
- No inventar tarifas, horas, fechas ni números de factura.
- No dar criterio fiscal sobre IVA, retenciones o suplidos. Marca [PREGUNTAR AL GESTOR].
- No enviar recordatorios ni contactar con clientes.
- No tocar el programa de facturación del despacho. Ese programa debe cumplir la normativa antifraude (Real Decreto 1007/2023, VeriFactu) y sus fechas de entrada en vigor se han ido aplazando: pregunta la fecha vigente al gestor.
- No amenazar con incluir a nadie en un fichero de morosos ni con acciones judiciales. Exige requisitos legales y lo decide un abogado del despacho.
- No poner en el informe nombres de clientes ni detalles de asuntos que no hagan falta.
- No presentar el resultado como asesoramiento legal o fiscal.

## Cuándo pasar a una persona
- La factura no cuadra con la hoja de encargo.
- Honorarios de éxito o asuntos con varias fases.
- El cliente es una Administración pública (la factura suele ser electrónica, por FACe) o es extranjero (el IVA cambia).
- Deudas por encima de [UMBRAL EN EUROS] o clientes que discuten la minuta.
- Cualquier duda sobre secreto profesional o datos personales.
