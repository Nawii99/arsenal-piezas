# Resumen diario de reseñas de Steam en el móvil…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Cada mañana recoge las reseñas nuevas de tu juego en Steam, las resume, propone una respuesta para las negativas y te lo manda por Telegram. Tú decides qué contestar; nada se publica solo.

## Qué es y qué hace

Flujo de n8n que cada mañana lee las reseñas nuevas de tu juego en Steam desde su endpoint público, las resume por idioma y tono, y redacta un borrador de respuesta para las negativas con un modelo de IA. Envía el resumen por Telegram. No publica nada: la respuesta la pega una persona en Steamworks.

## Cómo usarla

1. Crea el bot de Telegram y la clave de IA
2. Configura el App ID y la hora
3. Revisa un resumen de prueba
4. Pega las respuestas tú mismo

## Cuándo usarla

Has lanzado un juego en Steam y no quieres abrir Steamworks cada día para leer las reseñas nuevas, sobre todo las negativas.

## Cómo ganar dinero con ella

Móntalo como servicio de seguimiento de reseñas para estudios indie, con el resumen diario en Telegram, y cobra la instalación y una cuota mensual de [TU PRECIO]. El estudio decide qué contestar; el flujo no publica nada solo.

- Seguimiento diario de reseñas para estudios indie con atención al jugador…
- Instalación y cuota mensual de resúmenes para varios juegos de un mismo estudio…
- Informe semanal de reseñas para decidir parches y actualizaciones…

**Precio orientativo:** 90–250 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Resumen diario de reseñas de Steam en tu móvil (n8n)

Qué hace: todos los días a la hora que fijes, lee las reseñas nuevas de tu juego en Steam, las resume por idioma y tono, redacta un borrador de respuesta para las negativas y te lo manda por Telegram. Tú lees, corriges y pegas en Steamworks. No publica nada.

## Cuentas que hacen falta
- n8n: instalado en tu ordenador o servidor es gratis. n8n Cloud tiene prueba gratuita y luego es de pago; mira el precio actual en su web.
- Telegram: crea un bot con @BotFather. Gratis. Apunta el token y tu chat ID (escribe al bot y consulta https://api.telegram.org/bot[TOKEN]/getUpdates para verlo).
- IA: cuenta de Anthropic (Claude) o de OpenAI con clave de API. Se paga por uso; un resumen diario de unas pocas reseñas cuesta céntimos al mes.
- Steam: no hace falta clave. El endpoint público de reseñas devuelve JSON. Solo necesitas el App ID.

## Nodos, en orden
1. **Schedule Trigger**: todos los días a las 9:00.
2. **HTTP Request**: método GET a `https://store.steampowered.com/appreviews/[APP_ID]?json=1&filter=recent&language=all&num_per_page=100&purchase_type=all`. Sin autenticación. Devuelve un objeto con la lista `reviews`.
3. **Split Out**: campo `reviews`. Cada reseña pasa a ser un item separado.
4. **Filter**: condición numérica, `{{ $json.timestamp_created }}` mayor que `{{ $now.minus(1, 'day').toSeconds() }}`. Steam da la fecha en segundos Unix; así solo pasan las de las últimas 24 horas.
5. **IF**: si no queda ningún item, rama falsa a un Telegram con el texto Hoy sin reseñas nuevas y termina. Si hay, rama verdadera.
6. **Aggregate**: junta todas las reseñas en un solo item. Así haces una única llamada a la IA en vez de una por reseña.
7. **Nodo de IA** (Basic LLM Chain con Anthropic Chat Model u OpenAI Chat Model). Prompt: Reseñas de hoy de [NOMBRE DEL JUEGO]. Para cada una indica: idioma, positiva o negativa (el campo voted_up es true si es positiva), horas jugadas (playtime_forever, en minutos), resumen en una frase. Si es negativa, escribe un borrador de respuesta pública de tres líneas máximo, en el idioma de la reseña, sin discutir, agradeciendo lo concreto y diciendo qué se va a hacer o pidiendo el dato que falta. Al final, los tres temas más repetidos de hoy. Sé breve: máximo 3.000 caracteres. Pasa las reseñas con `{{ JSON.stringify($json) }}`.
8. **Telegram** (Send Message): chat ID el tuyo, texto la salida de la IA. Telegram rechaza mensajes de más de 4.096 caracteres; por eso el prompt limita a 3.000.
9. **Google Sheets** (opcional, Append Row): fecha, recommendationid, voted_up, language, review. Te da un histórico para ver si un parche ha cambiado el tono.

## Cómo probarla sin liarla
- Ejecuta con Test workflow usando el App ID de un juego popular (cualquiera con muchas reseñas al día) para ver datos reales antes de poner el tuyo.
- Desactiva el nodo de Telegram la primera vez y lee la salida de la IA en el panel de n8n. Ajusta el prompt hasta que el borrador suene a ti.
- Si tu juego aún no tiene reseñas, comprueba que la rama falsa del IF manda el mensaje de sin reseñas. Para forzarla, cambia temporalmente el filtro a 1 minuto.
- Activa el flujo solo cuando dos ejecuciones manuales seguidas te hayan dado un mensaje que pegarías tal cual.

## Qué NO hacer
- No publiques respuestas en Steam desde n8n. Se contestan a mano desde Steamworks. Una respuesta automática mal puesta se queda visible para siempre debajo de la reseña.
- No lances la petición cada hora. Steam limita las peticiones agresivas y no ganas nada: las reseñas no se contestan al minuto.
- No contestes una reseña negativa el mismo día si te ha sentado mal. El borrador está para eso: lo lees, lo dejas reposar, lo pegas mañana.
- No metas la clave de la API en el prompt ni en el nombre del nodo. Va en Credentials de n8n.
