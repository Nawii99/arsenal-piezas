---
name: cobrar-servicio-con-stripe
description: Monta el cobro de un servicio con Stripe (pago único o suscripción) con IVA de España y factura legal. Se activa cuando el usuario quiere empezar a cobrar por un servicio o producto digital.
---

# Cobrar un servicio con Stripe

## Qué hace

Te deja con un enlace de pago (o una página de pago) funcionando en modo prueba, con el IVA configurado, y con claro qué factura recibe el cliente y quién la emite. No toca producción hasta que tú lo digas.

## Qué preguntar antes de empezar (una sola tanda, no de una en una)

1. ¿Eres autónomo, sociedad o todavía no estás dado de alta? Si no estás dado de alta, para aquí: cobrar sin estar de alta en Hacienda tiene sanción. Esto no lo arregla ningún código.
2. ¿Vendes a particulares, a empresas o a los dos? Cambia el IVA y el tipo de factura.
3. ¿Vendes solo en España o también a otros países de la UE? Fuera de España el IVA se complica (OSS). Si es así, activa Stripe Tax y avisa de que tiene coste por transacción [comprobar tarifa en stripe.com/es/tax].
4. ¿Pago único, suscripción mensual, o los dos?
5. ¿Precio con IVA incluido o IVA aparte? A particulares en España el precio se anuncia con IVA incluido. A empresas se suele anunciar sin IVA.
6. ¿Tienes ya cuenta de Stripe verificada? Si no, la verificación pide DNI, cuenta bancaria y a veces justificante de actividad. Puede tardar días. Empieza por ahí.

## Paso a paso

1. Modo prueba siempre primero. Las claves de prueba empiezan por `sk_test_` y `pk_test_`. Las de producción por `sk_live_`. Nunca pegues una clave `sk_live_` en un chat, un correo, un repositorio, un nodo de n8n, una variable `const`, una cabecera ni una URL: va solo en una variable de entorno (`.env` fuera del repositorio) o en una credencial de n8n; un flujo exportado con la clave dentro se la llevaría.
2. Crea el producto en Stripe con su precio. Para el primer servicio, usa un Payment Link (enlace de pago) desde el panel de Stripe: no hace falta código y sirve para cobrar hoy. Guarda el enlace.
3. Configura el IVA: en el precio marca si es 'impuestos incluidos' o no. Si vendes a empresas, activa en el Payment Link la opción de pedir el NIF/CIF del cliente. Sin el NIF del cliente la factura a una empresa no es válida.
4. Activa el envío automático de recibo por correo en Stripe. Ojo: el recibo de Stripe NO es una factura legal en España. Le faltan tu NIF, el del cliente y la numeración correlativa salvo que lo configures.
5. Decide quién emite la factura legal. Opciones reales:
   - Stripe Invoicing: rellena tus datos fiscales, activa numeración correlativa y desglose de IVA. Tiene coste por factura [comprobar tarifa en stripe.com/es/invoicing].
   - Tu programa de facturación (Holded, Quipu, Billin u otro que ya uses) alimentado por un webhook de Stripe (verifica la firma `Stripe-Signature` con el secreto en una variable de entorno, comprueba `payment_status = paid` y guarda el id del evento para no facturar dos veces; la ruta «secreta» del webhook no autentica). Mira la receta 'n8n-pago-stripe-factura-aviso'. Si el número de factura lo calcula tu flujo, resérvalo antes de enviar, ejecuta de uno en uno y comprueba que no existe ya.
   - A mano al recibir el pago. Vale para los primeros clientes. No escala.
6. Si son suscripciones: crea el precio como 'recurrente', decide qué pasa si falla el cobro (Stripe reintenta varias veces por defecto; configura los correos de 'pago fallido' en Configuración > Suscripciones) y activa el portal de cliente para que puedan cancelar solos. Si no pueden cancelar solos, te comerás disputas.
7. Si necesitas página de pago dentro de tu web o app, genera con Stripe Checkout una sesión desde el servidor. Explícale al usuario qué hace cada archivo en dos frases antes de escribirlo.
8. Haz una compra de prueba con la tarjeta 4242 4242 4242 4242, cualquier fecha futura, cualquier CVC. Comprueba que el cliente recibe correo, que el pago aparece en el panel y que el IVA sale desglosado.
9. Pasa a producción solo cuando el usuario diga 'ok' de forma explícita. Cambia claves, repite la compra con una tarjeta real por 1 € y reembólsala.

## Qué devolver

- El enlace de pago de prueba y, si lo hay, el de producción.
- Una tabla corta: producto, precio sin IVA, IVA, precio final, único o recurrente.
- Quién emite la factura legal y cómo (una línea).
- Lista de lo que queda pendiente de la parte fiscal que el código no resuelve (alta, modelo 303, OSS si vende fuera).
- Comisión que se lleva Stripe por cobro: pon la que salga en el panel del usuario, no la inventes.

## Qué NO hacer

- No montar pagos con Payment Intents a mano si un Payment Link o Checkout resuelve el caso. Más código, más fallos, mismo cobro.
- No guardar números de tarjeta en ningún sitio. Nunca. Stripe los guarda por ti.
- No decir que 'la factura la hace Stripe automáticamente' sin haber configurado NIF, numeración y desglose de IVA.
- No poner el IVA como un porcentaje fijo en el código si el usuario vende fuera de España.
- No pasar a producción sin permiso explícito.
- No inventar tarifas de Stripe ni plazos de Hacienda. Lo que no sepas, [entre corchetes] y que lo compruebe.
