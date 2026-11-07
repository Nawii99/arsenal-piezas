# Nota de versión automática cuando publicas una actualiz…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Cuando detecta una versión nueva de tu app en Google Play, redacta la novedad en lenguaje humano y la publica en tu newsletter, en redes y en el changelog de la web.

## Qué es y qué hace

Receta de n8n que vigila cada día la ficha pública de tu app en Google Play. Cuando cambia el número de versión, toma tus notas de la actualización, las reescribe en lenguaje de cliente con IA y las envía a tu lista de correo, deja un borrador de publicación en redes y añade una entrada al changelog de tu web. Entrada: el nombre del paquete de la app y tus notas. Salida: textos listos en tres canales.

## Cómo usarla

1. Pon el nombre del paquete de tu app
2. Conecta correo, redes y changelog
3. Revisa el primer texto generado antes de activar el envío

## Cuándo usarla

Úsalo cuando publicas actualizaciones cada pocas semanas y nadie se entera porque anunciarlas es un trabajo aburrido que siempre se queda para mañana.

## Cómo ganar dinero con ella

Sustituye una hora de redacción y publicación por versión. Y cada anuncio de mejora es una excusa gratis para que un usuario dormido reabra tu app.

- Anuncios de versión para una app de un comercio con lista de clientes…
- Changelog público automático para un producto digital pequeño…
- Comunicación de novedades para una app de reservas de un local…

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Consulta a diario la ficha pública de tu app en Google Play. Si el número de versión ha cambiado, coge las «Novedades» que escribiste tú (a veces en jerga) y las reescribe en lenguaje de cliente.
Con eso manda un email a tu lista, deja un post programado en redes y añade una entrada a un Google Doc que es tu changelog público.
Es para quien tiene app y una lista de usuarios y no quiere que cada release pase desapercibida.

## Lo que necesitas antes
n8n.
El package name de tu app (com.tuempresa.tuapp), que sale en la URL de Play.
Clave de OpenAI para la reescritura.
Cuenta de Brevo (antes Sendinblue) con lista de contactos. La API key se saca en Brevo, SMTP & API, Generate a new API key. El plan gratis da 300 emails al día.
Cuenta de Buffer con su Access Token (Buffer, Developers, Create an app) para programar el post. Alternativa: publicar directo con el nodo de LinkedIn o X.

## Los nodos, en orden
1. «Schedule Trigger». Cron: 0 10 * * * (cada día a las 10:00). Timezone del workflow: Europe/Madrid.
2. «HTTP Request». Method GET, URL https://play.google.com/store/apps/details?id=TU_PACKAGE&hl=es&gl=ES . Response Format: String. Options: activa «Ignore SSL Issues» solo si te da error.
3. «Code» (sacar versión y novedades del HTML). Código completo:
```js
const html = $input.first().json.data || '';
let version = '';
const mv = html.match(/\[\[\["(\d+\.\d+(?:\.\d+)?)"\]\]/);
if (mv) version = mv[1];
let novedades = '';
const mn = html.match(/<div[^>]*itemprop="description"[^>]*>([\s\S]{0,1200}?)<\/div>/);
if (mn) novedades = mn[1].replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim();
return [{ json: { version, novedades } }];
```
4. «Google Sheets» (Get Row(s)) de una hoja «versiones» donde guardas la última publicada.
5. «IF». Condición: {{ $json.version }} distinto de la última guardada, y version no vacía.
6. «OpenAI» (Message a model), modelo gpt-4o-mini. Prompt: «Reescribe estas novedades de app para usuarios normales, español de España, tuteando. Devuelve un JSON con tres campos: email_asunto, email_cuerpo (3 párrafos cortos en HTML simple), post_social (máximo 240 caracteres con 2 emojis). Novedades: {{ $json.novedades }}». Activa «Output Content as JSON».
7. «Brevo» (Send transactional email) o el nodo «Email» si prefieres SMTP propio. Asunto {{ $json.email_asunto }}, cuerpo {{ $json.email_cuerpo }}. Para enviar a toda la lista usa «Create an email campaign» de Brevo y luego «Send campaign».
8. «HTTP Request» a Buffer: POST https://api.bufferapp.com/1/updates/create.json con parámetros text igual a {{ $json.post_social }} y profile_ids[] tu perfil. El access_token de Buffer no lo escribas en el nodo: usa Authentication: Generic Credential Type > Query Auth con una credencial de n8n (Name `access_token`, Value tu token), porque un flujo exportado se llevaría la clave.
9. «Google Docs» (Update a document, operación Insert) añadiendo al changelog: «v{{ $json.version }} — {{ $fecha }} — {{ $json.post_social }}».
10. «Google Sheets» (Append or Update) guardando la versión nueva.

## Cómo probarla
Desconecta los nodos de envío (Brevo y Buffer) y ejecuta a mano. Mira la salida del nodo Code: si «version» sale vacío, Google ha cambiado el HTML, ajusta la expresión regular o usa el campo de la ficha que sí encuentres.
Cambia a mano la versión guardada en la hoja por una antigua para forzar que dispare y ver el email de prueba en tu propio correo.

## Qué puede salir mal
Google cambia el HTML de la ficha cada pocos meses y el Code deja de encontrar la versión. Solución sencilla: pon un aviso a Telegram si version viene vacía, así te enteras.
Puede que Google te devuelva la página en otro idioma o te pida captcha si haces muchas peticiones. Una vez al día no da problemas.
Si el flujo se ejecuta dos veces el mismo día podría duplicar el email. Guarda la versión en la hoja antes de enviar, no después, si prefieres pecar de prudente.

## Cuánto cuesta
n8n autoalojado (Community Edition), Google Docs y Sheets: gratis; n8n Cloud tiene una prueba gratuita temporal y después planes de pago. Brevo: 300 emails al día gratis. Buffer: plan gratuito con 3 canales.
OpenAI: céntimos, se ejecuta solo cuando hay versión nueva.
