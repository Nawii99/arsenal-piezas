# Sincronización nocturna de una API externa a tu base de…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Cada noche descarga lo que ha cambiado en un servicio externo (Stripe, Holded, un ERP, un proveedor) y lo mete en tus tablas, solo lo nuevo, sin duplicar y aguantando cortes.

## Qué es y qué hace

Cada noche consulta un servicio externo (Stripe, Holded, un ERP) qué ha cambiado desde el último punto de corte, pagina y actualiza tus tablas con UPSERT. Guarda el punto de corte en una tabla de control, así que si falla una noche, la siguiente recupera lo que faltaba. Entrada: API de solo lectura; salida: tablas actualizadas y resumen. Se monta en n8n con PostgreSQL o MySQL propios.

## Cómo usarla

1. Crea la clave restringida de solo lectura
2. Revisa paginación y límites de la API
3. Crea la tabla de control
4. Que lo revise un profesional

## Cuándo usarla

Cuando necesites tener en tu propia base de datos lo que vive en un servicio de terceros para poder consultarlo, cruzarlo o hacer informes sin depender de su API cada vez.

## Cómo ganar dinero con ella

Sustituye herramientas de ETL como Fivetran o Airbyte Cloud (desde 100-300 euros al mes) y evita horas de exportar e importar CSV a mano.

- Integración de datos para tiendas que quieren informes sin depender de la API de Stripe.
- Sincronización con el ERP para empresas pequeñas que cruzan ventas y stock.
- Carga nocturna de datos de proveedores para consultoras con informes mensuales.

**Precio orientativo:** 300–1200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada noche a las 02:00 pregunta al servicio externo qué ha cambiado desde la última sincronización correcta (sincronización incremental), pagina hasta traérselo todo, lo transforma a tu esquema y lo inserta o actualiza con un UPSERT.
Guarda el punto de corte en una tabla de control, así que si una noche falla, la siguiente recupera lo que faltaba sin perder nada ni duplicar.

## Lo que necesitas antes
- n8n (Cloud o auto-alojado).
- PostgreSQL o MySQL propios.
- La API key del servicio externo, de solo lectura. En Stripe: Developers, API keys, Restricted key con permiso de lectura en Charges y Customers.
- Saber tres cosas de esa API: cómo se filtra por fecha de modificación, cómo se pagina (cursor o página) y cuál es su límite de peticiones. Está en su documentación, apartado "Rate limits" y "Pagination".
- Bot de Telegram para el resumen.

## Las tablas
```sql
CREATE TABLE sync_control (
  fuente TEXT PRIMARY KEY,
  ultimo_ok TIMESTAMPTZ NOT NULL DEFAULT '2020-01-01',
  ultimo_intento TIMESTAMPTZ, filas_ultima INT, error TEXT
);
CREATE TABLE ext_pagos (
  id TEXT PRIMARY KEY, cliente_email TEXT, importe NUMERIC(12,2), moneda TEXT,
  estado TEXT, creado TIMESTAMPTZ, actualizado TIMESTAMPTZ,
  bruto JSONB, sincronizado TIMESTAMPTZ DEFAULT now()
);
CREATE INDEX ON ext_pagos (creado);
INSERT INTO sync_control (fuente) VALUES ('stripe_pagos') ON CONFLICT DO NOTHING;
```

## Los nodos, en orden
1. **Schedule Trigger** — Cron: `0 2 * * *`, Timezone Europe/Madrid.
2. **Postgres** (nombre: Leer control) — `SELECT ultimo_ok FROM sync_control WHERE fuente='stripe_pagos';`
3. **Set** (nombre: Estado inicial) — campos: `cursor` vacío, `desde` = `={{ Math.floor(new Date($json.ultimo_ok).getTime()/1000) }}`, `total` = 0.
4. **HTTP Request** (nombre: Pedir página) — GET `https://api.stripe.com/v1/charges`, Authentication: Predefined, Stripe. Query Parameters: `limit`=100, `created[gte]`=`={{ $json.desde }}`, y `starting_after`=`={{ $json.cursor }}` (marca este parámetro para que se omita si está vacío, o añádelo con una expresión condicional). Settings: Retry On Fail, Max Tries 5, Wait Between Tries 3000.
5. **Code** (nombre: Transformar) — pasa cada cargo al formato de tu tabla.
6. **Postgres** (nombre: Guardar) — Operation: Execute Query con el UPSERT de abajo. Marca "Execute Once" desactivado.
7. **IF** (nombre: ¿Hay más?) — Boolean `={{ $('Pedir página').first().json.has_more }}` is true.
8. (rama sí) **Wait** — Amount: 1, Unit: Seconds, para no pasarte del límite de la API. Y vuelve al nodo "Pedir página" con el cursor actualizado.
9. (rama no) **Postgres** (nombre: Cerrar control) — `UPDATE sync_control SET ultimo_ok = now() - interval '10 minutes', ultimo_intento = now(), filas_ultima = $1, error = NULL WHERE fuente='stripe_pagos';`
10. **Telegram** — resumen: filas nuevas, actualizadas y tiempo.
11. **Error Trigger** en un workflow aparte — apunta el error en sync_control y te avisa; como no se toca `ultimo_ok`, la siguiente noche recupera lo pendiente.

## El código del nodo "Transformar"
```javascript
const resp = $input.first().json;
const datos = resp.data || [];
return datos.map(c => ({ json: {
  id: c.id,
  cliente_email: c.billing_details?.email || c.receipt_email || null,
  importe: (c.amount || 0) / 100,
  moneda: (c.currency || 'eur').toUpperCase(),
  estado: c.status,
  creado: new Date((c.created || 0) * 1000).toISOString(),
  actualizado: new Date().toISOString(),
  bruto: JSON.stringify(c)
} }));
```

## El UPSERT del nodo "Guardar"
```sql
INSERT INTO ext_pagos (id, cliente_email, importe, moneda, estado, creado, actualizado, bruto)
VALUES ($1,$2,$3,$4,$5,$6,$7,$8::jsonb)
ON CONFLICT (id) DO UPDATE SET
  estado = EXCLUDED.estado, importe = EXCLUDED.importe,
  actualizado = EXCLUDED.actualizado, bruto = EXCLUDED.bruto, sincronizado = now();
```
Query Parameters: `={{ $json.id }}`, `={{ $json.cliente_email }}`, `={{ $json.importe }}`, `={{ $json.moneda }}`, `={{ $json.estado }}`, `={{ $json.creado }}`, `={{ $json.actualizado }}`, `={{ $json.bruto }}`.

## El código para actualizar el cursor (nodo Code entre el IF y el Wait)
```javascript
const resp = $('Pedir página').first().json;
const ultimos = resp.data || [];
const cursor = ultimos.length ? ultimos[ultimos.length - 1].id : '';
const est = $('Estado inicial').first().json;
return [{ json: { cursor, desde: est.desde, total: (est.total || 0) + ultimos.length } }];
```

## Cómo probarla
- Pon `ultimo_ok` a hace 3 días y ejecuta: debe traerse varias páginas. Mira en la pestaña de ejecución cuántas vueltas ha dado el bucle.
- Ejecútalo dos veces seguidas sin tocar nada: la segunda vez el número de filas de la tabla NO debe subir (eso demuestra que el UPSERT funciona).
- Corta la ejecución a mitad a propósito: `ultimo_ok` debe quedarse como estaba y la siguiente ejecución debe recuperar lo que faltaba.

## Qué puede salir mal
- **Solapes de 10 minutos**: fíjate en que al cerrar guardamos `now() - 10 minutes`. Es a propósito: si un registro se creó justo mientras sincronizabas, se recogerá la próxima vez. Duplicar da igual porque hay UPSERT; perder no.
- **Límite de peticiones**: Stripe permite 100 por segundo, pero otras APIs van a 60 por minuto. Ajusta el Wait. Si te devuelven 429, el Retry On Fail lo salva, pero respeta la cabecera `Retry-After` si la mandan.
- **Bucles infinitos**: si `has_more` viene siempre true por un fallo tuyo con el cursor, te comes la cuota entera. Añade un contador de vueltas en el Code y corta a las 200.
- **Zonas horarias**: Stripe da timestamps Unix en UTC. Guarda siempre en TIMESTAMPTZ y convierte solo al mostrar.
- **Campos que cambian de forma**: guarda el JSON completo en la columna `bruto`. El día que necesites un campo que no mapeaste, lo tienes.

## Cuánto cuesta
- Gratis: n8n auto-alojado y una base Postgres pequeña. Las APIs de lectura de Stripe no se cobran.
- En n8n Cloud, una sincronización nocturna con 20 páginas son unas 600 ejecuciones al mes: puede caber en el plan de entrada.
