# Portero de validación antes de tocar la base de datos…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Comprueba que cada dato que entra por webhook cumple tus reglas (campos, tipos, formatos) y aparta los inválidos con el motivo, en vez de meter basura en tu base.

## Qué es y qué hace

Recibe datos por webhook y los valida contra tus reglas: campos obligatorios, formatos de email y teléfono, importes numéricos. Los datos válidos se guardan en PostgreSQL; los inválidos van a una hoja de rechazados con la lista de errores y se responde 422. Entrada: JSON de formulario o proveedor; salida: registro limpio o motivo del rechazo. Se monta en n8n.

## Cómo usarla

1. Crea la tabla clientes con sus restricciones
2. Define las reglas en el nodo Code
3. Conecta la hoja rechazados
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando integras formularios, proveedores o apps de terceros y acabas con teléfonos raros, emails vacíos o importes en texto dentro de tu base de datos.

## Cómo ganar dinero con ella

Limpiar datos sucios a posteriori cuesta horas y provoca errores en facturas y envíos. Esto lo evita en el origen: 3-5 h/mes recuperadas.

- Limpieza de formularios para tiendas y academias que reciben leads de varias webs.
- Validación de altas para agencias que integran datos de clientes de terceros.
- Filtro de calidad de datos para pymes con importaciones desde proveedores.

**Precio orientativo:** 120–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Pone un validador entre el mundo exterior y tu base de datos: define las reglas en un sitio (una tabla dentro del nodo Code), y todo lo que no las cumpla se guarda aparte con la lista exacta de errores y se responde 422 a quien lo mandó. Para quien recibe datos de fuera y quiere que su base se mantenga limpia.
**Lo que necesitas antes**
- n8n.
- Una base PostgreSQL (Supabase tiene plan gratuito con base Postgres real; Neon también) y sus datos de conexión: host, puerto 5432, base, usuario, contraseña. Credencial `Postgres` en n8n.
- Una tabla destino, por ejemplo `CREATE TABLE clientes (id serial primary key, email text unique not null, nombre text, telefono text, importe numeric, creado timestamptz default now());`.
- Una hoja `rechazados` en Sheets con columnas `fecha`, `errores`, `payload`.
**Los nodos, en orden**
1. `Webhook` — POST, Path `alta-cliente`, Respond `Using Respond to Webhook node`.
2. `Code` (*Validar*) — Mode `Run Once for Each Item`. Aquí van tus reglas, en un solo sitio:
```js
const reglas = {
  email:    { obligatorio: true,  tipo: 'string', patron: /^[^@\s]+@[^@\s]+\.[a-z]{2,}$/i },
  nombre:   { obligatorio: true,  tipo: 'string', min: 2, max: 80 },
  telefono: { obligatorio: false, tipo: 'string', patron: /^(\+34)?[6789]\d{8}$/ },
  importe:  { obligatorio: true,  tipo: 'numero', min: 0, max: 100000 }
};
const d = $json.body || {};
const errores = [];
const limpio = {};
for (const [campo, r] of Object.entries(reglas)) {
  let v = d[campo];
  if (typeof v === 'string') v = v.trim();
  if (v === undefined || v === null || v === '') { if (r.obligatorio) errores.push(campo + ': obligatorio'); continue; }
  if (r.tipo === 'numero') { const n = Number(String(v).replace(',', '.')); if (Number.isNaN(n)) { errores.push(campo + ': no es un número'); continue; } if (r.min !== undefined && n < r.min) errores.push(campo + ': menor que ' + r.min); if (r.max !== undefined && n > r.max) errores.push(campo + ': mayor que ' + r.max); limpio[campo] = n; continue; }
  v = String(v);
  if (r.min && v.length < r.min) errores.push(campo + ': demasiado corto');
  if (r.max && v.length > r.max) errores.push(campo + ': demasiado largo');
  if (r.patron && !r.patron.test(v)) errores.push(campo + ': formato incorrecto');
  limpio[campo] = campo === 'email' ? v.toLowerCase() : v;
}
const sobran = Object.keys(d).filter(k => !(k in reglas));
return { json: { valido: errores.length === 0, errores, limpio, sobran, original: d } };
```
3. `IF` — `={{ $json.valido }}` `is true`.
4. Rama **true** > `Postgres` — Operation `Execute Query`, Query:
```sql
INSERT INTO clientes (email, nombre, telefono, importe) VALUES ($1, $2, $3, $4) ON CONFLICT (email) DO UPDATE SET nombre = EXCLUDED.nombre, telefono = EXCLUDED.telefono RETURNING id;
```
   En Options > Query Parameters pon `={{ $json.limpio.email }}, {{ $json.limpio.nombre }}, {{ $json.limpio.telefono || null }}, {{ $json.limpio.importe }}`. Usa siempre parámetros, nunca pegues valores en el SQL: así te proteges de inyección.
5. Detrás > `Respond to Webhook` — Response Code 201, Response Body `={{ JSON.stringify({ ok: true, id: $json.id }) }}`, Response Headers `Content-Type: application/json`.
6. Rama **false** > `Google Sheets` — `Append` en `rechazados`: `fecha` = `={{ $now.toISO() }}`, `errores` = `={{ $json.errores.join(' | ') }}`, `payload` = `={{ JSON.stringify($json.original) }}`.
7. Detrás > `Respond to Webhook` — Response Code 422, Body `={{ JSON.stringify({ ok: false, errores: $json.errores }) }}`.
**Cómo probarla**
- Válido: `curl -X POST -H "Content-Type: application/json" -d '{"email":"Ana@Ejemplo.com ","nombre":"Ana","telefono":"612345678","importe":"49,90"}' TU_URL` — debe devolver 201 y guardar el email en minúsculas y el importe como 49.9.
- Inválido: manda `{"nombre":"A","importe":"mucho"}` — debe devolver 422 con tres errores y aparecer en la hoja `rechazados`.
- Repetido: manda el válido dos veces — debe actualizar, no duplicar (gracias al `ON CONFLICT`).
**Qué puede salir mal**
- *Los campos que sobran*: el código los detecta en `sobran` pero no los guarda. Es lo correcto; si el proveedor añade un campo nuevo que sí quieres, te enteras revisando ese array (puedes avisarte por correo si `sobran.length > 0`).
- *Teléfonos internacionales*: el patrón de ejemplo es solo español. Si vendes fuera, cambia a `/^\+\d{7,15}$/` y normaliza quitando espacios y guiones antes de validar.
- *Números con coma*: ya se contempla (`replace(',', '.')`), típico de formularios españoles.
- *La base de datos está caída*: activa `Retry On Fail` (3 intentos, 5 s) en el nodo Postgres y, si aun así falla, responde 503 en vez de 500 para que el emisor reintente.
- *Zona horaria*: `now()` en Postgres con columna `timestamptz` guarda UTC; muéstralo luego en hora española, no lo cambies al guardar.
**Cuánto cuesta**
Gratis: n8n auto-alojado, Supabase o Neon en plan gratuito (500 MB, suficiente para decenas de miles de clientes) y Sheets. Solo pagas si superas el plan gratuito de la base (Supabase Pro desde 25 $/mes).
