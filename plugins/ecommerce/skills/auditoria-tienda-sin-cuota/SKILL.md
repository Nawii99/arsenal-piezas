---
name: auditoria-tienda-sin-cuota
description: Audita si un negocio puede vender online sin pagar cuota mensual de plataforma (Stripe + carrito ligero en vez de Shopify) y calcula cuánto cobrarle por montársela. Se activa cuando alguien dice "quiero una tienda online barata" o "móntame algo sin mensualidad".
---

## Qué hace
Revisa el catálogo, el volumen de ventas esperado y el nivel técnico del cliente, y decide entre tres montajes: página de producto suelta con enlace de pago de Stripe, carrito ligero (Snipcart, Gumroad o similar) sobre una web ya existente, o recomendar que sí necesita una plataforma con cuota (Shopify) porque el catálogo es grande.

## Antes de empezar, pregunta
- Cuántos productos va a vender y si cambian mucho de precio o stock.
- Si ya tiene una web (WordPress, Webflow, HTML a mano) o no tiene nada.
- Si necesita facturar con IVA español y si es autónomo o sociedad.
- Si va a vender fuera de España (afecta al IVA y a las comisiones de Stripe).
- Cuánto espera facturar al mes, aunque sea una estimación.

## Paso a paso
1. Con el volumen esperado, calcula el coste real: comisión de Stripe (aprox. 1,4% + 0,25€ en tarjetas europeas, más en internacionales) frente a la cuota fija de una plataforma con mensualidad.
2. Si el cliente vende menos de [20] referencias y no cambia precios a diario, propone Payment Links de Stripe o Stripe Checkout embebido en su web actual: coste cero de plataforma, solo comisión por venta.
3. Si tiene entre [20] y [200] referencias con variantes (talla, color), propone un carrito ligero tipo Snipcart o Gumroad sobre su web actual, con pago solo por comisión y no por cuota.
4. Si supera eso, o necesita gestión de stock e impuestos automática por país, dile con claridad que sin cuota mensual no le compensa y que necesita Shopify u otra plataforma de pago.
5. Calcula el presupuesto de montaje: horas estimadas de trabajo tuyas más un margen, no le cobres por "la plataforma" porque no la hay.
6. Deja por escrito qué mantenimiento necesita después (actualizar productos, revisar pagos fallidos) y si eso lo cobras aparte como servicio mensual.

## Qué devolver
Un resumen en texto plano con: montaje recomendado, coste de comisión estimado al mes, presupuesto de horas y precio de montaje en euros, y si procede, precio del mantenimiento mensual como servicio aparte (esto sí puede llevar cuota, es tu servicio, no el de la plataforma).

## Qué NO hacer
- No prometas "cero comisiones": Stripe siempre cobra algo por transacción, dilo en euros o porcentaje real, nunca lo escondas.
- No recomiendes saltarte los términos de Stripe (cuentas falsas, verificación cruzada) para evitar el KYC: puede acabar en cuenta bloqueada y fondos retenidos.
- No factures como si fueras tú quien cobra al cliente final: el dinero pasa por la cuenta de Stripe del cliente, tú facturas solo tu servicio de montaje.
- No dejes sin avisar que si el negocio crece, este montaje se queda corto y habrá que migrar a otra plataforma.
