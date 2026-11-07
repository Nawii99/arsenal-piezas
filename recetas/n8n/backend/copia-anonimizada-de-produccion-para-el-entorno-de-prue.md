# Copia anonimizada de producción para el entorno de prue…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Cada sábado clona tu base de datos real en el entorno de pruebas y borra o falsea los datos personales antes de que nadie los toque.

## Qué es y qué hace

Cada sábado restaura una copia de producción (idealmente desde una réplica de lectura) en la base de pruebas y ejecuta un guion que sustituye nombres, emails, teléfonos y direcciones por datos falsos coherentes. Después comprueba que no quedan emails reales. Entrada: volcado de producción; salida: base de pruebas anonimizada. Requiere n8n auto-alojado con postgresql-client.

## Cómo usarla

1. Usa una réplica de lectura
2. Escribe el guion de anonimización con datos falsos
3. Prueba que no quedan emails reales
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando pruebas con datos inventados que no reflejan la realidad, o peor, cuando tu entorno de pruebas tiene datos reales de clientes.

## Cómo ganar dinero con ella

Evita una sanción de RGPD y quita 2-3 h de preparar datos de prueba cada vez que hay que probar algo en serio.

- Datos de prueba seguros para agencias que desarrollan apps con datos de clientes.
- Auditoría de anonimización para empresas que deben cumplir el RGPD en entornos de prueba.
- Refresco periódico de entornos de pruebas para equipos de desarrollo pequeños.

**Precio orientativo:** 200–700 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Vuelca la base de producción, la restaura en la base de pruebas y, antes de dar por bueno el refresco, ejecuta un guion de anonimización que sustituye nombres, emails, teléfonos y direcciones por datos falsos coherentes. Comprueba después que no queda ni un email real. Para cualquiera que tenga una app propia con datos de clientes y un entorno de pruebas.
**Lo que necesitas antes**
- n8n **auto-alojado** (usa `Execute Command`).
- `postgresql-client` dentro del contenedor de n8n (`RUN apk add --no-cache postgresql-client` en tu Dockerfile).
- Dos bases: producción (idealmente una **réplica de lectura**, nunca la principal en caliente) y pruebas. Credenciales de ambas como variables de entorno de n8n: `PROD_URL` (producción) y `TEST_ADMIN_URL` (servidor de pruebas, con un usuario que pueda crear y renombrar bases, apuntando a la base `postgres`), con formato `postgres://usuario:clave@host:5432/base`. Nunca escritas en el nodo.
- Credencial `Postgres` en n8n apuntando a la base de **pruebas** (nunca a producción en este flujo).
- Aviso legal: aunque anonimices después, durante unos minutos hay datos reales en pruebas. Lo correcto es restaurar en una base temporal, anonimizar allí y luego renombrar. Abajo va así.
**Los nodos, en orden**
1. `Schedule Trigger` — Cron Expression `0 4 * * 6` (sábados a las 4:00 UTC). En Settings del flujo, Timezone `Europe/Madrid`.
2. `Execute Command` (*Volcar producción*):
```bash
set -e; pg_dump --no-owner --no-acl -Fc "$PROD_URL" -f /tmp/prod.dump; echo listo
```
3. `Execute Command` (*Base temporal limpia*):
```bash
set -e; psql "$TEST_ADMIN_URL" -c 'DROP DATABASE IF EXISTS pruebas_nueva;' -c 'CREATE DATABASE pruebas_nueva;'; pg_restore --no-owner --no-acl -d "${TEST_ADMIN_URL%/*}/pruebas_nueva" /tmp/prod.dump; echo restaurado
```
4. `Postgres` (*Anonimizar*) — Connection apuntando a `pruebas_nueva`, Operation `Execute Query`. Todo en una transacción:
```sql
BEGIN;
UPDATE clientes SET email = 'cliente' || id || '@ejemplo-pruebas.test', nombre = 'Nombre' || id, apellidos = 'Apellido' || id, telefono = '600' || lpad((100000 + id)::text, 6, '0'), direccion = 'Calle Falsa ' || id, dni = 'X' || lpad(id::text, 8, '0');
UPDATE usuarios SET password_hash = crypt('pruebas1234', gen_salt('bf')), email = 'user' || id || '@ejemplo-pruebas.test';
UPDATE pagos SET tarjeta_ultimos4 = '0000', referencia_pasarela = 'test_' || id;
DELETE FROM logs_acceso;
DELETE FROM tokens_sesion;
UPDATE pedidos SET notas_cliente = NULL;
COMMIT;
```
   Si `crypt` no existe, ejecuta antes `CREATE EXTENSION IF NOT EXISTS pgcrypto;`.
5. `Postgres` (*Comprobar que no queda nada real*) — Execute Query:
```sql
SELECT (SELECT count(*) FROM clientes WHERE email NOT LIKE '%@ejemplo-pruebas.test') AS emails_reales, (SELECT count(*) FROM clientes WHERE telefono !~ '^600') AS telefonos_reales, (SELECT count(*) FROM clientes) AS total;
```
6. `IF` — `={{ $json.emails_reales }}` `is equal to` `0` **y** `={{ $json.telefonos_reales }}` `is equal to` `0`.
7. Rama **true** > `Execute Command` (*Cambiazo*):
```bash
set -e; psql "$TEST_ADMIN_URL" -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname='pruebas';" -c 'DROP DATABASE IF EXISTS pruebas_vieja;' -c 'ALTER DATABASE pruebas RENAME TO pruebas_vieja;' -c 'ALTER DATABASE pruebas_nueva RENAME TO pruebas;'; echo cambiado
```
8. Detrás > `Execute Command` — `rm -f /tmp/prod.dump` (importante: ese archivo tiene datos reales sin cifrar).
9. Detrás > `Gmail` — asunto `Entorno de pruebas refrescado`, cuerpo con `{{ $('Comprobar que no queda nada real').item.json.total }} clientes anonimizados`.
10. Rama **false** > `Gmail` con asunto `FALLO: la anonimización no ha quedado limpia` y detrás un `Execute Command` que borre `pruebas_nueva` y el dump. Nunca publiques una base que no ha pasado la comprobación.
**Cómo probarla**
- Ejecútalo primero con una copia pequeña y revisa a mano con `SELECT email, telefono FROM clientes LIMIT 20;` en la base de pruebas.
- Prueba el camino de fallo: comenta una línea del UPDATE (por ejemplo la del teléfono) y comprueba que el flujo aborta y te avisa en vez de publicar.
- Comprueba que tu app de pruebas arranca contra la base renombrada y que puedes entrar con la contraseña `pruebas1234`.
**Qué puede salir mal**
- *Tablas nuevas con datos personales*: si añades una tabla y olvidas anonimizarla, se cuela. Añade a la comprobación una consulta que busque el patrón `@` en columnas de texto de todas las tablas, o mantén una lista revisada cada trimestre.
- *El volcado tarda y bloquea*: hazlo siempre contra una réplica de lectura, no contra la base que atiende a tus clientes.
- *Conexiones abiertas al renombrar*: por eso está el `pg_terminate_backend`. Avisa al equipo de que los sábados a las 4 el entorno se corta un minuto.
- *Secretos dentro de la base* (claves de API de clientes, webhooks): anonimízalos también o el entorno de pruebas podría mandar peticiones reales a terceros. Es el fallo más peligroso y el más olvidado.
- *Variable con otro nombre*: los comandos usan `TEST_ADMIN_URL`; si la defines como `TEST_URL`, `psql` no conecta. Las claves van en variables de entorno: un flujo exportado se llevaría lo escrito en el nodo.
- *Espacio en disco*: guardas dump + base nueva + base vieja a la vez. Ten al menos 3 veces el tamaño de la base libre.
**Cuánto cuesta**
Gratis con n8n auto-alojado. El coste real es el del servidor de pruebas, que ya tienes. Herramientas comerciales de enmascaramiento de datos empiezan en cientos de euros al mes.
