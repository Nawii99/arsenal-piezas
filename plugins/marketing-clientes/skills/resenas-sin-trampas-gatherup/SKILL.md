---
name: resenas-sin-trampas-gatherup
description: Prepara peticiones de opinión a clientes reales, borradores de respuesta a reseñas y un resumen de lo que dicen, con GatherUp. Úsala cuando quieras más opiniones en Google u otros portales sin comprarlas ni filtrarlas.
---

# Reseñas sin trampas con GatherUp

Instalación: guarda este archivo como .claude/skills/resenas-sin-trampas-gatherup/SKILL.md en tu proyecto. Claude Code la usará cuando le pidas gestionar reseñas u opiniones de clientes.
Última revisión: octubre de 2026. Las normas de Google y de cada portal cambian. Léelas antes de lanzar nada.

## Qué hace
- Redacta el mensaje (email y SMS) que se manda al cliente cuando el servicio ha terminado.
- Redacta borradores de respuesta a reseñas positivas y negativas. El usuario los aprueba y los publica.
- Resume las opiniones de un periodo: qué se repite y qué conviene arreglar.
- Si GatherUp está conectado a Claude (por MCP, como los que ofrece Composio, o con n8n), primero comprueba qué permite la conexión. Leer reseñas es una cosa y enviar mensajes a clientes es otra. Lo segundo nunca se hace sin un «sí» escrito del usuario.

## Las reglas, antes de empezar
- Se pide la opinión a todos los clientes, no solo a los que parecen contentos. Mandar a Google solo a los satisfechos y a los demás a un formulario privado va contra las normas de Google. Puede acabar en reseñas borradas o en un perfil penalizado.
- No se ofrecen descuentos ni regalos a cambio de reseñas, y menos a cambio de reseñas positivas.
- No escriben reseñas ni el dueño, ni su familia, ni su plantilla. No se compran reseñas. En la UE las reseñas falsas se consideran práctica engañosa y las autoridades de consumo pueden sancionarlas.
- Si el negocio tiene secreto profesional (sanitario, abogacía...), nunca se confirma en una respuesta pública que esa persona es o fue cliente o paciente.

## Qué preguntar antes de empezar
Pregunta de una en una.
1. ¿Qué negocio es, cuántos locales tiene y en qué portales quieres opiniones? [PORTALES]
2. ¿En qué momento termina el servicio y ya se puede pedir la opinión?
3. ¿Qué datos de contacto tienes de cada cliente (correo, móvil) y cómo se los pediste? ¿Sabían que podrías escribirles? ¿Hay forma de darse de baja?
4. ¿Email, SMS o los dos? El SMS suele costar por mensaje. [COSTE EN TU CUENTA]
5. ¿Qué has hecho hasta ahora para conseguir reseñas? Cuéntalo todo, incluidos regalos o descuentos, para detectar problemas.
6. ¿Cómo hablas con tus clientes? Pega dos mensajes reales tuyos, sin datos personales.
7. ¿Quién aprueba las respuestas y en cuánto tiempo?

## Paso a paso
1. Foto de partida: reseñas totales, nota media, cuántas están sin responder y cuáles son las últimas. Si hay conexión, léelas. Si no, pide que las peguen sin nombres de contacto ni teléfonos.
2. Petición de opinión: dos versiones, email y SMS. Debe decir quién escribe, por qué, con un solo enlace y una sola petición, sin presión ni premio. El SMS, lo más corto posible: las tildes y los emojis pueden reducir los caracteres por mensaje.
3. Frecuencia: un mensaje y, como mucho, un recordatorio. Quien se da de baja o no contesta se apunta y no vuelve a recibir peticiones.
4. Reseñas positivas: gracias, un detalle concreto de lo que cuenta la persona, sin vender nada y sin datos personales.
5. Reseñas negativas: agradece, reconoce el problema sin discutir los hechos, no culpes al cliente, no des detalles del caso y ofrece un canal privado (teléfono o correo del negocio).
6. Si una reseña parece falsa, no la acuses en público. Guarda una captura y avisa a la plataforma de que incumple sus normas.
7. Informe mensual en tabla: reseñas nuevas, nota media, porcentaje respondido, tres temas que se repiten y tres acciones.
8. Entrega todo como borrador marcado «PENDIENTE DE APROBAR».

## Qué devolver y con qué formato
- Mensajes de petición: email (asunto y cuerpo) y SMS.
- Una lista numerada de respuestas. Cada una con la reseña a la que contesta y la marca [APROBAR] o [EDITAR].
- El informe en tabla Markdown.
- Un apartado «Ojo» con los riesgos que hayas visto: filtrado, regalos, datos personales.

## Qué NO hacer
- No envíes nada a clientes ni publiques ninguna respuesta. Todo es borrador.
- No filtres a quién se pide la opinión según lo contento que parezca.
- No ofrezcas ni sugieras recompensas por reseñar.
- No escribas reseñas, ni siquiera de ejemplo para publicar.
- No pongas en una respuesta pública nombres, pedidos, citas ni datos de salud o de pago.
- No contestes con enfado ni con amenazas legales. Si hay una amenaza real, es asunto de un abogado.
- No pidas reseñas a quien no sea cliente real ni a quien ha pedido no recibir mensajes.
- No inventes funciones de GatherUp ni cifras de resultados.

## Revisión humana antes de usar el resultado
Termina siempre recordando que una persona revisa:
- El dueño del negocio aprueba cada respuesta antes de que salga, sobre todo las negativas.
- Su asesor decide si una petición de opinión cuenta como comunicación comercial según la LSSI y el RGPD. Es discutible. Mientras tanto: solo clientes reales, un mensaje y un recordatorio, y baja en cada mensaje.
- Dónde guarda GatherUp los datos de los clientes y si ofrece contrato de encargado de tratamiento.
- Si el negocio es sanitario o con secreto profesional, un profesional del sector revisa cualquier respuesta pública.
