# Imágenes de la web a WebP con texto alternativo SEO…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Convierte las fotos pesadas de tu web a WebP, las comprime y escribe el texto alternativo describiendo la imagen. Para negocios cuya web tarda una eternidad en cargar.

## Qué es y qué hace

Recorre la biblioteca de medios de WordPress mediante la REST API, descarga cada imagen sin texto alternativo, genera una versión WebP más ligera, la vuelve a subir y escribe un alt que describe lo que se ve con tu palabra clave local. Usa una contraseña de aplicación de WordPress y la clave del modelo de imagen que elijas.

## Cómo usarla

1. Crea la contraseña de aplicación en WordPress
2. Conecta el modelo de IA elegido
3. Prueba con 20 imágenes
4. Revisa los alt antes del lote completo

## Cuándo usarla

Cuando PageSpeed te riñe por imágenes pesadas o tu web tiene cientos de fotos sin texto alternativo.

## Cómo ganar dinero con ella

Una web que carga en 2 s en vez de 6 s convierte hasta un 20% más. En una tienda de 3.000 €/mes son 600 € extra.

- Optimización de imágenes de una web de negocio local que tarda demasiado en cargar.
- Mantenimiento mensual de imágenes para blogs y tiendas con publicaciones frecuentes.
- Auditoría y conversión a WebP para webs de clientes que sufren por imágenes pesadas.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Recorre la biblioteca de medios de tu WordPress, se descarga cada imagen sin texto alternativo, genera una versión WebP más ligera, la vuelve a subir y escribe el alt describiendo lo que se ve, con tu palabra clave local.
Para negocios locales, blogs y tiendas con WordPress que arrastran años de imágenes sin optimizar.

## Lo que necesitas antes
- WordPress con la REST API activa (viene de serie). Crea una **contraseña de aplicación**: Usuarios > Perfil > Contraseñas de aplicación. Guarda usuario y esa contraseña.
- Clave de OpenAI con acceso a un modelo con visión (gpt-4o-mini vale).
- n8n con el nodo Edit Image (incluido).
- Una copia de seguridad de la web antes de tocar nada. En serio.

## Los nodos, en orden
1) **Manual Trigger** para la primera pasada; luego un **Schedule Trigger** semanal para las nuevas.
2) **HTTP Request** (Listar medios). Method: GET. URL: `https://tuweb.com/wp-json/wp/v2/media?per_page=50&media_type=image`. Authentication: Generic > Basic Auth con tu usuario y la contraseña de aplicación. En Options activa Pagination si tienes muchas.
3) **IF** (¿Falta alt?). Condición String > Is Empty sobre `{{ $json.alt_text }}`.
4) **HTTP Request1** (Descargar). Method: GET. URL: `{{ $json.source_url }}`. En Options > Response, Response Format: File, Output Field: `data`.
5) **Edit Image**. Operation: Resize. Width: 1600, Resize Option: Maximum Area (Only If Larger). Añade un segundo **Edit Image1** con Operation: Format, Format: webp, Quality: 80.
6) **Extract from File** (Binario a base64). Operation: Binary to Base64, Input Binary Field: `data`, Destination Key: `b64`.
7) **HTTP Request2** (Describir con IA). Method: POST. URL: `https://api.openai.com/v1/chat/completions`. Header Auth Bearer. Body JSON: modelo gpt-4o-mini y un mensaje de usuario con dos partes: texto «Describe esta imagen en una sola frase de máximo 120 caracteres, en español de España, para usarla como texto alternativo accesible. Si aparece un producto o un lugar, nómbralo. No empieces con Imagen de.» y una parte image_url con `data:image/webp;base64,{{ $json.b64 }}`.
8) **HTTP Request3** (Actualizar alt). Method: POST. URL: `https://tuweb.com/wp-json/wp/v2/media/{{ $('HTTP Request').item.json.id }}`. Basic Auth. Body JSON: `{ "alt_text": "{{ $json.choices[0].message.content }}" }`.
9) **HTTP Request4** (Subir el WebP). Method: POST a `/wp-json/wp/v2/media`, Send Binary File activado, Header `Content-Disposition: attachment; filename="{{ $('HTTP Request').item.json.slug }}.webp"`.
10) **Google Sheets** opcional para llevar registro de qué se ha tocado y poder revertir.

## Cómo probarla
Empieza con `per_page=3` y mira los tres alt generados en el escritorio de WordPress. Compara el peso antes y después con la pestaña Red del navegador. Cuando estés conforme, sube el per_page.

## Qué puede salir mal
- **Las páginas siguen apuntando al JPG antiguo**: subir el WebP como medio nuevo no cambia las entradas. Si quieres reemplazo real, usa un plugin de conversión (Converter for Media) y deja este flujo solo para los alt.
- **401 en la API**: la contraseña de aplicación va con espacios; pégala tal cual, n8n los admite.
- **Alt genéricos**: si la IA dice «una persona sonriendo», añade al prompt tu contexto: «Es la web de una clínica dental en Valencia».
- **Imágenes decorativas**: las que no aportan información deben llevar alt vacío. Filtra por nombre o carpeta las que no quieras tocar.

## Cuánto cuesta
n8n autoalojado 0 €. Cada descripción con gpt-4o-mini cuesta unos 0,002 €: 500 imágenes salen por 1 €. Los plugins comerciales de optimización cobran 4-9 €/mes.
