# Alta y cobro automatico de cliente de entrenamiento online…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Cuando un cliente paga por su plan, se genera el plan, se le envia por email y se guarda su ficha en una hoja de calculo que hace de CRM, sin que tengas que hacer nada manualmente.

## Qué es y qué hace

Flujo de n8n que, al confirmarse un pago en Stripe, lee el cuestionario de Typeform, genera el plan de entrenamiento, lo envía por Gmail y guarda la ficha del cliente en Google Sheets. Entra el pago y las respuestas; sale el plan por email y una fila de alta. Requiere cuentas de Stripe, Typeform, Google y n8n. Como hay datos personales y de salud, un profesional revisa cada plan.

## Cómo usarla

1. Conecta Stripe y Typeform
2. Diseña el prompt de plan con la ficha del cliente
3. Prueba con un pago de prueba
4. Que un profesional revise cada plan antes del envío

## Cuándo usarla

Vendes planes online y no quieres hacer a mano el alta de cada cliente que paga: generar el plan, enviarlo y apuntarlo en la hoja.

## Cómo ganar dinero con ella

Móntalo para entrenadores personales y pequeños estudios online, cobrando la instalación y una cuota de mantenimiento [TU PRECIO]. Como toca salud y datos personales, el entrenador o un profesional revisa cada plan antes de que llegue al cliente.

- Alta automática de clientes para entrenadores online que cobran por adelantado.
- Mantenimiento mensual del flujo de altas para pequeños estudios de entrenamiento.
- Panel de clientes en hoja de cálculo para estudios online sin software de gestión.

**Precio orientativo:** 200–500 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Que hace esta automatizacion
Cuando un cliente nuevo paga por su plan de entrenamiento, se genera el plan automaticamente, se le envia por email y se guarda su ficha en una hoja de calculo que hace de CRM.

## Cuentas que necesitas
- n8n (version cloud con prueba gratuita, o self-hosted gratis si lo instalas tu).
- Typeform, plan gratuito hasta 10 respuestas al mes; si esperas mas clientes, plan de pago.
- Stripe, sin cuota mensual, cobra una comision por transaccion en Espana (aprox 1,4% + 0,25 euros con tarjetas europeas).
- Cuenta de Gmail o Google Workspace, gratis.
- Google Sheets, gratis con cualquier cuenta de Google.

## Nodos, en orden
1. Disparador: 'Stripe Trigger' con el evento 'checkout.session.completed', para arrancar solo cuando el pago esta confirmado, no antes.
2. Nodo HTTP Request a Typeform (o el nodo nativo de Typeform) para traer las respuestas del cuestionario de alta que relleno el cliente antes de pagar, cruzando por su email.
3. Nodo de IA (HTTP Request a la API de Claude, o el nodo de IA de n8n) al que le pasas los datos del cliente con el prompt de la skill 'plan-entrenamiento-vendible' para generar el plan.
4. Nodo 'Convert to File' o 'HTML to PDF' para pasar el texto del plan a un PDF con tu logo.
5. Nodo Gmail, 'Send Email', con el PDF adjunto y un mensaje de bienvenida al cliente.
6. Nodo Google Sheets, 'Append Row', para guardar en tu hoja de clientes: nombre, email, fecha de alta, importe pagado y fecha del siguiente pago si es una suscripcion.
7. Nodo Gmail o Telegram para avisarte a ti de que ha entrado un cliente nuevo.

## Como probarla sin liarla
Usa el modo de pruebas de Stripe (tarjeta 4242 4242 4242 4242) para simular un pago sin cobrar de verdad. Comprueba que llega el email con el PDF correcto y que aparece la fila nueva en la hoja antes de activar el flujo con pagos reales.

## Que NO hacer
- No mandes el plan antes de que el pago este confirmado: usa siempre el evento de pago completado, no el de 'checkout iniciado'.
- No metas los datos de salud del cliente (lesiones, medicacion) en herramientas que no controlas o en hojas compartidas sin permiso; son datos sensibles segun el RGPD.
- No automatices el envio por WhatsApp con la app personal: usa la API oficial de WhatsApp Business o Gmail, porque enviar mensajes masivos automatizados desde un WhatsApp normal puede bloquearte el numero.
