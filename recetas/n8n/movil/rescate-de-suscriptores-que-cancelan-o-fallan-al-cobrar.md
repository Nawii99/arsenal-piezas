# Rescate de suscriptores que cancelan o fallan al cobrar…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Escucha los avisos de RevenueCat y lanza mensajes distintos según si el usuario canceló por decisión propia o porque le rebotó la tarjeta.

## Qué es y qué hace

Receta de n8n que escucha los eventos de facturación y cancelación de RevenueCat. Si el cobro falló por la tarjeta, envía un aviso con los pasos para actualizar el método de pago; si el usuario canceló, le pregunta el motivo; si la prueba gratuita está por acabar, le recuerda el valor antes del cobro. Entrada: webhooks de RevenueCat y clave secreta de API. Salida: correo adecuado a cada evento. Requiere consentimiento de contacto y RGPD.

## Cómo usarla

1. Configura el webhook en RevenueCat
2. Escribe los tres mensajes
3. Revisa el ingreso recuperado cada mes
4. Que lo revise un profesional

## Cuándo usarla

Cuando cobras suscripciones dentro de la app y ves bajas cada mes sin saber por qué. Especialmente si muchas son fallos de pago que se arreglan solos con un recordatorio.

## Cómo ganar dinero con ella

Recuperar el 20% de los fallos de tarjeta en una app con 200 suscriptores de 5 € son unos 100-200 € al año que ya no se pierden.

- Recuperación de cobros fallidos para una app de suscripción pequeña…
- Avisos de fin de prueba gratuita para una app de pago de un negocio…
- Informe mensual de ingresos recuperados para el dueño de la app…

**Precio orientativo:** 250–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recibe los eventos de RevenueCat (cancelación, problema de facturación, prueba a punto de acabar) y actúa distinto en cada caso: al que le falló la tarjeta le manda un aviso claro con qué hacer, al que cancela le pregunta el motivo, y al de la prueba gratuita le recuerda el valor antes de que le cobren. Para apps con suscripción que están perdiendo dinero por silencio.

## Lo que necesitas antes
- Cuenta de RevenueCat con tu app ya configurada (gratis hasta 2.500 $ de ingresos mensuales).
- En RevenueCat: Project Settings → Integrations → **Webhooks**, URL la de tu nodo Webhook y un valor en «Authorization header» que tú inventas.
- Los eventos que te interesan: `CANCELLATION`, `BILLING_ISSUE`, `SUBSCRIPTION_PAUSED`, `EXPIRATION`.
- Una **API key secreta** de RevenueCat (Project Settings → API keys) para consultar después si el usuario ha vuelto.
- Credencial de Gmail o SMTP para los correos, y el email del usuario guardado como atributo `$email` en RevenueCat (si no lo tienes, el flujo solo puede mandar push).
- Cuenta de OneSignal para el aviso push (plan gratuito generoso) con su App ID y REST API Key.
- Hoja de Google Sheets `bajas` con: fecha, app_user_id, tipo, producto, motivo, recuperado.

## Los nodos, en orden
1. **Webhook** — POST, Path: `revenuecat`, Authentication: Header Auth con el valor que pusiste en RevenueCat, Respond: Immediately (RevenueCat espera un 200 rápido o reintenta).
2. **Code** (nombre: Extraer evento) — saca tipo, id de usuario, producto, email y fecha. Código abajo.
3. **Google Sheets** — Append Row en `bajas`. Guarda siempre, aunque luego no hagas nada.
4. **Switch** — Rules sobre `{{ $json.tipo }}`: salida 0 `BILLING_ISSUE`, salida 1 `CANCELLATION`, salida 2 `EXPIRATION`, fallback resto.
5. Rama BILLING_ISSUE → **Gmail** Send. Asunto: `No hemos podido cobrar tu suscripción`. Cuerpo: explica que se arregla en Ajustes → tu nombre → Pagos y suscripciones, con el enlace `https://apps.apple.com/account/billing` para iOS o `https://play.google.com/store/paymentmethods` para Android según `{{ $json.tienda }}`. → **OneSignal** (nodo HTTP Request POST a `https://onesignal.com/api/v1/notifications`, header `Authorization: Basic TU_REST_KEY`, body con `include_external_user_ids: ["{{$json.app_user_id}}"]` y el mensaje).
6. Rama CANCELLATION → **Wait** de 1 día (para no parecer desesperado) → **Gmail** con una pregunta única: «¿Qué te ha faltado?» y tres enlaces a un Google Form prerellenado (caro / no lo uso / le falta X).
7. Rama EXPIRATION → **Wait** 7 días → **HTTP Request** GET `https://api.revenuecat.com/v1/subscribers/{{ $json.app_user_id }}` con header `Authorization: Bearer TU_API_KEY_SECRETA` → **IF** para ver si sigue sin suscripción activa → **Gmail** con una oferta de vuelta (por ejemplo un mes al 50% con un código promocional generado en App Store Connect o Play Console).
8. **Google Sheets** — Update Row marcando `recuperado` cuando en un evento posterior de tipo `RENEWAL` aparezca el mismo app_user_id.

## El trozo de código (nodo Code «Extraer evento»)
```javascript
const e = ($input.first().json.body || {}).event || {};
const tienda = (e.store || '').toUpperCase();
return [{ json: {
  tipo: e.type,
  app_user_id: e.app_user_id || e.original_app_user_id,
  email: (e.subscriber_attributes?.$email?.value || '').toLowerCase(),
  producto: e.product_id || '',
  precio: e.price_in_purchased_currency ?? null,
  moneda: e.currency || 'EUR',
  tienda: tienda.includes('APP_STORE') ? 'ios' : (tienda.includes('PLAY') ? 'android' : 'otra'),
  motivo: e.cancel_reason || e.expiration_reason || '',
  periodo_prueba: e.period_type === 'TRIAL',
  fecha: new Date(e.event_timestamp_ms || Date.now()).toISOString()
}}];
```

## Cómo probarla
- RevenueCat tiene un botón «Send test event» en la pantalla de webhooks: úsalo con el flujo en modo test y mira que llega cada tipo.
- Haz una compra de prueba en el entorno sandbox de Apple y cancélala desde los ajustes del dispositivo de pruebas: verás el ciclo real.
- Antes de conectar Gmail, sustituye el envío por un nodo Telegram a ti mismo durante una semana para leer todos los correos que se habrían mandado.

## Qué puede salir mal
- **Correos a quien no toca**: en sandbox los eventos se repiten mucho. Filtra con un IF `{{ $json.environment }}` distinto de `SANDBOX` (viene en el evento) antes de enviar nada.
- **Reintentos de RevenueCat**: si no devuelves 200 en pocos segundos, repite el envío y duplicas correos. Por eso el Webhook responde inmediatamente.
- **Sin email**: muchos usuarios de app no dan correo. Ten siempre la vía push como plan B y guarda `$email` en RevenueCat desde la app.
- **Cancelar no es irse**: la suscripción sigue activa hasta la fecha de expiración. No mandes «te echaremos de menos» el primer día, de ahí el Wait.
- **RGPD**: un correo comercial de recuperación necesita base legal; con relación contractual previa suele valer, pero incluye siempre la baja.

## Cuánto cuesta
RevenueCat gratis hasta 2.500 $/mes de ingresos rastreados. OneSignal gratis hasta 10.000 suscriptores web/push móvil. Gmail y Sheets gratis. n8n auto-alojado 0 €. Coste: prácticamente 0 € hasta que factures bien.
