# Moodboard automático con la paleta extraída de las refe…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Sueltas las fotos de referencia de un proyecto en una carpeta y te devuelve un moodboard con las imágenes y la paleta de colores dominantes ya extraída.

## Qué es y qué hace

Recorre las imágenes de una carpeta de referencias, pide a Cloudinary los colores predominantes de cada una, agrupa los que se repiten y genera un moodboard en HTML o PDF con la rejilla de fotos y la paleta resultante. Sirve para presentar una dirección visual con fundamento. Se monta con n8n, Make o Zapier.

## Cómo usarla

1. Crea la carpeta de referencias por proyecto
2. Crea la cuenta de Cloudinary y copia sus credenciales
3. Conecta Drive en n8n
4. Ejecuta con un proyecto de prueba

## Cuándo usarla

Cuando arrancas un proyecto de identidad o dirección de arte y pierdes una mañana montando el tablero de referencias y sacando los colores con el cuentagotas.

## Cómo ganar dinero con ella

Convierte 2-3 horas de trabajo de arranque en 5 minutos. A 45 €/hora son unos 110 € por proyecto que dejas de regalar en la fase no facturable.

- Moodboards entregados como fase inicial de cada proyecto de identidad…
- Paquete de dirección de arte con paleta y referencias para clientes…
- Informe visual de tendencias para marcas que preparan campañas…

**Precio orientativo:** 60–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recorre las imágenes de referencia de una carpeta, pide a un servicio de imagen los colores predominantes de cada una, agrupa los que se repiten y genera un HTML/PDF de moodboard con la rejilla de fotos y la paleta resultante.
Es para diseñadores de marca y directores de arte en la fase de investigación visual, y para presentar la propuesta de dirección al cliente con fundamento.
## Lo que necesitas antes
Una carpeta en Drive por proyecto: `referencias/nombre-proyecto`. Apunta el ID de la carpeta padre.
Cuenta en cloudinary.com (plan gratuito generoso): apunta `cloud_name`, `api_key` y `api_secret` desde el Dashboard. Cloudinary devuelve los colores predominantes con el parámetro `colors=true` al subir.
En n8n: credencial «Google Drive OAuth2 API» y una credencial «Basic Auth» con User tu `api_key` y Password tu `api_secret` de Cloudinary.
Opcional: cuenta en PDFShift para convertir el moodboard a PDF, o quédate con el HTML.
## Los nodos, en orden
**1. «Manual Trigger»** — o un «Google Drive Trigger» si quieres que salte al crear la carpeta.
**2. «Google Drive»** — Search con Query String `'ID_CARPETA' in parents and mimeType contains 'image/' and trashed=false`, Return All.
**3. «Split In Batches»** — Batch Size 1.
**4. «Google Drive»** — Download, campo binario `data`.
**5. «HTTP Request»** (nómbralo Subir y analizar) — POST a `https://api.cloudinary.com/v1_1/TU_CLOUD_NAME/image/upload`, Authentication: Basic Auth. Body Content Type: Form-Data con: parámetro binario `file` (Input Data Field `data`), parámetro `colors` = `true`, `upload_preset` si usas uno sin firmar. La respuesta trae `colors` (array de [hex, porcentaje]) y `secure_url`.
**6.** Salida de vuelta a «Split In Batches». La salida `done` va al paso 7.
**7. «Code»** — agrupa colores parecidos y arma el HTML del moodboard (código abajo).
**8. «HTTP Request»** — a PDFShift para convertir a PDF (igual que en la receta del manual de marca), o «Convert to File» si te vale el HTML.
**9. «Google Drive»** — Upload del moodboard a la carpeta del proyecto.
## El trozo de código (nodo «Code»)
```javascript
const imgs = $input.all().map(i => i.json).filter(r => r.secure_url);
function hex2rgb(h){ const s=h.replace('#',''); return [0,2,4].map(i=>parseInt(s.substr(i,2),16)); }
function dist(a,b){ const x=hex2rgb(a), y=hex2rgb(b); return Math.sqrt((x[0]-y[0])**2 + (x[1]-y[1])**2 + (x[2]-y[2])**2); }
const bruto = [];
for (const im of imgs) { for (const c of (im.colors || [])) { bruto.push({ hex: c[0], peso: Number(c[1]) }); } }
const grupos = [];
for (const c of bruto.sort((a,b)=>b.peso-a.peso)) {
  const g = grupos.find(g => dist(g.hex, c.hex) < 40);
  if (g) { g.peso += c.peso; g.n++; } else { grupos.push({ hex: c.hex, peso: c.peso, n: 1 }); }
}
const paleta = grupos.sort((a,b)=>b.peso-a.peso).slice(0, 8);
const totalPeso = paleta.reduce((s,p)=>s+p.peso, 0) || 1;
const rejilla = imgs.map(i => `<img src="${i.secure_url}" style="width:100%;border-radius:4px;display:block">`).map(t => `<div>${t}</div>`).join('');
const chips = paleta.map(p => `<div style="flex:${(p.peso/totalPeso*100).toFixed(1)};min-width:60px"><div style="height:80px;background:${p.hex}"></div><div style="font:11px Helvetica;padding-top:6px">${p.hex}<br>${(p.peso/totalPeso*100).toFixed(0)}%</div></div>`).join('');
const html = `<html><head><meta charset="utf-8"></head><body style="font-family:Helvetica,Arial;margin:0;padding:32px;background:#fafafa">` +
`<h1 style="font-size:26px;margin:0 0 4px">Moodboard</h1><p style="font-size:12px;color:#666">${imgs.length} referencias · ${new Date().toLocaleDateString('es-ES')}</p>` +
`<div style="display:grid;grid-template-columns:repeat(3,1fr);gap:10px;margin:20px 0 32px">${rejilla}</div>` +
`<h2 style="font-size:18px">Paleta dominante</h2><div style="display:flex;gap:6px">${chips}</div>` +
`</body></html>`;
return [{ json: { html, paleta, total_imagenes: imgs.length } }];
```
## Cómo probarla
Mete 9 fotos de referencia en la carpeta y ejecuta. Abre el HTML resultante: la paleta debería reconocerse a simple vista al mirar las fotos.
Si salen ocho grises casi iguales, sube el umbral de agrupación de 40 a 60 en la función `dist`. Si salen colores demasiado distintos mezclados, bájalo a 25.
## Qué puede salir mal
Cloudinary devuelve `colors` solo si tu cuenta tiene activado el add-on de detección de color; en el plan gratuito viene incluido el básico, compruébalo en Add-ons.
Fotos con mucho blanco o negro dominan la paleta y no aportan: añade un filtro en el Code que descarte los hex por encima de `#F0F0F0` y por debajo de `#101010` si no te interesan.
Ojo con los derechos: las referencias de Pinterest no se pueden republicar. El moodboard es de uso interno o para presentación, cítalas.
Si subes muchas imágenes pesadas, Cloudinary consume tu cuota de almacenamiento: borra los assets del proyecto cuando termines con un nodo HTTP Request de `destroy`.
## Cuánto cuesta
n8n y Drive gratis. Cloudinary tiene un plan gratuito con 25 créditos al mes (miles de subidas pequeñas). PDFShift es opcional. Un moodboard de 20 imágenes no cuesta nada.
