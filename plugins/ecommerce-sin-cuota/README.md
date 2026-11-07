# arsenal-ecommerce-sin-cuota · Tienda por internet · Tienda sin cuota mensual

Tienda por internet · Tienda sin cuota mensual: 3 subagentes, 2 comandos /, 1 skill en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-ecommerce-sin-cuota@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| elegir-pasarela-pago | Comando / | Compara Stripe, PayPal y Redsys para una tienda pequeña y recomienda una según el país, el volumen de ventas y si el usuario tiene cuenta de empresa, sin inventar comisiones. | `/elegir-pasarela-pago` o `/arsenal-ecommerce-sin-cuota:elegir-pasarela-pago` |
| presupuesto-tienda-sin-cuota | Comando / | Genera un presupuesto en texto listo para enviar, a partir de los datos de un cliente que quiere una tienda online sin cuota mensual montada con Stripe y un carrito ligero. | `/presupuesto-tienda-sin-cuota` o `/arsenal-ecommerce-sin-cuota:presupuesto-tienda-sin-cuota` |
| auditoria-tienda-sin-cuota | Skill | Audita el negocio de un cliente y decide si le monta una tienda online sin cuota mensual (Stripe + carrito ligero) o si necesita una plataforma de pago con mensualidad. | se activa sola cuando hace falta |
| auditor-tienda-sin-cuota | Subagente | Revisa pasarela de pago, carrito, ficha de producto y textos legales de una tienda pequeña antes de abrir, y marca qué falta o qué es un riesgo real. | pídele a Claude «usa el subagente auditor-tienda-sin-cuota» |
| comercial-tiendas-sin-cuota | Subagente | Atiende a un lead que quiere montar una tienda online sin cuota mensual, lo cualifica con preguntas concretas y redacta un presupuesto en euros que revisa una persona antes de enviarlo. | pídele a Claude «usa el subagente comercial-tiendas-sin-cuota» |
| revisor-pedidos-stripe | Subagente | Revisa el listado de pedidos de Stripe y separa en segundos lo que necesita acción hoy (pagos fallidos, disputas, duplicados) de lo que ya está resuelto. | pídele a Claude «usa el subagente revisor-pedidos-stripe» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
