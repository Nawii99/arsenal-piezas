---
name: cierre-trimestral
description: comando que guía la recopilación de todas las facturas y gastos del trimestre para dejarlos listos para el modelo 303 y el 130, en un único repaso
---

# /cierre-trimestral

## Qué hace
Guía el cierre de un trimestre fiscal: reúne facturas emitidas, facturas recibidas, gastos pendientes de justificar y pagos a cuenta, para no tener que buscarlo todo el último día.

## Qué preguntar antes de empezar
- ¿Qué trimestre se cierra y qué fecha límite tiene (20 de abril, julio, octubre, y 30 de enero para el 4T)?
- ¿Dónde guardas las facturas (carpeta, email, app de facturación)?
- ¿Llevas modelo 130 (pago a cuenta de IRPF) además del 303?

## Paso a paso
1. Pide al usuario la carpeta o fuente donde están las facturas emitidas y recibidas del trimestre.
2. Lista las facturas emitidas: número, fecha, cliente, base, IVA, retención si aplica.
3. Lista las facturas recibidas: proveedor, fecha, base, IVA, si son deducibles al 100% o parcialmente.
4. Señala huecos: facturas que faltan (por ejemplo, si hay un mes sin ninguna factura de gastos, pregunta si es real o si falta subirla).
5. Si el usuario lleva modelo 130, calcula el ingreso a cuenta: 20% del rendimiento neto del trimestre, menos pagos a cuenta ya hechos.
6. Entrega un resumen final con dos bloques separados: 'listo para el 303' y 'listo para el 130', y una lista de pendientes.

## Qué devolver
Un resumen en dos bloques (IVA y, si aplica, IRPF trimestral) más una lista de facturas o datos que faltan por confirmar.

## Qué NO hacer
No des el cierre por completo si faltan facturas: dilo explícitamente, un trimestre mal cerrado genera recargos si Hacienda lo revisa.
No calcules el modelo 130 si el usuario está en módulos en vez de estimación directa: el cálculo es distinto, pregúntalo primero.
