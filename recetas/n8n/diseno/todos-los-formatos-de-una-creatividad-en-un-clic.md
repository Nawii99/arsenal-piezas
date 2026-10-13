# Todos los formatos de una creatividad en un clic…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Sueltas un diseño en una carpeta de Drive y te devuelve la misma pieza recortada y adaptada a 1:1, 4:5, 9:16, 16:9 y banner web, sin deformar el motivo.

## Qué es y qué hace

Vigila una carpeta de Drive, sube cada diseño a Cloudinary y genera automáticamente versiones 1:1, 4:5, 9:16, 16:9 y banner con recorte que respeta el sujeto. Entrada: archivo de imagen; salida: pack de formatos en la carpeta de salida. Se monta en n8n con Drive y Cloudinary; Make y Zapier pueden hacer algo parecido con sus conectores.

## Cómo usarla

1. Crea la cuenta gratuita de Cloudinary
2. Crea las carpetas Entradas y Formatos listos
3. Define los tamaños en el flujo
4. Prueba con un diseño real

## Cuándo usarla

Úsalo cuando entregas la misma campaña para Instagram, Stories, YouTube y web y acabas exportando ocho versiones a mano de cada arte.

## Cómo ganar dinero con ella

Quita unos 20 minutos de exportado por campaña. Con 8 campañas al mes, casi 3 horas; y evita el clásico reenvío por entregar el formato equivocado.

- Packs multiformato para diseñadores freelance que entregan campañas a clientes.
- Adaptación de creatividades para agencias de social media con varios canales.
- Servicio mensual de formatos para marcas con campañas recurrentes.

**Precio orientativo:** 60–200 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una carpeta de Google Drive, sube cada diseño nuevo a Cloudinary y genera automáticamente todos los tamaños que usas, con recorte inteligente que respeta el sujeto de la imagen. Para diseñadores freelance y responsables de marketing que entregan packs multiformato.

## Lo que necesitas antes
- n8n (auto-alojado gratis o nube).
- Cuenta de Google con Drive conectada a n8n vía OAuth (console.cloud.google.com, activa Google Drive API).
- Cuenta gratuita en cloudinary.com. En Settings > API Keys tienes Cloud Name, API Key y API Secret.
- Dos carpetas en Drive: «Entradas» y «Formatos listos». Apunta el ID de cada una (está en la URL de la carpeta).

## Los nodos, en orden
1. **Google Drive Trigger** — Trigger On: Specific Folder, Folder: «Entradas», Event: File Created, Poll Times: Every Minute.
2. **Google Drive** — Resource: File, Operation: Download. File: By ID, valor `={{ $json.id }}`. Output field: `data`.
3. **HTTP Request** (renombra a «Subir a Cloudinary») — Method: POST, URL: `https://api.cloudinary.com/v1_1/TU_CLOUD_NAME/image/upload`. Authentication: Generic > Basic Auth con usuario = API Key y contraseña = API Secret. Body Content Type: Form-Data, con dos parámetros: `file` de tipo n8n Binary File con Input Data Field Name `data`, y `upload_preset` con el nombre de un preset sin firmar que crees en Settings > Upload.
4. **Code** — Mode: Run Once for All Items. Pega el código de abajo: construye una URL por formato usando las transformaciones de Cloudinary.
5. **Split In Batches** («Loop Over Items») — Batch Size: 1.
6. **HTTP Request** (renombra a «Descargar formato») — Method: GET, URL: `={{ $json.url }}`, Options > Response Format: File, Put Output in Field: `data`.
7. **Google Drive** — Operation: Upload. File Name: `={{ $json.nombre }}`. Folder: «Formatos listos». Input Data Field Name: `data`.
8. Conecta la salida a **Loop Over Items** otra vez.
9. **Slack** (o Gmail si no usas Slack) — Operation: Send Message. Text: `Listos los 5 formatos de {{ $('Google Drive Trigger').item.json.name }}`. Conéctalo a la salida «done» del loop.

## El nodo Code
```javascript
const cloud = 'TU_CLOUD_NAME';
const publicId = $('Subir a Cloudinary').first().json.public_id;
const base = $('Google Drive Trigger').first().json.name.replace(/\.[^.]+$/, '');
const formatos = [
  { etiqueta: 'feed-1x1',    t: 'c_fill,g_auto,w_1080,h_1080' },
  { etiqueta: 'feed-4x5',    t: 'c_fill,g_auto,w_1080,h_1350' },
  { etiqueta: 'stories-9x16',t: 'c_fill,g_auto,w_1080,h_1920' },
  { etiqueta: 'youtube-16x9',t: 'c_fill,g_auto,w_1920,h_1080' },
  { etiqueta: 'banner-web',  t: 'c_fill,g_auto,w_1600,h_600' },
];
return formatos.map(f => ({
  json: {
    nombre: `${base}-${f.etiqueta}.jpg`,
    url: `https://res.cloudinary.com/${cloud}/image/upload/${f.t},q_auto,f_auto/${publicId}.jpg`,
  }
}));
```

## Cómo probarla
Sube un JPG o PNG a la carpeta «Entradas» con el workflow en modo test. Comprueba que en «Formatos listos» aparecen los cinco archivos y ábrelos: el recorte `g_auto` debe mantener el producto o la cara centrados. Si no acierta, cambia `g_auto` por `g_face` para retratos o `g_north` para dejar aire arriba.

## Qué puede salir mal
- **Diseños con texto que se corta**: el recorte automático no sabe de tipografía. Para piezas con mucho texto usa `c_pad,b_auto` en vez de `c_fill` para que añada margen en lugar de recortar.
- **Archivos que no son imagen**: añade un nodo **IF** tras el trigger con la condición `{{ $json.mimeType }}` contains `image` para descartar PDFs.
- **Se dispara dos veces**: si mueves el archivo dentro de la carpeta, Drive puede lanzar otro evento. Mueve los originales a una carpeta «Procesados» con un nodo Google Drive > Move al final.
- **Límite de Cloudinary**: el plan gratuito da 25 créditos al mes (unas 25.000 transformaciones). De sobra para uso normal.

## Cuánto cuesta
n8n auto-alojado y Drive: gratis. Cloudinary: plan gratuito suficiente para un freelance; el siguiente escalón ronda los 89 $/mes y no lo necesitarás salvo volumen alto.
