# Cazador de enlaces rotos y páginas caídas de tu web…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Una vez por semana recorre todas las URLs de tu sitemap, busca 404 y enlaces rotos dentro de las páginas y te deja el listado ordenado en una hoja.

## Qué es y qué hace

Cada semana lee el sitemap de tu web, visita cada página, extrae sus enlaces y comprueba cuáles devuelven error. Escribe en una hoja la página de origen, el enlace roto y el código de respuesta. Entrada: sitemap.xml; salida: hoja de enlaces rotos. Se monta en n8n con HTTP Request, un nodo XML y Google Sheets, o con un rastreador equivalente en Make o Zapier.

## Cómo usarla

1. Localizar el sitemap de tu web
2. Crear la hoja Enlaces rotos
3. Probar con diez páginas
4. Programar la revisión semanal

## Cuándo usarla

Úsalo cuando tengas web con blog o catálogo con más de 20 páginas, o después de una migración, un cambio de plantilla o una limpieza de productos.

## Cómo ganar dinero con ella

Los 404 tiran el SEO y hacen que la gente se vaya. Una auditoría manual con herramienta de pago cuesta 100-300 €; esto la hace sola cada semana.

- Auditar webs de blog o catálogo grandes para pymes, cobrando por revisión.
- Ofrecer la limpieza de enlaces rotos tras migraciones de web.
- Montar un control mensual de enlaces para una tienda con muchos productos.

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee tu `sitemap.xml`, visita todas las páginas, extrae todos los enlaces que hay dentro y comprueba uno a uno cuáles devuelven error. El resultado va a una hoja de Google con la página donde está el enlace roto y el destino que falla.
Para dueños de webs con blog, catálogo o directorio que no quieren pagar una herramienta SEO solo para esto.

## Lo que necesitas antes
- n8n.
- Tu sitemap: normalmente `https://tudominio.es/sitemap.xml` o `/sitemap_index.xml` si usas Yoast o RankMath. Ábrelo en el navegador y confírmalo.
- Una hoja de Google Sheets «Enlaces rotos» con columnas: fecha, pagina_origen, enlace_roto, codigo.
- Credencial «Google Sheets OAuth2» en n8n.

## Los nodos, en orden
1. **Schedule Trigger** — Days, Trigger at Day of Week: Monday, Hour: 6.
2. **HTTP Request** — GET a tu sitemap. Options > Response > Response Format: Text.
3. **XML** — Mode: XML to JSON, Property Name: data.
4. **Code** (nombre: «URLs del sitemap»). Run Once for All Items. Aplana el sitemap (solo lee sitemaps de páginas con `urlset`; si tu web usa un índice de sitemaps, apunta al sitemap concreto de páginas, por ejemplo `post-sitemap.xml`).
```js
const d = $input.first().json.data;
const nodos = d.urlset?.url || [];
const urls = (Array.isArray(nodos) ? nodos : [nodos]).map(u => (typeof u.loc === 'string' ? u.loc : u.loc?._));
return urls.filter(Boolean).map(u => ({ json: { pagina: u } }));
```
5. **Split In Batches** (en n8n nuevo se llama «Loop Over Items») — Batch Size: 5. Así no machacas tu servidor.
6. **HTTP Request** (nombre: «Descargar página») — GET `={{ $json.pagina }}`, Response Format: Text, Never Error: on, Timeout: 20000.
7. **Code** (nombre: «Extraer enlaces»). Run Once for Each Item.
```js
const html = $json.data || '';
const origen = $('Loop Over Items').item.json.pagina;
const base = new URL(origen).origin;
const encontrados = [...html.matchAll(/href=["']([^"'#]+)["']/gi)].map(m => m[1]);
const limpios = [...new Set(encontrados)]
  .filter(h => !h.startsWith('mailto:') && !h.startsWith('tel:') && !h.startsWith('javascript:'))
  .map(h => h.startsWith('http') ? h : (h.startsWith('/') ? base + h : origen.replace(/\/[^/]*$/, '/') + h));
return limpios.map(l => ({ json: { origen, enlace: l } }));
```
8. **Remove Duplicates** — Compare: Selected Fields, Fields to Compare: enlace. Operation: Remove Items Seen in Previous Executions si quieres memoria entre semanas (o déjalo por ejecución).
9. **HTTP Request** (nombre: «Comprobar enlace») — Method: HEAD, URL `={{ $json.enlace }}`, Never Error: on, Include Response Status: on, Timeout: 15000, Batching > Items per Batch: 5, Batch Interval: 1000 ms.
10. **IF** — Number: `={{ $json.statusCode }}` >= 400 (marca también los 0, que son enlaces que ni resuelven).
11. **Google Sheets** — Append Row a «Enlaces rotos» con fecha `={{ $now.format('yyyy-LL-dd') }}`, origen, enlace y código.
12. Vuelve el flujo al nodo **Loop Over Items** para la siguiente tanda; en su salida «done» pon un **Gmail** con el resumen: `=Auditoría semanal: {{ $items().length }} enlaces rotos. Míralos en la hoja.`

## Cómo probarla
Ejecuta a mano con un sitemap pequeño primero (o limita el paso 4 con `.slice(0,10)`). Mete a propósito un enlace a `https://tudominio.es/no-existe-123` en una entrada del blog y comprueba que aparece en la hoja.

## Qué puede salir mal
- **Webs que no aceptan HEAD** y devuelven 405: cambia el método a GET con Options > Response > Response Format: Text y ya está (gasta más datos, nada más).
- **Enlaces a redes sociales que devuelven 403** (LinkedIn, Instagram bloquean bots): añade en el paso 7 un filtro que descarte dominios en una lista de ignorados.
- **Tarda muchísimo**: sube el Batch Size a 10 y quédate solo con enlaces internos (`l.startsWith(base)`), que son los que de verdad puedes arreglar.
- **Te capa tu propio hosting**: espacia con Batch Interval 2000 ms y lánzalo de madrugada.

## Cuánto cuesta
Gratis con n8n auto-alojado y Sheets. En n8n Cloud cuidado: cada enlace comprobado no cuenta como ejecución (solo cuenta el workflow entero), así que una vez por semana son 4 ejecuciones al mes, dentro incluso del plan pequeño.
