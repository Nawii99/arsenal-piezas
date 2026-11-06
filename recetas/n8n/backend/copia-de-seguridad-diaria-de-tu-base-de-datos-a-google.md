# Copia de seguridad diaria de tu base de datos a Google…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Cada madrugada saca un volcado comprimido de tu base de datos, lo sube a Google Drive, borra las copias viejas y te avisa si algo falla. Para cualquiera que tenga una tienda, una app o CRM.

## Qué es y qué hace

A las 03:15 hace un volcado de PostgreSQL o MySQL, lo comprime, lo sube a Google Drive con la fecha en el nombre, borra los de más de 30 días y avisa por Telegram si falla. Entrada: base de datos y usuario de solo lectura; salida: archivo .sql.gz en Drive y resumen semanal. Requiere n8n auto-alojado con los clientes de base de datos instalados. Si la base guarda datos personales, conviene revisar el tratamiento.

## Cómo usarla

1. Instala los clientes de base de datos en n8n
2. Crea el usuario de solo lectura
3. Prueba una restauración en otra máquina
4. Que lo revise un profesional

## Cuándo usarla

Cuando tengas una base de datos MySQL o PostgreSQL en un VPS o en un hosting y dependas de que "el proveedor ya hace copias", que suele significar que solo guarda 7 días y solo del servidor entero.

## Cómo ganar dinero con ella

Evita el desastre de perder la base de datos (recuperarla cuesta miles de euros o directamente el negocio) y sustituye servicios de backup gestionado de 15-40 € al mes.

- Copias de seguridad gestionadas para tiendas y apps pequeñas que hoy confían en el hosting.
- Configuración y prueba de restauración para agencias con clientes en VPS.
- Mantenimiento mensual de backups con informe de tamaño y verificación.

**Precio orientativo:** 120–350 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
A las 03:15 cada noche ejecuta un volcado (`pg_dump` o `mysqldump`) de tu base de datos, lo comprime, lo sube a una carpeta de Google Drive con el nombre `backup-AAAA-MM-DD.sql.gz` y borra los que tengan más de 30 días.
Si el volcado sale vacío o falla, te lo dice por Telegram; si va bien, te manda un resumen semanal con el tamaño para que veas si algo raro está pasando.

## Lo que necesitas antes
- n8n **auto-alojado** (esta receta necesita ejecutar comandos, y eso el n8n Cloud no lo permite). Docker en el mismo servidor donde está la base de datos, o con acceso SSH a él.
- Los clientes de base de datos instalados dentro del contenedor de n8n: entra con `docker exec -u root -it n8n sh` y ejecuta `apk add --no-cache postgresql-client` (o `mysql-client`).
- Usuario de base de datos de solo lectura para el backup. En Postgres: `CREATE USER backup WITH PASSWORD 'xxx'; GRANT CONNECT ON DATABASE tubd TO backup; GRANT USAGE ON SCHEMA public TO backup; GRANT SELECT ON ALL TABLES IN SCHEMA public TO backup;`
- Credencial de Google Drive OAuth2 en n8n (Credentials, Google Drive OAuth2 API, con un proyecto en console.cloud.google.com y la API de Drive activada).
- Una carpeta en Drive llamada "Backups BD"; copia su ID de la URL.
- Bot de Telegram (@BotFather) y tu chat ID.

## Los nodos, en orden
1. **Schedule Trigger** — Cron Expression: `15 3 * * *`, Timezone del workflow: Europe/Madrid.
2. **Set** (Edit Fields, nombre: Config) — campos de texto: `db` = tubd, `host` = 127.0.0.1, `user` = backup, `carpeta` = el ID de Drive. La contraseña NO va aquí: la pones como variable de entorno `PGPASSWORD` en el docker-compose de n8n.
3. **Execute Command** (nombre: Volcado) — Command: el comando de abajo. Settings: On Error, Continue (using error output).
4. **Execute Command** (nombre: Comprobar tamaño) — Command: `stat -c%s /tmp/backup-$(date +%F).sql.gz`.
5. **IF** (nombre: ¿Tiene tamaño?) — Number: Value 1 `={{ parseInt($json.stdout) }}`, Operation: larger, Value 2: 1024. Menos de 1 KB es un volcado vacío.
6. **Read/Write Files from Disk** — Operation: Read File(s) From Disk, File(s) Selector: `=/tmp/backup-{{ $now.format('yyyy-MM-dd') }}.sql.gz`.
7. **Google Drive** (nombre: Subir) — Resource: File, Operation: Upload, Input Data Field Name: data, File Name: `=backup-{{ $now.format('yyyy-MM-dd') }}.sql.gz`, Parent Drive: My Drive, Parent Folder: el ID de tu carpeta.
8. **Google Drive** (nombre: Listar antiguos) — Resource: File/Folder, Operation: Search, Search Method: query string, Filter por carpeta, Query String: `backup-`, Return All: activado.
9. **Code** (nombre: Filtrar viejos) — deja solo los de más de 30 días.
10. **Google Drive** (nombre: Borrar) — Resource: File, Operation: Delete, File ID: `={{ $json.id }}`.
11. **Execute Command** (nombre: Limpiar disco) — Command: `rm -f /tmp/backup-*.sql.gz`.
12. **Telegram** (rama de error del IF y del Volcado) — mensaje de fallo.

## El comando del nodo "Volcado"
```bash
PGPASSWORD="$PGPASSWORD" pg_dump -h {{ $json.host }} -U {{ $json.user }} -d {{ $json.db }} --no-owner --no-acl | gzip -9 > /tmp/backup-$(date +%F).sql.gz && echo OK
```
Si usas MySQL, cambia esa línea por: `mysqldump -h {{ $json.host }} -u {{ $json.user }} -p"$MYSQL_PWD" --single-transaction --quick {{ $json.db }} | gzip -9 > /tmp/backup-$(date +%F).sql.gz && echo OK`

## El código del nodo "Filtrar viejos"
```javascript
const limite = Date.now() - 30 * 24 * 60 * 60 * 1000;
return $input.all().filter(i => {
  const m = (i.json.name || '').match(/backup-(\d{4}-\d{2}-\d{2})/);
  if (!m) return false;
  return new Date(m[1]).getTime() < limite;
}).map(i => ({ json: { id: i.json.id, name: i.json.name } }));
```

## Cómo probarla
- Ejecuta el flujo a mano y comprueba que en Drive aparece el fichero y que pesa lo que esperas (una base de datos con datos nunca pesa 300 bytes).
- **Prueba la restauración, que es lo que de verdad importa**: descarga el .gz, y en una base de datos vacía de pruebas haz `gunzip -c backup-2026-09-08.sql.gz | psql -d pruebas`. Si eso no funciona, tu backup no existe.
- Renombra a mano un fichero viejo con fecha de hace 60 días y ejecuta: debe desaparecer.

## Qué puede salir mal
- **El disco se llena**: el volcado se hace en /tmp; si la base de datos es grande, asegúrate de tener espacio libre de al menos el doble. El nodo de limpiar disco es obligatorio, no opcional.
- **Subidas grandes a Drive**: por encima de 100 MB puede haber timeouts. En el nodo HTTP/Drive activa Retry On Fail (3 intentos) y sube el Timeout en Options.
- **La cuota de Drive**: 15 GB gratis compartidos con Gmail y Fotos. 30 copias de 200 MB son 6 GB, ojo.
- **Volcados con la base de datos en uso**: usa `--single-transaction` en MySQL para que la copia sea coherente y no bloquee tablas.
- **Contraseñas en texto plano**: nunca las pongas en el nodo Set; van en variables de entorno del contenedor.

## Cuánto cuesta
- Todo gratis: n8n auto-alojado, Drive hasta 15 GB, Telegram.
- Si necesitas más espacio: Google One 100 GB son 1,99 euros al mes. Alternativa más barata para volumen: un bucket S3 compatible (Backblaze B2, unos 5 dólares por TB al mes) con el nodo HTTP Request.
