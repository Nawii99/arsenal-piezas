# arsenal-ecommerce · Tienda por internet

Tienda por internet: 8 skills, 7 comandos /, 5 subagentes en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-ecommerce@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| asiento-cmd-devoluciones | Comando / | Agrupa devoluciones por causa real, pone coste, propone arreglo barato de cada una y avisa si chocaría con derechos del cliente. | `/asiento-cmd-devoluciones` |
| asiento-cmd-precio | Comando / | Calcula precio de venta restando hacia atrás: IVA, pasarela, envío, embalaje, devoluciones, enseña margen que queda de verdad. | `/asiento-cmd-precio` |
| auditoria-legal-tienda | Comando / | Pegas los textos legales que ya tiene tu tienda (o dices que no tienes ninguno) y te devuelve qué falta, qué está mal y en qué orden arreglarlo. | `/auditoria-legal-tienda` |
| elegir-pasarela-pago | Comando / | Compara Stripe, PayPal y Redsys para una tienda pequeña y recomienda una según el país, el volumen de ventas y si el usuario tiene cuenta de empresa, sin inventar comisiones. | `/elegir-pasarela-pago` |
| pagina-producto | Comando / | Genera el HTML de una página de producto autoalojable, sin plantilla de pago, con el botón de compra enlazado a un Payment Link de Stripe ya creado. | `/pagina-producto` |
| presupuesto-tienda-sin-cuota | Comando / | Genera un presupuesto en texto listo para enviar, a partir de los datos de un cliente que quiere una tienda online sin cuota mensual montada con Stripe y un carrito ligero. | `/presupuesto-tienda-sin-cuota` |
| responder-devolucion | Comando / | Pegas el mensaje del cliente que quiere devolver algo y te devuelve la respuesta lista para enviar, aplicando bien los plazos del derecho de desistimiento. | `/responder-devolucion` |
| asiento-tienda-legal | Skill | Lista de comprobación de lo que le falta a tienda antes de abrir en España: textos legales, precios, envío, devolución, datos personales. | se activa sola cuando hace falta |
| auditoria-legal-tienda-online | Skill | Revisa los textos legales de una tienda online española y genera un informe de fallos listo para entregar a un cliente y cobrarlo como servicio de auditoría. | se activa sola cuando hace falta |
| auditoria-tienda-sin-cuota | Skill | Audita el negocio de un cliente y decide si le monta una tienda online sin cuota mensual (Stripe + carrito ligero) o si necesita una plataforma de pago con mensualidad. | se activa sola cuando hace falta |
| ficha-producto-ecommerce | Skill | Genera la ficha completa de un producto (título, descripción, bullets, FAQ y SEO) a partir de datos sueltos, para no escribirla desde cero cada vez que subes un producto. | se activa sola cuando hace falta |
| optimizacion-de-tienda-skill-guiada | Skill | Cada cambio en la tienda pasa por el mismo filtro: qué problema resuelve, quién se beneficia, cómo medimos si funcionó. | se activa sola cuando hace falta |
| redactar-ficha-producto-ecommerce | Skill | Escribe título, descripción, bullets y llamada a la acción de un producto para pegar en Stripe o en un carrito ligero, sin inventar datos que luego generan reclamaciones. | se activa sola cuando hace falta |
| textos-legales-tienda | Skill | Genera los cuatro textos legales que toda tienda online española necesita: aviso legal, condiciones de venta, política de devoluciones y política de privacidad. | se activa sola cuando hace falta |
| textos-legales-tienda-online | Skill | Redacta los cuatro textos legales obligatorios de una tienda online en España (aviso legal, condiciones de venta, devoluciones y privacidad) a partir de los datos reales de tu negocio. | se activa sola cuando hace falta |
| asiento-revisor-tienda | Subagente | Subagente que revisa tienda buscando lo que hace perder ventas o genera reclamaciones, ordenado por coste y arreglo mínimo. | pídele a Claude «usa el subagente asiento-revisor-tienda» |
| auditor-tienda-sin-cuota | Subagente | Revisa pasarela de pago, carrito, ficha de producto y textos legales de una tienda pequeña antes de abrir, y marca qué falta o qué es un riesgo real. | pídele a Claude «usa el subagente auditor-tienda-sin-cuota» |
| comercial-tiendas-sin-cuota | Subagente | Atiende a un lead que quiere montar una tienda online sin cuota mensual, lo cualifica con preguntas concretas y redacta un presupuesto en euros que revisa una persona antes de enviarlo. | pídele a Claude «usa el subagente comercial-tiendas-sin-cuota» |
| optimizacion-de-tienda-subagente-revisor | Subagente | Cuéntale dónde está la tienda: diagnóstico de lo que no funciona, cambios propuestos, experimento para medir y métricas. | pídele a Claude «usa el subagente optimizacion-de-tienda-subagente-revisor» |
| revisor-pedidos-stripe | Subagente | Revisa el listado de pedidos de Stripe y separa en segundos lo que necesita acción hoy (pagos fallidos, disputas, duplicados) de lo que ya está resuelto. | pídele a Claude «usa el subagente revisor-pedidos-stripe» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
