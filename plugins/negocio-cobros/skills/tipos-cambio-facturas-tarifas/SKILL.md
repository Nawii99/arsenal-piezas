---
name: tipos-cambio-facturas-tarifas
description: Consulta tipos de cambio en Fixer y los aplica a facturas, presupuestos y listas de precios en otras monedas, dejando anotado el tipo, la fecha y la fuente. Úsala cuando tengas que pasar importes de una moneda a otra y quieras poder justificar la cifra.
---
# Tipos de cambio para facturas y tarifas
Convierte importes entre monedas con tipos de cambio de Fixer y deja anotado qué tipo usaste, de qué fecha y de qué fuente. Sirve para poder justificar una cifra. No sirve para operar con divisas.

## Instalación (para la persona, no para Claude)
- Crea una cuenta en Fixer y copia tu clave de acceso. Los planes gratuitos suelen limitar las consultas al mes, la moneda base y los datos históricos, y pueden actualizarse con retraso. Mira qué incluye el tuyo: [LÍMITES DE TU PLAN].
- Guarda la clave en una variable de entorno llamada FIXER_API_KEY. Pídele a Claude Code que te explique cómo hacerlo en tu sistema. No la pegues en el chat, en documentos ni en capturas de pantalla.
- Si prefieres un conector MCP en vez de la clave, usa el que ofrezca el servicio: [COMANDO O URL DEL CONECTOR].
- Guarda este texto como SKILL.md dentro de .claude/skills/tipos-cambio-facturas-tarifas/ (solo ese proyecto) o de ~/.claude/skills/tipos-cambio-facturas-tarifas/ (todos tus proyectos).

## Pregunta esto antes de empezar
1. ¿Para qué es la conversión? Factura emitida, factura recibida, presupuesto, lista de precios o informe interno. De eso depende qué fecha se aplica.
2. ¿Qué importes y en qué monedas? ¿A qué moneda se pasan?
3. ¿Qué fecha de tipo se usa? En una factura, la fecha de devengo. En un presupuesto, hoy. En un informe, la del cierre. Si no lo sabe, que lo consulte con su gestor: no lo supongas.
4. ¿Qué plan de Fixer tiene y qué límites? Si no lo sabe, que lo mire en su panel.
5. ¿Cuántos decimales y qué redondeo se usan? Para euros, normalmente dos decimales.

## Paso a paso
1. Comprueba que existe la clave FIXER_API_KEY o un conector. Si no, para y explica cómo conseguirla. No la pidas por el chat.
2. Pide los tipos de la fecha acordada, solo de las monedas necesarias y en una sola consulta. Cada consulta cuenta para el límite del plan.
3. Si la respuesta es un error, un límite superado, una moneda no admitida o una fecha no disponible, dilo y para. Nunca uses cifras de memoria.
4. Calcula importe por tipo. Si el plan solo da el euro como base y necesitas pasar de dólares a libras, calcula el cruce y dilo. Mantén todos los decimales del tipo y redondea solo el resultado final.
5. Comprueba cada resultado con la operación inversa: al volver a la moneda de origen debe salir lo mismo, con una diferencia de céntimos como mucho.
6. Apunta el tipo, la fecha del tipo (la que devuelve Fixer, no la de hoy), la fuente y la hora de la consulta.

## Qué devolver
- Una tabla con las columnas Concepto, Importe de origen, Moneda, Tipo aplicado, Fecha del tipo, Importe en moneda de destino.
- Una línea de nota: «Fuente: Fixer, consultado el [FECHA Y HORA]. Es un tipo de referencia de mercado, no el que aplicará tu banco o tu pasarela de pago».
- Si es una factura, recuerda esto: en España, si facturas en otra moneda, el IVA debe constar también en euros, con el tipo de cambio del día del devengo. Qué fuente de tipo aceptan en tu caso lo decide tu gestor. El Banco Central Europeo publica cada día laborable tipos de referencia del euro; si tu gestor prefiere esos, úsalos.
- Las dudas o datos que faltan, con el nombre [DATO QUE FALTA].

## Qué NO hacer
- No uses un tipo de memoria ni de otra web sin decirlo.
- No mezcles fechas distintas en una misma tabla sin avisar.
- No redondees a mitad de cálculo.
- No presentes el resultado como el dinero que vas a recibir o pagar. Tu banco, Stripe o PayPal aplican su propio tipo y comisión, y la diferencia es dinero real.
- No des consejos de inversión, de cuándo cambiar dinero ni de criptomonedas.
- No guardes la clave en archivos del proyecto ni la subas a GitHub.
- No lances consultas en bucle: puedes agotar el plan.
- No cambies precios publicados en una tienda o una web sin que una persona lo apruebe.

## Qué revisa una persona antes de usar el resultado
- Tu gestor o contable confirma la fuente y la fecha del tipo antes de emitir o contabilizar una factura en divisa.
- Tú compruebas a mano con una calculadora al menos dos importes de la tabla.
- Si es una tarifa de tienda, decides tú el redondeo comercial (por ejemplo, terminar en ,99) y el margen para cubrir las variaciones del cambio.
