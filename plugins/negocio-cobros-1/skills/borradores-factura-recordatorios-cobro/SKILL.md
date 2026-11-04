---
name: borradores-factura-recordatorios-cobro
description: Prepara borradores de factura, presupuesto y recordatorio de cobro, y revisa errores antes de emitir. Trabaja con Elorus si está conectado. Úsala cuando hagas muchas facturas parecidas y quieras una segunda mirada antes de emitirlas.
---

# Borradores de factura y recordatorios de cobro

## Qué hace
Prepara borradores de facturas, presupuestos y avisos de cobro con los datos que le des, y los revisa buscando fallos típicos. Si Elorus está conectado, crea los borradores allí y lee las facturas pendientes de cobro. Si no, trabaja con tablas y textos.
No emite nada. Emitir una factura crea una obligación fiscal y no se borra después: lo hace una persona.

## Antes de empezar, pregunta
- ¿Es autónomo o sociedad? ¿Está en la Península, en Canarias (IGIC), en Ceuta o en Melilla? ¿Qué régimen de IVA tiene? Si no lo sabe, que lo consulte con su gestor antes de seguir.
- ¿Qué tipo de IVA y qué retención de IRPF lleva cada cliente o servicio, según su gestor? Claude no lo decide: copia lo que le den.
- ¿Qué series y numeración usa? ¿Cuál fue el último número emitido?
- ¿Elorus está conectado y con qué permisos: solo lectura o también crear borradores? Si no, ¿qué datos va a pegar?
- De cada factura: cliente (nombre o razón social, NIF o CIF, domicilio), concepto, cantidad, precio sin IVA, fecha de la operación, forma y plazo de pago.
- ¿El cliente es de otro país, de fuera de la UE o una Administración Pública? Esos casos tienen reglas propias y pasan al gestor.

## Paso a paso
1. Reúne los datos y pregunta lo que falte. Si falta el NIF, el domicilio o el tipo de IVA, no sigas con esa factura: márcala como incompleta.
2. Haz el cálculo a la vista: base de cada línea, suma de bases, cuota de IVA, retención y total. Muestra la cuenta paso a paso y redondea siempre igual, a dos decimales. La persona la comprueba con calculadora, porque un modelo de lenguaje puede fallar en las cuentas.
3. Escribe el borrador con lo que exige una factura en España: serie y número, fecha de expedición, datos de quien emite y de quien recibe, descripción, base imponible, tipo y cuota de IVA, retención si aplica y total. Cualquier mención especial (exención, inversión del sujeto pasivo) solo si la da el gestor.
4. Revisa el lote y avisa de: NIF vacío o con formato raro, número repetido o con saltos, fecha fuera del periodo, suma que no cuadra, IVA distinto del habitual para ese cliente, importe muy distinto al de facturas anteriores, clientes duplicados con nombres parecidos y conceptos vacíos o vagos.
5. Si hay conexión, crea los borradores en Elorus sin emitir ni enviar. Enseña lo creado y lo que falta.
6. Cobros: ordena lo pendiente por antigüedad (no vencido, vencido hace poco, vencido hace mucho). Redacta un recordatorio por nivel: amable, firme y último aviso. Todos educados.
7. Deja un resumen para la persona: qué revisar y qué preguntar al gestor.

## Qué devolver
- Tabla de borradores: Cliente | Nº provisional | Concepto | Base | IVA | Retención | Total | Estado (listo para revisar o incompleta).
- Lista de avisos: lo raro encontrado, con la factura a la que se refiere.
- Preguntas pendientes para la persona.
- Tabla de cobros pendientes con antigüedad e importe.
- Textos de recordatorio, uno por nivel, con [NOMBRE], [Nº DE FACTURA], [IMPORTE] y [FECHA DE VENCIMIENTO].

## Qué revisa una persona antes de emitir
- La persona titular: datos del cliente, conceptos, importes, fechas y que el trabajo esté hecho.
- El gestor: tipo de IVA, retención, régimen, operaciones con el extranjero o con Administraciones Públicas, facturas rectificativas, y si el programa de facturación cumple las reglas vigentes (por ejemplo VeriFactu, cuyas fechas se han ido aplazando). Que pregunte cuáles le afectan hoy.

## Qué NO hacer
- No emitas, envíes ni marques como cobrada ninguna factura. Cobrada, solo con justificante (transferencia, recibo).
- No borres ni cambies facturas ya emitidas. Una factura emitida se corrige con una rectificativa, y eso lo decide una persona.
- No inventes NIF, importes, fechas, tipos de IVA ni retenciones. Si falta un dato, pon [DATO].
- No cambies la numeración ni las series.
- No amenaces en los recordatorios con embargos, abogados ni con meter al cliente en un fichero de morosos. Eso tiene requisitos legales y lo decide una persona con su asesor.
- No cites leyes ni intereses de demora en los recordatorios salvo que el gestor dé el texto.
- No des asesoramiento fiscal ni presentes impuestos. Si preguntan cuánto IVA toca, la respuesta es que lo confirma el gestor.
- No pidas ni pegues listados enteros de clientes con NIF y domicilio si no hacen falta. Trabaja con los datos mínimos.
- No pegues claves de API en el chat. Van en la configuración del conector.

## Cuándo pedir a una persona
- Siempre que el cliente sea de fuera de España, sea una Administración Pública, o haya dudas sobre IVA o retención.
- Cuando una factura tenga que anularse o corregirse.
- Cuando un cliente no pague tras varios avisos.

## Instalación (para ti, no para Claude)
Guarda este texto como SKILL.md dentro de una carpeta con el nombre de arriba, en .claude/skills/ de tu proyecto, o en ~/.claude/skills/ para usarlo en todos tus proyectos. Si conectas Elorus, empieza con permisos de solo lectura.
