# Guía de marca en PDF que se regenera sola…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Mantienes los colores, tipografías y normas en una hoja de cálculo y el sistema genera el PDF de la guía de estilo actualizado y lo comparte con el equipo.

## Qué es y qué hace

Lee la definición de la marca (colores, tipografías y normas) desde Google Sheets, monta un HTML con muestras de color y escalas tipográficas, lo convierte a PDF con Gotenberg (libre y auto-alojado) y reemplaza la versión anterior en Drive. Entrada: tres hojas de marca; salida: PDF único actualizado. Se monta en n8n.

## Cómo usarla

1. Levanta Gotenberg con Docker
2. Rellena las hojas colores, tipografías y normas
3. Programa la regeneración diaria o manual
4. Revisa el PDF antes de compartirlo

## Cuándo usarla

Úsalo cuando la marca evoluciona (nuevo tono, nueva tipografía) y hay tres versiones distintas del manual circulando por ahí y nadie sabe cuál vale.

## Cómo ganar dinero con ella

Una actualización de manual maquetada a mano son 3-5 horas. Con esto son 5 minutos de editar una hoja, y siempre hay una única versión buena.

- Manual de marca para pymes que tienen varias versiones circulando.
- Actualización de guías para estudios que gestionan varias identidades de clientes.
- Plantilla de guía de estilo para equipos de marketing con cambios frecuentes.

**Precio orientativo:** 150–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee la definición de la marca desde Google Sheets, monta un HTML con muestras de color, escalas tipográficas y normas de uso, lo convierte en PDF y lo sube a Drive sustituyendo la versión anterior. Para marcas pequeñas y estudios que gestionan varias identidades.

## Lo que necesitas antes
- n8n auto-alojado (para levantar Gotenberg al lado con Docker).
- Gotenberg, que es gratis y libre: `docker run -d -p 3000:3000 gotenberg/gotenberg:8`. Convierte HTML en PDF sin cuenta ni claves.
- Google Sheets y Drive por OAuth.
- Un documento con tres hojas: `colores` (columnas `nombre`, `hex`, `uso`), `tipografias` (`nombre`, `peso`, `uso`, `tamano`) y `normas` (`regla`).
- Tu logo en PNG subido a algún sitio con URL pública.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Days, a las 8:00. O usa un **Webhook** si prefieres regenerar a mano cuando cambies algo.
2. **Google Sheets** — Get Row(s) de la hoja `colores`.
3. **Google Sheets** — Get Row(s) de la hoja `tipografias`.
4. **Google Sheets** — Get Row(s) de la hoja `normas`.
5. **Code** — Mode: Run Once for All Items. Construye el HTML completo (código abajo) y lo deja como archivo binario `index.html`.
6. **HTTP Request** (renombra a «HTML a PDF») — Method: POST, URL `http://localhost:3000/forms/chromium/convert/html`. Body Content Type: Form-Data, un parámetro de tipo n8n Binary File llamado `files` con Input Data Field Name `data`. Options > Response Format: File, campo `data`.
7. **Google Drive** — Operation: Upload. File Name: `Guia-de-marca-{{ $now.format('yyyy-MM-dd') }}.pdf`. Carpeta «Marca».
8. **Google Drive** — Operation: Share, Role Reader, Type Anyone with link.
9. **Slack** — Send Message al canal del equipo: `Guía de marca actualizada: {{ $json.webViewLink }}`.

## El nodo Code
```javascript
const colores = $('Google Sheets').all().map(i => i.json);
const tipos = $('Google Sheets1').all().map(i => i.json);
const normas = $('Google Sheets2').all().map(i => i.json);
const muestras = colores.map(c =>
  `<div class="c"><div class="sw" style="background:${c.hex}"></div>
   <b>${c.nombre}</b><br><code>${c.hex}</code><br><small>${c.uso}</small></div>`
).join('');
const tipografia = tipos.map(t =>
  `<p style="font-weight:${t.peso};font-size:${t.tamano}">${t.nombre} — ${t.uso}</p>`
).join('');
const reglas = normas.map(n => `<li>${n.regla}</li>`).join('');
const html = `<html><head><meta charset="utf-8"><style>
body{font-family:Helvetica,Arial,sans-serif;margin:40px;color:#111}
h1{font-size:34px} h2{margin-top:36px;border-bottom:2px solid #111;padding-bottom:6px}
.c{display:inline-block;width:150px;margin:0 12px 20px 0;vertical-align:top}
.sw{height:90px;border-radius:8px;border:1px solid #ddd}
code{font-size:12px}
</style></head><body>
<h1>Guía de marca</h1><p>Versión ${new Date().toLocaleDateString('es-ES')}</p>
<h2>Colores</h2>${muestras}
<h2>Tipografía</h2>${tipografia}
<h2>Normas de uso</h2><ul>${reglas}</ul>
</body></html>`;
return [{
  json: {},
  binary: {
    data: {
      data: Buffer.from(html).toString('base64'),
      mimeType: 'text/html',
      fileName: 'index.html',
    }
  }
}];
```

## Cómo probarla
Ejecuta en test y descarga el PDF que sale del nodo 6 directamente desde n8n antes de subir nada a Drive. Comprueba que los cuadraditos de color coinciden con los hex de la hoja. Ojo con los nombres de los nodos de Sheets: si n8n los llama distinto, cambia las referencias del Code.

## Qué puede salir mal
- **Gotenberg no responde**: si n8n va en Docker, `localhost` no es el mismo; usa el nombre del servicio, por ejemplo `http://gotenberg:3000`, con ambos en la misma red de Docker.
- **Tipografías de la marca**: Chromium solo tiene las del sistema. Enlaza Google Fonts en el `<head>` o incrusta la fuente en base64.
- **Hex sin almohadilla**: si escribes `0B3D91` sin `#`, la muestra sale en blanco. Valida en el Code con `c.hex.startsWith('#') ? c.hex : '#' + c.hex`.
- **Versiones acumuladas**: si no quieres una copia por día, quita la fecha del nombre y usa Operation: Update en Drive sobre el mismo archivo.

## Cuánto cuesta
Cero euros: Gotenberg es software libre, n8n auto-alojado también, y Sheets y Drive con cuenta normal. Si no puedes montar Docker, usa PDFShift o api2pdf, con planes desde unos 9 $/mes.
