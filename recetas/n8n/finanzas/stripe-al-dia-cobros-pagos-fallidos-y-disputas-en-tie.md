# Stripe al día: cobros, pagos fallidos y disputas en tie…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Escucha lo que pasa en tu Stripe y, según sea un cobro bueno, un pago fallido o una disputa, lo apunta en tu hoja, avisa al cliente o te avisa a ti con urgencia.

## Qué es y qué hace

Recibe los eventos de Stripe en tiempo real y, según el caso, registra el cobro en tu hoja de ingresos con la comisión descontada, envía al cliente un correo para actualizar la tarjeta si el pago falla, o te avisa por Telegram si hay una disputa. Se monta con n8n, Make o Zapier y necesita tu clave secreta de Stripe.

## Cómo usarla

1. Crea la hoja Ingresos Stripe
2. Conecta Stripe con tu clave secreta y un webhook
3. Conecta Gmail y Telegram
4. Prueba con eventos de prueba de Stripe
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando cobras por Stripe y te enteras de las tarjetas rechazadas cuando el cliente ya se ha ido, o cuando el cierre de mes es copiar el panel de Stripe a mano.

## Cómo ganar dinero con ella

Recuperar tarjetas caducadas con un aviso el mismo día salva entre el 30% y el 50% de esos cobros. Con 60 suscripciones de 30 €, son 300-600 € al año que no se pierden.

- Recuperación de pagos fallidos como servicio mensual para tiendas online…
- Registro automático de ingresos Stripe para negocios de suscripción…
- Configuración de avisos de disputas para vendedores digitales…

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Recibe los eventos de Stripe en el momento en que ocurren. Si es un cobro con éxito, lo registra en tu hoja de ingresos con la comisión ya descontada. Si el pago falla, manda al cliente un correo con el enlace para actualizar su tarjeta. Si hay una disputa, te avisa a ti por Telegram porque eso corre prisa.
Para tiendas online, infoproductos, servicios por suscripción y cualquiera que cobre con Stripe.

## Lo que necesitas antes
Cuenta de Stripe con tu clave secreta (dashboard.stripe.com > Developers > API keys).
Una hoja «Ingresos Stripe» con columnas: Fecha, Cliente, Email, Concepto, Bruto, Comision, Neto, Moneda, IDPago, Tipo.
n8n accesible desde internet: si lo tienes en casa, usa el túnel `n8n start --tunnel` para probar, pero para producción ponlo en un VPS con dominio o usa la nube de n8n.
Credencial de Google en n8n y un bot de Telegram.
Un enlace del portal de cliente de Stripe (Settings > Billing > Customer portal) para meterlo en el correo de pago fallido.

## Los nodos, en orden
**Webhook**: HTTP Method POST, Path `stripe-finanzas`, Respond «Immediately». Copia la Production URL que te da n8n.
En Stripe: Developers > Webhooks > Add endpoint, pega esa URL y selecciona los eventos `invoice.payment_succeeded`, `invoice.payment_failed`, `charge.dispute.created` y `payment_intent.succeeded`.
**Switch**: modo Rules, valor a comparar `={{ $json.body.type }}`. Regla 1: igual a `invoice.payment_succeeded` (salida «cobro»). Regla 2: igual a `invoice.payment_failed` (salida «fallo»). Regla 3: igual a `charge.dispute.created` (salida «disputa»).
**Code** (salida cobro, renombra a `Formatear cobro`): modo «Run Once for Each Item».
```javascript
const e = $input.item.json.body.data.object;
const bruto = (e.amount_paid ?? e.amount) / 100;
const comision = bruto * 0.0145 + 0.25; // tarjeta europea estándar de Stripe, ajústalo a tu tarifa
return { json: { Fecha: new Date(e.created * 1000).toISOString().slice(0,10), Cliente: e.customer_name || e.customer || '', Email: e.customer_email || '', Concepto: (e.lines?.data?.[0]?.description) || e.description || 'Cobro Stripe', Bruto: bruto.toFixed(2), Comision: comision.toFixed(2), Neto: (bruto - comision).toFixed(2), Moneda: (e.currency || 'eur').toUpperCase(), IDPago: e.id, Tipo: 'cobro' } };
```
**Google Sheets** (tras el cobro): Append Row en «Ingresos Stripe», Map Automatically.
**Gmail** (salida fallo): Send. To `={{ $json.body.data.object.customer_email }}`. Subject `No hemos podido cobrar tu pago`. Message: `=Hola,\n\nHemos intentado cobrar {{ ($json.body.data.object.amount_due/100).toFixed(2) }} € y tu banco lo ha rechazado. Suele ser una tarjeta caducada o un límite del banco.\n\nPuedes actualizar tu tarjeta aquí: TU_ENLACE_DEL_PORTAL\n\nSi tienes cualquier duda, respóndeme a este correo.\n\nGracias`
**Google Sheets** (tras el fallo): Append Row con Tipo `fallo`, para llevar la cuenta de cuántos recuperas.
**Telegram** (salida disputa): Send Message. Text: `=DISPUTA EN STRIPE\nImporte: {{ ($json.body.data.object.amount/100).toFixed(2) }} €\nMotivo: {{ $json.body.data.object.reason }}\nPlazo para responder: revisa el panel de Stripe HOY.\nID: {{ $json.body.data.object.id }}`

## Cómo probarla
Stripe tiene modo test: activa la llave de test, usa la tarjeta `4242 4242 4242 4242` para un cobro correcto y la `4000 0000 0000 0341` para simular un pago fallido.
En Developers > Webhooks puedes pulsar «Send test webhook» y elegir el evento; verás la ejecución en n8n al instante.
Comprueba que el neto que apunta la hoja coincide con lo que Stripe te dice en su informe de balance; si no, ajusta la fórmula de comisión a tu tarifa real.

## Qué puede salir mal
Firma del webhook: por seguridad deberías validar la cabecera `stripe-signature`. La forma sencilla es poner Header Auth en el nodo Webhook con un valor secreto en la URL, o usar el nodo Stripe Trigger nativo de n8n, que ya valida por ti.
Reintentos de Stripe: si tu n8n no responde 200 en pocos segundos, Stripe reintenta y tendrás filas duplicadas. Por eso el Webhook responde «Immediately».
Comisiones: la fórmula del 1,45% + 0,25 € vale para tarjetas europeas. Las de fuera de Europa son más caras. Para exactitud, consulta el objeto `balance_transaction` con una llamada extra.
Suscripciones que fallan tres veces: Stripe manda tres eventos de fallo, así que el cliente recibirá tres correos. Añade un IF sobre `attempt_count` si te parece mucho.
Si n8n está caído, Stripe reintenta durante 3 días; no perderás eventos, pero llegarán tarde.

## Cuánto cuesta
Stripe: sin cuota, cobra su comisión por transacción.
Sheets, Gmail y Telegram: gratis. n8n autoalojado: gratis, pero necesita estar siempre encendido y accesible desde internet.
