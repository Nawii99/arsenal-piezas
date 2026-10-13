---
name: stripe-primer-cobro-desde-cero
description: Monta el primer cobro con Stripe desde cero (enlace de pago o Checkout) en modo de pruebas, con IVA español y factura. Se activa cuando el usuario quiere cobrar por internet, poner un botón de pago o empezar con Stripe.
---

# Primer cobro con Stripe

Acompañas a alguien que no programa a cobrar su primer pago con Stripe. Empiezas por lo que no necesita código (enlace de pago). Solo pasas a código si hace falta de verdad. Nada se toca en producción hasta que el flujo completo funciona en modo de pruebas.

## Antes de empezar, pregunta

1. Qué vende exactamente y cuánto cuesta (precio con o sin IVA). Si no lo sabe, pídele el precio final que quiere que pague el cliente.
2. Si es pago único o suscripción. Si es suscripción, para esto usa la pieza de diseño de suscripciones; aquí solo pago único.
3. A quién vende: particulares en España, empresas en España, o también fuera de España. Cambia el IVA.
4. Si ya tiene cuenta de Stripe y si está activada (le han pedido DNI/NIF e IBAN). Sin cuenta activada puede probar, pero no cobrar de verdad.
5. Si ya tiene web propia o solo quiere un enlace para mandar por WhatsApp, email o redes.
6. Con qué programa hace sus facturas hoy (Holded, Quipu, Excel, nada). Importa para no numerar facturas por duplicado.

## Paso a paso

### 1. Cuenta y modo de pruebas
- Entra en dashboard.stripe.com. Arriba a la derecha hay un interruptor de 'Modo de prueba'. Que esté activado. Todo lo que hagas ahí no mueve dinero.
- Explícale que hay dos juegos de claves: las de prueba (empiezan por pk_test_ y sk_test_) y las reales (pk_live_ y sk_live_). La que empieza por sk_ es secreta: no se pega en un chat, en una web ni en un mensaje. Si la ha pegado en algún sitio, se regenera desde Desarrolladores > Claves de API.

### 2. Producto y precio
- Productos > Añadir producto. Nombre claro (lo verá el cliente), precio en EUR, pago único.
- Si vende a particulares, lo normal es marcar el precio como 'IVA incluido'. Si vende a empresas, precio sin IVA y que Stripe lo añada. Pregúntale cuál quiere y anota la decisión.

### 3. Enlace de pago (sin código)
- Enlaces de pago > Nuevo enlace > elige el producto.
- Activa: pedir dirección de facturación, pedir número de identificación fiscal (NIF) si vende a empresas, y la página de 'gracias' a la que quiere que vaya el cliente después.
- Copia el enlace. Ese enlace es su botón de pago. Sirve para WhatsApp, email, Instagram o para pegarlo en cualquier web.

### 4. Probar el cobro
- Abre el enlace en modo de prueba y paga con la tarjeta 4242 4242 4242 4242, cualquier fecha futura, cualquier CVC y cualquier código postal.
- Comprueba en Pagos que aparece como 'Completado'. Comprueba que le llegó el email de recibo al correo que usó.
- Prueba también un fallo: tarjeta 4000 0000 0000 0002 (rechazada). Que vea qué le sale al cliente.

### 5. IVA
- Stripe Tax calcula el IVA por él (Configuración > Impuestos). Tiene un coste extra por transacción: dile que lo mire en stripe.com/es/pricing antes de activarlo y anota la cifra que vea, no la inventes.
- Sin Stripe Tax, puede crear el impuesto a mano: Productos > Tipos de impuesto > 'IVA 21 %' y asignarlo al precio. Vale si solo vende en España a un tipo fijo.
- Si vende a empresas de otros países de la UE con NIF-IVA válido, la factura va sin IVA con la mención 'inversión del sujeto pasivo'. Stripe Tax lo hace solo si el cliente mete su NIF-IVA. A mano es fácil equivocarse: dile que en ese caso consulte a su gestor.

### 6. Factura
- El recibo que manda Stripe NO es una factura legal española por defecto. Una factura en España necesita número correlativo sin huecos, fecha, NIF y dirección de emisor y cliente, descripción, base imponible, tipo de IVA, cuota y total.
- Dos caminos. A) Facturar desde su programa de siempre (Holded, Quipu, etc.) a partir del pago de Stripe: es lo más seguro si ya factura así. B) Usar Stripe Invoicing: hay que rellenar en Configuración > Facturación los datos de la empresa, el prefijo de numeración y activar la recogida de NIF del cliente. Si elige B, que deje de numerar facturas en el otro programa para esas ventas, o tendrá dos series mezcladas.
- Verifactu (el sistema de la AEAT para facturas) va a afectar a cómo se emiten facturas en España. [Comprueba en la web de la AEAT la fecha en que le obliga según sea autónomo o sociedad]. Díselo, no lo des por resuelto.

### 7. Pasar a real
- Solo cuando el paso 4 ha funcionado y tiene decidido lo del IVA y la factura.
- Desactiva el modo de prueba. Los productos y enlaces de prueba NO se copian: hay que crearlos de nuevo en modo real. Avísale antes de que se lleve la sorpresa.
- Haz que se cobre 1 € a sí mismo con su tarjeta real y luego lo reembolse. Así ve todo el circuito.

### 8. Si hace falta código (Checkout)
- Solo si necesita cosas que el enlace no da: precio variable, datos extra del cliente, integración con su web. Entonces escribes tú el código de una sesión de Checkout en el lenguaje de su web, con la clave secreta leída de una variable de entorno, nunca escrita en el archivo.
- Explícale qué hace cada archivo en dos frases. Si no puede seguirlo, simplifica.

## Qué devolver

1. Una lista de comprobación con los 8 pasos y una casilla por cada uno, marcando dónde está.
2. Las decisiones tomadas: precio con/sin IVA, Stripe Tax sí/no, factura desde dónde.
3. El enlace de pago de prueba y la tarjeta de prueba para que lo enseñe a alguien.
4. Lo que tiene que preguntar a su gestor, en una lista aparte y corta.
5. Los costes que le van a aplicar: comisión por cobro y coste de Stripe Tax si lo activa, con las cifras que él haya leído en la página de precios. Recuérdale que en un reembolso Stripe no devuelve la comisión y que una disputa (el cliente reclama al banco) tiene un coste fijo aparte.

## Qué NO hacer

- No pedirle nunca la clave secreta (sk_). Si la pega, dile que la regenere.
- No activar el modo real ni crear nada en producción sin que él lo confirme paso a paso.
- No dar por hecho que el recibo de Stripe vale como factura.
- No inventar comisiones ni porcentajes. Si no los tienes delante, se ponen entre corchetes para que los compruebe.
- No escribir código si el enlace de pago resuelve el caso.
- No meterle en suscripciones, cupones, portales de cliente ni Connect en este primer cobro. Una cosa a la vez.
- No sustituir al gestor en lo del IVA intracomunitario, exenciones o retenciones.
