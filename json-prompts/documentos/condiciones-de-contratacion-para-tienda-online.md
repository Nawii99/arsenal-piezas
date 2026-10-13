# Condiciones de contratación para tienda online…

**Tipo:** JSON prompt · **Área:** Documentos · **Licencia:** CC BY 4.0

Redacta las condiciones de venta de tu tienda: precios, pago, envíos, devoluciones de 14 días, garantías y reclamaciones.

## Qué es y qué hace

Plantilla JSON que redacta las condiciones generales de contratación de una tienda online española que vende a consumidores. Recibe los datos del vendedor, qué vendes, precios con IVA, métodos de pago, envíos, devoluciones de 14 días, garantía legal y excepciones de desistimiento, y devuelve el texto en el orden de identificación, objeto, proceso de compra, precios, pago y garantías. Funciona con Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Rellena datos del vendedor, envíos y devoluciones
2. Marca las excepciones de desistimiento que aplican
3. Pide el texto ordenado por apartados
4. Que lo revise un profesional.

## Cuándo usarla

Úsalo cuando montes una tienda online o vendas servicios por internet y necesites las condiciones que exige la ley de consumidores.

## Cómo ganar dinero con ella

Reduce discusiones y devoluciones conflictivas porque las reglas quedan claras antes de comprar, y evita multas por informar mal.

- Condiciones de compra para tiendas de Shopify o WooCommerce, con revisión de cada apartado antes de publicar.
- Adaptación de condiciones para vender servicios o productos digitales junto a productos físicos.
- Actualización de condiciones de devolución cuando cambian plazos o transportistas.

**Precio orientativo:** 80–200 € por tienda. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Redactar las condiciones generales de contratación de una tienda online española que vende a consumidores",
  "vendedor": {
    "razon_social": "[NOMBRE O RAZÓN SOCIAL]",
    "nif": "[NIF O CIF]",
    "direccion": "[DIRECCIÓN]",
    "email_y_telefono": "[DATOS DE CONTACTO]"
  },
  "entradas": {
    "que_vendes": "[PRODUCTOS FÍSICOS / DIGITALES / SERVICIOS / SUSCRIPCIÓN]",
    "precios_e_iva": "[IVA INCLUIDO O NO, MONEDA]",
    "metodos_de_pago": "[TARJETA, BIZUM, PAYPAL, TRANSFERENCIA, CONTRAREEMBOLSO]",
    "envios": "[ZONAS, PLAZOS Y COSTES]",
    "devoluciones": "[QUIÉN PAGA EL PORTE DE DEVOLUCIÓN Y EN CUÁNTOS DÍAS DEVUELVES EL DINERO]",
    "garantia": "[GARANTÍA LEGAL 3 AÑOS Y GARANTÍA COMERCIAL SI LA HAY]",
    "excepciones_desistimiento": "[PRODUCTOS PERSONALIZADOS, PERECEDEROS, DIGITALES DESCARGADOS]"
  },
  "instrucciones": [
    "Ordena así: identificación, objeto, proceso de compra paso a paso, precios e impuestos, pago, entrega, desistimiento, garantías, atención al cliente, resolución de conflictos y ley aplicable",
    "Describe el proceso de compra con los pasos reales, incluida la confirmación del pedido por email y el aviso de que el pedido implica obligación de pago",
    "Explica el derecho de desistimiento de 14 días naturales, cómo ejercerlo y sus excepciones, e incluye el formulario de desistimiento tipo",
    "Recoge la garantía legal de conformidad de 3 años para bienes y el plazo de reparación o sustitución",
    "Menciona la plataforma europea de resolución de litigios en línea y la hoja de reclamaciones si procede",
    "Añade cláusulas de fuerza mayor, modificación de condiciones y protección de datos con enlace a la política de privacidad"
  ],
  "restricciones": [
    "Prohibidas las cláusulas abusivas: no reducir el plazo de desistimiento ni cobrar penalizaciones desproporcionadas",
    "No prometer plazos de entrega distintos de los declarados",
    "Precios siempre con indicación de si incluyen IVA y gastos de envío",
    "Deja en corchetes cualquier dato que no se haya facilitado"
  ],
  "formato_salida": {
    "bloque_1": "condiciones de contratación numeradas listas para publicar",
    "bloque_2": "formulario de desistimiento tipo",
    "bloque_3": "texto del email de confirmación de pedido con los datos obligatorios",
    "bloque_4": "checklist de lo que debe verse en el checkout antes de pagar"
  },
  "criterios_calidad": [
    "Aparecen desistimiento, garantía legal y datos de contacto sin ambigüedad",
    "El botón de pago se describe con la fórmula de pedido con obligación de pago",
    "Ninguna cláu
```
