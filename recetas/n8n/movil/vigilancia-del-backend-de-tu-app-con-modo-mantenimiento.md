# Vigilancia del backend de tu app con modo mantenimiento…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Comprueba cada cinco minutos que la API de tu app responde y, si se cae, avisa y enciende un mensaje dentro de la app sin publicar versión nueva.

## Qué es y qué hace

Receta de n8n que llama cada cinco minutos al endpoint de salud de tu API y mide si responde y cuánto tarda. Si falla dos veces seguidas, avisa por Telegram y correo, y cambia un fichero de configuración remota (un Gist o un bucket) que tu app lee al arrancar para mostrar un mensaje de mantenimiento en lugar de una pantalla en blanco. Entrada: URL de salud y URL de configuración. Salida: alerta y estado de mantenimiento.

## Cómo usarla

1. Crea el endpoint de salud y el fichero de configuración
2. Conecta Telegram y correo
3. Simula una caída y comprueba el mensaje en la app

## Cuándo usarla

Cuando tu app depende de un servidor propio y te enteras de las caídas por las reseñas de una estrella en vez de por un aviso.

## Cómo ganar dinero con ella

Cada hora caído son reseñas malas y bajas. Sustituye herramientas de monitorización de 15-30 €/mes y evita reinstalar la app para dar explicaciones.

- Aviso de caídas para una app de reservas con servidor propio…
- Mensaje de mantenimiento para una tienda con app que depende de su API…
- Servicio de vigilancia para pequeños proveedores de apps con servidor…

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada cinco minutos llama a un punto de salud de tu API y mide si responde y cuánto tarda. Si falla dos veces seguidas te avisa por Telegram y llamada perdida por correo, y además cambia un fichero de configuración remota que tu app lee al arrancar para mostrar «estamos en mantenimiento» en vez de una pantalla en blanco. Para quien tiene app con servidor propio y sin equipo de guardia.

## Lo que necesitas antes
- Un endpoint de salud en tu API, por ejemplo `https://api.tuempresa.com/health`, que devuelva 200 y un JSON `{"ok":true,"version":"1.4.2"}`. Si no lo tienes, vale cualquier ruta ligera que no toque base de datos pesada.
- Un sitio donde publicar la configuración remota que tu app consulte al arrancar: lo más barato es un **Gist público de GitHub** (raw URL) o un fichero en un bucket. Tu app debe leer esa URL al abrir y, si `mantenimiento` es true, enseñar el mensaje.
- Token de GitHub con permiso `gist` (github.com → Settings → Developer settings → Personal access tokens).
- Bot de Telegram y credencial de Gmail.
- Hoja de Google Sheets `uptime` con: fecha, estado, ms, codigo, mensaje.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Minutes, Minutes Between Triggers: 5.
2. **HTTP Request** (nombre: Ping salud) — GET tu URL de salud. Options → Timeout: 8000 ms, Response → Never Error: activado, Include Response Headers and Status: activado.
3. **Code** (nombre: Evaluar) — decide si está sano según el código y el tiempo. Código abajo.
4. **Google Sheets** — Append Row en `uptime` con el resultado. Siempre, esté bien o mal: así tienes histórico y puedes calcular tu disponibilidad del mes.
5. **Google Sheets** — Get Row(s) de las 3 últimas filas para ver si el fallo se repite.
6. **IF** (nombre: ¿Caída confirmada?) — Conditions (AND): estado actual `caido` Y el estado anterior también `caido`. Con dos fallos seguidos evitas avisar por un hipo de red.
7. **Telegram** — Send Message: `🔴 API caída. Código {{$json.codigo}}, {{$json.ms}} ms. Desde {{$json.desde}}.`
8. **Gmail** — Send a tu correo y al del proveedor de hosting si procede.
9. **HTTP Request** (nombre: Activar mantenimiento) — Method: PATCH, URL: `https://api.github.com/gists/TU_GIST_ID`, Authentication: Generic > Header Auth con una credencial de n8n (Name `Authorization`, Value `Bearer TU_TOKEN`), Headers: `Accept` = `application/vnd.github+json`. No pegues el token en el nodo: si exportas o compartes el flujo como JSON, se iría con él. Body JSON: `{ "files": { "config.json": { "content": "{\"mantenimiento\":true,\"mensaje\":\"Estamos arreglando una incidencia, vuelve en unos minutos.\"}" } } }`.
10. Rama de recuperación: otro **IF** que detecte estado `ok` tras una caída → mismo PATCH con `mantenimiento: false` → **Telegram** `✅ API recuperada tras {{$json.minutos}} minutos.`
11. Opcional, **Schedule Trigger** mensual + **Code** que calcule el porcentaje de disponibilidad del mes desde la hoja y te lo mande por correo.

## El trozo de código (nodo Code «Evaluar»)
```javascript
const r = $input.first().json;
const codigo = r.statusCode ?? r.$statusCode ?? 0;
const cuerpo = r.body ?? r;
const inicio = $execution?.customData?.get?.('inicio');
const ms = Number(r.headers?.['x-response-time']?.replace('ms','')) || null;
let estado = 'ok';
let mensaje = '';
if (codigo < 200 || codigo >= 300) { estado = 'caido'; mensaje = 'Código HTTP ' + codigo; }
else if (cuerpo && cuerpo.ok === false) { estado = 'caido'; mensaje = 'La API dice que no está sana'; }
else if (ms && ms > 3000) { estado = 'lento'; mensaje = 'Tarda ' + ms + ' ms'; }
return [{ json: {
  estado,
  codigo,
  ms,
  mensaje,
  version: cuerpo?.version || '',
  fecha: new Date().toISOString()
}}];
```

## Cómo probarla
- Cambia la URL de salud por `https://api.tuempresa.com/no-existe` y ejecuta dos veces: debe avisar y poner el Gist en mantenimiento.
- Abre la app con el Gist en `mantenimiento: true` y comprueba que sale el mensaje. Este es el paso que más gente se salta y luego no funciona.
- Devuelve la URL buena y verifica que llega el aviso de recuperación y el Gist vuelve a false.

## Qué puede salir mal
- **Falsas alarmas por red**: por eso se exigen dos fallos seguidos. Si aun así te llega ruido, sube a tres.
- **Se cae tu n8n**: si el vigilante vive en el mismo servidor que la API, no te avisará de nada. Ponlo en otro sitio (un VPS distinto o n8n Cloud).
- **La app cachea el config**: pon en la petición de tu app un parámetro `?t=timestamp` o cabeceras `Cache-Control: no-cache`, o el mantenimiento no se verá.
- **Límite de la API de GitHub**: 5.000 peticiones por hora con token, vas sobrado; pero solo escribe el Gist cuando cambia el estado, no en cada ping.
- **Ruido nocturno**: si no quieres despertarte, añade un IF con la hora y manda solo correo entre las 00:00 y las 07:00.
- **Zona horaria**: `Europe/Madrid` en Settings del workflow para que las horas del histórico cuadren.

## Cuánto cuesta
GitHub Gist gratis. Telegram, Gmail y Sheets gratis. n8n auto-alojado 0 € más un VPS de 5 €/mes (que conviene que sea distinto del de tu API). Frente a UptimeRobot Pro o similares, ahorras entre 15 y 30 € al mes.
