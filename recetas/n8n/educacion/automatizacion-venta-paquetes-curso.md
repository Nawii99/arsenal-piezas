# Vender y entregar paquetes de curso por n8n…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Pedido -> Stripe cobra -> IA genera material del curso -> se entrega por email automático.

## Qué es y qué hace

Flujo de n8n que recoge un pedido de un formulario, cobra con Stripe, genera el material del curso con una IA y lo envía por Gmail. Entra el pedido con el pago confirmado; sale el material por email y un registro en Google Sheets. Requiere cuentas de Stripe, de API de pago por uso y de n8n. Una persona revisa el material antes de cada envío.

## Cómo usarla

1. Crea el formulario de pedido
2. Conecta Stripe y la IA
3. Prueba con un pedido de prueba
4. Revisa cada material antes del envío

## Cuándo usarla

Ya vendes paquetes de curso y los pedidos llegan poco a poco; no quieres cobrar, generar y enviar a mano cada vez.

## Cómo ganar dinero con ella

Es la trastienda de tu propio servicio de paquetes de curso: el cliente pide, paga y recibe sin que intervengas, y tú cobras por paquete [TU PRECIO]. Conviene que una persona revise el material antes del envío.

- Instalación de venta automática de paquetes de curso para formadores.
- Mantenimiento mensual del flujo de pedidos y entregas para academias.
- Panel de pedidos en hoja de cálculo para autónomos que venden formación.

**Precio orientativo:** 150–400 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Automatización: venta y entrega de paquetes de curso

Flujo pensado para vender el servicio de 'crear tu paquete de curso' sin tener que hacerlo todo a mano cada vez. Cobra, genera el material y lo entrega solo.

## Cuentas que hacen falta
- Tally o Google Forms, para el formulario de pedido (plan gratuito suficiente).
- Stripe, para cobrar (crear cuenta es gratis, cobra comisión por transacción, alrededor de un 1,5% más 0,25€ en pagos europeos).
- Una cuenta con acceso a la API de Claude o similar, para generar el material (de pago según el uso, revisa el precio actual antes de fijar tu tarifa).
- Gmail o un SMTP, para enviar el material por email (el plan gratis de Gmail permite unos 500 envíos al día).
- Google Sheets, para llevar el registro de pedidos (gratis).
- n8n, en su plan gratuito autoalojado o en la nube con el límite de ejecuciones que tenga tu plan.

## Nodos, en orden
1. Disparador: Webhook o nodo de Tally/Google Forms, que salta cuando alguien envía el pedido (tema del curso, nivel, número de alumnos, email).
2. Nodo Stripe (Create Payment Link o Checkout Session): genera un enlace de pago con el precio calculado según lo que ha marcado el cliente en el formulario.
3. Nodo Send Email: envía el enlace de pago al cliente y ahí se para el flujo hasta que pague.
4. Nodo Webhook de Stripe: escucha el evento 'checkout.session.completed', que confirma que el cliente ha pagado.
5. Nodo HTTP Request: llama a la API de la IA con el prompt de generación de paquete de curso, usando la ficha de producto en JSON con los datos del formulario.
6. Nodo Function o Code: da formato al texto que devuelve la IA y lo prepara para convertirlo en PDF.
7. Nodo de conversión a PDF (un servicio externo o una plantilla): genera el documento final que se entrega.
8. Nodo Send Email: envía el PDF al cliente como entrega de su pedido.
9. Nodo Google Sheets (Append Row): guarda el pedido, el precio cobrado, la fecha y si se ha entregado.

## Cómo probarla sin liarla
- Activa el modo de pruebas (test mode) de Stripe antes de nada: así no cobras dinero real mientras pruebas el flujo.
- Rellena el formulario tú mismo con tu propio email como cliente y comprueba que llega el enlace de pago, el aviso de pago recibido y el PDF final.
- Revisa siempre el PDF que genera la IA antes de mandarlo a un cliente real: puede tener errores que hay que corregir a mano.
- No actives el modo real de Stripe hasta que hayas completado al menos tres pruebas de principio a fin sin fallos.
