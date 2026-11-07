# Pago en Stripe → factura, registro y aviso al móvil (n8n)

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Receta de n8n: cuando entra un pago en Stripe, apunta la venta en una hoja de Google, manda los datos a tu programa de facturación y te avisa por Telegram en el móvil.

## Qué es y qué hace

Receta de n8n que, al entrar un pago en Stripe, apunta la venta en Google Sheets, envía los datos a tu programa de facturación para emitir la factura y te avisa por Telegram. Sustituye copiar y pegar de los correos de pago. El gestor comprueba que las facturas salen bien.

## Cómo usarla

1. Conecta Stripe con n8n
2. Mapea los datos a tu programa de facturas
3. Prueba con una factura de test
4. Que lo revise un profesional

## Cuándo usarla

Ya cobras con Stripe y haces cada factura a mano, copiando datos de los correos de pago. Con esto la venta se apunta, se manda a tu programa de facturación y te llega un aviso al móvil.

## Cómo ganar dinero con ella

Véndela a autónomos que facturan a mano: automatizas registro, factura y aviso en una tarde, por [TU PRECIO], con mantenimiento mensual si lo quieren. Su gestor comprueba que las facturas salen bien.

- Facturación automática para autónomos que facturan a mano…
- Registro y aviso de ventas con mantenimiento mensual incluido…
- Conexión de pagos con programa de facturas para pequeños negocios…

**Precio orientativo:** 150–350 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Pago en Stripe → factura, registro y aviso (n8n)

## Qué resuelve

Cada vez que alguien te paga, hoy tienes que: mirar el correo de Stripe, copiar los datos, hacer la factura y apuntarla. Esta receta lo hace sola y te avisa al móvil.

## Cuentas que hacen falta

- Stripe: sin cuota mensual, cobra comisión por transacción [comprobar en stripe.com/es/pricing].
- n8n: si lo tienes instalado tú (self-hosted) es gratis sin límite. n8n Cloud tiene prueba gratuita y luego es de pago [comprobar en n8n.io/pricing].
- Google Sheets: gratis con cuenta de Google.
- Telegram: gratis. Necesitas crear un bot con @BotFather (te da un token) y saber tu chat_id.
- Programa de facturación con API (Holded, Quipu u otro): depende del plan que tengas. Si no tienes ninguno, salta el nodo 6 y factura a mano con los datos de la hoja.

## Antes de empezar

Hazlo todo en modo prueba de Stripe. Todos los nodos funcionan igual con claves `sk_test_`. Solo cambias a producción al final.

## Nodos, en orden

1. Disparador: nodo 'Stripe Trigger'. Credencial: tu clave secreta de Stripe (de prueba). Evento: `checkout.session.completed` si cobras con Payment Links o Checkout. Si cobras suscripciones y quieres una factura por cada cobro mensual, usa `invoice.paid` en lugar del anterior. Al activar el flujo, n8n registra el webhook en Stripe solo.
   Riesgo: el nodo Stripe Trigger de n8n comprueba la firma del webhook por ti. Si en lugar de este nodo usas un nodo 'Webhook' genérico, cualquiera que sepa la URL puede enviarte un pago falso y te generará una factura falsa. Usa el Stripe Trigger.
2. Nodo 'IF': comprueba que `payment_status` es `paid` (o para `invoice.paid`, que `paid` es true). Si no, termina el flujo sin hacer nada. Evita facturar pagos pendientes.
3. Nodo 'Set' (Editar campos): saca en campos limpios lo que vas a usar: correo del cliente, nombre, importe (Stripe lo da en céntimos: divide entre 100), moneda, NIF si lo pediste (viene en `customer_details.tax_ids`), fecha, id del pago. Así los nodos siguientes son fáciles de leer.
4. Nodo 'Google Sheets' (Lookup) antes de nada: busca si ya existe el id_pago. Si existe, para. Stripe reenvía el mismo evento si tu n8n no respondió a tiempo, y sin este paso harás facturas duplicadas. Es el fallo más común.
5. Nodo 'Google Sheets' (Append row): hoja 'Ventas'. Columnas: fecha, id_pago, cliente, correo, NIF, base, IVA, total, numero_factura, estado_factura. Deja 'estado_factura' en 'pendiente': la venta queda reservada antes de facturar y, si algo falla más adelante, tienes el registro y puedes facturar a mano. Este flujo debe ejecutarse de uno en uno (concurrencia 1) para que dos pagos no se crucen.
6. Nodo 'HTTP Request' hacia tu programa de facturación: crea la factura con base, IVA, NIF y datos del cliente. La URL y el cuerpo exactos dependen del programa [mirar su documentación de API]. Numeración correlativa: la pone el programa de facturación, nunca tú en n8n. Antes de dar la factura por buena, comprueba que el número devuelto no existe ya en la columna numero_factura de la hoja; si existe, para y avísate.
7. Nodo 'Google Sheets' (Update): pon 'estado_factura' en 'emitida' con el número que devolvió el programa, y guarda ese número en 'numero_factura'.
8. Nodo 'Telegram' (Send message): a tu chat_id. Texto corto: 'Pago de [IMPORTE] € de [NOMBRE]. Factura [NÚMERO] emitida.' Si el nodo 6 falló, que diga 'Factura PENDIENTE, hazla a mano'. Para eso, en el nodo 6 activa 'Continue on fail' y en el 8 usa un IF sobre si hubo error.

## Cómo probarla sin liarla

1. Activa el flujo con claves de prueba.
2. En el panel de Stripe (modo prueba) haz una compra con tu Payment Link y la tarjeta 4242 4242 4242 4242.
3. Mira en n8n 'Executions': tiene que haber una ejecución verde. Comprueba la fila en la hoja y el mensaje en Telegram.
4. En Stripe > Desarrolladores > Webhooks, pulsa 'Reenviar' sobre ese mismo evento. Debe pararse en el nodo 4 y no crear una segunda factura. Si crea dos, no pases a producción.
5. Si usas programa de facturación, comprueba que tiene modo sandbox o crea las facturas de prueba como 'borrador' y bórralas después. Una factura emitida con número correlativo no se borra: se anula con una rectificativa.
6. Cuando todo cuadre, duplica el flujo, cambia la credencial a la clave `sk_live_` y desactiva el de prueba. No mezcles claves de prueba y producción en el mismo flujo.

## Qué NO hacer

- No uses un nodo Webhook genérico para recibir pagos sin verificar la firma de Stripe.
- No pongas la numeración de facturas en n8n ni en la hoja. La numeración tiene que ser correlativa y sin huecos; eso lo garantiza el programa de facturación.
- No emitas factura si el pago no está en `paid`.
- No mandes datos del cliente (NIF, correo) a servicios que no necesites. Cada nodo que toca datos personales es un sitio más donde protegerlos.
