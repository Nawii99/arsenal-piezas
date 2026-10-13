# Reseñas de tu app al chat, con respuesta redactada…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Vigila las reseñas nuevas de Google Play y App Store, avisa en Telegram y te deja escrito un borrador de respuesta listo para copiar y pegar.

## Qué es y qué hace

Receta de n8n que revisa cada hora las reseñas nuevas de tu app en Google Play y en App Store. Entrada: la API de reseñas de Google Play y el RSS público de reseñas de App Store. Salida: un mensaje en Telegram con la estrella, el texto y un borrador de respuesta listo para copiar. El borrador lo escribe la IA que elijas: Claude, Codex, Gemini o una IA local, con un nodo distinto para cada una.

## Cómo usarla

1. Conecta la API de Google Play y el RSS de App Store
2. Elige la IA que redacta el borrador
3. Prueba con una reseña real y activa el flujo cada hora

## Cuándo usarla

Úsalo cuando tienes una app publicada y las reseñas se te acumulan sin contestar, o cuando una mala valoración tarda días en enterarte y ya te ha hundido la nota.

## Cómo ganar dinero con ella

Ahorra la media hora diaria de entrar a las dos consolas y responder a mano. Contestar en menos de 24 h sube la nota media y esa nota es lo que te trae descargas gratis.

- Gestión de reseñas para apps de pequeñas empresas sin equipo…
- Respuestas en menos de 24 horas para una app de reservas de un local…
- Panel mensual de reseñas con temas repetidos para el responsable de producto…

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Cada hora mira si hay reseñas nuevas de tu app en Google Play y en App Store y te las manda a un chat de Telegram con la estrella, el texto y un borrador de respuesta ya escrito.
Es para quien tiene una app publicada y no quiere entrar cada día a dos paneles distintos para enterarse de que alguien le ha puesto una estrella.

## Lo que necesitas antes
Cuenta de n8n (gratis auto-alojado en tu ordenador o servidor, o el plan gratuito de n8n Cloud).
Para Android: la API de reseñas de Google Play. Entra en Google Cloud Console, crea un proyecto, activa «Google Play Android Developer API», crea una cuenta de servicio y descarga el JSON de la clave. Luego en Play Console, Usuarios y permisos, invita al email de esa cuenta de servicio con permiso de ver y responder reseñas.
Para iOS: no hace falta clave, App Store usa un RSS público. La URL es https://itunes.apple.com/es/rss/customerreviews/id=TU_ID_DE_APP/sortBy=mostRecent/json . El ID lo sacas de la URL de tu app en el App Store, es el número que va detrás de «id».
Un bot de Telegram: escribe a @BotFather, comando /newbot, te da un token. Escríbele algo al bot y saca tu chat_id en https://api.telegram.org/bot TU_TOKEN /getUpdates.
Clave de OpenAI en platform.openai.com, apartado API keys (opcional, solo para el borrador de respuesta).

## Los nodos, en orden
1. «Schedule Trigger». Interval: Hours, cada 1 hora.
2. «HTTP Request» (iOS). Method GET, URL el RSS de arriba. Response Format: JSON.
3. «Code» (normalizar iOS). Convierte el RSS en una lista limpia. Código completo:
```js
const entries = $input.first().json.feed.entry || [];
const out = [];
for (const e of entries) {
  if (!e.author || !e['im:rating']) continue;
  out.push({ json: {
    id: e.id.label,
    tienda: 'App Store',
    estrellas: Number(e['im:rating'].label),
    autor: e.author.name.label,
    titulo: e.title.label,
    texto: e.content.label,
    version: e['im:version'] ? e['im:version'].label : ''
  }});
}
return out;
```
4. «HTTP Request» (Android). Method GET, URL https://androidpublisher.googleapis.com/androidpublisher/v3/applications/TU_PACKAGE_NAME/reviews . Authentication: Predefined Credential Type, Google Service Account, y pegas el JSON de la cuenta de servicio. En Scope pon https://www.googleapis.com/auth/androidpublisher.
5. «Code» (normalizar Android). Código completo:
```js
const reviews = $input.first().json.reviews || [];
const out = [];
for (const r of reviews) {
  const c = r.comments[0].userComment;
  out.push({ json: {
    id: r.reviewId,
    tienda: 'Google Play',
    estrellas: c.starRating,
    autor: r.authorName || 'Anónimo',
    titulo: '',
    texto: c.text || '',
    version: c.appVersionName || ''
  }});
}
return out;
```
6. «Merge» en modo Append para juntar las dos listas.
7. «Google Sheets» (operación Lookup en una hoja «reseñas», columna id). Busca si el id ya está guardado. Esto es lo que evita que te avise dos veces de la misma reseña.
8. «IF». Condición: el resultado del Lookup está vacío. Rama true sigue, rama false no hace nada.
9. «OpenAI» (Message a model). Modelo gpt-4o-mini. Prompt: «Eres el responsable de atención al cliente de la app TU_APP. Escribe una respuesta pública de máximo 350 caracteres, en español de España, tuteando, sin excusas largas. Reseña de {{ $json.estrellas }} estrellas: {{ $json.texto }}».
10. «Telegram» (Send Message). Chat ID el tuyo. Texto: «{{ $json.tienda }} · {{ $json.estrellas }}★ · v{{ $json.version }} — {{ $json.autor }}: {{ $json.texto }} — Borrador: {{ $json.message.content }}».
11. «Google Sheets» (Append) guardando id, tienda, estrellas, fecha, para que no se repita.

## Cómo probarla
Ejecuta el flujo a mano con «Execute Workflow» y mira la salida de cada nodo pinchando en él. La primera vez te llegarán de golpe las últimas reseñas: es normal, deja que se guarden todas en la hoja y a partir de ahí solo llegarán las nuevas.
Si quieres probar sin inundarte el chat, pon un nodo «Limit» con Max Items 1 antes del Telegram.

## Qué puede salir mal
El RSS de Apple solo devuelve unas 50 reseñas recientes y solo de una tienda por país. Si vendes en varios países duplica el nodo HTTP cambiando /es/ por /mx/, /us/, etc.
La API de Google Play solo devuelve reseñas de los últimos 7 días. Si apagas n8n una semana, pierdes las de en medio.
Si te llegan duplicados es que el Lookup no encuentra la columna: comprueba que la primera fila de la hoja tiene la cabecera escrita exactamente «id».
Error 401 en Android: casi siempre es que no invitaste a la cuenta de servicio dentro de Play Console, o que tarda unas horas en propagarse el permiso.

## Cuánto cuesta
n8n auto-alojado: gratis. Google Play API y el RSS de Apple: gratis. Telegram: gratis. Google Sheets: gratis.
OpenAI con gpt-4o-mini: unos céntimos al mes con 200 reseñas. Si no quieres pagar nada, quita el nodo de OpenAI y responde tú.
n8n Cloud de pago empieza sobre 20 € al mes, solo si no quieres auto-alojar.
