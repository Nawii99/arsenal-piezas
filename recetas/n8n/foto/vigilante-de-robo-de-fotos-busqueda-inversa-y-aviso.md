# Vigilante de robo de fotos: búsqueda inversa y aviso…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Coge tus fotos publicadas, hace una búsqueda inversa por internet cada semana y te avisa de las webs que las están usando sin tu permiso.

## Qué es y qué hace

Toma una lista de URLs de tus imágenes públicas, las pasa cada semana por la búsqueda inversa de Google Lens mediante SerpApi, descarta tus dominios y los conocidos, y envía por email las apariciones nuevas con su enlace. Ayuda a detectar usos sin licencia ni crédito. Requiere cuenta de SerpApi y dos hojas de Google Sheets.

## Cómo usarla

1. Crea cuenta en SerpApi y guarda la API key
2. Prepara las hojas Mis imágenes e Hallazgos
3. Revisa el primer informe
4. Que lo revise un profesional

## Cuándo usarla

Cuando vendes o publicas imágenes propias y sospechas que circulan por webs, marketplaces o perfiles ajenos sin licencia ni crédito.

## Cómo ganar dinero con ella

Detectar un solo uso indebido puede acabar en una licencia retroactiva de 150-600 €, y te ahorra buscar a mano cada imagen una por una.

- Instalación de la vigilancia de imágenes para fotógrafos e ilustradores que quieren defender su obra.
- Seguimiento mensual de usos indebidos para una agencia con catálogo de imágenes propias.
- Informe trimestral de apariciones para tiendas que publican fotos de producto de terceros.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Para fotógrafos, ilustradores y tiendas que publican imágenes propias: toma una lista de URLs de tus imágenes públicas, las pasa por la búsqueda inversa de Google Lens vía SerpApi, filtra los dominios que no son tuyos ni conocidos, y te manda un correo semanal con los hallazgos nuevos.

## Lo que necesitas antes
- n8n (Cloud o auto-alojado).
- Cuenta en serpapi.com. Plan gratuito: 100 búsquedas al mes. La API Key está en Dashboard > Your Account > API Key.
- Una hoja de Google Sheets «Mis imágenes» con columnas: url_imagen, titulo, activo (sí/no).
- Otra hoja «Hallazgos» con columnas: fecha, titulo, dominio, url_pagina, url_imagen, estado.
- Una lista de dominios propios y permitidos (tu web, tu Instagram, tus marketplaces, tu banco de imágenes).

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: Weeks, Trigger on Weekday: Monday, Trigger at Hour: 8.
2. **Google Sheets** — Operation: Get Row(s), hoja «Mis imágenes», Filters: columna `activo` igual a `sí`.
3. **Loop Over Items** — Batch Size: 1. En Options del nodo pon Reset desactivado.
4. **HTTP Request «Google Lens»** — Method: GET, URL: `https://serpapi.com/search.json`. Send Query Parameters activado con: `engine` = `google_lens`, `url` = `={{ $json.url_imagen }}`, `hl` = `es`, `country` = `es`, `api_key` = tu clave (guárdala mejor en Credentials > Header Auth o en una variable de entorno). En Settings: Retry On Fail 2 intentos, y Batching: 1 petición cada 3000 ms.
5. **Code «Filtrar dominios ajenos»** — con el código de abajo.
6. **Google Sheets** — Operation: Get Row(s) sobre «Hallazgos» para leer lo ya registrado.
7. **Code «Quitar repetidos»** o un nodo **Remove Duplicates** (Operation: Remove Items Seen in Previous Executions, Keep Items Where: Value Is New, Value to Dedupe On: `={{ $json.url_pagina }}`).
8. **IF** — `{{ $items().length }}` Larger than 0.
9. **Google Sheets** — Operation: Append en «Hallazgos» con estado = `nuevo`.
10. **Gmail** — Operation: Send. Subject: `Posibles usos no autorizados de tus fotos ({{ $items().length }})`. Message Type: HTML, con una lista de enlaces.

## El trozo de código (nodo Code «Filtrar dominios ajenos»)
```javascript
const PERMITIDOS = ['tuweb.com', 'instagram.com', 'facebook.com', 'etsy.com', 'shopify.com', 'pinterest.com', 'linkedin.com'];
const titulo = $('Loop Over Items').item.json.titulo;
const urlOriginal = $('Loop Over Items').item.json.url_imagen;
const salida = [];
for (const item of $input.all()) {
  const visuales = item.json.visual_matches || [];
  for (const v of visuales) {
    let dominio = '';
    try { dominio = new URL(v.link).hostname.replace('www.', ''); } catch (e) { continue; }
    const permitido = PERMITIDOS.some(p => dominio === p || dominio.endsWith('.' + p));
    if (permitido) continue;
    salida.push({ json: {
      fecha: new Date().toISOString().slice(0, 10),
      titulo,
      dominio,
      url_pagina: v.link,
      url_imagen: urlOriginal,
      estado: 'nuevo'
    }});
  }
}
return salida;
```

## Cómo probarla
- Mete en «Mis imágenes» una sola URL, de una foto tuya que sepas que está copiada en algún sitio.
- Ejecuta a mano y mira la salida cruda del nodo HTTP: debe traer un array `visual_matches`. Si viene vacío, tu URL no es accesible públicamente (prueba a abrirla en una ventana de incógnito).
- Añade tu propio dominio a PERMITIDOS y vuelve a ejecutar: tu web debe desaparecer de los resultados.

## Qué puede salir mal
- **Te quedas sin búsquedas**: 100/mes en el plan gratuito significa 25 imágenes a la semana. Marca `activo = no` en las que no te preocupan y rota la lista.
- **Falsos positivos**: agregadores, CDN y cachés de buscadores aparecen constantemente. Amplía PERMITIDOS con cada revisión semanal; en dos o tres semanas el ruido baja mucho.
- **URL privada**: si tus imágenes están tras login o firmadas con caducidad, Lens no las ve. Usa la versión pública de baja resolución.
- **No es prueba legal automática**: antes de reclamar, guarda captura con fecha (puedes archivar la url_pagina en web.archive.org desde otro nodo HTTP Request a `https://web.archive.org/save/{{ $json.url_pagina }}`).
- **Reclamar sin asesoría**: usa la hoja para documentar y consulta con un abogado o envía primero un aviso de retirada al hosting.

## Cuánto cuesta
n8n, Sheets y Gmail: 0 €. SerpApi: gratis 100 búsquedas al mes; el plan de pago más pequeño son 75 $/mes por 5.000 búsquedas, solo interesante si vives de licenciar imágenes.
