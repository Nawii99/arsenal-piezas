# Borrado automático de datos antiguos (RGPD)

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Cada mes anonimiza o borra los datos personales que ya no debes guardar, deja constancia de lo hecho y te manda el informe para tu carpeta de cumplimiento.

## Qué es y qué hace

Aplica tu política de conservación cada mes: anonimiza o borra leads sin compra a los 12 meses, currículums a los 24 y carritos abandonados a los 6. Entran una hoja con tablas, campos de fecha y plazos, y credenciales de base con UPDATE y DELETE; sale la limpieza y un registro con fecha, tabla y filas tocadas. Trata datos personales: los plazos y la base legal deben revisarse con un profesional.

## Cómo usarla

1. Escribe la política de conservación con tu asesor
2. Haz una copia de seguridad verificada antes de la primera ejecución
3. Rellena las hojas Politica RGPD y Registro RGPD
4. Ejecuta en modo prueba
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando guardes datos de clientes, leads o currículums en tu base de datos y no tengas ningún proceso de borrado, que es lo que exige el RGPD.

## Cómo ganar dinero con ella

Reduce el riesgo de sanción (las leves ya parten de miles de euros) y evita 3-5 horas trimestrales de limpieza manual y de preparar evidencias.

- Cumplimiento RGPD automatizado para tiendas y pymes con registro de borrados…
- Servicio mensual de depuración de datos personales para agencias con bases de clientes…
- Auditoría de conservación de datos para autónomos que guardan currículums y contactos…

**Precio orientativo:** 150–400 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Aplica tu política de conservación: los leads que no compraron a los 12 meses se anonimizan, los currículums se borran a los 24 meses, los carritos abandonados a los 6. Guarda un registro con fecha, tabla y número de registros tocados, y te manda el informe. Para cualquier negocio con datos personales en base de datos propia.

## Lo que necesitas antes
- Credencial Postgres (o MySQL) en n8n con permiso de UPDATE y DELETE, y **una copia de seguridad reciente y verificada** antes de la primera ejecución.
- Tu política de conservación escrita: qué tabla, qué campo de fecha, cuántos meses, y si se anonimiza o se borra. Anonimizar es casi siempre mejor que borrar: conservas las estadísticas sin conservar a la persona.
- Una hoja «Politica RGPD» con columnas: tabla, campo_fecha, meses, accion (ANONIMIZAR/BORRAR), condicion_extra.
- Una hoja «Registro RGPD» con: fecha, tabla, accion, registros, ejecutado_por.

## Los nodos, en orden
1. **Schedule Trigger** — mensual: Custom (Cron) `0 4 1 * *` (día 1 a las 4:00).
2. **Google Sheets** — Get Row(s) de «Politica RGPD».
3. **Split In Batches** — Batch Size 1.
4. **Code** (renómbralo «Construir SQL») — Run Once for Each Item:
```javascript
const p = $input.item.json;
const meses = parseInt(p.meses, 10);
const extra = (p.condicion_extra || '').trim();
const donde = `${p.campo_fecha} < NOW() - INTERVAL '${meses} months'` + (extra ? ` AND ${extra}` : '');
let sql;
if ((p.accion || '').toUpperCase() === 'BORRAR') {
  sql = `DELETE FROM ${p.tabla} WHERE ${donde}`;
} else {
  sql = `UPDATE ${p.tabla} SET nombre = 'anonimizado', email = 'anon_' || id || '@borrado.local', telefono = NULL, direccion = NULL, notas = NULL WHERE ${donde} AND email NOT LIKE 'anon_%'`;
}
return { json: { tabla: p.tabla, accion: p.accion, sql, conteo: `SELECT COUNT(*) AS n FROM ${p.tabla} WHERE ${donde}` } };
```
5. **Postgres** (renómbralo «Contar antes») — Execute Query: `={{ $json.conteo }}`.
6. **IF** — Number: `{{ $json.n }}` larger than 0.
7. Rama true → **Postgres** (renómbralo «Ejecutar») — Execute Query: `={{ $('Construir SQL').first().json.sql }}`.
8. → **Google Sheets** — Append Row en «Registro RGPD» con fecha, tabla, acción, número y `n8n-automatico`.
9. Vuelve a **Split In Batches**. En «done» → **Code** que junta el resumen → **Gmail** con asunto `Informe RGPD {{ $now.format('MMMM yyyy') }}` y el detalle línea a línea.

## Cómo probarla
- **Primero en una copia**: restaura tu backup en una base de pruebas y ejecuta todo ahí. No lo estrenes en producción.
- Desconecta el nodo «Ejecutar» y deja solo el conteo: verás cuántos registros tocaría cada regla. Si el número te sorprende, revisa la condición antes de seguir.
- Ajusta `condicion_extra` para excluir lo que debes conservar por ley fiscal: por ejemplo `id NOT IN (SELECT cliente_id FROM facturas)`, porque las facturas hay que guardarlas 4-6 años aunque el cliente pida su borrado.

## Qué puede salir mal
- **Borras algo que debías conservar**: la obligación fiscal de conservar facturas convive con el RGPD. Anonimiza el lead, nunca la factura. Usa siempre `condicion_extra` para protegerlas.
- **Inyección desde la hoja**: este SQL se construye con texto de la hoja, así que **solo tú** debes poder editarla. No des permiso de edición a nadie más.
- **Sin vuelta atrás**: un DELETE no se deshace. Añade antes un **Postgres** que copie los registros a una tabla `_papelera` con fecha, y bórrala del todo a los 30 días.
- **Zonas horarias**: `NOW()` en Postgres suele ir en UTC; para un corte mensual da igual, no te compliques.
- **Tablas grandes**: un DELETE de millones de filas bloquea la tabla. Trocéalo añadiendo `AND id IN (SELECT id FROM tabla WHERE ... LIMIT 5000)` y ejecutando varias veces.

## Cuánto cuesta
0 € en herramientas. Esto no sustituye a un asesor legal: la política de conservación la defines tú o tu asesoría, el flujo solo la ejecuta sin fallos.
