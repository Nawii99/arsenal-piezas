# Respuestas a reseñas de 1 y 2 estrellas con tu visto bu…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Cada día busca las reseñas malas de tu app en Google Play, te propone una respuesta redactada y la publica solo cuando tú das el OK.

## Qué es y qué hace

Flujo de n8n que descarga las reseñas nuevas de tu app en Google Play, selecciona las de 1 y 2 estrellas sin respuesta, redacta un borrador con una IA de texto (Claude, Codex, Gemini o una IA local) y lo envía a Telegram con dos botones: publicar o descartar. Entran las reseñas por la API de Google Play; sale la respuesta publicada solo tras tu visto bueno. Requiere una cuenta de servicio con permiso de responder.

## Cómo usarla

1. 1. Crea la cuenta de servicio en Google Cloud e invítala en Play Console
2. 2. Conecta la IA elegida y el bot de Telegram
3. 3. Aprueba las primeras respuestas a mano

## Cuándo usarla

Úsalo cuando responder reseñas te dé pereza pero sepas que contestar sube la nota media y recupera usuarios enfadados.

## Cómo ganar dinero con ella

Responder a las críticas malas sube la valoración y la conversión de la ficha. Te ahorra 10-15 minutos por reseña y lo hace en tono constante.

- Respuestas a reseñas de Android para desarrolladores que tienen volumen de críticas y poco tiempo.
- Gestión de reseñas de Google Play para agencias que cuidan la valoración de apps de clientes.
- Respuestas con visto bueno para apps que necesitan contestar a usuarios enfadados sin sonar a robot.

**Precio orientativo:** 100–250 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Descarga las reseñas nuevas de tu app en Google Play, se queda con las de 1 y 2 estrellas sin contestar, redacta un borrador con IA y te lo manda a Telegram con dos botones: publicar o descartar.
Para desarrolladores con app en Android y volumen de reseñas suficiente como para no querer escribir cada respuesta desde cero.

## Lo que necesitas antes
Acceso de administrador a Google Play Console.
Una cuenta de servicio: en Google Cloud Console crea un proyecto, activa «Google Play Android Developer API», crea una Service Account y descarga su JSON. Luego en Play Console > Usuarios y permisos, invita el correo de esa cuenta de servicio con permiso de «Responder a las reseñas».
En n8n, Credentials > Google Service Account API: pega el email y la clave privada del JSON, y en Scopes pon `https://www.googleapis.com/auth/androidpublisher`.
Una clave de la API de Anthropic (console.anthropic.com) para el nodo de IA, o usa el nodo de otro proveedor si ya tienes cuenta.
Bot de Telegram y tu chat_id.

## Los nodos, en orden
1. **Schedule Trigger**: Cron `0 10 * * *`.
2. **HTTP Request**: GET `https://androidpublisher.googleapis.com/androidpublisher/v3/applications/TU.PACKAGE.NAME/reviews?maxResults=50`, Authentication = Predefined Credential Type > Google Service Account.
3. **Code**: filtra estrellas <= 2 y sin respuesta del desarrollador. Código abajo.
4. **Split In Batches**: Batch Size = 1.
5. **Basic LLM Chain** (nodo de IA de n8n) conectado a un modelo de Anthropic. Prompt: «Eres el fundador de la app X. Escribe una respuesta pública de máximo 300 caracteres a esta reseña de {{ $json.estrellas }} estrellas: "{{ $json.texto }}". Tutea, pide perdón si toca, di qué vas a hacer y ofrece escribir a soporte@tudominio.com. Nada de excusas técnicas ni emojis.»
6. **Telegram** (Send Message): manda reseña + borrador y pide que respondan con `OK <id>`.
7. **Telegram Trigger** en un segundo workflow: escucha tu respuesta, y si empieza por OK, dispara el **HTTP Request** final.
8. **HTTP Request** final: POST `https://androidpublisher.googleapis.com/androidpublisher/v3/applications/TU.PACKAGE.NAME/reviews/{{ $json.review_id }}:reply` con body `{ "replyText": "{{ $json.respuesta }}" }`.

## El nodo Code
```javascript
const reviews = $input.first().json.reviews || [];
const salida = [];
for (const r of reviews) {
  const c = (r.comments || [])[0];
  const user = c && c.userComment;
  if (!user) { continue; }
  const tieneRespuesta = (r.comments || []).some(x => x.developerComment);
  if (tieneRespuesta) { continue; }
  if (Number(user.starRating) > 2) { continue; }
  salida.push({ json: {
    review_id: r.reviewId,
    estrellas: user.starRating,
    texto: (user.text || '').slice(0, 800),
    version: (user.appVersionName || 'desconocida'),
    dispositivo: user.device || ''
  }});
}
return salida;
```

## Cómo probarla
Primero ejecuta solo hasta el nodo 3 y mira cuántas reseñas salen. La API solo devuelve reseñas de los últimos 7 días con texto, así que si tu app es pequeña puede venir vacío: es normal.
Prueba la publicación con una reseña tuya de prueba desde otra cuenta de Google antes de dejarlo suelto.
Deja siempre la aprobación manual: publicar respuestas automáticas sin leer acaba mal el día que alguien escribe algo raro.

## Qué puede salir mal
Permisos: el error 401 casi siempre es que la cuenta de servicio no está invitada en Play Console o que falta el scope.
La API solo permite responder a reseñas de los últimos 7 días; las viejas hay que contestarlas a mano en la consola.
En iOS esta API no existe con equivalente sencillo; para App Store necesitas la API de App Store Connect con clave JWT, que es bastante más trabajo.
Límites: no abuses de las llamadas, con una vez al día vas sobrado.

## Cuánto cuesta
Play Developer API gratis. El modelo de IA cuesta céntimos: una respuesta de 300 caracteres son menos de 0,01 € con Claude Haiku. n8n auto-alojado gratis.
