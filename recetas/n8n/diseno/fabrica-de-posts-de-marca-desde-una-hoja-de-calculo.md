# Fábrica de posts de marca desde una hoja de cálculo…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Escribes el texto de tus posts en Google Sheets y cada mañana salen las imágenes ya maquetadas con tu plantilla, tus colores y tu logo, guardadas en Drive.

## Qué es y qué hace

Lee una hoja con titular, subtítulo y color de cada post, rellena la plantilla de marca en Placid mediante su API (capas titulo, subtitulo, fondo y logo) y guarda las imágenes terminadas en Drive. Entrada: fila de hoja; salida: imagen final lista para publicar. Se monta en n8n con cuenta de Placid y Google. Pensado para publicar muchas piezas con el mismo diseño base.

## Cómo usarla

1. Crea la plantilla en Placid con las capas exactas
2. Obtén el token de API
3. Rellena la hoja de posts
4. Revisa las primeras imágenes antes del lote

## Cuándo usarla

Úsalo cuando publicas varias piezas a la semana con el mismo diseño base (frases, tips, ofertas) y estás perdiendo horas duplicando artboards a mano en Canva o Figma.

## Cómo ganar dinero con ella

Ahorra unos 10-15 minutos por pieza. Con 20 piezas al mes son 4 horas menos de maquetación repetitiva, o unos 120 € si lo subcontratas a 30 €/h.

- Producción de posts para autónomos que publican tres piezas por semana.
- Plantillas por lotes para tiendas con ofertas semanales.
- Maquetación recurrente para agencias con clientes en redes sociales.

**Precio orientativo:** 150–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee una hoja de Google Sheets donde apuntas titular, subtítulo y color de cada post, y genera la imagen final aplicando tu plantilla de marca. Está pensada para autónomos y pequeñas marcas que publican mucho contenido con el mismo diseño y no quieren tocar el editor cada vez.

## Lo que necesitas antes
- Cuenta de n8n (nube gratuita limitada o auto-alojado con Docker, gratis).
- Cuenta de Google con Sheets y Drive. Las credenciales se sacan en console.cloud.google.com: crea un proyecto, activa Google Sheets API y Google Drive API, y genera un ID de cliente OAuth de tipo Aplicación web con la URL de retorno que te muestra n8n.
- Cuenta en Placid (placid.app). En Settings > API sacas el token. Crea allí una plantilla con capas llamadas exactamente `titulo`, `subtitulo`, `fondo` y `logo`, y copia el UUID de la plantilla.
- Una hoja de cálculo con columnas: `fecha`, `titulo`, `subtitulo`, `color_fondo`, `estado`, `url_imagen`.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: Days, Days Between Triggers 1, Trigger at Hour 7. Así se ejecuta cada mañana a las 7:00.
2. **Google Sheets** — Resource: Sheet Within Document, Operation: Get Row(s). Selecciona el documento y la hoja. En Filters añade Lookup Column `estado`, Lookup Value `pendiente`. Devuelve una fila por post.
3. **Split In Batches** (se llama «Loop Over Items») — Batch Size: 1. Evita mandar diez peticiones a la vez a la API de imágenes.
4. **HTTP Request** (renombra el nodo a «Crear imagen») — Method: POST, URL: `https://api.placid.app/api/rest/{{ $json.template_uuid || 'TU_UUID' }}`. En Authentication elige Generic Credential Type > Header Auth, Name `Authorization`, Value `Bearer TU_TOKEN_PLACID`. Body Content Type: JSON, y en Specify Body: Using JSON pega el JSON del apartado siguiente.
5. **Wait** — Amount: 8, Unit: Seconds. Placid tarda unos segundos en renderizar.
6. **HTTP Request** (renombra a «Descargar imagen») — Method: GET, URL: `={{ $('Crear imagen').item.json.image_url }}`. En Options activa Response > Response Format: File, Put Output in Field: `data`.
7. **Google Drive** — Resource: File, Operation: Upload. Input Data Field Name: `data`. File Name: `={{ $('Loop Over Items').item.json.fecha }}-{{ $('Loop Over Items').item.json.titulo.substring(0,30) }}.jpg`. Parent Drive: My Drive, Folder: la carpeta «Posts generados» que crees a mano.
8. **Google Sheets** — Operation: Update Row. Matching Column: `titulo`. Escribe `estado` = `listo` y `url_imagen` = `={{ $('Crear imagen').item.json.image_url }}`.
9. Conecta la salida del nodo 8 de vuelta a la entrada de **Loop Over Items** para que procese la siguiente fila.
10. **Gmail** — Operation: Send. To: tu correo. Subject: `Posts del día listos`. Message: `Se han generado {{ $items().length }} piezas en la carpeta Posts generados de Drive.` Conéctalo a la salida «done» del Loop Over Items.

## El JSON del cuerpo del nodo «Crear imagen»
```json
{
  "layers": {
    "titulo": { "text": "{{ $json.titulo }}" },
    "subtitulo": { "text": "{{ $json.subtitulo }}" },
    "fondo": { "background_color": "{{ $json.color_fondo }}" }
  },
  "create_now": true
}
```

## Cómo probarla
Pon dos filas de prueba en la hoja con estado `pendiente`. Pulsa «Test workflow» en n8n y ve mirando el resultado de cada nodo. Abre la imagen que devuelve `image_url` en el navegador antes de guardar nada. Cuando las dos salgan bien, activa el workflow con el interruptor de arriba a la derecha.

## Qué puede salir mal
- **Se generan duplicados**: pasa si el nodo 8 falla y la fila se queda en `pendiente`. Solución: en Settings del nodo Google Sheets de actualización activa Retry On Fail con 3 intentos.
- **Textos que se salen de la caja**: en Placid marca la capa de título como Auto Size o limita a 60 caracteres con `{{ $json.titulo.substring(0,60) }}`.
- **Hora equivocada**: en Settings del workflow pon Timezone `Europe/Madrid`, si no n8n usa UTC y se ejecuta a las 9:00.
- **Límite de API**: el plan gratuito de Placid da pocas imágenes al mes; el Split In Batches con Batch Size 1 evita picos.

## Cuánto cuesta
n8n auto-alojado y Google Sheets/Drive: gratis. Placid tiene prueba gratuita y luego desde unos 19 €/mes. Alternativa gratis del todo: sustituye Placid por un nodo Code que genere HTML y un Gotenberg auto-alojado que lo convierta en imagen.
