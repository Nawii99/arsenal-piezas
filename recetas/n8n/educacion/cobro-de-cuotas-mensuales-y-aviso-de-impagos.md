# Cobro de cuotas mensuales y aviso de impagos…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Controla quién ha pagado la mensualidad, avisa con antelación al que le toca renovar y persigue solo a los que fallan, con tres mensajes escalonados.

## Qué es y qué hace

Escucha los avisos de Stripe de pago correcto, pago fallido y cancelación de suscripción, actualiza la hoja de cuotas del alumno y lanza el correo adecuado: recibo, aviso de tarjeta rechazada o corte de acceso. Entran eventos de Stripe y salen correos y estados en una hoja. Para academias con cuota mensual y membresías de formación, con n8n y Gmail. Verifica la firma del webhook de Stripe y descarta los eventos repetidos antes de actuar.

## Cómo usarla

1. Crea el producto recurrente en Stripe
2. Configura el webhook con los tres eventos y verifica su firma con el signing secret
3. Escribe los tres correos escalonados
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando cobres por cuotas (academia, clases mensuales, membresía formativa) y pierdas tiempo cada mes revisando el banco y escribiendo a los que no han pagado.

## Cómo ganar dinero con ella

Reducir un 3% de impagos en una academia que factura 8.000 € al mes son 240 € recuperados cada mes, más las horas que no pasas persiguiendo.

- Implantación de cobro recurrente y avisos de impago para academias con cuota mensual, con prueba incluida.
- Gestión mensual de impagos y reintentos para clubes de estudio o membresías, cobrada por cuota.
- Plantilla de correos de impago escalonados que se vende a gestorías y pequeñas escuelas.

**Precio orientativo:** 200–500 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Escucha los avisos de Stripe (pago correcto, pago fallido, suscripción cancelada), actualiza la ficha del alumno y lanza la secuencia adecuada: recibo, aviso amable de tarjeta rechazada o corte de acceso.
Para academias con cuota mensual, membresías de formación y clubes de estudio.

## Lo que necesitas antes
- Cuenta de Stripe (gratis abrirla) con un producto de precio recurrente creado en el panel.
- Una hoja «Cuotas» con: alumno | email | producto | importe | estado | ultimo_pago | intentos_fallidos
- El webhook de Stripe: en dashboard.stripe.com > Desarrolladores > Webhooks > Añadir endpoint, pega la URL de producción de tu nodo Webhook de n8n y selecciona los eventos `invoice.paid`, `invoice.payment_failed` y `customer.subscription.deleted`. Copia también el «signing secret» (`whsec_...`) del endpoint y guárdalo como variable de entorno de n8n (`STRIPE_WEBHOOK_SECRET`), no escrito en el nodo. Alternativa más simple: sustituye el Webhook y el Code de verificación por un nodo **Stripe Trigger**, que comprueba la firma por ti (el evento llega entonces en `$json` y no en `$json.body`).
- Credenciales de Google Sheets y Gmail en n8n.

## Los nodos, en orden
1) **Webhook**. HTTP Method: POST. Path: `stripe-cuotas`. Response Mode: «Immediately». Copia la URL de producción y pégala en Stripe.
1b) **Code** («Verificar firma de Stripe»), justo después del Webhook y antes del Switch. No te fíes de ningún aviso sin este paso. En el Webhook activa antes Options > **Raw Body**; en n8n auto-alojado necesitas `NODE_FUNCTION_ALLOW_BUILTIN=crypto`:
```js
const crypto = require('crypto');
const secret = $env.STRIPE_WEBHOOK_SECRET;
const item = $input.first();
const cabecera = item.json.headers['stripe-signature'] || '';
const partes = Object.fromEntries(cabecera.split(',').map(p => p.split('=')));
const raw = (await this.helpers.getBinaryDataBuffer(0, 'data')).toString('utf8');
const esperada = crypto.createHmac('sha256', secret || '').update(`${partes.t}.${raw}`).digest('hex');
const ok = !!partes.v1 && partes.v1.length === esperada.length && crypto.timingSafeEqual(Buffer.from(partes.v1), Buffer.from(esperada));
const reciente = Math.abs(Date.now() / 1000 - Number(partes.t)) < 300;
if (!secret || !ok || !reciente) throw new Error('Firma de Stripe no válida: evento descartado');
return [{ json: { body: JSON.parse(raw) } }];
```
2) **Switch**. Modo Rules sobre `{{ $json.body.type }}`. Salida 0: `invoice.paid`. Salida 1: `invoice.payment_failed`. Salida 2: `customer.subscription.deleted`.
3) **Code** (común a las tres ramas, ponlo justo después de cada salida o usa un Merge antes). Extrae lo que importa:
```js
const e = $input.first().json.body;
const obj = e.data.object;
return [{ json: {
  tipo: e.type,
  email: obj.customer_email || (obj.customer_details && obj.customer_details.email) || '',
  nombre: (obj.customer_name || 'alumno').split(' ')[0],
  importe: obj.amount_paid ? (obj.amount_paid / 100) : (obj.amount_due ? obj.amount_due / 100 : 0),
  factura: obj.hosted_invoice_url || '',
  portal: 'https://billing.stripe.com/p/login/TU_ENLACE_PORTAL',
  fecha: new Date().toISOString().slice(0,10)
}}];
```
4) Rama pago correcto (comprueba antes que `body.data.object.status` sea `paid`): **Google Sheets** (Update Row) filtrando por `email`, pon `estado` = `al_dia`, `ultimo_pago` = fecha, `intentos_fallidos` = 0. Luego **Gmail** (Send) con el recibo y el enlace `{{ $json.factura }}`.
5) Rama pago fallido: **Google Sheets** (Get Row(s)) por email para leer `intentos_fallidos`, luego **Code** que sume 1, luego **IF** con tres caminos según el número.
6) Intento 1: **Gmail** con asunto `Tu tarjeta ha sido rechazada, {{ $json.nombre }}` y el enlace al portal de cliente para actualizarla. Tono tranquilo, sin drama.
7) Intento 2 (Stripe reintenta solo a los 3 días): **Gmail** recordatorio y **Slack**/email a ti para que decidas si llamas.
8) Intento 3: **Gmail** avisando de la suspensión del acceso y **Google Sheets** poniendo `estado` = `suspendido`.
9) Rama cancelación: **Google Sheets** poner `estado` = `baja` y **Gmail** con una pregunta única: «¿Qué te ha faltado?». Añade un **Wait** de 30 días y un segundo **Gmail** de reactivación con descuento.

## Cómo probarla
- En Stripe, modo Test: usa la tarjeta `4242 4242 4242 4242` para un pago correcto y `4000 0000 0000 0341` para simular fallo tras el cobro.
- En Desarrolladores > Webhooks, pulsa «Enviar evento de prueba» para cada uno de los tres tipos.
- Mira en n8n la pestaña «Executions» que el Switch reparte bien y que la hoja se actualiza.

## Qué puede salir mal
- **El webhook no llega**: en n8n, la URL de test solo escucha mientras pulsas «Listen». Activa el workflow y usa la URL de producción.
- **El email viene vacío**: en Stripe algunas facturas no traen `customer_email`. Guarda el `customer_id` en la hoja al matricular y busca por ahí.
- **Duplicados**: Stripe reintenta el webhook si no respondes 200. Con Response Mode «Immediately» respondes al momento y no se repite. Aun así Stripe puede enviar el mismo evento dos veces: guarda el `id` del evento (`body.id`) en la hoja y descarta los repetidos.
- **Zona horaria**: los timestamps de Stripe son UTC. Ojo con las facturas de medianoche.
- **Legal**: guarda el consentimiento de domiciliación y conserva las facturas; en España Stripe emite el recibo pero la factura la haces tú.

## Cuánto cuesta
- Stripe: 1,5% + 0,25 € por cobro con tarjeta europea. Sin cuota fija.
- Google y n8n auto-alojado: gratis.
- Alternativa sin Stripe: sustituye el Webhook por un **Schedule Trigger** que lea los movimientos que apuntas a mano en la hoja. Cero comisiones, algo más de trabajo.
