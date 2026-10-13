# Borradores de respuesta a reseñas malas, listos para ap…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Coge cada reseña de 1 a 3 estrellas, redacta con IA una respuesta educada en tu tono y te la manda por email para que solo tengas que decir «sí» y se publique.

## Qué es y qué hace

Flujo de n8n que toma las reseñas de 1 a 3 estrellas de tu app, pide a una IA de texto (Claude, Codex, Gemini o una IA local) un borrador de respuesta con tu tono y lo envía por correo con dos botones para publicar o descartar. Entran el texto de la reseña y tu guía de tono; sale una respuesta lista para aprobar. Requiere la credencial de Google Play y la clave de la IA elegida.

## Cómo usarla

1. 1. Escribe tu guía de tono en tres frases
2. 2. Conecta la IA elegida y Google Play
3. 3. Aprueba los primeros diez borradores antes de automatizar la publicación

## Cuándo usarla

Cuando recibes reseñas negativas y tardas días en contestar, o cuando respondes en caliente y te sale un tono defensivo que empeora la ficha.

## Cómo ganar dinero con ella

De 15 minutos por respuesta a 30 segundos de aprobar. Responder a las reseñas sube la nota media y la conversión de la ficha entre un 5% y un 10%.

- Respuestas a reseñas negativas para apps con mucho volumen de críticas que no dan tiempo a contestar cada una.
- Gestión de reputación de tiendas para agencias que cuidan la nota media de varias apps de clientes.
- Plantillas de respuesta con tono de marca para desarrolladores que quieren sonar humanos sin escribir cada texto.

**Precio orientativo:** 100–250 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Toma las reseñas negativas de tu app, genera con IA un borrador de respuesta con tu tono y te lo envía por correo con dos botones: publicar o descartar.
Para quien tiene app en Google Play y quiere contestar a todo el mundo sin dedicarle media mañana ni sonar a robot.

## Lo que necesitas antes
- El flujo de captación de reseñas ya montado (o el nodo de reseñas de Google Play por separado).
- Cuenta de servicio de Google Cloud con la API de Google Play Developer y permiso «Responder a reseñas» en Play Console.
- Una clave de API de OpenAI (platform.openai.com → API keys) o de Anthropic (console.anthropic.com). Carga 5 € y sobra para meses.
- Gmail conectado en n8n (credencial OAuth2 de Google).
- Una hoja `Respuestas` con: `reviewId`, `texto_original`, `borrador`, `estado`, `fecha`.

## Los nodos, en orden
1. **Schedule Trigger** — cada 2 horas.
2. **HTTP Request** — GET `https://androidpublisher.googleapis.com/androidpublisher/v3/applications/com.tuempresa.tuapp/reviews` con credencial Google Service Account.
3. **Code** («Solo negativas sin responder») — se queda con las de 3 estrellas o menos que no tengan `developerComment`.
4. **OpenAI** (nodo `Message a Model`, modelo `gpt-4o-mini`) o **HTTP Request** a la API de Anthropic. Prompt de sistema: «Eres el responsable de atención al cliente de {NOMBRE APP}. Escribe una respuesta pública de máximo 350 caracteres a esta reseña. Tono cercano, tuteando, español de España. Reconoce el problema, di qué vais a hacer y ofrece escribir a soporte@tuempresa.com. Nada de excusas ni de vender.»
5. **Google Sheets** — `Append` en `Respuestas` con estado `pendiente`.
6. **Gmail** — Send Message a tu correo con el original, el borrador y dos enlaces: `https://TU-N8N/webhook/aprobar?id={{$json.reviewId}}` y `...&accion=descartar`.
7. **Webhook** (flujo aparte, ruta `aprobar`, método GET) — recibe el clic.
8. **IF** — comprueba `{{ $json.query.accion }}` distinto de `descartar`.
9. **Google Sheets** — `Get Row(s)` filtrando por `reviewId` para recuperar el borrador.
10. **HTTP Request** — POST a `https://androidpublisher.googleapis.com/androidpublisher/v3/applications/com.tuempresa.tuapp/reviews/{{$json.reviewId}}:reply` con body JSON `{ "replyText": "{{$json.borrador}}" }`.
11. **Google Sheets** — `Update` poniendo estado `publicada`.
12. **Respond to Webhook** — devuelve un HTML simple: «Respuesta publicada, ya puedes cerrar esta pestaña».

## El código del nodo «Solo negativas sin responder»
```javascript
const salida = [];
for (const item of $input.all()) {
  for (const r of (item.json.reviews || [])) {
    const c = r.comments[0].userComment;
    const yaRespondida = r.comments.some(x => x.developerComment);
    if (!yaRespondida && c.starRating <= 3 && c.text) {
      salida.push({ json: { reviewId: r.reviewId, estrellas: c.starRating, texto: c.text, autor: r.authorName || 'Usuario' } });
    }
  }
}
return salida;
```

## Cómo probarla
- Ejecuta con el nodo de publicación desconectado y revisa 5 borradores seguidos. Si el tono no te encaja, retoca el prompt de sistema, no el flujo.
- Haz una prueba real con una reseña de 3 estrellas poco delicada y comprueba en Play Console que la respuesta aparece publicada en unos minutos.
- Abre el enlace de descartar y confirma que el estado en la hoja cambia y que no se publica nada.

## Qué puede salir mal
- Google Play solo deja responder una vez por reseña; si ya respondiste, la API devuelve error 400. Por eso está el filtro `yaRespondida`.
- Solo puedes responder reseñas de los últimos 7 días vía API. Si tardas más, hay que hacerlo a mano.
- La IA a veces promete cosas («lo arreglamos en la próxima versión»). Añade al prompt: «no prometas plazos ni funciones».
- Protege el webhook: añade un parámetro `token` secreto en la URL y un IF que lo compruebe, o cualquiera con el enlace publica respuestas en tu nombre.
- App Store no permite responder por API pública; para iOS, deja el borrador en la hoja y cópialo a mano en App Store Connect.

## Cuánto cuesta
n8n gratis auto-alojado. La IA sale por unos 0,20-0,50 € al mes con `gpt-4o-mini` para 100-200 reseñas. Gmail y la API de Play, gratis. Coste real: menos de 1 € al mes.
