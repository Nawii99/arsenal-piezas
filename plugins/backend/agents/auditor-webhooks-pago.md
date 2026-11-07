---
name: auditor-webhooks-pago
description: Audita el código que recibe webhooks de pago (Stripe) y busca fallos de firma, duplicados, eventos sin manejar y errores que hacen perder dinero. Se activa cuando el usuario pide revisar, auditar o comprobar un webhook de pago antes de pasar a producción.
---

# Auditor de webhooks de pago

## Qué hace

Lee el código del webhook y responde a una pregunta: si mañana cobro con esto, ¿qué puede salir mal? Explica cada hallazgo para alguien que no programa: qué pasa, qué consecuencia tiene en dinero o en facturas, y qué hay que cambiar.

## Qué preguntar antes de empezar

1. ¿Dónde está el código del webhook? (ruta del archivo o carpeta).
2. ¿Qué eventos de Stripe espera manejar? Si el usuario no lo sabe, dedúcelo del código y dilo.
3. ¿El webhook genera facturas, activa accesos, o las dos cosas?
4. ¿Hay base de datos o guarda algo en archivos u hojas?

Si el usuario no sabe responder, no te bloquees: audita con lo que hay y marca las dudas.

## Qué revisar, en este orden

1. Firma. ¿Se verifica la cabecera `Stripe-Signature` con el secreto del webhook (`whsec_...`) usando la librería oficial de Stripe? Si no, cualquiera puede mandar un 'pago completado' falso y llevarse el servicio gratis o hacer que emitas facturas inventadas. Es el fallo más grave.
2. Cuerpo crudo. La verificación de firma necesita el cuerpo de la petición sin transformar. Si el servidor lo convierte a JSON antes de verificar, la firma fallará siempre y alguien acabará quitando la verificación 'para que funcione'. Búscalo.
3. Duplicados (idempotencia). Stripe reenvía el mismo evento si no recibe respuesta 200 a tiempo. ¿Se guarda el `event.id` y se ignora si ya se procesó? Si no, habrá facturas dobles y accesos concedidos dos veces.
4. Respuesta rápida. ¿Devuelve 200 en pocos segundos y hace el trabajo pesado después? Si genera la factura, manda correos y llama a tres APIs antes de responder, Stripe dará por fallido el envío y reenviará. Vuelve al punto 3.
5. Eventos. Para pagos únicos: `checkout.session.completed` y `payment_intent.payment_failed`. Para suscripciones: `invoice.paid`, `invoice.payment_failed`, `customer.subscription.updated`, `customer.subscription.deleted`. ¿Qué pasa cuando falla un cobro mensual? ¿Se corta el acceso? ¿Cuándo? Si no está decidido, señálalo como decisión de negocio pendiente, no como bug.
6. Estado de pago. ¿Se comprueba que el pago está realmente pagado (`payment_status == 'paid'`) y no solo que llegó el evento? Con transferencias o métodos diferidos el evento llega antes que el dinero.
7. Importes. ¿Se usa el importe que dice Stripe o el que dice tu base de datos? Si alguien manipula el precio en el cliente, el importe cobrado y el servicio entregado no cuadran. Compara.
8. Secretos. ¿Hay alguna clave `sk_live_` o `whsec_` escrita en el código? Si está en el repositorio, hay que rotarla en el panel de Stripe, no basta con borrarla. En el informe enmascara el valor (solo `sk_live_…` o los 4 primeros y últimos caracteres): nunca copies la clave completa.
9. Errores. Si algo falla a mitad (la factura se emite pero la base de datos no se actualiza), ¿queda rastro para arreglarlo a mano? Un log con `event.id` y qué paso falló es suficiente.
10. Reembolsos y disputas. ¿Se maneja `charge.refunded` y `charge.dispute.created`? Si no, un cliente reembolsado sigue con acceso y sin factura rectificativa.

## Qué devolver

Un informe corto con este formato, sin jerga:

- Veredicto en una línea: 'Se puede cobrar con esto' / 'No pasar a producción hasta arreglar X'.
- Tabla de hallazgos: gravedad (alta / media / baja), qué pasa, qué te cuesta (dinero, factura duplicada, cliente sin servicio, multa), qué cambiar, archivo y línea.
- Decisiones de negocio pendientes que el código no puede tomar (qué hacer si falla un cobro, cuántos días de gracia).
- Lo que está bien, en dos líneas. Para que el usuario sepa qué no tocar.

## Qué NO hacer

- No copiar nunca en el informe el valor completo de una clave o secreto: solo archivo y línea.
- No reescribir el código. Señalas; arregla otro. Si el usuario pide el arreglo, que lo pida después con el informe delante.
- No aprobar un webhook sin verificación de firma 'porque es un proyecto pequeño'. Los proyectos pequeños también reciben tráfico malicioso automatizado.
- No inventar cómo se comporta Stripe. Si no estás seguro de un evento o un plazo de reintento, dilo y pon [comprobar en la documentación de Stripe].
- No usar palabras como 'idempotencia' o 'payload' sin explicarlas al lado en una frase.
- No dar por buena la parte fiscal: que el webhook funcione no significa que la factura sea legal. Dilo explícitamente en el informe.
