# Guardia del cobro: pedido de prueba automático a diario…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Cada mañana lanza un cobro real en modo prueba contra tu pasarela y confirma que el pago se crea, se confirma y dispara tu webhook de pedidos.

## Qué es y qué hace

Flujo de n8n que cada mañana crea un cobro de prueba en modo test de Stripe, lo confirma con una tarjeta de prueba y comprueba que tu webhook de pedidos lo recibe. Entra la clave secreta de modo test y la URL de tu webhook; sale un aviso si el pago falla o no llega la notificación. Nunca usa claves reales ni cobra dinero.

## Cómo usarla

1. Activa el modo test en Stripe y copia la clave sk_test
2. Crea el webhook de pedidos en n8n
3. Programa la prueba diaria con aviso de fallo
4. Que lo revise un profesional (cobros y pasarela de pago)

## Cuándo usarla

Úsalo cuando vendas online y quieras dormir tranquilo: es la avería más cara del negocio y la que menos se nota, porque nadie te escribe para decirte «no he podido pagarte».

## Cómo ganar dinero con ella

Un checkout roto un fin de semana es facturación cero. Detectarlo en horas en vez de en días recupera cientos o miles de euros al año.

- Monitorización del checkout para tiendas online que venden productos o cursos con pago directo.
- Revisión mensual de pagos y webhooks para negocios con suscripciones y reservas con cobro.
- Implantación de un control diario de pagos para infoproductores con lanzamientos puntuales.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**: usa las claves de **modo test** de Stripe para crear un intento de pago, confirmarlo con una tarjeta de prueba y verificar que tu sistema recibe la notificación. Además comprueba que tus claves y tu producto en modo real siguen activos. Para tiendas online, infoproductos, suscripciones y reservas con pago.
**Para quién no es**: si cobras solo por transferencia o Bizum manual.

### Lo que necesitas antes
- **Cuenta de Stripe** (gratis abrirla). En el panel, arriba a la derecha, activa **Modo de prueba** y ve a Desarrolladores > Claves de API: copia la clave secreta que empieza por `sk_test_`. Nunca uses la `sk_live_` en esta receta.
- **Un endpoint tuyo que reciba pedidos**: si tienes webhook propio, apunta el aviso a él. Si no, monta uno en n8n con un nodo **Webhook** (te da una URL) y regístralo en Stripe > Desarrolladores > Webhooks en modo prueba, evento `payment_intent.succeeded`.
- **Una hoja Google Sheets** «Guardia checkout» con `fecha`, `resultado`, `id_pago`, `ms_tardados`, `detalle`.
- **Telegram** con bot creado (@BotFather).
- **Si usas WooCommerce, Shopify o PayPal** en vez de Stripe: todos tienen modo sandbox con claves propias; el esquema de nodos es el mismo cambiando la URL y la autenticación.

### Los nodos, en orden
**1. Schedule Trigger** — Days, cada 1 día a las 7:00 y opcionalmente otra ejecución a las 19:00 (duplica el nodo o pon Hours entre triggers 12). Timezone `Europe/Madrid`.
**2. HTTP Request** («Crear pago») — POST `https://api.stripe.com/v1/payment_intents`. Authentication: Generic Credential Type > Header Auth, Name `Authorization`, Value `Bearer sk_test_...` (guárdalo como credencial, no lo escribas en el nodo). Body Content Type: `Form Urlencoded`. Parámetros: `amount` = `1000`, `currency` = `eur`, `payment_method` = `pm_card_visa`, `confirm` = `true`, `automatic_payment_methods[enabled]` = `true`, `automatic_payment_methods[allow_redirects]` = `never`, `description` = `Prueba automatica QA {{ $now.toMillis() }}`. Options: Never Error activado, Full Response activado. Settings: Retry On Fail, 2 intentos.
**3. IF** («¿Pagado?») — String: `{{ $json.body.status }}` equals `succeeded`.
**4. (Rama true) Wait** — 60 segundos, para dar tiempo al webhook.
**5. HTTP Request** («¿Llegó a mi sistema?») — GET a tu propia API o, si el webhook lo recoges en n8n y lo guardas en Sheets, usa aquí un nodo **Google Sheets** con Operation `Get Row(s)` y filtro por el `id` del pago: Lookup Column `id_pago`, Lookup Value `{{ $('Crear pago').first().json.body.id }}`. Always Output Data activado.
**6. IF** («¿Hay registro?») — String: `{{ $json.id_pago }}` is not empty.
**7. Google Sheets** — Append Row: `fecha` `{{ $now.format('dd/MM/yyyy HH:mm') }}`, `resultado` `OK` o `FALLO`, `id_pago`, `detalle`.
**8. Telegram** (cualquier rama de fallo) — Send Message: `🚨 CHECKOUT EN RIESGO. Paso fallido: {{ $json.detalle }}. Estado devuelto por Stripe: {{ $('Crear pago').first().json.body.status }}. Comprueba la tienda ya.`
**9. HTTP Request** («Comprobar precios en real») — GET `https://api.stripe.com/v1/prices?active=true&limit=20` con la clave **restringida de solo lectura** de modo real (Stripe > Claves restringidas > permiso Read en Prices). Luego un **Code** que compare los importes con los que tú esperas:
```js
const esperados = { 'price_1AbcDef': 3990, 'price_1XyzGhi': 9900 };
const mal = [];
for (const p of $json.data) {
  if (esperados[p.id] !== undefined && p.unit_amount !== esperados[p.id]) {
    mal.push(p.id + ' cuesta ' + (p.unit_amount / 100) + ' € y deberia costar ' + (esperados[p.id] / 100) + ' €');
  }
}
return [{ json: { mal: mal.join(' | '), hayError: mal.length > 0 } }];
```
**10. IF + Telegram** — si `hayError`, aviso de precio cambiado.

### Cómo probarla
- Lánzalo a mano: en el panel de Stripe (modo prueba) debe aparecer un pago de 10,00 € «Correcto» con la descripción «Prueba automatica QA».
- Prueba el fallo: cambia `pm_card_visa` por `pm_card_visa_chargeDeclined` (tarjeta de prueba que Stripe rechaza siempre). Debes recibir la alerta de Telegram.
- Prueba el segundo tramo desconectando el webhook en Stripe: la ejecución debe avisar de que el pago se hizo pero tu sistema no se enteró.

### Qué puede salir mal
- **Usar la clave real por error**: te cobrarías a ti mismo. Nombra la credencial en n8n como `STRIPE TEST - NO TOCAR` y no guardes nunca la live en el mismo sitio.
- **`allow_redirects` sin poner a `never`**: Stripe te devolverá `requires_action` y creerás que está roto.
- **El modo test no prueba tu pasarela real**: comprueba también, una vez al mes y a mano, una compra real de 1 € que luego reembolsas. Esta receta cubre el 90%, no el 100%.
- **Reintentos duplicados**: si activas Retry On Fail en el nodo de creación, puedes crear dos pagos de prueba. Es inofensivo en test, pero no copies ese ajuste a producción.

### Cuánto cuesta
- Stripe en modo prueba: **0 €**, no cobra comisiones ni por transacción de test.
- n8n, Sheets y Telegram: **0 €**. Total: **0 €/mes**.
