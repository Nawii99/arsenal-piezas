# Pedido de prueba de punta a punta…

**Tipo:** Prompt · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Guion para hacerte un pedido falso a ti mismo y seguir el rastro completo: cobro, email, factura, stock, aviso al proveedor, devolución y reembolso.

## Qué es y qué hace

Prompt que genera un guion para hacerte un pedido de prueba y seguir toda la cadena. Entran plataforma, forma de cobro, IVA y automatizaciones; sale una lista de comprobaciones de cobro, emails, factura, stock, aviso al proveedor, devolución y reembolso. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Rellena los [corchetes] con tu tienda
3. Haz el pedido de prueba y marca cada comprobación
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando vayas a abrir una tienda o cambies pasarela de pago, plantilla de email, envíos o precios, y necesites comprobar que la venta completa funciona de verdad.

## Cómo ganar dinero con ella

Detecta el pedido que se cobra pero no avisa a nadie, o el IVA mal aplicado, antes de que te cueste devoluciones, reclamaciones y reseñas de una estrella.

- Prueba de punta a punta antes del lanzamiento de tiendas online…
- Revisión de flujo de pedidos tras cambiar pasarela o plantillas…
- Informe de verificación de ventas y reembolsos para tiendas de clientes…

**Precio orientativo:** 100–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como responsable de operaciones de comercio electrónico. Has puesto en marcha decenas de tiendas pequeñas y sabes que el 90% de los desastres no están en la web, sino en lo que ocurre después del clic de pagar.

MI SITUACIÓN
- Dónde vendo: [SHOPIFY / WOOCOMMERCE / LANDING CON STRIPE / ETSY / OTRA]
- Qué vendo: [PRODUCTO FÍSICO / DIGITAL / SERVICIO CON CITA / SUSCRIPCIÓN]
- Precio y si lleva IVA incluido: [PRECIO] y [IVA INCLUIDO / SE SUMA AL FINAL]
- Cómo cobro: [STRIPE / PAYPAL / BIZUM / TRANSFERENCIA / CONTRA REEMBOLSO]
- Qué pasa automáticamente tras el pago (lo que yo creo): [EMAILS, FACTURA, AVISO A PROVEEDOR, ETIQUETA DE ENVÍO, ALTA EN UNA LISTA]
- Herramientas conectadas: [MAILCHIMP, MAKE, ZAPIER, HOJA DE CÁLCULO, WHATSAPP, NINGUNA]
- Envíos: [TRANSPORTISTA] y zonas [PENÍNSULA / BALEARES / CANARIAS / EUROPA]
- Cupones o descuentos activos: [LISTA O NINGUNO]

LO QUE TIENES QUE HACER
1. Dibuja en texto la cadena completa del pedido, paso a paso, desde que alguien entra hasta que el dinero está en mi cuenta y el producto en su casa. Marca en cada eslabón quién lo ejecuta: la web, una automatización, un tercero o yo a mano.
2. En cada eslabón, dime el rastro comprobable: qué correo, qué línea en qué panel, qué fila de qué hoja o qué mensaje debería aparecer, y dónde lo miro exactamente.
3. Escríbeme el guion de 4 pedidos de prueba distintos, no uno solo: (a) pedido normal con tarjeta real de importe mínimo, (b) pedido con cupón y con dirección de una zona con IVA o envío distinto, (c) pedido que falla a propósito (tarjeta rechazada o cerrar la pestaña en la pantalla de pago), (d) pedido que luego devuelvo y reembolso entero.
4. Para el pedido (c) explícame qué NO debe pasar: no debe descontar stock, no debe enviar email de gracias, no debe avisar al proveedor. Los pedidos fantasma son el fallo más caro y más silencioso.
5. Dame la comprobación de dinero: qué importe sale en la pasarela, qué comisión se lleva, qué me queda y cómo cuadrar eso con lo que dice mi tienda. Señala dónde suelen aparecer descuadres.
6. Dame la comprobación legal y fiscal básica en España a nivel de tienda: que la factura o justificante lleva mis datos fiscales, número correlativo, base imponible, tipo de IVA y total; que existe información de desistimiento de 14 días; y que el cliente recibe las condiciones. No des asesoría fiscal, solo el checklist de lo que debe aparecer.
7. Dime cómo dejar todo limpio después: cancelar los pedidos de prueba, devolver el stock, borrar el contacto de las listas y no ensuciar mis estadísticas.

RESTRICCIONES
- Todo con importes mínimos reales, nunca con modo de prueba únicamente: el modo de prueba oculta justo los fallos de comisiones, impuestos y avisos.
- No inventes nombres de menús concretos si no estás seguro de mi plataforma; describe qué busco y dónde suele estar.
- No prometas cumplimiento legal: enumera comprobaciones, no dictámenes.

FORMATO DE RESPUESTA
1) Mapa de la cadena del pedido, eslabón a eslabón, con el rastro a comprobar en cada uno.
2) Cuatro guiones de pedido, cada uno con: preparación, pasos exactos, qué debe ocurrir, qué NO debe ocurrir, y dónde lo verifico.
3) Tabla de descuadres típicos: síntoma | causa habitual | cómo lo confirmo.
4) Checklist de limpieza posterior.
5) «Semáforo de apertura»: 8 puntos que, si están todos en verde, puedo abrir la tienda con tranquilidad.

CRITERIOS DE CALIDAD
- Cada comprobación dice dónde mirar y qué valor exacto debería ver.
- Incluye siempre el caso del pago fallido y el de la devolución; si los omites, la respuesta es inútil.
- Lenguaje llano: si usas un término del oficio, explícalo en la misma línea entre paréntesis.
- Máximo dos páginas de lectura. Empieza por el apartado 1.
```
