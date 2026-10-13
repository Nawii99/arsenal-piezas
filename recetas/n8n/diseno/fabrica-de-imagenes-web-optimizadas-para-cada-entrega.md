# Fábrica de imágenes web optimizadas para cada entrega…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Convierte cada PNG o JPG que dejas en una carpeta en versiones comprimidas y a varios anchos, listas para web, sin abrir Photoshop.

## Qué es y qué hace

Detecta imágenes nuevas en la carpeta web-origen, las comprime con TinyPNG, genera tres anchos (400, 800 y 1600 px) y las sube a web-listo con nombres claros, anotando el ahorro de peso en una hoja. Entrada: PNG o JPG; salida: imágenes optimizadas en tres tamaños. Se monta en n8n con la clave de TinyPNG.

## Cómo usarla

1. Pide la clave de TinyPNG
2. Crea las carpetas web-origen y web-listo
3. Prueba con una imagen grande
4. Revisa el ahorro de peso en la hoja

## Cuándo usarla

Cuando entregas piezas para la web del cliente y te piden versiones a 400, 800 y 1600 px, o cuando su web va lenta por imágenes de 4 MB.

## Cómo ganar dinero con ella

Sustituye 20 minutos de exportación manual por entrega y evita facturas de desarrollo por 'optimizar imágenes'.

- Entrega de assets para desarrolladores que necesitan varios tamaños de imagen.
- Optimización de fotos para webs de clientes con imágenes pesadas.
- Paquete mensual de imágenes web para tiendas y blogs con publicaciones frecuentes.

**Precio orientativo:** 30–120 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Detecta imágenes nuevas en `web-origen`, las pasa por la API de TinyPNG (compresión inteligente), genera tres anchos distintos y las sube a `web-listo` con nombres claros, apuntando el ahorro de peso en una hoja. Para diseñadores que entregan assets a desarrolladores o gestionan webs de clientes.

## Lo que necesitas antes
- Cuenta de n8n.
- Clave de TinyPNG: en tinypng.com/developers pones tu correo y te llega la API key. Gratis hasta 500 imágenes al mes.
- Carpetas de Drive `web-origen` y `web-listo` con sus IDs.
- Hoja `Optimizacion` con columnas: `fecha`, `archivo`, `kb_antes`, `kb_despues`, `ahorro_pct`.
- Credenciales de Google Drive y Sheets en n8n.

## Los nodos, en orden
1. **Google Drive Trigger** — File Created en `web-origen`, Poll Every Minute.
2. **IF** — `{{ $json.mimeType }}` starts with `image/`. Rama true continúa.
3. **Google Drive** (`Descargar`) — Operation: Download. File ID `{{ $json.id }}`. Put Output in Field: `data`.
4. **HTTP Request** (`Comprimir`) — Method: POST. URL `https://api.tinify.com/shrink`. Authentication: Generic, Basic Auth, User `api`, Password: tu API key. Body Content Type: n8n Binary File, Input Data Field Name: `data`. Options, Response: Include Response Headers and Status: activado. La respuesta trae `output.url` y `output.size`.
5. **Code** (`Tres tamaños`) — Mode: Run Once for All Items. Código abajo: crea tres items con anchos 400, 800 y 1600.
6. **HTTP Request** (`Redimensionar`) — Method: POST. URL: `{{ $json.output_url }}`. Basic Auth igual que antes. Body: JSON: `{ "resize": { "method": "scale", "width": {{ $json.ancho }} }, "convert": { "type": "image/webp" } }`. Options, Response, Response Format: File, Put Output in Field: `data`.
7. **Google Drive** (`Subir`) — Operation: Upload. Input Data Field Name `data`. File Name: `{{ $json.base }}-{{ $json.ancho }}.webp`. Parent Folder: `web-listo`.
8. **Google Sheets** — Append Row en `Optimizacion` con la fecha, el nombre y los pesos.

## El trozo de código (nodo Code del paso 5)
```javascript
const r = $input.first().json;
const original = $('Google Drive Trigger').first().json;
const base = (original.name || 'imagen').replace(/\.[^.]+$/, '').toLowerCase().replace(/[^a-z0-9]+/g, '-');
const output_url = r.output ? r.output.url : (r.headers && r.headers.location);
const kb_antes = Math.round((r.input ? r.input.size : 0) / 1024);
const kb_despues = Math.round((r.output ? r.output.size : 0) / 1024);
return [400, 800, 1600].map(ancho => ({ json: { ancho, base, output_url, kb_antes, kb_despues, ahorro_pct: kb_antes ? Math.round((1 - kb_despues / kb_antes) * 100) : 0 } }));
```

## Cómo probarla
- Sube un JPG de 3 MB. Deben aparecer tres WebP en `web-listo` y una fila con un ahorro superior al 50 por ciento.
- Abre el WebP de 400 px y comprueba que se ve nítido; si no, cambia `"method": "scale"` por `"fit"` y añade `height`.
- Prueba con un archivo que no sea imagen (un PDF) y confirma que el IF lo descarta.

## Qué puede salir mal
- **Límite de 500 imágenes al mes**: cada archivo original consume 1 compresión más 3 redimensiones, o sea 4 créditos. Son 125 imágenes reales al mes. Si te quedas corto, baja a dos anchos.
- **Imágenes de más de 5 MB**: TinyPNG las rechaza. Añade un IF con `{{ $json.size }}` menor que 5000000.
- **La cabecera Location**: en algunas versiones de n8n la URL de salida viene en `headers.location` en minúscula. El código contempla ambos casos.
- **Transparencia**: el PNG con alfa mantiene la transparencia en WebP; si necesitas JPG, cambia el `convert.type` pero pierdes el alfa.

## Cuánto cuesta
- n8n auto-alojado: 0 euros.
- TinyPNG: 500 compresiones al mes gratis; a partir de ahí unos 0,009 dólares por imagen.
- Coste real: 0 euros para un volumen normal de estudio pequeño.
