# Previas con marca de agua y hoja de contactos…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Coge las fotos de una sesión, las reduce, les pone tu marca de agua y monta una hoja de contactos numerada, todo sin abrir Photoshop.

## Qué es y qué hace

Procesa en lote una carpeta de JPG de una sesión: reduce cada foto a 1200 px de lado largo, estampa tu marca de agua semitransparente, añade un número visible y deja las previas en su carpeta. Entra una carpeta de Drive y sale otra con previas protegidas y un email con el recuento. Se monta en n8n con el nodo Edit Image, sin Photoshop. Para fotógrafos de evento, retrato o producto que entregan selección antes del retoque.

## Cómo usarla

1. Pon tu marca de agua en PNG transparente
2. Crea las carpetas originales y previas en Drive
3. Monta el flujo en n8n con Edit Image
4. Prueba con una sesión antes de usarlo

## Cuándo usarla

Úsalo cuando entregues previsualizaciones para que el cliente elija, o mandes propuestas a marcas y no quieras que circule material sin proteger.

## Cómo ganar dinero con ella

Preparar 200 previas a mano con marca de agua son 45 minutos por sesión. A cuatro sesiones al mes, tres horas recuperadas y cero fotos sueltas sin firmar.

- Previas protegidas para bodas y eventos, entregadas en 24 horas con marca de agua y número por foto…
- Preparación de material para marcas: envías propuestas con fotos sin firmar y sin riesgo de circulación…
- Configuración del flujo de previas para otros fotógrafos, con soporte mensual…

**Precio orientativo:** 90–250 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Procesa en lote una carpeta de JPG: reduce cada foto a 1200 px de lado largo, le estampa tu logotipo semitransparente en una esquina, le pone un número visible para que el cliente pueda referirse a ella, y deja el resultado en la carpeta de previas.
Al terminar te manda un email con el recuento. Es para fotógrafos de evento, retrato o producto que entregan selección antes del retoque.

## Lo que necesitas antes
- n8n (vale el auto-alojado; el nodo **Edit Image** viene incluido, no necesitas instalar nada).
- Tu marca de agua en PNG con fondo transparente, blanca, de unos 400 px de ancho, guardada en el disco accesible por n8n, por ejemplo `/data/marca.png`.
- Dos carpetas en Drive: `SESIONES/NombreSesion/originales` y `SESIONES/NombreSesion/previas`.
- Credenciales de Google Drive y Gmail en n8n.

## Los nodos, en orden
1. **n8n Form Trigger** — un campo: `carpeta_id` (el ID de la carpeta de originales en Drive, que sale de la URL). Así lanzas el proceso sesión a sesión sin tocar el flujo.
2. **Google Drive** — Operation: `Search`, Query String: `'{{ $json.carpeta_id }}' in parents and mimeType contains 'image/' and trashed = false`, Return All activado.
3. **Sort** — Field: `name`, Order: `ascending`. Así la numeración sigue el orden de disparo.
4. **Code** — añade el número correlativo a cada item: `return $input.all().map((item, i) => ({ json: { ...item.json, num: String(i + 1).padStart(4, '0') } }));`
5. **Split In Batches** — Batch Size: `1`. Procesar imágenes consume memoria; de una en una.
6. **Google Drive** — Operation: `Download`, File ID: `{{ $json.id }}`, campo binario `data`.
7. **Edit Image** (renómbralo «Reducir») — Operation: `Resize`, Width: `1200`, Height: `1200`, Resize Option: `Maximum area` (mantiene proporción y no agranda las pequeñas). Property Name: `data`.
8. **Read/Write Files from Disk** — Operation: `Read File(s) From Disk`, File Selector: `/data/marca.png`, Property Name: `marca`. Conéctalo aparte y únelo con un **Merge** en modo `Combine by Position`, o más sencillo: usa la operación `Composite` del Edit Image indicando la ruta del archivo.
9. **Edit Image** (renómbralo «Marca de agua») — Operation: `Composite`, Composite Image Property: `marca`, Position X: `40`, Position Y: `40`, Operator: `Over`.
10. **Edit Image** (renómbralo «Número») — Operation: `Text`, Text: `{{ $('Code').item.json.num }}`, Font Size: `36`, Font Color: `#FFFFFF`, Position X: `40`, Position Y: `1120`.
11. **Google Drive** — Operation: `Upload`, File Name: `{{ $('Code').item.json.num }}_{{ $('Code').item.json.name }}`, Parent Folder: la carpeta `previas`, Input Data Field Name: `data`. Conecta la salida de vuelta al **Split In Batches**.
12. **Gmail** (desde «done») — To: tu correo, Subject: `Previas listas`, Message: `Procesadas {{ $('Code').all().length }} fotos. Carpeta: https://drive.google.com/drive/folders/ID_PREVIAS`.

## Cómo probarla
- Empieza con una carpeta de 5 fotos, una vertical y una horizontal. Comprueba que la marca de agua cae dentro del encuadre en las dos: si en la vertical se sale, es que estás posicionando desde arriba con coordenadas pensadas para horizontal.
- Mira el peso de una previa: debería quedar entre 200 y 400 KB. Si sale de 2 MB, añade en el Edit Image de reducción la opción de calidad al 80.
- Verifica que el número que se ve en la imagen coincide con el que lleva el nombre de archivo. Es lo que hace que el cliente pueda decirte «la 0042» y os entendáis.

## Qué puede salir mal
- **Fotos verticales y horizontales mezcladas**: las coordenadas fijas fallan. Solución: haz dos ramas con un **IF** que compare ancho y alto (los tienes con un **Edit Image** en Operation `Get Information`) y usa posiciones distintas.
- **Memoria**: procesar imágenes es lo más pesado que hace n8n. Con Batch Size 1 vas seguro; si aun así se cae, activa `N8N_DEFAULT_BINARY_DATA_MODE=filesystem`.
- **Marca de agua ilegible**: sobre fondo blanco una marca blanca desaparece. Usa un PNG con sombra suave incorporada, o pon la marca centrada al 15% de opacidad y grande, que es más difícil de recortar.
- **Lentitud**: 300 fotos tardan entre 15 y 40 minutos. Lánzalo y vete a otra cosa; no lo mires. Si n8n Cloud te corta por tiempo máximo de ejecución, trocea en tandas de 100.
- **RAW no**: el nodo Edit Image trabaja con JPG y PNG. Exporta primero JPG desde tu revelador.
- **Orden alfabético traicionero**: `DSC10.jpg` va antes que `DSC9.jpg`. Si tus nombres no llevan ceros a la izquierda, ordena por `createdTime` en vez de por nombre.

## Cuánto cuesta
- n8n auto-alojado con el nodo Edit Image: gratis, sin API de terceros ni servicios de pago.
- Drive y Gmail: gratis en el plan personal.
- Total: 0 €. Es de las pocas automatizaciones de imagen que no depende de ningún servicio externo.
