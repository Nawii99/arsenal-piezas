# Entregas web optimizadas y con informe de peso ahorrado…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Comprime todas las imágenes de una entrega, genera versiones WebP y te devuelve un informe con cuánto ha adelgazado cada archivo para enseñárselo al cliente.

## Qué es y qué hace

Toma las imágenes de una carpeta de Drive, las comprime con la API de TinyPNG y guarda las versiones ligeras en una carpeta de entrega. Después envía un correo con una tabla de kilobytes antes y después de cada archivo. Sirve para justificar el rendimiento de una entrega gráfica. Se monta con n8n, Make o Zapier.

## Cómo usarla

1. Crea las carpetas entrega-original y entrega-web
2. Genera la API key de TinyPNG
3. Configura las credenciales de Drive y de autenticación básica en n8n
4. Prueba con un lote pequeño

## Cuándo usarla

Cuando entregas gráficos para web o tienda online y el desarrollador se queja del peso, o quieres justificar por qué tu entrega es mejor que la del anterior.

## Cómo ganar dinero con ella

Evita la ronda de correcciones por rendimiento (1-2 horas) y te da un argumento comercial medible para vender la optimización como partida aparte.

- Optimización de imágenes como partida aparte en cada entrega para web…
- Auditoría de peso de gráficos para tiendas online con informe incluido…
- Mantenimiento trimestral de activos visuales para webs de clientes…

**Precio orientativo:** 40–120 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Toma todas las imágenes de una carpeta de Drive, las pasa por un compresor inteligente, guarda las versiones ligeras y en WebP en la carpeta de entrega, y manda un correo con la tabla de kilobytes antes y después.
Es para diseñadores que entregan piezas para webs, tiendas online o newsletters y quieren demostrar el valor técnico de su entrega.
## Lo que necesitas antes
Dos carpetas en Drive: `entrega-original` y `entrega-web`. Apunta sus IDs.
Una clave de TinyPNG: tinify.com/developers, te registras con el correo y te dan la API key. 500 compresiones al mes gratis.
En n8n: credencial «Google Drive OAuth2 API» y una credencial «Basic Auth» con User `api` y Password tu API key de TinyPNG.
## Los nodos, en orden
**1. «Manual Trigger»** (o «Google Drive Trigger» sobre `entrega-original` si lo quieres automático).
**2. «Google Drive»** (nómbralo Listar) — Resource: File/Folder, Operation: Search, Search Method: Advanced, Query String `'ID_CARPETA' in parents and (mimeType='image/png' or mimeType='image/jpeg') and trashed=false`, Return All activado.
**3. «Split In Batches»** — Batch Size 1: TinyPNG no admite ráfagas grandes.
**4. «Google Drive»** (nómbralo Descargar) — Operation: Download, File ID `{{ $json.id }}`, Put Output File in Field `data`.
**5. «HTTP Request»** (nómbralo Comprimir) — POST a `https://api.tinify.com/shrink`, Authentication: Generic > Basic Auth. Body Content Type: n8n Binary File, Input Data Field Name `data`. Settings: Retry On Fail, Max Tries 3, Wait 3000.
**6. «HTTP Request»** (nómbralo Bajar comprimida) — GET a `{{ $json.output.url }}`, Response Format: File, campo `data`.
**7. «Google Drive»** — Upload a `entrega-web`, File Name `{{ $('Split In Batches').first().json.name }}`.
**8. «HTTP Request»** (nómbralo WebP) — POST a `{{ $('Comprimir').item.json.output.url }}` con Basic Auth y Body JSON `{ "convert": { "type": "image/webp" } }`, Response Format: File. Súbelo también a Drive cambiando la extensión a `.webp`.
**9. «Code»** — acumula los datos del informe (código abajo).
**10.** Salida de vuelta a «Split In Batches». Cuando termina el bucle, la salida `done` va al nodo final.
**11. «Gmail»** — Send, asunto `Entrega optimizada: -{{ $json.ahorro_pct }}% de peso`, Email Type HTML, cuerpo `{{ $json.html }}`.
## El trozo de código (nodo «Code», modo Run Once for All Items)
```javascript
const filas = [];
let antes = 0, despues = 0;
for (const item of $input.all()) {
  const r = item.json;
  const nombre = r.nombre || r.input?.name || 'sin nombre';
  const a = Number(r.input?.size || 0);
  const d = Number(r.output?.size || 0);
  if (!a) continue;
  antes += a; despues += d;
  filas.push({ nombre, a, d, pct: Math.round((1 - d/a) * 100) });
}
const ahorro_pct = antes ? Math.round((1 - despues/antes) * 100) : 0;
const kb = n => (n/1024).toFixed(1) + ' KB';
const html = `<p>Se han optimizado ${filas.length} imágenes. Peso total: ${kb(antes)} → ${kb(despues)} (<b>-${ahorro_pct}%</b>).</p>` +
  '<table border=1 cellpadding=6><tr><th>Archivo</th><th>Antes</th><th>Después</th><th>Ahorro</th></tr>' +
  filas.sort((x,y)=>y.pct-x.pct).map(f => `<tr><td>${f.nombre}</td><td>${kb(f.a)}</td><td>${kb(f.d)}</td><td>${f.pct}%</td></tr>`).join('') + '</table>';
return [{ json: { total: filas.length, ahorro_pct, html } }];
```
## Cómo probarla
Mete tres JPG grandes (más de 1 MB) en `entrega-original` y ejecuta. Compara visualmente el original y el comprimido al 200% de zoom: TinyPNG no debería notarse.
Comprueba que el informe cuadra abriendo las propiedades de un archivo en Drive.
## Qué puede salir mal
TinyPNG solo acepta PNG, JPEG y WebP hasta 5 MB. Los TIFF, PDF o archivos mayores dan error 415 o 413: fíltralos en la query del paso 2.
Si mandas muchas imágenes a la vez sin Split In Batches, recibirás errores 429 (demasiadas peticiones).
Las 500 compresiones mensuales gratuitas se agotan rápido si conviertes también a WebP: cada conversión cuenta como una operación más.
Si un logo con transparencia sale con bordes sucios, es que el original tenía canal alfa mal exportado, no la compresión.
## Cuánto cuesta
n8n autoalojado (Community Edition), Drive y Gmail gratis; n8n Cloud tiene una prueba gratuita temporal y después planes de pago. TinyPNG: 500 operaciones al mes gratis y después unos 0,009 $ por imagen adicional; una entrega típica de 40 imágenes no llega a 40 céntimos.
