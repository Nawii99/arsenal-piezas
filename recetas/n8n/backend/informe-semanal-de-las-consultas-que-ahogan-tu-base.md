# Informe semanal de las consultas que ahogan tu base…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Cada lunes te manda las diez consultas más lentas o más repetidas de tu base de datos, en lenguaje llano y con qué índice falta.

## Qué es y qué hace

Cada lunes lee la estadística de PostgreSQL pg_stat_statements, saca las diez consultas que más tiempo consumen en la semana, con su tiempo medio, llamadas y tablas, y te las envía por correo. Opcionalmente pide a un modelo de IA una explicación de dos frases por consulta. Entran un usuario de solo lectura y la extensión activada; sale un informe semanal. Para apps que crecen y necesitan saber qué indexar.

## Cómo usarla

1. Activa pg_stat_statements en Supabase o en tu Postgres
2. Crea un usuario de solo lectura con acceso a la vista
3. Configura Gmail en n8n
4. Revisa el primer informe con un desarrollador

## Cuándo usarla

Cuando la app va cada vez más lenta según crece y no sabes si es el servidor, el código o una consulta concreta que se ha desmadrado.

## Cómo ganar dinero con ella

Un índice bien puesto suele valer más que doblar el servidor: te ahorras 20-50 € al mes de máquina y ganas velocidad de verdad.

- Diagnóstico de rendimiento de base de datos para apps de clientes con informe semanal…
- Servicio mensual de optimización de consultas para tiendas que van lentas…
- Configuración de informes de consultas para startups sin DBA…

**Precio orientativo:** 80–250 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee la estadística interna de PostgreSQL, saca las diez consultas que más tiempo total consumen en la semana y te las manda por correo con su tiempo medio, sus llamadas y las tablas implicadas.
Opcionalmente le pide a Claude que te explique en dos frases qué está pasando en cada una. Para el que tiene una app creciendo y no tiene un DBA.

## Lo que necesitas antes
- La extensión `pg_stat_statements` activada. En Supabase: Database > Extensions > buscar y activar. En un Postgres propio: añade `shared_preload_libraries = 'pg_stat_statements'` a `postgresql.conf`, reinicia y ejecuta `CREATE EXTENSION pg_stat_statements;`.
- Un usuario de solo lectura con permiso sobre esa vista.
- Credenciales de Gmail en n8n. Para la parte de explicación, una clave de la API de Anthropic (console.anthropic.com > API Keys); es opcional.

## Los nodos, en orden
1. **Schedule Trigger** — Weeks, lunes a las 8:00.
2. **Postgres** — Execute Query con la consulta de abajo.
3. **Code** — limpia la consulta (recorta a 300 caracteres) y calcula porcentajes.
4. **HTTP Request** (opcional) — POST `https://api.anthropic.com/v1/messages`, cabeceras `x-api-key`, `anthropic-version: 2023-06-01`, modelo `claude-haiku-4-5`, pidiéndole que explique cada consulta y sugiera índice.
5. **Code** — monta la tabla HTML del correo.
6. **Gmail** — Send Message con `HTML` activado.
7. **Postgres** — `SELECT pg_stat_statements_reset();` para que la semana siguiente mida solo la semana siguiente.

## La consulta SQL del nodo Postgres
```sql
SELECT
  round(total_exec_time)::bigint AS ms_total,
  calls AS llamadas,
  round(mean_exec_time::numeric, 1) AS ms_media,
  round((100 * total_exec_time / sum(total_exec_time) OVER ())::numeric, 1) AS pct,
  rows AS filas,
  query AS consulta
FROM pg_stat_statements
WHERE query NOT ILIKE '%pg_stat_statements%'
ORDER BY total_exec_time DESC
LIMIT 10;
```

## El código que arma el correo
```js
const filas = $input.all().map(i => i.json);
const tr = filas.map(f => `<tr><td>${f.pct}%</td><td>${f.llamadas}</td><td>${f.ms_media} ms</td><td><code>${String(f.consulta).slice(0,300).replace(/</g,'&lt;')}</code></td></tr>`).join('');
const html = `<h3>Top 10 consultas de la semana</h3><table border=1 cellpadding=6 style="border-collapse:collapse;font-family:sans-serif;font-size:13px"><tr><th>% del tiempo</th><th>Llamadas</th><th>Media</th><th>Consulta</th></tr>${tr}</table><p>Si una consulta se lleva más del 30% del tiempo, ahí está tu cuello de botella.</p>`;
return [{ json: { html } }];
```

## Cómo probarla
- Lanza el flujo a mano un miércoles: si la tabla sale vacía, la extensión no está activa o el usuario no tiene permiso.
- Coge la consulta número uno y ejecútala en tu cliente SQL con `EXPLAIN ANALYZE` delante. Si ves «Seq Scan» sobre una tabla grande, ahí falta un índice.

## Qué puede salir mal
- **El reset borra el histórico.** Si prefieres acumular, quita el paso 7 y compara semanas guardando cada informe en una hoja.
- **Datos sensibles en las consultas.** `pg_stat_statements` normaliza los valores (los sustituye por `$1`), así que no viajan datos de clientes en el correo. Compruébalo antes de mandarlo fuera.
- **Managed databases.** Algunos proveedores no dejan ejecutar el reset: no pasa nada, el informe sigue valiendo.
- **Coste de la IA.** Si activas el paso 4, son diez consultas a la semana con Haiku: céntimos.

## Cuánto cuesta
- Postgres, n8n autoalojado (Community Edition) y Gmail: gratis. n8n Cloud solo tiene prueba gratuita temporal y después es de pago.
- Claude Haiku para las explicaciones: por debajo de 0,20 € al mes con este volumen. Puedes prescindir de ese nodo.
