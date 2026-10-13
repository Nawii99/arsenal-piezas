# Copia de seguridad 3-2-1 con parte diario de verificaci…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Copia cada noche las fotos nuevas a un segundo servicio, comprueba que el archivo llegó entero y te manda un parte por email.

## Qué es y qué hace

Cada noche busca en las carpetas de trabajo de Drive los archivos añadidos en las últimas 24 horas, los sube a un bucket de Backblaze B2 y compara tamaño y hash en los dos lados. Por la mañana envía un correo con cuántos archivos y gigas se copiaron y si alguno falló. Entran archivos nuevos y salen copias verificadas y un parte. Para fotógrafos o estudios con archivos en Drive y sin copia externa, con n8n.

## Cómo usarla

1. Crea el bucket privado en Backblaze B2
2. Genera la clave de aplicación y guárdala
3. Indica en n8n las carpetas de Drive
4. Revisa el primer parte y una restauración de prueba

## Cuándo usarla

Úsalo cuando tu archivo fotográfico vive solo en un sitio y sabes que un día vas a tener un susto, pero nunca encuentras el momento de montar copias.

## Cómo ganar dinero con ella

Perder una boda entera cuesta la devolución, el prestigio y a veces una demanda. Esto vale unos 6 €/mes y quita el problema.

- Implantación de copia externa verificada para estudios fotográficos, cobrada por instalación.
- Mantenimiento mensual de las copias y pruebas de restauración para fotógrafos, por cuota.
- Plantilla de respaldo nocturno vendida a pequeños despachos con archivos en Drive.

**Precio orientativo:** 200–400 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada noche recorre las carpetas de trabajo de Google Drive, detecta los archivos añadidos en las últimas 24 horas, los sube a un bucket de Backblaze B2 y compara el tamaño y el hash de los dos lados. Por la mañana tienes un email con cuántos archivos se copiaron, cuántos GB y si alguno falló.
Para el fotógrafo o el estudio que trabaja en Drive y no tiene copia fuera de Google.

## Lo que necesitas antes
- Cuenta en backblaze.com > B2 Cloud Storage. Crea un bucket privado, por ejemplo `archivo-fotos`.
- En B2, App Keys > Add a New Application Key: apunta `keyID` y `applicationKey`. Solo se ve una vez.
- Los IDs de las carpetas de Drive que quieres respaldar.
- Una hoja `Registro Backup` con columnas: `fecha`, `archivos`, `gigas`, `fallidos`, `detalle`.
- En n8n: credencial `Google Drive OAuth2` y `Google Sheets OAuth2`.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 3 * * *`, todas las noches a las 3.
2. **Google Drive** — Resource `File/Folder`, Operation `Search`. Query String vacío y en `Filter` pon Folder = tu carpeta, y en `Query String` avanzado usa: `modifiedTime > '{{ $now.minus(1, "day").toISO() }}' and mimeType contains 'image/'`.
3. **IF** — si no hay resultados, salta directo al email diciendo «nada nuevo».
4. **HTTP Request** (`Autorizar B2`) — Method `GET`. URL: `https://api.backblazeb2.com/b2api/v3/b2_authorize_account`. Authentication: `Basic Auth` con usuario = keyID y contraseña = applicationKey. Devuelve `apiUrl` y `authorizationToken`.
5. **Split In Batches** — Batch Size: 5. Sube de cinco en cinco para no saturar la memoria de n8n.
6. **Google Drive** — Operation `Download`, File ID `{{ $json.id }}`, campo binario `data`.
7. **HTTP Request** (`Pedir URL de subida`) — Method `POST`, URL `{{ $('Autorizar B2').item.json.apiUrl }}/b2api/v3/b2_get_upload_url`. Header `Authorization` con el `authorizationToken`. Body JSON: `{"bucketId": "TU_BUCKET_ID"}`.
8. **Code** (`Calcular hash`) — saca el SHA1 del binario, que es lo que B2 pide. Código abajo.
9. **HTTP Request** (`Subir a B2`) — Method `POST`, URL `{{ $json.uploadUrl }}`. Headers: `Authorization` = `{{ $json.uploadAuthToken }}`, `X-Bz-File-Name` = `{{ $json.nombreCodificado }}`, `Content-Type` = `b2/x-auto`, `X-Bz-Content-Sha1` = `{{ $json.sha1 }}`. Body Content Type: `n8n Binary File`, campo `data`.
10. **Code** (`Verificar`) — compara el `contentSha1` que devuelve B2 con el que calculaste. Código abajo.
11. **Google Sheets** — `Append Row` con el resumen del día.
12. **Gmail** — te manda el parte con el detalle.

## El código del nodo Calcular hash
```javascript
const crypto = require('crypto');
const item = $input.item;
const bin = await this.helpers.getBinaryDataBuffer(0, 'data');
const sha1 = crypto.createHash('sha1').update(bin).digest('hex');
const nombre = $('Google Drive').item.json.name;
const carpeta = new Date().toISOString().slice(0,7); // AAAA-MM
return {
  json: {
    sha1,
    tamano: bin.length,
    nombre,
    nombreCodificado: encodeURIComponent(`${carpeta}/${nombre}`),
    uploadUrl: $json.uploadUrl,
    uploadAuthToken: $json.authorizationToken
  },
  binary: item.binary
};
```

## El código del nodo Verificar
```javascript
const ok = [], mal = [];
let bytes = 0;
for (const it of $input.all()) {
  const r = it.json;
  const esperado = $('Calcular hash').all().find(x => x.json.nombre === decodeURIComponent(r.fileName || '').split('/').pop());
  if (r.contentSha1 && esperado && r.contentSha1 === esperado.json.sha1) { ok.push(r.fileName); bytes += r.contentLength || 0; }
  else { mal.push(r.fileName || 'desconocido'); }
}
return [{ json: {
  fecha: new Date().toISOString().slice(0,10),
  archivos: ok.length,
  gigas: (bytes / 1073741824).toFixed(2),
  fallidos: mal.length,
  detalle: mal.length ? 'FALLARON: ' + mal.join(', ') : 'Todo correcto'
}}];
```

## Cómo probarla
- Sube dos fotos nuevas a la carpeta vigilada y ejecuta el workflow a mano sin esperar a las 3.
- Entra en el panel de Backblaze y comprueba que aparecen en `archivo-fotos/AAAA-MM/`.
- Prueba a restaurar: descarga una foto desde B2 y ábrela. Una copia que no has probado a restaurar no es una copia.

## Qué puede salir mal
- **Archivos enormes.** B2 pide subida multiparte por encima de 5 GB. Para fotos no es problema; para vídeo sí, y ahí conviene usar el cliente oficial rclone en lugar de n8n.
- **El token de B2 caduca a las 24 horas.** Como autorizas en cada ejecución nocturna, no te afecta.
- **n8n se queda sin memoria.** Si respaldas 500 fotos de golpe la primera noche, baja el Batch Size a 2 y aumenta `N8N_PAYLOAD_SIZE_MAX`. Mejor aún: haz la primera carga masiva con rclone y deja n8n solo para el día a día.
- **Nombres repetidos.** B2 guarda versiones, no machaca. Si te ocupa de más, activa reglas de ciclo de vida en el bucket para conservar solo la última versión.

## Cuánto cuesta
- Backblaze B2: 6 $ por TB al mes, con los primeros 10 GB gratis. Un archivo de 500 GB son unos 3 €/mes.
- Descargas: los primeros 3x de tu almacenamiento son gratis al mes, más que suficiente.
- n8n auto-alojado: 0 €.
