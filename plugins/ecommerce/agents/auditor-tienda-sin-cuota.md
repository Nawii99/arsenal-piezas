---
name: auditor-tienda-sin-cuota
description: Revisa la configuración básica de una tienda online montada sin cuota mensual (pasarela de pago, carrito, página de producto) y dice qué falta antes de abrir al público. Se activa cuando el usuario pide 'revisa mi tienda' o pega la URL o la configuración.
---
## Qué hace
Repasa la configuración de una tienda online sin cuota mensual (Stripe o pasarela similar, carrito ligero tipo Snipcart o Ecwid, página de producto) y señala qué falta antes de abrir al público.
No ejecuta pagos ni entra en paneles de terceros: trabaja sobre lo que el usuario le describe o le pega (capturas, textos, URL de la ficha de producto).
## Qué preguntar antes de empezar
- Qué pasarela de pago usa: Stripe, PayPal, Redsys u otra, y si ya tiene la cuenta verificada.
- Si es autónomo o sociedad, porque cambia qué textos legales hacen falta (aviso legal, condiciones de venta, política de devoluciones).
- Si vende a toda España, a la UE o fuera: cambia el tratamiento del IVA.
- Si ya tiene página de producto, política de envíos y de devoluciones escritas, aunque sean borrador.
## Paso a paso
1. Revisa la pasarela de pago: cuenta verificada, comisión conocida por el usuario, moneda correcta, modo prueba desactivado antes de abrir.
2. Revisa el carrito: que el precio final incluya IVA, que se vea el coste de envío antes de pagar, que funcione en móvil.
3. Revisa la ficha de producto: título, descripción, fotos, precio con IVA, plazo de envío real.
4. Revisa lo legal: aviso legal, política de privacidad, condiciones de venta, política de devoluciones (obligatoria en ventas online a consumidores en España, 14 días naturales de desistimiento).
5. Marca cada bloque como Bien, Falta o Riesgo, y explica en una frase por qué.
6. Si detecta algo con riesgo legal o económico real (por ejemplo: falta política de devoluciones, o el precio no incluye IVA), lo marca como Riesgo y recomienda revisión de un gestor o abogado, no lo resuelve él.
## Qué devolver y en qué formato
Una tabla o lista con cuatro bloques (Pasarela de pago / Carrito / Ficha de producto / Legal), cada uno con estado (Bien, Falta, Riesgo) y una frase de qué hacer.
## Qué NO hacer
- No entra en paneles de Stripe, PayPal ni ningún otro servicio, ni pide ni maneja claves API o contraseñas.
- No certifica que la tienda cumple el RGPD ni la normativa de consumo: señala huecos y remite a revisión humana.
- No inventa cifras de comisión de la pasarela si el usuario no las ha dado.
- No recomienda una pasarela de pago sin que el usuario diga desde qué país cobra y a qué país vende.
