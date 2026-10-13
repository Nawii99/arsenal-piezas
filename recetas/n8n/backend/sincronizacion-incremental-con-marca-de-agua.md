# Sincronización incremental con marca de agua…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Copia cada 15 minutos solo los registros que han cambiado desde la última vez entre dos sistemas, sin volver a mover todo ni perderse filas.

## Qué es y qué hace

Cada 15 minutos pide al origen solo los registros modificados desde una marca de agua guardada, los envía al destino por lotes y solo entonces avanza la marca. Si falla a mitad, la siguiente ejecución recupera lo que faltaba sin duplicar. Entrada: tabla con columna updated_at indexada; salida: registros sincronizados en Airtable, Sheets u otra base. Se monta en n8n.

## Cómo usarla

1. Crea el índice en updated_at
2. Genera el token del destino
3. Prueba una carga completa inicial
4. Revisa la marca de agua tras una semana

## Cuándo usarla

Úsalo cuando tienes que mantener dos bases sincronizadas (tienda y ERP, app y almacén de datos) y hoy lo haces con exportaciones completas que tardan y duplican.

## Cómo ganar dinero con ella

Cambia una exportación manual diaria de 30-60 min por un proceso automático, y baja el consumo de API al mover solo lo que cambia.

- Sincronización de tienda y ERP para pymes que hoy exportan a mano cada día.
- Carga incremental a almacén de datos para consultoras con varias fuentes.
- Integración entre app y CRM para negocios que duplican datos a mano.

**Precio orientativo:** 200–800 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Guarda una «marca de agua»: la fecha del último registro que sincronizó. Cada 15 minutos pide al origen solo lo modificado después de esa fecha (con un pequeño solape de seguridad), lo envía al destino por lotes y solo entonces avanza la marca. Si algo falla a mitad, la marca no avanza y en la siguiente vuelta se recupera. Para quien mueve datos entre dos sistemas y no quiere ni duplicados ni huecos.
**Lo que necesitas antes**
- n8n.
- Origen: una base Postgres/MySQL con una columna `updated_at` (tipo `timestamptz`) **con índice**: `CREATE INDEX idx_clientes_updated ON clientes (updated_at);`. Sin índice, la consulta irá lenta según crezca la tabla.
- Destino: otra base, Airtable, Google Sheets o una API con endpoint de upsert. Aquí uso Airtable: airtable.com > cuenta > Personal access token con permisos `data.records:write` sobre la base.
- Una tabla de control en el origen (o una hoja): `CREATE TABLE sync_control (nombre text primary key, watermark timestamptz, actualizado timestamptz);` y una fila inicial `INSERT INTO sync_control VALUES ('clientes', '2000-01-01T00:00:00Z', now());`.
**Los nodos, en orden**
1. `Schedule Trigger` — Minutes, cada `15`.
2. `Postgres` (*Leer marca*) — Execute Query: `SELECT watermark FROM sync_control WHERE nombre = 'clientes';`
3. `Code` (*Calcular ventana*) — Mode `Run Once for All Items`:
```js
const w = $json.watermark;
const desde = new Date(new Date(w).getTime() - 120000).toISOString();
return [{ json: { desde } }];
```
   Ese solape de 2 minutos cubre los relojes desincronizados y las transacciones que se confirman con retraso. Como el destino hace upsert, reprocesar unas filas no molesta.
4. `Postgres` (*Leer cambios*) — Execute Query con parámetros:
```sql
SELECT id, email, nombre, importe, updated_at FROM clientes WHERE updated_at > $1 ORDER BY updated_at ASC LIMIT 500;
```
   Query Parameters: `={{ $json.desde }}`. El `LIMIT 500` es clave: si hubo un cambio masivo, no te comes toda la tabla de golpe; el resto entra en la siguiente vuelta.
5. `IF` — `={{ $items().length }}` `larger` `0` (si no hay nada, el flujo termina y no toca la marca).
6. `Split In Batches` — Batch Size `10` (Airtable acepta 10 registros por llamada).
7. `Airtable` — Operation `Upsert`, Base y Table las tuyas, Columns to Match On `id_origen`, mapeando `id_origen` = `={{ $json.id }}`, `email`, `nombre`, `importe`. Settings: `Retry On Fail` 3 intentos, espera 2000 ms.
8. `Wait` — Amount `250`, Unit `Milliseconds`. Airtable limita a 5 peticiones por segundo por base; esto te deja holgado.
9. Conecta la salida del `Wait` de vuelta a `Split In Batches`. Cuando el bucle termina (salida `done`), sigue al paso 10.
10. `Code` (*Nueva marca*) — Mode `Run Once for All Items`, sobre los datos leídos en el paso 4:
```js
const filas = $('Leer cambios').all().map(i => i.json.updated_at);
const maxima = filas.sort()[filas.length - 1];
return [{ json: { watermark: maxima, procesadas: filas.length } }];
```
11. `Postgres` (*Guardar marca*) — Execute Query: `UPDATE sync_control SET watermark = $1, actualizado = now() WHERE nombre = 'clientes';` con parámetro `={{ $json.watermark }}`. **Solo aquí** avanza la marca, después de que todo haya ido bien.
12. Opcional: `Gmail` de resumen diario leyendo `sync_control` para ver que la marca se mueve.
**Cómo probarla**
- Pon la marca a mano muy atrás (`UPDATE sync_control SET watermark = '2024-01-01'`) y ejecuta: debe traer los 500 primeros y avanzar la marca a la fecha del último.
- Vuelve a ejecutar varias veces hasta que ya no traiga nada: así compruebas que el paginado por marca funciona.
- Toca un registro en el origen (`UPDATE clientes SET nombre='X' WHERE id=5;`) y espera un ciclo: debe llegar solo ese.
- Provoca un fallo (pon mal el token de Airtable) y comprueba que la marca **no** avanza y que en la siguiente vuelta se recupera todo.
**Qué puede salir mal**
- *Registros borrados*: esto no los propaga. Si necesitas borrados, usa borrado lógico en el origen (columna `borrado_at`) y trátalo como un cambio más.
- *Relojes y zonas horarias*: usa `timestamptz` y UTC en todo. Si el origen guarda `timestamp` sin zona, tienes un problema latente: conviértelo con `updated_at AT TIME ZONE 'Europe/Madrid'` o migra la columna.
- *Filas que cambian sin tocar `updated_at`*: si tu app actualiza con SQL directo, añade un trigger: `CREATE TRIGGER t BEFORE UPDATE ON clientes FOR EACH ROW EXECUTE FUNCTION ...` que ponga `updated_at = now()`.
- *Muchas filas con el mismo `updated_at`*: si más de 500 comparten segundo exacto, el paginado se atasca. Ordena por `updated_at, id` y guarda también el último `id` como parte de la marca.
- *Límite de Airtable*: 5 req/s y 100.000 registros por base en el plan gratuito. Si te acercas, cambia el destino por Postgres.
**Cuánto cuesta**
n8n auto-alojado gratis; 96 ejecuciones al día. Airtable gratuito hasta 1.000 registros por base (el de pago desde 20 $/usuario/mes). En Make esto se comería el plan gratuito rápido: cada lote es una operación.
