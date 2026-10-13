---
name: freshbooks-horas-a-borrador-de-factura
description: Revisa en FreshBooks las horas sin facturar y las facturas vencidas, y prepara borradores de factura y de recordatorio de cobro. Úsala al cerrar el mes o cuando quieras saber qué te deben. No emite, no envía y no marca como pagada ninguna factura: solo prepara borradores y textos.
---

# Del parte de horas al borrador de factura en FreshBooks

Te ayuda a cerrar el mes en FreshBooks. Junta lo que está sin facturar, detecta lo que te deben y deja borradores listos. Los revisa una persona y los emite una persona. La IA que lo prepare (Claude, Codex, Gemini o una IA local) no emite nada.

## Lo que haces tú, una sola vez
- Guarda este texto en `.claude/skills/freshbooks-horas-a-borrador-de-factura/SKILL.md`, dentro de tu carpeta de trabajo.
- Conecta FreshBooks a tu herramienta de IA con un conector MCP (una conexión directa entre la IA y FreshBooks: el oficial de FreshBooks, si existe, o uno de confianza). Si usas Claude Code, escribe `/mcp` para ver qué conectores tienes activos.
- Empieza con permisos de solo lectura si el conector lo permite. Pasa a crear borradores cuando hayas comprobado que lo que lee es correcto.
- Pregunta a tu gestor si FreshBooks te sirve para facturar en España. La factura debe llevar numeración correlativa, NIF, IVA desglosado y, cuando te toque, cumplir la factura electrónica y Verifactu (el sistema de la Agencia Tributaria para registrar las facturas) [FECHA QUE TE DIGA TU GESTOR]. Muchos programas hechos para otros países no cubren todo esto.
- Los datos de tus clientes pasan por la IA que uses (Claude, Codex, Gemini o una IA local). Comprueba que tu política de privacidad y tus contratos lo permiten.
- Si trabajas con la cuenta de FreshBooks de un cliente tuyo, hace falta su permiso por escrito y un contrato de encargado del tratamiento (el que regula cómo tratas sus datos). Consúltalo con tu gestor.

## Qué preguntar antes de tocar nada
Pregunta al usuario, de una vez y numeradas, lo que no sepas:
1. ¿Qué periodo se cierra (mes, trimestre, fechas concretas)?
2. ¿Todos los clientes o solo alguno?
3. ¿Solo informe, o también borradores creados en FreshBooks?
4. ¿Qué tarifa por hora se usa? ¿Hay tarifas distintas por cliente o proyecto? [TARIFAS]
5. ¿Qué IVA lleva cada cliente y si hay retención de IRPF? Si no lo sabe, lo decide su gestor. Ni el usuario ni tú lo adivináis.
6. ¿Cuál es el plazo de pago habitual? [PLAZO EN DÍAS]

## Paso a paso
1. Comprueba la conexión pidiendo un dato simple, como el nombre de la cuenta. Si no hay herramientas de FreshBooks disponibles, para y dilo. No inventes datos ni simules que los tienes.
2. Trae el tiempo registrado y sin facturar del periodo, agrupado por cliente y proyecto.
3. Busca rarezas y márcalas sin corregirlas: entradas sin proyecto o sin descripción, duplicadas, de un proyecto cerrado o con jornadas muy largas.
4. Muestra un resumen al usuario y espera su OK antes de crear nada.
5. Con su OK, crea un borrador por cliente. Estado borrador, nunca enviada. Cada línea lleva descripción clara, horas, tarifa e impuesto según lo que te dijeron. Pon como vencimiento la fecha de la factura más el plazo de pago indicado en la pregunta 6.
6. Si el conector es de solo lectura o el usuario pidió solo informe, no crees nada: entrega cada borrador como tabla (cliente, líneas, horas, tarifa, impuesto) para copiarlo a mano.
7. Lista las facturas vencidas: cliente, número, importe, fecha de vencimiento y días de retraso.
8. Redacta un recordatorio de cobro por cada factura vencida, en tres tonos según el retraso: cordial, firme y último aviso. Solo texto. No lo envíes.
9. Cierra con el informe y una lista de dudas.

## Qué devolver
En este orden y en tablas:
1. Tabla «Por facturar»: Cliente | Proyecto | Horas | Tarifa | Importe sin IVA | Avisos.
2. Tabla «Vencidas»: Cliente | Nº factura | Importe | Vencimiento | Días de retraso.
3. Lista de borradores creados, con su identificador y el estado «borrador». Si no has creado nada (conector de solo lectura o solo informe), una tabla por cliente con sus líneas, horas, tarifa e impuesto, para copiarla a mano.
4. Los textos de recordatorio, uno por factura.
5. «Dudas para ti»: todo lo que has dejado sin resolver.
Las cifras salen siempre de FreshBooks. Si calculas algo, enseña la cuenta.

## Qué NO hacer
- No emitas, envíes ni marques como pagada ninguna factura.
- No borres ni edites facturas ya emitidas. Si hay un error, propón una factura rectificativa y que la decida el gestor.
- No cambies tarifas, impuestos, datos fiscales de clientes ni cuentas bancarias.
- No inventes horas, importes ni clientes. Si falta un dato, pregunta.
- No mezcles monedas sin avisar.
- No amenaces con acciones legales ni cites leyes en los recordatorios.
- No copies datos de clientes fuera de esta sesión.

## Cuándo parar y llamar a una persona
- Importes que no cuadran con lo que el usuario esperaba.
- Clientes fuera de España o de la UE, o ventas a empresas de otro país (el IVA cambia).
- Clientes que son administración pública (usan su propio sistema de factura electrónica).
- Facturas rectificativas, abonos o impagos largos.

## Qué revisa una persona antes de usar el resultado
- El usuario o su gestor revisa cada borrador antes de emitirlo: importes, IVA, IRPF, numeración y datos fiscales.
- El gestor confirma que el programa cumple los requisitos de facturación de España.
- El usuario lee cada recordatorio antes de enviarlo.
