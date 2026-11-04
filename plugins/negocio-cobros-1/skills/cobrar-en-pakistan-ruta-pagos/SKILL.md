---
name: cobrar-en-pakistan-ruta-pagos
description: Prepara el plan para cobrar a clientes de Pakistán con métodos locales (JazzCash, Easypaisa, Raast) u otras vías, con ruta de cobro, flujo de pago, precios en rupias y pruebas. Úsala antes de integrar nada. Obliga a trabajar con la documentación oficial vigente.
---
# Cobrar en Pakistán: ruta de pagos locales
Qué hace: te ayuda a decidir cómo puede una empresa de España cobrar a usuarios en Pakistán, qué métodos locales existen, qué necesita cada uno y cómo sería el flujo de pago de una suscripción o un producto digital. Entrega un plan. No programa ninguna integración si no se lo pides, y nunca con cobros reales.
Aviso: lo que Claude recuerda de JazzCash, Easypaisa, Raast y de las pasarelas de pago puede estar desfasado en octubre de 2026. Solo se da por cierto lo que conste en la documentación oficial actual de cada proveedor, que pasa el usuario o que se consulta [ENLACE OFICIAL DE CADA PROVEEDOR]. Lo que no conste se marca «por confirmar con el proveedor».
Cómo se usa: se activa sola con peticiones de este tema, o la llamas escribiendo /cobrar-en-pakistan-ruta-pagos.
## Pregunta antes de empezar
- ¿Qué vendes (suscripción, curso, servicio, producto digital) y a quién (particulares o empresas)?
- ¿Tienes empresa o cuenta bancaria en Pakistán, o cobrarías desde España? Es la pregunta que más decide.
- ¿Con qué cobras hoy (Stripe, PayPal, Paddle u otro) y en qué países funciona? No des por hecho que admite Pakistán.
- ¿Tu app ya está programada? ¿Quién la mantiene? ¿Valdría un enlace de pago de una pasarela, sin programar?
- ¿En qué moneda quieres fijar el precio: euros, dólares o rupias (PKR)?
- ¿Cómo pagan tus posibles clientes: cartera móvil, cuenta bancaria o tarjeta? Si no lo sabes, propón preguntarlo a cinco usuarios reales antes de decidir.
## Paso a paso
1. Aclara la ruta. Compara por escrito tres vías. Una pasarela o agregador local con permiso para operar en Pakistán que liquide en tu cuenta. Una plataforma que actúe como vendedor oficial y gestione impuestos, si admite Pakistán y sus métodos. Una empresa o socio local. De cada una: requisitos, comisiones [SEGÚN EL PROVEEDOR], moneda de liquidación, plazo de cobro y quién se ocupa de los impuestos. Ninguna es segura hasta que el proveedor la confirme.
2. Para cada método (JazzCash, Easypaisa, Raast, tarjeta) rellena una ficha: si lo admite la pasarela elegida, si permite cobro único o recurrente, cómo se confirma el pago (aviso automático al servidor o consulta de estado), si admite reembolsos y qué límites tiene por operación.
3. Cobros recurrentes. Muchos métodos con cartera o transferencia exigen que el usuario apruebe cada pago. Si es así, no diseñes un cargo automático: propón periodos prepagados (mes, trimestre, año) con aviso antes de que caduquen. Confírmalo con el proveedor.
4. Precios locales. Propón una escala en rupias según lo que pueden pagar tus clientes, usando el tipo de cambio del día de una fuente oficial: [TIPO DE CAMBIO PKR/EUR Y FECHA]. Calcula el precio mínimo con el que no pierdes dinero tras comisiones, impuestos y devoluciones. Avisa de que el tipo de cambio se mueve y de que bajar precios por país es una decisión comercial tuya.
5. Describe el flujo en palabras. El usuario elige plan, la app crea un pedido con número único, el usuario paga, el proveedor avisa a tu servidor, tu servidor comprueba que el aviso es auténtico y que el importe coincide, activa el servicio una sola vez y envía el recibo. Define qué pasa si el aviso no llega, si llega dos veces, si el pago llega tarde y si hay reembolso.
6. Pruebas en el entorno de pruebas (sandbox) del proveedor, con claves de prueba. Casos: pago correcto, pago rechazado, pago abandonado, aviso duplicado, aviso falso, importe distinto y reembolso. Anota resultado esperado y obtenido. Antes de abrir al público, haz un pago real de poco importe y devuélvelo.
7. Contabilidad: ¿en qué moneda facturas? ¿Qué tipo de cambio usará tu gestor para contabilizar? ¿Cómo concilias cobros que llegan agrupados y con comisiones descontadas? Prepara una hoja que enlace cada cobro con su pedido.
8. Prepara dos listas de preguntas. Para el proveedor: requisitos para abrir cuenta desde España, documentación, comisiones, plazos, límites, reembolsos y soporte. Para tu asesor: si se factura IVA español a clientes fuera de la UE, qué impuestos puede exigir Pakistán sobre servicios digitales, qué normas de control de cambios y de blanqueo aplican y qué tipo de cambio usar.
## Qué devolver
Un documento «Plan de cobros en Pakistán» con este orden:
1. Comparativa de rutas, con lo confirmado y lo pendiente.
2. Ficha por método de pago.
3. Flujo de pago paso a paso, con los casos de fallo.
4. Escala de precios en PKR con fecha del tipo de cambio.
5. Plan de pruebas con resultados.
6. Preguntas para el proveedor y para el asesor.
7. Riesgos y quién debe revisar cada uno.
## Qué NO hacer
- No inventes direcciones de API, nombres de campos, comisiones, límites ni plazos.
- No pongas claves reales en el chat ni en el código. Las de prueba van en variables de entorno y las reales las gestiona la persona responsable.
- No actives ningún cobro real sin pruebas en sandbox y sin revisar que el aviso de pago se verifica con su firma.
- No guardes datos de tarjeta ni de cartera de los usuarios. Los guarda el proveedor.
- No propongas saltarse controles de la pasarela, como ocultar el país real del cliente o cobrar a través de cuentas de terceros. Es un riesgo legal serio.
- Si hay código, trabaja en una rama aparte, nunca directamente en producción, y explica cada cambio en lenguaje llano.
## Quién revisa antes de usar el resultado
- Un asesor fiscal con experiencia internacional revisa el IVA, los posibles impuestos en Pakistán, el tipo de cambio contable y la factura.
- Un abogado revisa el contrato con la pasarela, el control de cambios, la prevención de blanqueo y los términos de uso.
- Una persona técnica revisa la verificación de los avisos de pago, la custodia de claves y los reintentos.
- Tú decides si el negocio compensa tras ver comisiones, impuestos y devoluciones.
