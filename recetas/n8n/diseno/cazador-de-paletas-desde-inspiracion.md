# Cazador de paletas desde inspiración…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Guardas una imagen de referencia y te devuelve la paleta en hexadecimal con nombres, uso sugerido y la ficha lista para tu moodboard.

## Qué es y qué hace

Recibe una imagen de referencia desde una carpeta de Drive y la envía a un modelo con visión, que devuelve seis colores en hexadecimal con nombre, su papel en la paleta y el tono que transmiten. El resultado se guarda en una hoja de cálculo o en Notion junto a la imagen. Sirve para armar moodboards sin sacar colores a mano. Se monta con n8n, Make o Zapier.

## Cómo usarla

1. Crea la carpeta inspiracion en Drive
2. Conecta Google Drive y tu clave de Claude, Codex, Gemini o una IA local
3. Prepara la hoja paletas con sus columnas
4. Prueba con una imagen y revisa la fila generada

## Cuándo usarla

Úsalo cuando acumulas capturas de inspiración y luego pierdes el tiempo sacando colores con el cuentagotas uno a uno para armar la paleta.

## Cómo ganar dinero con ella

Ahorra 15-20 minutos por moodboard y da paletas más coherentes. Coste: menos de 0,01 € por imagen analizada.

- Paletas para moodboards de marca entregadas como ficha por imagen…
- Servicio mensual de dirección de arte con biblioteca de paletas por cliente…
- Plantilla para estudios que documentan referencias visuales de cada proyecto…

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Vigila una carpeta `inspiracion` en Drive; por cada imagen que dejas ahí, la IA con visión analiza la composición y devuelve seis colores en hexadecimal con nombre, papel dentro de la paleta (principal, secundario, acento, fondo, texto) y una nota sobre el tono que transmite. Todo se guarda en una hoja o en una base de Notion junto a la imagen.
Para diseñadores de marca que construyen territorios visuales y para quien prepara moodboards para clientes.

**Lo que necesitas antes**
- Credencial OAuth de Google Drive.
- Clave de API de un modelo con visión: console.anthropic.com (Claude) o platform.openai.com.
- Carpeta `inspiracion` en Drive.
- Una hoja `paletas` con columnas: archivo, fecha, hex1..hex6, papeles, sensacion, enlace_imagen. O una base de Notion con esas propiedades y una integración creada en notion.so/my-integrations, compartida con la base.

**Los nodos, en orden**
1. **Google Drive Trigger**: File Created sobre `inspiracion`.
2. **Google Drive**: Download File con `{{ $json.id }}`.
3. **Code**: pasa la imagen a base64 para mandarla a la API.
```javascript
const bin = items[0].binary.data;
return [{ json: { nombre: items[0].json.name || 'inspiracion', mime: bin.mimeType, b64: bin.data } }];
```
4. **HTTP Request**: POST a `https://api.anthropic.com/v1/messages`, cabeceras `x-api-key` y `anthropic-version: 2023-06-01`. En el body, un mensaje con dos bloques: uno de tipo `image` con `source.type` en `base64`, `media_type` con `{{ $json.mime }}` y `data` con `{{ $json.b64 }}`, y otro de tipo `text` con el prompt: «Extrae la paleta de esta imagen. Devuelve SOLO un JSON con esta forma: {"colores":[{"hex":"#RRGGBB","nombre":"...","papel":"principal|secundario|acento|fondo|texto"}],"sensacion":"dos frases"}. Seis colores exactos. Nada de texto fuera del JSON.».
5. **Code** (segundo): parsea la respuesta con tolerancia, por si la IA añade texto alrededor.
```javascript
const txt = $json.content[0].text;
const m = txt.match(/\{[\s\S]*\}/);
if (!m) throw new Error('La IA no devolvió JSON: ' + txt.slice(0, 200));
const d = JSON.parse(m[0]);
const fila = { archivo: $('Code').first().json.nombre, fecha: new Date().toISOString().slice(0,10), sensacion: d.sensacion };
d.colores.forEach((c, i) => { fila['hex' + (i + 1)] = c.hex; });
fila.papeles = d.colores.map(c => `${c.hex} ${c.papel}`).join(' | ');
return [{ json: fila }];
```
6. **Google Sheets**: Append Row en `paletas`. Truco: en la hoja, aplica formato condicional para que cada celda hex se pinte de su color y veas la paleta de un vistazo.
7. **Notion** (alternativa): operación Create Database Page, con la imagen como portada y los hex como propiedades de texto.

**Cómo probarla**
- Sube tres imágenes muy distintas: una foto oscura de producto, un cartel plano de colores y una escena natural. Compara los hex con el cuentagotas de tu editor: la desviación normal es pequeña, y si es grande, la imagen tenía filtros de color.
- Prueba con una imagen en blanco y negro para ver que no se inventa colores.

**Qué puede salir mal**
- La IA devuelve JSON con texto alrededor: por eso el segundo Code node busca con expresión regular. Si aun así falla, activa Retry On Fail en el nodo HTTP.
- Imágenes muy pesadas: por encima de 5 MB la API puede rechazarlas. Mete antes un **Edit Image** con Resize a 1024 px de ancho.
- Precisión: la IA da colores representativos, no un análisis pixel a pixel. Para trabajo fino, valida con el cuentagotas antes de entregar.
- Derechos: la inspiración es para ti, no para copiar. Las paletas no se registran, pero las composiciones sí tienen autor.

**Cuánto cuesta**
- Menos de 0,01 € por imagen con Claude Haiku o similar.
- Drive, Sheets y n8n autoalojado: gratis (n8n Cloud solo tiene una prueba gratuita temporal y después es de pago). Notion: plan gratuito suficiente.
