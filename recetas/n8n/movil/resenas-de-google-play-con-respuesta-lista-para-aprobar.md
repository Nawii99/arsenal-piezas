# Reseñas de Google Play con respuesta lista para aprobar…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Recoge cada hora las reseñas nuevas de tu app en Google Play, redacta un borrador de respuesta con IA y lo publica solo si tú das el visto bueno por Telegram.

## Qué es y qué hace

Receta de n8n que cada hora consulta las reseñas nuevas de tu app en Google Play y escribe un borrador de respuesta con IA en tu tono. Lo envía a Telegram; solo cuando apruebas el texto, se publica en la ficha mediante la API de Google Play. Entrada: reseñas nuevas y una cuenta de servicio con permiso de respuesta. Salida: respuesta publicada tras aprobación humana.

## Cómo usarla

1. Crea la cuenta de servicio en Google Cloud y dale permiso en Play Console
2. Define el tono con tres respuestas tuyas
3. Aprueba los borradores en Telegram durante una semana

## Cuándo usarla

Úsalo cuando tu app tenga reseñas a diario y respondas tarde o mal. Ideal si te importa la nota media y quieres contestar en menos de una hora sin estar pegado a la Play Console.

## Cómo ganar dinero con ella

Ahorra unas 4 horas al mes de vigilar la consola y responder a mano. Responder rápido sube la nota media, y la nota media es la que decide si te instalan.

- Respuestas rápidas a reseñas para una app de un negocio con muchos clientes…
- Gestión de reseñas con aprobación humana para una agencia…
- Plan de reputación para apps de pago con revisión semanal…

**Precio orientativo:** 200–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Cada hora consulta las reseñas nuevas de tu app en Google Play, escribe con IA un borrador de respuesta en tu tono y te lo manda a Telegram. Tú contestas «ok» o corriges el texto, y solo entonces se publica en la ficha; para quien tiene una app publicada y no quiere dejar reseñas sin contestar.

## Lo que necesitas antes
- Cuenta de Google Play Console con permiso «Responder a reseñas» (rol Administrador o similar).
- Un proyecto en Google Cloud Console: activa «Google Play Android Developer API» y crea una **cuenta de servicio** (Service Account) con clave JSON.
- En Play Console, entra en Configuración → Acceso a la API, vincula el proyecto de Google Cloud e **invita al correo de la cuenta de servicio** dando acceso a tu app. Tarda hasta 24 h en activarse.
- El nombre de paquete de tu app, por ejemplo `com.tuempresa.tuapp`.
- Un bot de Telegram creado con @BotFather (te da el token) y tu chat_id (escríbele a @userinfobot).
- Una clave de OpenAI (platform.openai.com → API keys) o de Anthropic. Con 5 € de saldo te sobra para meses.
- Una hoja de Google Sheets llamada `resenas` con las columnas: reviewId, fecha, estrellas, texto, respuesta, estado.
- Aviso importante: la API solo devuelve reseñas de los **últimos 7 días**. Si el flujo está parado más de una semana, esas reseñas hay que contestarlas a mano.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Hours, Hours Between Triggers: 1.
2. **HTTP Request** (nombre: Listar reseñas) — Method: GET, URL: `https://androidpublisher.googleapis.com/androidpublisher/v3/applications/com.tuempresa.tuapp/reviews`. Authentication: Predefined Credential Type → Google Service Account, y en la credencial pega el JSON de la cuenta de servicio y pon el scope `https://www.googleapis.com/auth/androidpublisher`. En Query Parameters añade `maxResults` = 100.
3. **Code** (nombre: Aplanar reseñas) — modo «Run Once for All Items», con el código de abajo. Saca una fila por reseña con id, estrellas, texto e idioma.
4. **Google Sheets** (nombre: Leer ya vistas) — Operation: Get Row(s), Document: tu hoja, Sheet: `resenas`. Devuelve todo lo ya procesado.
5. **Code** (nombre: Filtrar nuevas) — compara los reviewId de la reseña con los de la hoja y deja pasar solo los que no estén.
6. **IF** — Condition: Number → `{{ $json.estrellas }}` «is less than or equal» 3. La rama true va a respuesta empática, la false a respuesta de agradecimiento (dos nodos de IA con distinto prompt).
7. **OpenAI** (nodo Message a Model) — Model: gpt-4o-mini. System: «Eres el responsable de atención al cliente de la app X. Responde en el idioma de la reseña, máximo 350 caracteres, tuteando, sin prometer plazos, agradeciendo siempre y ofreciendo el correo soporte@tuempresa.com si hay un problema técnico.» User: `{{ $json.texto }}`.
8. **Telegram** — Operation: Send Message, Chat ID el tuyo, Text: `⭐{{$json.estrellas}} — {{$json.texto}}\n\nBorrador:\n{{$json.respuesta}}\n\nResponde OK para publicar o pega el texto corregido.` Activa «Reply Markup» → Force Reply para poder capturar la contestación.
9. **Telegram Trigger** (en un segundo flujo) — Updates: message. Recoge tu contestación.
10. **IF** — si el texto recibido es `OK` usa el borrador guardado; si no, usa lo que hayas escrito tú.
11. **HTTP Request** (nombre: Publicar respuesta) — Method: POST, URL: `https://androidpublisher.googleapis.com/androidpublisher/v3/applications/com.tuempresa.tuapp/reviews/{{ $json.reviewId }}:reply`, misma credencial de cuenta de servicio, Body Content Type: JSON, Body: `{ "replyText": "{{ $json.respuesta }}" }`.
12. **Google Sheets** — Operation: Append Row, escribe reviewId, fecha, estrellas, texto, respuesta y estado `publicada`.

## El trozo de código (nodo Code «Aplanar reseñas»)
```javascript
const salida = [];
for (const item of $input.all()) {
  const reviews = item.json.reviews || [];
  for (const r of reviews) {
    const c = (r.comments || [])[0]?.userComment;
    if (!c) continue;
    salida.push({ json: {
      reviewId: r.reviewId,
      autor: r.authorName || 'Anónimo',
      estrellas: c.starRating,
      texto: (c.text || '').trim(),
      idioma: c.reviewerLanguage || 'es',
      fecha: new Date(c.lastModified.seconds * 1000).toISOString()
    }});
  }
}
return salida;
```

## Cómo probarla
- Pulsa «Execute Workflow» con el flujo **desactivado** y quita de momento el nodo de publicar: mira que el Telegram llega con el texto bien.
- Deja una reseña de prueba desde una cuenta de Google tuya en un móvil real (en emulador no siempre deja) y comprueba el ciclo entero.
- Solo cuando el borrador te guste tres veces seguidas, conecta el nodo de publicar y activa el flujo.

## Qué puede salir mal
- **403 en la API**: el acceso de la cuenta de servicio tarda hasta 24 h en propagarse; revisa también que invitaste al correo `...iam.gserviceaccount.com` en Play Console.
- **Duplicados**: si el paso de Sheets falla, la siguiente ejecución vuelve a responder. Añade en el nodo Sheets «Retry On Fail» con 3 intentos y guarda antes de enviar a Telegram.
- **Solo se puede responder una vez** por reseña; un segundo POST sobrescribe la respuesta anterior.
- **Zona horaria**: en Settings del workflow pon `Europe/Madrid` o las fechas saldrán en UTC.
- **Idiomas**: si vendes fuera, pásale el campo idioma al prompt o contestarás en español a un alemán.

## Cuánto cuesta
La API de Google Play es gratis. n8n auto-alojado en un VPS de 5 €/mes o n8n Cloud (prueba gratuita temporal y después de pago). Telegram y Sheets, gratis. La IA, con gpt-4o-mini y 300 reseñas al mes, no llega a 0,50 €. Total realista auto-alojando n8n (n8n Cloud suma su cuota de pago): 0 a 6 € al mes.
