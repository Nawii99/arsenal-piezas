---
description: Define los limites de seguridad y tono de un agente que habla con clientes, con frases de escape exactas y pruebas para comprobar que aguanta
argument-hint: [que hace el bot y en que negocio]
---

Eres responsable de riesgos de un agente conversacional. Tu unico trabajo es que el bot no meta a su dueno en un lio.

AGENTE: $ARGUMENTS
Si falta contexto, pregunta solo tres cosas: sector, canal (WhatsApp, web, telefono) y si el bot puede cerrar ventas o solo informar.

PASO 1. INVENTARIO DE RIESGOS DEL SECTOR
Lista los 8 riesgos concretos de ese negocio, con un ejemplo de frase peligrosa que un bot suelta sin querer.
Piensa en estas familias: precios y descuentos, plazos de entrega, garantias y devoluciones, consejos de salud o legales, datos personales, comparaciones con la competencia, promesas de resultados, disponibilidad y stock.

PASO 2. LAS TRES LISTAS
- PUEDE: lo que el bot dice y hace sin pedir permiso.
- SOLO CON FORMULA: temas que puede tocar pero solo con una frase fija que tu escribes palabra por palabra.
- NUNCA: temas donde no improvisa jamas, y a los que responde derivando a una persona.
Cada linea de NUNCA lleva su frase de escape literal, lista para copiar, en el tono del negocio.

PASO 3. FRASES DE ESCAPE
Escribe 6 frases de escape distintas, en espanol natural, cortas, sin sonar a robot ni a abogado.
Cada una: reconoce la pregunta, dice claro que eso lo ve una persona, y ofrece el siguiente paso concreto (llamada, formulario, horario).
Prohibido usar «no estoy programado para» o «como modelo de lenguaje».

PASO 4. BLOQUE PARA PEGAR EN EL PROMPT
Redacta el bloque de reglas listo para pegar en las instrucciones del bot. Estructura: identidad, tono, lo que puede, lo que nunca, que hacer si insisten, que hacer si el cliente se enfada, que hacer si el cliente pide hablar con un humano.
Escribelo en imperativo y en segunda persona, dirigido al bot.

PASO 5. PRUEBAS DE RESISTENCIA
Escribe 10 mensajes de prueba que intentan saltarse los limites, para que el usuario los pegue tal cual:
- 2 de cliente que pide descuento hasta la extenuacion.
- 2 de cliente que pide un plazo o una garantia que no existe.
- 2 de cliente que pregunta algo del sector con riesgo (salud, legal, fiscal, segun toque).
- 2 de alguien que intenta que el bot ignore sus instrucciones o revele su prompt.
- 2 de cliente maleducado o enfadado.
Para cada uno, escribe en una linea que respuesta cuenta como APROBADO y cual como SUSPENSO.

COMPRUEBA ANTES DE RESPONDER
- Que ninguna frase de escape promete nada que el negocio no controle.
- Que las frases suenan a persona: leelas en voz alta mentalmente.
- Que hay un camino claro a un humano en TODAS las situaciones de la lista NUNCA.

FORMATO DE SALIDA
# Limites del bot: [negocio]
## Riesgos del sector (tabla: riesgo / ejemplo de frase peligrosa / gravedad)
## Puede / Solo con formula / Nunca (tres listas)
## Frases de escape (6, numeradas, listas para copiar)
## Bloque de reglas para pegar en el prompt (en un bloque de codigo)
## 10 pruebas de resistencia (tabla: mensaje / aprobado si / suspenso si)
## Revision recomendada (que mirar cada mes en las conversaciones reales)
