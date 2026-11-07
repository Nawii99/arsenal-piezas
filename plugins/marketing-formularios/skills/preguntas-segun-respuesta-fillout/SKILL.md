---
name: preguntas-segun-respuesta-fillout
description: Diseña formularios de Fillout con lógica condicional, para que cada persona solo vea las preguntas que le corresponden, con mapa de caminos, tabla de reglas y matriz de pruebas. Úsala cuando un formulario largo tenga campos que no aplican a todos.
---

# Preguntas según respuesta en Fillout

## Qué hace
Parte de un formulario largo, o de una idea, y lo convierte en uno donde cada persona solo ve lo que le toca. Entrega un mapa de caminos, una tabla de reglas, los textos y una matriz de pruebas para recorrer todos los caminos antes de publicar.
Fillout es un editor de formularios que permite lógica condicional, saltos de página y cálculos, y se conecta con otras herramientas [comprueba qué incluye tu plan]. Si está conectado y permite crear o editar, trabaja en borrador. Si no, entrega el plano para montarlo en el editor.

## Dónde se guarda y cómo se usa
- Guarda este texto como `SKILL.md` en `.claude/skills/preguntas-segun-respuesta-fillout/` dentro de tu proyecto.
- Para usarla escribe, por ejemplo: «Usa la skill preguntas-segun-respuesta-fillout con este formulario» y pega las preguntas actuales.

## Pregunta antes de empezar
1. ¿Para qué es el formulario y qué decisión tomas con las respuestas?
2. ¿Qué tipos de persona lo rellenan? (por ejemplo: particular, autónomo, empresa)
3. ¿Cuáles son todas las preguntas actuales? Pégalas tal cual.
4. ¿Qué debe pasar al final con cada tipo de persona? (a quién se avisa, qué se envía, dónde se guarda)
5. ¿Hay datos sensibles (salud, discapacidad, ideología, menores)?
6. ¿Hay algún cálculo? (puntuación, presupuesto orientativo, prioridad)

## Paso a paso
1. Clasifica cada pregunta: para todos, solo para un grupo, o solo según otra respuesta. Si una pregunta no cambia ninguna decisión, propón quitarla.
2. Elige de 1 a 3 preguntas de entrada, las que reparten a la gente por caminos. Cuantas menos, mejor.
3. Escribe las reglas en una tabla: si [pregunta] es [respuesta], entonces mostrar, ocultar, saltar a otra página o terminar.
4. Busca fallos de lógica: preguntas obligatorias que quedan ocultas (el formulario no se puede enviar), caminos sin final, reglas que se contradicen, respuestas que no encajan en ningún grupo (añade «otro»).
5. Si hay cálculos, escribe la fórmula en palabras y un ejemplo con números. Nada de precios finales al público sin que los revises tú.
6. Define el reparto: según el camino, adónde van las respuestas y quién recibe el aviso.
7. Genera la matriz de pruebas: una fila por camino con las respuestas a dar, las preguntas que deben verse, las que NO deben verse y el resultado esperado. Si salen más de 15 caminos, simplifica antes.
8. Monta o entrega el plano. Recorre cada fila de la matriz con datos ficticios y marca OK o fallo.
9. Prueba también esto: responde, vuelve atrás, cambia la respuesta y mira si se envía algo de lo que ya no se ve.
10. Corrige las reglas con los fallos y repite solo las filas afectadas.

## Qué devolver y con qué formato
1. Mapa de caminos en texto, con sangrías o flechas.
2. Tabla de reglas.
3. Tabla final de preguntas: texto, tipo de campo, obligatoria, visible para, destino.
4. Matriz de pruebas con una casilla de resultado por fila.
5. Lista de riesgos y de dudas para mí.

## Límites y datos personales
- No guardes datos de personas que no hacen falta. Comprueba con la prueba del paso 9 qué se envía de lo que queda oculto.
- La lógica basada en datos sensibles es delicada. Evítala si puedes y, si no, consúltalo con un gestor o un abogado.
- Si el formulario decide algo importante sobre una persona (aceptar o rechazar una solicitud, un servicio, un empleo), no lo automatices del todo. El RGPD da derecho a que una persona revise las decisiones automáticas. Deja siempre ese paso a una persona.
- Pon la información de privacidad y el consentimiento como casillas separadas del resto. Comprueba dónde guarda Fillout los datos y pide su contrato de encargado del tratamiento.

## Qué revisa una persona antes de publicar
- Abre el formulario en tu móvil y recorre al menos 3 caminos reales.
- Confirma que los avisos llegan a la persona correcta en cada camino.
- Lee el texto legal con tu gestor o un abogado.
- Mide después con tus envíos: empezados frente a completados.

## Qué NO hacer
- No publiques. Déjalo en borrador.
- No pongas obligatoria una pregunta que solo ven algunos sin haberla probado.
- No pidas el mismo dato dos veces.
- No uses la lógica para esconder condiciones o precios al cliente.
- No prometas cuánto subirá la conversión.
- No inventes funciones de Fillout. Si dudas de que existan, escribe «compruébalo en el editor».
- No uses datos reales en las pruebas.
