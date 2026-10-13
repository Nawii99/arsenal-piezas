# Copia de seguridad semanal de tus repos a Google Drive…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Descarga cada semana un ZIP completo de tus repositorios de GitHub, lo sube a Google Drive con fecha y borra las copias de más de dos meses.

## Qué es y qué hace

Flujo de n8n que cada domingo lista tus repositorios de GitHub, descarga el ZIP de la rama principal de cada uno y lo sube a una carpeta de Google Drive con la fecha en el nombre. Borra las copias de más de 60 días y envía un resumen por Telegram. Sirve como copia de tu código fuera de GitHub.

## Cómo usarla

1. Crea el token de GitHub y la credencial de Drive
2. Indica la carpeta de destino
3. Ajusta los días de retención
4. Prueba una ejecución manual

## Cuándo usarla

Úsalo cuando todo tu código viva solo en GitHub y quieras una copia fuera de esa cuenta por si te la bloquean, la borras por error o un colaborador hace un desastre.

## Cómo ganar dinero con ella

Recuperar un proyecto perdido cuesta semanas de reescritura; esta copia vale cero euros y elimina ese riesgo por completo.

- Copias de seguridad de código para freelances y estudios pequeños…
- Configuración de backups de repositorios para equipos sin administrador de sistemas…
- Mantenimiento de copias como servicio mensual para desarrolladores…

**Precio orientativo:** 80–180 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada domingo lista tus repositorios, pide a GitHub el ZIP de la rama principal de cada uno y lo guarda en una carpeta de Google Drive con nombre `repo_AAAA-MM-DD.zip`. Después limpia lo que tenga más de 60 días para que no se te llene el Drive, y te manda un resumen por Telegram.
Para cualquiera que dependa de una sola cuenta de GitHub: freelance, estudio pequeño o alguien con proyectos personales que no quiere perder años de trabajo.

## Lo que necesitas antes
- n8n auto-alojado o en la nube.
- Token de GitHub con permiso `repo` (github.com/settings/tokens). Guárdalo en n8n como credencial «GitHub API».
- Cuenta de Google con Drive y credencial OAuth2 creada en n8n.
- Una carpeta en Drive llamada «Backups código»; copia su ID de la URL (`drive.google.com/drive/folders/ESTE_ID`).
- Bot de Telegram con su token y tu chat_id (con @BotFather).

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 3 * * 0` (domingos a las 3:00, zona Europe/Madrid).
2. **HTTP Request** («Listar repos») — GET `https://api.github.com/user/repos?per_page=100&affiliation=owner&sort=updated`, Authentication: «Predefined Credential Type» → GitHub API. Añade la cabecera `Accept: application/vnd.github+json`.
3. **Code** («Filtrar repos») — te quedas solo con lo que quieres respaldar.
```javascript
const salida = [];
for (const item of $input.all()) {
  for (const repo of item.json) {
    if (repo.archived) continue;
    if (repo.size === 0) continue;
    salida.push({ json: { nombre: repo.name, full: repo.full_name, rama: repo.default_branch } });
  }
}
return salida;
```
4. **Split In Batches** — Batch Size 1. Descargar ZIPs de varios megas en paralelo se come la memoria de n8n.
5. **HTTP Request** («Descargar ZIP») — GET `https://api.github.com/repos/{{ $json.full }}/zipball/{{ $json.rama }}`, Authentication GitHub API, y en Options activa «Response» → «Response Format: File» con «Put Output in Field» = `data`. Timeout 120000 ms.
6. **Code** («Nombrar archivo») — pone el nombre con fecha en los metadatos del binario.
```javascript
const item = $input.first();
const nombre = $('Split In Batches').item.json.nombre;
const fecha = new Date().toISOString().slice(0, 10);
item.binary.data.fileName = nombre + '_' + fecha + '.zip';
item.binary.data.mimeType = 'application/zip';
return [item];
```
7. **Google Drive** — Resource: File, Operation: Upload, «Input Data Field Name» `data`, «Parent Folder» tu carpeta de backups, «Name» `{{ $json.nombre }}_{{ $now.format('yyyy-MM-dd') }}.zip`.
8. Conecta la salida del Google Drive de nuevo al **Split In Batches** para que procese el siguiente repositorio.
9. **Google Drive** («Listar antiguos») — tras la salida «done» del Split In Batches, Operation: Search, «Query String» vacío, filtro por carpeta, y en Options pide el campo `createdTime`.
10. **Code** («Elegir borrables») — filtra por antigüedad.
```javascript
const limite = Date.now() - 60 * 86400000;
return $input.all().filter(i => new Date(i.json.createdTime).getTime() < limite).map(i => ({ json: { id: i.json.id, name: i.json.name } }));
```
11. **Google Drive** («Borrar») — Operation: Delete File, File ID `{{ $json.id }}`.
12. **Telegram** — Send Message con el número de repos copiados y de archivos borrados.

## Cómo probarla
Ejecuta a mano con el Code de filtrado limitado a un repositorio (`if (repo.name !== 'mi-proyecto') continue;`). Baja el ZIP desde Drive y ábrelo: debe contener el código completo. Para probar el borrado, sube a mano un archivo y cambia el límite a 0 días, comprueba que lo elimina, y devuelve el 60.

## Qué puede salir mal
- **Repos grandes**: si un repositorio pesa más de 200 MB, n8n auto-alojado puede quedarse sin memoria. Sube `N8N_PAYLOAD_SIZE_MAX` y activa el modo de almacenamiento en disco de los binarios con `N8N_DEFAULT_BINARY_DATA_MODE=filesystem`.
- **Límite de la API de GitHub**: 5.000 peticiones por hora con token; con decenas de repos no te acercas.
- **Solo la rama principal**: el zipball no incluye ramas ni historial de Git. Si necesitas el historial completo, en n8n auto-alojado usa un nodo **Execute Command** con `git clone --mirror` y comprime la carpeta resultante.
- **Cuota de Drive**: los 15 GB gratuitos se comparten con Gmail y Fotos. Por eso está el borrado a 60 días.

## Cuánto cuesta
Gratis mientras quepa en los 15 GB de Google. Si guardas muchos proyectos grandes, Google One de 100 GB cuesta unos 2 euros al mes. GitHub y n8n, cero.
