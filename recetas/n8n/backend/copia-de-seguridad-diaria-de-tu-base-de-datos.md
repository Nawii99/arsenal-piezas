# Copia de seguridad diaria de tu base de datos…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Cada noche hace un volcado de tu base de datos, lo comprime, lo sube a Google Drive, comprueba que el archivo no está vacío y te avisa si algo falla.

## Qué es y qué hace

Cada madrugada saca una copia completa de tu base MySQL o PostgreSQL, la comprime, la sube a Google Drive y borra las copias de más de 30 días. Entran los datos de conexión de solo lectura y las credenciales de Drive; sale un archivo comprimido por noche y un aviso si algo falla. Requiere n8n auto-alojado en la misma máquina, para negocios con base propia en un VPS. Contiene datos personales.

## Cómo usarla

1. Instala pg_dump o mysqldump en el servidor
2. Crea un usuario de solo lectura en la base
3. Conecta Google Drive OAuth en n8n
4. Programa la copia y prueba una restauración
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tengas una base de datos MySQL o PostgreSQL en un VPS con datos de clientes, pedidos o facturas y hoy dependas de acordarte de hacer la copia a mano.

## Cómo ganar dinero con ella

Evita perder días de trabajo y datos de clientes tras un fallo de disco. Sustituye un servicio de backup gestionado de 15-40 € al mes.

- Copias de seguridad gestionadas para tiendas y CRM a medida, con aviso mensual…
- Configuración y mantenimiento de backups para pymes con VPS propio…
- Auditoría de copias de seguridad con prueba de restauración para clientes…

**Precio orientativo:** 80–250 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada madrugada saca una copia completa de tu base de datos, la comprime, la sube a una carpeta de Google Drive y borra las copias de más de 30 días. Para cualquier negocio con una base de datos propia en un VPS (tienda a medida, CRM interno, app de reservas).

## Lo que necesitas antes
- n8n auto-alojado **en la misma máquina** que la base de datos, o con acceso de red a ella. Esto no funciona en n8n Cloud porque necesita ejecutar comandos del sistema.
- El cliente de línea de comandos instalado: `sudo apt install postgresql-client` (o `mysql-client`).
- Un usuario de base de datos con permiso de solo lectura sobre todas las tablas.
- Cuenta de Google. En n8n: Credentials → New → «Google Drive OAuth2 API». Te pide Client ID y Secret, que sacas en console.cloud.google.com → APIs y servicios → Credenciales → Crear credenciales → ID de cliente OAuth → Aplicación web, y pegas como URI de redirección la que te muestra n8n.
- Una carpeta en Drive llamada «Backups BD»; copia su ID de la URL.
- Una hoja de Google Sheets llamada «Registro backups» con las columnas: fecha, archivo, tamaño_mb, estado.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: Days, Days Between Triggers 1, Trigger at Hour 3, Trigger at Minute 30. Importante: n8n usa la zona horaria de Settings → Timezone; ponla en `Europe/Madrid` o te ejecutará a la hora equivocada en verano.
2. **Execute Command** (renómbralo «Volcado») — Command:
```
pg_dump -h 127.0.0.1 -U usuario_backup -d nombre_bd | gzip > /var/backups/bd_$(date +%Y-%m-%d).sql.gz && ls -l /var/backups/bd_$(date +%Y-%m-%d).sql.gz
```
   La contraseña NO se escribe en el comando: va en `~/.pgpass` (permisos 600) del usuario que ejecuta n8n, porque un flujo exportado se llevaría la clave si la pones en el nodo. Para MySQL sustituye la primera parte por `mysqldump --defaults-extra-file=/home/node/.my.cnf nombre_bd | gzip > ...`, con usuario y contraseña en ese fichero (permisos 600).
3. **Code** (renómbralo «Comprobar tamaño») — Mode: Run Once for All Items. Código completo:
```javascript
const salida = $input.first().json.stdout || '';
const partes = salida.trim().split(/\s+/);
const bytes = parseInt(partes[4] || '0', 10);
const ruta = partes[partes.length - 1] || '';
const fecha = new Date().toISOString().slice(0, 10);
return [{ json: {
  ruta,
  bytes,
  tamano_mb: Math.round((bytes / 1048576) * 100) / 100,
  fecha,
  nombre: 'bd_' + fecha + '.sql.gz',
  valido: bytes > 10240
} }];
```
4. **IF** — Condition: Boolean → `{{ $json.valido }}` is true.
5. Rama **true** → **Read/Write Files from Disk** (Operation: Read File, File Selector: `{{ $json.ruta }}`).
6. → **Google Drive** — Resource: File, Operation: Upload, Input Data Field Name: `data`, File Name: `{{ $('Comprobar tamaño').first().json.nombre }}`, Parent Drive: My Drive, Parent Folder: el ID de «Backups BD».
7. → **Google Sheets** — Operation: Append Row, hoja «Registro backups», valores: fecha, nombre, tamaño_mb y estado `OK`.
8. Rama **false** → **Gmail** — Operation: Send, To: tu correo, Subject: `FALLO backup BD {{ $json.fecha }}`, Message: incluye `{{ $json.bytes }}` y la salida del comando.
9. Añade un segundo **Schedule Trigger** semanal + **Execute Command** con `find /var/backups -name 'bd_*.sql.gz' -mtime +30 -delete` para no llenar el disco.

## Cómo probarla
- Ejecuta el flujo a mano con «Test workflow» y mira que en Drive aparece el `.gz`.
- Descárgalo y ábrelo: `gunzip -c bd_fecha.sql.gz | head -50`. Debes ver sentencias `CREATE TABLE`.
- Prueba el fallo: cambia la contraseña en `.pgpass` por una falsa y comprueba que te llega el email.

## Qué puede salir mal
- **Permisos**: n8n corre como su propio usuario; dale permiso de escritura en `/var/backups` (`sudo chown -R node:node /var/backups`) o el volcado quedará vacío.
- **Contraseña**: nunca la escribas en el nodo Execute Command. Guárdala en `~/.pgpass` con permisos 600 (línea `127.0.0.1:5432:nombre_bd:usuario_backup:contraseña`) y comprueba que la lee el usuario con el que corre n8n.
- **Google Drive 403 quota**: si la base pesa mucho, sube por partes o usa un bucket S3 compatible con la API de HTTP Request.
- **Se acaba el disco a medias**: el volcado sale truncado pero con tamaño grande. Para curarte en salud, añade `&& gunzip -t fichero` al comando y falla si el test no pasa.
- **Cambio de hora**: si no fijas la zona horaria, en marzo y octubre te bailará una hora. No es grave para un backup nocturno, pero apúntalo.

## Cuánto cuesta
n8n auto-alojado: 0 €. Google Drive: gratis hasta 15 GB, luego 1,99 €/mes por 100 GB. Gmail y Sheets: gratis. Coste real: el que ya pagas por el VPS.
