---
name: factura
description: Genera el texto de una factura válida en España (numerada, con IVA y retención calculados) a partir del trabajo hecho y los datos del cliente
argument-hint: cliente, qué le has hecho e importe sin IVA
---
Usa la skill factura-legal-espana: ahí están mis datos fiscales y las reglas legales. Si la ficha está sin rellenar, pídemela antes de nada.

Trabajo, cliente e importe: $ARGUMENTS

Antes de generar, pregúntame solo lo que falte:
1. Nombre o razón social, NIF y dirección del cliente.
2. Si el cliente es empresa/autónomo o particular, y si está en España, en la UE o fuera.
3. Partidas con importe sin IVA (si me lo has dado en bruto, propón el desglose y confírmalo conmigo).
4. Fecha de la operación si no es hoy.
5. Forma y plazo de pago, si no están en la ficha.

Genera:
1. **Número de factura**: el siguiente al de la ficha. Dímelo y pide confirmación antes de usarlo.
2. **La factura en texto plano**, en este orden: cabecera (FACTURA, número, fecha), datos del emisor, datos del cliente, tabla de partidas (descripción, cantidad, precio unitario, importe), base imponible, IVA (tipo y cuota), retención de IRPF si procede (tipo e importe en negativo), TOTAL A PAGAR en euros con dos decimales, forma de pago con IBAN y fecha de vencimiento.
3. Si no lleva IVA o no lleva retención, la frase legal que lo justifica, tal cual la da la skill.
4. Debajo, **la cuenta paso a paso** (base, IVA, retención, total) para que la compruebe en diez segundos.
5. **Email de envío** de dos frases con asunto "Factura [NÚMERO] – [MI NOMBRE]": qué es, cuándo vence, gracias.
6. Recuérdame actualizar el último número en la ficha de la skill, o actualízalo tú si puedes editar el archivo.

Formato: un bloque de texto que pueda pegar en un documento o en mi programa de facturación sin retocar.

Lo que NO tienes que hacer:
- No inventes NIF, direcciones ni fechas. Si falta algo, pregunta.
- No apliques retención a particulares ni IVA a clientes de la UE con NIF-IVA validado.
- No cambies el número de factura para "cuadrar" nada: si hay un hueco, avísame y lo miro con el gestor.
- Si ya me aplica Verifactu (mira la skill), avísame en la primera línea de que este texto no sustituye al programa de facturación.
