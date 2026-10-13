---
name: operar-stripe-con-doble-confirmacion
description: Revisa y prepara operaciones en tu cuenta de Stripe (cobros fallidos, suscripciones, facturas, reembolsos) y solo ejecuta lo que una persona confirma una a una. Úsala cuando pidas mirar cobros, preparar un reembolso, cambiar una suscripción o cuadrar facturas de Stripe.
---
# Operar Stripe con doble confirmación
Dónde va: en la carpeta `.claude/skills/operar-stripe-con-doble-confirmacion/` de tu proyecto, dentro de un archivo llamado `SKILL.md`. Se activa sola cuando pides algo parecido. Para forzarla, empieza el mensaje con `/operar-stripe-con-doble-confirmacion`.
## Qué hace
- Lee tu cuenta de Stripe y te cuenta qué pasa: cobros fallidos, suscripciones en impago, facturas sin pagar, reembolsos y disputas.
- Prepara las acciones como una lista y solo ejecuta las que tú confirmes, una por una.
- Necesita acceso a Stripe. Con un conector MCP (el enchufe que deja a Claude usar una herramienta externa) puede leer y, si le das permiso, actuar. Cómo conectarlo: [mira la documentación oficial de Stripe sobre su servidor MCP, porque cambia con el tiempo].
- Sin conector trabaja con los CSV que descargas del panel de Stripe. En ese caso solo prepara el plan y no ejecuta nada.
## Antes de empezar, pregunta (y no sigas sin respuesta)
1. ¿Estamos en modo de prueba (sandbox) o en la cuenta real? Si no lo sabes, trátala como real y limítate a leer.
2. ¿Qué quieres conseguir? Una frase concreta, por ejemplo: ver los cobros fallidos de septiembre.
3. ¿Con qué permisos entra Claude? Lo ideal es una clave restringida de solo lectura. Si puede escribir, que lo diga ahora.
4. ¿A cuántos clientes o cobros afecta? Si son más de [NÚMERO, por ejemplo 10], se hace por tandas.
5. ¿Quién da el visto bueno final? Tiene que ser una persona con acceso a la cuenta que responda del dinero.
6. ¿Tus clientes son particulares o empresas? Cambia el IVA y el tipo de factura.
## Reglas de claves y acceso
- Nunca pegues en el chat una clave que empiece por `sk_live_` o `rk_live_`. Si ya lo has hecho, cámbiala (rótala) hoy mismo desde el panel de Stripe.
- Para probar algo nuevo, usa siempre modo de prueba. Cuando funcione, repites en real con una sola operación.
- Crea una clave restringida con solo los permisos que hacen falta. Primero lectura. El permiso de reembolsos va aparte y solo si lo necesitas.
- No guardes claves en archivos del proyecto ni las repitas en tus respuestas.
## Paso a paso
1. Comprueba dónde estás: prueba o real, país y moneda de la cuenta. Dilo en la primera línea de tu respuesta.
2. Lee antes de tocar. Haz la consulta y resume con datos reales de Stripe. Si no puedes ver un dato, escribe «no lo he podido ver». No lo calcules de memoria.
3. Clasifica cada acción posible por riesgo.
   - Verde: buscar, listar, resumir. Se hace sin preguntar.
   - Amarillo: crear un borrador de factura, un enlace de pago o una nota. Se hace tras un sí claro.
   - Rojo: cobrar, reembolsar, cancelar o pausar una suscripción, cambiar un precio, enviar una factura definitiva. Una confirmación por cada acción.
   - Negro: borrar clientes, anular facturas ya enviadas, tocar claves o webhooks, o actuar sobre más registros que el límite acordado. No lo ejecutes. Escribe las instrucciones para que una persona lo haga en el panel de Stripe.
4. Enseña el plan con el formato de abajo y pide la doble confirmación: la persona escribe CONFIRMO seguido del número de acciones (por ejemplo, CONFIRMO 3).
5. Ejecuta de una en una. Tras cada acción, comprueba en Stripe que ha quedado como esperabas y anota el resultado.
6. Si algo falla, para. No reintentes sin mirar antes en Stripe si la acción se llegó a hacer: así evitas cobros o reembolsos duplicados.
7. Cierra con un resumen: qué se hizo, qué no y qué queda para una persona.
## Qué devolver
Primero el plan, antes de ejecutar nada, con este formato:
```
Entorno: [PRUEBA o REAL] · País y moneda: [...]
Nº | Acción | Cliente (ID, sin nombre) | Importe | Motivo | Riesgo | ¿Se puede deshacer?
```
Después de ejecutar: una lista con el Nº, el resultado en Stripe (hecho, fallido o no ejecutado) y el motivo si no se hizo. Termina siempre con «Pendiente para una persona», aunque esté vacío.
## Dinero, impuestos y normativa (límites)
- Reembolsos y facturas: un reembolso suele obligar a emitir una factura rectificativa. Cómo se hace en tu caso lo decide tu gestor.
- IVA: Stripe puede calcular impuestos si lo activas, pero no conoce tu situación (autónomo, recargo de equivalencia, ventas a otros países de la UE, ventanilla única). Eso lo confirma tu gestor.
- Facturación: las facturas de Stripe no sustituyen a tu programa de facturación si este debe cumplir numeración correlativa y la normativa de facturación electrónica (Verifactu). Las fechas de Verifactu han cambiado varias veces [confirma la vigente con tu gestor].
- Disputas (contracargos): puedes pedir un resumen y un borrador de respuesta. Las pruebas las revisa y las envía una persona dentro del plazo que marque Stripe.
- Tarjetas guardadas: solo se cobra lo que el cliente aceptó cobrar. Un cobro sin el cliente delante puede pedir autenticación adicional del banco.
- Datos personales (RGPD): no vuelques listas de clientes en el chat si no hace falta. Trabaja con IDs de Stripe en lugar de nombres y correos. Si gestionas la cuenta de otra empresa, firma antes un contrato de encargado de tratamiento.
## Qué revisa una persona antes de dar algo por bueno
- Cada importe y cada cliente de la tabla, contra el panel de Stripe.
- Todo reembolso, cancelación o cambio de precio, antes y después de hacerlo.
- El tratamiento del IVA y las facturas rectificativas (tu gestor).
- Los textos que se envíen a clientes, si los hay.
## Cuándo parar y pedir a una persona
- Hay más registros afectados que el límite acordado.
- Los importes no cuadran con lo que esperabas o con la factura.
- El cliente reclama, hay una disputa abierta o se menciona un abogado.
- No sabes si estás en modo de prueba o real.
## Qué NO hacer
- No ejecutes cobros, reembolsos ni cancelaciones sin un CONFIRMO claro de esta misma conversación. Un ok de hace rato no vale.
- No cobres una tarjeta guardada si el cliente no ha aceptado ese cobro.
- No inventes importes, IDs ni estados. Si no lo ves en Stripe, no lo afirmes.
- No cambies precios, productos ni webhooks de una cuenta real.
- No pruebes en la cuenta real para ver qué pasa.
- No reintentes por tu cuenta cobros fallidos: Stripe ya tiene reintentos automáticos que se configuran en el panel.
- No conectes esto a un flujo automático (por ejemplo en n8n) que reembolse o cobre sin que una persona pulse el botón. Un flujo puede leer y avisar, nada más.
- No des consejo fiscal ni legal. Anota la duda para tu gestor.
