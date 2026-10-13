---
name: elegir-pasarela-pago
description: Compara Stripe, PayPal y Redsys para una tienda pequeña sin cuota mensual y recomienda una según el país, el volumen de ventas y si el usuario ya tiene cuenta bancaria de empresa. Se activa con /elegir-pasarela-pago.
---
## Qué hace
Compara las pasarelas de pago más habituales para una tienda pequeña sin cuota mensual (Stripe, PayPal, Redsys) y recomienda una según el caso del usuario, sin inventar tarifas.
## Qué preguntar antes de empezar
- Desde qué país vende y a qué países quiere vender (España, UE, resto del mundo).
- Volumen mensual aproximado de ventas, aunque sea una estimación.
- Si tiene alta de autónomo o sociedad, porque algunas pasarelas piden CIF/NIF y cuenta bancaria a nombre del negocio.
- Si necesita cobrar en varias monedas o solo en euros.
## Paso a paso
1. Pide los cuatro datos de arriba si faltan.
2. Explica en una frase qué es cada pasarela: Stripe (integración directa en la web, pensada para carritos ligeros), PayPal (el comprador puede pagar sin dar la tarjeta a la tienda), Redsys (la pasarela de los bancos españoles, pide contrato con el banco).
3. Dile al usuario que consulte la comisión actual en la web oficial de cada una antes de decidir, porque las tarifas cambian con el tiempo: no le des una cifra fija de comisión.
4. Si vende sobre todo en España a particulares y quiere montarlo rápido sin contrato bancario, apunta hacia Stripe o PayPal por la rapidez de alta.
5. Si el negocio ya tiene relación con un banco español y quiere evitar depender de una empresa extranjera, apunta hacia Redsys, avisando de que el alta tarda más y pide contrato con el banco.
6. Avisa siempre de que el dinero tarda unos días en llegar a la cuenta bancaria real (no es instantáneo) y que hay que planificar la tesorería con eso en cuenta.
## Qué devolver y en qué formato
Una tabla con tres filas (Stripe, PayPal, Redsys) y columnas: rapidez de alta, para quién encaja, qué hay que revisar en la web oficial antes de decidir. Debajo, una recomendación en una frase.
## Qué NO hacer
- No dar una cifra exacta de comisión como si fuera fija: las pasarelas las cambian y varían según el plan.
- No recomendar una pasarela sin conocer el volumen de ventas y el país.
- No decir que una pasarela es 'la mejor' en general: depende del caso.
- No dar por hecho que el usuario tiene cuenta de empresa: preguntarlo.
