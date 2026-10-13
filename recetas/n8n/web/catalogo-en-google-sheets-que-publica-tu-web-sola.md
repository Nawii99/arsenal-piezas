# Catálogo en Google Sheets que publica tu web sola…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Editas productos o servicios en una hoja de cálculo y, con validación previa, se genera el JSON del catálogo, se sube a GitHub y la web estática se reconstruye sola.

## Qué es y qué hace

Lee la hoja de catálogo de Google Sheets, valida fila a fila el precio numérico, la imagen existente, los campos obligatorios y el slug único, y solo si todo es correcto genera productos.json. Lo sube a GitHub, lo que dispara el build de Cloudflare Pages o Netlify, y avisa por Telegram cuando la web está publicada con el número de productos. Requiere una web estática desplegada desde GitHub.

## Cómo usarla

1. Preparar la hoja Catálogo con sus columnas
2. Crear el token de GitHub con permiso sobre el repo
3. Montar el flujo de validación y publicación en n8n
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tengas una web estática (Astro, Hugo, Eleventy, o HTML con JavaScript) y quieras que alguien no técnico actualice precios y productos sin tocar código ni pedirte nada.

## Cómo ganar dinero con ella

Elimina la cuota de un CMS o de un desarrollador para cada cambio (30-60 € por retoque). Web estática = hosting a 0 € y carga instantánea.

- Catálogo editable por el cliente para tiendas con web estática sin CMS.
- Mantenimiento de precios y productos en una hoja para pequeños comercios.
- Montaje de una web estática con catálogo actualizable que el desarrollador entrega sin cuota de CMS.

**Precio orientativo:** 200–400 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee la hoja del catálogo, revisa fila a fila que los datos sean válidos (precio numérico, imagen que existe, campos obligatorios rellenos, slug único) y solo si todo está bien genera el archivo `productos.json`.
Lo sube al repositorio de GitHub, lo que dispara automáticamente el build de Cloudflare Pages o Netlify, y te avisa por Telegram cuando la web ya está publicada con el número de productos.

## Lo que necesitas antes
- Web estática ya desplegada desde un repositorio de GitHub en Cloudflare Pages o Netlify, y que lea su catálogo de `src/data/productos.json`.
- Hoja de Google «Catálogo» con columnas: slug, nombre, descripcion, precio, imagen_url, categoria, activo (SÍ/NO), destacado.
- Token de GitHub: `github.com/settings/tokens` > «Generate new token (classic)» con permiso `repo`, o un fine-grained token con permiso «Contents: Read and write» sobre ese repositorio.
- Credencial `GitHub API` en n8n con ese token, credencial Google Sheets y bot de Telegram.

## Los nodos, en orden
1. **Schedule Trigger** — Hours, Hours Between Triggers: 1 (o pon un **n8n Form Trigger** con un botón «Publicar ahora» si prefieres control manual).
2. **Google Sheets** — Get Row(s) del documento «Catálogo».
3. **Code** (renómbralo «Validar y montar JSON») — ver código. Si algo falla, lanza un error controlado con el detalle.
4. **IF** — Boolean: `={{ $json.valido }}` is true. La rama false va a un **Telegram** con `={{ $json.errores }}` y ahí termina: la web no se toca.
5. **Code** (renómbralo «¿Ha cambiado?») — compara el JSON nuevo con el guardado en datos estáticos para no hacer commits inútiles: `const s = $getWorkflowStaticData('global'); const igual = s.ultimo === $json.json; s.ultimo = $json.json; return [{ json: { ...$json, igual } }];`
6. **IF** — Boolean: `={{ $json.igual }}` is false (si es igual, se para aquí).
7. **GitHub** — Resource: File; Operation: Edit; Repository Owner y Name: los tuyos; File Path: `src/data/productos.json`; File Content: `={{ $json.json }}`; Commit Message: `=Catálogo actualizado: {{ $json.total }} productos ({{ $now.format('dd/LL/yyyy HH:mm') }})`. Si el archivo no existe todavía, usa Operation `Create` la primera vez.
8. **Wait** — Amount: 90, Unit: Seconds.
9. **HTTP Request** (renómbralo «Comprobar publicación») — GET `https://tudominio.com/productos.json?v={{ $now.toMillis() }}`; Response Format: Text; Never Error activado.
10. **Telegram** — Text: `🟢 Catálogo publicado: {{ $('Validar y montar JSON').item.json.total }} productos activos.\nÚltimo cambio: {{ $('Validar y montar JSON').item.json.resumen }}`.

## El código de «Validar y montar JSON»
```js
const filas = $input.all().map(i => i.json);
const errores = [];
const slugs = new Set();
const productos = [];
filas.forEach((f, i) => {
  const n = i + 2;
  if (!f.slug || !f.nombre) { errores.push(`Fila ${n}: falta slug o nombre`); return; }
  const slug = String(f.slug).trim().toLowerCase();
  if (!/^[a-z0-9-]+$/.test(slug)) errores.push(`Fila ${n}: el slug "${slug}" solo puede tener letras minúsculas, números y guiones`);
  if (slugs.has(slug)) errores.push(`Fila ${n}: slug repetido "${slug}"`);
  slugs.add(slug);
  const precio = Number(String(f.precio).replace(',', '.').replace(/[^0-9.]/g, ''));
  if (!isFinite(precio) || precio <= 0) errores.push(`Fila ${n}: precio inválido "${f.precio}"`);
  if (f.imagen_url && !/^https?:\/\//.test(f.imagen_url)) errores.push(`Fila ${n}: la imagen debe empezar por https://`);
  if (String(f.activo).toUpperCase() !== 'SÍ' && String(f.activo).toUpperCase() !== 'SI') return;
  productos.push({ slug, nombre: String(f.nombre).trim(), descripcion: String(f.descripcion || '').trim(), precio, imagen: f.imagen_url || '', categoria: f.categoria || 'general', destacado: String(f.destacado).toUpperCase().startsWith('S') });
});
if (productos.length === 0) errores.push('No hay ningún producto activo: no se publica nada para no vaciar la web');
return [{ json: {
  valido: errores.length === 0,
  errores: '❌ No he publicado. Corrige esto en la hoja:\n' + errores.join('\n'),
  total: productos.length,
  resumen: productos.slice(0, 3).map(p => p.nombre).join(', ') + (productos.length > 3 ? '…' : ''),
  json: JSON.stringify(productos, null, 2)
} }];
```

## Cómo probarla
- Mete un precio con texto («consultar») y ejecuta: debe llegarte el Telegram de error y NO hacerse commit. Ese es el guardarraíl importante.
- Corrígelo, ejecuta otra vez y mira en GitHub que aparece el commit y en Cloudflare Pages el nuevo despliegue.
- Abre la web en incógnito y comprueba que el producto nuevo se ve.

## Qué puede salir mal
- **Se publica un catálogo vacío**: el código ya lo bloquea; no quites esa comprobación.
- **Commits cada hora sin cambios**: el paso 5 lo evita; si reinicias n8n se hará uno de más, sin importancia.
- **Conflicto en GitHub («sha does not match»)**: alguien editó el archivo a mano; el nodo GitHub con Operation Edit resuelve el sha solo, pero si falla, ejecuta otra vez.
- **La web no refleja el cambio**: purga la caché de Cloudflare o añade a la URL del JSON un parámetro con la fecha del build.
- **Precios con coma española**: el código ya convierte `19,90` a `19.90`. Formatea de vuelta a euros en la web, no en la hoja.
- **Muchas manos en la hoja**: protege las columnas `slug` y `activo` con la protección de rangos de Google Sheets.

## Cuánto cuesta
- Cloudflare Pages: gratis (500 builds al mes) y hosting sin límite de tráfico. Netlify: 300 minutos de build gratis.
- GitHub, Google Sheets y Telegram: gratis.
- n8n auto-alojado gratis; en la nube gratuita, 24 ejecuciones al día son demasiadas: pon el Schedule cada 6 horas o usa el disparador manual con formulario.
