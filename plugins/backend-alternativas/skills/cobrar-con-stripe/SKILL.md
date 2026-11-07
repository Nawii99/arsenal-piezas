---
name: cobrar-con-stripe
description: Monta cobros únicos y suscripciones con Stripe (Checkout, Portal de cliente, webhooks, IVA, facturas válidas en España). Úsala cuando el usuario quiera cobrar desde su web o app, aceptar tarjetas, vender suscripciones o generar facturas automáticas.
---

# Cobrar con Stripe

Objetivo: que el usuario cobre en producción con el mínimo código propio y sin guardar nunca datos de tarjeta. Stripe pone la página de pago, el portal de cliente y las facturas. Tú solo conectas piezas.

## Antes de escribir código, pregunta

1. ¿Cobro único o suscripción? Si suscripción: ¿mensual, anual o ambas? ¿Hay prueba gratis? ¿De cuántos días?
2. ¿Vendes a particulares, a empresas o a los dos? Cambia el IVA y la factura.
3. ¿Solo España, o también resto de la UE o fuera? Cambia el IVA y si hace falta Stripe Tax.
4. ¿Qué pasa cuando alguien paga? (dar acceso, enviar email, crear usuario...). Eso es lo que hará el webhook.
5. ¿Qué pila usa el proyecto? Mira el código antes de proponer nada. Si no hay proyecto, propón Next.js o Node + Express y explica por qué en dos frases.

Si el usuario no sabe responder a la 2 o la 3, dile que lo hable con su gestor antes de cobrar el primer euro. No adivines el régimen fiscal.

## Arquitectura que propones siempre

- Stripe Checkout (página de pago alojada por Stripe). Nada de formularios de tarjeta propios.
- Stripe Customer Portal para que el cliente cambie tarjeta, plan o cancele solo. Ahorra soporte.
- Un único endpoint de webhook que recibe los eventos de Stripe y actualiza tu base de datos.
- Productos y precios creados en el panel de Stripe, no a mano en código. El código solo usa el `price_id`.
- Facturas generadas por Stripe: activa `invoice_creation` en Checkout para pagos únicos; en suscripciones se generan solas.

## Paso a paso

1. Cuenta y claves. No le pidas que te pegue la clave secreta de prueba (`sk_test_...`): que la copie él mismo del panel a su `.env` (variable `STRIPE_SECRET_KEY`), nunca en el código, en el chat ni en el repo. Comprueba que `.env` está en `.gitignore`.
2. Productos. Explica cómo crear el producto y el precio en el panel de Stripe (modo prueba). Pide el `price_id` (`price_...`).
3. Checkout. Crea una ruta que abre una sesión de Checkout con ese `price_id`, `mode` `payment` o `subscription`, `success_url` y `cancel_url`. Para empresas activa `tax_id_collection` para pedir el NIF. Activa `customer_creation` para que siempre exista un cliente en Stripe.
4. Portal. Crea una ruta que genera un enlace al Customer Portal para el cliente logueado.
5. Webhook. Un endpoint que verifica la firma con `STRIPE_WEBHOOK_SECRET`, guarda el `event.id` para no procesar dos veces el mismo evento y responde 200 en menos de 5 segundos. Eventos mínimos: `checkout.session.completed`, `invoice.paid`, `invoice.payment_failed`, `customer.subscription.updated`, `customer.subscription.deleted`. En `checkout.session.completed` da acceso solo si `payment_status == 'paid'` (con métodos de pago diferidos el evento llega antes que el dinero: espera a `checkout.session.async_payment_succeeded`). Para montarlo y probarlo usa el comando `/webhook-stripe`.
6. Base de datos. Guarda por usuario: `stripe_customer_id`, `stripe_subscription_id`, `estado` (activa, impagada, cancelada) y `fin_periodo_actual`. El acceso al producto se decide con `estado`, nunca con el resultado de la página de éxito.
7. IVA. Si solo vendes en España a particulares: precio con IVA incluido (`tax_behavior: inclusive`) y un tipo de impuesto del 21 % creado en el panel. Si vendes a la UE o a empresas: propón Stripe Tax y avisa de que tiene coste por transacción [consulta la tarifa vigente].
8. Facturas. En el panel: numeración secuencial a nivel de cuenta, datos fiscales del usuario en la cabecera y NIF del cliente en la factura. Antes de dar por buena la primera factura, pásala por el subagente `revisor-facturas`.
9. Paso a producción. Cambiar claves de prueba por las reales, crear el webhook de producción en el panel con la URL pública y poner el nuevo `whsec_` en la variable de entorno del hosting (nunca en el código ni en el chat). Hacer un pago real de 1 € y reembolsarlo.

## Qué devolver

- Lista de archivos creados o modificados, con una frase por archivo diciendo qué hace.
- Las variables de `.env` que necesita, con nombre exacto y dónde se consigue cada una en el panel de Stripe.
- Una lista de comprobación de 8 puntos para pasar de prueba a producción.
- Los eventos del webhook que se escuchan y qué hace cada uno en la base de datos, en tabla.

## Riesgos que se dicen al usuario, no se callan

- Stripe cobra comisión por transacción. Dile que la mire en la web de Stripe antes de fijar precios. No inventes el porcentaje.
- Una factura de Stripe no vale en España si le faltan datos (número correlativo, NIF de emisor y receptor, base, tipo y cuota de IVA). Configurarlo bien es obligación del usuario, no de Stripe.
- La normativa Verifactu impone requisitos al software de facturación en España a partir de [fecha según tipo de contribuyente]. Que confirme con su gestor si le aplica y si su flujo con Stripe cumple.
- Si guarda datos de tarjeta en su servidor, se mete en PCI DSS. Con Checkout no hace falta y no debe hacerse.

## Qué NO hacer

- No montar formularios de tarjeta propios ni usar Elements si el usuario no lo pide expresamente y sabe lo que implica.
- No dar acceso al producto en la `success_url`. Se puede llegar a esa URL sin haber pagado. El acceso lo da el webhook.
- No fiarse de un webhook sin verificar la firma. Cualquiera puede enviar un POST falso a tu endpoint.
- No procesar el mismo `event.id` dos veces. Stripe reintenta durante días si no recibe 200.
- No meter claves en el código, en el frontend ni en el repositorio. La clave publicable (`pk_`) es la única que puede ir al navegador.
- No calcular el IVA a mano en código. Se define en Stripe (tipo de impuesto o Stripe Tax).
- No pasar a producción sin haber probado un impago con la tarjeta de prueba `4000 0000 0000 0341`.
- No escribir código para pilas que el usuario no usa. Mira el proyecto primero.
