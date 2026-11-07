# arsenal-finanzas-cobros · Finanzas · Facturas y cobros

Finanzas · Facturas y cobros: 4 subagentes, 3 comandos /, 3 skills en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-finanzas-cobros@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| cobrar-impagados | Comando / | Monta el plan completo para cobrar una factura que no te pagan: qué escribir, cuándo, con qué tono y hasta dónde puedes llegar por la vía legal. | `/cobrar-impagados` o `/arsenal-finanzas-cobros:cobrar-impagados` |
| conciliar-banco | Comando / | Cuadra el extracto del banco con tus facturas y gastos del periodo y te saca la lista exacta de apuntes que no encajan y qué hacer con cada uno. | `/conciliar-banco` o `/arsenal-finanzas-cobros:conciliar-banco` |
| factura | Comando / | Genera en 1 minuto el texto de una factura válida en España: número correlativo, datos de ambas partes, partidas, IVA y retención calculados, total y correo de envío. | `/factura` o `/arsenal-finanzas-cobros:factura` |
| factura-legal-espana | Skill | Comprueba que una factura lleva todos los datos que exige Hacienda y la corrige o la redacta desde cero. Para autónomos y pymes españolas que empiezan a facturar. | se activa sola cuando hace falta |
| ingresos-devengados-saas | Skill | Reparte mes a mes los ingresos de suscripciones y servicios de un SaaS, calcula lo facturado, lo reconocido y lo diferido, y separa los casos dudosos para que los resuelva tu contable. | se activa sola cuando hace falta |
| montar-invoiceshelf-para-clientes | Skill | Instala y configura InvoiceShelf para que un freelance o negocio pequeño haga sus facturas y controle pagos y gastos, y deja montado el cobro por ello. | se activa sola cuando hace falta |
| auditor-comisiones-cobro | Subagente | Subagente que calcula lo que te cuesta de verdad cobrar: comisiones de Stripe, PayPal, datáfono y plataformas, y qué método te conviene según el ticket. | pídele a Claude «usa el subagente auditor-comisiones-cobro» |
| plan-de-cobros | Subagente | Subagente que ordena tus facturas impagadas por antigüedad y riesgo, y escribe la secuencia de reclamación completa hasta el aviso previo a lo legal. | pídele a Claude «usa el subagente plan-de-cobros» |
| revisor-condiciones-de-cobro | Subagente | Revisa tus presupuestos y contratos: arregla las condiciones de pago para cobres antes y mejor. Una persona comprueba. | pídele a Claude «usa el subagente revisor-condiciones-de-cobro» |
| revisor-facturas | Subagente | Revisa una factura, una plantilla o la configuración de facturación de Stripe y te dice qué le falta para ser válida en España: numeración, NIF, IVA desglosado, retención IRPF y menciones. | pídele a Claude «usa el subagente revisor-facturas» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
