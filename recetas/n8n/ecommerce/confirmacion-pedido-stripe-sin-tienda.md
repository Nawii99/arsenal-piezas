# Confirmación automática de pedido de Stripe sin plataforma d…

**Tipo:** Receta de automatización · **Área:** Tienda por internet · **Licencia:** CC BY 4.0

Workflow de n8n que, al recibir un pago en Stripe, registra el pedido en una hoja de cálculo, avisa al vendedor si es grande y envía la confirmación al cliente, sin plataforma de tienda.

## Qué es y qué hace

Es una receta de n8n que, al recibir un pago en Stripe, registra el pedido en una hoja de cálculo, avisa al vendedor si el importe es alto y envía la confirmación al cliente, sin plataforma de tienda con cuota. Entran el evento de pago de Stripe y los datos del pedido; salen una fila en la hoja y dos correos. El coste real es la comisión de Stripe por pago y el hosting de n8n si no lo autoalojas. Que lo revise un profesional si hay obligaciones fiscales.

## Cómo usarla

1. Conecta el webhook de Stripe con n8n
2. Monta el registro, el aviso y el correo en orden
3. Haz un pago de prueba y revisa la hoja. Que lo revise un profesional

## Cuándo usarla

Cuentas necesarias: Stripe (gratis, cobra comisión por operación), n8n (gratis si se autoaloja), Google Sheets y Gmail (gratis con una cuenta normal).

## Cómo ganar dinero con ella

Coste real: solo la comisión de Stripe por cada pago cobrado, y el hosting de n8n si no lo autoalojas gratis.

- Confirmación de pedido automática para tiendas que cobran con enlace de pago.
- Registro de ventas y aviso al vendedor para negocios que venden pocos productos al mes.
- Mantenimiento mensual del flujo de cobros con revisión de fallos y de correos.

**Precio orientativo:** 150–350 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué resuelve
Cuando alguien paga con un Payment Link o Checkout de Stripe, esta automatización registra el pedido, envía el email de confirmación y avisa al vendedor, sin tocar nada a mano y sin pagar una plataforma de tienda con cuota mensual.

## Cuentas necesarias y sus límites gratuitos
- Stripe: gratis crear la cuenta y los Payment Links; cobra una comisión por operación (en España, alrededor de 1,5% + 0,25€ por pago con tarjeta europea, revisa el precio actualizado en tu propia cuenta).
- n8n: si lo autoalojas (por ejemplo en una VPS barata o en tu propio ordenador) no tiene límite de ejecuciones; si usas n8n Cloud, el plan gratuito es una prueba limitada en el tiempo, después hay que pagar.
- Google Sheets: gratis con una cuenta de Gmail normal.
- Gmail (o el proveedor de correo que uses): gratis hasta el límite de envíos diarios de una cuenta normal, unos 500 al día.

## Nodos, en orden
1. Trigger: nodo 'Stripe Trigger' (o un nodo Webhook configurado a mano) escuchando el evento checkout.session.completed.
2. Nodo 'Stripe' (Get) para recuperar los datos completos de la sesión: email del cliente, importe, moneda y producto comprado.
3. Nodo 'Google Sheets' (Append Row) para añadir una fila con fecha, email, producto, importe y número de sesión de Stripe, a una hoja de 'Pedidos'.
4. Nodo 'IF' que comprueba si el importe supera un umbral que decidas (por ejemplo 100€).
5. Rama verdadera del IF: nodo 'Gmail' o 'Telegram' para avisarte a ti de un pedido grande, aparte del registro normal.
6. Nodo 'Gmail' (Send) para enviar al cliente el email de confirmación, con el número de pedido y el enlace de seguimiento si lo tienes.

## Cómo probarla sin liarla
1. Activa el modo test de Stripe (la clave empieza por sk_test_ o pk_test_) antes de conectar nada.
2. Genera un pago de prueba con una tarjeta de test de Stripe (por ejemplo 4242 4242 4242 4242, cualquier fecha futura y cualquier CVC).
3. Comprueba que aparece la fila en Google Sheets y que llega el email de confirmación a una cuenta tuya de prueba, no a un cliente real.
4. Solo cuando todo funcione en modo test, cambia las claves de Stripe a modo real (live) y repite una compra real del producto más barato para confirmar que también funciona en producción.

## Qué NO hacer
- No conectes las claves de Stripe en modo real (live) hasta haber probado el flujo completo en modo test.
- No guardes el número completo de tarjeta en ningún nodo ni en la hoja de cálculo: Stripe no te lo da y no debes pedirlo por otra vía, es una infracción de PCI-DSS.
- No mandes el email de confirmación antes de comprobar en el nodo IF que el pago está en estado 'paid', para no confirmar pedidos que luego fallen.
- No dejes el workflow sin un nodo de manejo de error: si falla el envío del email, el pedido tiene que quedar registrado igualmente en la hoja.
