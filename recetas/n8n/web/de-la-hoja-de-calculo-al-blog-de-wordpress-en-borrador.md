# De la hoja de cálculo al blog de WordPress en borrador…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Coge las filas marcadas como listas en tu hoja de contenidos, las convierte en entradas de WordPress con título, texto, categoría, etiquetas e imagen destacada, y las deja en borrador.

## Qué es y qué hace

Cada hora lee en Google Sheets las filas marcadas como listas, sube la imagen a la biblioteca de medios de WordPress por la REST API, crea la entrada en borrador con categoría y etiquetas, y escribe de vuelta la URL de edición y el nuevo estado. Entrada: título, contenido HTML, categoría, etiquetas e imagen. Salida: borradores en WordPress y hoja actualizada. Se monta en n8n con una credencial de WordPress y una contraseña de aplicación.

## Cómo usarla

1. Crea la contraseña de aplicación en WordPress
2. Configura la credencial en n8n
3. Prepara la hoja Calendario editorial
4. Revisa los borradores antes de publicar

## Cuándo usarla

Úsalo cuando planificas los artículos del blog en una hoja o en Notion y luego pierdes media hora por artículo copiando y pegando en WordPress.

## Cómo ganar dinero con ella

Ahorra 20-30 minutos por artículo. Con 8 artículos al mes son 3-4 horas mensuales, unos 150 € de tu tiempo.

- Publicación de borradores desde hojas de contenido para blogs de empresas que escriben a diario.
- Gestión de blogs de clientes para agencias: del calendario editorial al borrador en WordPress.
- Puesta en marcha de un flujo editorial con revisión humana para pymes con poco tiempo.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada hora mira si hay filas nuevas con el estado «listo» en tu hoja de contenidos, sube la imagen a la biblioteca de medios de WordPress, crea la entrada en borrador con su categoría y sus etiquetas, escribe la URL de edición de vuelta en la hoja y cambia el estado a «publicado en borrador».
Para negocios que hacen contenido con regularidad y agencias que gestionan blogs de clientes.

## Lo que necesitas antes
- WordPress con la REST API activa (viene de serie) y una **contraseña de aplicación**: Usuarios > tu perfil > Contraseñas de aplicación > crear una y copiarla (solo se ve una vez).
- En n8n, credencial de tipo **WordPress** con tu URL, tu usuario y esa contraseña de aplicación.
- Hoja «Calendario editorial» con columnas: `titulo`, `contenido_html`, `categoria`, `etiquetas`, `imagen_url`, `estado`, `url_wp`.
- Credencial de Google Sheets en n8n.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 * * * *` (cada hora).
2. **Google Sheets** (*Get Row(s)*) — hoja «Calendario editorial». En Options usa un filtro: columna `estado` igual a `listo`.
3. **IF** — `{{ $json.titulo }}` *is not empty*.
4. **Split In Batches** — Batch Size `1`.
5. **HTTP Request** («Bajar imagen») — GET `={{ $json.imagen_url }}`, en Options `Response Format: File`. Si la fila no trae imagen, salta este bloque con un IF previo.
6. **HTTP Request** («Subir a medios») — POST a `https://tudominio.es/wp-json/wp/v2/media`, autenticación con la credencial de WordPress (Predefined Credential Type > WordPress), Body Content Type `n8n Binary File`, campo `data`, y cabecera `Content-Disposition: attachment; filename="imagen.jpg"`. Devuelve un `id`.
7. **Code** — traduce el nombre de la categoría a su ID y prepara el cuerpo (código abajo).
8. **HTTP Request** («Crear entrada») — POST a `https://tudominio.es/wp-json/wp/v2/posts` con JSON: `{ "title": ..., "content": ..., "status": "draft", "categories": [id], "tags": [...], "featured_media": id }`.
9. **Google Sheets** (*Update Row*) — escribe `url_wp` con `={{ $json.link }}` y `estado` con `borrador creado`.
10. Vuelve al **Split In Batches**.

## El nodo Code
```javascript
const fila = $('Split In Batches').first().json;
// Rellena este mapa con los IDs reales de tus categorias.
// Los ves en WordPress > Entradas > Categorias, pasando el raton por el nombre: el numero de tag_ID en la URL.
const categorias = { 'Marketing': 5, 'Casos de exito': 8, 'Tutoriales': 12, 'Noticias': 3 };
const idCategoria = categorias[fila.categoria] || 1;
const etiquetas = String(fila.etiquetas || '').split(',').map(e => e.trim()).filter(Boolean);
let media = null;
try { media = $('Subir a medios').first().json.id; } catch (e) { media = null; }
return [{ json: {
  title: fila.titulo,
  content: fila.contenido_html,
  status: 'draft',
  categories: [idCategoria],
  featured_media: media,
  etiquetas_texto: etiquetas.join(', ')
} }];
```

## Cómo probarla
- Rellena una sola fila con estado `listo`, un título de prueba y dos párrafos en HTML. Ejecuta a mano.
- Entra en WordPress > Entradas > Borradores: la entrada debe estar ahí con su imagen destacada y su categoría.
- Comprueba que la hoja se ha actualizado con la URL. Borra el borrador y repite una vez más para asegurarte de que no duplica.
- Deja el estado `listo` solo en las filas de verdad y activa.

## Qué puede salir mal
- **401 Unauthorized**: casi siempre es la contraseña de aplicación mal copiada (lleva espacios que sí cuentan) o un plugin de seguridad que bloquea la REST API. Comprueba abriendo `https://tudominio.es/wp-json/wp/v2/posts` en el navegador.
- **Duplicados**: si el nodo de Update Row falla, la fila sigue en `listo` y a la hora siguiente se crea otra entrada. Pon el Update Row antes del Create si te preocupa, o añade un IF que compruebe si `url_wp` ya tiene contenido.
- **Etiquetas nuevas**: la API espera IDs, no nombres. Si quieres crear etiquetas sobre la marcha, añade un HTTP Request previo a `/wp-json/wp/v2/tags` que las busque o las cree.
- **HTML que WordPress se come**: el editor de bloques reformatea HTML pegado. Si el resultado sale raro, envuelve cada párrafo en `<!-- wp:paragraph --><p>...</p><!-- /wp:paragraph -->`.
- **Imágenes muy grandes**: si la imagen pesa más de lo que permite tu hosting (típico 8 MB), el nodo falla. Redúcelas antes o sube el límite en el `php.ini`.

## Cuánto cuesta
- Todo gratis: WordPress, Sheets y la REST API no cobran.
- n8n auto-alojado 0 €. En n8n.cloud, 24 ejecuciones al día caben en un plan básico.
- Siempre en **borrador**: la revisión humana antes de publicar no te la quita nadie, y es lo que evita el desastre.
