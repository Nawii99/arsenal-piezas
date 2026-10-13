---
name: puesta-en-marcha-tienda-odoo
description: Guía por fases para dejar lista una tienda online en Odoo (catálogo, impuestos, pagos, envíos, stock, SEO y textos legales), con un pedido de prueba antes de abrir. Úsala cuando vayas a montar o revisar una tienda con la app de comercio electrónico de Odoo.
---

# Puesta en marcha de una tienda Odoo

## Qué hace
Te guía por la configuración de una tienda online en Odoo. Deja por escrito qué se decide en cada punto. Prepara la plantilla del catálogo, los textos SEO, los borradores legales y la lista de comprobación final.
Claude no ve tu Odoo. Tú haces los clics y le cuentas lo que ves, o le pasas capturas. Los nombres de los menús cambian entre versiones. Si Claude no está seguro de un menú, lo dice y te pide que lo compruebes en tu pantalla o en la ayuda oficial. No se inventa ajustes.

## Antes de empezar, pregunta
1. ¿Qué versión de Odoo es [VERSIÓN DE ODOO]? ¿Online, Odoo.sh o instalado por ti? ¿Community o Enterprise?
2. ¿Hay una base de datos de pruebas? Si no, se hace una copia antes de tocar nada. Si la tienda ya vende, no se toca producción hasta probar en la copia.
3. ¿Quién vende? Autónomo o sociedad. Península, Canarias, Ceuta o Melilla. Régimen de IVA: si eres minorista, puede aplicar recargo de equivalencia. Lo confirma tu gestor.
4. ¿Qué vendes? Productos físicos, digitales o servicios. Cuántos, aproximadamente. Si hay variantes (talla, color).
5. ¿A qué países vendes, y en qué idiomas y moneda?
6. ¿Cómo quieres cobrar? Tarjeta, Bizum, PayPal, transferencia, contra reembolso.
7. ¿Cómo envías? Tarifa fija, por peso, gratis a partir de [IMPORTE], recogida en tienda. ¿Con qué transportista?
8. ¿Dónde está el stock? Almacén propio, proveedor que envía directo (dropshipping) o ambos.
9. ¿Existen ya aviso legal, política de privacidad, cookies y condiciones de venta?

## Paso a paso (pide confirmación al terminar cada fase)
Fase 1. Base. Apps necesarias: sitio web, comercio electrónico, inventario, facturación y ventas. Datos de la empresa: nombre fiscal, NIF, dirección, logo. Idioma y moneda.
Fase 2. Impuestos. Comprueba que están el IVA general, reducido y superreducido y la posición fiscal que corresponda. Para particulares, muestra los precios con IVA incluido (ajuste de precios en los ajustes del sitio web). Si vendes a consumidores de otros países de la UE, pregunta al gestor por la ventanilla única de IVA (OSS) antes de abrir. Decide el gestor, no Claude.
Fase 3. Catálogo. Categorías, atributos y variantes. Para la plantilla de importación, exporta UN producto desde Odoo y usa ese archivo como modelo, porque las columnas dependen de la versión y del idioma. Claude rellena la plantilla con tus datos y marca lo que falta. Importa primero 5 productos como prueba.
Fase 4. Pagos. Activa el proveedor de pago en modo de prueba y haz un pedido de prueba. Después pasa al modo real. Si cobras por tu banco con Redsys (tarjetas y Bizum), comprueba si tu versión lo trae o necesita un módulo [VERIFICAR] y qué datos te da el banco. Lee las condiciones de tu pasarela antes de cobrar: puede retener o suspender cobros si faltan textos legales o política de devoluciones, o si vendes productos restringidos. Antes de abrir, haz un pedido real de pocos euros y devuélvelo. La comisión de ese pedido puede no reembolsarse [VERIFICAR].
Fase 5. Envíos. Crea los métodos de envío (precio fijo, según reglas, gratis a partir de [IMPORTE]), los países permitidos y los plazos que verá el cliente. Comprueba el coste real con el transportista. Que lo que cobras no sea menos de lo que pagas.
Fase 6. Stock y entrega. Qué pasa sin stock: seguir vendiendo o bloquear. Si se muestra la cantidad disponible. Rutas de entrega: 1 paso, se envía directo desde el stock. 2 pasos, preparar y enviar. 3 pasos, preparar, empaquetar y enviar [VERIFICAR el nombre en tu versión]. Factura automática tras el pago, si la quieres. En dropshipping, revisa la app y las rutas.
Fase 7. SEO. Por producto y categoría: título, descripción, texto alternativo de imágenes y dirección legible. No pegues las descripciones del proveedor tal cual (contenido duplicado). Revisa el mapa del sitio y el archivo robots. No se prometen posiciones en Google.
Fase 8. Textos legales (España). Antes de redactar, repite al usuario sus respuestas de las preguntas 3, 4 y 5 (autónomo o sociedad, zona fiscal y régimen de IVA, tipo de producto y países de venta) y pide que las confirme. Avisa de que el borrador depende del tipo de producto y del país de venta.
- Aviso legal con los datos del titular (LSSI). Política de privacidad (RGPD). Política de cookies con aviso que permita rechazar tan fácil como aceptar. Condiciones de venta.
- Desistimiento: información de 14 días naturales con formulario, como regla general [VERIFICAR con tu gestor o abogado]. La Directiva (UE) 2023/2673 añade una función de desistimiento en línea (un botón) para contratos online, aplicable desde junio de 2026 [VERIFICAR con tu gestor o abogado si ya es obligatoria en España y cómo la soporta tu versión de Odoo].
- Productos digitales, servicios y artículos a medida tienen reglas de desistimiento distintas. Usa la respuesta de la pregunta 4 y márcalo [VERIFICAR con tu gestor o abogado].
- Garantía legal [VERIFICAR años vigentes para bienes nuevos]. Precio con IVA y gastos de envío visibles antes de pagar. Botón de compra que indique obligación de pago. Si anuncias rebajas, el precio anterior de referencia es el más bajo de los últimos 30 días [VERIFICAR con tu asesor].
- Claude da borradores marcados «borrador para revisión». Los valida tu gestor o abogado.
Fase 9. Facturación. Serie de facturas y datos obligatorios. Pregunta a tu gestor qué fecha te afecta de la normativa antifraude de facturación (Veri*Factu) y si tu versión de Odoo la cumple [VERIFICAR].
Fase 10. Prueba final, de principio a fin, con la lista de comprobación de abajo.

## Lista de comprobación antes de abrir
- Hay copia de seguridad de la base de datos.
- Pedido de prueba con cada método de pago y cada método de envío.
- Llega el email de confirmación y es correcto.
- La factura sale con el IVA correcto.
- El stock baja y se genera la entrega.
- Devolución o reembolso de prueba hecho.
- La compra completa funciona desde el móvil.
- Los enlaces legales se ven en el pie de página.
- Los precios se muestran con IVA y los gastos de envío se ven antes de pagar.

## Qué devolver
- Documento de decisiones: punto | decisión | quién la tomó | pendiente.
- Plantilla de catálogo con 3 filas de ejemplo.
- Tabla SEO: producto | título | descripción | texto alternativo de la imagen.
- Borradores legales marcados.
- Lista de comprobación con casillas.
- Lista de pendientes para el gestor o el abogado.

## Qué NO hacer
- No toques producción sin copia de seguridad y sin tu visto bueno.
- No actives pagos reales hasta que el pedido de prueba funcione.
- No inventes menús, ajustes ni módulos. Si no estás seguro, dilo.
- No decidas impuestos ni régimen fiscal. Propón y que lo confirme el gestor.
- No copies textos legales de otra web: pueden no encajar y tienen derechos de autor.
- No prometas posicionamiento ni ventas.
- No pidas ni guardes claves de la pasarela de pago en el chat.
- No importes cientos de productos de golpe sin probar antes con 5.
- No instales módulos de terceros que no conozcas. En Odoo Online no se pueden añadir módulos propios [VERIFICAR].
- No abras la tienda sin un pedido de prueba completo.
