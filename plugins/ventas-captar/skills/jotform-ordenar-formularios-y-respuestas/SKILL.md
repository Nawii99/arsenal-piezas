---
name: jotform-ordenar-formularios-y-respuestas
description: Revisa formularios de Jotform, resume las respuestas nuevas, detecta datos incompletos o sospechosos y prepara a quién debe llegar cada una. Úsala cuando un formulario recibe presupuestos, inscripciones o reservas. No borra respuestas ni cambia el formulario publicado.
---

# Formularios Jotform ordenados: revisar, resumir y repartir respuestas

Hace dos trabajos principales. Uno, revisar que el formulario pide lo justo y cumple lo básico de privacidad. Dos, leer las respuestas nuevas, resumirlas y repartir cada una a quien le toca. Los cambios en el formulario y la automatización son propuestas opcionales.

## Lo que haces tú, una sola vez
- Guarda este texto en `.claude/skills/jotform-ordenar-formularios-y-respuestas/SKILL.md`.
- Conecta Jotform con un conector MCP (un enlace que deja a la IA usar tu cuenta) o con su clave de acceso. Mira con `/mcp` que está activo. No pegues la clave en el chat.
- Mira en tu cuenta dónde se guardan los datos y qué ofrece tu plan en protección de datos. Si tu cliente es de la UE, compruébalo antes de empezar [REVÍSALO EN TU CUENTA].
- Si el formulario pide datos de salud, documentos de identidad, pagos o datos de menores, no lo uses con esta skill hasta que lo haya revisado la persona responsable.

## Qué preguntar antes de empezar
1. ¿Qué formulario o formularios? ¿Para qué sirven?
2. ¿Qué pasa hoy con cada respuesta? ¿Quién la lee y dónde se copia?
3. ¿A quién debe llegar cada tipo de respuesta y qué se espera de esa persona? Que te dé las reglas.
4. ¿Desde qué fecha revisamos las respuestas?
5. ¿Qué datos personales se piden? ¿Hay casilla de aceptación de la política de privacidad?
6. ¿Qué plazo de contestación se ha prometido a quien rellena el formulario?
7. ¿En qué idioma contestamos?

## Paso a paso
1. Comprueba la conexión. Si no hay herramientas de Jotform, para y dilo. No inventes formularios ni respuestas.
2. Parte A, revisar el formulario (solo lectura). Lista los campos. Marca los que sobran (cada dato pedido necesita un motivo), los que faltan, los obligatorios que no deberían serlo, los de datos sensibles, el texto de privacidad, la casilla de aceptación, el mensaje de confirmación y a quién llega el aviso por correo.
3. Parte B, respuestas nuevas. Trae las de la fecha acordada. Valida emails con formato raro, teléfonos incompletos, duplicados, campos vacíos, spam evidente y respuestas absurdas.
4. Clasifica cada respuesta: completa, a completar (falta algo) o sospechosa.
5. Parte C, resumir y repartir. Escribe una línea por respuesta, propón a quién va según las reglas del usuario y redacta un borrador de confirmación para quien rellenó el formulario. No prometas precio ni plazo salvo los que el usuario te dio.
6. Después redacta un aviso breve por cada persona de tu equipo que recibe respuestas. Cada aviso dice qué respuestas le tocan y qué se espera de ella según las reglas del usuario. No inventes plazos ni tareas. Incluye solo los datos personales que esa persona necesita.
7. Prepara las respuestas en tabla, lista para pegar en una hoja de cálculo.
8. Parte D, cambios en el formulario (opcional). Propónlos por escrito. No los apliques sin OK. Si el usuario los aprueba, duplica el formulario y trabaja en la copia.
9. Parte E, automatizar de verdad (opcional). Que cada respuesta llegue sola a una hoja de cálculo o a un CRM (el programa donde guardas tus clientes y contactos) se monta fuera de esta skill, con una herramienta de automatización (como Zapier, Make o n8n) o con las conexiones que trae Jotform. Tú escribe qué dato del formulario va a qué columna de la hoja y qué reglas se aplican.

## Qué devolver
1. Informe del formulario: lo que está bien, lo que sobra, lo que falta y los riesgos de privacidad.
2. Tabla de respuestas: Fecha | Nombre | Contacto | Resumen | Estado | A quién va.
3. Borradores de confirmación, uno por respuesta que lo necesite.
4. Avisos internos: uno por cada destinatario, con las respuestas que le tocan y qué se espera de él o de ella.
5. Lista de dudas para el usuario.
6. Si procede, qué dato del formulario va a qué columna de la hoja, para automatizarlo.

## Qué NO hacer
- No borres respuestas ni formularios. No cambies el formulario publicado.
- No contestes a quien rellena el formulario. Solo borradores.
- No añadas campos por si acaso.
- No pidas datos de salud, DNI, IBAN ni datos de menores sin que lo haya decidido la persona responsable.
- No uses los datos para algo distinto de lo que dice el formulario.
- No inventes respuestas ni rellenes campos vacíos.
- No prometas plazos ni precios que no te hayan dado.
- No pongas en un aviso interno más datos personales de los que necesita quien lo recibe.
- No copies datos de personas fuera de esta sesión.

## Cuándo parar y llamar a una persona
- Formularios con pagos, salud o menores.
- Alguien pide ver, corregir o borrar sus datos. El plazo legal general es corto (un mes).
- Respuestas con quejas, amenazas o reclamaciones.
- Datos que no deberían haber llegado, como un DNI en un campo libre. Avisa y no los copies.

## Qué revisa una persona antes de usar el resultado
- La persona responsable del formulario revisa la política de privacidad (quién es el responsable, para qué se usan los datos, qué derechos tienen), los datos que se piden y cuánto tiempo se guardan.
- Esa persona aprueba cualquier cambio antes de publicarlo.
- Si el formulario es de un cliente, hay contrato de encargado del tratamiento firmado antes de ver sus respuestas.
- Cada borrador de confirmación y cada aviso interno lo lee una persona antes de enviarlo.
