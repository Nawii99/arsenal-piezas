# Copia de seguridad diaria de la base de datos en Drive…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Cada madrugada vuelca tu base de datos MySQL o PostgreSQL, la comprime, la sube a Google Drive, borra las de hace más de 30 días y te confirma que salió bien.

## Qué es y qué hace

A las 4 de la madrugada ejecuta un volcado de tu base de datos MySQL o PostgreSQL en el servidor, lo comprime, lo sube a una carpeta de Google Drive con la fecha en el nombre, borra las copias de más de 30 días y confirma el tamaño por mensaje. Se monta con n8n, Make o Zapier, pero el comando debe ejecutarse en el mismo servidor. Que lo revise un profesional.

## Cómo usarla

1. Crea un usuario de base de datos solo de lectura
2. Instala el cliente de mysqldump o pg_dump donde corre n8n
3. Crea la carpeta de copias en Drive
4. Restaura una copia de prueba en otro entorno

## Cuándo usarla

Cuando tengas una web o app con base de datos en un VPS y tu «copia de seguridad» sea acordarte de hacerla de vez en cuando.

## Cómo ganar dinero con ella

Perder la base de datos de una tienda son días de trabajo y clientes cabreados. Esto cuesta 0 € frente a los 10-30 €/mes de un backup gestionado.

- Copias de seguridad automáticas como servicio mensual para webs con base de datos…
- Plan de recuperación para tiendas que dependen de su base de datos…
- Revisión trimestral de restauraciones para proyectos en VPS…

**Precio orientativo:** 60–150 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
A las 4 de la madrugada ejecuta un `mysqldump` (o `pg_dump`) en tu servidor, comprime el fichero, lo sube a una carpeta de Google Drive con la fecha en el nombre, borra las copias de más de 30 días y te manda un mensaje con el tamaño del fichero.
Para quien mantiene su propio VPS con WordPress, Laravel, Django o similar y no tiene backups automáticos.
## Lo que necesitas antes
- n8n auto-alojado en el MISMO servidor que la base de datos (el nodo Execute Command corre en el contenedor de n8n; si usas Docker, monta un volumen y asegúrate de tener el cliente `mysql-client` o `postgresql-client` instalado en la imagen).
- Usuario de base de datos con permiso de lectura sobre todas las tablas.
- Credencial de Google Drive OAuth2 en n8n (console.cloud.google.com > habilita Google Drive API > credenciales OAuth de app web con la Redirect URL de n8n). Crea una carpeta `Backups BD` y copia su ID de la URL.
- Bot de Telegram con token y chat id.
## Los nodos, en orden
1) **Schedule Trigger**: Cron `0 4 * * *`, Timezone `Europe/Madrid`.
2) **Execute Command**: comando (una sola línea):
```bash
F=/tmp/bd_$(date +%Y-%m-%d).sql.gz && mysqldump -h 127.0.0.1 -u backup -p"$DB_PASS" --single-transaction --quick mi_base | gzip > $F && echo $F && ls -lh $F | awk '{print $5}'
```
Guarda la contraseña como variable de entorno `DB_PASS` en el docker-compose de n8n, nunca escrita en el nodo.
3) **Code**: parsea la salida para sacar ruta y tamaño.
```javascript
const salida = ($json.stdout || '').trim().split('\n');
if ($json.exitCode !== 0) throw new Error('Fallo el dump: ' + $json.stderr);
return [{ json: { ruta: salida[0], tamano: salida[1] || '?', nombre: salida[0].split('/').pop() } }];
```
4) **Read/Write Files from Disk**: Operation `Read File(s) From Disk`, File(s) Selector `{{ $json.ruta }}`, Property Name `data`.
5) **Google Drive**: Resource `File`, Operation `Upload`, Input Data Field Name `data`, File Name `{{ $('Code').item.json.nombre }}`, Parent Folder el ID de tu carpeta `Backups BD`.
6) **Google Drive** (limpieza): Resource `File/Folder`, Operation `Search`, filtro por carpeta, y detrás un **Code** que se quede con los de más de 30 días:
```javascript
const limite = Date.now() - 30 * 86400000;
return $input.all().filter(i => new Date(i.json.createdTime).getTime() < limite).map(i => ({ json: { id: i.json.id, name: i.json.name } }));
```
7) **Google Drive**: Operation `Delete File`, File ID `{{ $json.id }}`.
8) **Execute Command**: `rm -f {{ $('Code').first().json.ruta }}` para no llenar el disco del servidor.
9) **Telegram**: Text `✅ Backup {{ $('Code').first().json.nombre }} subido a Drive ({{ $('Code').first().json.tamano }})`.
10) **Error Trigger** (workflow aparte): crea un segundo workflow con un nodo **Error Trigger** + **Telegram** que te avise `🔴 Falló el backup: {{ $json.execution.error.message }}`, y enlázalo en Settings > Error Workflow del workflow principal.
## Cómo probarla
- Ejecuta a mano y comprueba que el fichero aparece en Drive y que se puede descomprimir: `gunzip -t bd_2026-09-09.sql.gz`.
- Prueba la restauración en local al menos una vez: `gunzip < fichero.sql.gz | mysql -u root -p base_de_pruebas`. Un backup que no has restaurado nunca no es un backup.
- Cambia la contraseña a una errónea a propósito y comprueba que salta el aviso de error.
## Qué puede salir mal
- **El comando no existe en el contenedor**: instala `mariadb-client` en tu imagen de n8n o usa `docker exec` desde el host con n8n en modo privilegiado.
- **La base de datos crece y el dump tarda**: sube el Timeout del nodo y usa `--single-transaction` (ya está) para no bloquear la web.
- **Cuota de Drive llena**: 15 GB gratis compartidos con Gmail. Con dumps de 200 MB y retención de 30 días vas justo; baja la retención a 14 días o comprime con `gzip -9`.
- **Zona horaria**: si el cron va en UTC, la copia sale a las 6:00 en España. Fija la Timezone en el workflow.
## Cuánto cuesta
- n8n: gratis auto-alojado. Google Drive: 15 GB gratis; 100 GB son 1,99 €/mes.
- Telegram: gratis. Coste total realista: 0 €.
