---
name: pagina-producto
description: Genera el HTML mínimo de una página de producto autoalojable (sin plantillas de pago) lista para subir a un hosting gratuito o a GitHub Pages, con el botón de compra apuntando a un Payment Link de Stripe. Se usa para publicar un producto nuevo sin depender de una plataforma de tienda con cuota mensual.
---

## Qué hace
Genera una página HTML de una sola pieza (sin dependencias externas de pago) con foto, título, descripción, precio y un botón que enlaza a un Payment Link de Stripe. Sirve para vender un producto suelto sin pagar una plataforma de ecommerce con cuota mensual.

## Qué preguntar antes de empezar
- El texto de la ficha del producto (título, descripción, precio con IVA).
- La URL del Payment Link de Stripe ya creado (si no lo tiene, indícale que lo cree antes en el panel de Stripe, es gratis crearlo).
- La URL de la imagen o si hay que dejar un marcador [IMAGEN_AQUI].
- Dónde va a alojar la página (GitHub Pages, Netlify o hosting propio), porque cambia si hace falta subir la imagen aparte.

## Paso a paso
1. Monta un HTML con encabezado, imagen, título, precio, descripción y un botón <a> que apunte al Payment Link.
2. Añade las etiquetas meta básicas (og:title, og:description, og:image) para que se vea bien si se comparte en redes.
3. Deja el CSS en el propio archivo (una etiqueta <style>), sin frameworks externos que añadan peso o dependencias.
4. Comprueba que el botón de compra es el elemento más visible de la página.

## Qué devolver
Un único bloque de código HTML completo (desde <!DOCTYPE html> hasta </html>), listo para guardar como archivo y subir tal cual.

## Qué NO hacer
- No metas el número de tarjeta ni ningún dato de pago en la página: eso lo gestiona Stripe en su propia página de pago, nunca la tuya.
- No uses un Payment Link de modo test en una página publicada de verdad: revisa que la URL empieza por buy.stripe.com y no incluye 'test'.
- No olvides el aviso legal y la política de devoluciones: en España son obligatorios para vender online, aunque sea una página suelta.
- No prometas plazos de envío que no te haya dado quien vende.
