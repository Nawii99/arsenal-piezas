---
name: presupuesto-tienda-sin-cuota
description: Genera, a partir de unos datos rápidos del cliente, un presupuesto en texto listo para enviar por montar una tienda online sin cuota mensual (Stripe + carrito ligero). Úsalo cuando ya tienes los datos y solo falta redactar el presupuesto.
---

## Qué hace
Toma los datos que le pases del cliente y devuelve el presupuesto ya redactado, en euros, sin que tengas que escribirlo cada vez desde cero.

## Qué necesita que le des (pégalo al invocar el comando)
- Número de productos y si tienen variantes (talla, color).
- Si ya tiene web o hay que crearla.
- Tu tarifa por hora y las horas estimadas del proyecto.
- Si el cliente quiere mantenimiento mensual contratado o solo el montaje puntual.

## Paso a paso
1. Con el número de productos, elige el montaje: Payment Link suelto (catálogo pequeño), carrito ligero (catálogo mediano con variantes) o avisa de que se sale del alcance de este servicio.
2. Multiplica horas estimadas por tarifa para sacar el precio del montaje único.
3. Si hay mantenimiento, añade una segunda partida mensual aparte, con lo que incluye (cambios de precio, alta de productos nuevos, revisión de pagos fallidos).
4. Añade siempre una línea aclarando que la comisión de Stripe por cobro (no es cuota, es por venta) la paga el cliente a Stripe, no a ti.
5. Redacta el presupuesto en un bloque de texto plano en español de España, con IVA indicado si el que factura es autónomo o empresa española.

## Qué devolver
Un bloque de texto con: descripción breve del montaje, precio del montaje único con IVA si aplica, precio del mantenimiento mensual si lo pidió, y la nota de la comisión de Stripe. Nada de tablas complicadas, listo para copiar y pegar en un email.

## Qué NO hacer
- No pongas un precio si faltan datos: deja el hueco entre corchetes, por ejemplo [PRECIO A CONFIRMAR], en vez de inventarlo.
- No incluyas la comisión de Stripe como parte de tu factura: es un cobro aparte que hace Stripe directamente al cliente.
- No generes el presupuesto en un idioma o formato distinto al que pida quien lo va a enviar.
