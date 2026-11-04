---
name: plan-precios-cobro-y-bajas
description: Diseña precios, cobro con Stripe y plan contra las bajas de un producto o servicio de pago recurrente, partiendo de tus costes. Úsala cuando vayas a cobrar por primera vez o quieras mejorar ingresos sin perder clientes.
---

# Plan de precios, cobro y bajas

## Qué hace
Te ayuda a decidir cuánto cobrar, cómo cobrar y cómo evitar que los clientes se vayan. Parte de tus costes y de tu cliente, no de precios de moda. Devuelve un documento con huecos [ENTRE CORCHETES] donde falten datos.

## Qué preguntar antes de empezar
1. ¿Qué vendes (servicio, suscripción, curso, herramienta con IA) y a quién? Particulares (consumidores) o empresas.
2. ¿Cuánto te cuesta atender a un cliente al mes? Herramientas, tu tiempo (horas por tu precio hora) y, si usas IA por API, el coste por uso. Si no lo sabes, lo calculamos juntos.
3. ¿Cobras ya? Precio actual, número de clientes y cuántos se dieron de baja el último mes.
4. ¿Cómo cobras o quieres cobrar: Stripe, transferencia, otro?
5. ¿Eres autónomo o sociedad? ¿Vendes solo en España o también a otros países de la UE? ¿Tu gestor conoce este negocio?
6. ¿Cuántas semanas y cuántos clientes puedes dedicar a probar precios?

## Paso a paso
1. Suelo de precio. Coste por cliente, más comisión de cobro, más tu parte de costes fijos, más el margen que quieres. El precio no puede quedar por debajo. Calcula siempre con el precio sin IVA. La tarifa de Stripe cámbiala por la de tu panel: [TARIFA DE STRIPE]. Algunas funciones de suscripciones tienen coste aparte.
2. Modelo de cobro. Razona cuál encaja y cuál descartas:
  - Pago único: cuando se entrega y se acabó.
  - Suscripción mensual o anual: cuando el valor continúa. El plan anual con descuento de [DESCUENTO ANUAL EN %] reduce bajas.
  - Por uso o créditos: cuando tu coste sube con el uso, como pasa con la IA.
  - Freemium: solo si el plan gratis te cuesta casi nada por usuario. Con IA, pon un tope de uso.
  - Prueba gratuita: con tarjeta o sin ella. Sin tarjeta entra más gente y paga menos. Con tarjeta, el aviso del cobro posterior tiene que ser clarísimo.
3. Planes. Dos o tres niveles. Para cada uno: nombre, precio sin IVA y con IVA, qué incluye y el límite que lo diferencia. Una sola medida que el cliente entienda: usuarios, informes, mensajes. El plan del medio es el que quieres vender.
4. Descuentos y precios dinámicos. Reglas claras y por escrito. Si el precio cambia según el país o la fecha, se explica. Si cambia según datos de la persona (perfil, comportamiento), en la UE hay que informar al consumidor, y es mejor evitarlo. El precio tachado de una rebaja debe ser el más bajo que aplicaste en los 30 días anteriores. Que lo confirme tu asesor.
5. Cobro sin programar. Stripe tiene enlaces de pago (Payment Links) para un producto, Checkout para una web y un portal de cliente donde se gestionan y se dan de baja solos. Pruébalo primero en modo de prueba con la tarjeta de test 4242 4242 4242 4242. No pases al modo real hasta que tu gestor confirme IVA y facturación.
6. Bajas. Separa dos tipos:
  - Voluntarias: pregunta el motivo al darse de baja (tres opciones y «otro»). Ofrece pausar o bajar de plan, sin esconder el botón de baja.
  - Involuntarias (el pago falla): reintentos automáticos de cobro, aviso por email antes de que caduque la tarjeta y un mensaje claro para actualizarla.
  - Primeras semanas: un onboarding corto para que el cliente llegue pronto a su primer resultado.
7. Experimento de precios. Un solo cambio cada vez. [NÚMERO DE CLIENTES] o [NÚMERO DE SEMANAS] por variante. Medir conversión a pago y bajas al segundo mes. Decidir de antemano qué haces si sale peor.
8. Escenarios. Tres: prudente, medio y optimista. Ingresos mensuales = clientes por precio sin IVA, menos costes. Con tus números y etiquetados como hipótesis, no como previsión.

## Qué devolver (un documento con estos apartados)
1. Diagnóstico en cinco líneas.
2. Costes y suelo de precio (tabla).
3. Modelo recomendado y por qué, y el que descartas.
4. Tabla de planes.
5. Plan de cobro paso a paso.
6. Plan contra las bajas, con cinco acciones como máximo.
7. Experimento de precios.
8. Escenarios.
9. Para revisar con tu gestor o asesor (lista).
10. Datos que faltan.

## Qué NO hacer
- No inventes cifras de conversión, bajas del sector ni precios de la competencia. Si falta el dato, [DATO QUE FALTA].
- No prometas ingresos. Los escenarios son cuentas con tus números.
- No pidas claves de Stripe (las que empiezan por sk_ o rk_) ni datos de tarjetas en el chat. No crees cobros, reembolsos ni suscripciones reales.
- No recomiendes trucos oscuros: baja escondida, cobro tras la prueba sin aviso claro, urgencia falsa o rebajas con un precio anterior inventado. Además de feo, incumple normas de consumo.
- No subas el precio a clientes actuales sin avisar con antelación y sin mirar lo que firmaron.
- No des consejo fiscal. IVA (el general en España es el 21 %, con otros tipos según el caso), alta de actividad, facturas y venta a consumidores de otros países de la UE los confirma tu gestor.
- Con consumidores hay derecho de desistimiento de 14 días en ventas online, con excepciones para servicios digitales si hay consentimiento expreso. Condiciones de venta y política de bajas las revisa un asesor antes de cobrar.
- No dejes un plan gratis con coste ilimitado para ti.
