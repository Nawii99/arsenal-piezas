# Cazador de imágenes pesadas en tu web…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Rastrea tu web cada semana, encuentra las imágenes que pesan de más, las comprime y te deja las versiones optimizadas listas para sustituir.

## Qué es y qué hace

Cada lunes lee el sitemap de tu web, saca todas las imágenes de cada página y mide su peso. Las que pasan del límite, por ejemplo 200 KB, las comprime con TinyPNG y deja en una hoja la lista ordenada, el ahorro conseguido y el enlace a la versión ligera. Entran URLs de sitemap y salen auditorías y versiones comprimidas. Para tiendas online y webs de servicios, con n8n.

## Cómo usarla

1. Localiza el sitemap de tu web
2. Consigue la clave gratuita de TinyPNG
3. Monta el rastreo semanal en n8n
4. Sustituye las imágenes por las versiones optimizadas

## Cuándo usarla

Úsalo cuando tu web tarda en cargar, Google te avisa de rendimiento móvil, o subiste fotos directamente de la cámara a la tienda.

## Cómo ganar dinero con ella

Un segundo menos de carga sube la conversión entre un 5 y un 10%. En una tienda de 3.000 €/mes son 150-300 € más al mes.

- Auditoría de imágenes pesadas para tiendas online, entregada con lista priorizada y versiones comprimidas.
- Revisión mensual de rendimiento de imágenes para webs de clientes, cobrada por cuota.
- Plantilla de auditoría vendida a diseñadores web que entregan sitios con fotos de cámara.

**Precio orientativo:** 150–300 € por auditoría. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada lunes rastrea las páginas de tu sitio a partir del sitemap, saca todas las imágenes, mide cuánto pesa cada una, y las que superan tu límite (por ejemplo 200 KB) las pasa por un compresor. Te deja en una hoja la lista ordenada por peso, el ahorro conseguido y el enlace a la versión ligera.
Para dueños de tiendas online, webs de servicios y portfolios que no tienen quien les mantenga el sitio.

## Lo que necesitas antes
- La URL de tu sitemap, normalmente `https://tudominio.com/sitemap.xml` o `sitemap_index.xml`.
- Clave gratuita de TinyPNG: tinify.com/developers. Da 500 compresiones al mes gratis.
- Hoja `Auditoria Imagenes` con columnas: `fecha`, `pagina`, `url_imagen`, `kb_antes`, `kb_despues`, `ahorro_pct`, `url_optimizada`.
- Carpeta de Drive `IMAGENES-OPTIMIZADAS`.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 8 * * 1`, los lunes a las 8.
2. **HTTP Request** (`Leer sitemap`) — `GET` a tu sitemap. Response Format `Text`.
3. **Code** (`Sacar URLs`) — extrae las direcciones del XML. Código abajo.
4. **Split In Batches** — Batch Size: 3. Y detrás un **Wait** de 2 segundos: no machaques tu propio servidor.
5. **HTTP Request** (`Bajar página`) — `GET` a `{{ $json.url }}`, Response Format `Text`. En Options activa `Ignore SSL Issues` solo si tu certificado da guerra.
6. **Code** (`Encontrar imágenes`) — saca los `src` y `srcset` del HTML. Código abajo.
7. **HTTP Request** (`Medir peso`) — Method `HEAD`, URL `{{ $json.url_imagen }}`. Activa `Include Response Headers and Status` y `Never Error` en Options, para que un 404 no rompa la ejecución.
8. **Code** (`Filtrar pesadas`) — se queda con las que pasan de 200 KB. Código abajo.
9. **HTTP Request** (`Comprimir`) — Method `POST`, URL `https://api.tinify.com/shrink`. Authentication `Basic Auth`: usuario `api`, contraseña tu clave. Body JSON: `{"source": {"url": "={{ $json.url_imagen }}"}}`.
10. **HTTP Request** (`Descargar comprimida`) — `GET` a `{{ $json.output.url }}`, Response Format `File`.
11. **Google Drive** — `Upload` a `IMAGENES-OPTIMIZADAS`.
12. **Google Sheets** — `Append Row` con la fila del informe.
13. **Gmail** — resumen: cuántas imágenes, cuántos MB de ahorro total.

## El código del nodo Sacar URLs
```javascript
const xml = $json.data || $json.body || '';
const urls = [...xml.matchAll(/<loc>(.*?)<\/loc>/g)].map(m => m[1].trim());
// Si es un indice de sitemaps, quedate solo con los .xml para una segunda vuelta
const paginas = urls.filter(u => !u.endsWith('.xml'));
return paginas.slice(0, 100).map(url => ({ json: { url } }));
```

## El código del nodo Encontrar imágenes
```javascript
const html = $json.data || '';
const pagina = $('Split In Batches').item.json.url;
const base = new URL(pagina).origin;
const encontradas = new Set();
for (const m of html.matchAll(/<img[^>]+src=["']([^"']+)["']/gi)) {
  let u = m[1];
  if (u.startsWith('//')) u = 'https:' + u;
  else if (u.startsWith('/')) u = base + u;
  if (/\.(jpe?g|png|webp)(\?|$)/i.test(u)) encontradas.add(u.split('?')[0]);
}
return [...encontradas].map(url_imagen => ({ json: { pagina, url_imagen } }));
```

## El código del nodo Filtrar pesadas
```javascript
const LIMITE_KB = 200;
const salida = [];
for (const it of $input.all()) {
  const h = it.json.headers || {};
  const bytes = parseInt(h['content-length'] || '0', 10);
  const kb = Math.round(bytes / 1024);
  if (kb > LIMITE_KB) {
    salida.push({ json: { ...it.json, kb_antes: kb, fecha: new Date().toISOString().slice(0,10) } });
  }
}
salida.sort((a,b) => b.json.kb_antes - a.json.kb_antes);
return salida.slice(0, 40); // el limite gratuito de TinyPNG es 500 al mes
```

## Cómo probarla
- Ejecuta primero solo hasta el paso 8 y mira la lista. Si sale vacía, enhorabuena, tu web ya está fina. Si salen 200 imágenes de 3 MB, ahí tienes el problema.
- Comprime una sola y compárala visualmente al 100% con la original antes de fiarte del proceso.
- Sustituye las imágenes en tu web a mano la primera vez para ver el efecto en PageSpeed Insights.

## Qué puede salir mal
- **Web hecha en JavaScript.** Si es un React o similar, el HTML plano no trae las imágenes. Ahí necesitas un servicio de renderizado como ScrapingBee o Browserless en el paso 5.
- **Cloudflare te bloquea.** Añade en Headers un `User-Agent` de navegador normal y baja la velocidad con el Wait.
- **`content-length` vacío.** Algunos servidores no lo mandan. En ese caso cambia el HEAD por un GET con Response Format `File` y mira el tamaño del binario.
- **No sustituye las imágenes solo.** Esta receta audita y comprime. Para reemplazar automáticamente en WordPress necesitas la REST API de WP con contraseña de aplicación, y eso conviene hacerlo con calma y copia de seguridad delante.

## Cuánto cuesta
- TinyPNG: 500 compresiones al mes gratis, luego 0,009 $ por imagen.
- n8n autoalojado, Sheets y Drive: gratis (n8n Cloud solo tiene una prueba gratuita temporal y después es de pago).
- Alternativa 100% gratis: monta un contenedor con `imgproxy` o usa el nodo **Edit Image** de n8n con Operation `Resize` y calidad 82.
