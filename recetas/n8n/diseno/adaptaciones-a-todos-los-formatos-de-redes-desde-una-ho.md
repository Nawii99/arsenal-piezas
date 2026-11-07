# Adaptaciones a todos los formatos de redes desde una ho…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Rellenas una fila con titular, imagen y color, y te devuelve la misma pieza adaptada a story, feed cuadrado, portada de LinkedIn y banner, ya subida a Drive.

## Qué es y qué hace

Lee una hoja de cálculo donde cada fila es una pieza gráfica con titular, subtítulo, imagen y color, la envía a un motor de plantillas (Placid o Bannerbear) para generar cada formato, y guarda los resultados en Drive con nombre ordenado, escribiendo los enlaces de vuelta en la hoja. Se monta con n8n, Make o Zapier.

## Cómo usarla

1. Diseña una plantilla por formato y nombra sus capas
2. Crea la hoja Campanas con sus columnas
3. Conecta Placid y Google Drive
4. Rellena una fila de prueba y revisa los enlaces

## Cuándo usarla

Cuando el cliente pide la misma campaña en seis tamaños distintos y te toca duplicar mesas de trabajo y recolocar textos a mano cada vez.

## Cómo ganar dinero con ella

De 40 minutos por campaña a 2. Con cuatro campañas al mes son más de dos horas facturables recuperadas, o adaptaciones que puedes cobrar sin trabajarlas.

- Adaptación de campañas a todos los formatos como entrega fija por cliente…
- Gestión mensual de piezas para redes de pymes con hoja de encargos…
- Plantillas de formatos sociales para agencias que trabajan con varios clientes…

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee una hoja de cálculo donde cada fila es una pieza gráfica, la manda a un motor de plantillas con varios formatos y guarda cada resultado en Drive con nombre ordenado, escribiendo el enlace de vuelta en la hoja.
Es para diseñadores que gestionan redes de varios clientes y para el propio cliente, que puede rellenar la hoja sin tocar el diseño.
## Lo que necesitas antes
Cuenta en placid.app (o Bannerbear, misma idea). Diseña ahí una plantilla por formato: `story-1080x1920`, `feed-1080x1080`, `linkedin-1200x627`, `banner-1200x300`. En cada plantilla nombra las capas exactamente `titulo`, `subtitulo`, `imagen` y `fondo`.
Apunta el `uuid` de cada plantilla (aparece en la URL del editor) y tu API token en Placid: Settings > API Tokens.
Una hoja de Google `Campanas` con columnas: `id`, `titulo`, `subtitulo`, `url_imagen`, `color_fondo`, `estado`, `enlaces`.
En n8n: credenciales «Google Sheets OAuth2 API», «Google Drive OAuth2 API» y una «Header Auth» con Name `Authorization` y Value `Bearer TU_TOKEN_PLACID`.
## Los nodos, en orden
**1. «Schedule Trigger»** — Interval: Minutes, cada 15. (O usa un «Webhook» si prefieres dispararlo con un botón.)
**2. «Google Sheets»** — Get Row(s) de `Campanas`, Options > Filters: columna `estado` igual a `pendiente`.
**3. «Split In Batches»** — Batch Size 1: una campaña cada vez.
**4. «Code»** — expande la fila en cuatro items, uno por formato (código abajo).
**5. «HTTP Request»** (nómbralo Generar imagen) — POST a `https://api.placid.app/api/rest/images`, Authentication: Header Auth. Body JSON: `{ "template_uuid": "{{ $json.template_uuid }}", "layers": { "titulo": { "text": "{{ $json.titulo }}" }, "subtitulo": { "text": "{{ $json.subtitulo }}" }, "imagen": { "image": "{{ $json.url_imagen }}" }, "fondo": { "color": "{{ $json.color_fondo }}" } } }`.
**6. «Wait»** — Amount 5, Unit Seconds. La generación es asíncrona y la primera respuesta suele venir con estado `queued`.
**7. «HTTP Request»** (nómbralo Comprobar) — GET a `{{ $('Generar imagen').item.json.polling_url }}`. Settings: Retry On Fail, Max Tries 5, Wait Between Tries 4000, para cubrir los casos lentos.
**8. «HTTP Request»** (nómbralo Descargar) — GET a `{{ $json.image_url }}`, Response Format: File.
**9. «Google Drive»** — Upload, File Name `{{ $('Code').item.json.nombre_archivo }}`, carpeta de la campaña.
**10. «Google Sheets»** — Operation: Update, busca por columna `id` y escribe `estado` = `hecho` y `enlaces` con las URL separadas por saltos de línea.
**11.** Conecta de vuelta a «Split In Batches».
## El trozo de código (nodo «Code»)
```javascript
const fila = $input.first().json;
const formatos = [
  { clave: 'story', template_uuid: 'UUID_STORY' },
  { clave: 'feed', template_uuid: 'UUID_FEED' },
  { clave: 'linkedin', template_uuid: 'UUID_LINKEDIN' },
  { clave: 'banner', template_uuid: 'UUID_BANNER' }
];
const slug = String(fila.titulo || 'pieza').toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g,'').replace(/[^a-z0-9]+/g,'-').replace(/^-|-$/g,'').slice(0,40);
return formatos.map(f => ({ json: {
  ...f,
  id: fila.id,
  titulo: fila.titulo,
  subtitulo: fila.subtitulo || '',
  url_imagen: fila.url_imagen,
  color_fondo: fila.color_fondo || '#111111',
  nombre_archivo: `${fila.id}_${slug}_${f.clave}.jpg`
} }));
```
## Cómo probarla
Rellena una sola fila con `estado` = `pendiente` y un titular corto. Ejecuta a mano y comprueba los cuatro archivos en Drive.
Después prueba con un titular larguísimo: si se sale de la caja, activa en la plantilla de Placid el ajuste automático de tamaño de fuente (`Auto-fit text`).
## Qué puede salir mal
Titulares de longitud muy distinta rompen la composición: define en la hoja un máximo de caracteres y ponlo como validación de datos en Google Sheets.
Si no marcas `estado` = `hecho`, la siguiente ejecución vuelve a generar todo. Es el fallo más común.
Las URL de imagen deben ser públicas y acabar en `.jpg` o `.png`; los enlaces de Drive con `/view` no funcionan, usa el formato `uc?export=download&id=`.
Los acentos y las comillas tipográficas en el JSON pueden romper la petición: en n8n usa la expresión `{{ JSON.stringify($json.titulo) }}` si te da error de parseo.
## Cuánto cuesta
n8n autoalojado (Community Edition) y Google gratis (n8n Cloud: prueba gratuita temporal y después de pago). Placid: prueba gratuita y planes desde unos 19 €/mes con 5.000 imágenes; Bannerbear parte de 49 $/mes. Si generas menos de 30 imágenes al mes, cabes en la prueba o en el plan más pequeño.
