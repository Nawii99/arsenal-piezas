# Cazaduplicados: limpia ráfagas y fotos casi idénticas…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Recorre tu carpeta de fotos, calcula una huella visual de cada imagen y te marca las que son iguales o casi iguales para que borres el peso muerto.

## Qué es y qué hace

Sube cada foto a Cloudinary para pedir su huella visual (phash), compara todas contra todas y anota en una hoja de Sheets los grupos de fotos casi idénticas. Recorre una carpeta de Drive y no borra nada: tú decides qué eliminar. Sirve para ráfagas y para carpetas con copias que ocupan almacenamiento en la nube sin aportar nada.

## Cómo usarla

1. Crea cuenta gratuita en Cloudinary y copia las claves
2. Conecta Drive y Sheets en n8n
3. Ejecuta el flujo sobre una sesión de prueba
4. Revisa los grupos antes de borrar

## Cuándo usarla

Úsalo cuando disparas en ráfaga, tienes el Drive lleno de fotos repetidas y estás pagando almacenamiento por copias que no aportan nada.

## Cómo ganar dinero con ella

Recuperas entre el 20 % y el 40 % del espacio de una sesión y te ahorras 2-3 horas de revisar miniaturas a ojo en cada entrega.

- Limpieza del archivo de fotos de un fotógrafo, con informe de grupos de duplicados y espacio recuperable.
- Servicio puntual para agencias que pagan almacenamiento de copias, con auditoría de carpetas en Drive.
- Revisión trimestral de duplicados para tiendas online con catálogos grandes de fotos de producto.

**Precio orientativo:** 120–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Para fotógrafos y tiendas online que acumulan miles de imágenes: sube cada foto a Cloudinary pidiendo su huella visual (phash), compara todas contra todas y apunta en una hoja los grupos de fotos casi idénticas. Tú decides qué borras; la automatización no borra nada por su cuenta.

## Lo que necesitas antes
- Cuenta de n8n (n8n Cloud con su prueba gratuita temporal, o auto-alojado gratis con Docker).
- Cuenta de Google con la carpeta de fotos en Drive. En n8n: Credentials > Google Drive OAuth2, siguiendo el asistente de Google Cloud Console (crear proyecto, activar Drive API, pantalla de consentimiento en modo Prueba, tu correo como usuario de prueba).
- Cuenta gratuita en cloudinary.com. En el Dashboard copias Cloud name, API Key y API Secret.
- Una hoja de Google Sheets vacía llamada «Duplicados» con las columnas: grupo, nombre, id_drive, enlace, distancia.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: Weeks, Days Between Triggers: 1, Trigger at Hour: 3. Lo pones de madrugada porque puede tardar.
2. **Google Drive** — Resource: File/Folder, Operation: Search. Search Method: Advanced, Query String: `'ID_DE_TU_CARPETA' in parents and (mimeType='image/jpeg' or mimeType='image/png') and trashed=false`. Return All: activado. Fields: `id,name,webViewLink,size`.
3. **Loop Over Items** (Split In Batches) — Batch Size: 1. Todo lo que va dentro del bucle se conecta a la salida «loop».
4. **Google Drive** — Operation: Download. File ID: `={{ $json.id }}`. Put Output File in Field: `data`.
5. **HTTP Request** (renómbralo «Subir a Cloudinary») — Method: POST, URL: `https://api.cloudinary.com/v1_1/TU_CLOUD_NAME/image/upload`. Authentication: Generic Credential Type > Basic Auth, usuario = API Key, contraseña = API Secret. Body Content Type: Form-Data. Campos: `file` de tipo n8n Binary File con Input Data Field Name `data`; `phash` con valor `true`; `folder` con valor `dedupe`; `upload_preset` déjalo vacío. En Settings del nodo activa Retry On Fail (3 intentos, 5000 ms) y Always Output Data desactivado.
6. **Code** dentro del bucle (Mode: Run Once for All Items) para quedarte solo con lo útil: devuelve `{ nombre: ..., id_drive: ..., enlace: ..., phash: ... }`.
7. Conectas la salida del bucle («done») a un **Code** final llamado «Agrupar parecidas» con el código de abajo.
8. **Google Sheets** — Operation: Append, tu documento, hoja «Duplicados», Mapping Column Mode: Map Each Column Manually, y enlazas grupo, nombre, id_drive, enlace y distancia.
9. **Gmail** — Operation: Send. To: tu correo. Subject: `Duplicados detectados: {{ $items().length }} fotos en grupos`. Message: el enlace a la hoja.

## El trozo de código (nodo Code «Agrupar parecidas»)
```javascript
const fotos = $input.all().map(i => i.json).filter(f => f.phash);
function distancia(a, b) {
  const ba = BigInt('0x' + a), bb = BigInt('0x' + b);
  let x = ba ^ bb, n = 0;
  while (x) { n += Number(x & 1n); x >>= 1n; }
  return n;
}
const UMBRAL = 8; // 0 = idénticas, sube a 12 si quieres agrupar más
const usadas = new Set();
const salida = [];
let grupo = 0;
for (let i = 0; i < fotos.length; i++) {
  if (usadas.has(i)) continue;
  const iguales = [i];
  for (let j = i + 1; j < fotos.length; j++) {
    if (usadas.has(j)) continue;
    const d = distancia(fotos[i].phash, fotos[j].phash);
    if (d <= UMBRAL) { iguales.push(j); usadas.add(j); fotos[j]._d = d; }
  }
  if (iguales.length > 1) {
    grupo++;
    for (const k of iguales) {
      usadas.add(k);
      salida.push({ json: { grupo, nombre: fotos[k].nombre, id_drive: fotos[k].id_drive, enlace: fotos[k].enlace, distancia: fotos[k]._d ?? 0 } });
    }
  }
}
return salida;
```

## Cómo probarla
- Crea una carpeta de pruebas en Drive con 10 fotos, tres de ellas de la misma ráfaga.
- Ejecuta con Execute Workflow y revisa la salida del nodo «Subir a Cloudinary»: tiene que aparecer un campo `phash` de 16 caracteres. Si no aparece, es que el campo `phash: true` no se envió.
- Comprueba que las tres de la ráfaga caen en el mismo grupo. Si mete fotos distintas juntas, baja el UMBRAL a 5; si no agrupa las obvias, súbelo a 12.

## Qué puede salir mal
- **Cloudinary te corta**: el plan gratuito tiene un límite mensual de créditos. Procesa por lotes de 300-500 fotos y usa el filtro de fecha en la Query String de Drive (`modifiedTime > '2026-01-01'`) para no repetir trabajo.
- **Fotos ya subidas**: añade un nodo Google Sheets de lectura al principio y descarta los id_drive que ya tengan phash guardado; así no vuelves a pagar créditos por la misma foto.
- **RAW y HEIC**: Cloudinary no siempre los procesa. Filtra solo jpeg/png y trabaja con los JPG de previsualización.
- **Se para a medias**: activa Retry On Fail en el nodo HTTP y en Settings del workflow marca «Save failed executions» para poder reanudar.
- **Borrado accidental**: no pongas nunca un nodo de borrado automático. Revisa la hoja y borra tú.

## Cuánto cuesta
n8n auto-alojado: 0 €. Google Drive y Sheets: 0 € con tu cuenta normal. Cloudinary: gratis hasta 25 créditos al mes (unas 25.000 transformaciones o 25 GB), suficiente para varios miles de fotos al mes; a partir de ahí el plan Plus ronda los 89 $/mes, pero si te acercas al límite lo normal es reducir el volumen, no pagar.
