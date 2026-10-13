# Borrado y anonimizado de datos por RGPD con evidencia…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Cada mes anonimiza los datos personales que ya no puedes conservar, según los plazos que tú definas, y deja un registro firmado de lo hecho.

## Qué es y qué hace

El día 1 de cada mes recorre las tablas con datos personales, anonimiza los registros que superan el plazo de conservación que tú fijas (sustituyendo, no borrando) y anota en una hoja qué se hizo, cuántas filas y con qué regla. Entran una hoja de política de retención y credenciales de base con UPDATE; sale la anonimización y un registro de evidencia. Trata datos personales: que lo revise un profesional.

## Cómo usarla

1. Escribe la política de retención con tu asesor
2. Rellena las hojas politica_retencion y registro_rgpd
3. Haz copia de seguridad antes de la primera ejecución
4. Ejecuta en seco y revisa el registro
5. Que lo revise un profesional

## Cuándo usarla

Cuando guardas datos de clientes, presupuestos o currículums y sabes que «hay que borrarlos en algún momento», pero nunca hay momento.

## Cómo ganar dinero con ella

Las sanciones del RGPD empiezan en miles de euros. Y en una inspección o una auditoría de cliente, el registro es lo que te salva.

- Anonimización mensual de datos para pymes con bases de contactos y candidatos…
- Cumplimiento RGPD con evidencia para agencias que gestionan datos de clientes…
- Auditoría y limpieza de datos personales para tiendas online antes de una inspección…

**Precio orientativo:** 150–400 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
El día 1 de cada mes recorre las tablas con datos personales, anonimiza (no borra: sustituye) los registros que superan el plazo de conservación que tú has fijado y anota en una hoja qué se hizo, cuántas filas y con qué regla.
Para autónomos y pymes que guardan contactos, candidatos o clientes antiguos.

## Lo que necesitas antes
- Una hoja `politica_retencion` con columnas: tabla, campo_fecha, meses, campos_a_anonimizar, condicion_extra. Ejemplo de fila: `leads | creado_en | 24 | nombre,email,telefono | estado <> 'cliente'`.
- Un usuario de base de datos con permiso de UPDATE sobre esas tablas (no hace falta DELETE: anonimizar es más seguro y conserva tus estadísticas).
- Una hoja `registro_rgpd` con columnas: fecha, tabla, regla, filas_afectadas, ejecutado_por.
- Habla con tu asesor sobre los plazos: 6 años para lo contable, 2 años típicos para candidatos, lo que digas en tu política de privacidad para el marketing.

## Los nodos, en orden
1. **Schedule Trigger** — Days, Trigger at Day of Month: 1, hora 4:00.
2. **Google Sheets** — Get Row(s) de `politica_retencion`.
3. **Split In Batches** — Batch Size: 1.
4. **Code** — construye la SQL de anonimizado a partir de la fila (código abajo).
5. **Postgres** — Execute Query con `={{ $json.sql_conteo }}` para saber cuántas filas se van a tocar.
6. **IF** — si el conteo es mayor que 5.000, para y avisa: algo huele raro y prefieres revisarlo a mano.
7. **Postgres** — Execute Query con `={{ $json.sql_update }}`.
8. **Google Sheets** — Append a `registro_rgpd`.
9. **Gmail** — resumen mensual con todas las reglas ejecutadas.

## El código que arma la SQL
```js
const f = $input.first().json;
const campos = String(f.campos_a_anonimizar).split(',').map(c => c.trim());
const sets = campos.map(c => {
  if (c === 'email') return `${c} = 'anon-' || id || '@borrado.local'`;
  if (c === 'telefono') return `${c} = NULL`;
  return `${c} = 'ANONIMIZADO'`;
}).join(', ');
const donde = `${f.campo_fecha} < now() - interval '${parseInt(f.meses)} months' AND ${campos[0]} <> 'ANONIMIZADO'` + (f.condicion_extra ? ` AND (${f.condicion_extra})` : '');
return [{ json: {
  tabla: f.tabla,
  regla: `${f.tabla}: ${f.meses} meses`,
  sql_conteo: `SELECT count(*) AS n FROM ${f.tabla} WHERE ${donde};`,
  sql_update: `UPDATE ${f.tabla} SET ${sets}, anonimizado_en = now() WHERE ${donde};`
} }];
```

## Cómo probarla
- **Primero en una copia de la base.** Restaura la copia de seguridad de la receta 2 en una base `pruebas` y apunta ahí el flujo.
- Ejecuta solo hasta el nodo del conteo y mira el número: si te sale la tabla entera, tu `campo_fecha` está mal.
- Añade a las tablas la columna `anonimizado_en timestamptz` antes de nada; el código la usa.

## Qué puede salir mal
- **Borrar lo que la ley te obliga a guardar.** Facturas y datos fiscales se conservan; nunca metas la tabla de facturación aquí sin preguntar a tu asesor.
- **Anonimizado que se puede deshacer.** No uses el email como semilla del sustituto: usa el id, como en el código.
- **Copias en otros sitios.** Tu CRM, tu herramienta de email y tus copias de seguridad también tienen esos datos. Añade una fila de recordatorio manual en el correo mensual.
- **Reejecución.** La condición `<> 'ANONIMIZADO'` hace el flujo idempotente: puedes lanzarlo dos veces sin daño.

## Cuánto cuesta
- Gratis. Lo único que puede costar es la media hora de tu asesor para fijar los plazos, y merece la pena.
