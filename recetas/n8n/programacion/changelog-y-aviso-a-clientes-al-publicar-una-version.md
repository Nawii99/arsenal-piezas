# Changelog y aviso a clientes al publicar una versión…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Al crear una release en GitHub, agrupa los commits en un changelog legible para clientes, lo publica en Notion y lo envía por email a la lista de avisos.

## Qué es y qué hace

Al crear una release en GitHub, recoge los commits desde la versión anterior, los agrupa en Nuevo, Mejorado y Arreglado con un lenguaje entendible para el cliente, crea una página en Notion y envía el aviso por correo a tu lista de usuarios. Se monta con n8n, Make o Zapier y necesita una clave de API de un modelo de IA como Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Crea el webhook de releases en GitHub
2. Conecta Notion y el correo
3. Añade la clave de tu modelo de IA
4. Publica una release de prueba y revisa el texto

## Cuándo usarla

Úsalo cuando entregues versiones de un producto o SaaS y escribir las notas de la versión para clientes te dé pereza y acabes sin mandarlas.

## Cómo ganar dinero con ella

Ahorra 1-2 horas por release escribiendo notas y evita el «no sabía que ya estaba hecho» del cliente. Gratis salvo unos céntimos de IA.

- Notas de versión para clientes como servicio por release de un SaaS…
- Comunicación de producto para apps con usuarios beta…
- Changelog público para productos digitales de pequeños estudios…

**Precio orientativo:** 60–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Cuando publicas una release en GitHub, recoge todos los commits desde la versión anterior, los traduce de jerga técnica a beneficios entendibles agrupados en «Nuevo», «Mejorado» y «Arreglado», crea una página en Notion y manda un email a tus clientes o usuarios beta.
Para quien vende un producto digital o SaaS propio y quiere comunicar avances sin dedicarle media mañana.
## Lo que necesitas antes
- Repositorio en GitHub y token con permiso de lectura de `Contents` y `Metadata`.
- Clave de API de OpenAI (platform.openai.com) o de Anthropic. Con unos céntimos por release sobra.
- Integración de Notion: notion.so/my-integrations > New integration > copia el token. Comparte tu base de datos «Changelog» con la integración desde el botón «...» > Connections.
- Gmail conectado en n8n, y la lista de emails en una hoja de Google Sheets o en tu propio Notion.
## Los nodos, en orden
1) **Webhook**: POST, path `nueva-release`. En GitHub: Settings > Webhooks > Add webhook, Content type `application/json`, evento «Releases» solamente. Protégelo: configura un *Secret* en el webhook de GitHub, valida la cabecera `X-Hub-Signature-256` en un nodo Code con ese secreto leído de una variable de entorno y descarta entregas repetidas por `X-GitHub-Delivery`.
2) **IF**: String, valor 1 `{{ $json.body.action }}`, «is equal to», valor 2 `published`.
3) **HTTP Request**: GET `https://api.github.com/repos/{{ $json.body.repository.full_name }}/compare/{{ $json.body.release.target_commitish }}...{{ $json.body.release.tag_name }}` con Header Auth `Authorization: Bearer TU_TOKEN`. Si prefieres algo más simple, usa `/commits?since=` con la fecha de la release anterior.
4) **Code**: limpia los mensajes de commit y descarta ruido.
```javascript
const commits = ($json.commits || []).map(c => c.commit.message.split('\n')[0]);
const utiles = commits.filter(m => !/^(Merge|chore|ci|style|bump|wip)/i.test(m));
return [{ json: { lista: utiles.join('\n- '), total: utiles.length, version: $('Webhook').first().json.body.release.tag_name } }];
```
5) **HTTP Request** (IA): POST `https://api.openai.com/v1/chat/completions`, Header Auth con tu clave. Body:
```json
{ "model": "gpt-4o-mini", "messages": [{"role": "user", "content": "Eres responsable de producto. Convierte estos mensajes de commit en notas de versión en español de España para clientes NO técnicos. Tres apartados con viñetas: Nuevo, Mejorado, Arreglado. Nada de nombres de archivo ni de funciones. Máximo 12 viñetas. Commits:\n- {{ $json.lista }}"}] }
```
6) **Notion**: Resource `Database Page`, Operation `Create`, tu base de datos «Changelog», propiedades: Título `Versión {{ $('Code').item.json.version }}`, Fecha hoy, y en el contenido el texto de la IA.
7) **Google Sheets**: Operation `Get Row(s)` de la hoja `avisos` con la columna `email` de quienes quieren enterarse.
8) **Split In Batches**: Batch Size 30, para no disparar el antispam de Gmail.
9) **Gmail**: Operation `Send`, To en BCC si mandas a varios, Subject `Novedades de la versión {{ $('Code').first().json.version }}`, Message con el texto generado más un enlace a la página de Notion.
10) **Wait**: 60 segundos entre lotes, conectado de vuelta al Split In Batches.
## Cómo probarla
- Crea una release de prueba en un repo secundario marcada como «pre-release» y comprueba que el IF la deja pasar solo si tú quieres.
- Revisa el texto que devuelve la IA ANTES de enchufar el envío de emails: desconecta el nodo Gmail las dos primeras veces.
- Manda el primer email solo a ti mismo poniendo una hoja con un único correo.
## Qué puede salir mal
- **La IA se inventa funcionalidades**: baja la temperatura a 0.2 en el body (`"temperature": 0.2`) y añade «Si un commit no es claro, ignóralo» al prompt.
- **Commits sin sentido tipo «fix»**: mejora tus mensajes o filtra más en el Code. Basura entra, basura sale.
- **Gmail bloquea el envío masivo**: 500 destinatarios/día en cuenta personal. Por encima de 200 suscriptores usa Brevo (300 emails/día gratis) con un HTTP Request a su API.
- **Notion falla por propiedades**: los nombres de las propiedades del nodo deben coincidir exactamente con los de tu base de datos, mayúsculas incluidas.
## Cuánto cuesta
- GitHub, Notion (plan personal) y n8n auto-alojado: gratis.
- OpenAI gpt-4o-mini: menos de 0,01 € por release.
- Brevo si creces: gratis hasta 300 emails/día, luego desde 9 €/mes.
