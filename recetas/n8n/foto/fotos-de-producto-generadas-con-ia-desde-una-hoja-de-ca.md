# Fotos de producto generadas con IA desde una hoja de cá…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Apuntas el producto en una fila, la IA genera la foto de estudio con el fondo y la luz que has definido, y la sube a tu ficha de producto. Para tiendas que no pueden pagar un book de fotos.

## Qué es y qué hace

Lee una hoja con SKU, material, color, estilo y fondo, construye el prompt fotográfico completo con plano, lente, luz y fondo, y genera la imagen con un modelo de imagen de OpenAI, Replicate o Flux. Guarda el resultado en Drive y, si vendes en Shopify, lo sube a la ficha del producto mediante la Admin API.

## Cómo usarla

1. Crea la hoja Catalogo
2. Conecta el modelo de imagen con su clave
3. Revisa cada imagen antes de subirla
4. Que lo revise un profesional

## Cuándo usarla

Cuando tienes catálogo grande, fotos malas de proveedor y presupuesto cero para un fotógrafo de producto.

## Cómo ganar dinero con ella

Un book de producto cuesta 15-40 € por foto. Con 100 referencias son 1.500-4.000 €; aquí bajas a menos de 10 €.

- Montaje de fotos de producto con IA para tiendas con catálogo grande y presupuesto ajustado.
- Servicio mensual de imágenes para nuevas referencias de una tienda Shopify.
- Plantilla de prompts de estudio vendida a artesanos que no pueden pagar un book de fotos.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee una hoja con producto, material, color y estilo deseado, monta el prompt fotográfico completo (plano, lente, luz, fondo), genera la imagen con un modelo de imagen y la deja en Drive y en la ficha del producto.
Para tiendas online, artesanos y marcas pequeñas que necesitan imágenes coherentes de muchas referencias.

## Lo que necesitas antes
- Hoja Catalogo con columnas: SKU, Producto, Material, Color, Estilo, Fondo, Prompt, URLImagen, Estado.
- Clave de OpenAI (platform.openai.com) para el modelo de imagen, o clave de Replicate/Flux si prefieres ese estilo.
- Carpeta FOTOS_IA en Google Drive.
- Si vendes en Shopify: en tu tienda, Configuración > Apps y canales > Desarrollar apps, creas una app privada con permiso write_products y copias el Admin API access token.
- Aviso legal: las imágenes generadas no pueden mostrar el producto con características que no tiene; en España eso sería publicidad engañosa.

## Los nodos, en orden
1) **Schedule Trigger** cada hora, o **Manual Trigger** si prefieres lanzarlo tú.
2) **Google Sheets** (Get Rows). Filtro: Estado = PENDIENTE. Limit: 10 por vuelta.
3) **Split In Batches**. Batch Size: 1 (los modelos de imagen van de uno en uno).
4) **Code** (Montar el prompt). Ver abajo.
5) **HTTP Request** (Generar). Method: POST. URL: `https://api.openai.com/v1/images/generations`. Header Auth con `Bearer sk-...`. Body JSON: `{ "model": "gpt-image-1", "prompt": "{{ $json.promptFinal }}", "size": "1024x1024", "quality": "high" }`.
6) **Convert to File** (Base64 a binario). Operation: Convert to File > Base64 to File. Base64 Input Field: `data[0].b64_json`. File Name: `{{ $('Google Sheets').item.json.SKU }}.png`.
7) **Google Drive** (Upload) a FOTOS_IA. Detrás, **Google Drive1** con Operation: Share, Type anyone, Role reader.
8) **HTTP Request1** (Subir a Shopify). Method: POST. URL: `https://TU-TIENDA.myshopify.com/admin/api/2025-01/products/{{ $json.ProductID }}/images.json`. Header `X-Shopify-Access-Token`. Body JSON: `{ "image": { "src": "URL_PUBLICA", "alt": "{{ $json.Producto }} de {{ $json.Material }} en color {{ $json.Color }}" } }`.
9) **Google Sheets1** (Update Row). Estado: GENERADA. URLImagen con el enlace.
10) Vuelta al **Split In Batches**. Añade un **Wait** de 5 segundos antes del retorno para no chocar con el límite de la API.

## El trozo de código (nodo Code)
```javascript
const f = $input.first().json;
const estilos = {
  'minimal': 'fondo blanco infinito, luz suave de softbox grande a 45 grados, sombra tenue bajo el producto',
  'natural': 'sobre mesa de madera clara, luz de ventana lateral, sombras largas suaves, ambiente cálido',
  'lujo': 'fondo gris grafito degradado, luz cenital dura y contraluz azulado, reflejos controlados'
};
const luz = estilos[String(f.Estilo).toLowerCase()] || estilos.minimal;
const promptFinal = [
  `Fotografía de producto profesional de ${f.Producto} de ${f.Material} en color ${f.Color}.`,
  `Plano de tres cuartos, ligeramente elevado, objetivo 100 mm macro, diafragma f/8, todo el producto enfocado.`,
  luz + '.',
  'Sin texto, sin marcas de agua, sin personas, sin manos.',
  'Imagen limpia, nítida, lista para ficha de comercio electrónico.'
].join(' ');
return [{ json: { ...f, promptFinal } }];
```

## Cómo probarla
Genera primero tres SKU muy distintos (algo brillante, algo de tela, algo pequeño). Mira si el material se reconoce. Si no, añade al prompt detalles concretos: «cuero granulado mate», «acero cepillado con reflejos suaves».

## Qué puede salir mal
- **El producto no es el tuyo**: la IA inventa. Para productos con forma exacta, usa edición de imagen sobre una foto real (endpoint /images/edits con la foto del proveedor como base) en vez de generación desde cero.
- **Límite de peticiones**: si te devuelve 429, sube el Wait a 15 segundos y baja el lote.
- **Coste descontrolado**: pon Limit 10 en el nodo de Sheets para no generar 500 imágenes por error.
- **Fondos que no casan**: fija el mismo Estilo para todo el catálogo o las fichas quedarán descoordinadas.

## Cuánto cuesta
n8n autoalojado 0 €. Cada imagen de alta calidad cuesta entre 0,04 y 0,19 € según el modelo: 100 imágenes salen por 4-19 €. Shopify y Drive no cobran extra por esto.
