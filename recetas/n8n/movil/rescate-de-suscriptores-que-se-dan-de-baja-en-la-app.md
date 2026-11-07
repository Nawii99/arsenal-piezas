# Rescate de suscriptores que se dan de baja en la app…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Cuando alguien cancela su suscripción, la IA prepara un email personal según el motivo y el tiempo que llevaba, y te lo apunta en el CRM para hacer seguimiento.

## Qué es y qué hace

Receta de n8n que recibe por webhook la cancelación de una suscripción desde RevenueCat. Consulta cuánto tiempo llevaba el cliente y su plan y, según el caso, envía un correo distinto (encuesta corta, oferta de pausa o contacto personal) que puede redactar una IA. Registra el motivo en Airtable para ver las bajas agrupadas. Entrada: eventos de cancelación y datos del cliente. Salida: correo enviado y fila en la base. Requiere consentimiento de contacto y cumplir el RGPD.

## Cómo usarla

1. Activa el webhook en RevenueCat
2. Define los tres correos y sus reglas
3. Revisa las bajas agrupadas cada mes
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tienes suscripciones dentro de la app y las bajas se te van sin que nadie hable con esa persona ni sepas por qué se fue.

## Cómo ganar dinero con ella

Recuperar un 10% de las bajas es dinero que ya no ibas a ver. Un suscriptor de 9,99 € al mes que se queda seis meses más son 60 € por cada rescate.

- Recuperación de bajas para una app de suscripción de un estudio pequeño…
- Encuesta de salida automática para apps de pago de un negocio…
- Informe mensual de motivos de baja para decidir mejoras de producto…

**Precio orientativo:** 250–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
RevenueCat avisa a n8n en el momento en que alguien cancela la renovación automática. n8n mira cuánto tiempo llevaba de cliente y qué plan tenía, y manda un email distinto según el caso: encuesta corta si era nuevo, oferta de pausa si llevaba mucho, contacto personal si gastaba mucho.
Guarda todo en Airtable para que veas los motivos de baja agrupados.
Es para apps con suscripción, de cualquier tamaño.

## Lo que necesitas antes
n8n.
RevenueCat con los webhooks activados: Project Settings, Integrations, Webhooks, pones la URL de n8n y un Authorization header inventado (por ejemplo «Bearer secreto123») para que nadie más te llame.
Clave de OpenAI.
Brevo o Gmail para enviar el email.
Base de Airtable «Bajas» con campos: email, plan, dias_cliente, motivo, fecha, recuperado. La API key en airtable.com/create/tokens.

## Los nodos, en orden
1. «Webhook». Method POST, ruta /baja-suscripcion. En Options activa Authentication tipo Header Auth con el mismo valor que pusiste en RevenueCat.
2. «IF» (filtrar el tipo de evento). Condición: {{ $json.body.event.type }} igual a CANCELLATION. RevenueCat manda muchos tipos de evento; solo nos interesa este.
3. «Code» (calcular antigüedad y valor). Código completo:
```js
const e = $input.first().json.body.event;
const compra = e.purchased_at_ms ? new Date(e.purchased_at_ms) : new Date();
const dias = Math.round((Date.now() - compra.getTime()) / 86400000);
let segmento = 'nuevo';
if (dias > 30 && dias <= 180) segmento = 'medio';
if (dias > 180) segmento = 'fiel';
return [{ json: {
  email: e.subscriber_attributes?.$email?.value || '',
  plan: e.product_id || '',
  motivo: e.cancel_reason || 'sin especificar',
  precio: e.price || 0,
  dias: dias,
  segmento: segmento,
  app_user_id: e.app_user_id
}}];
```
4. «IF». Si email está vacío, ve directo a Airtable y no envíes nada (no tienes a quién escribir).
5. «Switch» por {{ $json.segmento }} con tres salidas.
6. «OpenAI» (Message a model), uno por rama o uno común con el segmento en el prompt. Prompt: «Escribe un email breve, español de España, tuteando, firmado por el fundador de TU_APP, para alguien que acaba de cancelar. Segmento {{ $json.segmento }}, llevaba {{ $json.dias }} días, motivo declarado {{ $json.motivo }}. Si es nuevo, pregunta qué le falló con una sola pregunta. Si es medio, ofrece pausar la suscripción 2 meses. Si es fiel, ofrécele hablar 10 minutos por teléfono. Nada de tono corporativo. Máximo 120 palabras».
7. «Wait». Resume After Time Interval, 2 horas. Escribir en el segundo exacto de la cancelación queda raro y agresivo.
8. «Brevo» (Send transactional email) al {{ $json.email }} con el texto generado.
9. «Airtable» (Create Record) guardando todos los campos y recuperado en falso.
10. Flujo aparte de seguimiento: «Schedule Trigger» semanal más «Airtable» (Search) de bajas de hace 30 días más «HTTP Request» a RevenueCat para ver si volvieron, y «Airtable» (Update) marcando recuperado.

## Cómo probarla
RevenueCat tiene un botón «Send test event» en la configuración del webhook. Envíalo y comprueba que el IF lo filtra bien.
Para probar el email entero, cambia temporalmente el destinatario por tu propio correo y fuerza cada uno de los tres segmentos editando el valor en el Code.

## Qué puede salir mal
El email no siempre viene: solo si lo has guardado como atributo del suscriptor en RevenueCat. Pídelo en el registro de la app y guárdalo con setEmail.
Una cancelación no es una baja inmediata: el usuario sigue teniendo acceso hasta que acaba el periodo. No le escribas como si ya se hubiera ido.
Ojo con escribir a quien cancela y vuelve a suscribirse el mismo día: filtra por app_user_id repetidos en Airtable.
Cumple el RGPD: este es un email de servicio, pero si aprovechas para vender necesitas base legal. Incluye siempre enlace de baja.

## Cuánto cuesta
n8n autoalojado (Community Edition) y Airtable: gratis (Airtable free llega a 1.000 registros por base); n8n Cloud tiene una prueba gratuita temporal y después planes de pago. Brevo: 300 emails al día gratis. RevenueCat gratis hasta 2.500 $ al mes. OpenAI: céntimos.
