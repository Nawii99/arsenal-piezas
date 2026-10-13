# Optimizador de imágenes antes de subirlas…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Coges una carpeta de Drive, sueltas ahí las fotos y te las devuelve comprimidas y en WebP, listas para la web, con el registro de cuánto peso has ahorrado.

## Qué es y qué hace

Vigila una carpeta de entrada en Google Drive; cuando aparece una imagen, la comprime y la convierte a WebP con la API de TinyPNG, la deja en la carpeta de optimizadas con nombre en minúsculas y sin espacios, mueve el original a su carpeta y anota en Google Sheets el peso antes y después. Para diseñadores que preparan material para WordPress o Shopify.

## Cómo usarla

1. Crear la API key de TinyPNG
2. Crear las tres carpetas en Drive
3. Preparar la hoja Imagenes
4. Montar el trigger de Drive en n8n

## Cuándo usarla

Úsalo cuando el cliente te manda fotos de 6 MB del móvil y acabas abriendo Photoshop o webs de compresión de una en una.

## Cómo ganar dinero con ella

Ahorra 10-20 minutos por lote de fotos y mejora la velocidad de la web, que es dinero en tiendas. Coste: 0 € hasta 500 imágenes al mes.

- Preparación de imágenes para webs de clientes que llegan con fotos de móvil pesadas.
- Lote mensual de optimización de imágenes para tiendas online.
- Servicio de optimización incluido en la entrega de web para diseñadores y desarrolladores.

**Precio orientativo:** 60–150 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién.** Vigila una carpeta `1-Entrada` de Google Drive; cuando aparece una imagen, la comprime y la convierte a WebP con la API de TinyPNG, la deja en `2-Optimizadas` con el nombre en minúsculas y sin acentos ni espacios (apto para URL), mueve la original a `3-Originales` y anota en una hoja el peso antes y después.
Para diseñador o desarrollador web que prepara material de clientes para subir a WordPress, Shopify o una web a medida.

**Lo que necesitas antes**
- Cuenta gratuita en `tinypng.com/developers`: te dan una API key por email, 500 compresiones al mes gratis.
- Tres carpetas en Google Drive: `1-Entrada`, `2-Optimizadas`, `3-Originales`. Copia el ID de cada una desde la URL.
- Credencial Google Drive OAuth2 en n8n.
- Hoja `Imagenes` con columnas `fecha`, `nombre`, `kb_antes`, `kb_despues`, `ahorro`.

**Los nodos, en orden**
1. **Google Drive Trigger** — Trigger On: Specific Folder, la carpeta `1-Entrada`, Event: File Created, Poll Times: Every Minute.
2. **IF** (`Es imagen?`) — String `{{ $json.mimeType }}` `contains` `image/`.
3. **Google Drive** (`Descargar`) — Operation: Download, File ID `{{ $json.id }}`, Put Output File in Field `data`.
4. **HTTP Request** (`Comprimir`) — Method POST, URL `https://api.tinify.com/shrink`. Authentication: Generic > Basic Auth, con una credencial cuyo usuario sea `api` y contraseña tu API key. Body Content Type: `n8n Binary File`, Input Data Field Name `data`. Options > Response > Include Response Headers and Status: activado.
5. **HTTP Request** (`Convertir a WebP`) — Method POST, URL `{{ $json.body.output.url }}`, misma Basic Auth, Body JSON: `{ "convert": { "type": "image/webp" } }`. Response > Format: `File`, Put Output in Field `data`.
6. **Code** (`Nombre limpio`) — Mode: Run Once for Each Item. Código abajo.
7. **Google Drive** (`Subir optimizada`) — Operation: Upload, Input Data Field Name `data`, File Name `{{ $json.nombre }}`, Parent Folder `2-Optimizadas`.
8. **Google Drive** (`Mover original`) — Operation: Move File, File ID `{{ $('Google Drive Trigger').item.json.id }}`, Destino `3-Originales`.
9. **Google Sheets** — Append Row con pesos y ahorro.

**El código del nodo `Nombre limpio`**
```js
const original = $('Google Drive Trigger').item.json.name || 'imagen.jpg';
const base = original.replace(/\.[^.]+$/, '');
const limpio = base
  .normalize('NFD').replace(/[̀-ͯ]/g, '')
  .toLowerCase()
  .replace(/[^a-z0-9]+/g, '-')
  .replace(/^-+|-+$/g, '')
  .slice(0, 60);
const antes = Number($('Google Drive Trigger').item.json.size || 0);
const despues = Number($('Comprimir').item.json.body?.output?.size || 0);
return { json: { nombre: `${limpio}.webp`, kb_antes: Math.round(antes / 1024), kb_despues: Math.round(despues / 1024), ahorro: antes ? Math.round((1 - despues / antes) * 100) + '%' : '' } };
```

**Cómo probarla**
- Sube una foto JPG de 4 MB a `1-Entrada` y espera un minuto. Debe aparecer un `.webp` de unos 200-400 KB en `2-Optimizadas` y la original en `3-Originales`.
- Abre el WebP en el navegador para verificar que no se ve pastoso; si molesta, quita el paso 5 y quédate con el JPG comprimido.

**Qué puede salir mal**
- Límite gratuito de 500 imágenes al mes: cada foto consume 1 compresión (la conversión a WebP no suma otra). Si te pasas, la API responde 429; añade un IF que avise en vez de fallar en silencio.
- El Drive Trigger puede tardar hasta un minuto: es normal, no es que esté roto.
- Bucle infinito: nunca pongas la carpeta de salida dentro de la de entrada.
- Imágenes con transparencia: pasar PNG a WebP la conserva; pasar a JPG no. No conviertas logos a JPG.
- Los nombres con `ñ`, tildes y espacios rompen URLs en algunos servidores; por eso el Code los limpia.

**Cuánto cuesta**
- TinyPNG: 500 imágenes al mes gratis; después 0,009 $ por imagen hasta 10.000.
- Drive y Sheets: gratis. n8n autoalojado: gratis.
