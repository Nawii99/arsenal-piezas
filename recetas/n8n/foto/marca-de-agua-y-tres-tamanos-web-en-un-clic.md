# Marca de agua y tres tamaños web en un clic…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Coge las fotos que subes a una carpeta, les pone tu marca de agua y genera versión web, versión redes y miniatura, todo sin abrir Photoshop. Para fotógrafos y tiendas que publican mucho.

## Qué es y qué hace

Detecta cada foto nueva en una carpeta de Drive, superpone el logo en la esquina con el nodo Edit Image de n8n y guarda tres versiones de 2000, 1080 y 400 píxeles en subcarpetas distintas. Mantiene el mismo aspecto en todas las publicaciones sin abrir un editor. Requiere solo credenciales de Drive y un logo en PNG con fondo transparente.

## Cómo usarla

1. Sube el logo en PNG transparente a Drive
2. Crea las cuatro carpetas
3. Conecta Drive en n8n
4. Prueba con 10 fotos antes de activarlo

## Cuándo usarla

Cuando publicas fotos en tu web, en el blog o en portfolios y pierdes tardes redimensionando y poniendo el logo a mano.

## Cómo ganar dinero con ella

Ahorra unos 2 minutos por foto. Con 200 fotos al mes son casi 7 horas, o los 150-250 € que cobraría un becario por hacerlo.

- Montaje del flujo de marca de agua y tamaños para fotógrafos que publican en web y redes.
- Servicio mensual de preparación de imágenes para tiendas online con altas de producto frecuentes.
- Plantilla de exportación en tres tamaños vendida a agencias que entregan material a sus clientes.

**Precio orientativo:** 120–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Detecta cada foto nueva en una carpeta de Drive, le superpone tu logo en la esquina, y guarda tres versiones (2000 px, 1080 px y 400 px) en tres subcarpetas distintas.
Para fotógrafos, tiendas online y agencias que publican en web y redes y quieren un aspecto uniforme sin trabajo manual.

## Lo que necesitas antes
- n8n (autoalojado o Cloud). El nodo Edit Image viene incluido, no hace falta instalar nada.
- Credencial de Google Drive OAuth2 (proyecto en console.cloud.google.com con Google Drive API activada).
- Tu logo en PNG con fondo transparente, ya subido a Drive, y su ID (está en la URL del archivo, entre /d/ y /view).
- Cuatro carpetas en Drive: 00_ORIGINALES, WEB_2000, REDES_1080, MINI_400.

## Los nodos, en orden
1) **Google Drive Trigger**. Event: File Created. Folder: 00_ORIGINALES. Poll Times: Every Minute.
2) **Google Drive** (Download). Operation: Download. File ID: `{{ $json.id }}`. Deja Put Output File in Field: `data`.
3) **Google Drive1** (Download logo). Operation: Download. File ID: el ID fijo de tu logo. En Options > Put Output File in Field escribe `logo`.
4) **Merge**. Mode: Combine, Combine By: Position. Entrada 1 la foto, entrada 2 el logo. Así viajan los dos binarios en el mismo item.
5) **Edit Image** (Marca de agua). Operation: Composite. Property Name: `data`. Composite Image Property: `logo`. Operator: Over. Position X: 40. Position Y: 40. Gravity: SouthEast si tu versión lo ofrece.
6) **Edit Image1** (Web). Operation: Resize. Width: 2000. Height: 2000. Resize Option: Maximum Area (respeta la proporción). Format: jpeg. Quality: 82.
7) **Google Drive2** (Upload). Operation: Upload. Input Data Field Name: `data`. File Name: `{{ $('Google Drive Trigger').item.json.name.replace(/\.[^.]+$/, '') }}-web.jpg`. Parent Folder: WEB_2000.
8) Desde el nodo 5, saca una segunda rama: **Edit Image2** (Redes). Resize a 1080x1080, Resize Option: Maximum Area, Format jpeg, Quality 85. Detrás, **Google Drive3** subiendo a REDES_1080 con sufijo `-redes.jpg`.
9) Tercera rama desde el nodo 5: **Edit Image3** (Mini). Resize a 400x400, Resize Option: Fill (recorta cuadrado). Detrás **Google Drive4** subiendo a MINI_400 con sufijo `-mini.jpg`.
10) Opcional: **Google Drive5** (Move). Operation: Move File. Mueve el original a una carpeta PROCESADAS para que el trigger no lo vuelva a ver.

## Cómo probarla
Sube una foto apaisada y otra vertical. Comprueba que el logo cae siempre abajo a la derecha y que ninguna sale deformada. Si el logo sale gigante, redimensiónalo antes con otro Edit Image (Resize a 300 px de ancho) entre el nodo 3 y el Merge.

## Qué puede salir mal
- **El logo tapa la foto**: es que tu PNG es de 3000 px. Redúcelo a 250-400 px de ancho.
- **Fotos con perfil de color raro**: si los JPEG salen apagados, añade en Edit Image la operación Multi Step con un paso de conversión a sRGB, o exporta desde Lightroom ya en sRGB.
- **Fotos giradas**: algunas cámaras guardan la orientación solo en el EXIF. Añade un primer Edit Image con Operation: Rotate y ángulo `{{ $json.imageOrientation === 6 ? 90 : 0 }}` o, más simple, exporta desde tu revelador ya orientado.
- **Bucle infinito**: si subes los resultados a la misma carpeta que vigila el trigger, el flujo se retroalimenta. Usa siempre carpetas distintas.

## Cuánto cuesta
Gratis del todo si autoalojas n8n. En n8n Cloud, cada foto consume unas 8 ejecuciones de nodo; el plan gratuito aguanta bien un volumen pequeño y el de pago arranca en unos 24 €/mes. Google Drive gratis hasta 15 GB.
