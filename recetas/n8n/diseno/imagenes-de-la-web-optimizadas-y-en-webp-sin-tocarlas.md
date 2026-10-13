# Imágenes de la web optimizadas y en WebP sin tocarlas…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Coge las imágenes que preparas para la web del cliente, las comprime, las convierte a WebP y te dice cuántos kilos has ahorrado en cada una.

## Qué es y qué hace

Vigila una carpeta de Drive, comprime cada imagen con la API de TinyPNG, la convierte a WebP con el mismo nombre en la carpeta de salida y anota en una hoja el peso antes y después. Entrada: JPG o PNG; salida: WebP optimizado y ahorro por archivo. Se monta en n8n con la clave gratuita de TinyPNG (500 imágenes al mes).

## Cómo usarla

1. Pide la clave de TinyPNG
2. Crea las carpetas de origen y de salida
3. Prueba con cinco imágenes
4. Revisa el ahorro en la hoja

## Cuándo usarla

Úsalo cuando entregas piezas para web o tienda online y las fotos pesadas te tiran la velocidad de carga y las notas de PageSpeed del cliente.

## Cómo ganar dinero con ella

Evita pagar a un desarrollador por optimizar imágenes (60-90 €/h) y mejora la conversión de la web: cada segundo de carga se lleva ventas.

- Optimización de imágenes para diseñadores que entregan material para web.
- Servicio mensual de assets optimizados para tiendas online con catálogos grandes.
- Auditoría visual de rendimiento para webs de clientes con mala puntuación.

**Precio orientativo:** 30–120 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una carpeta de Drive, pasa cada imagen por el compresor de TinyPNG, la convierte a WebP, la guarda con el mismo nombre en la carpeta de salida y anota el peso antes y después en una hoja. Para diseñadores que entregan material para web y quieren que llegue ya listo para producción.

## Lo que necesitas antes
- n8n.
- Google Drive y Sheets por OAuth.
- Clave gratuita de TinyPNG en tinypng.com/developers: te la mandan por correo. El plan gratuito son 500 imágenes al mes.
- Dos carpetas en Drive: «Web sin optimizar» y «Web optimizada».
- Hoja «Optimización» con columnas: `fecha`, `archivo`, `kb_antes`, `kb_despues`, `ahorro_pct`.

## Los nodos, en orden
1. **Google Drive Trigger** — Specific Folder «Web sin optimizar», Event: File Created, Poll: Every Minute.
2. **IF** — `{{ $json.mimeType }}` contains `image`.
3. **Google Drive** — Operation: Download, File By ID `={{ $json.id }}`, campo `data`.
4. **HTTP Request** (renombra a «Comprimir») — Method: POST, URL `https://api.tinify.com/shrink`. Authentication: Generic > Basic Auth, usuario `api`, contraseña: tu clave de TinyPNG. Body Content Type: n8n Binary File, Input Data Field Name `data`. La respuesta trae `output.url`, `input.size` y `output.size`.
5. **HTTP Request** (renombra a «Convertir a WebP») — Method: POST, URL `={{ $json.output.url }}`. Misma Basic Auth. Body Content Type: JSON con `{ "convert": { "type": "image/webp" } }`. Options > Response Format: File, campo `data`.
6. **Code** — Mode: Run Once for Each Item. Calcula el ahorro (código abajo).
7. **Google Drive** — Operation: Upload. File Name `={{ $json.nombre_webp }}`. Folder: «Web optimizada». Input Data Field Name: `data`.
8. **Google Sheets** — Append Row con fecha, archivo, kb antes, kb después y porcentaje ahorrado.

## El nodo Code
```javascript
const antes = $('Comprimir').item.json.input.size;
const despues = $('Comprimir').item.json.output.size;
const original = $('Google Drive Trigger').item.json.name;
return { json: {
  nombre_webp: original.replace(/\.[^.]+$/, '') + '.webp',
  archivo: original,
  fecha: new Date().toISOString().slice(0, 10),
  kb_antes: Math.round(antes / 1024),
  kb_despues: Math.round(despues / 1024),
  ahorro_pct: Math.round((1 - despues / antes) * 100),
}};
```

## Cómo probarla
Sube un JPG grande, de 2-3 MB. Comprueba que en «Web optimizada» aparece el `.webp`, ábrelo y compáralo con el original al 100 % de zoom: no deberías notar diferencia. Mira la fila de la hoja: lo normal es un ahorro del 60-80 %.

## Qué puede salir mal
- **Se pierde la transparencia**: WebP la mantiene, pero si el cliente necesita compatibilidad con navegadores muy antiguos deja también el PNG original.
- **Logotipos**: para logos usa SVG, no WebP. Añade un IF que descarte los `.svg` y los copie tal cual.
- **Error 429 de TinyPNG**: has pasado las 500 imágenes del mes. Añade un nodo **Wait** de 2 segundos antes del paso 4 y controla el volumen.
- **Nombres con acentos**: Drive los admite, pero para web renombra en el Code con `.normalize('NFD').replace(/[̀-ͯ]/g, '')`.

## Cuánto cuesta
Gratis hasta 500 imágenes al mes con TinyPNG; a partir de ahí unos 0,009 $ por imagen. n8n, Drive y Sheets sin coste.
