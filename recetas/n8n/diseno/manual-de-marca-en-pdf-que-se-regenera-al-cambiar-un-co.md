# Manual de marca en PDF que se regenera al cambiar un co…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Cuando tocas los colores, tipografías o normas en una hoja, vuelve a generar el manual de marca en HTML y PDF y lo deja actualizado en la carpeta del cliente.

## Qué es y qué hace

Lee los colores, tipografías y normas de marca desde una hoja de cálculo, los inserta en una plantilla HTML ya diseñada, convierte el resultado a PDF mediante una API y lo sube a Drive con fecha y número de versión. Sirve para que el cliente consulte siempre el último manual. Se monta con n8n, Make o Zapier.

## Cómo usarla

1. Crea la hoja Manual con sus pestañas
2. Prepara la plantilla HTML con marcadores
3. Conecta el servicio de PDF y Drive
4. Genera una versión de prueba y compárala con el original

## Cuándo usarla

Cuando entregas manuales de identidad que luego evolucionan y acabas con tres PDF distintos circulando por la empresa del cliente.

## Cómo ganar dinero con ella

Cada actualización del manual son 2-4 horas de maquetación. Con dos actualizaciones al año por cliente y cinco clientes, son 30 horas al año.

- Mantenimiento anual de manuales de marca con actualización incluida…
- Plantilla de manual reutilizable para estudios con varios clientes…
- Control de versiones de identidad para empresas que cambian colores o normas…

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee los datos de la marca (colores, tipografías, usos correctos e incorrectos, áreas de respeto) desde una hoja, los mete en una plantilla HTML que has diseñado una sola vez, la convierte a PDF y la sube a Drive con fecha y número de versión.
Es para estudios que mantienen manuales vivos y quieren que el cliente consulte siempre la última versión desde un enlace fijo.
## Lo que necesitas antes
Una hoja de Google `Manual` con pestañas: `Colores` (`nombre`, `hex`, `pantone`, `cmyk`, `uso`), `Tipografias` (`familia`, `pesos`, `uso`, `licencia`) y `Normas` (`titulo`, `texto`, `imagen_url`, `tipo`: correcto/incorrecto).
Una plantilla HTML tuya, con la maquetación y el CSS del manual. La guardas dentro del nodo Code como cadena, o en un Gist público que descargas con un «HTTP Request».
Cuenta en pdfshift.io (o DocRaptor / Api2Pdf): API key en el panel. Plan gratuito con unas 50 conversiones al mes.
En n8n: credenciales «Google Sheets OAuth2 API», «Google Drive OAuth2 API» y «Basic Auth» con User `api` y Password tu clave de PDFShift.
## Los nodos, en orden
**1. «Google Sheets Trigger»** — Poll Times: Every Hour, Document tu hoja, Event: Row Updated. (O un «Schedule Trigger» semanal si prefieres.)
**2. «Google Sheets»** ×3 — un nodo Get Row(s) por pestaña: `Colores`, `Tipografias`, `Normas`. Encadénalos o usa un «Merge» en modo Combine by Position.
**3. «Code»** — arma el HTML completo con los datos (código abajo).
**4. «HTTP Request»** (nómbralo A PDF) — POST a `https://api.pdfshift.io/v3/convert/pdf`, Authentication: Basic Auth. Body JSON: `{ "source": {{ JSON.stringify($json.html) }}, "format": "A4", "landscape": false, "margin": "15mm", "use_print": true }`. Response Format: File, Put Output in Field `data`. Settings: Retry On Fail, 2 intentos.
**5. «Code»** (nómbralo Versión) — calcula la versión sumando 1 a un contador guardado en una celda de la hoja, o usa la fecha: `const d = new Date(); return [{ json: { nombre: `Manual_Marca_${d.getFullYear()}${String(d.getMonth()+1).padStart(2,'0')}${String(d.getDate()).padStart(2,'0')}.pdf` } }];`
**6. «Google Drive»** — Upload a la carpeta del cliente, File Name `{{ $json.nombre }}`, Input Data Field `data`.
**7. «Google Drive»** (nómbralo Publicar) — Operation: Share, Role `reader`, Type `anyone`, para tener un enlace que el cliente pueda abrir.
**8. «Gmail»** — avisa al cliente: `Manual de marca actualizado. Última versión aquí: {{ $json.webViewLink }}`.
## El trozo de código (nodo «Code»)
```javascript
const colores = $('Colores').all().map(i => i.json);
const tipos = $('Tipografias').all().map(i => i.json);
const normas = $('Normas').all().map(i => i.json);
const css = `body{font-family:Helvetica,Arial,sans-serif;color:#111;margin:0} h1{font-size:34px;margin:0 0 8px} h2{font-size:20px;margin:36px 0 12px;border-bottom:2px solid #111;padding-bottom:6px} .grid{display:flex;flex-wrap:wrap;gap:12px} .sw{width:150px} .chip{height:90px;border-radius:6px;border:1px solid #0002} .meta{font-size:11px;line-height:1.5;margin-top:6px} .norma{margin:14px 0;padding:12px;border-left:4px solid #ccc} .ok{border-color:#1a9c4b} .ko{border-color:#c62828} .page{page-break-after:always;padding:40px}`;
const swatches = colores.map(c => `<div class=sw><div class=chip style="background:${c.hex}"></div><div class=meta><b>${c.nombre}</b><br>HEX ${c.hex}<br>PANTONE ${c.pantone || '-'}<br>CMYK ${c.cmyk || '-'}<br>${c.uso || ''}</div></div>`).join('');
const fuentes = tipos.map(t => `<div class=norma><b>${t.familia}</b> — pesos: ${t.pesos}<br><span class=meta>${t.uso || ''} · Licencia: ${t.licencia || 'por definir'}</span></div>`).join('');
const reglas = normas.map(n => `<div class="norma ${String(n.tipo).toLowerCase() === 'correcto' ? 'ok' : 'ko'}"><b>${n.titulo}</b><br>${n.texto}${n.imagen_url ? `<br><img src="${n.imagen_url}" style="max-width:320px;margin-top:8px">` : ''}</div>`).join('');
const html = `<html><head><meta charset="utf-8"><style>${css}</style></head><body>` +
`<div class=page><h1>Manual de identidad</h1><p class=meta>Generado el ${new Date().toLocaleDateString('es-ES')}</p></div>` +
`<div class=page><h2>Colores</h2><div class=grid>${swatches}</div></div>` +
`<div class=page><h2>Tipografías</h2>${fuentes}</div>` +
`<div class=page><h2>Usos correctos e incorrectos</h2>${reglas}</div>` +
`</body></html>`;
return [{ json: { html } }];
```
## Cómo probarla
Ejecuta hasta el Code y copia el HTML en un archivo local para abrirlo en el navegador: así ajustas la maquetación sin gastar conversiones de PDF.
Cuando esté bien, ejecuta el flujo entero y revisa saltos de página y márgenes en el PDF. Ajusta `margin` y los `page-break-after`.
## Qué puede salir mal
Las imágenes deben estar en URL públicas; las de Drive con `/view` no cargan en el PDF. Usa `uc?export=download&id=` o un servicio de imágenes.
Las tipografías de marca no se incrustan solas: si quieres verlas en el PDF, añade en el CSS un `@font-face` con la fuente alojada en una URL pública y comprueba que la licencia lo permite.
Los acentos se rompen si olvidas el `<meta charset="utf-8">`.
PDFShift tarda unos segundos con manuales largos; si da timeout, sube el Timeout del nodo HTTP Request en Settings a 60000 ms.
## Cuánto cuesta
n8n, Sheets y Drive gratis. PDFShift: unas 50 conversiones gratis al mes y planes desde unos 9-24 $/mes. Con un manual por cliente y dos actualizaciones al año, no pasas del gratuito.
