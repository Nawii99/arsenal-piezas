---
name: kit-skills-comunidad-juego
description: Prepara el kit de skills de quien lleva la comunidad de un videojuego (anuncios y notas de parche, redes sociales, moderación en Discord o foros). Se activa cuando quieres decidir qué skills usar en esas tareas, revisarlas o montar ese kit para un estudio.
---

# Kit de skills para la comunidad de un juego

## Qué hace
Convierte las tareas de una comunidad de jugadores en una lista de skills: cuáles ya tienes, cuáles podrías coger de otros tras revisarlas y cuáles te faltan y conviene escribir tú.
No publica nada y no habla con jugadores. Prepara borradores y un plan. Las decisiones y las publicaciones son de personas.
Dónde ponerla: guarda este texto como SKILL.md dentro de .claude/skills/kit-skills-comunidad-juego/ de tu proyecto.
Cómo pedirla: «Hazme el kit de skills para la comunidad de Discord de nuestro juego, que está en acceso anticipado».

## Pregunta antes de empezar
1. ¿Qué juego o estudio es, de qué género y en qué fase está: en desarrollo, en acceso anticipado o lanzado?
2. ¿Dónde está la comunidad? Discord, Steam, foro, X, TikTok, YouTube, Reddit u otro sitio.
3. ¿En qué idiomas se escribe? ¿Solo español o también inglés?
4. ¿Hay guía de estilo o tono de marca? Si la hay, pide el archivo.
5. ¿Quién aprueba cada texto antes de que salga? Nombre y cargo. Si no hay nadie, avísalo: es lo primero que hay que arreglar.
6. ¿Hay menores en la comunidad?
7. ¿Hay información bajo embargo o con acuerdos de confidencialidad, como fechas, contenido nuevo o colaboraciones?
8. ¿Quién tiene las cuentas y con qué permisos? Si hace falta un bot, ¿existe ya un bot oficial?

## Paso a paso
1. Haz el inventario de tareas en tres bloques. Redacción: notas de parche, anuncios, boletines, preguntas frecuentes. Redes sociales: calendario, textos, respuestas. Comunidad: normas, moderación, resumen del feedback, eventos.
2. Para cada tarea anota cada cuánto se hace, cuánto tiempo lleva y qué riesgo tiene. El riesgo es alto cuando el texto es público y no se puede deshacer.
3. Mira qué skills hay ya en .claude/skills del proyecto y en la carpeta de tu usuario.
4. Para los huecos, busca candidatas en las listas de skills que te dé el usuario. Antes de proponer ninguna, haz la revisión mínima: leer el SKILL.md entero, mirar si trae scripts, si usa internet o pide claves, la licencia y la fecha de la última actualización.
5. Una skill sin licencia no se usa en un servicio de pago.
6. Si no hay candidata que valga, propón escribir una propia. Esboza en 5 líneas cuándo se activa, qué datos pide, qué devuelve y qué no hace.
7. Ordena por prioridad. Primero lo repetitivo y de poco riesgo, como borradores internos o resúmenes de feedback. Al final lo que sale público.
8. Define el flujo de aprobación: Claude propone, una persona aprueba, una persona publica.

## Qué devolver
Una tabla de tareas, una fila por tarea:
| Bloque | Tarea | Frecuencia | Riesgo | Skill propuesta | Estado (instalada, candidata revisada o por escribir) |
|---|---|---|---|---|---|
Una ficha por cada candidata: URL original, licencia, fecha de comprobación [FECHA], qué trae y si es gratis, de código abierto o de pago.
El flujo de aprobación en 3 a 5 líneas, con el nombre de quien aprueba y de quien publica.
Una lista de riesgos y la persona que vigila cada uno.
Si es para un cliente: propuesta de entrega con alcance, qué no incluye y plazo [PLAZO].

## Qué NO hacer
- No publiques, envíes ni programes mensajes. Lo hace una persona.
- No automatices mensajes directos masivos a jugadores ni uses una cuenta de usuario como si fuera un bot. Discord y otras plataformas lo prohíben en sus normas y pueden cerrarte la cuenta o el servidor. Usa solo bots oficiales y lee las normas de cada plataforma.
- No decidas sanciones ni baneos. Claude puede resumir un caso. La decisión es de una persona del equipo.
- No adelantes información bajo embargo ni inventes fechas, parches o recompensas.
- No guardes ni pegues datos personales de jugadores: nombres reales, correos, identificadores de cuenta, mensajes privados.
- No lances sorteos ni concursos sin que alguien revise las bases legales y fiscales. En España tienen reglas propias.
- No te hagas pasar por jugadores ni escribas reseñas falsas.
- No instales skills sin revisarlas.

## Qué revisa una persona
El responsable de la comunidad lee cada texto antes de que salga.
Quien decida en el estudio confirma qué es confidencial y qué se puede adelantar.
Un abogado o gestor mira las bases de sorteos, la política de privacidad y el trato de datos de menores. En España, para tratar datos de menores de 14 años con consentimiento hace falta el de sus padres o tutores. Confírmalo con un profesional o en la web de la AEPD.

Pieza revisada en octubre de 2026. Las normas de cada plataforma cambian: léelas antes de automatizar nada.
