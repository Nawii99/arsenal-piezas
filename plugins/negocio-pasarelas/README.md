# arsenal-negocio-pasarelas · Negocio · Pasarelas y medios de pago

Negocio · Pasarelas y medios de pago: 4 subagentes, 4 skills en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-negocio-pasarelas@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| cobrar-en-pakistan-ruta-pagos | Skill | Prepara el plan para cobrar a clientes de Pakistán con métodos locales (JazzCash, Easypaisa, Raast) u otras vías: ruta legal y de cobro, flujo de pago, precios en rupias y pruebas. | se activa sola cuando hace falta |
| cobros-con-freno-braintree | Skill | Te ayuda a revisar cobros, impagos, suscripciones y reembolsos de Braintree y deja todo movimiento de dinero pendiente de tu OK. | se activa sola cuando hace falta |
| operar-stripe-con-doble-confirmacion | Skill | Revisa tu cuenta de Stripe y prepara cobros, reembolsos y cambios de suscripción, pero solo ejecuta lo que una persona confirma una a una. | se activa sola cuando hace falta |
| square-cuadre-y-cobros-con-confirmacion | Skill | Consulta pagos, pedidos y facturas de Square, cuadra las ventas con tu caja o banco y prepara cobros o devoluciones que solo se ejecutan con tu confirmación. | se activa sola cuando hace falta |
| cobrar-china-wechat-pay | Subagente | Valora si tu negocio puede cobrar con WeChat Pay y prepara el plan: vía a través de tu pasarela o TPV, pruebas, contabilidad y los obstáculos que no son de pago, como aduanas, marca y datos. | pídele a Claude «usa el subagente cobrar-china-wechat-pay» |
| cobros-con-stripe | Subagente | Elige y prepara la forma más simple de cobrar con Stripe (enlace de pago, Checkout o suscripción), te da los pasos para probarla en modo de prueba y una lista de revisión previa. | pídele a Claude «usa el subagente cobros-con-stripe» |
| cobros-venmo-eeuu | Subagente | Valora si tu negocio puede cobrar con Venmo, elige la vía oficial (PayPal o Braintree), prepara el plan y las pruebas en modo prueba y avisa de los límites legales y fiscales. | pídele a Claude «usa el subagente cobros-venmo-eeuu» |
| plan-cobros-por-banco-sepa | Subagente | Compara cobrar por transferencia, adeudo SEPA o pago desde el banco del cliente, calcula el coste con tus cifras y prepara el circuito y sus riesgos sin mover dinero. | pídele a Claude «usa el subagente plan-cobros-por-banco-sepa» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
