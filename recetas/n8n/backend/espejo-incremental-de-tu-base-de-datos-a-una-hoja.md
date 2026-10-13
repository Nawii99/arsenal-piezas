# Espejo incremental de tu base de datos a una hoja…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Copia a una hoja o a Airtable solo lo que ha cambiado desde la última vez, usando un marcador y una huella para no duplicar ni repetir trabajo.

## Qué es y qué hace

Cada 15 minutos lleva a Airtable o Sheets solo las filas creadas o modificadas desde la última pasada, usando un marcador de tiempo guardado y una huella del contenido para no reescribir lo que no cambió. Entran una tabla con updated_at y la base de destino; sale una copia fresca y ligera. Para equipos que necesitan datos actualizados sin acceso directo a la base.

## Cómo usarla

1. Añade la columna updated_at y su trigger en Postgres
2. Crea la tabla sync_estado con el marcador
3. Prepara la base de Airtable con id_origen y huella
4. Ejecuta una carga inicial y compara conteos

## Cuándo usarla

Cuando tu equipo pide ver datos del backend y acabas exportando CSV a mano, o tienes un flujo que copia toda la tabla cada noche.

## Cómo ganar dinero con ella

Sustituye media hora diaria de exportar y pegar, y baja el coste de lectura de la base de 100.000 filas a las 200 que cambiaron.

- Sincronización de pedidos para equipos de atención al cliente en Airtable…
- Configuración de un espejo de datos para pymes que comparten información con su equipo…
- Mantenimiento de integraciones de datos entre la base de producción y herramientas de equipo…

**Precio orientativo:** 150–400 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada 15 minutos lleva a Airtable (o a Sheets) solo las filas creadas o modificadas desde la última pasada, usando un marcador de tiempo guardado y una huella del contenido para no reescribir lo que no ha cambiado.
Para el que quiere que ventas o atención al cliente vean datos frescos sin darles acceso a la base ni matarla a consultas.

## Lo que necesitas antes
- Que tu tabla tenga una columna `updated_at` que se actualice de verdad. Si no la tiene: `ALTER TABLE pedidos ADD COLUMN updated_at timestamptz DEFAULT now();` más un trigger que la toque en cada UPDATE.
- Una tabla auxiliar para el marcador: `CREATE TABLE sync_estado (flujo TEXT PRIMARY KEY, cursor TIMESTAMPTZ);` e insertar `('pedidos_airtable', '2000-01-01')`.
- Una base de Airtable con una tabla `Pedidos` y un campo de texto `id_origen` marcado como único de facto, más un campo `huella`.
- Token de Airtable: airtable.com/create/tokens, permisos `data.records:read` y `data.records:write` sobre esa base.

## Los nodos, en orden
1. **Schedule Trigger** — Minutes, cada 15.
2. **Postgres** — Execute Query: `SELECT cursor FROM sync_estado WHERE flujo='pedidos_airtable';`
3. **Postgres** — Execute Query con el cursor: `SELECT id, cliente, total, estado, updated_at FROM pedidos WHERE updated_at > $1 ORDER BY updated_at ASC LIMIT 500;` Pasa el cursor en Query Parameters.
4. **IF** — si no hay filas, termina.
5. **Code** — calcula la huella de cada fila.
6. **Split In Batches** — Batch Size: 10, para respetar el límite de Airtable.
7. **Airtable** — Operation: Upsert, Matching Column: `id_origen`. Así una fila que ya existe se actualiza en vez de duplicarse.
8. **Code** — coge el `updated_at` más alto de la tanda.
9. **Postgres** — `UPDATE sync_estado SET cursor=$1 WHERE flujo='pedidos_airtable';` Este nodo va **al final**, nunca antes de escribir en Airtable.

## El código de la huella
```js
const crypto = require('crypto');
return $input.all().map(item => {
  const f = item.json;
  const texto = [f.cliente, f.total, f.estado].join('|');
  const huella = crypto.createHash('md5').update(texto).digest('hex').slice(0, 12);
  return { json: { id_origen: String(f.id), cliente: f.cliente, total: f.total, estado: f.estado, huella, updated_at: f.updated_at } };
});
```

## Cómo probarla
- Cambia el estado de un pedido a mano en la base y espera un ciclo: en Airtable debe cambiar esa fila y ninguna más.
- Ejecuta el flujo dos veces seguidas sin tocar nada: la segunda no debe escribir nada. Si escribe, el cursor no se está guardando.

## Qué puede salir mal
- **Filas modificadas en el mismo segundo que el cursor.** Usa `>` y ordena por `updated_at`, y acepta que puedes reprocesar alguna: como el upsert es idempotente, no pasa nada.
- **Borrados.** Este espejo no ve las filas borradas. Si necesitas eso, usa borrado lógico (`deleted_at`) y filtra en Airtable.
- **Límite de Airtable:** 5 peticiones por segundo. El Batch Size de 10 con «Upsert» va sobrado; si te da 429, añade un nodo Wait de 1 segundo dentro del bucle.
- **Zonas horarias.** Guarda `timestamptz` y compara en UTC. Mezclar `timestamp` sin zona con hora española te hará perder dos horas de datos en verano.

## Cuánto cuesta
- Airtable gratis: 1.000 registros por base. Por encima, 20 $ por usuario y mes: para más volumen usa Google Sheets (hasta 10 millones de celdas, gratis).
- n8n auto-alojado gratis; en Cloud son 2.880 ejecuciones al mes, así que baja a cada hora si usas Cloud.
