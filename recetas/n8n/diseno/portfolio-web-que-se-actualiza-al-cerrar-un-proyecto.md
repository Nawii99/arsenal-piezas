# Portfolio web que se actualiza al cerrar un proyecto…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Marcas un proyecto como publicable en tu hoja y tu web de portfolio se regenera sola con la nueva ficha, sin tocar código ni pagar plataforma.

## Qué es y qué hace

Lee tus proyectos de una hoja de cálculo, genera el HTML de la galería y lo publica en GitHub Pages cuando marcas un proyecto como publicable. Entrada: hoja Portfolio con imágenes en Drive o Cloudinary; salida: web estática actualizada. Es gratis y no tiene cuota de plataforma. Se monta en n8n con un token de GitHub de permisos acotados.

## Cómo usarla

1. Crea el repositorio tunombre.github.io
2. Activa Pages desde la rama main
3. Crea el token fine-grained
4. Marca el primer proyecto como publicable

## Cuándo usarla

Úsalo cuando tienes trabajos buenos sin publicar porque actualizar la web es un rollo, y llevas dos años con el mismo portfolio desactualizado.

## Cómo ganar dinero con ella

Sustituye una web de portfolio de pago (12-25 €/mes) y quita la excusa de no publicar: un portfolio al día trae encargos.

- Portfolio mantenido para diseñadores freelance que quieren publicar cada encargo.
- Web de casos de estudio para agencias pequeñas sin presupuesto de hosting.
- Escaparate de trabajos para estudios que reciben encargos por recomendación.

**Precio orientativo:** 80–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee tus proyectos de una hoja de cálculo, genera el HTML del portfolio con su galería y lo publica en GitHub Pages, que es hosting gratuito. Para diseñadores freelance que quieren un portfolio propio, rápido y sin cuota mensual.

## Lo que necesitas antes
- n8n.
- Google Sheets y Drive por OAuth.
- Cuenta de GitHub. Crea un repositorio público llamado `tunombre.github.io` y activa Pages en Settings > Pages, Source: Deploy from a branch, rama `main`, carpeta `/root`.
- Un token de GitHub: Settings > Developer settings > Personal access tokens > Fine-grained, con permiso Contents: Read and write sobre ese repositorio.
- Hoja «Portfolio» con columnas: `titulo`, `cliente`, `anio`, `disciplina`, `descripcion`, `url_imagen`, `estado`.
- Las imágenes de los proyectos en Drive con permiso Anyone with link, o subidas a Cloudinary.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Hours, cada 6 horas. O un **Webhook** para publicar cuando tú quieras.
2. **Google Sheets** — Get Row(s), hoja «Portfolio», Filters: Lookup Column `estado`, Lookup Value `publicar`.
3. **Code** — Mode: Run Once for All Items. Genera el HTML completo (código abajo).
4. **GitHub** — Resource: File, Operation: Edit (si el archivo ya existe) o Create. Owner y Repository: los tuyos. File Path: `index.html`. File Content: `={{ $json.html }}`. Commit Message: `Portfolio actualizado {{ $now.format('yyyy-MM-dd HH:mm') }}`.
5. **Wait** — 60 segundos, que es lo que tarda GitHub Pages en desplegar.
6. **HTTP Request** — Method: GET, URL `https://tunombre.github.io/`. Sirve de comprobación de que la web responde.
7. **IF** — `{{ $json.statusCode || 200 }}` equals 200.
8. Rama true: **Gmail** — Send a ti: `Portfolio publicado con {{ $('Code').item.json.total }} proyectos: https://tunombre.github.io`.
9. Rama false: **Gmail** — Send: `Fallo al publicar el portfolio, revisa GitHub Pages`.

## El nodo Code
```javascript
const proyectos = $input.all().map(i => i.json);
const tarjetas = proyectos.map(p => `
  <article class="p">
    <img src="${p.url_imagen}" alt="${p.titulo}" loading="lazy">
    <h3>${p.titulo}</h3>
    <p class="meta">${p.cliente} · ${p.disciplina} · ${p.anio}</p>
    <p>${p.descripcion}</p>
  </article>`).join('');
const html = `<!doctype html><html lang="es"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Portfolio</title><style>
*{box-sizing:border-box}body{font-family:Helvetica,Arial,sans-serif;margin:0;background:#fafafa;color:#111}
header{padding:80px 24px;max-width:900px;margin:auto}h1{font-size:clamp(32px,6vw,64px);margin:0}
main{display:grid;gap:32px;grid-template-columns:repeat(auto-fill,minmax(300px,1fr));max-width:1200px;margin:auto;padding:0 24px 80px}
.p img{width:100%;border-radius:12px;display:block;aspect-ratio:4/3;object-fit:cover}
.p h3{margin:14px 0 4px}.meta{color:#777;font-size:13px;margin:0 0 8px}
footer{padding:40px 24px;text-align:center;color:#777}
</style></head><body>
<header><h1>Diseño gráfico y de marca</h1><p>Proyectos seleccionados. Escríbeme a hola@tudominio.com</p></header>
<main>${tarjetas}</main>
<footer>Actualizado el ${new Date().toLocaleDateString('es-ES')}</footer>
</body></html>`;
return [{ json: { html, total: proyectos.length } }];
```

## Cómo probarla
Marca dos proyectos como `publicar` y ejecuta en test. Copia el HTML que devuelve el Code, pégalo en un archivo local y ábrelo en el navegador antes de subir nada. Luego deja que el nodo GitHub haga el commit y visita la URL de Pages en el móvil para ver que se adapta.

## Qué puede salir mal
- **Imágenes que no cargan**: los enlaces de Drive tipo `/file/d/.../view` no valen en un `<img>`. Usa `https://drive.google.com/thumbnail?id=ID&sz=w1600` o, mejor, Cloudinary.
- **GitHub pide el SHA**: la operación Edit necesita saber la versión anterior; el nodo GitHub de n8n lo resuelve solo, pero si da error 409 vuelve a ejecutar.
- **Descripciones con comillas o `<`**: escápalas en el Code con `.replace(/</g,'&lt;')` para no romper el HTML.
- **Caché del navegador**: si no ves los cambios, recarga con Ctrl+F5; Pages tarda hasta 2 minutos.

## Cuánto cuesta
Todo gratis: GitHub Pages no cobra por hosting de sitios estáticos, n8n auto-alojado tampoco, y Sheets y Drive entran en la cuenta normal de Google. Solo pagarías el dominio propio, unos 10-12 € al año.
