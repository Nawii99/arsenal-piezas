# Prueba semanal de que tu cobro con tarjeta funciona…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Simula un pago con tarjeta de prueba en Stripe y comprueba que tu cuenta real sigue habilitada para cobrar y sin pagos bloqueados sin resolver.

## Qué es y qué hace

Cada lunes hace dos comprobaciones: un pago de prueba en modo test de Stripe para confirmar que el checkout funciona, y una lectura del estado de tu cuenta real para ver si los cobros y pagos están habilitados y sin requisitos pendientes. Entrada: claves de test y de solo lectura; salida: aviso por Telegram si algo falla. Se monta en n8n con la API de Stripe y Telegram.

## Cómo usarla

1. Crear las claves de test y de solo lectura
2. Probar el pago de prueba a mano
3. Fijar el aviso en Telegram
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando cobres online y no puedas permitirte descubrir un fin de semana que el checkout lleva días rechazando tarjetas o que Stripe te pidió papeles y limitó la cuenta.

## Cómo ganar dinero con ella

Un checkout roto un fin de semana en una tienda que factura 4.000 €/mes son unos 250 € que no vuelven. La comprobación es gratis y tarda segundos.

- Vigilar el cobro online de tiendas pequeñas que venden con Stripe.
- Ofrecer comprobaciones semanales de checkout a agencias de e-commerce.
- Montar un informe mensual de salud de la cuenta de cobros para el dueño.

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Dos comprobaciones cada lunes: una, que la pasarela procesa un pago (usando el modo test de Stripe, sin mover un euro real); dos, que tu cuenta real sigue con los cobros y los pagos a tu banco habilitados y sin requisitos pendientes. Para cualquiera que venda online con Stripe.

## Lo que necesitas antes
- n8n.
- Claves de Stripe: en el panel de Stripe, Desarrolladores > Claves de API. Copia la clave secreta de **modo test** (`sk_test_...`) y la de **modo real** (`sk_live_...`). Guárdalas como dos credenciales «Header Auth» distintas en n8n con Name `Authorization` y Value `Bearer sk_test_...` / `Bearer sk_live_...`, o usa dos credenciales «Stripe API».
- Bot de Telegram.
- Muy importante: la clave real solo se usa para LEER el estado de la cuenta. Nunca crees cargos reales de prueba.

## Los nodos, en orden
1. **Schedule Trigger** — Days, Day of Week: Monday, Hour: 8.
2. **HTTP Request** (nombre: «Pago de prueba») — Method: POST, URL `https://api.stripe.com/v1/payment_intents`, Authentication: la credencial de test. Body Content Type: Form-Urlencoded. Parámetros: `amount` = `1200`, `currency` = `eur`, `payment_method` = `pm_card_visa`, `confirm` = `true`, `automatic_payment_methods[enabled]` = `true`, `automatic_payment_methods[allow_redirects]` = `never`, `description` = `QA semanal`. Never Error: on.
3. **HTTP Request** (nombre: «Estado cuenta») — GET `https://api.stripe.com/v1/account` con la credencial real. Never Error: on.
4. **HTTP Request** (nombre: «Pagos fallidos reales») — GET `https://api.stripe.com/v1/charges` con la credencial real, Query Parameters: `limit` = `100`, `created[gte]` = `={{ Math.floor(Date.now()/1000) - 604800 }}`.
5. **Code** (nombre: «Diagnóstico»). Run Once for All Items.
```js
const pago = $('Pago de prueba').first().json;
const cuenta = $('Estado cuenta').first().json;
const cargos = $('Pagos fallidos reales').first().json.data || [];
const fallidos = cargos.filter(c => c.status === 'failed').length;
const total = cargos.length || 1;
const avisos = [];
if (pago.status !== 'succeeded') avisos.push('El pago de PRUEBA no se completó: ' + (pago.error?.message || pago.status));
if (!cuenta.charges_enabled) avisos.push('Tu cuenta NO puede cobrar ahora mismo');
if (!cuenta.payouts_enabled) avisos.push('Stripe no te está transfiriendo el dinero al banco');
const pend = cuenta.requirements?.currently_due || [];
if (pend.length) avisos.push('Stripe te pide documentación: ' + pend.join(', '));
if (fallidos / total > 0.3) avisos.push('El ' + Math.round(fallidos*100/total) + '% de los cobros de esta semana han fallado');
return [{ json: { ok: avisos.length === 0, texto: avisos.join(' | ') } }];
```
6. **IF** — Boolean `={{ $json.ok }}` is false.
7. **Telegram** — `=💳 PROBLEMA DE COBROS: {{ $json.texto }}`.
8. Rama buena, opcional: **Telegram** una vez al mes con «cobros ok», para saber que la vigilancia sigue viva.

## Cómo probarla
Cambia `pm_card_visa` por `pm_card_visa_chargeDeclined` (tarjeta de prueba que Stripe rechaza a propósito) y ejecuta: debe llegarte el aviso. Vuelve a poner `pm_card_visa` y comprueba que queda en silencio. Verifica en el panel de Stripe, con el interruptor «Modo de prueba» activado, que ves el pago de 12 €: en modo real no debe aparecer nada.

## Qué puede salir mal
- **Confundir las claves**: si usas `sk_live_` en el paso 2 harás un cargo real a una tarjeta inexistente y te dará error, o peor. Revisa dos veces que el paso 2 usa la credencial test.
- **Esto prueba Stripe, no tu botón**: si quieres cubrir el botón de tu web, combínalo con la receta de prueba del formulario apuntando a la URL de tu Checkout y comprobando que devuelve 200.
- **Otras pasarelas**: con Redsys o PayPal no hay equivalente tan limpio; en ese caso vigila al menos que la página de pago cargue y revisa a diario los pedidos con estado «pendiente de pago» anómalos.
- **Cuentas nuevas**: `requirements.currently_due` suele traer cosas los primeros días; no te asustes, resuélvelas.

## Cuánto cuesta
Gratis. Stripe no cobra por el modo test ni por consultar la API; sus comisiones son solo sobre ventas reales. n8n auto-alojado, 0 €.
