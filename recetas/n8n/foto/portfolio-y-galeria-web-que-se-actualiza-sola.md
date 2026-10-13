# Portfolio y galería web que se actualiza sola…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Marcas una foto como destacada en Drive y en cinco minutos aparece publicada en tu web, optimizada y con su descripción.

## Qué es y qué hace

Una carpeta de Drive organizada por categorías se revisa cada 30 minutos. Las fotos nuevas se suben a Cloudinary en varios tamaños, se genera un fichero galeria.json y se sube al repositorio de GitHub donde está publicada tu web. La web lee ese JSON y se actualiza sin tocar código. Entran fotos de Drive y sale una galería actualizada, con n8n, Cloudinary y GitHub Pages.

## Cómo usarla

1. Publica tu web en GitHub Pages
2. Crea un token de GitHub con el permiso mínimo
3. Conecta Drive y Cloudinary en n8n
4. Revisa la primera actualización en la web

## Cuándo usarla

Úsalo cuando tienes trabajo nuevo estupendo pero tu web sigue enseñando fotos de hace dos años porque actualizarla es un engorro.

## Cómo ganar dinero con ella

Evita 200-400 € al año de mantenimiento web o las horas que le dedicas tú, y mantiene el portfolio vendiendo siempre lo último.

- Montaje de portfolio que se actualiza solo para fotógrafos e ilustradores, cobrado por puesta en marcha.
- Mantenimiento mensual del portfolio y actualización de galerías para creativos, por cuota.
- Plantilla de galería automática vendida a estudios que no quieren pagar hosting cada mes.

**Precio orientativo:** 200–400 € por puesta en marcha. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Tienes una carpeta `PORTFOLIO` en Drive con subcarpetas por categoría (`bodas`, `producto`, `retrato`). Cada 30 minutos el flujo mira si hay novedades, sube las fotos a Cloudinary en varios tamaños, genera un fichero `galeria.json` y lo sube a tu repositorio de GitHub. Tu web lee ese JSON y se pinta sola, sin tocar código.
Para fotógrafos e ilustradores con web propia sencilla, alojada gratis en GitHub Pages, Netlify o Cloudflare Pages.

## Lo que necesitas antes
- Repositorio de GitHub con tu web publicada en GitHub Pages. Si no la tienes, un `index.html` en un repo público y activar Pages en Settings > Pages ya te da una URL.
- Token de GitHub: Settings > Developer settings > Personal access tokens > Fine-grained, con permiso `Contents: Read and write` sobre ese repo.
- Cuenta gratuita de Cloudinary con `Cloud name`, `API Key` y `API Secret`.
- Carpeta de Drive `PORTFOLIO` con una subcarpeta por categoría. El nombre del archivo se usará como título, así que llámalos bien: `Boda en el Monasterio de Piedra.jpg`.
- Una hoja `Portfolio Publicado` con columnas `drive_id`, `categoria`, `titulo`, `url`, `fecha`, para llevar la cuenta de lo ya subido.

## Los nodos, en orden
1. **Schedule Trigger** — cada 30 minutos.
2. **Google Drive** — Operation `Search`, carpeta `PORTFOLIO`, con la opción de buscar en subcarpetas activada. Filtro `mimeType contains 'image/'`.
3. **Google Sheets** — `Get Row(s)` de `Portfolio Publicado`.
4. **Code** (`Solo las nuevas`) — descarta las que ya están publicadas. Código abajo.
5. **IF** — si no hay nuevas, para el flujo aquí.
6. **Split In Batches** — Batch Size: 1.
7. **Google Drive** — `Download`.
8. **HTTP Request** (`Subir a Cloudinary`) — igual que en la receta de marca de agua: `POST` a `https://api.cloudinary.com/v1_1/TU_CLOUD/image/upload`, Basic Auth con Key y Secret, Body `n8n Binary File` campo `data`, y parámetro `folder` con `portfolio`.
9. **Google Sheets** — `Append Row` con el `public_id` y la categoría.
10. **Google Sheets** — `Get Row(s)` otra vez, ya con todo dentro, para tener la lista completa.
11. **Code** (`Montar el JSON`) — construye el fichero de la galería. Código abajo.
12. **HTTP Request** (`Guardar en GitHub`) — `PUT` a `https://api.github.com/repos/TU_USUARIO/TU_REPO/contents/galeria.json`. Headers: `Authorization` = `Bearer TU_TOKEN`, `Accept` = `application/vnd.github+json`, `User-Agent` = `n8n`. Body JSON: `{"message": "Actualizar galeria", "content": "={{ $json.contenido_b64 }}", "sha": "={{ $json.sha }}"}`.

## El código del nodo Solo las nuevas
```javascript
const publicadas = $('Google Sheets').all().map(i => String(i.json.drive_id));
const nuevas = $('Google Drive').all().filter(i => !publicadas.includes(String(i.json.id)));
return nuevas.map(i => ({ json: {
  id: i.json.id,
  titulo: i.json.name.replace(/\.[^.]+$/, ''),
  categoria: (i.json.parents && i.json.parents[0]) ? i.json.parents[0] : 'general'
}}));
```

## El código del nodo Montar el JSON
```javascript
const cloud = 'TU_CLOUD_NAME';
const base = `https://res.cloudinary.com/${cloud}/image/upload`;
const fotos = $input.all().map(i => i.json).filter(f => f.url);
fotos.sort((a,b) => new Date(b.fecha) - new Date(a.fecha));
const galeria = fotos.map(f => ({
  titulo: f.titulo,
  categoria: f.categoria,
  miniatura: `${base}/c_fill,g_auto,w_600,h_600,q_auto,f_auto/${f.url}`,
  grande:    `${base}/c_limit,w_2000,q_auto:good,f_auto/${f.url}`,
  fecha: f.fecha
}));
const texto = JSON.stringify({ actualizado: new Date().toISOString(), total: galeria.length, fotos: galeria }, null, 2);
return { json: { contenido_b64: Buffer.from(texto, 'utf8').toString('base64') } };
```

## El HTML que lee el JSON (pégalo en tu web)
```html
<div id="galeria" style="display:grid;grid-template-columns:repeat(auto-fill,minmax(240px,1fr));gap:12px"></div>
<script>
fetch('galeria.json?v=' + Date.now()).then(r => r.json()).then(d => {
  document.getElementById('galeria').innerHTML = d.fotos.map(f =>
    `<a href="${f.grande}" target="_blank"><img src="${f.miniatura}" alt="${f.titulo}" loading="lazy" style="width:100%;display:block;border-radius:6px"></a>`
  ).join('');
});
</script>
```

## Cómo probarla
- Sube una foto a `PORTFOLIO/bodas` y ejecuta a mano. Comprueba que aparece en Cloudinary, luego en la hoja, y por último que el `galeria.json` de GitHub cambió.
- Recarga tu web con Ctrl+F5. Si no ves la foto nueva, es caché: el `?v=` del fetch ya lo evita, pero GitHub Pages tarda un par de minutos en publicar.
- Prueba a quitar una foto de Drive: no desaparecerá de la web. Para eso hace falta borrar también su fila en la hoja; hazlo a mano, es más seguro.

## Qué puede salir mal
- **El PUT de GitHub falla con 409 o 422.** Es porque falta el `sha` del fichero actual. Añade antes un **HTTP Request** `GET` a la misma URL de contents que te devuelve el `sha`, y actívale `Never Error` para la primera vez, cuando el fichero aún no existe.
- **La categoría sale como un ID de carpeta.** El campo `parents` devuelve el ID, no el nombre. Añade un **Google Drive** con Operation `Get Folder` para traducirlo, o más simple: nombra los archivos con prefijo `bodas--titulo.jpg` y parte por `--` en el Code.
- **Fotos gigantes.** Cloudinary con `q_auto,f_auto` sirve WebP o AVIF según el navegador y baja mucho el peso. No subas tú versiones optimizadas, deja que lo haga él.
- **Repositorio público.** Si el repo es público, cualquiera ve el JSON. No pasa nada: son fotos de portfolio. No metas ahí nada privado.

## Cuánto cuesta
- GitHub Pages: gratis, con dominio propio incluido.
- Cloudinary gratis: 25 créditos al mes, de sobra para un portfolio.
- n8n auto-alojado, Drive y Sheets: 0 €.
- Un servicio equivalente tipo Pixieset o SmugMug cuesta de 8 a 30 €/mes.
