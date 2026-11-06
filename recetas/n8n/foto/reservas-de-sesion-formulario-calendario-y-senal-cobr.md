# Reservas de sesión: formulario, calendario y señal cobr…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

El cliente rellena un formulario, elige hueco, paga la señal con Stripe y se le crea la cita en tu calendario con el email de confirmación. Para fotógrafos que pierden tiempo con fechas.

## Qué es y qué hace

El cliente rellena un formulario de n8n con nombre, email y fecha deseada, y recibe un enlace de pago de Stripe por la señal. Cuando paga, se crea el evento en Google Calendar, la reserva queda en una hoja y el cliente recibe la confirmación por Gmail. Así se cierran citas y se cobra por adelantado.

## Cómo usarla

1. Verifica tu cuenta de Stripe y copia la clave secreta
2. Crea la hoja Reservas y conecta Calendar, Gmail y Sheets
3. Prueba un pago en modo test
4. Que lo revise un profesional

## Cuándo usarla

Cuando cierras sesiones a base de mensajes, te cancelan sin avisar y no cobras nada por adelantado.

## Cómo ganar dinero con ella

Cobrar una señal del 30% reduce los plantones casi a cero. Con 4 sesiones al mes evitas 1-2 huecos perdidos, unos 300-500 €.

- Montaje de reservas con señal para fotógrafos de retrato, mascotas o books.
- Gestión mensual de reservas y cobros para un estudio con varias sesiones a la semana.
- Plantilla de reservas con pago previo vendida a servicios con cita que sufren plantones.

**Precio orientativo:** 250–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recoge la petición de sesión, te la apunta como pendiente, envía al cliente un enlace de pago de Stripe con la señal y, en cuanto paga, crea el evento en Google Calendar y le manda la confirmación con dirección y qué llevar.
Para fotógrafos de retrato, familias, mascotas, books y cualquier servicio con cita.

## Lo que necesitas antes
- Cuenta de Stripe (gratuita) verificada con tu IBAN. En dashboard.stripe.com > Desarrolladores > Claves API copias la clave secreta.
- Un Payment Link o, mejor, usar la API de Checkout Sessions para importe variable.
- Credenciales de Google Calendar OAuth2, Gmail OAuth2 y Google Sheets OAuth2.
- Hoja Reservas con columnas: Nombre, Email, Telefono, Tipo, FechaDeseada, Importe, Estado, SessionID.

## Los nodos, en orden
1) **n8n Form Trigger**. Form Title: Reserva tu sesión. Campos: Nombre (text, obligatorio), Email (email, obligatorio), Teléfono (text), Tipo de sesión (dropdown: Retrato 150, Familia 220, Book 350), Fecha deseada (date), Comentarios (textarea).
2) **Code** (Calcular señal). Devuelve el precio según el tipo y la señal del 30%. Ver código abajo.
3) **Google Sheets** (Append Row). Estado: PENDIENTE PAGO.
4) **HTTP Request** (Crear pago). Method: POST. URL: `https://api.stripe.com/v1/checkout/sessions`. Authentication: Generic > Header Auth, Name: Authorization, Value: `Bearer sk_live_...`. Body Content Type: Form-Urlencoded. Parámetros: `mode` = payment, `success_url` = tu página de gracias, `customer_email` = `{{ $('n8n Form Trigger').item.json.Email }}`, `line_items[0][price_data][currency]` = eur, `line_items[0][price_data][unit_amount]` = `{{ $('Code').item.json.senalCentimos }}`, `line_items[0][price_data][product_data][name]` = `Señal {{ $('n8n Form Trigger').item.json['Tipo de sesión'] }}`, `line_items[0][quantity]` = 1.
5) **Gmail** (Enviar enlace). To el cliente. Cuerpo con el enlace `{{ $json.url }}` y el texto: «Tu fecha queda bloqueada 48 horas hasta que se abone la señal».
6) Segundo flujo: **Stripe Trigger**. Events: checkout.session.completed.
7) **Google Sheets1** (Get Rows) filtrando por Email `{{ $json.data.object.customer_email }}` y Estado PENDIENTE PAGO.
8) **Google Calendar**. Operation: Create Event. Calendar: el tuyo. Start: `{{ $json.FechaDeseada }}T10:00:00`. End: dos horas después. Summary: `Sesión {{ $json.Tipo }} - {{ $json.Nombre }}`. Description: teléfono y comentarios. En Options activa Send Updates: all.
9) **Gmail1** (Confirmación) con dirección del estudio, qué ropa traer y política de cancelación.
10) **Google Sheets2** (Update Row). Estado: CONFIRMADA.

## El trozo de código (nodo Code)
```javascript
const precios = { 'Retrato 150': 150, 'Familia 220': 220, 'Book 350': 350 };
const f = $input.first().json;
const tipo = f['Tipo de sesión'];
const total = precios[tipo] || 150;
const senal = Math.round(total * 0.30);
return [{ json: {
  total,
  senal,
  senalCentimos: senal * 100,
  resto: total - senal
}}];
```

## Cómo probarla
Usa las claves de **test** de Stripe (sk_test_) y la tarjeta 4242 4242 4242 4242 con cualquier fecha futura y CVC. Comprueba que el evento aparece en el calendario y que llegan los dos correos. Solo entonces cambia a las claves live.

## Qué puede salir mal
- **Doble reserva a la misma hora**: añade antes del Calendar un nodo **Google Calendar1** con Operation: Get Many y filtro de fecha; si hay eventos, manda un email proponiendo otra hora en vez de crear la cita.
- **El webhook de Stripe no llega**: en n8n autoalojado necesitas que tu instancia sea accesible desde internet (dominio con HTTPS o túnel). Comprueba los intentos en Stripe > Desarrolladores > Webhooks.
- **Zona horaria**: si las citas salen con una hora de diferencia, pon Timezone Europe/Madrid en Settings del workflow y en el nodo de Calendar.
- **Devoluciones**: deja escrito en el email que la señal no se devuelve con menos de 48 h de aviso; en España conviene tenerlo en tus condiciones publicadas.

## Cuánto cuesta
n8n autoalojado 0 €. Stripe cobra 1,5% + 0,25 € por cobro europeo: sobre una señal de 66 € son unos 1,24 €. Google Calendar y Gmail gratis. Alternativa de pago tipo Calendly + Stripe serían 12-16 €/mes.
