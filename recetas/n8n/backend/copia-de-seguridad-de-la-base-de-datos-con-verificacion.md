# Copia de seguridad de la base de datos con verificación…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Vuelca tu base de datos cada noche, la sube cifrada a Drive, borra las antiguas y comprueba que el archivo se puede abrir y tiene el tamaño esperado.

## Qué es y qué hace

Cada noche vuelca PostgreSQL o MySQL, comprime y cifra el archivo, lo sube a Drive y borra las copias de más de 30 días. Además comprueba que el archivo no está corrupto y que su tamaño no ha caído de golpe. Entrada: base de datos y contraseña de cifrado; salida: copia verificada y aviso si falla. Requiere n8n auto-alojado con clientes de base de datos y gnupg.

## Cómo usarla

1. Instala los clientes en el contenedor
2. Guarda la clave de cifrado fuera de n8n
3. Prueba una restauración completa al mes
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tu negocio vive en una base de datos y tus copias son «las que hace el hosting», que nunca has probado a restaurar.

## Cómo ganar dinero con ella

Perder la base de datos es perder el negocio. Cuesta 0 € y sustituye a servicios de backup de 15-30 €/mes.

- Copias verificadas para apps y tiendas que nunca han probado a restaurar.
- Backup gestionado para agencias con bases de datos de varios clientes.
- Plan de recuperación ante incidentes para pymes con datos de clientes.

**Precio orientativo:** 100–350 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Todas las noches hace un volcado de PostgreSQL o MySQL, lo comprime y cifra, lo sube a una carpeta de Google Drive, borra las copias de más de 30 días y comprueba dos cosas que casi nadie comprueba: que el archivo no está corrupto y que no ha encogido de golpe (señal de que el volcado falló a medias). Para quien tiene una app o tienda propia con base de datos.
**Lo que necesitas antes**
- n8n **auto-alojado** (el nodo `Execute Command` no existe en n8n Cloud).
- En el contenedor de n8n, los clientes instalados: en el Dockerfile añade `RUN apk add --no-cache postgresql-client gnupg` (o `mysql-client`).
- Usuario de base de datos con permiso de solo lectura para el volcado.
- Credencial de Google Drive en n8n y una carpeta creada, por ejemplo `Backups/BD`. Apunta su ID (está en la URL de la carpeta).
- Una contraseña larga para cifrar, guardada donde tú sepas (si la pierdes, la copia no sirve de nada). Ponla como variable de entorno `BACKUP_PASS` de n8n, y la contraseña de la base como variable `PGPASS` (el comando la lee de ahí; no la escribas en el nodo).
- Una hoja `historico_backups` en Sheets con columnas `fecha`, `archivo`, `bytes`, `estado`.
**Los nodos, en orden**
1. `Schedule Trigger` — Days, Trigger at Hour `3`, Minute `15`. Evita las horas en punto: a esa hora arranca todo el mundo.
2. `Execute Command` (*Volcar*) — Command:
```bash
set -e; F=/tmp/bd_$(date -u +%Y%m%d_%H%M).sql.gz.gpg; PGPASSWORD="$PGPASS" pg_dump -h TU_HOST -U TU_USUARIO -d TU_BASE --no-owner | gzip -9 | gpg --batch --yes --passphrase "$BACKUP_PASS" -c -o "$F"; ls -l "$F" | awk '{print $5}'; echo "$F"
```
3. `Code` (*Leer salida*) — Mode `Run Once for All Items`:
```js
const lineas = String($json.stdout).trim().split('\n');
const ruta = lineas[lineas.length - 1];
const bytes = Number(lineas[lineas.length - 2]);
return { json: { ruta, bytes, nombre: ruta.split('/').pop() } };
```
4. `Execute Command` (*Verificar*) — Command `gpg --batch --passphrase "$BACKUP_PASS" -d {{ $json.ruta }} | gunzip -t && echo INTEGRO`. Si el archivo está corrupto, el comando falla y el flujo se detiene ahí (bien: quieres enterarte).
5. `Read/Write Files from Disk` — Operation `Read File(s) From Disk`, File(s) Selector `={{ $('Leer salida').item.json.ruta }}`.
6. `Google Drive` — Operation `Upload`, Input Data Field Name `data`, File Name `={{ $('Leer salida').item.json.nombre }}`, Parent Drive `My Drive`, Parent Folder el ID de tu carpeta de backups.
7. `Google Sheets` — Operation `Append` en `historico_backups`: `fecha` = `={{ $now.toISO() }}`, `archivo`, `bytes`, `estado` = `subido`.
8. `Google Sheets` — Operation `Get Row(s)` de la misma hoja, para leer el histórico.
9. `Code` (*Vigilar encogimiento*) — Mode `Run Once for All Items`:
```js
const filas = $input.all().map(i => i.json).filter(r => r.estado === 'subido');
const actual = filas[filas.length - 1];
const previas = filas.slice(-8, -1).map(r => Number(r.bytes));
const media = previas.length ? previas.reduce((a, b) => a + b, 0) / previas.length : Number(actual.bytes);
const sospechoso = Number(actual.bytes) < media * 0.8;
return [{ json: { sospechoso, bytes: actual.bytes, media: Math.round(media), archivo: actual.archivo } }];
```
10. `IF` — `={{ $json.sospechoso }}` `is true` > `Gmail` con asunto `Copia de seguridad sospechosamente pequeña` y el detalle de bytes vs media.
11. `Google Drive` — Operation `Search Files and Folders` en la carpeta de backups, y detrás un `Code` que se quede con los archivos de más de 30 días:
```js
const limite = Date.now() - 30 * 86400000;
return $input.all().filter(i => new Date(i.json.createdTime).getTime() < limite);
```
12. `Google Drive` — Operation `Delete File`, File `={{ $json.id }}`.
13. `Execute Command` final — `rm -f {{ $('Leer salida').item.json.ruta }}` para no llenar el disco del servidor.
**Cómo probarla**
- Ejecuta a mano y descarga el archivo de Drive. En tu ordenador: `gpg -d bd_xxx.sql.gz.gpg | gunzip > prueba.sql` y luego `psql -d base_de_pruebas -f prueba.sql`. **Si no has restaurado una copia, no tienes copias.** Hazlo una vez al trimestre.
- Prueba el aviso de encogimiento poniendo a mano un `bytes` ridículo en la última fila del histórico y relanzando desde el paso 8.
**Qué puede salir mal**
- *Espacio en disco*: un volcado grande puede llenar `/tmp`. Comprueba con `df -h` y, si vas justo, monta un volumen para `/tmp` en el contenedor.
- *Cuota de Google Drive*: 15 GB gratis compartidos con Gmail y Fotos. Con retención de 30 días y volcados de 200 MB vas justo; baja la retención o usa Backblaze B2 (0,006 $/GB/mes) vía `HTTP Request`.
- *La contraseña de cifrado en el comando*: úsala siempre desde variable de entorno, nunca escrita en el nodo, o quedará en el historial de ejecuciones y se iría con el flujo si lo exportas. Lo mismo para `PGPASS`: si falta la variable, `pg_dump` falla por autenticación.
- *Bloqueos en la base de datos*: `pg_dump` no bloquea escrituras, pero si tu base es grande hazlo contra una réplica de lectura.
- *Zonas horarias*: usa `date -u` como en el comando; así los nombres de archivo ordenan bien siempre.
**Cuánto cuesta**
Gratis con n8n auto-alojado y los 15 GB de Google Drive. Si necesitas más espacio: Google One 100 GB por 1,99 €/mes o Backblaze B2 por céntimos. Compara con un servicio de backup gestionado (15-30 €/mes) y verás el ahorro.
