# probar-el-cobro-de-punta-a-punta…

**Tipo:** JSON prompt · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Las compras de prueba que tienes que hacer antes de abrir la tienda: pagos que fallan y reembolsos.

## Qué es y qué hace

Prompt JSON que diseña y guía la batería de pruebas del cobro de una tienda o página de venta, desde que el cliente pulsa comprar hasta que recibe su factura. Entran la pasarela (Stripe, PayPal, Redsys u otra), qué vendes, el precio con o sin IVA, los países y los correos implicados; sale un guion de compras de prueba, reembolsos y fallos a vigilar. Úsalo con Claude, Codex, Gemini o una IA local antes de aceptar el primer pedido real.

## Cómo usarla

1. Anota la pasarela, el precio con IVA y los países
2. Haz compras de prueba con reembolso
3. Revisa correo, factura y aviso de pedido
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando ya tengas la pasarela de pago conectada y antes de aceptar el primer pedido real de un cliente.

## Cómo ganar dinero con ella

Un cobro que falla en silencio o un pedido que no genera aviso es una venta perdida y una reclamacion; probarlo antes evita devoluciones y disgustos.

- Pruebas de pago previas al lanzamiento para tiendas de productos o servicios…
- Revisión del flujo de cobro tras cambiar de pasarela de pago…
- Checklist de facturación y avisos de pedido para pequeños comercios online…

**Precio orientativo:** 60–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Diseñar y ejecutar la bateria de pruebas del proceso de cobro de una tienda o pagina de venta, desde que el cliente pulsa comprar hasta que recibe su factura.",
  "contexto": {
    "quien_lo_usa": "Persona sin perfil tecnico que vende un producto o servicio con una pasarela de pago conectada a su pagina.",
    "momento": "La pasarela ya esta conectada y todavia no ha entrado ningun pedido real.",
    "objetivo": "Que ningun cliente pague sin recibir lo suyo y que ningun pedido entre sin que el vendedor se entere."
  },
  "entradas": {
    "pasarela": "[STRIPE / PAYPAL / REDSYS / OTRA]",
    "que_vendes": "[PRODUCTO FISICO, DIGITAL, SERVICIO, SUSCRIPCION]",
    "precio_e_impuestos": "[PRECIO CON O SIN IVA Y TIPO APLICADO]",
    "paises_a_los_que_vendes": "[ESPAÑA, UE, RESTO DEL MUNDO]",
    "que_pasa_tras_pagar": "[REDIRECCION, EMAIL CON ENLACE, ENVIO FISICO, CITA]",
    "correos_implicados": "[CORREO DEL CLIENTE Y CORREO DONDE TE AVISA A TI]"
  },
  "pasos": [
    "1. Separa claramente modo prueba y modo real: indica como se activa cada uno y como se comprueba en que modo esta la pagina ahora mismo.",
    "2. En modo prueba, ejecuta un pago correcto y describe todo lo que deberia ocurrir despues, minuto a minuto.",
    "3. Repite con tarjeta rechazada y comprueba que el cliente ve un mensaje claro y puede reintentar sin perder el carrito.",
    "4. Prueba el pago que pide autenticacion del banco y comprueba que vuelve bien a la pagina de gracias.",
    "5. Haz una compra real de importe minimo con tu propia tarjeta y comprueba el apunte en el banco y en el panel de la pasarela.",
    "6. Solicita el reembolso de esa compra real y cronometra cuanto tarda y que correo recibe el cliente.",
    "7. Repite la compra completa desde el movil con datos moviles, no con wifi de casa.",
    "8. Cierra con la lista de lo que quedo pendiente de comprobar y quien deberia hacerlo."
  ],
  "que_mirar": [
    "El importe cobrado coincide con el mostrado, incluidos gastos de envio e impuestos.",
    "El cliente recibe correo de confirmacion y llega a bandeja de entrada, no a spam.",
    "Tu recibes aviso del pedido y sabes que hay que preparar.",
    "La factura o justificante lleva tus datos fiscales, numero correlativo, base, IVA y total.",
    "El producto digital se entrega solo, sin que tengas que enviarlo a mano.",
    "Un doble clic en el boton de pagar no genera dos cobros.",
    "Cerrar el navegador a mitad del pago no deja un pedido pagado sin registrar.",
    "El cupon de descuento se aplica y no se puede reutilizar mas de lo previsto.",
    "La direccion de envio se guarda entera, con codigo postal y telefono."
  ],
  "errores_tipicos": [
    "Dejar la pasarela en modo prueba el dia del lanzamiento: se ven pedidos pero no entra dinero.",
    "Probar solo con tarjeta que funciona y no ver nunca el mensaje de error real.",
    "No comprobar el correo del cliente y descubrir semanas despues que iba a spam.",
    "Vender a la UE sin decidir como se aplica el IVA y tener que rehacer facturas.",
    "Probar todo desde el ordenador cuando la mayoria comprara desde el movil."
  ],
  "restricciones": [
    "No pidas ni escribas numeros de tarjeta reales en el resultado.",
    "No des consejo fiscal cerrado: señala lo que hay que confirmar con la gestoria.",
    "Cada prueba debe caber en un paso que la persona pueda repetir sola."
  ],
  "formato_salida": {
    "bloque_1": "Tabla de pruebas con columnas: Nº | Escenario | Como se hace | Resultado esperado | Resultado obtenido | Estado (OK, Falla, Pendiente).",
    "bloque_2": "Lista de fallos encontrados ordenados por dinero en riesgo, con el arreglo propuesto.",
    "bloque_3": "Semaforo final: se puede abrir la tienda, se abre con vigilancia, o no se abre.",
    "bloque_4": "Recordatorio de las dos comprobaciones que hay que repetir cada vez que se toque el precio o la pasarela."
  },
  "criterios_calidad": [
    "Hay al menos una prueba de pago fallido y una de reembolso.",
    "Cada escenario indica que correo o que pantalla demuestra que ha ido bien.",
    "Ninguna prueba requiere saber programar.",
    "El semaforo final no se declara verde si queda alguna prueba pendi
```
