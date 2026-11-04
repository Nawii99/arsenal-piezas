# arsenal-finanzas-cobros · Finanzas · Facturas y cobros

Finanzas · Facturas y cobros: 18 comandos /, 7 subagentes, 3 skills en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-finanzas-cobros@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| apartar-impuestos | Comando / | Calcula cuánto dinero de cada cobro tienes que apartar en otra cuenta para llegar al IVA y al IRPF sin sustos y te deja el calendario del año. | `/apartar-impuestos` |
| cliente-rentable | Comando / | Ordena tus clientes por lo que te dejan de verdad, contando horas reales, incidencias y retrasos de pago, y te dice a quién subir, a quién soltar y a quién cuidar. | `/cliente-rentable` |
| cobrar-facturas-impagadas | Comando / | Monta la escalera de reclamación de una factura impagada: qué mandas, cuándo y con qué texto, hasta el burofax y el monitorio. | `/cobrar-facturas-impagadas` |
| cobrar-impagados | Comando / | Monta el plan completo para cobrar una factura que no te pagan: qué escribir, cuándo, con qué tono y hasta dónde puedes llegar por la vía legal. | `/cobrar-impagados` |
| conciliar-banco | Comando / | Cuadra el extracto del banco con tus facturas y gastos del periodo y te saca la lista exacta de apuntes que no encajan y qué hacer con cada uno. | `/conciliar-banco` |
| condiciones-de-cobro | Comando / | Diseña tus condiciones de pago y las escribe: anticipo, hitos, plazos, recargos y qué pasa si el cliente se retrasa o cancela. | `/condiciones-de-cobro` |
| factura | Comando / | Genera en 1 minuto el texto de una factura válida en España: número correlativo, datos de ambas partes, partidas, IVA y retención calculados, total y email de envío. | `/factura` |
| hucha-impuestos | Comando / | Calcula qué porcentaje de cada cobro tienes que apartar para IVA, IRPF y cuota, y monta el sistema de cuentas separadas. | `/hucha-impuestos` |
| presupuesto-cliente | Comando / | Redacta un presupuesto en tabla con partidas, IVA y total, tres opciones de precio, condiciones, el email de envío y respuestas si te piden rebaja. | `/presupuesto-cliente` |
| presupuesto-condiciones | Comando / | Convierte una descripción rápida de un trabajo en un presupuesto listo para enviar, con alcance cerrado, lo que no entra, forma de pago, validez y condiciones de cambios y cancelación. | `/presupuesto-condiciones` |
| presupuesto-servicio-contable | Comando / | Genera un presupuesto por tramos para vender un servicio de llevanza contable y fiscal a un autónomo o pyme española, según su volumen de facturas y los modelos que necesita. | `/presupuesto-servicio-contable` |
| punto-muerto | Comando / | Calcula cuánto tienes que vender cada mes para no perder dinero y cuántas unidades o clientes son en tu caso. | `/punto-muerto` |
| recobro-impagos | Comando / | Monta el plan de reclamación de una factura impagada paso a paso, con los mensajes exactos y los plazos legales en España. | `/recobro-impagos` |
| rentabilidad-cliente | Comando / | Calcula cuánto ganas de verdad con cada cliente, contando las horas reales, los extras no facturados y los retrasos de pago. | `/rentabilidad-cliente` |
| rentabilidad-por-cliente | Comando / | Ordena tus clientes por lo que te dejan de verdad, contando horas ocultas y retrasos de pago, y decide a quién subir, a quién cuidar y a quién soltar. | `/rentabilidad-por-cliente` |
| subida-precios | Comando / | Prepara una subida de precios a tus clientes actuales: a quién, cuánto, cuándo y con qué carta, calculando cuántas bajas te puedes permitir. | `/subida-precios` |
| subir-precios-cartera | Comando / | Plan para subir precios a los clientes que ya tienes: a quién, cuánto, en qué orden y con qué carta, calculando cuántos puedes perder sin salir perdiendo. | `/subir-precios-cartera` |
| subir-tarifas | Comando / | Prepara la subida de precios completa: cuánto subir, a quién y cuándo, con la carta a clientes y las respuestas a las quejas que te van a llegar. | `/subir-tarifas` |
| factura-legal-espana | Skill | Comprueba que una factura lleva todos los datos que exige Hacienda y la corrige o la redacta desde cero. Para autónomos y pymes españolas que empiezan a facturar. | se activa sola cuando hace falta |
| finanzas-pyme | Skill | Reglas de finanzas para autónomos y pymes en España: margen por venta, tesorería, cobros, impuestos básicos, precios y qué medir cada mes. | se activa sola cuando hace falta |
| montar-invoiceshelf-para-clientes | Skill | Instala y configura InvoiceShelf para que un freelance o negocio pequeño haga sus facturas y controle pagos y gastos, y deja montado el cobro por ello. | se activa sola cuando hace falta |
| auditor-comisiones-cobro | Subagente | Subagente que calcula lo que te cuesta de verdad cobrar: comisiones de Stripe, PayPal, datáfono y plataformas, y qué método te conviene según el ticket. | pídele a Claude «usa el subagente auditor-comisiones-cobro» |
| buscador-agentes-papeleo | Subagente | Subagente que busca subagentes hechos por otras personas para contratos, facturas y papeleo, y los valora con pruebas antes de que instales nada. | pídele a Claude «usa el subagente buscador-agentes-papeleo» |
| conciliador-banco-facturas | Subagente | Subagente que cruza el extracto del banco con tus facturas emitidas y recibidas, y te dice qué está cobrado, qué falta y qué no cuadra. | pídele a Claude «usa el subagente conciliador-banco-facturas» |
| plan-de-cobros | Subagente | Subagente que ordena tus facturas impagadas por antigüedad y riesgo, y escribe la secuencia de reclamación completa hasta el aviso previo a lo legal. | pídele a Claude «usa el subagente plan-de-cobros» |
| rentabilidad-por-cliente | Subagente | Subagente que calcula lo que ganas o pierdes de verdad con cada cliente o proyecto, cruzando lo facturado con las horas y los gastos reales. | pídele a Claude «usa el subagente rentabilidad-por-cliente» |
| revisor-condiciones-de-cobro | Subagente | Revisa tus presupuestos y contratos: arregla las condiciones de pago para cobres antes y mejor. Una persona comprueba. | pídele a Claude «usa el subagente revisor-condiciones-de-cobro» |
| validador-de-facturas | Subagente | Revisa tus facturas antes de mandarlas: datos obligatorios, IVA, retención, numeración, casos especiales. Una persona comprueba. | pídele a Claude «usa el subagente validador-de-facturas» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
