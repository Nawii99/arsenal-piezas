# Copia incremental de tu base de datos a un panel…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Cada noche lleva solo los registros nuevos de tu base de datos a una hoja o a BigQuery, por lotes y sin duplicar, para que el equipo consulte sin tocar producción.

## Qué es y qué hace

Guarda la marca del último id copiado, pide a tu base de datos solo los registros posteriores con un usuario de solo lectura, los envía en tandas de 500 filas a una hoja y actualiza la marca. Entran la tabla con una columna incremental y la hoja de destino; sale una copia actualizada sin tocar producción. Para tiendas y SaaS que quieren informes sin dar acceso a la base.

## Cómo usarla

1. Crea el usuario de solo lectura en Postgres
2. Verifica que la tabla tiene un id o updated_at fiable
3. Prepara las pestañas Pedidos_copia y Control
4. Ejecuta una carga inicial pequeña

## Cuándo usarla

Úsalo cuando alguien de tu equipo pida datos y acabes exportando CSV a mano, o cuando las consultas de informes ralenticen tu web.

## Cómo ganar dinero con ella

Ahorra 2-4 horas al mes de exportaciones manuales y evita comprar un ETL tipo Fivetran o Stitch (desde 100 €/mes).

- Panel de informes para tiendas con datos actualizados sin tocar la base de producción…
- Sincronización de datos para equipos de ventas en hoja, con actualización nocturna…
- Configuración de copias incrementales para pymes que exportan CSV a mano…

**Precio orientativo:** 100–300 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Guarda una «marca de agua» (el último id o fecha ya copiado), pide a la base solo lo posterior, lo manda en tandas de 500 filas a una hoja de destino y actualiza la marca. Para tiendas y SaaS que quieren informes sin dar acceso a producción.

## Lo que necesitas antes
- Credencial «Postgres» en n8n (host, puerto 5432, base, usuario **de solo lectura**, contraseña). Créalo así: `CREATE USER lector WITH PASSWORD 'x'; GRANT CONNECT ON DATABASE tu_bd TO lector; GRANT SELECT ON ALL TABLES IN SCHEMA public TO lector;`
- Una tabla con una columna incremental fiable: `id` autonumérico o `updated_at`.
- Una hoja «Pedidos_copia» con las cabeceras exactas de las columnas que quieras.
- Una segunda pestaña «Control» con dos celdas: A1 = `ultimo_id`, B1 = `0`.

## Los nodos, en orden
1. **Schedule Trigger** — diario a las 2:00.
2. **Google Sheets** — Get Row(s) de la pestaña «Control» para leer la marca.
3. **Postgres** — Operation: Execute Query. Query:
```sql
SELECT id, creado_en, cliente_email, total, estado
FROM pedidos
WHERE id > $1
ORDER BY id ASC
LIMIT 5000;
```
   En Query Parameters pon: `={{ $json.B || 0 }}`. Usar parámetros y no concatenar texto te protege de inyección.
4. **IF** — Condition: Number → `{{ $input.all().length }}` larger than 0. Si no hay nada nuevo, el flujo acaba aquí.
5. **Code** (renómbralo «Limpiar»)— Run Once for Each Item:
```javascript
const p = $input.item.json;
return { json: {
  id: p.id,
  fecha: p.creado_en ? new Date(p.creado_en).toISOString().slice(0, 19).replace('T', ' ') : '',
  email: (p.cliente_email || '').toLowerCase(),
  total_eur: Number(p.total || 0).toFixed(2),
  estado: p.estado || ''
} };
```
6. **Split In Batches** — Batch Size: 500. Sheets se atraganta con miles de filas de golpe.
7. **Google Sheets** — Operation: Append Row(s), hoja «Pedidos_copia», Mapping: Map Automatically.
8. Conecta la salida de Sheets de vuelta a **Split In Batches**.
9. En la salida «done» de Split In Batches → **Code** para calcular la nueva marca:
```javascript
const filas = $('Limpiar').all().map(i => i.json.id);
const max = filas.length ? Math.max(...filas.map(Number)) : 0;
return [{ json: { ultimo_id: max, copiadas: filas.length, cuando: new Date().toISOString() } }];
```
10. **Google Sheets** — Update Row en la pestaña «Control», poniendo `ultimo_id` en B1.

## Cómo probarla
- Pon la marca a `0` y ejecuta: debe copiar todo (ojo si son millones de filas, empieza con un `LIMIT 100`).
- Vuelve a ejecutar sin insertar nada: no debe copiar nada. Esa es la prueba clave.
- Inserta 3 pedidos de prueba y ejecuta: deben aparecer solo esos 3.

## Qué puede salir mal
- **Filas modificadas después**: si un pedido cambia de estado, con `id >` no se recopia. Si lo necesitas, usa `updated_at > marca` y en Sheets usa «Append or Update Row» con Matching Column `id`.
- **Marca corrupta**: si el flujo falla a mitad, algunas filas ya están en Sheets pero la marca no ha subido; en el siguiente ciclo se duplican. Solución: usa «Append or Update» en vez de «Append».
- **Timeout de Postgres**: baja el `LIMIT` a 1000 y deja que se ejecute varios ciclos.
- **Límite de Sheets**: 10 millones de celdas por documento. Con 5 columnas, unos 2 millones de filas. Antes de llegar, cambia el destino al nodo **Google BigQuery** (tiene 1 TB de consultas gratis al mes).
- **Zona horaria de las fechas**: Postgres suele guardar en UTC. Si quieres hora española, en el SELECT usa `creado_en AT TIME ZONE 'Europe/Madrid'`.

## Cuánto cuesta
n8n 0 €, Postgres el que ya pagas, Sheets 0 €. BigQuery: 10 GB de almacenamiento y 1 TB de consultas gratis al mes, más que de sobra para un negocio pequeño.
