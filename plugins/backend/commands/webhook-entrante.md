---
description: Revisa o construye la recepción de webhooks de un proveedor externo con verificación de firma, idempotencia, respuesta rápida y reproceso
argument-hint: [proveedor y evento, p. ej. "Stripe pago completado"]
---

Eres un ingeniero de integraciones. Vas a dejar en condiciones la recepción de avisos automáticos de: $ARGUMENTS.
Explica primero la idea en una frase: un webhook es el proveedor llamando a tu timbre para contarte que ha pasado algo. Si no abres, si abres tarde o si no compruebas quién llama, se lía.

FASE 1 - Contexto
Pregunta y espera respuesta:
1. ¿Qué eventos te envía el proveedor y cuáles te importan de verdad?
2. ¿Qué tiene que ocurrir en tu sistema con cada uno? (dar acceso, enviar el producto, marcar pedido).
3. ¿Ya está montado o partimos de cero? Si está montado, dime la dirección donde llega.
4. ¿Ha habido casos raros? (clientes que pagaron y no recibieron, gente que recibió dos veces).

FASE 2 - Las seis comprobaciones
Revisa el código y responde una por una con archivo, línea y veredicto:
1. FIRMA. ¿Se verifica la firma del proveedor con el secreto correspondiente antes de hacer nada? Si no, cualquiera puede enviarte un aviso falso de pago y llevarse el producto gratis. Es el fallo más grave y más común.
2. CUERPO CRUDO. La firma se calcula sobre el texto exacto recibido. Si tu framework transforma el cuerpo a objeto antes, la verificación falla o se hace mal. Comprueba que se guarda el cuerpo sin tocar.
3. IDEMPOTENCIA. Los proveedores reenvían. ¿Se guarda el identificador del evento y se ignora si ya se procesó? Sin esto, un reenvío entrega dos veces.
4. RESPUESTA RÁPIDA. ¿Se responde de acuerdo en menos de unos segundos y el trabajo pesado se hace después? Si tardas, el proveedor da por fallido el aviso y reintenta, multiplicando el lío.
5. ORDEN Y RETRASO. Los eventos pueden llegar desordenados o tarde. ¿El código aguanta que llegue el de cancelación antes que el de creación? Decide siempre según el estado que envía el evento, no según el orden de llegada.
6. REGISTRO. ¿Se guarda cada aviso recibido en crudo, con su fecha y resultado? Sin eso no podrás demostrar nada ni reprocesar.

FASE 3 - Diseño correcto
Describe el flujo recomendado en pasos numerados: recibir, verificar firma, guardar crudo, responder de acuerdo, encolar el procesado, procesar comprobando si ya se hizo, marcar resultado.
Define la tabla de eventos recibidos con sus campos y la clave única que evita duplicados.
Da también el procedimiento manual: cómo reprocesar a mano un evento que falló, sin pedirle nada al proveedor.

FORMATO DE RESPUESTA EXACTO
## Veredicto en una línea
Seguro, con agujeros o inseguro.
## Las seis comprobaciones
Tabla: Comprobación | Estado | Archivo y línea | Qué puede pasar si sigue así
## Flujo recomendado
Pasos numerados.
## Cambios de código
Por archivo, con el fragmento. Pregunta antes de aplicarlos.
## Cómo probarlo sin romper nada
Cómo usar el modo de pruebas del proveedor y su herramienta de reenvío, el comando exacto para enviarte un aviso falso y comprobar que lo rechazas por firma inválida, y cómo enviar dos veces el mismo evento y comprobar que solo se procesa uno.
## Qué mirar cada semana
Avisos fallidos, avisos ignorados por duplicado y avisos sin procesar.

SABRÁS QUE ESTÁ BIEN si un aviso falso sin firma válida se rechaza, si el mismo evento enviado tres veces produce un único efecto, y si puedes reprocesar a mano cualquier evento del último mes.
