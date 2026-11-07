# arsenal-negocio-precios · Negocio · Precios y oferta

Negocio · Precios y oferta: 6 subagentes, 6 skills, 5 comandos / en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-negocio-precios@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| asiento-cmd-precio | Comando / | Calcula precio de venta restando hacia atrás: IVA, pasarela, envío, embalaje, devoluciones, enseña margen que queda de verdad. | `/asiento-cmd-precio` o `/arsenal-negocio-precios:asiento-cmd-precio` |
| descuento-seguro | Comando / | Calcula hasta qué descuento puedes hacer sin perder dinero y cuánto más tendrías que vender para compensarlo, con la respuesta lista para el regateo. | `/descuento-seguro` o `/arsenal-negocio-precios:descuento-seguro` |
| precio-servicio | Comando / | Calcula tu precio mínimo con la cuenta, el rango de mercado y el precio por valor. Te propone 3 niveles y cómo defenderlos cuando te digan que es caro. | `/precio-servicio` o `/arsenal-negocio-precios:precio-servicio` |
| presupuesto-condiciones | Comando / | Convierte una descripción rápida de un trabajo en un presupuesto listo para enviar, con alcance cerrado, lo que no entra, forma de pago, validez y condiciones de cambios y cancelación. | `/presupuesto-condiciones` o `/arsenal-negocio-precios:presupuesto-condiciones` |
| presupuesto-servicio-contable | Comando / | Genera un presupuesto por tramos para vender un servicio de llevanza contable y fiscal a un autónomo o pyme española, según su volumen de facturas y los modelos que necesita. | `/presupuesto-servicio-contable` o `/arsenal-negocio-precios:presupuesto-servicio-contable` |
| calendario-precios-alquiler-turistico | Skill | Te prepara un calendario de precios noche a noche para una vivienda de alquiler de corta duración, con un precio mínimo calculado con tus costes y reglas de ajuste que aplicas tú. | se activa sola cuando hace falta |
| cuentas-claras-margen-producto | Skill | Ordena ingresos, gastos y precios de tu tienda a partir de exportaciones (Stripe, banco, hoja de cálculo) y estima cuánto te queda por producto, antes de impuestos. | se activa sola cuando hace falta |
| disenar-planes-de-suscripcion | Skill | Cuántos planes, qué llevan, precio: cuentas de suscriptores que hacen falta para cuadrar. | se activa sola cuando hace falta |
| plan-precios-cobro-y-bajas | Skill | Diseña los precios, el cobro con Stripe y el plan contra las bajas de un producto o servicio de pago recurrente, partiendo de tus costes reales. | se activa sola cuando hace falta |
| revisor-estudios-de-precio | Skill | Comprueba si un estudio de sensibilidad al precio es fiable, calcula el rango de precios que sostienen los datos y propone una prueba real antes de cambiar nada. | se activa sola cuando hace falta |
| tarifas-y-canales-alojamientos | Skill | Analiza tus datos de ocupación y precios, propone cambios de tarifa por fechas según demanda y competencia, y compara cuánto te deja de verdad cada canal de venta. | se activa sola cuando hace falta |
| calculadora-cambio-de-precio | Subagente | Calcula con tus números qué pasa con el beneficio si subes, bajas o reposicionas un precio, y cuántas ventas puedes perder antes de salir perdiendo. | pídele a Claude «usa el subagente calculadora-cambio-de-precio» |
| plan-subida-de-precios | Subagente | Subagente que planifica una subida de precios: a quién, cuánto, cuándo, con qué carta y qué pasa si se te va parte de la cartera. | pídele a Claude «usa el subagente plan-subida-de-precios» |
| radiografia-rentabilidad-catalogo | Subagente | Calcula cuánto deja cada producto o servicio de tu catálogo después de costes, comisiones y devoluciones, y propone qué subir, agrupar, vigilar o dejar de reponer. | pídele a Claude «usa el subagente radiografia-rentabilidad-catalogo» |
| revisor-ingresos-precios-promos | Subagente | Analiza tus ventas, costes y descuentos para decir qué productos y clientes dejan beneficio real y qué pruebas de precio merecen la pena. | pídele a Claude «usa el subagente revisor-ingresos-precios-promos» |
| revisor-precios-paquetes | Subagente | Precios revisados: mínimo sin perder dinero, paquetes, respuestas para negociar descuentos. | pídele a Claude «usa el subagente revisor-precios-paquetes» |
| revisor-precios-prueba-controlada | Subagente | Calcula cuánto ganas de verdad por venta en cada canal y tipo de cliente, y te propone una prueba pequeña de precios antes de cambiar nada. | pídele a Claude «usa el subagente revisor-precios-prueba-controlada» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
