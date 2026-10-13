# Guardián de paleta: avisa si un arte se sale de marca…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Analiza cada diseño que subes a Drive, extrae sus colores dominantes y te avisa si alguno se aleja de los colores oficiales de la marca.

## Qué es y qué hace

Cada archivo nuevo de una carpeta de revisión se procesa para extraer sus colores dominantes y se compara con tu paleta corporativa en hexadecimal. Si un color ocupa mucha superficie y no se parece a ninguno oficial, avisa con el valor hex que se sale. Entrada: imagen; salida: veredicto en hoja y aviso. Se monta en n8n con una API de análisis de color.

## Cómo usarla

1. Escribe tu paleta en hex
2. Conecta Drive y Sheets
3. Define la tolerancia de color
4. Revisa los avisos del primer mes

## Cuándo usarla

Úsalo cuando varias personas o colaboradores externos producen piezas para la misma marca y los tonos se van desviando poco a poco sin que nadie lo note.

## Cómo ganar dinero con ella

Evita reimpresiones y reposts por color mal aplicado. Una tirada de 500 folletos mal impresa cuesta 200-400 €; con que lo pilles una vez al año ya sale a cuenta.

- Control de color para marcas que trabajan con diseñadores externos.
- Revisión de piezas para imprenta antes de tiradas de folletos y etiquetas.
- Auditoría de coherencia visual para cadenas de tiendas o franquicias.

**Precio orientativo:** 40–150 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada vez que alguien sube una pieza a la carpeta de revisión, saca sus colores predominantes y los compara con tu paleta corporativa. Si un color ocupa mucha superficie y no se parece a ninguno de los tuyos, te manda un aviso con el hex culpable. Para responsables de marca que delegan producción.

## Lo que necesitas antes
- n8n auto-alojado o en la nube.
- Google Drive conectado por OAuth (activa Google Drive API en console.cloud.google.com).
- Cuenta gratuita de Cloudinary: Cloud Name, API Key y API Secret en Settings > API Keys.
- Tus colores de marca en hexadecimal, por ejemplo `#0B3D91`, `#F2A100`, `#FFFFFF`, `#1A1A1A`.
- Una hoja de Google Sheets llamada «Control de marca» con columnas `fecha`, `archivo`, `veredicto`, `colores`.

## Los nodos, en orden
1. **Google Drive Trigger** — Trigger On: Specific Folder, carpeta «Para revisar», Event: File Created, Poll Times: Every 5 Minutes.
2. **IF** — Condición String: `{{ $json.mimeType }}` contains `image`. Rama true sigue; la false no se conecta a nada.
3. **Google Drive** — Operation: Download, File By ID `={{ $json.id }}`, salida en el campo `data`.
4. **HTTP Request** (renombra a «Analizar color») — Method: POST, URL `https://api.cloudinary.com/v1_1/TU_CLOUD_NAME/image/upload`. Authentication: Generic > Basic Auth (API Key / API Secret). Body Content Type: Form-Data con: `file` (n8n Binary File, campo `data`), `upload_preset` (tu preset sin firmar) y `colors` con valor `true`. La respuesta trae el array `colors` con pares hex-porcentaje.
5. **Code** — Mode: Run Once for Each Item. Pega el código de abajo, que calcula la distancia entre cada color detectado y tu paleta.
6. **IF** — Condición Boolean: `{{ $json.fuera_de_marca }}` is true.
7. Rama true: **Gmail** — Operation: Send. Subject: `Aviso de marca: {{ $('Google Drive Trigger').item.json.name }}`. Message: `Colores sospechosos: {{ $json.sospechosos.join(', ') }}. Revisa la pieza antes de publicarla.`
8. Ramas true y false: **Google Sheets** — Operation: Append Row en «Control de marca» con fecha, nombre de archivo, veredicto y la lista de colores detectados.

## El nodo Code
```javascript
const marca = ['#0B3D91', '#F2A100', '#FFFFFF', '#1A1A1A'];
const tolerancia = 40; // sube a 60 si salta demasiado
const aRgb = h => [1,3,5].map(i => parseInt(h.slice(i, i+2), 16));
const dist = (a, b) => Math.sqrt(a.reduce((s, v, i) => s + (v - b[i]) ** 2, 0));
const colores = $json.colors || [];
const sospechosos = [];
for (const [hex, pct] of colores) {
  if (pct < 5) continue; // ignora colores anecdóticos
  const cerca = marca.some(m => dist(aRgb(hex), aRgb(m)) < tolerancia);
  if (!cerca) sospechosos.push(`${hex} (${pct}%)`);
}
return {
  json: {
    sospechosos,
    fuera_de_marca: sospechosos.length > 0,
    veredicto: sospechosos.length ? 'REVISAR' : 'OK',
    colores: colores.map(c => c[0]).join(' '),
  }
};
```

## Cómo probarla
Sube una pieza que sepas que está bien y otra a la que le hayas cambiado a propósito el azul corporativo por otro azul. La primera debe registrarse como OK y la segunda mandarte el correo. Si te avisa de todo, sube `tolerancia` a 60; si no avisa nunca, bájala a 25.

## Qué puede salir mal
- **Fotografías**: una foto de producto tiene cientos de tonos y disparará avisos. Aplica esta automatización solo a la carpeta de piezas gráficas, o sube el umbral `pct < 5` a `pct < 15`.
- **Perfil de color**: si el diseño viene en CMYK, expórtalo a RGB antes; Cloudinary convierte, pero los tonos bailan.
- **Blancos y negros**: si tu paleta no incluye blanco y negro, añádelos igualmente al array o saltará en toda pieza con fondo blanco.
- **Límite de Drive Trigger**: en n8n nube el sondeo mínimo es cada minuto; con cada 5 minutos vas sobrado.

## Cuánto cuesta
Todo gratis en volumen normal: n8n auto-alojado, Drive y el plan gratuito de Cloudinary (25 créditos/mes). El análisis de color no consume crédito extra frente a una subida normal.
