# Limpieza y archivado automático de datos viejos con inf…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Cada domingo archiva y borra los datos que ya no sirven (logs, sesiones, carritos abandonados, exportaciones), y te manda un informe con qué tablas están creciendo más.

## Qué es y qué hace

Cada domingo localiza en tu base los registros antiguos que ya no sirven (logs, sesiones, carritos abandonados), los exporta a CSV en Drive, los borra por lotes y ejecuta el mantenimiento. Envía un informe con las tablas que más crecen y los índices sin uso. Entrada: tabla de reglas de limpieza; salida: CSV archivado y correo. Se monta en n8n con permisos de borrado acotados.

## Cómo usarla

1. Crea la tabla de reglas de limpieza
2. Prueba en un entorno de pruebas
3. Activa el ciclo semanal
4. Que lo revise un profesional

## Cuándo usarla

Cuando tu base de datos crezca sin control, las consultas empiecen a ir lentas o estés a punto de pasarte del plan gratuito de tu proveedor por culpa de tablas de basura.

## Cómo ganar dinero con ella

Retrasa años el salto al siguiente plan de base de datos (de 25 a 100 euros al mes) y mantiene las consultas rápidas, que es lo que hace que tu web no vaya lenta.

- Mantenimiento de bases de datos para apps con crecimiento descontrolado de logs.
- Optimización de consultas para tiendas online lentas por tablas de carritos.
- Informe trimestral de salud de base de datos para pequeños proveedores de software.

**Precio orientativo:** 100–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada domingo de madrugada exporta a CSV los registros antiguos que vas a borrar (por si acaso), los sube a Google Drive, los borra por lotes para no bloquear la base de datos, ejecuta el mantenimiento y te manda un correo con el antes y el después.
El informe incluye el tamaño de las 10 tablas más grandes, cuánto han crecido en la semana y qué índices no está usando nadie.

## Lo que necesitas antes
- n8n (Cloud o auto-alojado).
- PostgreSQL con un usuario que tenga permiso de DELETE en las tablas afectadas (no hace falta superusuario salvo para VACUUM FULL, que aquí no usamos).
- Carpeta "Archivo BD" en Google Drive y credencial Google Drive OAuth2.
- Credencial Gmail OAuth2.
- Una tabla de reglas para no tener que tocar el flujo cada vez que añadas una limpieza:
```sql
CREATE TABLE limpieza_reglas (
  id SERIAL PRIMARY KEY, tabla TEXT, campo_fecha TEXT, dias INT,
  condicion_extra TEXT DEFAULT 'true', archivar BOOLEAN DEFAULT true, activa BOOLEAN DEFAULT true
);
INSERT INTO limpieza_reglas (tabla, campo_fecha, dias, condicion_extra, archivar) VALUES
  ('logs_acceso','creado',90,'true',false),
  ('sesiones','expira',7,'true',false),
  ('carritos','actualizado',180,"estado = 'abandonado'",true),
  ('exportaciones','creado',30,'true',false),
  ('webhooks_cola','creado',60,"estado IN ('hecho','muerto')",true);
```

## Los nodos, en orden
1. **Schedule Trigger** — Cron: `0 4 * * 0` (domingos a las 4), Timezone Europe/Madrid.
2. **Postgres** (nombre: Tamaños antes) — la consulta de tamaños de abajo.
3. **Postgres** (nombre: Leer reglas) — `SELECT * FROM limpieza_reglas WHERE activa;`
4. **Loop Over Items** — Batch Size: 1.
5. **Postgres** (nombre: Contar) — `SELECT count(*) AS n FROM {{ $json.tabla }} WHERE {{ $json.campo_fecha }} < now() - interval '{{ $json.dias }} days' AND ({{ $json.condicion_extra }});`
6. **IF** (nombre: ¿Hay algo y hay que archivar?) — `={{ Number($json.n) > 0 && $('Loop Over Items').first().json.archivar }}`.
7. **Postgres** (nombre: Extraer) — `SELECT * FROM {{ ... }} WHERE ... LIMIT 50000;`
8. **Convert to File** — Operation: Convert to CSV, Put Output File in Field: data, Options: Header Row activado, Delimiter: `;` (para que Excel en español lo abra bien).
9. **Google Drive** — Upload, File Name: `=archivo-{{ tabla }}-{{ $now.format('yyyy-MM-dd') }}.csv`, carpeta Archivo BD.
10. **Postgres** (nombre: Borrar por lotes) — la consulta de borrado por lotes de abajo. Detrás un **IF** que compruebe si quedan filas y vuelva a este mismo nodo hasta que devuelva 0.
11. (fin del loop) **Postgres** (nombre: Mantenimiento) — `VACUUM (ANALYZE);` Ojo: este nodo necesita que la conexión no esté en transacción; si te da error, ejecútalo con un nodo aparte y la opción "Execute Query" simple.
12. **Postgres** (nombre: Tamaños después) — la misma consulta de tamaños.
13. **Postgres** (nombre: Índices sin usar) — la consulta de abajo.
14. **Code** (nombre: Informe) — monta la tabla HTML comparando antes y después.
15. **Gmail** — Send, Subject: `=🧹 Limpieza semanal: liberados {{ $json.liberado }}`, HTML con el informe.

## La consulta de tamaños
```sql
SELECT relname AS tabla,
  pg_size_pretty(pg_total_relation_size(c.oid)) AS legible,
  pg_total_relation_size(c.oid) AS bytes,
  (SELECT reltuples::bigint FROM pg_class WHERE oid = c.oid) AS filas_aprox
FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE n.nspname = 'public' AND c.relkind = 'r'
ORDER BY pg_total_relation_size(c.oid) DESC LIMIT 10;
```

## El borrado por lotes
```sql
WITH lote AS (
  SELECT ctid FROM {{ $json.tabla }}
  WHERE {{ $json.campo_fecha }} < now() - interval '{{ $json.dias }} days'
    AND ({{ $json.condicion_extra }})
  LIMIT 5000
)
DELETE FROM {{ $json.tabla }} WHERE ctid IN (SELECT ctid FROM lote)
RETURNING 1;
```
Borra de 5.000 en 5.000 para no bloquear la tabla ni inflar el WAL. El IF posterior mira `={{ $items().length === 5000 }}` para decidir si vuelve a ejecutarse.

## Índices que nadie usa
```sql
SELECT schemaname||'.'||relname AS tabla, indexrelname AS indice,
  pg_size_pretty(pg_relation_size(indexrelid)) AS tamano, idx_scan AS usos
FROM pg_stat_user_indexes
WHERE idx_scan < 50 AND pg_relation_size(indexrelid) > 1000000
ORDER BY pg_relation_size(indexrelid) DESC;
```

## El código del nodo "Informe"
```javascript
const antes = $('Tamaños antes').all().map(i => i.json);
const despues = $('Tamaños después').all().map(i => i.json);
const idx = $('Índices sin usar').all().map(i => i.json);
const totalAntes = antes.reduce((s,t) => s + Number(t.bytes), 0);
const totalDespues = despues.reduce((s,t) => s + Number(t.bytes), 0);
const mb = b => (b / 1048576).toFixed(1) + ' MB';
const filas = despues.map(d => { const a = antes.find(x => x.tabla === d.tabla) || { bytes: d.bytes }; const dif = Number(a.bytes) - Number(d.bytes); return '<tr><td>' + d.tabla + '</td><td>' + d.legible + '</td><td>' + (dif > 0 ? '-' + mb(dif) : '+' + mb(-dif)) + '</td></tr>'; }).join('');
const idxHtml = idx.length ? '<h4>Índices que casi nadie usa (plantéate borrarlos)</h4><ul>' + idx.map(i => '<li>' + i.indice + ' en ' + i.tabla + ' — ' + i.tamano + ', ' + i.usos + ' usos</li>').join('') + '</ul>' : '';
return [{ json: { liberado: mb(totalAntes - totalDespues), html: '<h3>Limpieza semanal</h3><p>Liberados <b>' + mb(totalAntes - totalDespues) + '</b>. Total base: ' + mb(totalDespues) + '</p><table border=1 cellpadding=6><tr><th>Tabla</th><th>Tamaño</th><th>Cambio</th></tr>' + filas + '</table>' + idxHtml } }];
```

## Cómo probarla
- **Primero en una copia**. Restaura tu último backup en una base de pruebas y ejecuta ahí. Un DELETE mal escrito no tiene deshacer.
- Ejecuta con todas las reglas puestas a `activa = false` menos una, y con `dias` muy alto para que no borre nada: comprueba que el conteo y el informe salen bien.
- Baja el `dias` poco a poco y verifica que el CSV de Drive contiene exactamente lo que se ha borrado.

## Qué puede salir mal
- **Borrar algo que hacía falta**: por eso archivas a CSV antes. Y por eso el primer mes pon `archivar = true` en todas las reglas, aunque parezca innecesario.
- **Claves foráneas**: si una tabla hija apunta a lo que borras, el DELETE fallará o borrará en cascada. Repasa las relaciones antes con `\d nombre_tabla` en psql.
- **Inyección desde la tabla de reglas**: la `condicion_extra` se mete tal cual en el SQL. Esa tabla la controlas tú, pero no dejes que nadie más escriba en ella.
- **El espacio no baja en disco**: un DELETE normal libera espacio para reutilizar dentro de Postgres, pero no lo devuelve al sistema operativo. Para eso hace falta `VACUUM FULL`, que **bloquea la tabla**: hazlo a mano y solo si de verdad te hace falta el disco.
- **Ejecución larguísima**: si la primera limpieza tiene millones de filas, tardará. Lánzala a mano fuera de horas la primera vez.

## Cuánto cuesta
- Gratis: n8n auto-alojado, Drive hasta 15 GB, Gmail.
- Lo que ahorras: cada gigabyte de Postgres gestionado cuesta entre 0,10 y 0,30 euros al mes, y el salto de plan cuando te pasas del límite es lo caro.
