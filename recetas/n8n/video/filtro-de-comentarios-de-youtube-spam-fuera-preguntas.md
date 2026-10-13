# Filtro de comentarios de YouTube: spam fuera, preguntas…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Revisa cada 15 minutos los comentarios nuevos del canal, oculta el spam y las estafas, y te manda por Telegram solo los que son preguntas reales de clientes potenciales.

## Qué es y qué hace

Es una automatización de n8n que revisa cada 15 minutos los comentarios nuevos de tu canal, los clasifica con un modelo de IA (Claude, Codex, Gemini o una IA local) en pregunta, elogio, crítica o spam, oculta el spam y te avisa solo de preguntas y críticas. Entra la lista de comentarios recientes y sale una moderación automática, un aviso por Telegram y un registro en Sheets. Usa una credencial YouTube OAuth2 con permiso de moderar.

## Cómo usarla

1. Conecta YouTube con permiso de moderar
2. Elige el modelo de IA y su clave
3. Prueba con comentarios de ejemplo
4. Revisa lo que oculta los primeros días

## Cuándo usarla

Úsalo cuando tu canal reciba suficientes comentarios como para que se te escapen preguntas de compra entre el spam de criptomonedas y los bots que suplantan tu cuenta.

## Cómo ganar dinero con ella

Recuperas las ventas que se pierden por no contestar y te quitas 20-30 min diarios de moderación manual.

- Moderación para creadores con mucho spam de criptomonedas y bots.
- Filtro de preguntas de compra para negocios que venden por YouTube y pierden consultas.
- Gestión de comunidad mensual para canales de clientes.

**Precio orientativo:** 100–250 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Descarga los comentarios recientes de todo el canal, los clasifica con IA en cuatro tipos (pregunta, elogio, crítica, spam), oculta automáticamente el spam y te avisa solo de las preguntas y de las críticas, dejando registro en una hoja.
Para canales que ya reciben comentarios a diario y para negocios donde un comentario puede ser un cliente.

## Lo que necesitas antes
- n8n y credencial **YouTube OAuth2** con permiso `youtube.force-ssl` (el de moderar).
- Clave de API de OpenAI (o cualquier modelo compatible; también sirve Groq o un modelo local con el nodo HTTP Request).
- Bot de Telegram con su token y tu `chat_id`.
- Hoja `Comentarios` con columnas: `id`, `autor`, `texto`, `tipo`, `video`, `fecha`, `accion`.

## Los nodos, en orden
1. **Schedule Trigger** — cada 15 minutos.
2. **HTTP Request** — GET `https://www.googleapis.com/youtube/v3/commentThreads`, Authentication: Predefined → YouTube OAuth2. Query: `part` = `snippet`, `allThreadsRelatedToChannelId` = `TU_CHANNEL_ID`, `maxResults` = `50`, `order` = `time`, `moderationStatus` = `published`.
3. **Split Out** — Field to Split Out: `items`.
4. **Google Sheets** (Get Row(s)) — lee la hoja para saber cuáles ya trataste.
5. **Code** (quedarte con lo nuevo):
```javascript
const vistos = new Set($('Google Sheets').all().map(i => String(i.json.id)));
return $input.all().filter(i => !vistos.has(i.json.id)).map(i => {
  const s = i.json.snippet.topLevelComment.snippet;
  return { json: { id: i.json.id, autor: s.authorDisplayName, texto: s.textOriginal, video: i.json.snippet.videoId, fecha: s.publishedAt } };
});
```
6. **OpenAI** (Message a Model) — Model `gpt-4.1-mini`. System: «Clasificas comentarios de YouTube de un negocio español. Devuelve solo JSON.» User: `Clasifica este comentario en tipo (pregunta|elogio|critica|spam) y urgencia (alta|baja). Marca spam si vende algo, pide contactar por WhatsApp, suplanta al creador o promete beneficios de inversión. Comentario de {{ $json.autor }}: "{{ $json.texto }}"`. Activa `Output Content as JSON` y `Simplify` desactivado.
7. **Switch** — Modo Rules sobre `{{ $json.tipo }}`: salida 0 `spam`, salida 1 `pregunta`, salida 2 `critica`, salida por defecto el resto.
8. Rama **spam** → **HTTP Request**: POST `https://www.googleapis.com/youtube/v3/comments/setModerationStatus?id={{ $('Code').item.json.id }}&moderationStatus=rejected&banAuthor=false`, sin cuerpo, con la credencial de YouTube.
9. Rama **pregunta** y **crítica** → **Telegram** (Send Message): `❓ {{ $json.tipo }} de {{ $('Code').item.json.autor }}: {{ $('Code').item.json.texto }} — https://youtu.be/{{ $('Code').item.json.video }}`.
10. **Google Sheets** (Append Row) — al final de todas las ramas, con `tipo` y `accion` (`oculto`, `avisado`, `ignorado`).

## Extra: borrador de respuesta
Si quieres, añade tras la rama de pregunta un **OpenAI** que redacte una respuesta corta en tu tono y la mande en el mismo mensaje de Telegram. Tú solo copias y pegas. No publiques automáticamente: una respuesta desafortunada en público sale cara.

## Cómo probarla
- Escribe tú mismo tres comentarios de prueba en un vídeo oculto: uno con una pregunta, uno con «invierte conmigo en cripto, escribe a este WhatsApp» y uno normal.
- Comprueba que el de cripto queda oculto (aparece en YouTube Studio → Comentarios → Retenidos) y que solo te llega uno a Telegram.

## Qué puede salir mal
- **Solo puedes moderar tu canal**: `setModerationStatus` falla con comentarios de canales ajenos.
- **`banAuthor=true` es irreversible**: déjalo en false salvo reincidentes.
- **Cuota**: `commentThreads.list` gasta 1 unidad, moderar 50; cada 15 minutos son 96 llamadas al día, nada.
- **Falsos positivos**: revisa la hoja la primera semana. Si la IA oculta comentarios legítimos, endurece el prompt con ejemplos reales tuyos.
- **Comentarios en respuestas**: `commentThreads` solo trae el nivel superior; si necesitas respuestas, añade `part=replies`.

## Cuánto cuesta
- Clasificar 1.000 comentarios con un modelo pequeño: menos de 0,30 €.
- YouTube API y Telegram: gratis. n8n auto-alojado: 0 €.
