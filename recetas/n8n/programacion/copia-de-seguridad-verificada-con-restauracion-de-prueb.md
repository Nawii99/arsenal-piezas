# Copia de seguridad verificada con restauración de prueb…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Hace la copia de tu base de datos, la restaura de verdad en una base temporal y comprueba que las tablas tienen filas antes de decirte que todo va bien.

## Qué es y qué hace

Cada noche vuelca la base de datos Postgres o MySQL, la sube cifrada a un almacenamiento tipo Backblaze B2 y una vez por semana la restaura en una base temporal para contar filas de las tablas clave. Entrada: credenciales de la base y un bucket configurado con rclone. Salida: aviso por Gmail solo si la restauración o el recuento fallan. Requiere n8n auto-alojado porque usa Execute Command. Sirve de guía para cualquier pipeline de respaldo.

## Cómo usarla

1. Instala el cliente de base de datos y gzip en n8n
2. Configura rclone hacia B2
3. Define las tablas que hay que contar
4. Que lo revise un profesional

## Cuándo usarla

Cuando tienes una base de datos con datos de clientes y confías en un backup que nunca has restaurado.

## Cómo ganar dinero con ella

Un backup que no se restaura no es un backup; esta receta cuesta 0 € y evita el escenario que se lleva negocios por delante.

- Configuración y prueba de copias de seguridad para tiendas online y SaaS pequeños con Postgres.
- Mantenimiento mensual de backups con restauración de prueba y un informe para el cliente.
- Auditoría de recuperación ante desastres para pymes que nunca han restaurado una copia.

**Precio orientativo:** 250–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

### Qué hace y para quién
Cada noche vuelca la base de datos, la sube cifrada al almacenamiento barato, y una vez por semana la restaura en una base desechable y cuenta las filas de las tablas clave. Si algo no cuadra, te avisa.
Para quien tiene un producto en producción con Postgres o MySQL y ninguna garantía real de recuperación.

### Lo que necesitas antes
- **n8n auto-alojado** (esta receta usa el nodo `Execute Command`, que no existe en n8n Cloud).
- `postgresql-client` y `gzip` instalados en el contenedor de n8n. Si usas Docker, monta una imagen propia con `apk add postgresql-client` o ejecuta los comandos vía SSH.
- Credenciales de la base de datos en variables de entorno de n8n: `PGHOST`, `PGUSER`, `PGPASSWORD`, `PGDATABASE`.
- Una cuenta de Backblaze B2 (10 GB gratis) o cualquier S3, con `rclone` o `aws-cli` configurado.
- Gmail para el aviso.

### Los nodos, en orden
1. **Schedule Trigger** — `Every Day`, hora `3`, timezone `Europe/Madrid`.
2. **Execute Command** (nombre: «Volcar») — comando de `pg_dump` con la fecha en el nombre.
3. **IF** — Condition: Number `{{ $json.exitCode }}` `equals` `0`. Si falla, salta directo al Gmail de error.
4. **Execute Command** (nombre: «Subir») — sube el fichero al bucket.
5. **IF** (nombre: «¿Toca verificar?») — Condition: String `{{ $now.weekday }}` `equals` `7` (domingo).
6. **Execute Command** (nombre: «Restaurar y contar») — restaura en una base temporal y cuenta filas.
7. **Code** (nombre: «Evaluar») — comprueba que ninguna tabla clave venga vacía.
8. **Gmail** — Operation `Send`, asunto verde o rojo según el resultado.

### Comando del nodo «Volcar»
```bash
set -e
F=/backups/db-$(date +%Y%m%d).sql.gz
pg_dump --no-owner --clean | gzip -9 > $F
ls -l $F | awk '{print $5}'
```

### Comando del nodo «Restaurar y contar»
```bash
set -e
F=/backups/db-$(date +%Y%m%d).sql.gz
psql -c "DROP DATABASE IF EXISTS prueba_restore"
psql -c "CREATE DATABASE prueba_restore"
gunzip -c $F | psql -d prueba_restore > /dev/null 2>&1
psql -d prueba_restore -At -F',' -c "SELECT 'usuarios', count(*) FROM usuarios UNION ALL SELECT 'pedidos', count(*) FROM pedidos UNION ALL SELECT 'facturas', count(*) FROM facturas"
psql -c "DROP DATABASE prueba_restore"
```

### El código del nodo «Evaluar»
```javascript
const salida = String($input.first().json.stdout || '').trim();
const filas = salida.split('\n').filter(Boolean).map(l => { const [tabla, n] = l.split(','); return { tabla, filas: Number(n) }; });
const vacias = filas.filter(f => !f.filas);
const ok = filas.length > 0 && vacias.length === 0;
const texto = filas.map(f => `${f.tabla}: ${f.filas} filas`).join('\n');
return [{ json: { ok, vacias: vacias.map(v => v.tabla), texto, asunto: ok ? '✅ Backup restaurado y verificado' : '🚨 BACKUP SOSPECHOSO: tablas vacías' } }];
```

### Cómo probarla
- Ejecuta el nodo «Volcar» a mano y comprueba con `ls -lh /backups` que el fichero pesa lo que esperas (si son 20 bytes, algo va mal).
- Fuerza la rama de verificación cambiando el IF a que se cumpla siempre, y mira el correo con el recuento.
- Cambia el nombre de una tabla en el SQL a una inexistente: debe llegarte el correo rojo. Esa es la prueba de que la alarma funciona.

### Qué puede salir mal
- **Disco lleno**: añade al final del comando `find /backups -name 'db-*.sql.gz' -mtime +14 -delete` para conservar solo dos semanas en local.
- **Contraseña en el comando**: nunca la escribas ahí; usa variables de entorno o un fichero `.pgpass` con permisos 600.
- **Restaurar sobre la base buena**: el nombre `prueba_restore` es sagrado; revisa dos veces que el `psql -d` de la restauración lleva ese `-d` y no el de producción.
- **Backup sin cifrar en la nube**: añade `| gpg --symmetric --batch --passphrase-file /run/secrets/pass` antes de subir.
- **Base enorme**: si el volcado tarda más de una hora, sube el `Timeout` del nodo Execute Command en Settings y considera `pg_dump -Fc` con `pg_restore -j 4`.

### Cuánto cuesta
- n8n auto-alojado en un VPS: 5-8 €/mes, que probablemente ya pagas.
- Backblaze B2: 10 GB gratis y unos 0,006 $/GB/mes después. Para una base de 5 GB comprimida, céntimos.
- Un servicio gestionado de backups verificados empieza en 25-40 €/mes.
