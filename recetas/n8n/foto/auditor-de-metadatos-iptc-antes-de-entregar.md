# Auditor de metadatos IPTC antes de entregar…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Revisa cada foto de la carpeta de entrega y te avisa de las que van sin copyright, sin autor ni palabras clave, para que no salga nada de tu estudio sin firmar.

## Qué es y qué hace

Recorre una carpeta local de fotos listas para entregar, lee sus metadatos con ExifTool y comprueba cuatro campos: autor, copyright, título y palabras clave. Envía la lista de archivos incompletos y, si lo activas, rellena el copyright con tus datos. Entran JPG o TIFF y salen un informe y los archivos corregidos. Para fotógrafos que entregan a agencias o medios, con n8n autoalojado y ExifTool instalado en el servidor.

## Cómo usarla

1. Instala ExifTool en el servidor o contenedor
2. Monta la carpeta de entregas como volumen
3. Define los cuatro campos obligatorios
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando entregues lotes a agencias, medios o bancos de imágenes, donde una foto sin metadatos IPTC te la rechazan o la usan sin acreditarte.

## Cómo ganar dinero con ella

Evita rechazos de lotes enteros (medio día de trabajo repitiendo la entrega) y que tus fotos circulen sin tu nombre, que es la vía más rápida a que no te paguen.

- Auditoría de metadatos antes de entregar para fotógrafos de agencia, cobrada por lote.
- Limpieza y firma de metadatos para estudios que entregan a medios, por cuota mensual.
- Plantilla de control de metadatos vendida a bancos de imagen pequeños y gestores de archivo.

**Precio orientativo:** 150–300 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recorre una carpeta local de fotos listas para entregar, lee sus metadatos con ExifTool y comprueba que llevan cuatro campos obligatorios: autor, aviso de copyright, título y palabras clave.
Te manda un mensaje con la lista de archivos incompletos y, si quieres, rellena automáticamente el copyright con tus datos. Es para fotógrafos profesionales que entregan a terceros.

## Lo que necesitas antes
- n8n AUTO-ALOJADO (esta receta usa el nodo «Execute Command», que no existe en n8n Cloud). Si lo tienes en Docker, necesitas ExifTool dentro del contenedor.
- Instalar ExifTool: en Ubuntu `sudo apt install libimage-exiftool-perl`; en Mac `brew install exiftool`; en un contenedor Docker de n8n, entra con `docker exec -u root -it n8n sh` y ejecuta `apk add exiftool`.
- Una carpeta local, por ejemplo `/data/entregas/pendientes`, montada como volumen en el contenedor de n8n.
- Credencial de Slack en n8n («Slack API», OAuth2) o, si prefieres email, la de Gmail.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: `Hours`, cada `1` hora. O usa un **Manual Trigger** si prefieres lanzarlo tú al terminar cada sesión.
2. **Execute Command** — Command: `exiftool -j -Artist -Copyright -ObjectName -Keywords -FileName /data/entregas/pendientes/*.jpg`. La opción `-j` devuelve JSON, que es lo que hace fácil el resto.
3. **Code** — Mode: `Run Once for All Items`. Convierte la salida de texto en objetos y separa completos de incompletos (código abajo).
4. **IF** — condición Number: `{{ $json.incompletos.length }}` mayor que `0`.
5. **Execute Command** (rama true, opcional, renómbralo «Firmar»)  — Command: `exiftool -overwrite_original -Artist="Tu Nombre" -Copyright="(c) 2026 Tu Nombre. Todos los derechos reservados." -Creator="Tu Nombre" /data/entregas/pendientes/*.jpg`. Esto rellena autor y copyright en todas de golpe; título y palabras clave los tienes que poner tú a mano porque dependen de la foto.
6. **Slack** — Resource: `Message`, Operation: `Send`, Channel: `#entregas`, Text: `Fotos sin metadatos completos: {{ $json.resumen }}`.

## El código del nodo Code
```javascript
let datos = [];
try { datos = JSON.parse($input.first().json.stdout); } catch (e) { return [{ json: { incompletos: [], resumen: 'ExifTool no devolvió JSON: ' + String($input.first().json.stderr || '').slice(0, 200) } }]; }
const obligatorios = ['Artist', 'Copyright', 'ObjectName', 'Keywords'];
const incompletos = [];
for (const f of datos) {
  const faltan = obligatorios.filter(c => !f[c] || String(f[c]).trim() === '');
  if (faltan.length) incompletos.push({ archivo: f.FileName, faltan: faltan.join(', ') });
}
const resumen = incompletos.length ? incompletos.map(i => '- ' + i.archivo + ' (falta: ' + i.faltan + ')').join('\n') : 'Todo correcto';
return [{ json: { total: datos.length, incompletos, resumen } }];
```

## Cómo probarla
- Copia tres fotos a la carpeta: una bien etiquetada desde Lightroom, otra recién exportada sin metadatos y una tercera con solo el autor. El aviso debe listar dos.
- Antes de activar el paso «Firmar», haz una copia de la carpeta. `-overwrite_original` escribe encima sin preguntar.
- Lanza a mano `exiftool -j foto.jpg` en el terminal para ver los nombres exactos de los campos: algunos programas escriben en `Creator` (XMP) en vez de `Artist` (EXIF).

## Qué puede salir mal
- **`exiftool: not found`**: no está instalado dentro del contenedor de n8n, aunque sí lo esté en tu ordenador. Instálalo con `docker exec -u root`, y ten en cuenta que se pierde al recrear el contenedor: mejor haz una imagen propia con un Dockerfile de dos líneas.
- **La lista de archivos es enorme**: si hay más de unos 500 archivos, el comodín `*.jpg` puede reventar el límite de longitud del comando. Usa `exiftool -j -r -ext jpg /data/entregas/pendientes` con `-r` (recursivo) en vez del comodín.
- **Campos duplicados**: IPTC, EXIF y XMP guardan lo mismo en sitios distintos y algunos visores solo leen uno. Si trabajas con agencias, escribe los tres: añade `-XMP:Creator` y `-IPTC:By-line` al comando de firma.
- **Acentos y eñes**: añade `-charset iptc=UTF8` al comando o verás «Fotografía» convertido en garabatos.
- **Se pierden al exportar**: si Lightroom o Capture One tienen marcada la opción de quitar metadatos al exportar, este flujo te avisará cada vez. Arréglalo en el preajuste de exportación, no aquí.

## Cuánto cuesta
- ExifTool: gratis y de código abierto.
- n8n auto-alojado en un VPS pequeño: 5 € al mes, o 0 € en tu propio ordenador.
- Slack: el plan gratuito sirve. Total: 0 a 5 € al mes.
