# Vigilante de reseñas con borrador de respuesta prudente…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Revisa cada día las reseñas nuevas de tu ficha de Google, avisa al instante de las de 1 y 2 estrellas y te deja preparado un borrador de respuesta que nunca revela datos del paciente.

## Qué es y qué hace

Revisa cada día las reseñas nuevas de tu ficha de Google, las clasifica por estrellas y avisa al instante de las de 1 a 3. Para cada una prepara un borrador de respuesta con reglas fijas: agradecer, no confirmar que la persona es paciente y no hablar de su caso. Entrada: reseñas de Google Business Profile; salida: avisos y borradores. Se monta en n8n con la API de Google Business Profile y Telegram.

## Cómo usarla

1. Solicitar acceso a la API de reseñas de Google
2. Fijar las reglas de la respuesta
3. Probar con reseñas antiguas
4. Que lo revise un profesional

## Cuándo usarla

Cuando una reseña mala se queda semanas sin respuesta porque nadie mira la ficha, y cuando respondes con prisa se te escapa información que no debería estar ahí.

## Cómo ganar dinero con ella

Responder a todas las reseñas mejora la posición en Maps y la conversión de la ficha; media estrella más puede significar un 5-9% más de llamadas.

- Gestionar reseñas para clínicas que quieren responder rápido sin revelar datos.
- Ofrecer el vigilante de reseñas a centros de estética con varias sedes.
- Montar un informe mensual de reseñas y respuestas para el gerente.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Consulta las reseñas de tu Perfil de Empresa en Google, detecta las que no estaban en tu registro y las clasifica por estrellas.
Las de 4 y 5 van a un Sheet para responder en tanda; las de 1 a 3 disparan un aviso inmediato a Telegram con un borrador de respuesta redactado con reglas fijas: agradecer, no confirmar nunca que la persona ha sido paciente, no hablar de su caso y llevar la conversación a un canal privado.
Para cualquier clínica o centro de bienestar con ficha en Google Maps.

## Lo que necesitas antes
Perfil de Empresa en Google verificado y con acceso de propietario.
Acceso a la Google Business Profile API: en console.cloud.google.com activas `My Business Account Management API` y `My Business Business Information API`, y solicitas el acceso a la API de reseñas rellenando el formulario de Google (tarda unos días). Alternativa sin espera: un servicio como SerpApi o Apify, con clave desde su panel.
Credencial `Google OAuth2 API` genérica en n8n con el scope `https://www.googleapis.com/auth/business.manage`, o simplemente tu clave de SerpApi si vas por esa vía.
Bot de Telegram con token de @BotFather y tu `chat_id`.
Google Sheet `Resenas` con `review_id`, `fecha`, `estrellas`, `autor`, `texto`, `respondida`.

## Los nodos, en orden
1. **Schedule Trigger** — `0 8,15 * * *`, dos pasadas al día.
2. **HTTP Request** — Method `GET`, URL `https://mybusiness.googleapis.com/v4/accounts/{ACCOUNT_ID}/locations/{LOCATION_ID}/reviews`, Authentication `Predefined Credential Type` y elige tu credencial de Google; o con SerpApi, URL `https://serpapi.com/search.json` con parámetros `engine=google_maps_reviews`, `data_id`, `api_key`.
3. **Item Lists** (o **Split Out**) — campo `reviews` para separar cada reseña en un item.
4. **Google Sheets** — `Get Row(s)` de `Resenas`.
5. **Code** — descarta las que ya tengan `review_id` guardado y traduce el rating textual (`FIVE`, `FOUR`) a número.
6. **Google Sheets** — `Append Row` con la reseña nueva.
7. **IF** — `{{$json.estrellas}}` menor o igual que `3`.
8. Rama true → **Code** que arma el borrador (código abajo) → **Telegram** `Send Message` con el texto y el enlace directo a la reseña.
9. Rama false → **Gmail** un resumen diario a las 15:00 con las reseñas positivas pendientes de responder.

## El nodo Code del borrador
```js
return $input.all().map(item => {
  const r = item.json;
  const nombre = (r.autor || '').split(' ')[0] || 'Hola';
  let borrador;
  if (r.estrellas <= 2) {
    borrador = `${nombre}, gracias por tomarte el tiempo de escribirnos. Sentimos que tu experiencia no haya sido buena. Por confidencialidad no comentamos casos concretos por aquí, pero queremos escucharte: escríbenos a INFO@TUCLINICA.ES o llámanos al 9XX XXX XXX y lo revisamos personalmente.`;
  } else {
    borrador = `${nombre}, gracias por tu valoración y por contarnos lo que podemos mejorar. Nos lo llevamos apuntado. Si quieres darnos más detalle, escríbenos a INFO@TUCLINICA.ES y lo vemos con calma.`;
  }
  const alerta = `RESEÑA ${r.estrellas}★ de ${r.autor}\n\n"${(r.texto || '').slice(0, 400)}"\n\nBORRADOR:\n${borrador}`;
  return { json: { ...r, borrador, alerta } };
});
```

## Cómo probarla
Pide a un conocido que deje una reseña de prueba (y la borre después) o ejecuta el HTTP Request a mano y mira que llegan las reseñas antiguas sin duplicar en el Sheet.
Comprueba que un texto largo se corta a 400 caracteres y no revienta el mensaje de Telegram.

## Qué puede salir mal
La API oficial de reseñas de Google requiere aprobación; si tienes prisa empieza con SerpApi y migra luego.
La respuesta hay que publicarla a mano desde el perfil salvo que tengas la API de escritura aprobada; el borrador te ahorra el 90% del tiempo igual.
Nunca confirmes en público que alguien ha sido paciente ni des detalles clínicos: además de ser mala praxis, es una infracción de protección de datos.
Duplicados: el `review_id` es la clave, no uses la fecha ni el nombre.

## Cuánto cuesta
n8n auto-alojado 0 €, API oficial de Google gratis.
SerpApi: plan gratuito de 100 búsquedas al mes, suficiente para dos consultas diarias; el plan de pago arranca sobre 50 $/mes.
Telegram y Sheets: gratis.
