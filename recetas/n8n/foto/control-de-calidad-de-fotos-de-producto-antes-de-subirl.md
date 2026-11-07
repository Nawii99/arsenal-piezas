# Control de calidad de fotos de producto antes de subirl…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Revisa cada foto de producto y comprueba resolución, proporción, peso, fondo blanco y color, y te dice cuáles no cumplen los requisitos del marketplace.

## Qué es y qué hace

Analiza cada foto de una carpeta: mide lado mayor, proporción, peso, espacio de color y el brillo de las cuatro esquinas para comprobar si el fondo es blanco puro. Separa las fotos en APTAS y RECHAZADAS con el motivo exacto, según los requisitos de tu marketplace. Usa ImageMagick dentro de n8n autoalojado y Drive y Sheets para el registro.

## Cómo usarla

1. Instala ImageMagick en el contenedor
2. Crea las carpetas QC ENTRADA, APTAS y RECHAZADAS
3. Anota los requisitos del marketplace
4. Prueba con un lote de catálogo

## Cuándo usarla

Cuando subes catálogos a Amazon, Shein, Zalando o tu tienda y te rechazan fotos por fondo no blanco, tamaño insuficiente o proporción incorrecta.

## Cómo ganar dinero con ella

Evita rechazos que retrasan una publicación 3-5 días y te ahorra revisar a ojo cientos de imágenes antes de cada subida de catálogo.

- Montaje del control de calidad para tiendas que suben catálogos a marketplaces con rechazos frecuentes.
- Revisión por lotes para agencias que preparan fichas de producto para varios clientes.
- Checklist automatizado vendido a vendedores de Amazon o Zalando que pierden días por fotos rechazadas.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Para tiendas y agencias que preparan catálogos: analiza cada imagen de una carpeta, mide lado mayor, proporción, peso, espacio de color y el brillo de las cuatro esquinas (para saber si el fondo es realmente blanco puro), y separa las fotos en APTAS y RECHAZADAS con el motivo exacto de cada rechazo.

## Lo que necesitas antes
- n8n **auto-alojado** (usa Execute Command).
- ImageMagick en el contenedor: Dockerfile con `FROM n8nio/n8n`, `USER root`, `RUN apk add --no-cache imagemagick`, `USER node`.
- Credenciales de Google Drive y Google Sheets en n8n.
- Carpetas en Drive: `QC ENTRADA`, `QC APTAS`, `QC RECHAZADAS`.
- Un bot de Telegram si quieres el aviso al móvil: hablas con @BotFather, /newbot, copias el token y sacas tu chat_id escribiendo al bot y abriendo `https://api.telegram.org/botTOKEN/getUpdates`.
- Los requisitos de tu marketplace apuntados (por ejemplo Amazon: lado mayor ≥ 1600 px, fondo RGB 255,255,255, JPG o PNG, sRGB).

## Los nodos, en orden
1. **Schedule Trigger** — cada 15 minutos.
2. **Google Drive** — Search en `QC ENTRADA`, Query String: `'ID_QC_ENTRADA' in parents and mimeType contains 'image/' and trashed=false`, Return All.
3. **Loop Over Items** — Batch Size: 1.
3b. **Code «Nombre seguro»** (modo «Run Once for Each Item») — `const ext = String($json.name).split('.').pop().toLowerCase(); if (!['jpg','jpeg','png','webp','tif','tiff','gif','heic','bmp'].includes(ext) || !/^[A-Za-z0-9_-]+$/.test($json.id)) throw new Error('Formato no admitido: ' + $json.name); return { json: { ...$json, archivo: $json.id + '.' + ext } };`. En /tmp y en los comandos solo se usa `archivo`.
4. **Google Drive** — Download, campo binario `data`.
5. **Read/Write Files from Disk** — Write File to Disk, File Path `=/tmp/qc/{{ $('Nombre seguro').item.json.archivo }}` (crea antes /tmp/qc con un Execute Command `mkdir -p /tmp/qc`).
6. **Execute Command «Medir»** — Command: `magick identify -format '{"ancho":%w,"alto":%h,"peso":%b,"formato":"%m","perfil":"%[colorspace]"}' "/tmp/qc/{{ $('Nombre seguro').item.json.archivo }}"`.
7. **Execute Command «Esquinas»** — Command: `magick "/tmp/qc/{{ $('Nombre seguro').item.json.archivo }}" -format '%[fx:int(255*p{2,2}.r)],%[fx:int(255*p{w-3,2}.r)],%[fx:int(255*p{2,h-3}.r)],%[fx:int(255*p{w-3,h-3}.r)]' info:`.
8. **Code «Evaluar»** — aplica las reglas (código abajo).
9. **IF** — Boolean: `{{ $json.apta }}` is true.
10. Rama verdadera: **Google Drive** Operation: Move a `QC APTAS`. Rama falsa: **Google Drive** Move a `QC RECHAZADAS`.
11. **Google Sheets** — Append en la hoja «QC» con archivo, ancho, alto, proporcion, peso_mb, apta, motivos.
12. Fuera del bucle: **Code** que cuente rechazos y **Telegram** — Operation: Send Message, con el resumen y los tres primeros motivos.
13. **Execute Command** final: `rm -rf /tmp/qc/*`.

## El trozo de código (nodo Code «Evaluar»)
```javascript
const MIN_LADO = 1600;
const MAX_MB = 10;
const PROPORCIONES = [1, 4/5, 3/4]; // 1:1, 4:5, 3:4 admitidas
const salida = [];
for (const item of $input.all()) {
  const m = JSON.parse($('Medir').item.json.stdout);
  const esquinas = $('Esquinas').item.json.stdout.trim().split(',').map(Number);
  const nombre = $('Loop Over Items').item.json.name;
  const pesoMb = parseFloat(String(m.peso).replace(/[^0-9.]/g, '')) / (String(m.peso).includes('K') ? 1024 : 1);
  const prop = m.ancho / m.alto;
  const motivos = [];
  if (Math.max(m.ancho, m.alto) < MIN_LADO) motivos.push(`Lado mayor ${Math.max(m.ancho, m.alto)} px, mínimo ${MIN_LADO}`);
  if (pesoMb > MAX_MB) motivos.push(`Pesa ${pesoMb.toFixed(1)} MB, máximo ${MAX_MB}`);
  if (!PROPORCIONES.some(p => Math.abs(prop - p) < 0.02)) motivos.push(`Proporción ${prop.toFixed(2)} no admitida`);
  if (esquinas.some(v => v < 250)) motivos.push(`Fondo no blanco puro en las esquinas (${esquinas.join('/')})`);
  if (!['JPEG', 'PNG'].includes(m.formato)) motivos.push(`Formato ${m.formato} no admitido`);
  if (m.perfil && m.perfil.toUpperCase() === 'CMYK') motivos.push('Está en CMYK, debe ser sRGB');
  salida.push({ json: { archivo: nombre, ancho: m.ancho, alto: m.alto, proporcion: prop.toFixed(2), peso_mb: pesoMb.toFixed(2), apta: motivos.length === 0, motivos: motivos.join(' | ') }});
}
return salida;
```

## Cómo probarla
- Prepara cuatro fotos a propósito: una correcta, una de 800 px, una con fondo gris claro y una en 16:9.
- Ejecuta y comprueba que cada una cae donde toca y que el motivo del rechazo es el correcto.
- Si una foto con fondo blanco de verdad te sale rechazada, sube el umbral de 250 a 245: muchos JPG comprimidos tienen las esquinas en 250-253.

## Qué puede salir mal
- **Objeto que toca el borde**: si el producto llega a la esquina, la prueba de fondo falla. Muestrea más puntos (añade `p{w/2,2}` y `p{2,h/2}` al comando) y exige que fallen al menos tres.
- **Unidad de peso**: `%b` devuelve KB o MB según el tamaño; el código ya lo contempla, pero verifica con una foto de 200 KB.
- **PNG con transparencia**: las esquinas transparentes se leen como negro. Añade `-background white -flatten` antes del `-format` en el comando de esquinas.
- **Fotos que se quedan en /tmp**: si el flujo falla a mitad, el `rm` final no se ejecuta. Añade un Error Workflow en Settings del workflow que lo limpie.
- **Nombres con trampa**: una foto llamada `$(id).jpg` o con comillas ejecutaría órdenes en ImageMagick. En /tmp va como `ID-de-Drive.extensión` y el nombre original solo se apunta en la hoja; si llega otra extensión, el flujo para hasta que la saques de `QC ENTRADA`.
- **El Code «Evaluar» no encuentra los datos**: cita los nodos por su nombre, `$('Medir')` y `$('Esquinas')`; si los renombras, cambia también esas dos líneas.
- **Requisitos que cambian**: pon MIN_LADO, MAX_MB y PROPORCIONES en variables del workflow (Settings > Variables) o en una hoja de configuración, para no tocar el código.

## Cuánto cuesta
0 € en todo: n8n auto-alojado, ImageMagick libre, Drive y Sheets con tu cuenta, Telegram gratis. Solo pagas el VPS si no lo ejecutas en tu propio ordenador (5-7 €/mes).
