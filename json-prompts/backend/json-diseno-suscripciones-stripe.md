# Diseñar un modelo de suscripciones para Stripe antes de escr…

**Tipo:** JSON prompt · **Área:** Backend · **Licencia:** CC BY 4.0

Diseña todos los detalles de tus suscripciones antes de Stripe: planes, pruebas, impagos, cancelación, eventos a atender.

## Qué es y qué hace

Prompt JSON que guía el diseño de una suscripción antes de tocar Stripe: planes, periodo de prueba, tratamiento de impagos, cancelación y eventos que hay que atender. Pide datos del negocio y devuelve un documento de decisiones para aprobar. Sirve para negocios que cobran cada mes a mano y quieren automatizarlo sin errores.

## Cómo usarla

1. Describe el servicio y los planes
2. Rellena impagos y cancelación
3. Revisa el documento de decisiones
4. Que lo revise un profesional

## Cuándo usarla

Cuando quieres cobrar mensualmente por un servicio y no sabes cuántos planes poner, qué hacer con los impagos ni qué eventos de Stripe tienes que atender.

## Cómo ganar dinero con ella

Se usa como primera sesión de un servicio de 'montaje de suscripciones' para negocios que hoy cobran a mano cada mes; la salida es el documento que se entrega y se aprueb…

- Primera sesión de montaje de suscripciones para negocios que cobran a mano…
- Documento de planes y condiciones de suscripción para aprobar antes de programar…
- Rediseño del modelo de cobros para reducir impagos en servicios mensuales…

**Precio orientativo:** 60–200 € por sesión. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "rol": "Eres una persona que ha montado suscripciones con Stripe para negocios pequeños en España y explica las cosas a alguien que no programa. Ayudas a decidir antes de configurar o programar nada.",
  "objetivo": "Diseñar el modelo de suscripción completo: planes, precios, prueba gratuita, impagos, cancelación, eventos de Stripe a escuchar y textos que ve el cliente. Nada de código en esta fase.",
  "contexto_negocio": {
    "que_vendo": "[DESCRIBE EL SERVICIO EN UNA O DOS FRASES]",
    "soy": "[AUTÓNOMO | SOCIEDAD]",
    "pais": "España",
    "moneda": "EUR",
    "tipo_cliente": "[PARTICULARES | EMPRESAS | AMBOS]",
    "clientes_actuales": "[NÚMERO APROXIMADO O 0]",
    "como_cobro_hoy": "[TRANSFERENCIA | BIZUM | NADA | OTRO]",
    "precios_que_tengo_en_la_cabeza": [
      { "nombre": "[PLAN 1]", "precio_mes_eur": "[IMPORTE]", "que_incluye": "[LISTA CORTA]" },
      { "nombre": "[PLAN 2 O BORRAR]", "precio_mes_eur": "[IMPORTE]", "que_incluye": "[LISTA CORTA]" }
    ],
    "prueba_gratuita_dias": "[0 | 7 | 14 | 30]",
    "quiero_pago_anual": "[SÍ | NO | NO LO SÉ]",
    "quien_emite_la_factura": "[STRIPE | MI PROGRAMA DE FACTURAS | NO LO SÉ]",
    "donde_vive_el_servicio": "[WEB PROPIA | SOLO ENLACES DE STRIPE | APP | NO HAY NADA AÚN]"
  },
  "decisiones_que_debes_ayudarme_a_tomar": [
    "Cuántos planes tener (recomienda pocos y justifica).",
    "Precio con IVA incluido o IVA aparte, según el tipo de cliente.",
    "Prueba gratuita con tarjeta o sin tarjeta, y qué implica cada una.",
    "Qué pasa cuando falla el cobro: cuántos reintentos, cuántos días de gracia, cuándo se corta el servicio.",
    "Cómo cancela el cliente (portal de cliente de Stripe o escribiéndome) y qué pasa con el resto del mes pagado.",
    "Si cambia de plan a mitad de mes, cómo se prorratea.",
    "Desde dónde sale la factura legal de cada cobro mensual."
  ],
  "eventos_de_stripe": {
    "instruccion": "Para cada evento de la lista, explica en una frase qué significa, qué debería pasar en mi negocio cuando llega y si es imprescindible o puede esperar. Añade los que falten para mi caso y quita los que no apliquen.",
    "lista_minima": [
      "checkout.session.completed",
      "customer.subscription.created",
      "invoice.paid",
      "invoice.payment_failed",
      "customer.subscription.updated",
      "customer.subscription.deleted",
      "customer.subscription.trial_will_end"
    ]
  },
  "formato_salida": {
    "seccion_1_planes": {
      "tipo": "tabla",
      "columnas": ["Plan", "Precio mes (EUR)", "Precio año (EUR) si aplica", "IVA incluido o aparte", "Qué incluye", "Para quién es"]
    },
    "seccion_2_ciclo_de_vida": {
      "tipo": "tabla",
      "columnas": ["Estado de la suscripción en Stripe", "Qué ve el cliente", "Qué hago yo", "Cuánto dura como máximo"],
      "estados_a_cubrir": ["trialing", "active", "past_due", "unpaid", "canceled", "incomplete"]
    },
    "seccion_3_impagos": {
      "tipo": "lista numerada",
      "contenido": "Secuencia día a día desde que falla el cobro hasta que se corta el servicio, con el texto exacto de cada email al cliente."
    },
    "seccion_4_eventos": {
      "tipo": "tabla",
      "columnas": ["Evento", "Qué significa", "Qué hago cuando llega", "Imprescindible (sí/no)"]
    },
    "seccion_5_textos_cliente": {
      "tipo": "lista",
      "contenido": "Texto de la página de precios, del email de bienvenida, del aviso de fin de prueba, del aviso de impago y de la confirmación de cancelación. Cortos y en español de España."
    },
    "seccion_6_lo_que_configuro_en_stripe": {
      "tipo": "lista numerada",
      "contenido": "Pasos en el panel de Stripe, en modo de prueba, en el orden en que hay que hacerlos. Sin código."
    },
    "seccion_7_preguntas_al_gestor": {
      "tipo": "lista",
      "contenido": "Solo lo que dependa de mi situación fiscal: IVA a clientes de la UE, retenciones, quién emite la factura."
    }
  },
  "reglas": [
    "Español de España, tuteando, frases cortas.",
    "No inventes comisiones de Stripe ni fechas legales. Si hace falta una cifra que no tienes, ponla entre corchetes y di dónde comprobarla.",
    "No propongas más de tres planes salvo que yo lo p
```
