# Inventario de claves y secretos con aviso de caducidad…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Lleva la cuenta de todas tus claves de API, certificados y tokens, comprueba que siguen vivos y te avisa un mes antes de que caduquen.

## Qué es y qué hace

Lleva un registro de claves de API, certificados y tokens guardando solo los últimos cuatro caracteres. Una vez por semana calcula los días que quedan para cada caducidad y hace una llamada de prueba para confirmar que la clave sigue funcionando. Avisa por email y crea un evento en el calendario si caduca en menos de 30 días. Entrada: hoja de inventario; salida: avisos. Requiere n8n auto-alojado.

## Cómo usarla

1. Crea la hoja inventario_claves
2. Guarda los valores secretos solo en las credenciales de n8n
3. Configura un endpoint de prueba por servicio
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tienes claves repartidas por Stripe, Google, el hosting y tres integraciones más, y nadie sabe cuáles siguen activas ni cuándo caducan.

## Cómo ganar dinero con ella

Una clave caducada un domingo por la noche te deja sin cobrar. Este flujo te ahorra ese apagón y las 3-4 h de investigación de cada susto.

- Auditoría de accesos para pymes con claves repartidas entre varios proveedores.
- Control de caducidades para agencias que gestionan cuentas de clientes.
- Plan de renovación de credenciales para startups tras un susto de seguridad.

**Precio orientativo:** 80–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Mantiene una hoja con todas tus credenciales (sin guardar el valor secreto, solo los últimos 4 caracteres) y, una vez por semana, hace dos cosas: calcula cuántos días faltan para su caducidad y comprueba con una llamada real que la clave sigue funcionando. Si algo caduca en menos de 30 días o ha dejado de responder, recibes un correo y se crea un aviso en tu calendario.
**Lo que necesitas antes**
- n8n auto-alojado (recomendado: aquí se manejan credenciales) o n8n Cloud.
- Hoja `inventario_claves` con columnas: `nombre`, `servicio`, `ultimos4`, `fecha_caducidad`, `url_comprobacion`, `credencial_n8n`, `responsable`, `estado`, `dias_restantes`.
- Credenciales de Google Sheets, Gmail y Google Calendar en n8n (OAuth2 desde Google Cloud Console).
- Para cada servicio, un endpoint barato de comprobación: Stripe `https://api.stripe.com/v1/balance`, Google `https://www.googleapis.com/oauth2/v3/tokeninfo`, tu propia API `/health`. Anótalos en la columna `url_comprobacion`.
- Regla de oro: **el valor de la clave nunca va en la hoja**. Vive en las credenciales de n8n; la hoja solo la nombra.
**Los nodos, en orden**
1. `Schedule Trigger` — Trigger Interval `Weeks`, Trigger on Weekdays `Monday`, Trigger at Hour `8`.
2. `Google Sheets` — Operation `Get Row(s)`, hoja `inventario_claves`.
3. `Code` (*Días restantes*) — Mode `Run Once for Each Item`:
```js
const f = $json.fecha_caducidad;
let dias = null;
if (f) { const fin = new Date(f + 'T00:00:00Z').getTime(); dias = Math.floor((fin - Date.now()) / 86400000); }
return { json: { ...$json, dias_restantes: dias === null ? 9999 : dias } };
```
4. `HTTP Request` (*Ping de vida*) — Method GET, URL `={{ $json.url_comprobacion }}`, Authentication con la credencial que corresponda (si son varios servicios, lo más simple es duplicar este flujo por servicio o usar Header Auth con una expresión). Settings: `Continue On Fail` ON, `Never Error` desactivado, Timeout 10000.
5. `Code` (*Juntar veredicto*) — Mode `Run Once for Each Item`:
```js
const base = $('Días restantes').item.json;
const viva = $json.error === undefined;
let estado = 'ok';
if (!viva) estado = 'no responde';
else if (base.dias_restantes <= 0) estado = 'caducada';
else if (base.dias_restantes <= 30) estado = 'caduca pronto';
return { json: { ...base, estado, alerta: estado !== 'ok' } };
```
6. `Google Sheets` — Operation `Update`, match on `nombre`, escribe `estado` y `dias_restantes`.
7. `IF` — `={{ $json.alerta }}` `is true`.
8. Rama true > `Google Calendar` — Operation `Create`, Calendar el tuyo, Start `={{ $now.plus({ days: 3 }).toISO() }}`, End `={{ $now.plus({ days: 3, hours: 1 }).toISO() }}`, Summary `Renovar clave: {{ $json.nombre }} ({{ $json.estado }})`.
9. Detrás > `Gmail` — Operation `Send`, To tu correo, Subject `Claves que necesitan atención ({{ $json.nombre }})`, Message con `Servicio: {{ $json.servicio }} · Últimos 4: {{ $json.ultimos4 }} · Estado: {{ $json.estado }} · Días: {{ $json.dias_restantes }} · Responsable: {{ $json.responsable }}`.
**Cómo probarla**
- Mete una fila de prueba con `fecha_caducidad` dentro de 10 días y una `url_comprobacion` que funcione: debe salir `caduca pronto`, correo y evento en el calendario.
- Mete otra con una URL rota (`https://httpstat.us/401`): debe salir `no responde`.
- Comprueba que las filas sanas no generan ruido: si te llegan avisos todas las semanas, la gente deja de leerlos.
**Qué puede salir mal**
- *Muchos correos seguidos*: agrupa. Cambia el paso 7-9 por un `Code` en modo `Run Once for All Items` que junte todas las alertas en un solo correo con una lista.
- *Claves sin fecha de caducidad* (muchas no caducan): déjalas en blanco, el código les pone 9999 y solo se comprueba si siguen vivas.
- *El ping consume cuota*: usa endpoints de solo lectura y baratos; nunca uses un endpoint que cree o borre algo.
- *Riesgo de fuga*: no pongas nunca la clave completa en la hoja ni en el asunto del correo. Si compartes la hoja, restringe el acceso a tu cuenta.
- *Fechas*: escribe `fecha_caducidad` siempre como `AAAA-MM-DD` y formatea la columna de Sheets como texto para que no la convierta a otro formato.
**Cuánto cuesta**
Cero euros: una ejecución semanal en n8n auto-alojado, con Sheets, Gmail y Calendar de una cuenta normal. En n8n Cloud entra en cualquier plan. En Zapier gastarías 4-5 tareas por semana, cabe en el gratuito si no vigilas muchas claves.
