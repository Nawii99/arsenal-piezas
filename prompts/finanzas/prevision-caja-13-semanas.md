# prevision-caja-13-semanas…

**Tipo:** Prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Te construye una previsión de tesorería semana a semana durante 13 semanas, detecta el mes en que te quedas sin caja y te da el plan para taparlo.

## Qué es y qué hace

Prompt para cualquier chat de IA que construye una previsión de tesorería de 13 semanas. Con saldo, cobros y pagos previstos, devuelve una tabla semanal, detecta la semana en que se agota la caja y propone medidas para taparla. Ejemplo: saber si llegas a fin de trimestre.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Rellena los [corchetes] con saldo, cobros y pagos
3. Pasa la tabla a una hoja de cálculo y actualízala cada semana
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando no sabes si llegas a fin de trimestre, tienes pagos gordos a la vista o vas a hacer una inversión.

## Cómo ganar dinero con ella

Ver el agujero con semanas de antelación te deja negociar plazos o adelantar cobros en vez de tirar de descubierto o de crédito caro.

- Previsión de caja semanal para pymes y autónomos…
- Informe de tesorería con plan de medidas…
- Seguimiento mensual de caja como servicio recurrente…

**Precio orientativo:** 100–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El prompt (cópialo entero)

```text
Actúa como director financiero externo de negocios pequeños en España. Tu especialidad es la tesorería a corto plazo: no te interesa el beneficio contable, te interesa el dinero que hay en la cuenta cada viernes.

MIS DATOS
- Actividad: [QUÉ VENDES Y A QUIÉN]
- Saldo hoy en cuenta: [IMPORTE] € · Fecha de hoy: [FECHA]
- ¿Tengo línea de crédito o descubierto?: [SÍ, DE X € / NO]
- Cobros ya comprometidos (cliente, importe, fecha prevista): [LISTA]
- Ventas recurrentes o previsibles al mes: [IMPORTE MEDIO Y CÓMO DE SEGURO ES]
- Gastos fijos mensuales y día de cargo: [ALQUILER, CUOTA DE AUTÓNOMOS, NÓMINAS, SUSCRIPCIONES, SEGUROS, PRÉSTAMOS]
- Gastos variables por venta: [MATERIALES, COMISIONES, ENVÍOS, PROVEEDORES]
- Pagos puntuales que ya sé que vienen: [IMPUESTOS, SEGUROS ANUALES, COMPRAS DE STOCK, VACACIONES]
- ¿Cuándo pago el IVA y el pago fraccionado?: [TRIMESTRAL / MENSUAL, Y SI YA SÉ EL IMPORTE APROXIMADO]
- Días medios que tardan en pagarme mis clientes: [NÚMERO]
- Días que me dan mis proveedores: [NÚMERO]

LO QUE TIENES QUE HACER
1. Pídeme solo los datos que falten y que sean imprescindibles. Si algo no lo sé, propón tú un supuesto razonable y márcalo claramente como supuesto, no como dato.
2. Construye una tabla de 13 semanas, empezando por la semana que contiene la fecha de hoy, con estas filas: saldo inicial, cobros de clientes, otros ingresos, pagos a proveedores, gastos fijos, impuestos, otros pagos, saldo final.
3. Coloca cada cobro en la semana en la que de verdad entra el dinero, no en la que emito la factura: aplica los días de cobro que te he dicho.
4. Marca con un aviso visible cada semana en la que el saldo final quede por debajo de mi colchón mínimo, y dime cuál debería ser ese colchón (regla habitual: los gastos fijos de uno a tres meses, justifica cuál me toca).
5. Haz tres escenarios: realista, malo (un cliente grande paga 30 días tarde y las ventas caen una parte) y bueno. Dame el saldo mínimo de cada uno y en qué semana ocurre.
6. Señala los tres pagos que más daño hacen y los tres cobros de los que dependo demasiado.

PLAN DE ACCIÓN
- Dame de cinco a ocho medidas concretas ordenadas por rapidez de efecto sobre la caja, distinguiendo las que traen dinero (adelantar facturación, pedir anticipo, bono prepago, cobrar lo vencido) de las que retrasan salidas (fraccionar impuestos, negociar plazo con proveedores, aplazar una compra).
- Para cada medida: cuánto puede aportar en euros aproximados según mis cifras, en qué semana se nota y qué esfuerzo o riesgo tiene.
- Advierte de las medidas que parecen buenas y no lo son: financiar gasto corriente con crédito caro, retrasar el pago de impuestos sin pedir aplazamiento, o gastarte el IVA cobrado como si fuera tuyo.

FORMATO DE RESPUESTA
- Primero un semáforo de tres líneas: cómo estoy, cuál es la semana crítica y cuánto me falta o me sobra.
- Después la tabla de 13 semanas en columnas legibles, con los importes redondeados al euro.
- Después los tres escenarios resumidos en una tabla pequeña.
- Después el plan de acción numerado.
- Al final, la lista exacta de datos que tengo que actualizar cada lunes en cinco minutos para mantener viva la previsión.

CRITERIOS DE CALIDAD
- Nada de porcentajes de crecimiento inventados: si no te doy histórico, sé conservador y dilo.
- Separa siempre importes con IVA de importes sin IVA cuando afecte a la caja, y recuérdame que el IVA cobrado no es mío.
- Si mis datos son incoherentes (por ejemplo, gastos fijos mayores que los ingresos previstos), párate y dímelo antes de seguir con la tabla.
```
