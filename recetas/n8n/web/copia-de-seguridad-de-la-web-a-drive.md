# Copia de seguridad de la web a Drive…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Hace cada noche una copia de la base de datos y de los ficheros subidos de tu web, la sube a Google Drive comprimida y borra las copias de más de 30 días.

## Qué es y qué hace

Cada noche entra por SSH al servidor, genera un volcado de la base de datos y un comprimido de la carpeta de subidas, lo trae a n8n y lo sube a Google Drive con la fecha en el nombre. Borra los archivos de más de 30 días y te confirma por Telegram el tamaño del backup. Sirve para webs en VPS o hosting con SSH, como WordPress, PrestaShop o Laravel.

## Cómo usarla

1. Obtener usuario, host y clave SSH
2. Crear las credenciales SSH y de Google Drive en n8n
3. Crear la carpeta de backups
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tienes una web en un hosting cuyo backup no controlas, o pagas 10-15 €/mes por un plugin de copias que puedes sustituir.

## Cómo ganar dinero con ella

Ahorra la cuota del plugin de backup (120-180 €/año por web) y te evita pagar una recuperación de emergencia de 300 €.

- Copias nocturnas para webs de clientes en VPS o hosting con SSH.
- Restauración de prueba trimestral de copias para tiendas online.
- Servicio de backup gestionado que el técnico ofrece dentro de su mantenimiento.

**Precio orientativo:** 120–250 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién.** Cada noche entra por SSH en tu servidor, genera un volcado de la base de datos y un comprimido de la carpeta de subidas, se lo trae a n8n, lo sube a una carpeta de Google Drive con fecha en el nombre, borra los archivos de más de 30 días y te confirma por Telegram con el tamaño del backup.
Para quien tiene una o varias webs (WordPress, PrestaShop, Laravel) en un VPS o en un hosting con acceso SSH.

**Lo que necesitas antes**
- Acceso SSH al hosting: usuario, host y contraseña o clave privada. Si tu hosting no da SSH, esta receta no te vale; usa la variante con `wget` a un script PHP protegido por token.
- Credencial SSH en n8n: Credentials > New > SSH Password o SSH Private Key.
- Credencial Google Drive OAuth2 en n8n; crea en Drive una carpeta `Backups/<nombre-web>` y copia su ID de la URL.
- Saber los datos de la base de datos: en WordPress están en `wp-config.php` (`DB_NAME`, `DB_USER`, `DB_PASSWORD`).
- Espacio: 15 GB gratis en Drive dan de sobra para webs pequeñas.

**Los nodos, en orden**
1. **Schedule Trigger** — Days, Hour 3, Minute 30 (de madrugada, cuando nadie compra).
2. **SSH** (`Volcar BD`) — Resource: Command. Command: `cd /tmp && mysqldump -u USUARIO -p'CONTRASENA' NOMBREBD --single-transaction --quick | gzip > bd-$(date +%F).sql.gz && ls -l /tmp/bd-$(date +%F).sql.gz`.
3. **SSH** (`Comprimir ficheros`) — Command: `cd /var/www/tuweb && tar -czf /tmp/uploads-$(date +%F).tar.gz wp-content/uploads --warning=no-file-changed || true`.
4. **SSH** (`Descargar BD`) — Resource: File, Operation: Download, Path `/tmp/bd-{{ $now.format('yyyy-LL-dd') }}.sql.gz`, Put Output in Field `data`.
5. **Google Drive** (`Subir BD`) — Operation: Upload, Input Data Field Name `data`, File Name `bd-{{ $now.format('yyyy-LL-dd') }}.sql.gz`, Parent Folder: la carpeta `Backups`.
6. **SSH** (`Descargar ficheros`) — igual que el 4 pero con `uploads-...tar.gz`.
7. **Google Drive** (`Subir ficheros`) — igual que el 5 con el nuevo nombre.
8. **SSH** (`Limpiar servidor`) — Command: `rm -f /tmp/bd-*.sql.gz /tmp/uploads-*.tar.gz`.
9. **Google Drive** (`Listar antiguos`) — Resource: File/Folder, Operation: Search, Search Method: Advanced Query, Query String: `'IDCARPETA' in parents and modifiedTime < '{{ $now.minus({ days: 30 }).toISO() }}' and trashed = false`.
10. **Google Drive** (`Borrar`) — Operation: Delete File, File ID `{{ $json.id }}`.
11. **Telegram** — Send Message: `Backup {{ $now.format('dd/LL/yyyy') }} OK. BD y uploads subidos a Drive.`
12. En Settings del workflow: Error Workflow apuntando a un workflow mínimo con un nodo Telegram que te avise si algo falla.

**Cómo probarla**
- Ejecuta a mano y comprueba en Drive que aparecen los dos ficheros con la fecha de hoy.
- Descarga el `.sql.gz`, descomprímelo y ábrelo: tiene que empezar con `-- MySQL dump` y contener `CREATE TABLE`. Si pesa 0-2 KB, las credenciales de la BD están mal.
- Prueba de verdad la restauración una vez: monta la web en local con ese volcado. Un backup que no has restaurado nunca no es un backup.

**Qué puede salir mal**
- La contraseña de la BD con caracteres raros rompe el comando: enciérrala en comillas simples como en el ejemplo y evita comillas simples dentro.
- Si la carpeta `uploads` pesa más de 1 GB, n8n puede quedarse sin memoria al descargarla. Solución: haz el `tar` partido por años (`wp-content/uploads/2026`) o usa `rclone` en el servidor y que n8n solo lo dispare.
- El aviso `file changed as we read it` de tar es normal en webs vivas; por eso está el `|| true`.
- Zona horaria: si el nombre del fichero sale con el día anterior, pon `Europe/Madrid` en Settings del workflow.
- Retención: si borras por `modifiedTime` y Drive re-toca el archivo, podrías borrar de más. Alternativa segura: filtra por el nombre `bd-2026-` en el Query String.

**Cuánto cuesta**
- n8n autoalojado gratis; Drive 15 GB gratis, 100 GB por 1,99 €/mes si te quedas corto.
- Ahorras el plugin de backup de pago y el servicio de backup del hosting.
