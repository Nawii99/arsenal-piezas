---
name: horas-presupuesto-proyectos-odoo
description: Revisa los partes de horas de Odoo, compara lo gastado con el presupuesto de cada proyecto, avisa de los que se desvían y prepara un borrador de lo que toca facturar. Úsala en el cierre semanal o mensual de una agencia, consultora o estudio que cobra por horas o por proyecto.
---

# Horas, presupuesto y facturación de proyectos en Odoo

## Qué hace
Trabaja sobre los partes de horas que exportas de Odoo. Compara lo gastado con el presupuesto de cada proyecto. Avisa de los que se desvían. Prepara un borrador de lo que toca facturar.
Solo lee y propone. No cambia horas, no emite facturas y no escribe a clientes.

## Qué necesita tu Odoo
- Las apps de Proyecto, Partes de horas, Ventas y Facturación. Los nombres de menús cambian según versión e idioma.
- Horas presupuestadas en cada proyecto o tarea. Sin ese dato no se puede medir el consumo. Si falta, lístalo como [DATO QUE FALTA] y no lo inventes.
- Fecha de entrega de cada proyecto. Sin ella no se calcula la proyección.
- Bien configurado el servicio que vendes. En Odoo, la forma de facturar se decide en el producto de servicio: según partes de horas, precio fijo o prepago, o por hitos. Si está mal puesto, lo demás no sirve. Revisa esto primero.

## Antes de empezar, pregunta
1. ¿Cómo cobras cada proyecto? Horas a tarifa, precio cerrado, bolsa de horas pagada por adelantado, hitos o mixto.
2. ¿Cuál es la tarifa por hora? ¿Única, por rol o por persona? No la inventes: [TARIFA POR HORA].
3. ¿Qué periodo se revisa? Semana, mes o proyecto entero.
4. ¿Qué umbrales de alerta usamos? Por defecto, amarillo al [80] % del presupuesto y rojo al [100] %.
5. ¿Quién recibe el informe?
6. ¿Puede mostrar horas por persona o solo por proyecto? (Mira el apartado de personas.)
7. ¿Las horas están aprobadas? ¿Cuáles cuentan como facturables?
8. ¿Quieres ver el margen? Hace falta el coste por hora del equipo, que es un dato delicado. Si no quieres compartirlo, se omite.
9. ¿Cuál es la fecha de entrega de cada proyecto? Sin ella no hay proyección y se marca [DATO QUE FALTA].

## Paso a paso
1. Revisa cómo está configurado el cobro de cada proyecto y dile al usuario si encaja con lo que contestó.
2. Pide exportar los partes del periodo con estas columnas: proyecto, tarea, fecha, horas, descripción, facturable sí o no, estado de aprobación del parte y estado de facturación. Pide también, por proyecto o tarea: horas presupuestadas, modelo de cobro y fecha de entrega. En las bolsas de horas, pide además las horas compradas.
   Si hay personas, pide un código por persona (P1, P2…) en lugar del nombre, y el rol si cambia la tarifa. El código sirve solo para la comprobación del paso 3 y no sale en el informe. La tabla que une códigos y nombres la guarda quien gestiona los datos.
3. Revisa la calidad. Lista horas sin descripción, días con más de [12] horas del mismo código de persona, horas negativas o a cero, horas en proyectos cerrados, tareas sin presupuesto e imputaciones muy tardías. No las corrijas.
4. Calcula por proyecto. Porcentaje consumido = horas imputadas entre horas presupuestadas (o entre horas compradas, si es una bolsa).
5. Ritmo semanal = media de horas de las últimas [4] semanas.
6. Proyección = horas imputadas + ritmo semanal × semanas que faltan hasta la fecha de entrega. Si no hay fecha de entrega, no calcules proyección y escribe [DATO QUE FALTA].
7. Según cómo se cobre cada proyecto, calcula lo que toca vigilar o facturar:
   - Horas a tarifa: pendiente de facturar = horas facturables y aprobadas sin facturar × tarifa.
   - Bolsa de horas: saldo = horas compradas menos horas consumidas. Usa el mismo semáforo sobre las horas compradas. Si está en amarillo o rojo, prepara un borrador de propuesta de nueva bolsa. Las horas consumidas no se facturan una a una.
   - Mixto: separa la parte por horas de la de precio cerrado y aplica a cada parte su regla.
   - Hitos: no factures por horas. Revisa los hitos cumplidos contra el contrato o el presupuesto aceptado y lista los que podrían facturarse.
   - Precio cerrado: las horas no se facturan. Sirven solo para medir cuánto cuesta.
8. Semáforo. Verde por debajo del umbral amarillo. Amarillo al llegar al umbral amarillo y mientras no llegue al segundo. Rojo al llegar o superar el segundo umbral, o si la proyección lo alcanza o lo supera.
9. Para cada proyecto en amarillo o rojo: causa probable, decisión que hace falta (avisar al cliente, pedir ampliación, reducir alcance, asumir la desviación) y un borrador de mensaje de 3 a 5 líneas. Antes de pedir más presupuesto, hay que leer el contrato o el presupuesto aceptado. No se envía nada.
10. Borrador de facturación: una línea por proyecto con concepto, horas, tarifa e importe base. En las bolsas, una línea con la propuesta de nueva bolsa. En los hitos, una línea por hito cumplido. No calcules IVA ni retenciones: lo confirma tu gestor.

## Qué devolver
- Resumen de 5 líneas: proyectos revisados, cuántos en rojo, horas por facturar y lo más urgente.
- Tabla: proyecto | modelo de cobro | horas presupuestadas o compradas | horas imputadas | % consumido | proyección | semáforo.
- Saldo de cada bolsa de horas.
- Problemas de datos encontrados.
- Borrador de facturación pendiente.
- Mensajes sugeridos para proyectos en riesgo.
- Decisiones que solo puede tomar una persona.

## Personas, empleo y facturas (revisa una persona)
- Los partes de horas son datos de personas trabajadoras. Usa totales por proyecto. No hagas rankings ni informes de «productividad» individual.
- Los códigos P1, P2… solo sirven para la comprobación de calidad. No los muestres en el informe.
- Si el informe va a mostrar horas por persona, antes se informa al equipo y lo revisa quien lleve recursos humanos o el asesor laboral (RGPD y derechos digitales de los trabajadores).
- Los partes por proyecto no sustituyen el registro de jornada obligatorio en España. Son cosas distintas [VERIFICAR novedades de la norma con tu asesor laboral].
- Lo mismo para freelancers: horas de personas, mismas precauciones.
- Antes de emitir una factura, una persona revisa las horas aprobadas, la tarifa pactada, el IVA y la retención de IRPF si procede.
- Si el proyecto es de precio cerrado, las horas no se facturan. Se usan solo para medir cuánto cuesta.

## Alertas dentro de Odoo
Odoo permite horas asignadas por tarea con barra de progreso y reglas automáticas. Montarlas lo hace quien administre Odoo, primero en una copia de pruebas, porque es fácil equivocarse. Esta skill funciona sin eso, con un informe semanal.

## Qué NO hacer
- No emitas, confirmes ni envíes facturas.
- No modifiques, borres ni «arregles» horas de nadie.
- No repartas horas entre proyectos para que cuadre el presupuesto.
- No factures horas no aprobadas ni de proyectos de precio cerrado o por hitos.
- No evalúes el rendimiento de personas con estos datos.
- No inventes tarifas, presupuestos, fechas ni costes. Pon [DATO QUE FALTA].
- No envíes mensajes a clientes. Solo borradores.
- No muestres horas por persona fuera del equipo de gestión.
- No prometas márgenes ni ingresos.
