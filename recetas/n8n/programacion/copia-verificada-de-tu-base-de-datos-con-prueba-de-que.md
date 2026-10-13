# Copia verificada de tu base de datos con prueba de que…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Vuelca cada noche tu base de datos PostgreSQL a Google Drive, comprueba que el archivo no está vacío ni es sospechosamente pequeño y avisa si algo huele mal.

## Qué es y qué hace

Flujo de n8n que cada noche genera un volcado comprimido de tu PostgreSQL con pg_dump, lo sube a Google Drive y compara su tamaño con el de los tres días anteriores. Avisa si ha encogido más de un 20 por ciento, señal de volcado incompleto o borrado masivo, y rota las copias de los últimos 14 días más una mensual. Requiere n8n auto-alojado.

## Cómo usarla

1. Instala el cliente de PostgreSQL en el servidor de n8n
2. Guarda la conexión como variables de entorno
3. Activa la rotación y el aviso de tamaño
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tengas datos de clientes en una base de datos propia o en Supabase y tu única copia sea la del proveedor, que no controlas ni sabes restaurar.

## Cómo ganar dinero con ella

Perder la base de datos de un negocio es un cierre; y una copia que nadie verifica es tan mala como no tenerla. Coste cero frente a un desastre total.

- Copias de seguridad verificadas para bases de datos de pymes y tiendas…
- Mantenimiento de datos para proyectos que guardan información de clientes…
- Plan de recuperación ante desastres para aplicaciones de un solo servidor…

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada noche genera un volcado comprimido de la base de datos, lo sube a Drive, compara su tamaño con el de las tres noches anteriores y avisa si ha encogido más de un 20 por ciento (señal de volcado incompleto o de borrado masivo). Rota las copias: guarda las de los últimos 14 días y la del día 1 de cada mes.
Para el desarrollador que gestiona la base de datos de su propio producto o la de un cliente y no tiene un equipo de sistemas detrás.

## Lo que necesitas antes
- n8n **auto-alojado**, porque necesitas el nodo **Execute Command**, que no existe en n8n Cloud.
- El cliente de PostgreSQL instalado en la máquina de n8n. Si usas Docker, la imagen oficial ya trae `pg_dump`; si no, instálalo con `apt install postgresql-client`.
- Los datos de conexión: host, puerto, base, usuario y contraseña. Guárdalos como **variables de entorno** del contenedor de n8n (`PGHOST`, `PGPORT`, `PGDATABASE`, `PGUSER`, `PGPASSWORD`), nunca escritos dentro del nodo.
- Credencial de Google Drive en n8n y una carpeta «Backups BD» (copia su ID de la URL).
- Bot de Telegram.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 2 * * *` (todas las noches a las 2:00, Europe/Madrid).
2. **Execute Command** («Volcar») — Command:
```bash
FECHA=$(date +%Y-%m-%d) && pg_dump --no-owner --no-acl -Fc "$PGDATABASE" | gzip > /tmp/backup_$FECHA.dump.gz && ls -l /tmp/backup_$FECHA.dump.gz | awk '{print $5}'
```
3. **Code** («Leer tamaño»)
```javascript
const salida = $input.first().json.stdout.trim().split('\n');
const bytes = Number(salida[salida.length - 1]);
const fecha = new Date().toISOString().slice(0, 10);
return [{ json: { fecha, bytes, mb: Math.round(bytes / 1048576 * 100) / 100, ruta: '/tmp/backup_' + fecha + '.dump.gz' } }];
```
4. **IF** («¿Volcado vacío?») — `{{ $json.bytes }}` menor que 1024. Si se cumple, va directo a un **Telegram** de alerta roja y para.
5. **Read/Write Files from Disk** — Operation: Read File, File Selector `{{ $json.ruta }}`, «Property Name» `data`.
6. **Google Drive** — Operation: Upload, Input Data Field `data`, Name `backup_{{ $json.fecha }}.dump.gz`, carpeta «Backups BD».
7. **Google Drive** («Listar copias») — Operation: Search en esa carpeta, pidiendo los campos `name`, `size`, `createdTime`.
8. **Code** («Verificar y rotar»)
```javascript
const archivos = $input.all().map(i => i.json).filter(a => a.name.startsWith('backup_'));
archivos.sort((a, b) => new Date(b.createdTime) - new Date(a.createdTime));
const hoy = Number(archivos[0].size);
const previos = archivos.slice(1, 4).map(a => Number(a.size));
const media = previos.length ? previos.reduce((s, x) => s + x, 0) / previos.length : hoy;
const alerta = hoy < media * 0.8;
const borrar = [];
for (const a of archivos) {
  const dias = (Date.now() - new Date(a.createdTime).getTime()) / 86400000;
  const esDiaUno = a.name.includes('-01.dump');
  if (dias > 14 && !esDiaUno) borrar.push({ id: a.id, name: a.name });
}
return [{ json: { alerta, hoy_mb: Math.round(hoy / 1048576), media_mb: Math.round(media / 1048576), borrar } }];
```
9. **Item Lists** (Split Out sobre `borrar`) y **Google Drive** (Operation: Delete File) para la rotación.
10. **Execute Command** («Limpiar temporal») — `rm -f /tmp/backup_*.dump.gz`.
11. **Telegram** — mensaje diario corto: `✅ Copia {{ $json.hoy_mb }} MB subida` o `⚠️ La copia de hoy ({{ $json.hoy_mb }} MB) es mucho menor que la media ({{ $json.media_mb }} MB), revisa`.

## Cómo probarla
Ejecuta a mano y baja el archivo de Drive. La prueba de verdad es la restauración: en tu máquina crea una base vacía y ejecuta `pg_restore --no-owner -d pruebas backup_FECHA.dump.gz` tras descomprimir con `gunzip`. Si no restauras nunca, no tienes copia, tienes un archivo. Hazlo al menos una vez cada trimestre y apúntalo en el calendario.

## Qué puede salir mal
- **`pg_dump` no está en el contenedor**: el Execute Command devolverá «command not found». Añade `apk add postgresql-client` a tu Dockerfile o usa una imagen que lo incluya.
- **Versiones incompatibles**: si el servidor es PostgreSQL 16 y tu cliente es el 13, `pg_dump` se niega. Instala el cliente de la misma versión mayor o superior.
- **Disco lleno**: los volcados en `/tmp` se acumulan si falla la subida. El nodo de limpieza y un `df -h` de vez en cuando lo evitan.
- **Datos personales**: una copia con datos de clientes en tu Drive entra dentro del RGPD. Cífrala añadiendo `| gpg --symmetric --batch --passphrase "$CLAVE_BACKUP"` a la tubería, y guarda esa clave en un gestor de contraseñas, no en n8n.
- **Supabase**: usa la cadena de conexión de «Session pooler» del panel, no la directa, si tu servidor no tiene IPv6.

## Cuánto cuesta
Gratis hasta los 15 GB de Google Drive; con copias comprimidas de una base pequeña das para meses. Un VPS de 5 euros al mes te sirve para n8n y para esto. Los backups gestionados de proveedores cuestan desde 10-25 euros mensuales.
