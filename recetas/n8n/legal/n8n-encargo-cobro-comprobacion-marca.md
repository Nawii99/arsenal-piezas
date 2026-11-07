# Flujo n8n: encargo y cobro de comprobación de marca…

**Tipo:** Receta de automatización · **Área:** Legal y contratos · **Licencia:** CC BY 4.0

Encargo por formulario, cobro antes, comprobación automática, aviso para revisar a mano OEPM.

## Qué es y qué hace

Flujo de n8n que recibe la petición de un cliente por formulario, lo cobra con un enlace de pago de Stripe antes de empezar, comprueba automáticamente el dominio con una API y deja preparada la revisión manual de la OEPM, que no tiene API pública. Al terminar envía el informe por correo. Necesitas n8n, Stripe, un formulario y una cuenta de correo; el coste son las comisiones de cobro y el límite gratuito de la API.

## Cómo usarla

1. Crea el formulario y el enlace de Stripe
2. Monta el webhook que confirma el pago (con la firma de Stripe verificada)
3. Comprueba el dominio y deja la revisión de la OEPM a mano
4. Que lo revise un profesional

## Cuándo usarla

Quieres que el cliente pida la comprobación por formulario, pague antes de empezar y tú solo te ocupes de la revisión manual de la OEPM.

## Cómo ganar dinero con ella

Cobra por adelantado cada comprobación de marca con un enlace de pago, por comprobación [TU PRECIO]. La OEPM la miras tú a mano y los casos dudosos pasan a un profesional.

- Venta online de comprobaciones de marca con cobro por adelantado…
- Flujo de encargos para despachos que atienden registro de marca…
- Automatización de presupuestos y cobros para servicios de naming…

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace
Recibe la petición de un cliente que quiere comprobar si puede usar un nombre, cobra el servicio antes de empezar, comprueba automáticamente el dominio y deja preparado el hueco para que revises tú a mano la OEPM (no tiene API pública), y por último envía el informe por correo.

## Cuentas necesarias y límites gratuitos
- Un formulario (Typeform o Google Forms, plan gratuito vale para empezar, con límite de respuestas al mes).
- n8n (self-hosted gratis, o n8n Cloud con su plan de prueba).
- Stripe en modo Payment Link para cobrar, sin coste fijo, cobra comisión por cada cobro.
- Una API de comprobación de dominios (por ejemplo WhoisXML API, tiene un límite de consultas gratis al mes, revisa el número exacto en tu cuenta).
- Una cuenta de Gmail o el proveedor de correo que uses, para el nodo de envío.

## Nodo por nodo
1. Disparador: nodo Webhook o Typeform Trigger, que se activa cuando el cliente rellena el formulario con el nombre a comprobar y su email.
2. Confirmación del pago: envía al cliente el Payment Link de Stripe y escucha el aviso de Stripe con un nodo Stripe Trigger (comprueba la firma) o, con un Webhook genérico, verifica la cabecera `Stripe-Signature` con el «signing secret» del endpoint, guardado en las credenciales o en una variable de entorno. Sigue solo si el evento es `checkout.session.completed` con `payment_status` = `paid` y el id del evento no se había procesado antes; si no, el flujo termina y envía un correo con el enlace de pago pendiente.
3. Nodo HTTP Request a la API de comprobación de dominios: consulta si el .es y el .com del nombre están libres.
4. Nodo Set: prepara un campo 'tarea_pendiente_oepm' marcado como true, porque la búsqueda en la OEPM no tiene API pública y la tienes que hacer tú a mano en la sede electrónica.
5. Nodo Slack o Telegram (opcional): te avisa a ti de que hay una comprobación de OEPM pendiente de hacer a mano, con el nombre y el email del cliente.
6. Nodo de espera o segundo Webhook: cuando termines la comprobación manual de la OEPM, rellenas un formulario propio (o un nodo Set manual) con el resultado.
7. Nodo Function o Code: junta el resultado del dominio con el resultado manual de la OEPM y arma el texto del informe con el disclaimer legal incluido.
8. Nodo Gmail (Send Email): envía el informe final al cliente, con el disclaimer de que no sustituye una búsqueda oficial.

## Cómo probarla sin liarla
Prueba todo el flujo primero contigo mismo como cliente: rellena el formulario con tu propio nombre y correo, usa el modo test de Stripe (no cobra de verdad) y comprueba que llega el correo final antes de activarlo para clientes reales. No actives el modo de pago real hasta que el correo final salga bien formateado y sin datos de prueba a la vista.
