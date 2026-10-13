# Marca de agua y tamaños web automáticos…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Cada foto que sueltas en una carpeta de Drive sale sola con tu marca de agua y en tres tamaños listos para web, redes e impresión.

## Qué es y qué hace

Vigila una carpeta de Google Drive. Cada foto nueva se sube a Cloudinary, recibe tu marca de agua y genera tres versiones: web de 1600 px, redes de 1080x1080 y original con logo. Las deja ordenadas en subcarpetas de Drive. Entran fotos y salen tres tamaños en carpetas. Para fotógrafos, diseñadores y tiendas que suben muchas imágenes, con n8n y una cuenta gratuita de Cloudinary.

## Cómo usarla

1. Crea las cuatro carpetas de Drive
2. Sube tu logo a Cloudinary con su ID público
3. Configura los tres tamaños en n8n
4. Prueba con diez fotos antes de usarlo a diario

## Cuándo usarla

Úsalo cuando entregas fotos a clientes o subes muchas imágenes a tu web y pierdes tiempo abriendo Photoshop para poner el logo y redimensionar una por una.

## Cómo ganar dinero con ella

Ahorras entre 2 y 5 minutos por foto. Con 200 fotos al mes son unas 10 horas menos de trabajo manual repetido.

- Configuración de marca de agua y tamaños para fotógrafos que entregan galerías, cobrada por puesta en marcha.
- Gestión mensual del archivo de imágenes para tiendas online con alta frecuencia de fotos, por cuota.
- Plantilla de procesado de fotos vendida a estudios que quieren ahorrar retoque mecánico.

**Precio orientativo:** 150–300 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una carpeta de Google Drive llamada `1-ENTRADA`. Cuando aparece una foto nueva, la sube a Cloudinary, le aplica tu marca de agua y genera tres versiones (web 1600px, redes 1080x1080 y original con logo), y las deja ordenadas en subcarpetas de Drive.
Pensado para el fotógrafo, el diseñador o la tienda online que repite el mismo retoque mecánico decenas de veces por semana.

## Lo que necesitas antes
- Cuenta de Google (Drive) y n8n. Vale n8n Cloud plan gratuito o n8n auto-alojado con Docker en tu ordenador o en un VPS de 5 €/mes.
- Cuenta gratuita en Cloudinary: cloudinary.com. En el panel, arriba, tienes `Cloud name`, `API Key` y `API Secret`. Cópialos.
- Tu logo en PNG con fondo transparente. Súbelo a Cloudinary a mano y ponle de nombre público `marca_agua` (Media Library > Upload > pestaña Advanced > Public ID).
- En Drive crea cuatro carpetas: `1-ENTRADA`, `2-WEB`, `3-REDES`, `4-ORIGINAL-CON-LOGO`. Apunta el ID de cada una (está en la URL, después de `/folders/`).
- En n8n: Credentials > New > `Google Drive OAuth2 API`, y sigue el asistente. Necesitas activar la Google Drive API en console.cloud.google.com.

## Los nodos, en orden
1. **Google Drive Trigger** — Resource: `File`, Event: `Created`, Watch: `Specific Folder`, y eliges `1-ENTRADA`. Poll Times: cada minuto.
2. **IF** — para no procesar vídeos ni PDF. Condición String: `{{ $json.mimeType }}` → `contains` → `image/`. Solo sigue la rama `true`.
3. **Google Drive** — Operation: `Download`. File ID: `{{ $json.id }}`. Deja el nombre del campo binario en `data`.
4. **HTTP Request** (llámalo `Subir a Cloudinary`) — Method: `POST`. URL: `https://api.cloudinary.com/v1_1/TU_CLOUD_NAME/image/upload`. Authentication: `Generic Credential Type` > `Basic Auth`, con usuario = API Key y contraseña = API Secret. Body Content Type: `n8n Binary File`, Input Data Field Name: `data`. En Body Parameters añade `upload_preset` con el valor de un preset sin firmar que crees en Settings > Upload, y `folder` con `entradas`.
5. **Code** (llámalo `Construir URLs`) — genera las tres URL de transformación. El código está abajo.
6. **HTTP Request** (`Bajar versión web`) — Method: `GET`, URL: `{{ $json.url_web }}`, Response Format: `File`, Put Output in Field: `data`.
7. **Google Drive** — Operation: `Upload`. Parent Folder: `2-WEB`. File Name: `{{ $json.nombre }}-web.jpg`. Input Data Field Name: `data`.
8. Duplica los pasos 6 y 7 dos veces más, cambiando `url_web` por `url_redes` y `url_logo`, y las carpetas por `3-REDES` y `4-ORIGINAL-CON-LOGO`.
9. **Gmail** — Operation: `Send`. A ti mismo, asunto `Procesada: {{ $json.nombre }}`. Opcional, pero útil los primeros días.

## El código del nodo Code
```javascript
// Modo: Run Once for Each Item
const cloud = 'TU_CLOUD_NAME';
const publicId = $json.public_id;
const nombre = (publicId.split('/').pop() || 'foto').replace(/[^a-zA-Z0-9_-]/g, '_');
const base = `https://res.cloudinary.com/${cloud}/image/upload`;
// La marca de agua: 18% de ancho, esquina inferior derecha, 70% de opacidad
const marca = 'l_marca_agua,w_0.18,fl_relative,o_70,g_south_east,x_30,y_30';
return {
  json: {
    nombre,
    url_web:    `${base}/c_limit,w_1600,q_auto:good,f_jpg/${marca}/${publicId}.jpg`,
    url_redes:  `${base}/c_fill,g_auto,w_1080,h_1080,q_auto:good,f_jpg/${marca}/${publicId}.jpg`,
    url_logo:   `${base}/q_auto:best,f_jpg/${marca}/${publicId}.jpg`
  }
};
```

## Cómo probarla
- Sube UNA foto a `1-ENTRADA` y pulsa `Test workflow` en n8n. Mira el resultado nodo a nodo.
- Copia la `url_web` que devuelve el Code y ábrela en el navegador: si la marca de agua no sale, el `public_id` del logo está mal escrito.
- Cuando funcione con una foto, sube cinco de golpe y luego activa el workflow con el interruptor `Active`.

## Qué puede salir mal
- **El trigger de Drive tarda hasta un minuto.** Es normal, no es un fallo. Si subes 50 fotos a la vez, n8n las va cogiendo en tandas.
- **Fotos gigantes.** Cloudinary gratis acepta hasta 10 MB por archivo. Si disparas con RAW convertidos a JPG de 25 MB, mete antes un nodo **HTTP Request** a Cloudinary con `eager` o reduce en cámara.
- **Duplicados.** Si mueves una foto de vuelta a `1-ENTRADA` se vuelve a procesar. Solución limpia: después del paso 8, añade un **Google Drive** con Operation `Move` que saque el original de `1-ENTRADA` a una carpeta `0-PROCESADAS`.
- **Nombres con tildes o espacios.** El Code ya los limpia; no toques esa línea.
- **Error 420 o 429 de Cloudinary.** Has pasado el límite del minuto. Añade un nodo **Wait** de 2 segundos antes del paso 4.

## Cuánto cuesta
- n8n auto-alojado: 0 €. n8n Cloud tiene plan gratuito de pruebas y luego arranca sobre 20 €/mes.
- Cloudinary gratis: 25 créditos al mes, que dan de sobra para unas 20.000 transformaciones o 25 GB de tráfico. Si entregas bodas enteras te quedarás corto y el siguiente plan ronda los 89 $/mes; en ese caso pásate a un n8n auto-alojado con el nodo **Edit Image** nativo, que es gratis del todo aunque da menos calidad de marca de agua.
- Google Drive: gratis hasta 15 GB.
