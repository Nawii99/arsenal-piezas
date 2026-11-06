# Publicación programada en Instagram con pie escrito por…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Coges una foto de una carpeta, la IA escribe el pie y los hashtags según tu estilo y se publica sola a la hora buena. Para fotógrafos y marcas que quieren presencia en Instagram.

## Qué es y qué hace

Cada día toma la siguiente foto de una cola en Drive, genera con una IA de texto un pie en tu tono y 12 hashtags, y la publica en una cuenta profesional de Instagram mediante la Instagram Graph API. Requiere una cuenta profesional vinculada a una Página de Facebook y un token de la app. El texto lo puede escribir Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Crea la app en developers.facebook.com con Instagram Graph API
2. Genera el token de la cuenta profesional
3. Prepara la cola de fotos en Drive
4. Revisa las primeras publicaciones

## Cuándo usarla

Cuando tienes fotos de sobra pero se te olvida publicar, o tardas media hora en decidir qué escribir en cada post.

## Cómo ganar dinero con ella

Sustituye a un community manager de 200-400 €/mes y te devuelve 3-5 horas semanales.

- Montaje de publicación programada para restaurantes o tiendas que tienen material pero no tiempo.
- Gestión mensual de la cuenta: cola de fotos, pies y calendario para un fotógrafo o un estudio.
- Plantilla de programación de Instagram vendida a marcas pequeñas que quieren constancia sin contratar un community manager.

**Precio orientativo:** 200–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Cada día a una hora fija toma la siguiente foto de una cola en Drive, genera con IA un pie en tu tono y 12 hashtags, y la publica en tu cuenta profesional de Instagram usando la API oficial.
Para fotógrafos, restaurantes, tiendas y estudios que ya tienen material y solo necesitan constancia.

## Lo que necesitas antes
- Cuenta de Instagram **Profesional** vinculada a una **Página de Facebook** (obligatorio, con cuenta personal no hay API).
- App en developers.facebook.com: añade el producto Instagram Graph API, genera un token de larga duración y apunta tu Instagram Business Account ID (lo sacas con /me/accounts y luego ?fields=instagram_business_account).
- Credencial OpenAI: platform.openai.com > API keys. Con 5 € de saldo te sobra para meses.
- Carpeta COLA_INSTAGRAM en Drive y una hoja Publicado con columnas: Archivo, Fecha, Pie, PostID.
- Importante: la API de Instagram necesita una **URL pública** de la imagen. Usa el enlace directo de Drive o, mejor, sube la foto a un bucket público o a tu propio hosting.

## Los nodos, en orden
1) **Schedule Trigger**. Days, cada 1 día, Hour: 19, Minute: 30 (buena hora en España). Timezone del workflow: Europe/Madrid.
2) **Google Drive** (Search). Query String: `'ID_COLA' in parents and trashed = false`. Options > Order By: `createdTime`. Limit: 1.
3) **IF**. Si no hay resultados (`{{ $json.id }}` vacío), rama false a un **Gmail** que te avise de que se ha acabado la cola.
4) **Google Drive1** (Share). Operation: Share. Type: anyone, Role: reader. Así la foto tiene URL pública temporal.
5) **Set**. Campo urlPublica: `https://drive.google.com/uc?export=download&id={{ $('Google Drive').item.json.id }}`.
6) **OpenAI** (Message a Model). Model: gpt-4o-mini. Operation: Message a Model. En el mensaje de sistema: «Eres el community manager de un estudio de fotografía en España. Escribes en español de España, tuteando, cercano, sin emojis en exceso.» En el de usuario: «Escribe un pie de Instagram de máximo 3 frases para una foto titulada {{ $('Google Drive').item.json.name }}. Añade después 12 hashtags relevantes de fotografía en España, en una sola línea. No uses comillas.»
7) **HTTP Request** (Crear contenedor). Method: POST. URL: `https://graph.facebook.com/v21.0/TU_IG_ID/media`. Send Body: activado, Body Content Type: Form-Urlencoded. Parámetros: image_url = `{{ $('Set').item.json.urlPublica }}`, caption = `{{ $('OpenAI').item.json.message.content }}`, access_token = tu token.
8) **Wait**. Amount: 30 seconds. Instagram necesita ese tiempo para descargar la imagen.
9) **HTTP Request1** (Publicar). Method: POST. URL: `https://graph.facebook.com/v21.0/TU_IG_ID/media_publish`. Body: creation_id = `{{ $('HTTP Request').item.json.id }}`, access_token = tu token.
10) **Google Sheets** (Append Row) con Archivo, Fecha, Pie y PostID `{{ $json.id }}`.
11) **Google Drive2** (Move). Mueve la foto a la carpeta YA_PUBLICADO para que no se repita.

## Cómo probarla
Deja una sola foto en la cola y cambia el Schedule Trigger a Every Minute mientras pruebas. Revisa el pie generado antes de dejarlo suelto: si no te suena a ti, ajusta el mensaje de sistema con dos ejemplos de pies tuyos reales.

## Qué puede salir mal
- **Error "The image is not accessible"**: la URL de Drive no siempre sirve para Instagram. Solución fiable: sube la foto a Cloudinary (plan gratuito) con un nodo HTTP Request y usa su URL.
- **El token caduca**: el de larga duración dura 60 días. Monta un segundo flujo mensual que llame a `https://graph.facebook.com/v21.0/oauth/access_token?grant_type=fb_exchange_token...` y guarde el nuevo.
- **Formato de imagen**: Instagram rechaza proporciones fuera de 4:5 a 1.91:1. Añade antes un **Edit Image** con Resize a 1080x1350, opción Fill.
- **Hashtags repetidos**: Instagram penaliza copiar el mismo bloque siempre. Pide en el prompt que varíe al menos la mitad.

## Cuánto cuesta
La API de Instagram es gratis. OpenAI gpt-4o-mini cuesta menos de 0,01 € por pie: publicando a diario, unos 0,30 €/mes. n8n autoalojado 0 €. Cloudinary tiene plan gratuito de 25 créditos al mes, suficiente.
