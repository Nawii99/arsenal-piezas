# Catálogo de tu fototeca con IA (palabras clave y alt)

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

La IA mira cada foto nueva, la describe, saca palabras clave y color dominante, y lo apunta todo en una hoja de cálculo buscable.

## Qué es y qué hace

Cada foto que llega a una carpeta de Drive se envía a un modelo de visión, que devuelve un título, una descripción, diez palabras clave, el color dominante y si es apta para uso comercial. El resultado va a una fila de Google Sheets con el enlace a la foto. Entran imágenes y salen fichas buscables, con n8n y una API de IA como Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Crea la hoja Fototeca con sus columnas
2. Consigue la clave de la IA con visión
3. Monta el flujo en n8n con la carpeta de entrada
4. Revisa veinte fichas antes de usarlo a gran escala

## Cuándo usarla

Úsalo cuando tienes miles de fotos con nombres tipo IMG_4821.jpg y no encuentras nada, o cuando necesitas texto alternativo y descripciones para vender o publicar.

## Cómo ganar dinero con ella

Etiquetar una foto a mano lleva 1-2 minutos. Con 500 fotos son 12 horas. Aquí cuesta unos 0,003 € por foto y cero tiempo tuyo.

- Catalogación de fototecas para fotógrafos con archivos grandes, cobrada por cada 500 fotos.
- Textos alternativos y descripciones para tiendas online, entregados en lote.
- Plantilla de catálogo visual vendida a agencias que necesitan buscar en su banco de imágenes.

**Precio orientativo:** 150–350 € por lote de 500 fotos. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada foto que llega a una carpeta de Drive se envía a un modelo de visión que devuelve un título corto, una descripción vendedora, diez palabras clave, el color dominante y si es apta para uso comercial. Todo eso se escribe en una fila de Google Sheets con el enlace a la foto.
Para el fotógrafo con archivo grande, la tienda online que necesita alt text, y el creador de contenido que quiere buscar en su propio banco de imágenes escribiendo «mesa de madera luz cálida».

## Lo que necesitas antes
- n8n (auto-alojado o plan gratuito) y cuenta de Google.
- Clave de API de Anthropic: console.anthropic.com > Settings > API Keys > Create Key. Carga 5 € de saldo, dan para miles de fotos. Vale igual con OpenAI cambiando la URL y el cuerpo.
- Una carpeta de Drive `CATALOGAR` y apunta su ID.
- Una hoja de Google Sheets llamada `Fototeca` con estas columnas en la fila 1: `archivo`, `enlace`, `titulo`, `descripcion`, `palabras_clave`, `color`, `apta_comercial`, `fecha`.
- En n8n, credenciales de `Google Drive OAuth2`, `Google Sheets OAuth2` y `Anthropic API`.

## Los nodos, en orden
1. **Google Drive Trigger** — Event: `File Created`, Watch: `Specific Folder` → `CATALOGAR`.
2. **Google Drive** — Operation: `Download`, File ID: `{{ $json.id }}`, campo binario `data`.
3. **Code** (`Preparar imagen`) — convierte el binario a base64 y recorta si hace falta. Código abajo.
4. **HTTP Request** (`Analizar con IA`) — Method: `POST`. URL: `https://api.anthropic.com/v1/messages`. Headers: `x-api-key` desde una credencial de n8n (Generic Credential Type > Header Auth, Name `x-api-key`, Value tu clave; no la escribas en el nodo: un flujo exportado se la llevaría), `anthropic-version` con `2023-06-01`, `content-type` con `application/json`. Body: `JSON` y pega el cuerpo del bloque de abajo.
5. **Code** (`Leer respuesta`) — extrae el JSON que devuelve el modelo. Código abajo.
6. **Google Sheets** — Operation: `Append Row`, documento `Fototeca`, hoja `Hoja 1`. Mapea cada columna con su campo: `titulo` → `{{ $json.titulo }}`, y así con todas.
7. **Google Drive** — Operation: `Update File`, File ID: `{{ $('Google Drive Trigger').item.json.id }}`, New Name: `{{ $json.titulo_archivo }}.jpg`. Así el archivo pasa a llamarse algo legible.

## El código del nodo Preparar imagen
```javascript
const item = $input.item;
const bin = item.binary.data;
return { json: { base64: bin.data, tipo: bin.mimeType, archivo: bin.fileName } };
```

## El cuerpo JSON del HTTP Request
```json
{
  "model": "claude-sonnet-5-5",
  "max_tokens": 700,
  "messages": [{
    "role": "user",
    "content": [
      {"type": "image", "source": {"type": "base64", "media_type": "={{ $json.tipo }}", "data": "={{ $json.base64 }}"}},
      {"type": "text", "text": "Analiza esta foto. Responde SOLO con un JSON valido, sin texto alrededor, con estas claves: titulo (max 8 palabras), titulo_archivo (en minusculas, sin tildes, palabras separadas por guiones), descripcion (2 frases, util como alt text SEO), palabras_clave (array de 10 strings en espanol), color (nombre del color dominante), apta_comercial (true si no se ven caras reconocibles, marcas ni logos ajenos; false si no)."}
    ]
  }]
}
```

## El código del nodo Leer respuesta
```javascript
const texto = $json.content[0].text.trim();
const limpio = texto.replace(/^```json/, '').replace(/```$/, '').trim();
let d;
try { d = JSON.parse(limpio); } catch (e) { d = { titulo: 'REVISAR', descripcion: limpio, palabras_clave: [], color: '', apta_comercial: false, titulo_archivo: 'revisar-' + Date.now() }; }
const origen = $('Google Drive Trigger').item.json;
return { json: {
  archivo: origen.name,
  enlace: 'https://drive.google.com/file/d/' + origen.id + '/view',
  titulo: d.titulo,
  titulo_archivo: d.titulo_archivo,
  descripcion: d.descripcion,
  palabras_clave: (d.palabras_clave || []).join(', '),
  color: d.color,
  apta_comercial: d.apta_comercial ? 'SI' : 'NO',
  fecha: new Date().toISOString().slice(0,10)
}};
```

## Cómo probarla
- Sube tres fotos muy distintas (un retrato, un producto, un paisaje) y ejecuta en modo test.
- Comprueba que en Sheets las palabras clave son en español y útiles. Si salen genéricas, alarga el texto del prompt pidiendo palabras clave de búsqueda comercial.
- Prueba con una foto donde se vea una cara: debe marcar `apta_comercial` como NO.

## Qué puede salir mal
- **El modelo devuelve texto alrededor del JSON.** El nodo Leer respuesta ya lo limpia y, si falla, escribe REVISAR en vez de romper el flujo.
- **Fotos de más de 5 MB.** La API las rechaza. Mete antes un nodo **Edit Image** con Operation `Resize`, ancho 1200 px: la IA no necesita más resolución para entender la foto y bajas el coste.
- **Duplicados en la hoja.** Antes del Append pon un **Google Sheets** con Operation `Lookup Row` buscando el nombre del archivo y un **IF**: si ya existe, no escribe.
- **Coste disparado.** Cada foto son unos 0,003 €. Si vas a procesar 10.000, haz una prueba de 20 y multiplica.

## Cuánto cuesta
- n8n auto-alojado: 0 €.
- Anthropic: pago por uso, sin cuota. Unos 3 € por cada 1.000 fotos analizadas a 1200 px.
- Google Sheets y Drive: gratis.
