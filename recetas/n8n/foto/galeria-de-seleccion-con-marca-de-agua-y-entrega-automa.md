# Galería de selección con marca de agua y entrega automá…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Convierte la carpeta de una sesión en previsualizaciones con tu marca de agua, manda al cliente una hoja para marcar sus favoritas y luego le entrega solo esas en alta.

## Qué es y qué hace

Genera copias de baja resolución con tu logotipo para cada foto de una sesión, las guarda en una carpeta de solo lectura y crea una hoja donde el cliente marca SÍ en las que quiere. Un segundo flujo detecta esos SÍ y envía solo las originales, sin marca. Usa Drive, Sheets y Cloudinary en n8n y evita enviar archivos grandes por mensajería.

## Cómo usarla

1. Sube tu logo a Cloudinary con Public ID logo_marca
2. Crea la plantilla de Sheets
3. Prueba con una sesión pequeña
4. Activa el flujo de entrega de originales

## Cuándo usarla

Cuando entregas sesiones con «X fotos incluidas a elegir» y pierdes días con WeTransfer, capturas de pantalla y mensajes del tipo «me quedo con la 47».

## Cómo ganar dinero con ella

Ahorra 2-4 horas por sesión en preparar previews y reenvíos, y evita la fuga de fotos en alta antes de cobrar el resto.

- Montaje de galería de selección para fotógrafos de bodas, con marca de agua y entrega automática.
- Servicio mensual de preparación de galerías para estudios que entregan preselecciones a sus clientes.
- Plantilla de flujo de selección vendida a fotógrafos de retrato que quieren dejar de enviar fotos por WeTransfer.

**Precio orientativo:** 180–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Para fotógrafos de bodas, retrato o producto que entregan una preselección: coge la carpeta de la sesión, genera copias en baja con tu logotipo encima, las guarda en una carpeta de solo lectura y crea una hoja donde el cliente escribe SÍ en las que quiere. Un segundo flujo detecta esos SÍ y le manda automáticamente las originales sin marca.

## Lo que necesitas antes
- n8n (auto-alojado gratis o Cloud).
- Google Drive y Google Sheets con credencial OAuth2 en n8n.
- Cloudinary gratuita: Cloud name, API Key y API Secret del Dashboard.
- Tu logotipo en PNG con fondo transparente, subido una sola vez a Cloudinary con Public ID `logo_marca` (lo haces a mano desde la web de Cloudinary, Media Library > Upload).
- Una plantilla de Google Sheets con columnas: miniatura, nombre_archivo, id_original, quiero (SÍ/NO), notas.

## Los nodos, en orden — Flujo A: preparar la galería
1. **Google Drive Trigger** — Trigger On: Specific Folder, Watch For: File Created, apuntando a la carpeta «01 ENTRADA SESIONES». Poll Times: cada hora. (Si prefieres lanzarlo tú, cambia por un Manual Trigger y un campo con el ID de carpeta.)
2. **Google Drive** — Operation: Search, Query String: `'{{ $json.id }}' in parents and mimeType contains 'image/' and trashed=false`, Return All activado.
3. **Loop Over Items** — Batch Size: 1.
4. **Google Drive** — Operation: Download, File ID `={{ $json.id }}`, campo binario `data`.
5. **HTTP Request «Subir original»** — POST a `https://api.cloudinary.com/v1_1/TU_CLOUD/image/upload`, Basic Auth con Key/Secret, Form-Data: `file` (binario `data`), `folder` = `sesiones/{{ $('Google Drive Trigger').item.json.name }}`, `use_filename` = `true`, `unique_filename` = `false`.
6. **Code «Construir URL con marca»** — genera la URL de la versión con logo y tamaño reducido (código abajo).
7. **HTTP Request «Descargar preview»** — Method: GET, URL `={{ $json.url_preview }}`, Response Format: File, Put Output in Field: `data`.
8. **Google Drive** — Operation: Upload, Input Data Field Name: `data`, File Name `={{ $json.nombre }}_preview.jpg`, Parent Folder: carpeta «02 PREVIEWS» (o crea subcarpeta con un nodo Google Drive > Folder > Create).
9. **Google Sheets** — Operation: Append. Columna miniatura con la fórmula `=IMAGE("{{ $json.url_preview }}")`, nombre_archivo, id_original, quiero vacío.
10. Fuera del bucle: **Gmail** — Send, al cliente, con el enlace de la hoja, compartida en modo Editor solo con el correo del cliente (no con «cualquiera con el enlace»), y el texto de instrucciones.

## Flujo B: entregar las elegidas
1. **Schedule Trigger** — cada 6 horas.
2. **Google Sheets** — Operation: Get Row(s), Filters: columna `quiero` igual a `SÍ`. Añade también una columna `entregada` y filtra las vacías.
3. **IF** — Condition: Number, `{{ $items().length }}` Larger than `0`.
4. **Loop Over Items** > **Google Drive** Operation: Copy (o Share) del `id_original` a la carpeta «03 ENTREGA», y **Google Sheets** Update poniendo `entregada` = `sí`.
5. **Google Drive** — Operation: Share sobre la carpeta «03 ENTREGA»: Permissions Role: reader, Type: user, Email Address: el correo del cliente (guárdalo en una columna `email_cliente` de la hoja). Son fotos personales del cliente: no uses «cualquiera con el enlace».
6. **Gmail** — Send con el enlace de la carpeta y el aviso de caducidad de la galería.

## El trozo de código (nodo Code «Construir URL con marca»)
```javascript
const CLOUD = 'TU_CLOUD_NAME';
return $input.all().map(item => {
  const pid = item.json.public_id;
  const t = 'w_1200,c_limit,q_auto:eco,f_jpg/l_logo_marca,o_45,w_0.35,fl_relative,g_south_east,x_25,y_25';
  return { json: {
    nombre: (item.json.original_filename || pid.split('/').pop()),
    public_id: pid,
    url_preview: `https://res.cloudinary.com/${CLOUD}/image/upload/${t}/${pid}.jpg`
  }};
});
```

## Cómo probarla
- Mete 5 fotos en «01 ENTRADA SESIONES» dentro de una subcarpeta de prueba y lanza el Flujo A a mano.
- Abre una URL de preview en el navegador: tiene que verse a 1200 px con el logo abajo a la derecha al 45 % de opacidad. Si el logo sale gigante, baja `w_0.35` a `w_0.2`.
- Escribe SÍ en dos filas y ejecuta el Flujo B; comprueba que solo aparecen esas dos en «03 ENTREGA».

## Qué puede salir mal
- **El cliente borra filas de la hoja**: protege el rango (Datos > Proteger hojas) dejando editable solo la columna `quiero`.
- **Duplicados en la entrega**: la columna `entregada` es obligatoria; sin ella el Flujo B reenvía las mismas fotos cada 6 horas.
- **Nombres con tildes o espacios**: pon `unique_filename: false` y `use_filename: true`, y si Cloudinary te cambia el nombre, guarda siempre el `public_id` como referencia, no el nombre.
- **La marca se recorta**: usa `fl_relative` con `w_0.35`, si no el logo se escala en píxeles fijos y en fotos verticales queda mal.
- **Fotos en alta filtradas**: nunca compartas la carpeta de originales; comparte solo «02 PREVIEWS» y «03 ENTREGA», y siempre con el correo concreto del cliente, porque son fotos con datos personales.

## Cuánto cuesta
0 € en n8n auto-alojado, Drive y Sheets. Cloudinary gratis hasta 25 créditos/mes: una sesión de 400 fotos con preview consume muy poco. Si haces más de 20-30 sesiones grandes al mes te acercarás al límite y tocará subir de plan (desde 89 $/mes) o generar los previews en local con ImageMagick.
