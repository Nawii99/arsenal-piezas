# Cuadre de precios entre tu hoja y tu web…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Compara cada noche los precios y el stock que tienes en tu hoja de cálculo maestra con lo que muestra realmente tu web, y te canta las diferencias.

## Qué es y qué hace

Cada noche lee en Google Sheets el precio y el stock correctos de cada producto, visita su ficha web y extrae el precio publicado de los datos JSON-LD. Si hay diferencia, avisa por Telegram o correo con el enlace, el precio correcto y el publicado. Entrada: hoja Maestro precios y fichas web; salida: lista de diferencias. Se monta en n8n.

## Cómo usarla

1. Crea la hoja Maestro precios con sku, url y precio
2. Comprueba que tus fichas tienen JSON-LD
3. Que lo revise un profesional

## Cuándo usarla

Cuando gestionas precios en una hoja o en el TPV y la web es otro mundo, o cuando sincronizas con un proveedor y no te fías del resultado.

## Cómo ganar dinero con ella

Vender a un precio antiguo por error puede costarte el margen entero de esos pedidos. Detectarlo en 24 horas en vez de a fin de mes salva bastantes euros.

- Control de precios entre hoja y tienda para un comercio con cientos de referencias.
- Cuadre de stock y precio tras una sincronización con un proveedor.
- Auditoría nocturna de precios para una tienda que cambia ofertas cada semana.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Tu hoja de cálculo es la verdad. El flujo lee cada fila, visita la ficha del producto en tu web, extrae el precio real de la página y compara.
Si hay diferencia, te lo dice con el enlace, el precio que debería ser y el que hay.

## Lo que necesitas antes
- Una hoja de Google «Maestro precios» con columnas: `sku`, `nombre`, `url`, `precio_correcto`, `stock_correcto`.
- Credencial de Google Sheets en n8n.
- Que tus fichas de producto tengan datos estructurados JSON-LD (WooCommerce, Shopify y PrestaShop los ponen por defecto; puedes comprobarlo buscando `"@type":"Product"` en el código fuente de una ficha).
- Bot de Telegram o correo.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 23 * * *`, `Timezone` `Europe/Madrid`.
2. **Google Sheets** — *Get Rows* de «Maestro precios».
3. **Split In Batches** — *Batch Size* 5. Cinco fichas a la vez para no saturar tu hosting.
4. **HTTP Request** — GET `{{ $json.url }}`, *Response Format* `Text`, *Never Error* ON, *Timeout* 20000, y en *Headers* `User-Agent: Mozilla/5.0`.
5. **Code** («Extraer y comparar») — saca el precio del JSON-LD y compara.
6. Conecta de vuelta al **Split In Batches**.
7. **Code** («Juntar diferencias», salida *done*) — recoge todas las diferencias.
8. **IF** — `{{ $json.hayDiferencias }}` is true.
9. **Telegram** — Text `{{ $json.mensaje }}`.
10. **Google Sheets** (opcional) — *Append Row* en una pestaña «Historial descuadres».

## El código del nodo «Extraer y comparar»
```javascript
const salida = [];
const filas = $('Split In Batches').all().map(i => i.json);
const paginas = $input.all();
for (let i = 0; i < paginas.length; i++) {
  const html = paginas[i].json.data || paginas[i].json.body || '';
  const fila = filas[i] || {};
  let precioWeb = null, stockWeb = null;
  const bloques = [...html.matchAll(/<script[^>]*application\/ld\+json[^>]*>([\s\S]*?)<\/script>/g)];
  for (const b of bloques) {
    try {
      const j = JSON.parse(b[1].trim());
      const lista = Array.isArray(j) ? j : (j['@graph'] || [j]);
      for (const nodo of lista) {
        if (nodo['@type'] === 'Product') {
          const of = Array.isArray(nodo.offers) ? nodo.offers[0] : nodo.offers;
          if (of) { precioWeb = parseFloat(of.price); stockWeb = (of.availability || '').includes('InStock'); }
        }
      }
    } catch (e) {}
  }
  const esperado = parseFloat(String(fila.precio_correcto).replace(',', '.'));
  const difPrecio = precioWeb !== null && Math.abs(precioWeb - esperado) > 0.01;
  const difStock = fila.stock_correcto !== undefined && String(fila.stock_correcto).toLowerCase() === 'si' && stockWeb === false;
  if (precioWeb === null) salida.push({ json: { aviso: '⚠️ ' + fila.nombre + ': no he podido leer el precio en ' + fila.url } });
  else if (difPrecio) salida.push({ json: { aviso: '💶 ' + fila.nombre + ': la web dice ' + precioWeb + ' € y debería ser ' + esperado + ' € → ' + fila.url } });
  if (difStock) salida.push({ json: { aviso: '📦 ' + fila.nombre + ': figura agotado en la web y debería estar disponible' } });
}
return salida;
```

## El código del nodo «Juntar diferencias»
```javascript
const avisos = $input.all().map(i => i.json.aviso).filter(Boolean);
return [{ json: {
  hayDiferencias: avisos.length > 0,
  mensaje: 'Cuadre de precios ' + new Date().toLocaleDateString('es-ES') + ' — ' + avisos.length + ' incidencias:\n' + avisos.join('\n')
} }];
```

## Cómo probarla
- Pon en la hoja un precio distinto a propósito para un producto y ejecuta: debe avisarte de ese y solo de ese.
- Comprueba con dos o tres fichas primero: filtra la hoja a 3 filas antes de lanzarlo entero.
- Verifica que el precio que saca es el de venta y no el tachado antes de descuento: si tu tema mete varios precios, quédate con el del JSON-LD, que es el bueno.

## Qué puede salir mal
- **La web carga el precio con JavaScript** y no está en el HTML: prueba a leer la API de la tienda en vez de la página (`/wp-json/wc/store/products?slug=...` en WooCommerce, que es pública y no necesita clave).
- **Precios con IVA o sin IVA**: decide cuál es «el correcto» y sé consistente en la hoja, o guarda las dos columnas.
- **Descuentos programados**: los días de rebajas todo cantará como descuadre. Añade una columna `ignorar_hasta` en la hoja y sáltate esas filas en el Code.
- **Tu hosting te bloquea** por 300 peticiones seguidas: baja el Batch Size a 3 y mete un **Wait** de 2 segundos dentro del bucle.

## Cuánto cuesta
- Gratis con n8n auto-alojado y Google Sheets.
- Un catálogo de 200 productos son 200 peticiones nocturnas: nada para tu servidor si van espaciadas.
- En Make esto serían 200+ operaciones diarias, unas 6.000 al mes: fuera del plan gratuito, unos 10-16 €/mes.
