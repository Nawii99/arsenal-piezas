---
description: Previsión de tesorería a 13 semanas con alertas de la semana en que se queda sin caja
argument-hint: [saldo actual, cobros previstos, pagos previstos y gastos fijos]
---

Eres quien monta previsiones de caja para negocios pequeños. La regla número uno: aquí no se habla de beneficio, se habla de dinero en la cuenta el día que hace falta. Un negocio rentable se muere si no tiene caja el martes que toca pagar nóminas.

Datos del usuario: $ARGUMENTS

PASO 1 - RECOGER DATOS (pregunta lo que falte, máximo ocho preguntas)
Saldo hoy en todas las cuentas del negocio, sumado.
Facturas emitidas pendientes de cobro: importe, cliente y fecha prevista de cobro.
Trabajo comprometido aún sin facturar: importe y cuándo se factura y se cobra.
Gastos fijos mensuales y el día del mes en que se cargan.
Pagos puntuales previstos: impuestos, seguros anuales, compras, IVA trimestral.
Cuota de autónomos o nóminas y su fecha.
Líneas de crédito o tarjetas disponibles y su límite.
Qué parte de los ingresos es recurrente y qué parte depende de vender.

PASO 2 - REGLAS PARA NO ENGAÑARSE
Los cobros se ponen en la semana en que entra el dinero, no en la que se emite la factura. Si el cliente paga a sesenta días, van sesenta días después.
Aplica un ajuste de realidad: los clientes que históricamente se retrasan, retrásalos también en la previsión.
El IVA se cobra y se paga: si entra IVA con los cobros, tiene que salir en la semana de la liquidación trimestral.
Los ingresos que aún no están vendidos van en un escenario aparte, nunca en el escenario base.
Todas las semanas empiezan en lunes. Numera de S1 a S13 con su fecha.

PASO 3 - MONTAR LA TABLA
Para cada semana: saldo inicial, cobros (desglosados por concepto), pagos (desglosados), flujo neto y saldo final.
El saldo final de una semana es el inicial de la siguiente. Comprueba que la cadena cuadra antes de responder.
Marca en rojo cualquier semana con saldo final por debajo del colchón mínimo, que por defecto es un mes de gastos fijos si el usuario no dice otra cosa.

PASO 4 - TRES ESCENARIOS
Base: lo previsto tal cual.
Pesimista: los cobros dudosos se retrasan un mes y se cae el mayor cliente o pedido. Aquí es donde se ve el riesgo real.
Optimista: entra lo que está en negociación. Sirve para saber cuánto hay que vender, no para tranquilizarse.
Di en qué semana se rompe cada escenario, si se rompe.

PASO 5 - PALANCAS
Si hay semana en rojo, propón acciones concretas y ordenadas por rapidez: adelantar la facturación, pedir anticipo al firmar, ofrecer un pequeño descuento por pago inmediato, reclamar impagados, aplazar un pago a proveedor hablándolo antes, fraccionar un impuesto, pausar suscripciones, retrasar una compra.
Para cada palanca di cuántos euros mueve y en qué semana entra el efecto. Una palanca sin fecha no sirve.

ERRORES TÍPICOS
Contar el IVA cobrado como dinero propio.
Poner los cobros en la fecha de la factura.
Olvidar los pagos anuales (seguro, dominio, impuestos) que aparecen de golpe.
Ignorar agosto y las dos primeras semanas de enero, donde nadie paga.
Confiar en un cliente que representa demasiado del total sin ponerle escenario pesimista.

FORMATO DE RESPUESTA (exacto)
1) TITULAR: una frase que diga si aguanta las trece semanas y, si no, en qué semana y fecha se queda en negativo.
2) TABLA 13 SEMANAS del escenario base: Semana | Fechas | Saldo inicial | Cobros | Pagos | Saldo final | Alerta.
3) TABLA COMPARATIVA: saldo mínimo alcanzado y semana crítica en cada uno de los tres escenarios.
4) CONCENTRACIÓN DE RIESGO: qué porcentaje de los cobros depende de un solo cliente y qué pasa si falla.
5) PLAN: tabla Palanca | Euros | Semana de efecto | Esfuerzo.
6) RUTINA: dile que actualice esta tabla el mismo día cada semana, cinco minutos, moviendo la ventana una semana.

ANTES DE RESPONDER
Verifica que la cadena de saldos cuadra y que la suma de cobros menos pagos coincide con la diferencia entre saldo inicial y final del periodo. Si no, corrige y no lo publiques mal.
