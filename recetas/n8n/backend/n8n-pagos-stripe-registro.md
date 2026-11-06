# Cada pago en Stripe, apuntado y avisado (n8n)

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Receta de n8n: cuando Stripe cobra una factura, la apunta en una hoja de Google con número, cliente, NIF, base, IVA, total y enlace al PDF, y te avisa por Telegram si un cobro falla.

## Qué es y qué hace

Receta de n8n que, al cobrar una factura en Stripe, la apunta en una hoja de Google con número, cliente, NIF, base, IVA, total y enlace al PDF, y avisa por Telegram si un cobro falla. Evita bajar facturas una a una al cerrar el trimestre. El gestor comprueba que los datos sirven para sus impuestos.

## Cómo usarla

1. Activa el webhook de Stripe en n8n
2. Mapea las columnas de la hoja
3. Prueba un cobro de test
4. Que lo revise un profesional

## Cuándo usarla

El gestor te pide las facturas del trimestre y las estás bajando de Stripe una a una. Esto las deja apuntadas en el momento del cobro y te avisa si un pago falla.

## Cómo ganar dinero con ella

Instálala a autónomos y pequeños negocios que cobran con Stripe, por [TU PRECIO] de montaje y una cuota mensual de mantenimiento. El gestor de cada cliente comprueba que los datos de la hoja le sirven para sus impuestos.

- Registro de cobros para autónomos que entregan datos al gestor cada trimestre…
- Aviso de cobros fallidos para negocios con cuotas periódicas…
- Cuota mensual de mantenimiento del registro fiscal de pagos…

**Precio orientativo:** 120–300 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Cada pago en Stripe, apuntado y avisado

Qué resuelve: a fin de trimestre el gestor te pide todas las facturas y tú entras en Stripe a descargarlas una a una. Con esto, cada cobro queda apuntado en una hoja con su PDF el mismo segundo en que se cobra, y te enteras al momento de los impagos.

## Cuentas que hacen falta

- Stripe: sin cuota mensual; cobra comisión por cada transacción [consulta la tarifa vigente en stripe.com/es/pricing].
- n8n: instalado en tu servidor es gratis sin límite. n8n Cloud tiene prueba gratuita limitada y después es de pago.
- Google (Sheets): cuenta gratuita.
- Telegram: gratis. Crea un bot con @BotFather y copia el token.

## Preparación (5 minutos)

1. Hoja de Google llamada `Facturas` con esta primera fila: `Numero | Fecha | Cliente | Email | NIF | Base | IVA | Total | Moneda | Estado | PDF | Enlace Stripe | ID factura`.
2. En Stripe, panel > Facturación > Configuración: numeración secuencial a nivel de cuenta y tus datos fiscales en la cabecera. Sin esto la hoja se llena de facturas que no valen. Pásalas antes por el subagente `revisor-facturas`.
3. En n8n, credenciales de Stripe (clave secreta), Google Sheets (OAuth) y Telegram (token del bot). Escribe al bot una vez y consigue tu `chat_id`.

## Nodos, en orden

**1. Stripe Trigger** (disparador). Eventos: `invoice.paid` e `invoice.payment_failed`. n8n crea el webhook en Stripe por ti al activar el flujo. Guarda el flujo y actívalo una vez para que aparezca la URL en el panel de Stripe.

**2. Switch** llamado `Tipo de evento`. Regla: `{{ $json.type }}` igual a `invoice.paid` va a la salida 0; `invoice.payment_failed` a la salida 1.

**3. Set** llamado `Datos factura` (rama pagado). Stripe manda los importes en céntimos. Campos:
- `Numero`: `{{ $json.data.object.number }}`
- `Fecha`: `{{ new Date($json.data.object.created * 1000).toISOString().slice(0,10) }}`
- `Cliente`: `{{ $json.data.object.customer_name }}`
- `Email`: `{{ $json.data.object.customer_email }}`
- `NIF`: `{{ $json.data.object.customer_tax_ids && $json.data.object.customer_tax_ids[0] ? $json.data.object.customer_tax_ids[0].value : '' }}`
- `Base`: `{{ $json.data.object.subtotal_excluding_tax / 100 }}`
- `IVA`: `{{ ($json.data.object.tax || 0) / 100 }}`
- `Total`: `{{ $json.data.object.total / 100 }}`
- `Moneda`: `{{ $json.data.object.currency.toUpperCase() }}`
- `Estado`: `pagada`
- `PDF`: `{{ $json.data.object.invoice_pdf }}`
- `Enlace Stripe`: `{{ $json.data.object.hosted_invoice_url }}`
- `ID factura`: `{{ $json.data.object.id }}`

**4. Google Sheets** (Append or Update). Hoja `Facturas`. Columna clave: `ID factura`. Con "actualizar si existe" evitas líneas duplicadas si Stripe reenvía el evento.

**5. Telegram** (Send Message). Texto: `Cobro: {{ $json.Total }} {{ $json.Moneda }} de {{ $json.Cliente }}. Factura {{ $json.Numero }}. PDF: {{ $json.PDF }}`.

**6. Set** llamado `Datos impago` (rama impago, salida 1 del Switch). Campos: `Cliente`, `Email`, `Total` (dividido entre 100), `Enlace Stripe` igual que arriba, y `Intento`: `{{ $json.data.object.attempt_count }}`.

**7. Telegram** (Send Message). Texto: `IMPAGO: {{ $json.Cliente }} ({{ $json.Email }}), {{ $json.Total }}. Intento {{ $json.Intento }}. Stripe reintentará solo; si pasa del 3, escríbele. {{ $json['Enlace Stripe'] }}`.

Opcional, rama impago, nodo 8: **Gmail** al cliente con enlace a su factura para que actualice la tarjeta. Actívalo solo si en Stripe has desactivado los emails automáticos de impago; si no, el cliente recibe dos.

## Cómo probarlo sin liarla

1. Haz todo en modo prueba de Stripe: clave `sk_test_` en las credenciales de n8n. Así el webhook se crea en el entorno de prueba y no toca cobros reales.
2. En n8n, pulsa "Listen for test event" en el Stripe Trigger.
3. En el panel de Stripe (modo prueba), crea un cliente con NIF y email, y una factura de 10 € con IVA; pulsa "Cobrar" con la tarjeta de prueba `4242 4242 4242 4242`. Tiene que aparecer una fila en la hoja y un mensaje en Telegram.
4. Repite con la tarjeta `4000 0000 0000 0341` (se rechaza). Tiene que llegar el aviso de impago y ninguna fila nueva.
5. Reenvía el mismo evento desde el panel de Stripe (Desarrolladores > Webhooks > evento > Reenviar). La hoja no debe ganar una fila duplicada.
6. Cuando todo cuadre, cambia la credencial a la clave real (`sk_live_`), desactiva y vuelve a activar el flujo para que n8n cree el webhook en producción, y haz un cobro real de 1 € a ti mismo. Reembólsalo después.

## Riesgos y límites

- La hoja es un registro, no tu contabilidad oficial. El PDF de cada factura sigue estando en Stripe: descarga copia propia cada mes, porque si Stripe cierra tu cuenta pierdes el acceso.
- Si el flujo de n8n está caído cuando Stripe envía el evento, Stripe reintenta durante horas, pero si tu n8n autoalojado está apagado días, se pierde. Revisa la hoja contra el panel de Stripe una vez al mes.
- Las retenciones de IRPF no salen en la factura de Stripe. Si facturas a empresas como autónomo, esa factura la revisa tu gestor antes de darla por buena.
- Verifactu impone requisitos al software de facturación a partir de [fecha según tipo de contribuyente]. Confirma con tu gestor si tu flujo cumple.
- Los datos del cliente (nombre, email, NIF) acaban en una hoja de Google: cuéntalo en tu política de privacidad y no compartas la hoja con nadie que no deba verla.
