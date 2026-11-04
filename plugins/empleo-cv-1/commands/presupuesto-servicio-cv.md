---
name: presupuesto-cv
description: Redacta un presupuesto formal para un encargo de CV o carta de presentación, listo para pegar en un email, con desglose, IVA y condiciones
---

# Qué hace este comando

A partir de lo que el usuario escriba después del comando (qué quiere el cliente, para cuándo, en qué idioma), redacta un presupuesto que se pueda enviar tal cual por email.

## Qué preguntar si no viene en el mensaje

- Qué incluye el encargo: solo CV, CV + carta de presentación, versión en otro idioma, versión web (HTML) o plantilla de Notion.
- Cuántas rondas de cambios acepta el usuario incluir en el precio (recomienda dos: más de eso se cobra aparte).
- El precio base que quiere cobrar el usuario. NO te inventes un precio de mercado: si el usuario no lo tiene claro, deja el hueco como [PRECIO] y dile que mire qué cobran otros perfiles parecidos antes de enviar nada.
- Si el usuario factura como autónomo con IVA o todavía no está dado de alta.

## Paso a paso

1. Escribe un párrafo de apertura de dos frases: qué has entendido del encargo y qué va a recibir el cliente exactamente (formatos de archivo incluidos).
2. Desglosa el precio en una tabla: concepto, precio sin IVA, IVA al 21% y total. Si el usuario no está dado de alta como autónomo, no montes la tabla con IVA: avísale de que facturar sin estar dado de alta tiene riesgo de sanción y que eso lo resuelva antes de cobrar.
3. Añade condiciones en 4 o 5 líneas: plazo de entrega, número de rondas de cambios incluidas, precio de la ronda extra, forma de pago (recomienda 50% por adelantado en encargos nuevos) y validez del presupuesto (30 días es lo habitual).
4. Añade una línea de tratamiento de datos: los datos personales del cliente se usan solo para elaborar el CV y se borran al terminar si lo pide. Es un encargo con datos personales y en España aplica el RGPD, aunque sea un trabajo pequeño.
5. Cierra con una llamada a la acción concreta: 'si te encaja, respóndeme a este correo y empiezo el [FECHA]'.

## Qué devolver

El presupuesto completo en texto plano listo para pegar en un email, sin encabezados de Markdown raros que se rompan al pegar. Debajo, separado por una línea, un recordatorio de dos puntos para el usuario: qué huecos le quedan por rellenar y si hay algo del encargo que suene a alcance mal cerrado (por ejemplo, 'cambios ilimitados').

## Qué NO hacer

- No inventes precios, plazos ni datos fiscales. Todo lo que falte, [entre corchetes].
- No prometas resultados del CV ('conseguirás entrevistas'). Se vende el trabajo, no el resultado del proceso de selección.
- No incluyas el DNI del usuario ni del cliente en el presupuesto: eso va en la factura, no aquí.
