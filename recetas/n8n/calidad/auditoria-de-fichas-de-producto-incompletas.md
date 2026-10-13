# Auditoría de fichas de producto incompletas…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Revisa todo tu catálogo cada semana y te lista las fichas sin foto, con descripción demasiado corta, sin precio, sin stock o sin texto SEO.

## Qué es y qué hace

Cada semana descarga los productos de WooCommerce o Shopify por su API, les aplica comprobaciones de foto, descripción mínima, precio, stock y texto SEO, y escribe en una hoja los que fallan con el motivo y el enlace de edición. Entrada: API de la tienda; salida: hoja de incidencias. Se monta en n8n y solo cambia el nodo que trae los datos según la plataforma.

## Cómo usarla

1. Crea la clave de API de WooCommerce con permiso de lectura o la app privada de Shopify
2. Prepara la hoja Auditoría catálogo
3. Define las reglas en el nodo Code
4. Programa el miércoles a las 5:00

## Cuándo usarla

Cuando tienes más de 30 productos y ya no puedes revisarlos a mano, o cuando has importado un catálogo de un proveedor y no te fías.

## Cómo ganar dinero con ella

Una ficha sin foto o sin descripción no vende. Detectar 20 fichas flojas y arreglarlas es la forma más barata de subir la conversión sin gastar en anuncios.

- Auditoría semanal de catálogo para una tienda con más de treinta productos.
- Revisión de fichas importadas de proveedor antes de publicar en WooCommerce.
- Informe de calidad de fichas para una tienda Shopify que quiere subir la conversión.

**Precio orientativo:** 100–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Descarga todos tus productos por la API de tu tienda, les pasa una lista de comprobaciones y escribe en una hoja los que suspenden, con el motivo y el enlace para editarlo.
Sirve igual para WooCommerce y para Shopify, solo cambia el nodo que trae los datos.

## Lo que necesitas antes
- **WooCommerce**: en tu WordPress, *WooCommerce > Ajustes > Avanzado > API REST > Añadir clave*, permisos de solo *Lectura*. Te da una Consumer Key y una Consumer Secret.
- **Shopify**: en *Configuración > Apps y canales de ventas > Desarrollar apps*, crea una app privada con el permiso `read_products` y copia el Admin API access token.
- Hoja de Google «Auditoría catálogo» con columnas: `fecha`, `id`, `nombre`, `problemas`, `enlace`.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 5 * * 3` (miércoles a las 5:00).
2. **WooCommerce** — *Resource: Product*, *Operation: Get Many*, *Return All* ON. (Si es Shopify: nodo **Shopify** > *Product* > *Get Many* > *Return All* ON.)
3. **Code** («Revisar fichas») — aplica las reglas.
4. **Filter** — condición: `{{ $json.problemas }}` **is not empty**.
5. **Google Sheets** — *Append or Update Row*, columna de coincidencia `id`, para que no se dupliquen semana a semana.
6. **Code** («Resumen») — cuenta cuántas fichas fallan y por qué motivo.
7. **Gmail** — *Send Message* con el resumen y el enlace a la hoja.

## El código del nodo «Revisar fichas»
```javascript
const salida = [];
for (const item of $input.all()) {
  const p = item.json;
  const problemas = [];
  const desc = (p.description || p.body_html || '').replace(/<[^>]*>/g, '').trim();
  const corta = (p.short_description || '').replace(/<[^>]*>/g, '').trim();
  const imagenes = p.images || [];
  const precio = parseFloat(p.price || p.variants?.[0]?.price || 0);

  if (imagenes.length === 0) problemas.push('sin foto');
  if (imagenes.length === 1) problemas.push('solo 1 foto');
  if (desc.length < 300) problemas.push('descripción corta (' + desc.length + ' caracteres)');
  if (!corta && p.short_description !== undefined) problemas.push('sin descripción breve');
  if (!precio || precio <= 0) problemas.push('sin precio');
  if (p.stock_status === 'outofstock' && p.status === 'publish') problemas.push('agotado pero publicado');
  if (!(p.name || p.title) || (p.name || p.title).length < 15) problemas.push('título demasiado corto');
  if ((p.name || p.title || '').toUpperCase() === (p.name || p.title || '')) problemas.push('título en mayúsculas');
  if (!(p.categories || []).length && !(p.product_type)) problemas.push('sin categoría');
  if ((p.tags || []).length === 0) problemas.push('sin etiquetas');

  salida.push({ json: {
    fecha: new Date().toISOString().slice(0,10),
    id: p.id,
    nombre: p.name || p.title || '',
    problemas: problemas.join(' | '),
    enlace: p.permalink || ('https://tutienda.es/wp-admin/post.php?post=' + p.id + '&action=edit')
  }});
}
return salida;
```

## Cómo probarla
- Ejecuta con *Test workflow* y mira la tabla de salida del Code: deberías reconocer al momento un par de fichas que sabes que están flojas.
- Ajusta los umbrales a tu criterio: si vendes camisetas, 300 caracteres puede ser mucho; si vendes maquinaria, poco.
- Quita a mano la foto de un producto de prueba y vuelve a ejecutar para confirmar que lo detecta.

## Qué puede salir mal
- **Timeout con catálogos grandes**: con más de 500 productos, quita el *Return All* y usa paginación con **Split In Batches** de 100, o filtra por `after` (fecha de modificación) para revisar solo lo nuevo.
- **La API de WooCommerce va lenta** en hostings compartidos: baja el tamaño de página a 50 y ejecútalo de madrugada.
- **Duplicados en la hoja**: por eso se usa *Append or Update* con `id` como clave, no *Append*.
- **Productos variables**: el precio vive en las variaciones, no en el padre. Si usas variables, comprueba `p.variations.length > 0` en vez del precio.
- **Descripciones con HTML**: el código ya limpia las etiquetas antes de contar caracteres, para no engañarte con un `<div>` gigante.

## Cuánto cuesta
- Gratis: la API de WooCommerce y la de Shopify (para tu propia tienda) no cuestan nada.
- Google Sheets gratis.
- En n8n auto-alojado sale a coste cero. En Make, un catálogo de 300 productos gasta unas 300 operaciones por ejecución: con una vez al mes cabe en el plan gratuito, semanalmente no.
