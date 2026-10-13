# fugas-de-cobro-online…

**Tipo:** JSON prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Busca el dinero que se pierde por el camino en tus cobros online: comisiones, devoluciones, tarjetas caducadas y suscripciones que fallan.

## Qué es y qué hace

Prompt JSON que audita tu circuito de cobro online. Entran las ventas brutas del periodo, lo que llegó al banco, las comisiones de cada pasarela, los pagos fallidos, las devoluciones y las bajas de suscripción; sale cuánto se pierde en cada fuga y un sistema para recuperar cobros fallidos. Se usa con Claude, Codex, Gemini o una IA local, y puede alimentarse de avisos de Stripe o PayPal con n8n, Make o Zapier.

## Cómo usarla

1. Exporta ventas y liquidaciones del periodo
2. Cruza ventas con ingresos reales
3. Clasifica cada fuga y su importe
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando cobras por Stripe, PayPal o una plataforma y no te cuadra lo que ingresas, o si tienes cuotas mensuales que se caen solas.

## Cómo ganar dinero con ella

Recupera cobros fallidos que ya tenías vendidos y baja las comisiones que pagas, sin conseguir un solo cliente nuevo.

- Auditoría de cobros para tiendas online que pierden dinero en pagos fallidos y comisiones.
- Recordatorio automático de tarjetas caducadas con n8n o Make para negocios con suscripciones.
- Informe mensual de fugas de cobro para autónomos que cobran por varias pasarelas.

**Precio orientativo:** 60–150 € por auditoría. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Auditar el circuito de cobro online, cuantificar cada fuga entre lo vendido y lo ingresado, y montar el sistema de recuperación de pagos fallidos.",
  "contexto": {
    "negocio": "[QUÉ VENDES Y SI ES PAGO ÚNICO, SUSCRIPCIÓN O AMBOS]",
    "pasarelas": "[STRIPE, PAYPAL, REDSYS, MARKETPLACE, BIZUM, TRANSFERENCIA]",
    "sintoma": "[NO ME CUADRA LO QUE INGRESO / SE ME CAEN SUSCRIPCIONES / MUCHAS DEVOLUCIONES]"
  },
  "entradas": {
    "ventas_brutas": "[IMPORTE VENDIDO EN EL PERIODO Y NÚMERO DE OPERACIONES]",
    "ingresos_reales": "[LO QUE HA LLEGADO AL BANCO EN EL MISMO PERIODO]",
    "comisiones": "[PORCENTAJE Y FIJO POR OPERACIÓN DE CADA PASARELA, MÁS COMISIÓN DE CAMBIO DE DIVISA SI LA HAY]",
    "pagos_fallidos": "[OPERACIONES RECHAZADAS, TARJETAS CADUCADAS, SALDO INSUFICIENTE]",
    "devoluciones_y_reclamaciones": "[REEMBOLSOS, DISPUTAS Y SU MOTIVO]",
    "suscripciones": "[ALTAS Y BAJAS DEL PERIODO Y CUÁNTAS BAJAS FUERON POR FALLO DE PAGO]",
    "plazos_de_abono": "[CADA CUÁNTO TE TRANSFIERE LA PASARELA Y CON CUÁNTOS DÍAS DE RETENCIÓN]"
  },
  "metodo": [
    "1. Monta la cascada: vendido, menos comisiones, menos devoluciones, menos disputas, menos pagos fallidos no recuperados, igual a ingresado. Cuadra la diferencia con el banco y si sobra o falta dinero, dilo.",
    "2. Expresa cada fuga en euros y en porcentaje de lo vendido, y ordénalas de mayor a menor.",
    "3. Comisiones: calcula el coste medio por operación. Detecta si el ticket pequeño se come el margen por la parte fija y propón mínimo de pedido, pago agrupado o cambio de método.",
    "4. Pagos fallidos: separa los recuperables (tarjeta caducada, saldo temporal) de los definitivos. Los recuperables son la fuga más fácil de tapar.",
    "5. Diseña la recuperación de cobros fallidos: reintento a las 24 horas, a los 3 días y a los 7, más email al cliente en cada uno con enlace directo a actualizar la tarjeta, y aviso previo antes de que caduque.",
    "6. Devoluciones y disputas: agrupa por motivo y ataca el motivo principal con un cambio concreto en la descripción del producto, en el nombre que sale en el extracto bancario, en el email de confirmación o en el plazo de entrega.",
    "7. Retenciones y plazos: calcula cuántos días tarda el dinero en llegar y qué importe está siempre retenido, para no contarlo como caja disponible.",
    "8. Revisa las suscripciones: cuántas bajas fueron voluntarias y cuántas por fallo técnico. La segunda cifra es dinero recuperable con avisos.",
    "9. Cierra con el cuadro de control mensual: cinco números a mirar y el objetivo de cada uno."
  ],
  "restricciones": [
    "Nunca propongas cobrar sin consentimiento claro ni poner trabas para darse de baja.",
    "No guardes ni pidas datos de tarjeta fuera de la pasarela.",
    "Trabaja siempre con importes sin IVA para el margen, y con importes totales para cuadrar el banco: no los mezcles.",
    "No inventes las comisiones de una pasarela: pide los datos reales del extracto."
  ],
  "errores_tipicos_a_evitar": [
    "Dar por ingresado lo vendido y descubrir el descuadre al cerrar el trimestre.",
    "No mirar las comisiones por cambio de divisa en ventas fuera de la zona euro.",
    "Dejar morir la suscripción que falló sin ni un solo aviso al cliente.",
    "Poner un nombre irreconocible en el extracto bancario y provocar disputas.",
    "Contar como caja disponible el dinero aún retenido por la pasarela."
  ],
  "formato_salida": {
    "bloque_1": "La cascada de vendido a ingresado con euros y porcentaje en cada escalón.",
    "bloque_2": "Tabla de fugas ordenada por importe, con la causa y si es recuperable.",
    "bloque_3": "Sistema de recuperación de pagos fallidos con calendario y los textos de los avisos.",
    "bloque_4": "Cambios concretos para bajar devoluciones y disputas.",
    "bloque_5": "Cuadro de control mensual con cinco números y su objetivo.",
    "estilo": "Español de España, tuteando, sin tecnicismos de pasarela sin explicar"
  },
  "criterios_calidad": [
    "La cascada cuadra con el ingreso real del banco o la diferencia queda explicada.",
    "Las fugas recuperables están separadas de las que no lo son.",
    "Los textos de aviso al clie
```
