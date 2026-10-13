# Fichas de venta multi-idioma para tus modelos 3D…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

A partir de una fila con el nombre y cuatro datos del modelo, redacta el título, la descripción y las etiquetas para varios marketplaces y en tres idiomas.

## Qué es y qué hace

Flujo de n8n que lee una hoja con los datos técnicos de cada modelo (tipo, triángulos, texturas, formatos, estilo) y redacta el título, la descripción y las etiquetas para cada tienda y en varios idiomas. Entra una fila por modelo y sale la ficha en inglés, español y alemán escrita de vuelta en la hoja. Usa una clave de API de una IA de texto (Claude, Codex, Gemini o una IA local) y el coste es de céntimos por ficha.

## Cómo usarla

1. 1. Rellena una fila por modelo con sus datos técnicos
2. 2. Pon tu clave de IA en la credencial de n8n
3. 3. Revisa las fichas antes de publicarlas en cada tienda

## Cuándo usarla

Úsalo cuando vendes modelos en varias tiendas a la vez y pierdes horas reescribiendo la misma ficha para Fab, CGTrader y Sketchfab en inglés, español y alemán.

## Cómo ganar dinero con ella

Pasas de 25 minutos por ficha a menos de uno. Con 40 modelos al mes eso es un fin de semana entero recuperado.

- Fichas de venta en tres idiomas para artistas 3D que publican el mismo modelo en Fab, CGTrader y Sketchfab.
- Pack de textos de catálogo para estudios que venden lotes de props y necesitan descripciones coherentes.
- Redacción de fichas con revisión humana para tiendas de assets que quieren ahorrar horas en cada alta.

**Precio orientativo:** 60–180 € por catálogo. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lees una hoja donde apuntas los datos técnicos del modelo (tipo, triángulos, texturas, formatos, estilo) y el flujo genera los textos de venta adaptados a cada tienda y a cada idioma.
Para el artista 3D que publica en varios sitios y sabe que el 80% de las visitas dependen del título y de las etiquetas.

## Lo que necesitas antes
Cuenta de n8n y credenciales de Google Sheets OAuth2.
Una clave de la API de Anthropic: entra en `console.anthropic.com`, sección API Keys, crea una y guárdala. Requiere meter saldo (con 5 € haces cientos de fichas).
En n8n, crea la credencial `Anthropic API` con esa clave, o usa un HTTP Request con la cabecera `x-api-key`.
Una hoja `catalogo` con columnas: `modelo`, `tipo`, `triangulos`, `texturas`, `formatos`, `estilo`, `usos`, `estado`, y luego `titulo_en`, `desc_en`, `tags_en`, `titulo_es`, `desc_es`, `titulo_de`, `desc_de`.
Rellena solo las primeras columnas y deja `estado` vacío. El flujo pone `hecho` al terminar.

## Los nodos, en orden
1) **Schedule Trigger** — cada hora, o usa un **Manual Trigger** si prefieres lanzarlo tú.
2) **Google Sheets** (`Get Row(s)`) — pestaña `catalogo`, con filtro `estado` igual a vacío. Activa `Return All`.
3) **Split In Batches** — tamaño 1, para que cada modelo vaya por separado y no se mezclen textos.
4) **HTTP Request** — POST a `https://api.anthropic.com/v1/messages`. Cabeceras: `x-api-key` con tu clave, `anthropic-version` con `2023-06-01`, `content-type` con `application/json`. Cuerpo en JSON (ver abajo).
5) **Code** — extrae el JSON de la respuesta.
6) **Google Sheets** (`Update Row`) — busca por la columna `modelo` y escribe todas las columnas de textos más `estado` = `hecho`.
7) Conecta de vuelta al **Split In Batches**.

## El cuerpo del HTTP Request
```json
{
  "model": "claude-sonnet-5-5",
  "max_tokens": 2000,
  "messages": [{ "role": "user", "content": "Eres redactor de fichas de marketplaces 3D. Datos del modelo: nombre {{ $json.modelo }}, tipo {{ $json.tipo }}, {{ $json.triangulos }} triángulos, texturas {{ $json.texturas }}, formatos {{ $json.formatos }}, estilo {{ $json.estilo }}, usos {{ $json.usos }}. Devuelve SOLO un objeto JSON válido, sin texto alrededor, con estas claves: titulo_en, desc_en, tags_en, titulo_es, desc_es, titulo_de, desc_de. Los títulos, máximo 70 caracteres, con la palabra clave principal delante. Las descripciones, entre 90 y 130 palabras, con una lista de especificaciones técnicas al final. tags_en son 15 etiquetas separadas por comas, en minúsculas y sin repetir." }]
}
```

## El trozo de código (nodo Code)
```javascript
const bruto = $input.first().json.content[0].text.trim();
const limpio = bruto.replace(/^```json/i, '').replace(/```$/, '').trim();
let d;
try { d = JSON.parse(limpio); }
catch (e) { return [{ json: { error: 'Respuesta no válida', bruto: limpio.slice(0, 300) } }]; }
d.modelo = $('Split In Batches').first().json.modelo;
d.estado = 'hecho';
return [{ json: d }];
```

## Cómo probarla
Rellena una sola fila de la hoja y ejecuta el flujo a mano. Revisa que los tres idiomas suenan naturales y que las etiquetas no son un copia y pega del título.
Si la respuesta viene con texto antes del JSON, endurece la instrucción: «Tu respuesta debe empezar por { y terminar por }».
Publica la primera ficha a mano y compárala con las que hacías tú. Ajusta el estilo en el prompt hasta que te suene a tuyo.

## Qué puede salir mal
Si dejas el flujo procesando 200 filas de golpe puedes chocar con el límite de peticiones por minuto: pon un nodo **Wait** de 3 segundos antes del HTTP Request.
Si el modelo devuelve JSON roto, el Code lo captura y no escribe basura en la hoja; revisa esas filas a mano.
Cada tienda tiene su límite de caracteres en el título: comprueba el de Fab y CGTrader y ajústalo en el prompt.
No publiques la descripción palabra por palabra idéntica en las tres tiendas: cambia el primer párrafo en cada una para no competir contigo mismo en Google.

## Cuánto cuesta
n8n y Google Sheets: gratis.
La API de Anthropic se paga por uso. Una ficha completa en tres idiomas cuesta alrededor de 1-2 céntimos, así que 100 modelos salen por menos de 2 €.
