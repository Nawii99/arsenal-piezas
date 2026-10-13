# n8n: cuando alguien paga en Stripe, apuntarlo en Google Shee…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Stripe avisa a n8n de cada pago, comprueba que es real, lo escribe en una hoja y te envía email y Telegram.

## Qué es y qué hace

Flujo de n8n que recibe el aviso de Stripe de cada pago, comprueba que el evento es real con la firma, mira si ya estaba registrado, escribe una fila en Google Sheets y envía email y Telegram. Sirve para llevar el control de ventas sin mirar el panel. Puede cambiar Sheets por un CRM o un programa de facturas.

## Cómo usarla

1. Crea el webhook en Stripe
2. Comprueba la firma en n8n
3. Escribe la fila en Sheets
4. Prueba con un pago de test

## Cuándo usarla

Cuando ya cobras con Stripe y quieres dejar de mirar el panel para saber quién ha pagado y llevar el control de ventas sin programar.

## Cómo ganar dinero con ella

Se vende como 'registro automático de ventas' a cualquier negocio con Stripe; el mismo flujo sirve para conectar con su CRM o su programa de facturas en lugar de Sheets.

- Registro automático de ventas para negocios que cobran con Stripe…
- Conexión de pagos con CRM o programa de facturas para pymes…
- Avisos de venta para equipos que reparten pedidos…

**Precio orientativo:** 100–250 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Stripe -> n8n -> Google Sheets + email + Telegram

## Qué hace
Cada vez que un cliente termina de pagar en Stripe, n8n recibe el aviso (webhook), comprueba que es real, mira si ya lo tenía apuntado, escribe una fila en tu hoja de Google, manda un email de confirmación al cliente y te llega un mensaje a Telegram en el móvil.

## Cuentas que hacen falta y qué cuestan
- Stripe: cuenta gratis. Solo pagas comisión por cobro. Necesitas la clave secreta de PRUEBA (sk_test_...) para montar esto y la de REAL para cuando funcione.
- n8n: dos opciones. n8n Cloud (de pago tras la prueba gratuita; mira n8n.io/pricing) o n8n instalado por ti (gratis, edición Community). Ojo: Stripe tiene que poder llegar a tu n8n por internet. Si lo tienes en tu ordenador de casa sin URL pública, el webhook no llega. Para empezar, n8n Cloud es lo que menos se atasca.
- Google: cuenta normal. Sheets gratis. Gmail gratis con límite de envío diario (una cuenta personal ronda los 500 correos al día; una de Google Workspace, más).
- Telegram: gratis. Creas un bot hablando con @BotFather y te da un token.

## Preparar antes de abrir n8n
1. Crea una hoja de Google llamada 'Ventas Stripe' con estas cabeceras en la fila 1: id_sesion, fecha, email_cliente, nombre_cliente, producto, importe_eur, estado, enlace_recibo.
2. En Stripe, activa el modo de prueba y ten a mano un enlace de pago de prueba (Enlaces de pago).
3. En Telegram, crea el bot con @BotFather, guarda el token, escríbele un 'hola' al bot y averigua tu chat_id (por ejemplo con @userinfobot).

## Nodos, en orden

### Nodo 1 - Stripe Trigger (disparador)
- Credencial: nueva credencial de Stripe con la clave sk_test_.
- Events: marca 'checkout.session.completed'.
- Al activar el flujo, n8n crea el webhook en Stripe por ti. Lo verás en Stripe > Desarrolladores > Webhooks.
- Nota: al pasar a real tendrás que cambiar la credencial a sk_live_ y volver a activar; se creará un segundo webhook en modo real. Es normal tener dos.

### Nodo 2 - Stripe: recuperar la sesión (comprobación de que el aviso es real)
- Nodo 'HTTP Request'. Método GET. URL: https://api.stripe.com/v1/checkout/sessions/{{ $json.data.object.id }}
- Autenticación: 'Predefined Credential Type' > Stripe (la misma credencial).
- Añade un parámetro de consulta: expand[] = line_items
- Por qué: no te fías del contenido del aviso, le pides a Stripe el pago por su ID. Si alguien te manda un aviso falso, este nodo falla y el flujo se para. Es la protección mínima.

### Nodo 3 - IF: ¿está pagado?
- Condición: {{ $json.payment_status }} igual a 'paid'.
- Rama false: no hacer nada (deja la salida sin conectar).

### Nodo 4 - Google Sheets: buscar si ya existe
- Operación: 'Get Row(s)'. Hoja 'Ventas Stripe'. Filtro: columna id_sesion igual a {{ $('Nodo 2').item.json.id }} (usa el nombre real que tenga tu nodo 2).
- Activa 'Always Output Data' en la configuración del nodo para que siga aunque no encuentre nada.
- Por qué: Stripe reenvía el mismo aviso si no le respondes a tiempo. Sin esto acabas con la misma venta apuntada dos veces y el cliente con dos emails.

### Nodo 5 - IF: ¿es nueva?
- Condición: {{ $json.id_sesion }} está vacío (is empty).
- Rama true: sigue. Rama false: fin.

### Nodo 6 - Google Sheets: añadir fila
- Operación: 'Append Row'. Mapea las columnas, cogiendo los datos del nodo 2:
- id_sesion: {{ $('Nodo 2').item.json.id }}
- fecha: {{ $now.format('yyyy-MM-dd HH:mm') }}
- email_cliente: {{ $('Nodo 2').item.json.customer_details.email }}
- nombre_cliente: {{ $('Nodo 2').item.json.customer_details.name }}
- producto: {{ $('Nodo 2').item.json.line_items.data[0].description }}
- importe_eur: {{ $('Nodo 2').item.json.amount_total / 100 }} (Stripe da los importes en céntimos)
- estado: {{ $('Nodo 2').item.json.payment_status }}
- enlace_recibo: déjalo vacío por ahora; el recibo lo manda Stripe si lo tienes activado en Configuración > Emails.

### Nodo 7 - Gmail: email al cliente
- Operación: 'Send'. Para: {{ $('Nodo 2').item.json.customer_details.email }}
- Asunto: 'Hemos recibido tu pago - [NOMBRE DE TU NEGOCIO]'
- Cuerpo: texto corto con qué ha comprado, el importe y qué pasa ahora (cuándo recibe el servicio o el acceso). Nada de adornos. Pon tu email de contacto.
- Si vas a mandar una factura, dilo aquí ('recibirás la factura en 48 h') y cúmplelo.

### Nodo 8 - Telegram: aviso a tu móvil
- Credencial: el token del bot. Chat ID: el tuyo.
- Texto: 'Nueva venta: {{ nombre_cliente }} - {{ producto }} - {{ importe_eur }} EUR'. Toma los valores del nodo 6 o del nodo 2.

## Cómo probarla sin liarla
1. Guarda el flujo y pulsa 'Test workflow' en n8n (modo escucha).
2. Abre tu enlace de pago DE PRUEBA y paga con la tarjeta 4242 4242 4242 4242, fecha futura, cualquier CVC. Usa tu propio email para recibir el correo.
3. Mira en n8n que cada nodo se pone en verde. Si el nodo 2 falla con 401, la credencial no es la de prueba o está mal pegada.
4. Comprueba la fila en Sheets, el email en tu bandeja y el mensaje en Telegram.
5. Repite el pago de prueba desde Stripe > Desarrolladores > Webhooks > tu webhook > 'Reenviar' el evento. Debe llegar hasta el nodo 5 y parar ahí (ya existía). Si vuelve a escribir la fila, el filtro del nodo 4 está mal.
6. Cuando todo funcione, activa el flujo (interruptor 'Active'). Hasta que no esté activo, Stripe no tiene a quién avisar cuando tú no estás mirando.
7. Para pasar a real: cambia la credencial de Stripe a sk_live_, desactiva y vuelve a activar el flujo, hazte un cobro real de 1 EUR y reembólsalo desde Stripe.

## Avisos
- Estás guardando nombres y emails de clientes en una hoja de Google: entra en tu obligación de protección de datos (RGPD). Que la hoja no sea pública y que tu política de privacidad diga que usas Google y Stripe.
- El email del nodo 7 no es una factura. Si tu cliente es empresa te la va a pedir; ten claro desde dónde la emites.
- Si el flujo falla a mitad (por ejemplo Gmail caído), la fila ya está en Sheets pero el cliente no tiene email. Activa en n8n 'Settings > Error workflow' con un aviso a Telegram para enterarte.
