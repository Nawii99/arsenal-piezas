# Panel de negocio: de tu base de datos a Google Sheets c…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Ejecuta las consultas SQL que te importan (ventas del día, altas, carritos abandonados, stock bajo) y vuelca el resultado en pestañas de Google Sheets listas para gráficos.

## Qué es y qué hace

Cada hora ejecuta una serie de consultas SQL de solo lectura contra tu base de datos y vuelca cada resultado en su pestaña de Google Sheets, sustituyendo lo anterior. Además guarda una fila diaria en la pestaña historico para gráficos. Entrada: consultas y usuario de lectura; salida: hoja con ventas, altas o stock. Funciona en n8n sin pagar una herramienta de BI.

## Cómo usarla

1. Crea el usuario de solo lectura
2. Define las consultas en un nodo Code
3. Crea las pestañas en Sheets
4. Conecta el gráfico al histórico

## Cuándo usarla

Cuando ya tengas una base de datos con datos de negocio y quieras un panel que puedas abrir desde el móvil, compartir con tu socio o tu gestor, sin montar ni pagar un Metabase.

## Cómo ganar dinero con ella

Sustituye a un Metabase o Looker Studio con conector de pago (0-50 euros al mes) y, sobre todo, te ahorra pedir informes a un desarrollador a 40-60 euros la hora.

- Panel de ventas para tiendas pequeñas que comparten datos con su gestor.
- Informes automáticos para socios de un negocio local sin acceso a la base.
- Métricas clave para emprendedores que quieren ver ventas desde el móvil.

**Precio orientativo:** 150–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada hora en punto ejecuta un conjunto de consultas SQL definidas en un solo sitio y escribe cada resultado en su pestaña de una hoja de cálculo, borrando lo anterior para que nunca haya duplicados.
Además guarda una fila diaria de métricas clave en una pestaña "historico", que es la que luego usas para ver la evolución en un gráfico.

## Lo que necesitas antes
- n8n (Cloud o auto-alojado).
- Acceso a tu base de datos desde n8n: host, puerto, usuario **de solo lectura**, contraseña y nombre de la base. Si tu base solo acepta conexiones locales, o pones n8n en el mismo servidor, o abres el puerto solo a la IP de n8n.
- Crea el usuario de lectura: `CREATE USER panel WITH PASSWORD 'xxx'; GRANT CONNECT ON DATABASE tubd TO panel; GRANT USAGE ON SCHEMA public TO panel; GRANT SELECT ON ALL TABLES IN SCHEMA public TO panel;`
- Una hoja de Google Sheets "Panel" con pestañas: `ventas_hoy`, `top_productos`, `stock_bajo`, `historico`, `meta`.
- Credencial Google Sheets OAuth2 en n8n y credencial Postgres (Credentials, Postgres, con SSL activado si es Supabase o Neon).

## Los nodos, en orden
1. **Schedule Trigger** — Cron: `5 * * * *` (a y cinco de cada hora, para no coincidir con el resto del mundo), Timezone Europe/Madrid.
2. **Code** (nombre: Consultas) — devuelve un item por cada consulta, con la pestaña destino. Código abajo.
3. **Loop Over Items** — Batch Size: 1.
4. **Postgres** (nombre: Ejecutar) — Operation: Execute Query, Query: `={{ $json.sql }}`, Settings: Always Output Data activado, On Error: Continue.
5. **Code** (nombre: Marcar destino) — añade a cada fila devuelta el nombre de la pestaña que toca.
6. **Google Sheets** (nombre: Vaciar) — Operation: Clear, Sheet: `={{ $json.pestana }}`, Clear: All data except first row.
7. **Google Sheets** (nombre: Escribir) — Operation: Append Row, Sheet: `={{ $json.pestana }}`, Mapping Column Mode: Map Automatically, Handling Extra Data: Insert in New Column.
8. Vuelve al **Loop Over Items** para la siguiente consulta.
9. (Salida done del loop) **Postgres** (nombre: KPIs del día) — la consulta de resumen.
10. **Google Sheets** (nombre: Histórico) — Operation: Append or Update Row en `historico`, columna clave: fecha. Así si se ejecuta 24 veces al día solo hay una fila por día, actualizada.
11. **IF** — `={{ $json.stock_bajo > 0 }}` is true, y detrás **Slack** avisando de las referencias por debajo del mínimo.

## El código del nodo "Consultas"
```javascript
const consultas = [
  { pestana: 'ventas_hoy', sql: "SELECT to_char(creado,'HH24:00') AS hora, count(*) AS pedidos, round(sum(total)::numeric,2) AS euros FROM pedidos WHERE creado::date = current_date AND estado <> 'cancelado' GROUP BY 1 ORDER BY 1" },
  { pestana: 'top_productos', sql: "SELECT p.nombre, sum(l.cantidad) AS unidades, round(sum(l.cantidad*l.precio)::numeric,2) AS euros FROM lineas l JOIN productos p ON p.id=l.producto_id JOIN pedidos o ON o.id=l.pedido_id WHERE o.creado > now() - interval '30 days' GROUP BY 1 ORDER BY 3 DESC LIMIT 20" },
  { pestana: 'stock_bajo', sql: "SELECT sku, nombre, stock, stock_minimo FROM productos WHERE stock <= stock_minimo AND activo = true ORDER BY stock ASC" }
];
return consultas.map(c => ({ json: c }));
```

## El código del nodo "Marcar destino"
```javascript
const pestana = $('Loop Over Items').first().json.pestana;
const filas = $input.all();
if (filas.length === 0) return [{ json: { pestana, vacio: true } }];
return filas.map(f => ({ json: { ...f.json, pestana } }));
```

## La consulta de KPIs del día
```sql
SELECT current_date AS fecha,
  (SELECT count(*) FROM pedidos WHERE creado::date=current_date AND estado<>'cancelado') AS pedidos,
  (SELECT coalesce(round(sum(total)::numeric,2),0) FROM pedidos WHERE creado::date=current_date AND estado<>'cancelado') AS facturado,
  (SELECT count(*) FROM usuarios WHERE creado::date=current_date) AS altas,
  (SELECT count(*) FROM productos WHERE stock<=stock_minimo AND activo) AS stock_bajo;
```

## Cómo probarla
- Ejecuta a mano y comprueba pestaña por pestaña que los números cuadran con lo que ves en tu panel de administración.
- Prueba con una consulta que no devuelva nada (por ejemplo stock bajo cuando no hay ninguno): la pestaña debe quedar vacía pero con cabeceras, no romperse.
- Cambia a mano un dato en la hoja y ejecuta otra vez: debe volver a sobrescribirse. La hoja es un espejo, no un sitio donde escribir.

## Qué puede salir mal
- **Consultas pesadas que ahogan tu base de datos**: haz un `EXPLAIN ANALYZE` de cada una antes de ponerlas cada hora. Si una tarda más de 2 segundos, crea índices o pásala a diaria.
- **Límite de Google Sheets**: 10 millones de celdas por documento y unas 300 escrituras por minuto por usuario. Escribe por lotes (Append Row con todos los items de golpe, no uno a uno).
- **Números que Sheets convierte en fechas**: pon el formato de la columna a Texto antes, o los SKU tipo 12-2026 se te convertirán en diciembre de 2026.
- **Decimales con coma**: usa `round(...::numeric,2)` en SQL y configura la hoja en español para que no te salgan puntos raros.
- **Zona horaria de la base de datos**: si tu Postgres guarda en UTC, un pedido de las 00:30 de Madrid contará como día anterior. Usa `creado AT TIME ZONE 'Europe/Madrid'` en las consultas.

## Cuánto cuesta
- Gratis del todo: n8n auto-alojado, Google Sheets y Slack en plan gratuito.
- En n8n Cloud, 24 ejecuciones al día son 720 al mes: cabe en el plan de entrada.
