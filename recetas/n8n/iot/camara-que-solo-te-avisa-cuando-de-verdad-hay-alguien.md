# Cámara que solo te avisa cuando de verdad hay alguien…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

La cámara manda la foto del movimiento a n8n, una IA mira si hay una persona y solo entonces te llega el aviso al móvil con la imagen.

## Qué es y qué hace

Flujo de n8n que recibe la foto que una cámara envía al detectar movimiento y, fuera del horario, la pasa a un modelo de visión que dice si hay una persona o un vehículo parado. Solo en ese caso te manda la imagen y la descripción a Telegram; si es un gato o una hoja, descarta el aviso. Entra la foto por HTTP y la clave del modelo; sale el aviso filtrado.

## Cómo usarla

1. Configura la cámara para enviar la foto por HTTP
2. Elige el modelo de visión entre Claude, Codex, Gemini o una IA local
3. Define el horario de aviso
4. Que lo revise un profesional (imágenes de personas y privacidad)

## Cuándo usarla

Úsalo cuando ya tengas una cámara que te bombardea de avisos por gatos, ramas o coches y hayas terminado ignorándolos todos.

## Cómo ganar dinero con ella

Recupera el valor de la cámara que ya tienes: pasas de 60 avisos inútiles al día a 1 o 2 de verdad, por céntimos de análisis.

- Filtro de avisos de cámara para naves, almacenes y obras que reciben decenas de falsas alarmas.
- Instalación de vigilancia inteligente para fincas y tiendas cerradas por la noche.
- Mantenimiento mensual de cámaras con revisión de avisos y ajuste de zonas de detección.

**Precio orientativo:** 250–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cuando la cámara detecta movimiento, envía la foto a un webhook de n8n. Fuera del horario de apertura, n8n manda esa imagen a un modelo de visión preguntándole qué ve. Si responde que hay una persona o un vehículo parado, te llega a Telegram la foto con la descripción. Si es un gato o una hoja, se descarta en silencio.
Para naves, almacenes, obras, fincas y tiendas cerradas por la noche.
## Lo que necesitas antes
- Una cámara que sepa hacer «FTP o HTTP push» de la foto al detectar movimiento, o un servidor **Frigate** / **Blue Iris** que lo haga. Muchas Reolink, Dahua y Hikvision permiten enviar por HTTP POST; si la tuya no, usa Frigate en una Raspberry con la cámara RTSP.
- n8n con https accesible.
- Una clave de la API de Anthropic: entra en la consola de Anthropic, crea una API key y copia también el identificador del modelo Haiku más reciente que te muestre la consola (es el más barato para esto). Carga 5 € de saldo para empezar.
- Bot de Telegram con token y chat_id.
## Los nodos, en orden
1. **Webhook** — Method POST, Path `camara`, Binary Property activado en Options si la cámara manda la imagen como archivo (`Field Name for Binary Data`: `data`). Authentication: Header Auth, para que no te lo llame cualquiera.
2. **IF** «¿Fuera de horario?» — condición String: `{{ $now.setZone('Europe/Madrid').hour >= 21 || $now.setZone('Europe/Madrid').hour < 7 ? 'si' : 'no' }}` **is equal to** `si`. Si tu negocio es 24 h, quita este nodo.
3. Rama true > **Extract from File** — Operation: Move File to Base64 String, Input Binary Field `data`, Destination Key `b64`. (Si tu cámara ya manda base64 en el JSON, sáltate este nodo.)
4. **HTTP Request** «Preguntar a la IA» — POST `https://api.anthropic.com/v1/messages`. Headers: `x-api-key` desde una credencial de n8n (Generic Credential Type > Header Auth, Name `x-api-key`, Value tu clave; no la escribas en el nodo: un flujo exportado se la llevaría), `anthropic-version` con valor `2023-06-01`, `content-type` `application/json`. Body JSON:
```json
{ "model": "EL_ID_DE_HAIKU_QUE_TE_DA_LA_CONSOLA", "max_tokens": 200, "messages": [ { "role": "user", "content": [ { "type": "image", "source": { "type": "base64", "media_type": "image/jpeg", "data": "={{ $json.b64 }}" } }, { "type": "text", "text": "Eres una alarma. Mira la foto y responde SOLO con un JSON: {\"persona\":true/false,\"vehiculo\":true/false,\"animal\":true/false,\"descripcion\":\"una frase corta en español\"}. No añadas nada más." } ] } ] }
```
5. **Code** «Leer respuesta» — Run Once for Each Item:
```js
const txt = $json.content && $json.content[0] ? $json.content[0].text : '{}';
let r = {};
try { r = JSON.parse(txt.replace(/```json|```/g, '').trim()); } catch (e) { r = { persona: true, descripcion: 'No he podido interpretar la respuesta, aviso por si acaso' }; }
const avisar = r.persona === true || r.vehiculo === true;
return { json: { avisar, descripcion: r.descripcion || '', persona: !!r.persona, animal: !!r.animal } };
```
6. **IF** — `{{ $json.avisar }}` is true.
7. Rama true > **Telegram** — Operation: Send Photo, Binary File activado con el campo `data` que viene del Webhook (usa `{{ $('Webhook').item.binary.data }}` si te hace falta referenciarlo), Caption: `🚨 {{ $json.descripcion }}`.
## Cómo probarla
Ponte delante de la cámara y provoca una detección: debe llegarte la foto con una descripción tipo «una persona con chaqueta oscura junto a la puerta». Después tira algo pequeño o deja pasar al perro: no debe llegar nada, pero mira en el historial de ejecuciones de n8n que la IA respondió `animal: true`. Ajusta el prompt si te da falsos negativos: es preferible que se pase de avisar a que se calle cuando no debe.
## Qué puede salir mal
- **Coste disparado**: si la cámara detecta 500 movimientos por noche, son 500 análisis. Pon primero la detección de la propia cámara lo más restrictiva posible (zonas, sensibilidad) y añade un **Code** antirrepetición que ignore fotos a menos de 60 segundos de la anterior.
- **La imagen llega demasiado grande**: reduce la resolución de la subcorriente de la cámara a 640x480. Vas a gastar menos y la IA sigue viendo perfectamente si hay alguien.
- **La IA devuelve texto en vez de JSON**: el `try/catch` ya te cubre avisando por si acaso. No lo quites.
- **Tu cámara no sabe hacer POST**: usa Frigate (gratis) en una Raspberry Pi 4; tiene webhooks y hasta detección propia de personas, que te ahorraría la mitad de las llamadas a la IA.
- **Falsos negativos de noche**: si la cámara es infrarroja mala, la IA verá manchas. Añade un foco o baja el listón del prompt a «alguna forma humana».
- **Privacidad**: no enfoques a la vía pública ni a viviendas ajenas y pon el cartel de zona videovigilada. Es obligatorio.
## Cuánto cuesta
La cámara ya la tienes. Telegram gratis. La API de Anthropic con el modelo pequeño cuesta céntimos por imagen a baja resolución: con detecciones bien filtradas, unos pocos euros al mes. Frigate y n8n autoalojado, solo el coste del cacharro (una Raspberry Pi de 60-80 € o un VPS de 5 €/mes).
