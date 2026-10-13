# Alt text SEO para todas las fotos de tu tienda…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Recorre las imágenes de tu catálogo que no tienen texto alternativo, la IA se lo escribe mirando la foto y el producto, y lo guarda en la tienda.

## Qué es y qué hace

Lista las imágenes de la biblioteca de WordPress o WooCommerce que no tienen texto alternativo, se las enseña a un modelo de visión junto al nombre del producto y propone un alt de 10 a 15 palabras sin relleno. Las propuestas van a una hoja para aprobarlas y, al aprobarlas, se escriben en la tienda por la API REST. Entran imágenes y salen textos alternativos aprobados, con n8n y una IA como Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Crea la contraseña de aplicación de WordPress
2. Comprueba la API REST de medios en el navegador
3. Monta la propuesta y la aprobación en n8n
4. Revisa el primer lote antes de escribir

## Cuándo usarla

Úsalo cuando tu tienda tiene cientos de fotos sin alt, no apareces en Google Imágenes y además no cumples accesibilidad.

## Cómo ganar dinero con ella

Google Imágenes puede traer un 10-20% del tráfico de una tienda de producto físico. Escribirlo a mano son 40 horas para 500 fotos.

- Mejora de textos alternativos para tiendas WooCommerce con cientos de fotos, cobrada por tienda.
- Mantenimiento mensual de accesibilidad y SEO de imágenes para tiendas con catálogo que crece, por cuota.
- Plantilla de alt text vendida a agencias que gestionan tiendas WordPress de sus clientes.

**Precio orientativo:** 150–300 € por tienda. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lista todas las imágenes de la biblioteca de tu WordPress/WooCommerce, se queda con las que tienen el campo alt vacío, se las enseña a un modelo de visión junto con el nombre del producto al que pertenecen, y escribe un alt descriptivo de 10-15 palabras con la palabra clave incluida, sin caer en el relleno de keywords.
Para tiendas WooCommerce, y con cambios menores para Shopify o PrestaShop.

## Lo que necesitas antes
- WordPress con acceso de administrador. En Usuarios > tu perfil > `Contraseñas de aplicación`, crea una llamada `n8n` y copia la cadena de 24 caracteres con espacios.
- Comprueba que la REST API responde: abre `https://tutienda.com/wp-json/wp/v2/media?per_page=1` en el navegador.
- Clave de API de Anthropic (console.anthropic.com) o de OpenAI.
- Hoja `Alt Text` con columnas: `id`, `archivo`, `alt_antes`, `alt_nuevo`, `estado`.

## Los nodos, en orden
1. **Manual Trigger** para la primera pasada masiva. Luego lo cambias por **Schedule Trigger** semanal para las fotos nuevas.
2. **HTTP Request** (`Listar medios`) — `GET` a `https://tutienda.com/wp-json/wp/v2/media`. Authentication: `Generic` > `Basic Auth`, usuario tu login de WP, contraseña la de aplicación. Query Parameters: `per_page` = 100, `page` = 1, `media_type` = `image`. Activa Pagination en Options si tu n8n lo soporta, o repite el nodo cambiando `page`.
3. **Code** (`Sin alt`) — filtra los que tienen alt vacío. Código abajo.
4. **Split In Batches** — Batch Size: 1.
5. **HTTP Request** (`Bajar miniatura`) — `GET` a `{{ $json.miniatura }}`, Response Format `File`, campo `data`. Usa la miniatura mediana, no la original: la IA la entiende igual y gastas menos.
6. **Code** (`A base64`) — convierte el binario. Es el mismo patrón que en cualquier receta de visión: `return { json: { b64: $input.item.binary.data.data, tipo: $input.item.binary.data.mimeType, ...$('Sin alt').item.json } };`
7. **HTTP Request** (`Escribir alt`) — `POST` a `https://api.anthropic.com/v1/messages`, con los headers `x-api-key`, `anthropic-version: 2023-06-01` y `content-type: application/json`. Body JSON abajo.
8. **Code** (`Limpiar texto`) — quita comillas y recorta a 125 caracteres. Código abajo.
9. **HTTP Request** (`Guardar en WordPress`) — Method `POST` a `https://tutienda.com/wp-json/wp/v2/media/{{ $json.id }}`. Misma Basic Auth. Body JSON: `{"alt_text": "={{ $json.alt_nuevo }}"}`.
10. **Google Sheets** — `Append Row` con el antes y el después, para que puedas revisarlo y deshacer si algo chirría.

## El cuerpo JSON del HTTP Request
```json
{
  "model": "claude-haiku-4-5",
  "max_tokens": 150,
  "messages": [{
    "role": "user",
    "content": [
      {"type": "image", "source": {"type": "base64", "media_type": "={{ $json.tipo }}", "data": "={{ $json.b64 }}"}},
      {"type": "text", "text": "Esta imagen pertenece al producto: ={{ $json.titulo }}. Escribe el texto alternativo (alt) en espanol de Espana: una sola frase de 10 a 15 palabras que describa lo que se ve de forma util para una persona ciega y para Google. Menciona el producto de forma natural. Nada de 'imagen de' ni 'foto de'. Responde solo con la frase, sin comillas."}
    ]
  }]
}
```

## El código del nodo Sin alt
```javascript
return $input.all()
  .filter(i => !i.json.alt_text || i.json.alt_text.trim() === '')
  .map(i => ({ json: {
    id: i.json.id,
    titulo: i.json.title?.rendered || i.json.slug || '',
    archivo: i.json.source_url,
    miniatura: i.json.media_details?.sizes?.medium?.source_url || i.json.source_url,
    alt_antes: ''
  }}));
```

## El código del nodo Limpiar texto
```javascript
let t = ($json.content?.[0]?.text || '').trim();
t = t.replace(/^["'«]|["'»]$/g, '').replace(/\s+/g, ' ');
t = t.replace(/^(imagen|foto|fotografia) de /i, '');
if (t.length > 125) t = t.slice(0, 122).trim() + '...';
const d = $('Sin alt').item.json;
return { json: { ...d, alt_nuevo: t, estado: 'ACTUALIZADO' } };
```

## Cómo probarla
- Cambia el `per_page` a 3 y ejecuta. Mira en el escritorio de WordPress > Medios que esas tres imágenes tienen ya su alt.
- Lee los tres textos. Si suenan a robot, ajusta el prompt: por ejemplo pídele que use el tono de tu marca o que evite adjetivos vacíos.
- Solo cuando te gusten los tres, sube el `per_page` a 100 y déjalo correr.

## Qué puede salir mal
- **Error 401.** La contraseña de aplicación va con espacios incluidos; no los quites. Y comprueba que tu hosting no bloquea el header Authorization (algunos Apache lo comen: hay que añadir una regla en .htaccess).
- **Error 403 de Wordfence o similar.** Añade la IP de tu n8n a la lista blanca del plugin de seguridad.
- **Se te va la mano y quieres deshacer.** Por eso guardas el `alt_antes` en Sheets. Monta un workflow inverso que lea la hoja y restaure.
- **Fotos decorativas.** Un fondo abstracto no necesita alt; ponerle uno molesta a los lectores de pantalla. Añade un **IF** que salte las imágenes cuyo nombre de archivo contenga `fondo`, `banner` o `decor`.

## Cuánto cuesta
- Claude Haiku con miniaturas: unos 0,0006 € por imagen. 1.000 fotos son menos de 1 €.
- n8n y WordPress: lo que ya pagas.
- Plugins comerciales de alt text automático cobran de 10 a 30 €/mes.
