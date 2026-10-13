---
name: llamadas-con-permiso-godial
description: Prepara y ordena campañas de llamadas en Godial con lista depurada, guion, horarios, registro de resultados e informe, y no lanza nada sin confirmación. Úsala para avisos y seguimiento a clientes, y para prospección solo después de la revisión legal.
---

# Campañas de llamadas con permiso y control (Godial)

Instalación: guarda este archivo como .claude/skills/llamadas-con-permiso-godial/SKILL.md en tu proyecto. Claude Code la usará cuando le pidas preparar una campaña de llamadas.
Última revisión: octubre de 2026. Las leyes y las condiciones de Godial cambian. Comprueba ambas antes de lanzar.

## Aviso antes de nada
- En España, llamar con fines comerciales a quien no ha dado permiso está restringido por la Ley General de Telecomunicaciones de 2022 y por el RGPD. Hay que respetar la Lista Robinson y las bajas propias. La AEPD sanciona, con multas que pueden ser de miles de euros.
- Esta skill prepara y ordena. No decide si se puede llamar a una lista. Eso lo decide un abogado o un asesor de protección de datos antes de lanzar.
- Cada llamada cuesta dinero. Claude no pulsa «iniciar» ni gasta saldo sin una confirmación escrita del usuario.

## Qué hace
- Clasifica y depura una lista de contactos: quién tiene permiso o relación con el negocio y quién no.
- Escribe el guion de la llamada y las respuestas a las objeciones más habituales.
- Prepara el plan de la campaña (tanda piloto, franjas horarias, reintentos) y la tabla para registrar resultados.
- Redacta el informe al terminar.
- Si Godial está conectado a Claude (por MCP, como los que ofrece Composio, o con n8n), primero lee qué acciones permite esa conexión. No supone nada sobre Godial. Si no se puede comprobar, trabaja en modo «preparar» sin tocar la cuenta.

## Qué preguntar antes de empezar
Pregunta de una en una.
1. ¿Qué tipo de llamada es? (a) Aviso de servicio a clientes, como recordar una cita o avisar de que un pedido está listo. (b) Seguimiento a quien ya te ha comprado. (c) Prospección comercial a gente que no es cliente. La (c) no empieza sin revisión legal previa.
2. ¿De dónde salen los números y con qué permiso? ¿Tienes guardado cuándo y cómo lo dieron?
3. ¿Se cruza la lista con la Lista Robinson y con tu propia lista de bajas? ¿Quién lo hace y cuándo?
4. ¿Llama una persona o una voz automática o de IA? Si es automática, debe avisar de que no es una persona. El reglamento europeo de IA va en esa dirección. Pregunta a tu asesor cómo te afecta.
5. ¿En qué franjas horarias se puede llamar? [HORARIO QUE TE CONFIRME TU ASESOR]
6. ¿Se graban las llamadas? Si es que sí, hay que avisar al inicio.
7. ¿Qué plan tienes en Godial, cuánto cuesta cada llamada o minuto y qué saldo hay? [MIRA EN TU CUENTA]
8. ¿Desde qué número se llama? Tiene que ser tuyo y poder recibir la llamada de vuelta.
9. ¿Qué quieres saber al terminar? Citas cerradas, interesados, bajas, quejas.

## Paso a paso
1. Mira qué permite la conexión con Godial (listar contactos, crear listas o campañas, consultar llamadas...). Dilo al usuario antes de seguir.
2. Clasifica la lista: cuántos contactos hay, cuáles tienen permiso o relación y cuáles no. Los que no, se apartan de la campaña con su motivo. No se mezclan.
3. Depura: duplicados, teléfonos mal formados (9 cifras en España o el prefijo internacional correcto), contactos de la lista de bajas y clientes con una reclamación abierta. A quien reclama no se le llama para vender.
4. Guion: quién llama y de qué empresa, motivo en una frase, si se graba, pregunta de permiso para seguir («¿Tiene un minuto?»), cuerpo corto, objeciones habituales y cierre.
5. Baja inmediata: «Si prefiere que no volvamos a llamarle, lo anoto ahora mismo». La baja se vuelca a la lista de exclusión el mismo día.
6. Plan de campaña: tanda piloto pequeña [NÚMERO DE CONTACTOS], franjas horarias, máximo de reintentos por contacto [NÚMERO] y condición para parar (por ejemplo, la primera queja).
7. Resumen previo al lanzamiento: lista, guion, horarios, coste estimado y saldo. Pausa y espera un «sí, lanza» escrito del usuario.
8. Piloto: escucha una muestra de llamadas y revisa resultados antes de ampliar.
9. Registro de cada llamada: fecha, resultado (contesta, no contesta, ocupado, rechaza, baja, interesado), siguiente paso y responsable.
10. Informe: contactos llamados, contestadas, interesados, bajas, quejas, coste total y coste por interesado (coste total entre interesados). Con los números reales, sin comparar con medias de otros.

## Qué devolver y con qué formato
- Ficha de campaña, en tabla: tipo de llamada, origen de la lista, permiso, horario, coste estimado y número de piloto.
- La lista apartada con el motivo de cada exclusión, sin datos personales innecesarios.
- El guion en bloques: apertura, permiso, cuerpo, objeciones, baja y cierre.
- La plantilla de registro, en tabla.
- El informe en tabla.
- Un apartado «Pendiente de revisión humana».

## Qué NO hacer
- No uses listas compradas, rascadas de internet ni de origen desconocido.
- No ocultes ni falsees el número desde el que se llama.
- No llames fuera del horario confirmado por el asesor.
- No sigas llamando a quien ha dicho que no.
- No pidas datos de tarjeta, claves ni códigos de verificación en una llamada automatizada ni en un guion.
- No escribas guiones que presionen, engañen o aparenten ser un banco, Hacienda, la Seguridad Social u otro organismo.
- No hagas pasar una voz automática por una persona.
- No lo uses para reclamar deudas con presión. Esa actividad tiene reglas propias.
- No lances la campaña ni gastes saldo sin confirmación escrita.
- No vuelques en el chat listas completas con datos personales. Trabaja con muestras o exportaciones mínimas.
- No inventes funciones, precios ni límites de Godial.

## Revisión humana antes de usar el resultado
Termina siempre recordando que una persona revisa:
- Un abogado o asesor de protección de datos aprueba la base legal de cada lista, el cruce con la Lista Robinson, el guion, el aviso de grabación y el uso de voz automática.
- El responsable del negocio aprueba el coste y el tamaño del piloto.
- Una persona escucha una muestra de las llamadas del piloto antes de ampliar.
- Si el negocio es sanitario, financiero o legal, el guion lo valida alguien del sector.
