# Escalera para cobrar un impagado…

**Tipo:** JSON prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Monta la secuencia de reclamación de una factura vencida: mensajes, plazos, tono, cuándo parar el trabajo y cuándo pasar a la vía formal.

## Qué es y qué hace

Prompt JSON que monta la reclamación de una factura vencida. Entran el número, la fecha y el importe de la factura, los días de retraso, el contacto que paga, lo que hay por escrito y las excusas recibidas; sale una secuencia de mensajes redactados con plazos entre ellos y el punto en que pasar a la vía formal. Sirve con Claude, Codex, Gemini o una IA local, y se puede programar con n8n o Make.

## Cómo usarla

1. Reúne factura, vencimiento y pruebas por escrito
2. Pega el contexto en el prompt
3. Envía los mensajes en el orden y plazos indicados
4. Que lo revise un profesional

## Cuándo usarla

Úsalo el día que una factura pasa de la fecha de vencimiento y no sabes qué escribir.

## Cómo ganar dinero con ella

Cobrar una factura parada es dinero que ya has ganado y no está en tu cuenta; la escalera ordenada cobra más y antes que insistir a lo loco.

- Gestión de impagados para autónomos con facturas paradas que no quieren escribir a mano.
- Plantilla de reclamación para despachos y agencias con clientes que pagan tarde.
- Revisión de cartera de facturas vencidas con mensajes listos para cada caso.

**Precio orientativo:** 30–90 € por factura. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Diseñar la escalera completa de reclamación de una factura vencida, con los mensajes redactados, los plazos entre ellos y el punto en el que paso a la vía formal.",
  "contexto": {
    "quien_soy": "[MI NOMBRE O EMPRESA Y QUÉ LE HICE AL CLIENTE]",
    "relacion": "[CLIENTE HABITUAL / PUNTUAL / PRIMERA VEZ]",
    "interes_en_conservarlo": "[ALTO / MEDIO / NINGUNO]",
    "tengo_trabajo_en_curso_con_el": "[SÍ / NO]"
  },
  "entradas": {
    "factura": "[NÚMERO, FECHA, IMPORTE, FECHA DE VENCIMIENTO, DÍAS DE RETRASO]",
    "que_hay_por_escrito": "[PRESUPUESTO ACEPTADO, EMAIL DE CONFORMIDAD, CONTRATO, ALBARÁN, NADA]",
    "contacto_real": "[NOMBRE Y CARGO DE QUIEN PAGA Y DE QUIEN CONTRATÓ]",
    "que_han_contestado": "[EXCUSAS RECIBIDAS HASTA AHORA O SILENCIO]"
  },
  "conocimiento_a_aplicar": [
    "El impago casi nunca es mala fe al principio: suele ser que la factura no ha llegado a quien paga o le falta un dato. El primer mensaje debe ser fácil de contestar.",
    "Cada mensaje sube un escalón: recordatorio amable, recordatorio con consecuencia, aviso formal, vía legal. No se salta de la sonrisa a la amenaza.",
    "Hay que hablar con quien firma los pagos, no solo con quien te contrató.",
    "En operaciones entre empresas la ley de morosidad reconoce intereses de demora y una compensación fija por costes de cobro: mencionarlo en el escalón formal tiene efecto, pero hay que hacerlo sin errores.",
    "El burofax con acuse de recibo y certificación de contenido es la prueba que sirve; el email suelto vale menos.",
    "Para deudas pequeñas y documentadas existe el procedimiento monitorio, que en cuantías bajas se puede iniciar sin abogado ni procurador: confírmalo antes de lanzarte.",
    "Parar el trabajo en curso es la palanca más fuerte, pero hay que avisarlo por escrito y con margen para no quedar tú en mal lugar.",
    "Ofrecer un plan de pago en dos plazos cobra más veces que exigir todo de golpe.",
    "Todo se documenta: fecha, canal, con quién hablaste y qué te dijo."
  ],
  "pasos": [
    "1. Comprobar que la factura es correcta y que llegó a la persona adecuada: fecha, datos fiscales, número de pedido si lo piden.",
    "2. Definir la escalera con 5 escalones y sus días exactos desde el vencimiento.",
    "3. Redactar el mensaje de cada escalón, corto y con una petición concreta.",
    "4. Marcar el escalón en el que se para el trabajo en curso y cómo se comunica.",
    "5. Preparar el texto del aviso formal previo a la vía legal.",
    "6. Preparar dos alternativas de acuerdo: pago en dos plazos y pago con pequeño descuento por pago inmediato, con su coste para mí.",
    "7. Dejar el registro de seguimiento para ir apuntando cada contacto."
  ],
  "errores_tipicos": [
    "Pedir perdón por reclamar lo que es tuyo.",
    "Amenazar en el primer mensaje y quemar la relación por nada.",
    "Seguir entregando trabajo mientras la deuda crece.",
    "Reclamar solo por WhatsApp y quedarse sin prueba.",
    "Aceptar un aplazamiento indefinido sin fecha ni importe."
  ],
  "restricciones": [
    "Tono firme y educado, nunca agresivo ni con insultos ni con amenazas falsas.",
    "No afirmes consecuencias legales concretas como certeza: preséntalas como el paso que corresponde y recomiéndame confirmarlo.",
    "Mensajes de 6 líneas como máximo, sin párrafos largos."
  ],
  "formato_salida": {
    "1_diagnostico": "Tres líneas sobre en qué situación estoy y cuál es la palanca más fuerte que tengo",
    "2_escalera": "Tabla: ESCALÓN | DÍAS DESDE VENCIMIENTO | CANAL | OBJETIVO DEL MENSAJE",
    "3_mensajes": "Los 5 textos listos para copiar, con asunto incluido cuando sea email",
    "4_aviso_formal": "Texto del burofax o carta previa",
    "5_acuerdos": "Las dos alternativas de acuerdo con su coste para mí",
    "6_registro": "Tabla vacía para apuntar fecha, canal, persona y respuesta"
  },
  "criterios_calidad": [
    "Cada mensaje pide una sola cosa y se puede contestar en una línea.",
    "La escalera sube de tono de forma gradual y coherente.",
    "Aparece el punto exacto en el que dejo de trabajar para ese cliente.",
    "Nada de plantillas con huecos sin rellenar: los textos salen con mis datos puestos."
```
