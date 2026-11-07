# Texto alternativo y palabras clave automáticos para tus…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Mira cada foto nueva de tu web o tienda con una IA de visión y le escribe el texto alternativo, un título y las palabras clave, y lo guarda en el archivo y en la web.

## Qué es y qué hace

Cada vez que subes una imagen nueva, una IA de visión genera un texto alternativo de menos de 125 caracteres, un título comercial y 8 palabras clave. Lo escribe en los metadatos del archivo y en la biblioteca de medios de WordPress. Entra la imagen y sale el alt, con n8n y una API de visión; el coste depende del modelo que elijas.

## Cómo usarla

1. Elige el modelo (Claude, Codex, Gemini o una IA local)
2. Conecta WordPress con contraseña de aplicación
3. Prueba con 10 imágenes
4. Revisa el primer lote

## Cuándo usarla

Cuando subes muchas fotos a WordPress o a tu tienda y las dejas sin alt ni descripción, perdiendo tráfico de Google Imágenes y accesibilidad.

## Cómo ganar dinero con ella

Ahorra unos 2 minutos por imagen (con 200 fotos son 7 horas) y mejora la posición en Google Imágenes, que en tiendas puede ser el 10-20 % del tráfico.

- Puesta en marcha del alt automático para tiendas WordPress con cientos de fotos sin descripción.
- Mantenimiento mensual de textos alternativos para un blog con publicaciones frecuentes.
- Auditoría y relleno de alt para la web de un negocio local que quiere aparecer en Google Imágenes.

**Precio orientativo:** 120–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Para tiendas online, blogs y fotógrafos con portfolio: cada vez que sube una imagen nueva, se la enseña a Gemini, obtiene un alt descriptivo de menos de 125 caracteres, un título comercial y 8 palabras clave, y lo escribe tanto en los metadatos IPTC del archivo como en la biblioteca de medios de WordPress.

## Lo que necesitas antes
- n8n (auto-alojado si quieres también sellar IPTC; en Cloud funciona todo menos ese paso).
- API Key de Google AI Studio (aistudio.google.com > Get API key). El nivel gratuito de Gemini Flash da un límite generoso de peticiones al día.
- WordPress con usuario administrador y una **Application Password** (Usuarios > Perfil > Contraseñas de aplicación). En n8n: Credentials > WordPress con la URL del sitio, el usuario y esa contraseña.
- Opcional: Google Drive OAuth2 si trabajas desde carpeta en vez de desde WordPress.

## Los nodos, en orden
1. **Schedule Trigger** — cada 2 horas.
2. **HTTP Request «Medios sin alt»** — Method: GET, URL: `https://tuweb.com/wp-json/wp/v2/media`, Authentication: Predefined Credential Type > WordPress. Query Parameters: `per_page` = `50`, `orderby` = `date`, `order` = `desc`, `media_type` = `image`.
3. **Filter** — Conditions: String, `{{ $json.alt_text }}` Is Empty.
4. **Loop Over Items** — Batch Size: 1.
5. **HTTP Request «Descargar imagen»** — GET a `={{ $json.source_url }}`, Response Format: File, campo `data`.
6. **Extract From File** — Operation: Move File to Base64 String, Input Binary Field: `data`, Destination Output Field: `b64`. (Gemini necesita la imagen en base64.)
7. **HTTP Request «Gemini describe»** — Method: POST, URL: `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent`. Headers: `x-goog-api-key` desde una credencial de n8n (Generic Credential Type > Header Auth, Name `x-goog-api-key`, Value tu clave; no la escribas en el nodo: un flujo exportado se la llevaría). Body Content Type: JSON, Specify Body: Using JSON, con el cuerpo de abajo.
8. **Code «Leer respuesta»** — extrae el JSON que devuelve Gemini (código abajo).
9. **HTTP Request «Actualizar WordPress»** — Method: POST, URL `=https://tuweb.com/wp-json/wp/v2/media/{{ $('Loop Over Items').item.json.id }}`, Authentication WordPress, Body JSON: `{ "alt_text": "{{ $json.alt }}", "title": "{{ $json.titulo }}", "caption": "{{ $json.pie }}" }`.
10. Opcional en auto-alojado: **Code «Limpiar para IPTC»** (modo «Run Once for Each Item») — el alt y las palabras clave los escribe la IA mirando una imagen de fuera, así que antes de la terminal solo se dejan letras, números, espacios, comas, puntos y guiones, y el ID de WordPress tiene que ser un número; si no, el flujo para: `const id = String($('Loop Over Items').item.json.id); if (!/^\d+$/.test(id)) throw new Error('ID de medio no válido: ' + id); const limpio = t => String(t || '').replace(/[^\p{L}\p{N} ,.-]/gu, '').slice(0, 200); return { json: { id, alt_iptc: limpio($('Leer respuesta').item.json.alt), keywords_iptc: limpio($('Leer respuesta').item.json.keywords) } };`. Después, un **HTTP Request** que vuelva a descargar `{{ $('Loop Over Items').item.json.source_url }}` como archivo, un **Read/Write Files from Disk** que lo escriba en `/tmp/medios/{{ $('Limpiar para IPTC').item.json.id }}.jpg` (crea antes la carpeta con `mkdir -p /tmp/medios`; solo para JPEG) y un **Execute Command** con `exiftool -overwrite_original -IPTC:Caption-Abstract="{{ $('Limpiar para IPTC').item.json.alt_iptc }}" -sep ", " -IPTC:Keywords="{{ $('Limpiar para IPTC').item.json.keywords_iptc }}" "/tmp/medios/{{ $('Limpiar para IPTC').item.json.id }}.jpg"`.
11. **Google Sheets** — Append con id, alt, titulo, keywords (tómalos de `$('Loop Over Items')` y `$('Leer respuesta')`: tras los nodos anteriores, `$json` ya no los trae), para tener registro de lo generado.

## El cuerpo JSON del nodo Gemini
```json
{
  "contents": [{ "parts": [
    { "text": "Eres experto en SEO de imágenes en español de España. Describe la foto y devuelve SOLO un JSON con las claves: alt (descripción objetiva de máximo 120 caracteres, sin la palabra imagen ni foto), titulo (máximo 60 caracteres, atractivo y comercial), pie (una frase de máximo 140 caracteres), keywords (array de 8 palabras clave en minúsculas). Nada de texto fuera del JSON." },
    { "inline_data": { "mime_type": "image/jpeg", "data": "{{ $json.b64 }}" } }
  ] }],
  "generationConfig": { "temperature": 0.3, "responseMimeType": "application/json" }
}
```

## El trozo de código (nodo Code «Leer respuesta»)
```javascript
return $input.all().map(item => {
  const texto = item.json?.candidates?.[0]?.content?.parts?.[0]?.text || '{}';
  let d = {};
  try { d = JSON.parse(texto); } catch (e) { d = { alt: '', titulo: '', pie: '', keywords: [] }; }
  return { json: {
    alt: (d.alt || '').slice(0, 125),
    titulo: (d.titulo || '').slice(0, 60),
    pie: d.pie || '',
    keywords: Array.isArray(d.keywords) ? d.keywords.join(', ') : ''
  }};
});
```

## Cómo probarla
- Sube a WordPress una foto sin alt y ejecuta el flujo a mano.
- Mira la salida del nodo Gemini: si el texto viene con ```json alrededor, es que se te olvidó el `responseMimeType: application/json`.
- Entra en la biblioteca de medios y comprueba que el alt y el título están escritos. Corrige el tono en el prompt (por ejemplo, «tono cercano, tuteando») hasta que te guste.

## Qué puede salir mal
- **Alt demasiado largo o poético**: acorta el límite en el prompt y recorta también en el código, como hace el `.slice(0, 125)`.
- **Fotos de personas**: pide en el prompt que no describa etnia, edad ni estado de ánimo si no quieres problemas de sesgo; describe la escena y el producto.
- **Límite de peticiones de Gemini**: si te devuelve error 429, añade en el nodo HTTP Settings > Batching una petición cada 4000 ms y Retry On Fail.
- **Imágenes muy grandes**: por encima de unos 15-20 MB en base64 fallará. Descarga la versión `medium_large` de WordPress en vez del original (`{{ $json.media_details.sizes.large.source_url }}`).
- **Texto de la IA en la terminal**: una imagen puede llevar escrito algo que la IA copie al alt, como `$(id)` o comillas; si llegara a exiftool se ejecutaría. Por eso «Limpiar para IPTC» deja solo letras, números y puntuación básica, y la copia local se llama por el ID numérico de WordPress.
- **Textos duplicados**: si todas las fotos son del mismo producto, añade al prompt el nombre del producto desde WordPress para que varíe el enfoque.

## Cuánto cuesta
n8n y WordPress: 0 €. Gemini Flash: nivel gratuito con límite diario suficiente para cientos de imágenes; si lo superas, el pago por uso ronda céntimos por cada mil imágenes. Alternativa de pago similar: GPT-4o mini, también céntimos.
