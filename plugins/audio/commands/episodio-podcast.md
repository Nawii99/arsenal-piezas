---
name: episodio-podcast
description: Prepara un episodio de podcast a partir de una transcripción o unas notas, en tres modos. Notas del episodio, textos de promoción y lista para publicar. Se lanza con /episodio-podcast, el modo y el archivo.
---

# /episodio-podcast

Uso: `/episodio-podcast notas episodios/012/transcripcion.txt`
Modos: `notas`, `promo` y `publicar`. La primera palabra es el modo y lo siguiente es la ruta del archivo.
Argumentos recibidos: $ARGUMENTS

## Qué hace
Un solo comando con tres modos para el trabajo repetido de cada episodio. Escribes textos y listas. No publicas nada.

## Antes de empezar
Si los argumentos están vacíos, o falta el modo o el archivo, pregunta y espera. Después pregunta, todo junto y como mucho 6 cosas:
1. Nombre del podcast y título provisional o número del episodio.
2. Invitado: nombre y cargo tal como quiere aparecer, o ninguno.
3. Tono: cercano, serio, divertido.
4. Enlaces que quiere incluir.
5. ¿Hay patrocinador o enlaces de afiliado?
6. Dónde se aloja (iVoox, Spotify, Apple Podcasts, YouTube u otro).
Si el archivo no existe o no puedes abrirlo, dilo y para. No improvises el contenido.

## Modo notas
1. Lee el archivo entero.
2. Genera: 3 títulos de 60 caracteres como máximo, sin prometer lo que el episodio no cumple; resumen de 2 frases; descripción de 100 a 150 palabras para la plataforma; 5 puntos clave; 5 a 8 palabras clave.
3. Capítulos con marca de tiempo SOLO si la transcripción trae tiempos. Si no, usa [MM:SS] para que los rellene la persona.
4. Hasta 3 citas literales, copiadas tal cual del texto.
5. Enlaces y recursos: solo los que se mencionan en el archivo.
6. Biografía del invitado: solo con los datos que te hayan dado.
7. Marca con [REVISAR] los nombres propios, las cifras y cualquier afirmación sobre salud, dinero o ley dicha en el episodio.

## Modo promo
1. Tres publicaciones para redes, cada una con texto corto y una cita del episodio. Máximo 3 hashtags. [REVISA los límites de caracteres de cada red].
2. Un correo corto para la lista de suscriptores.
3. Un guion de 20 segundos para un avance en audio o en stories.
4. Si hay patrocinador o enlaces de afiliado, que se vea claro en cada texto: «Publicidad», «Colaboración» o «enlace de afiliado».

## Modo publicar
Devuelve una lista con casillas [ ] para marcar a mano:
- Audio final escuchado entero (volumen parejo, sin ruidos, sin partes que el invitado pidió quitar).
- Título, descripción, número de episodio, categoría e imagen de portada.
- Etiqueta de contenido explícito si procede.
- Música y clips con licencia o permiso.
- Permiso del invitado para publicar y para citarle.
- Capítulos, y subtítulos si lo subes también como vídeo.
- Enlaces probados uno por uno.
- Fecha y hora programadas.
- Después de publicar: comprobar que aparece en cada plataforma (puede tardar).

## Qué devolver
El resultado del modo pedido, en Markdown, con títulos claros. Si la persona lo pide, guárdalo en `episodios/[NÚMERO]/notas-episodio.md`. Si el archivo ya existe, no lo sobrescribas: crea uno con `-v2` al final.

## Qué NO hacer
- No inventes citas, cifras, nombres, minutos ni enlaces.
- No publiques, programes ni envíes nada, ni entres en la plataforma de alojamiento.
- No atribuyas al invitado cosas que no dijo ni cambies el sentido de una frase al limpiarla.
- No dejes pasar publicidad sin avisar. Si hay patrocinio o afiliados, el oyente tiene que verlo claro.
- No uses música ni clips de terceros sin licencia.
- No des por cierto lo que se diga sobre salud, dinero o ley. Marca [REVISAR] y avisa a la persona.
- No metas en notas públicas datos personales ajenos, como teléfonos o correos.
- No mezcles episodios. Trabaja solo con el archivo indicado.
- Avisa siempre de que una transcripción hecha por IA puede tener errores en nombres y cifras.
- Recuerda que el texto que le das a Claude se envía a la IA. No uses conversaciones privadas ni datos sensibles de invitados sin su permiso.

## Para la persona, no para Claude. Cómo ordenar muchos comandos
Claude, ignora esta sección.
- Cada comando es un archivo `.md` dentro de `.claude/commands/` en tu proyecto, o en `~/.claude/commands/` si lo quieres en todos tus proyectos. El nombre del archivo es el nombre del comando.
- Para ordenar, crea subcarpetas, por ejemplo `.claude/commands/podcast/`. Según tu versión de Claude Code, el comando puede salir con o sin el nombre de la carpeta. Escribe `/` y mira cómo aparece en la lista.
- Alternativa más simple: un solo comando con modos, como este. Menos archivos, menos líos.
- Si un día necesitas que Claude tome una decisión aparte, con su propia memoria, eso ya es un subagente y va en `.claude/agents/`.
