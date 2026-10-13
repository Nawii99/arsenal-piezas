# Semáforo de gastos deducibles…

**Tipo:** JSON prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Clasifica tus gastos dudosos (coche, casa, comidas, móvil, ropa, viajes) en verde, ámbar y rojo, y dice qué papel guardar para cada uno.

## Qué es y qué hace

Prompt JSON que clasifica gastos dudosos en verde, ámbar y rojo según su riesgo de deducción. Entran concepto, proveedor, importe, fecha, forma de pago y finalidad de cada gasto, además de tu actividad y si trabajas desde casa o usas el coche; sale la clasificación y la documentación que hay que guardar para cada uno. Funciona con Claude, Codex, Gemini o una IA local, y puede ordenar los gastos desde una hoja con n8n o Make.

## Cómo usarla

1. Apunta cada gasto con importe, fecha y forma de pago
2. Pégalos en el prompt
3. Mira el color y el papel a guardar
4. Que lo revise un profesional

## Cuándo usarla

Úsalo antes de mandar los gastos a la asesoría o cuando dudes si algo lo puedes meter.

## Cómo ganar dinero con ella

Deducir bien lo que sí toca y descartar lo que no evita pagar de más y evita sustos en una revisión.

- Revisión de gastos dudosos para autónomos antes de enviar papeles a la gestoría.
- Guía de documentación deducible para oficios que usan el coche o trabajan desde casa.
- Checklist de gastos para gestorías con clientes que mezclan gasto personal y de empresa.

**Precio orientativo:** 30–70 € por revisión. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Revisar una lista de gastos dudosos, clasificarlos por nivel de riesgo de deducción y decirme exactamente qué documentación necesito para cada uno.",
  "contexto": {
    "forma_juridica": "[AUTÓNOMO EN ESTIMACIÓN DIRECTA / SOCIEDAD LIMITADA]",
    "actividad": "[A QUÉ ME DEDICO Y DÓNDE TRABAJO]",
    "trabajo_desde_casa": "[SÍ, Y TENGO EL DOMICILIO DECLARADO EN HACIENDA / SÍ, PERO NO DECLARADO / NO]",
    "uso_vehiculo": "[NO TENGO / USO MIXTO / SOLO PARA LA ACTIVIDAD]",
    "tengo_asesoria": "[SÍ / NO]"
  },
  "entradas": {
    "gastos_a_revisar": "[CONCEPTO | PROVEEDOR | IMPORTE | FECHA | CÓMO LO PAGUÉ | PARA QUÉ FUE]",
    "dudas_concretas": "[LO QUE MÁS ME PREOCUPA]"
  },
  "conocimiento_a_aplicar": [
    "El criterio general es que el gasto esté vinculado a la actividad, esté registrado y esté justificado con factura completa a nombre del negocio, no un ticket sin datos.",
    "Pagar con la tarjeta del negocio y no en efectivo refuerza mucho la justificación.",
    "Los gastos de suministros de la vivienda cuando trabajas en casa siguen una regla especial de porcentaje sobre la parte de la casa afecta a la actividad: hay que tener el domicilio declarado y calcularlo bien.",
    "El vehículo de uso mixto es el caso más conflictivo: en IVA suele admitirse una parte y en el impuesto sobre la renta el criterio es mucho más estricto salvo actividades concretas.",
    "Las comidas de trabajo del propio autónomo tienen límites diarios y exigen pago electrónico y establecimiento de restauración.",
    "Los gastos de atención a clientes tienen un límite anual ligado a la cifra de negocio.",
    "La ropa solo entra si es específica de la actividad o lleva el logo, no por vestir bien para una reunión.",
    "La formación y el software vinculados a la actividad suelen ser de los gastos más claros.",
    "Un gasto en zona ámbar no es ilegal: es un gasto que hay que poder explicar y documentar mejor."
  ],
  "pasos": [
    "1. Revisar gasto a gasto y comprobar tres cosas: relación con la actividad, factura correcta y medio de pago trazable.",
    "2. Asignar semáforo: VERDE si cumple los tres, ÁMBAR si falta documentación o el uso es mixto, ROJO si es personal o no se puede justificar.",
    "3. Para cada ámbar, decir qué falta y cómo convertirlo en verde.",
    "4. Señalar los gastos con porcentaje de afectación y explicar cómo se calcula ese porcentaje.",
    "5. Separar el tratamiento del IVA del tratamiento en el impuesto sobre la renta o sociedades, porque no coinciden.",
    "6. Preparar la lista de preguntas para la asesoría con los casos que dependen de mi situación concreta.",
    "7. Proponer tres normas de higiene para que el mes que viene haya menos ámbares."
  ],
  "errores_tipicos": [
    "Guardar el ticket del datáfono en vez de la factura.",
    "Deducir la compra del supermercado o la ropa de calle.",
    "Deducir el 100 por cien del coche sin poder demostrar uso exclusivo.",
    "Pagar en efectivo gastos que luego no se pueden defender.",
    "Meter gastos a nombre personal cuando la actividad es de una sociedad."
  ],
  "restricciones": [
    "Esto es orientación práctica, no asesoramiento fiscal: dilo al principio y remite las decisiones dudosas a un profesional.",
    "No des porcentajes ni límites exactos como certeza si no los tienes actualizados: descríbelos como regla que hay que confirmar.",
    "No propongas nunca facturas falsas ni deducir algo personal disfrazado."
  ],
  "formato_salida": {
    "1_aviso": "Una línea recordando que la última palabra la tiene mi asesoría",
    "2_tabla": "GASTO | IMPORTE | SEMÁFORO | MOTIVO | QUÉ DOCUMENTO NECESITO | IVA SÍ O NO",
    "3_ambares": "Lista de acciones para convertir ámbares en verdes",
    "4_rojos": "Lista de lo que dejo fuera y por qué, sin discusión",
    "5_preguntas": "Bloque listo para enviar a la asesoría",
    "6_higiene": "Tres normas para el mes que viene"
  },
  "criterios_calidad": [
    "Todos los gastos de mi lista tienen semáforo y motivo.",
    "Se distingue IVA de impuesto sobre el beneficio en los casos donde cambia.",
    "Las acciones para los ámbares son concretas: pedir factura a tal proveedor, cambiar la forma de pago,
```
