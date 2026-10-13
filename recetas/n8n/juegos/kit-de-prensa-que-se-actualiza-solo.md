# Kit de prensa que se actualiza solo…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Genera y publica tu página de prensa (descripción, capturas, GIFs, logos, datos) cada vez que cambias algo en una hoja o en una carpeta de Drive.

## Qué es y qué hace

Flujo de n8n que cada noche lee de Google Sheets los datos del juego (título, estudio, fecha, precio, plataformas, descripciones y tráiler) y las imágenes de las carpetas de Drive. Genera una página HTML estática con todo, la publica en GitHub Pages y deja un ZIP con los materiales. Entran la hoja y las carpetas de capturas, GIFs y logos; sale un enlace único siempre actualizado. Requiere cuentas de Google, GitHub y n8n.

## Cómo usarla

1. 1. Rellena la hoja kit con los datos del juego
2. 2. Sube capturas, GIFs y logos a las carpetas de Drive
3. 3. Activa GitHub Pages en el repositorio kit-prensa

## Cuándo usarla

Úsalo cuando te piden material de prensa cada dos por tres, mandas ZIPs por correo y nunca sabes si el periodista tiene la versión buena de las capturas y del texto.

## Cómo ganar dinero con ella

Ahorra 2-3 horas por cada envío a prensa y evita que salga publicada una captura vieja de hace tres builds.

- Página de prensa actualizada para estudios pequeños que mandan el juego a periodistas, creadores y festivales.
- Kit digital para editoras que reciben peticiones de material cada semana y quieren un enlace fijo.
- Mantenimiento de kit de prensa por suscripción para desarrolladores que lanzan varios juegos al año.

**Precio orientativo:** 150–350 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Coges una hoja con los datos del juego (título, estudio, fecha, precio, plataformas, descripción corta y larga, tráiler) y una carpeta de Drive con capturas, GIFs y logos. Cada noche n8n genera una página HTML estática con todo, la sube a GitHub Pages y deja además un ZIP con todos los materiales listo para descargar. Un enlace único que siempre está al día.
Para estudios pequeños que mandan el juego a prensa, creadores y festivales.

## Lo que necesitas antes
- n8n.
- Hoja de Google «kit» con dos columnas: campo y valor (filas: titulo, estudio, fecha_lanzamiento, precio, plataformas, descripcion_corta, descripcion_larga, trailer_youtube, contacto, redes).
- Carpeta de Drive «prensa» con subcarpetas «capturas», «gifs», «logos». Compártela como «cualquiera con el enlace puede ver».
- Repositorio de GitHub público llamado por ejemplo `kit-prensa` con GitHub Pages activado (Settings → Pages → rama main, carpeta raíz). Token de GitHub con permiso `repo`.
- Opcional: dominio propio apuntando a las Pages.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 3 * * *` (cada noche a las 3:00). Añade también un **Webhook** por si quieres forzarlo a mano.
2. **Google Sheets** («Get Row(s)», hoja «kit») — Trae los pares campo/valor.
3. **Google Drive** («Search Files/Folders») x3 — Una búsqueda por subcarpeta: capturas, gifs, logos. Marca «Return All».
4. **Merge** — Junta los datos y los listados de archivos.
5. **Code** — Monta el HTML completo de la página (código abajo).
6. **Convert to File** («Move Base64 String to File» o «Text to File») — Convierte el HTML en un archivo `index.html`.
7. **GitHub** («Create or Update a File») — Repositorio `kit-prensa`, ruta `index.html`, mensaje de commit `Kit actualizado {{ $now.toISO() }}`. Este nodo sobrescribe si el archivo ya existe.
8. **Compression** («Compress») — Empaqueta las capturas descargadas en `materiales.zip`.
9. **Google Drive** («Upload File») — Sube el ZIP a la carpeta «prensa» reemplazando el anterior.
10. **Gmail** (opcional) — Aviso a tu equipo: «Kit de prensa actualizado: https://tuusuario.github.io/kit-prensa/».

## El nodo Code que genera la página
```javascript
const datos = {};
for (const f of $('Google Sheets').all()) datos[f.json.campo] = f.json.valor;
const url = id => 'https://drive.google.com/uc?export=view&id=' + id;
const capturas = $('capturas').all().map(i => i.json.id);
const logos = $('logos').all().map(i => i.json.id);
const yt = (datos.trailer_youtube || '').split(/v=|youtu\.be\//)[1] || '';
const html = `<!doctype html><html lang="es"><meta charset="utf-8">
<title>Kit de prensa - ${datos.titulo}</title>
<style>body{font-family:system-ui;max-width:900px;margin:0 auto;padding:24px;background:#101014;color:#eee}
img{width:100%;border-radius:8px;margin:8px 0}.grid{display:grid;grid-template-columns:1fr 1fr;gap:12px}
a{color:#7cf}table{width:100%;border-collapse:collapse}td{padding:6px;border-bottom:1px solid #333}</style>
<h1>${datos.titulo}</h1><p>${datos.descripcion_corta}</p>
${yt ? `<iframe width="100%" height="420" src="https://www.youtube.com/embed/${yt}" frameborder="0" allowfullscreen></iframe>` : ''}
<h2>Datos</h2><table>
<tr><td>Estudio</td><td>${datos.estudio}</td></tr>
<tr><td>Lanzamiento</td><td>${datos.fecha_lanzamiento}</td></tr>
<tr><td>Precio</td><td>${datos.precio}</td></tr>
<tr><td>Plataformas</td><td>${datos.plataformas}</td></tr>
<tr><td>Contacto</td><td>${datos.contacto}</td></tr></table>
<h2>Sobre el juego</h2><p>${(datos.descripcion_larga || '').replace(/\n/g, '</p><p>')}</p>
<h2>Capturas</h2><div class="grid">${capturas.map(id => `<img src="${url(id)}" loading="lazy">`).join('')}</div>
<h2>Logos</h2><div class="grid">${logos.map(id => `<img src="${url(id)}">`).join('')}</div>
<p><small>Actualizado el ${new Date().toLocaleDateString('es-ES')}</small></p></html>`;
return [{ json: { html } }];
```

## Cómo probarla
- Ejecuta a mano y abre `https://tuusuario.github.io/kit-prensa/`. GitHub Pages tarda 1-2 minutos en refrescar.
- Si las imágenes salen rotas, es porque la carpeta de Drive no está compartida públicamente: cámbiala a «cualquiera con el enlace».
- Cambia una fila de la hoja (por ejemplo el precio), vuelve a ejecutar y comprueba que la página lo refleja.

## Qué puede salir mal
- **Drive como CDN**: si el kit se hace muy popular, Drive limita las descargas. Para capturas pesadas, súbelas directamente al repositorio de GitHub (nodo GitHub «Create or Update a File» con el binario) y sirve desde Pages.
- **Comillas en los textos**: si en la descripción metes comillas o `<`, pueden romper el HTML. Escapa el texto con una función simple antes de insertarlo.
- **Commits cada noche aunque no cambie nada**: añade un **IF** que compare un hash del HTML con el último guardado y solo suba si es distinto.
- **Materiales sin permiso**: no metas música o fuentes con licencia que no permita redistribución.

## Cuánto cuesta
0 €: GitHub Pages es gratis para repositorios públicos, Drive y Sheets gratis, n8n auto-alojado gratis. Solo pagarías un dominio propio (unos 10 €/año) si quieres una URL bonita en vez de la de github.io.
