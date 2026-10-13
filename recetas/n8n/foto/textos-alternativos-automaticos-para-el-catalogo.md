# Textos alternativos automáticos para el catálogo…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Genera el texto alternativo y el nombre de archivo correctos para las fotos de tu tienda usando un modelo que mira la imagen, y lo escribe en la ficha del producto.

## Qué es y qué hace

Recorre una lista de imágenes de producto, se las enseña a un modelo de visión y pide un texto alternativo de menos de 125 caracteres en español y un nombre de archivo con guiones. Guarda la propuesta en una hoja para revisarla y, al aprobarla, la escribe en la ficha del producto. Entran imágenes y nombres de producto y salen textos alternativos aprobados, con n8n y una IA como Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Prepara la hoja de pendientes con sus columnas
2. Consigue la clave de la IA en la consola de tu proveedor
3. Monta propuesta y aprobación en n8n
4. Revisa veinte textos antes de publicarlos

## Cuándo usarla

Úsalo cuando tengas cientos de fotos de producto subidas sin descripción, pierdas visitas en Google Imágenes o necesites cumplir accesibilidad.

## Cómo ganar dinero con ella

Escribir 300 textos alternativos a mano son unas 8 horas. Aquí cuestan menos de 2 € de API y traen tráfico de Google Imágenes que hoy no recibes.

- Textos alternativos y nombres de archivo para catálogos de tiendas online, cobrados por cada cien productos.
- Mantenimiento mensual del SEO de imágenes para tiendas con novedades semanales, por cuota.
- Plantilla de catálogo accesible vendida a fotógrafos de producto que entregan a sus clientes.

**Precio orientativo:** 150–300 € por cada cien productos. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recorre una lista de imágenes de producto, se las enseña a un modelo con visión y le pide un texto alternativo descriptivo de menos de 125 caracteres, en español, sin relleno de palabras clave, más un nombre de archivo con guiones.
Guarda el resultado en una hoja para que lo revises y, cuando das el visto bueno, lo escribe en tu tienda. Es para fotógrafos de producto que además gestionan la tienda del cliente, y para tiendas pequeñas.

## Lo que necesitas antes
- Clave de API de Anthropic: te registras en console.anthropic.com, vas a «API Keys», creas una y cargas saldo (con 5 € tienes para miles de imágenes).
- En n8n, credencial «Anthropic API» (o una «Header Auth» con la cabecera `x-api-key`).
- Una hoja de Google Sheets `alt_pendientes` con columnas: `url_imagen`, `nombre_producto`, `id_producto`, `alt_propuesto`, `nombre_archivo`, `aprobado`.
- Si vas a escribir en WooCommerce: en tu WordPress, WooCommerce › Ajustes › Avanzado › REST API, creas una clave con permisos de lectura/escritura y la metes en n8n como credencial «WooCommerce API».

## Los nodos, en orden
1. **Manual Trigger** para las primeras pruebas; luego un **Schedule Trigger** diario si subes producto a menudo.
2. **Google Sheets** — Operation: `Get Row(s)`, hoja `alt_pendientes`, Return All activado.
3. **Filter** — String `{{ $json.alt_propuesto }}` está vacío. Así no repites lo ya hecho.
4. **Split In Batches** — Batch Size: `1`.
5. **HTTP Request** (renómbralo «Bajar imagen») — Method: `GET`, URL: `{{ $json.url_imagen }}`, Response Format: `File`, campo de salida `data`.
6. **Extract From File** — Operation: `Binary to Property`... o más simple: usa un **Code** para pasar el binario a base64, que es lo que pide la API. Código abajo.
7. **HTTP Request** (renómbralo «Describir») — Method: `POST`, URL: `https://api.anthropic.com/v1/messages`. Headers: `x-api-key` con tu clave, `anthropic-version` = `2023-06-01`, `content-type` = `application/json`. Body: JSON, con el cuerpo del segundo bloque de código.
8. **Code** — extrae el JSON de la respuesta del modelo.
9. **Google Sheets** — Operation: `Update Row`, Column to Match On: `url_imagen`, escribe `alt_propuesto` y `nombre_archivo`. Conecta de vuelta al **Split In Batches**.
10. (Fase 2, cuando ya has revisado) Otro flujo con **Google Sheets** filtrando `aprobado = si` y un **WooCommerce** — Resource: `Product`, Operation: `Update`, o un **HTTP Request** a la API REST de WordPress `POST /wp-json/wp/v2/media/{id}` con el campo `alt_text`.

## El código (nodo 6, imagen a base64)
```javascript
const buffer = await this.helpers.getBinaryDataBuffer(0, 'data');
const bin = $input.first().binary.data;
return { json: {
  base64: buffer.toString('base64'),
  media_type: bin.mimeType || 'image/jpeg',
  nombre_producto: $('Split In Batches').item.json.nombre_producto,
  url_imagen: $('Split In Batches').item.json.url_imagen
} };
```

## El cuerpo JSON del nodo «Describir»
```json
{
  "model": "claude-sonnet-5-5",
  "max_tokens": 300,
  "messages": [{
    "role": "user",
    "content": [
      { "type": "image", "source": { "type": "base64", "media_type": "{{ $json.media_type }}", "data": "{{ $json.base64 }}" } },
      { "type": "text", "text": "Eres experto en accesibilidad y SEO. El producto se llama: {{ $json.nombre_producto }}. Devuelve SOLO un JSON con dos claves: alt (texto alternativo en español de España, máximo 125 caracteres, describe lo que se ve de forma útil para alguien que no ve la imagen, sin empezar por 'imagen de' y sin amontonar palabras clave) y archivo (nombre de archivo en minúsculas, con guiones, sin acentos ni eñes, máximo 6 palabras, sin extensión)." }
    ]
  }]
}
```

## Cómo probarla
- Corre el flujo con 3 filas. Lee los tres textos: si empiezan por «Imagen de» o meten adjetivos de vendedor, ajusta la instrucción del prompt.
- Prueba con una foto ambigua (detalle macro de una costura): ahí es donde se ve si el nombre de producto está ayudando al modelo.
- Antes de escribir en la tienda, haz copia de seguridad de la base de datos de WordPress. La fase 2 la activas solo cuando has revisado a mano las primeras 30 filas.

## Qué puede salir mal
- **El modelo devuelve texto alrededor del JSON**: en el nodo Code, extrae con `const m = texto.match(/\{[\s\S]*\}/); JSON.parse(m[0]);` y así te da igual.
- **Imágenes enormes**: la API tiene límite de tamaño por imagen. Antes del paso 7 mete un nodo **Edit Image** con Operation `Resize` a 1024 px de ancho; además abarata la llamada.
- **Coste desbocado**: pon un límite en el `Split In Batches` con un **IF** que corte a las 200 imágenes por ejecución.
- **Renombrar archivos ya publicados**: cambiar el nombre de un archivo que ya está en la web ROMPE los enlaces. Usa la columna `nombre_archivo` solo para fotos nuevas; para las que ya están publicadas, cambia únicamente el texto alternativo.
- **Textos alternativos clonados**: si tienes 8 fotos del mismo producto, saldrán parecidos. Añade al prompt el número de foto y pide que describa el ángulo o detalle concreto.

## Cuánto cuesta
- API de Anthropic: unos céntimos por imagen con el modelo intermedio; 300 imágenes salen por menos de 2 €.
- n8n, Sheets y WooCommerce: gratis.
- Total realista de un catálogo entero de 500 fotos: unos 3 € y una tarde de revisión.
