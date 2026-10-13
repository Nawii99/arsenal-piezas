---
name: prospectos-b2b-filtro-y-primer-mensaje
description: Filtra y ordena una lista de empresas o contactos B2B según tu cliente ideal y redacta un primer mensaje por segmento, sin enviar nada. Se activa cuando tienes una lista de prospectos (de Convolo AI o de cualquier otra herramienta), o quieres montarla, y necesitas saber a quién contactar primero.
---
# Prospectos B2B: filtro y primer mensaje
Qué hace: toma una lista de prospectos, descarta lo que no encaja, puntúa el resto con datos de la propia lista y prepara un primer mensaje por segmento. No envía nada: lo envía una persona.
No depende de ninguna herramienta. Si exportas la lista de Convolo AI, úsala. Si tienes su conector MCP, escribe /mcp para ver qué ofrece y usa solo lo que entiendas. No supongas funciones que no estén.
## Antes de contactar a nadie, ojo con la ley
- En España, el correo comercial sin consentimiento está restringido (LSSI, art. 21) y las llamadas comerciales sin consentimiento previo también (Ley General de Telecomunicaciones).
- Los datos de contacto profesionales tienen reglas propias (LOPDGDD, art. 19), pero no son barra libre. Mira también la Lista Robinson antes de hacer publicidad por correo o teléfono.
- Consulta con tu gestoría o con un abogado el canal y la base legal antes del primer envío. Esta skill no sustituye esa revisión.
## Antes de empezar, pregunta
1. ¿Qué vendes y a quién (sector, tamaño de empresa, zona, cargo)?
2. ¿Qué tres señales indican un buen cliente y qué tres hacen descartarlo (competidores, clientes actuales, sectores que no quieres)?
3. ¿De dónde viene la lista y hay consentimiento o relación previa? Si nadie lo sabe, no se contacta.
4. ¿Cuántos prospectos son y por qué canal hablará la persona? El canal lo decide ella.
5. ¿Qué tono quieres: cercano, formal, directo?
## Paso a paso
1. Si no tienes lista, busca empresas (no personas) en fuentes públicas: webs de asociaciones del sector, directorios, ferias, buscadores. Apunta web y fuente de cada una. No saques datos de LinkedIn con herramientas automáticas.
2. Resume el cliente ideal en 5 líneas y pide confirmación antes de seguir.
3. Limpia la lista en una copia: quita duplicados (mismo dominio y mismo cargo, o mismo email), filas sin empresa y empresas que coincidan con las exclusiones. Aparta los correos personales (gmail, hotmail...).
4. Puntúa cada fila de 0 a 3. 3 = encaja en todo. 2 = encaja pero falta un dato. 1 = dudoso. 0 = descartar. Una línea de motivo con datos de la propia lista. Si falta el dato, escribe «sin datos» y no adivines.
5. Si la persona lo permite y tienes acceso a la web, mira la web pública de las 10 empresas mejor puntuadas. Apunta algo concreto y verificable, con su enlace. Lo que no puedas verificar, no lo uses en el mensaje.
6. Redacta un primer mensaje por segmento, no uno por persona salvo que lo pidan. Máximo 90 palabras. Debe decir quién escribe y de qué empresa, un motivo de contacto basado en un dato real, una sola petición y una línea para no recibir más mensajes. Dos variantes.
7. Propón un orden de contacto: primero las de 3, en lotes pequeños.
## Qué devolver y con qué formato
- Cliente ideal en 5 líneas.
- Tabla con empresa, puntuación, motivo y dato que falta.
- Descartados y por qué.
- Mensajes por segmento, con dos variantes cada uno.
- Avisos: legales, de datos dudosos y de lo que no se pudo comprobar.
- Si lo piden, prospectos-puntuados.csv con la tabla.
## Qué NO hacer
- No envíes mensajes, no llames y no programes envíos.
- No adivines emails por patrón (nombre.apellido@): rebotan y dañan la reputación de tu dominio.
- No automatices LinkedIn: sus normas lo prohíben y pueden cerrarte la cuenta.
- No inventes datos de una empresa, noticias ni felicitaciones. No escribas «hemos visto que...» si no lo has visto.
- No prometas resultados en el mensaje.
- No contactes a quien ya dijo que no ni uses datos sensibles.
- No toques la lista original: trabaja siempre en una copia.
## Quién revisa
- Una persona de ventas lee los mensajes antes de que salga ninguno.
- Tu gestoría o tu abogado revisan el canal y la base legal antes del primer envío.
Instalación: guarda este texto como .claude/skills/prospectos-b2b-filtro-y-primer-mensaje/SKILL.md en tu carpeta de trabajo y abre Claude Code en esa carpeta.
