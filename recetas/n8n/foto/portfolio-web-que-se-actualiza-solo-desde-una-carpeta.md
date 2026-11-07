# Portfolio web que se actualiza solo desde una carpeta…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Subes fotos a una carpeta y tu página de portfolio se regenera sola, ordenada por proyecto y optimizada. Para fotógrafos que tienen la web abandonada desde 2023.

## Qué es y qué hace

Vigila una carpeta de Drive organizada por proyecto, genera el HTML de la galería con las fotos ya optimizadas y lo sube a un repositorio de GitHub. Cloudflare Pages o GitHub Pages publican la web gratis en cada cambio. Así actualizas el portfolio subiendo fotos a la carpeta, sin tocar código.

## Cómo usarla

1. Crea el repositorio de GitHub y el token de acceso
2. Conecta Cloudflare Pages al repositorio
3. Organiza la carpeta PORTFOLIO en Drive
4. Prueba con un proyecto

## Cuándo usarla

Cuando cada actualización de tu web es un suplicio y por eso enseñas trabajo viejo o mandas enlaces de Drive a los clientes.

## Cómo ganar dinero con ella

Evita los 300-800 € de un rediseño o los 15-25 €/mes de una plataforma tipo Squarespace o Format.

- Montaje de portfolio autoactualizable para fotógrafos que tienen la web abandonada.
- Mantenimiento mensual del portfolio y del dominio para estudios que suben trabajos cada mes.
- Plantilla de portfolio gratuito vendida a ilustradores y fotógrafos que no quieren pagar cuota.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una carpeta de Drive organizada en subcarpetas por proyecto, genera el HTML de la galería con las fotos ya optimizadas y lo publica en tu web gratuita, todo sin que toques código.
Para fotógrafos, ilustradores y estudios que quieren una web propia (no un perfil de Instagram) sin pagar cuota mensual.

## Lo que necesitas antes
- Cuenta de GitHub gratuita y un repositorio público llamado por ejemplo `portfolio`. Genera un Personal Access Token en Settings > Developer settings > Tokens (classic) con permiso `repo`.
- Cuenta de Cloudflare Pages (gratis) conectada a ese repositorio: cada push publica la web sola. Alternativa: GitHub Pages, también gratis.
- Estructura en Drive: PORTFOLIO / Bodas, PORTFOLIO / Producto, PORTFOLIO / Retrato, con las fotos dentro.
- Un dominio propio si quieres (10-14 €/año); si no, usas el subdominio gratuito.

## Los nodos, en orden
1) **Schedule Trigger** cada 6 horas, o **Manual Trigger** cuando tú quieras publicar.
2) **Google Drive** (Search carpetas). Query String: `'ID_PORTFOLIO' in parents and mimeType = 'application/vnd.google-apps.folder' and trashed = false`.
3) **Loop Over Items** (Split In Batches, Batch Size: 1) sobre cada proyecto.
4) **Google Drive1** (Search fotos). Query String: `'{{ $json.id }}' in parents and mimeType contains 'image/' and trashed = false`. Options > Fields: `id,name,imageMediaMetadata`. Order By: `name`.
5) **Google Drive2** (Share). Type: anyone, Role: reader. Así las URLs funcionan en la web.
6) **Code** (Montar el HTML). Ver abajo.
7) **HTTP Request** (Subir a GitHub). Method: PUT. URL: `https://api.github.com/repos/TU_USUARIO/portfolio/contents/index.html`. Authentication: Generic Credential Type > Header Auth, con una credencial de n8n (Name `Authorization`, Value `Bearer TU_TOKEN`); en Headers solo `Accept: application/vnd.github+json`. No pegues el token en el nodo: si exportas o compartes el flujo como JSON, se iría con él. Body JSON: `{ "message": "Actualiza portfolio", "content": "{{ $json.htmlBase64 }}", "sha": "{{ $json.shaActual }}" }`.
8) Antes del 7, un **HTTP Request1** con GET a la misma URL para obtener el `sha` del archivo actual (GitHub lo exige para sobrescribir). Ponlo con Continue On Fail por si el archivo aún no existe.
9) **Gmail** avisándote de que la web está publicada con el número de fotos.

## El trozo de código (nodo Code)
```javascript
const proyecto = $('Loop Over Items').first().json.name;
const fotos = $input.all().map(i => i.json);
const tarjetas = fotos.map(f => {
  const url = `https://drive.google.com/thumbnail?id=${f.id}&sz=w1600`;
  const alt = `${proyecto} - ${f.name.replace(/\.[^.]+$/, '').replace(/[-_]/g, ' ')}`;
  return `<figure><img loading="lazy" src="${url}" alt="${alt}"></figure>`;
}).join('\n');
const html = `<!doctype html><html lang="es"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>${proyecto} | Mi portfolio</title>
<style>body{margin:0;font-family:system-ui,sans-serif;background:#111;color:#eee}
h1{font-weight:400;letter-spacing:.05em;padding:48px 24px 16px}
.g{display:grid;grid-template-columns:repeat(auto-fill,minmax(300px,1fr));gap:8px;padding:8px}
figure{margin:0}img{width:100%;height:100%;object-fit:cover;display:block}</style>
</head><body><h1>${proyecto}</h1><div class="g">${tarjetas}</div></body></html>`;
const htmlBase64 = Buffer.from(html, 'utf8').toString('base64');
return [{ json: { proyecto, total: fotos.length, htmlBase64 } }];
```

## Cómo probarla
Pon 6 fotos en una sola subcarpeta y ejecuta a mano. Abre la URL de Cloudflare Pages en el móvil y comprueba que carga rápido y que las fotos no se deforman. Cuando funcione, añade el resto de proyectos.

## Qué puede salir mal
- **Drive corta las imágenes con mucho tráfico**: el enlace de thumbnail tiene límites diarios. Si tu web crece, sube las fotos al propio repositorio (otro HTTP Request PUT por foto, en base64) o a Cloudflare R2.
- **Fotos pesadas**: mete un **Edit Image** antes con Resize a 1600 px y calidad 80; una portada no necesita 8 MB.
- **Choque de sha**: si dos ejecuciones se solapan, GitHub devuelve 409. Deja el workflow con Concurrency 1 en Settings.
- **Orden de las fotos**: se ordenan por nombre, así que numera 01_, 02_, 03_ para mandar tú en la secuencia.

## Cuánto cuesta
Todo gratis: n8n autoalojado 0 €, GitHub 0 €, Cloudflare Pages 0 € con ancho de banda ilimitado. Solo pagas el dominio, 10-14 €/año. Frente a Squarespace o Format, ahorras 180-300 €/año.
