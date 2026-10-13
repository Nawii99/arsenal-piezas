# Alarma de bajas de suscripción con rescate automático…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Escucha los eventos de tus suscripciones (RevenueCat), apunta altas y bajas en una hoja y manda un correo de rescate a quien cancela.

## Qué es y qué hace

Flujo de n8n que recibe en tiempo real los eventos de RevenueCat (compras, renovaciones, problemas de pago y cancelaciones), los guarda en Google Sheets y tres días después de una baja envía un correo de rescate. Entran el JSON del evento y el correo guardado como atributo del usuario; sale una fila en la hoja y el correo enviado. Requiere RevenueCat integrado en la app y Gmail en n8n.

## Cómo usarla

1. 1. Integra RevenueCat en la app y guarda el correo del usuario
2. 2. Crea el webhook de RevenueCat y la hoja Suscripciones
3. 3. Revisa el texto del correo de rescate
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando cobres suscripciones dentro de la app y no tengas ni idea de cuánta gente se va cada semana ni por qué.

## Cómo ganar dinero con ella

Recuperar un 5 % de las bajas de una suscripción de 4,99 € al mes son cientos de euros al año. Y te ahorra montar un panel de métricas.

- Análisis de bajas para apps con suscripción que no saben por qué se va la gente cada semana.
- Correo de rescate automatizado para apps con suscripción mensual que quieren recuperar cancelaciones.
- Panel de altas y bajas para pequeños equipos que necesitan métricas sin contratar herramientas de analítica.

**Precio orientativo:** 200–450 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recibe en tiempo real cada compra, renovación, problema de pago y cancelación de tus suscripciones, las guarda ordenadas y dispara un correo de rescate a los tres días de una baja.
Para apps con suscripción (iOS y Android) que quieren entender su churn sin contratar herramientas de analítica.

## Lo que necesitas antes
Cuenta de RevenueCat: es gratis hasta 2.500 $ de ingresos mensuales y ya gestiona las compras dentro de la app en iOS y Android.
RevenueCat integrado en la app por tu desarrollador (es su parte del trabajo, un par de horas).
Que en tu app guardes el correo del usuario como «attribute» en RevenueCat (`$email`), si no, no podrás mandarle nada.
Gmail y Google Sheets conectados en n8n. Hoja `Suscripciones` con columnas: fecha, evento, id_usuario, email, producto, pais, importe.

## Los nodos, en orden
1. **Webhook**: POST, Path `revenuecat`. En RevenueCat, Project settings > Integrations > Webhooks, pega la URL y pon un valor en «Authorization header» (por ejemplo `Bearer miclavelarga123`).
2. En el Webhook de n8n, Authentication = Header Auth, con ese mismo nombre y valor. Sin esto, cualquiera podría inventarte eventos.
3. **Code**: aplana el evento de RevenueCat. Código abajo.
4. **Google Sheets** (Append): hoja `Suscripciones`, mapea todos los campos.
5. **Switch**: campo `{{ $json.evento }}`, salidas para `INITIAL_PURCHASE`, `CANCELLATION`, `BILLING_ISSUE` y el resto.
6. Salida CANCELLATION — **Telegram**: «Baja: {{ $json.producto }} de {{ $json.pais }}».
7. Salida CANCELLATION — **Wait**: modo «After Time Interval», 3 días.
8. Después del Wait — **IF**: que el email no esté vacío; y luego **Gmail** con el correo de rescate.
9. Salida BILLING_ISSUE — **Gmail** inmediato: «Tu pago no ha pasado, revisa la tarjeta» (esta es la que más dinero recupera).

## El nodo Code
```javascript
const e = ($input.first().json.body || {}).event || {};
const attrs = e.subscriber_attributes || {};
return [{ json: {
  fecha: new Date(e.event_timestamp_ms || Date.now()).toISOString(),
  evento: e.type || 'DESCONOCIDO',
  id_usuario: e.app_user_id || '',
  email: (attrs.$email && attrs.$email.value) || '',
  producto: e.product_id || '',
  pais: e.country_code || '',
  importe: e.price_in_purchased_currency || 0
}}];
```

## Cómo probarla
RevenueCat tiene un botón «Send test event» en la pantalla de webhooks: úsalo con el Webhook de n8n en modo escucha y comprueba que el Code no falla.
Haz una compra de prueba en modo sandbox desde tu móvil y cancélala desde Ajustes: verás el ciclo entero en la hoja.
Baja el Wait a 2 minutos mientras pruebas y luego lo subes a 3 días.

## Qué puede salir mal
RevenueCat reintenta el webhook si no le respondes 200; si tu n8n está apagado perderás eventos, así que la hoja es tu red de seguridad, no la fuente única.
Eventos duplicados: RevenueCat puede reenviar el mismo. Si te importa, guarda el `id` del evento en una columna y descarta repetidos con un Google Sheets de búsqueda previa.
Sin `$email` no hay rescate posible: pide a tu desarrollador que lo mande al identificar al usuario.
Cuidado con la privacidad: guardas correos de clientes, así que la hoja debe ser privada y estar en tu registro de tratamientos del RGPD.

## Cuánto cuesta
RevenueCat gratis hasta 2.500 $/mes de ingresos (luego un porcentaje pequeño). n8n auto-alojado, Sheets, Gmail y Telegram, gratis.
