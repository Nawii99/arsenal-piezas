# Panel de tus datos de actividad y resumen semanal…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Recoge cada noche tus pasos, sueño y entrenamientos de Google Fit, Fitbit o Strava, los guarda en una hoja y te manda un resumen semanal comparado con la semana anterior.

## Qué es y qué hace

Cada noche descarga de la API de Strava las actividades del día y las guarda en una hoja con fecha, tipo, duración, distancia y frecuencia cardiaca media; los lunes envía un correo comparando la semana con la anterior. Entrada: API de Strava con token; salida: hoja histórica y resumen. Se monta en n8n.

## Cómo usarla

1. Crea la app de Strava y autoriza tu cuenta una vez
2. Guarda las credenciales OAuth2 en n8n
3. Prepara la hoja y el cron nocturno
4. Que lo revise un profesional

## Cuándo usarla

Cuando llevas pulsera o reloj y quieres ver la evolución de meses en un sitio propio, sin depender de la app del fabricante ni de su suscripción.

## Cómo ganar dinero con ella

Sustituye suscripciones tipo Fitbit Premium o Strava de pago (unos 8-12 €/mes, 100-140 € al año) y te deja los datos en tu hoja para siempre.

- Panel de actividad propio para un entrenador que quiere seguir a sus clientes con su permiso.
- Resumen semanal de pasos y entrenos para un emprendedor que no quiere pagar una app.
- Histórico de actividad en hoja para un club deportivo con seguimiento mensual.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada noche llama a la API de Strava (o Fitbit, o Google Fit), baja las actividades del día, las apunta en una hoja con fecha, tipo, duración, distancia y frecuencia cardíaca media, y los lunes te manda un email comparando esta semana con la anterior.
Para ti como emprendedor que entrena, y también para entrenadores que quieren ver de un vistazo la actividad de sus clientes (con su permiso y su token).

## Lo que necesitas antes
- Cuenta de Strava. Entra en strava.com/settings/api, crea una aplicación y anota Client ID y Client Secret.
- Autoriza tu propia cuenta una vez: abre en el navegador `https://www.strava.com/oauth/authorize?client_id=TU_ID&redirect_uri=http://localhost&response_type=code&scope=activity:read_all`, acepta, y copia el `code` que aparece en la URL.
- Cambia ese code por tokens con un curl: `curl -X POST https://www.strava.com/oauth/token -d client_id=TU_ID -d client_secret=TU_SECRET -d code=EL_CODE -d grant_type=authorization_code`. Guarda `refresh_token`.
- Google Sheet `Actividad` con: fecha, tipo, nombre, minutos, km, fc_media, calorias, id_actividad. Y una pestaña `Config` con una fila: refresh_token, access_token, expira.
- n8n.

## Los nodos, en orden
1. **Schedule Trigger** – Cron `0 23 * * *`, Timezone Europe/Madrid.
2. **Google Sheets** – Read Rows de `Config` para leer el refresh_token.
3. **HTTP Request** – POST a `https://www.strava.com/oauth/token`. Body: Form-Urlencoded con `client_id`, `client_secret`, `grant_type=refresh_token`, `refresh_token={{ $json.refresh_token }}`. Devuelve un access_token nuevo que dura 6 horas.
4. **Google Sheets** – Update en `Config` con el nuevo refresh_token (Strava lo rota, si no lo guardas mañana no entras).
5. **HTTP Request** – GET a `https://www.strava.com/api/v3/athlete/activities`. Query Parameters: `after` = `={{ Math.floor($now.startOf('day').toSeconds()) }}`, `per_page` = `50`. Headers: `Authorization` = `Bearer {{ $('HTTP Request').item.json.access_token }}`.
6. **Code** – aplana la respuesta a filas limpias. Código abajo.
7. **Google Sheets** – Append or Update en `Actividad`, Matching Column `id_actividad`. Así aunque ejecutes dos veces no duplicas.
8. **Schedule Trigger** (workflow dos, «Resumen semanal») – Cron `0 8 * * 1`, Timezone Europe/Madrid.
9. **Google Sheets** – Read Rows de `Actividad`, Return All.
10. **Code** – compara los últimos 7 días con los 7 anteriores en minutos, kilómetros y número de sesiones.
11. **Gmail** – Send con el resumen y una línea de contexto: «Has entrenado X minutos, un Y% más que la semana pasada».

## El código del nodo Code (paso 6)
```
const salida = [];
for (const item of $input.all()) {
  const a = item.json;
  if (!a.id) continue;
  salida.push({ json: {
    id_actividad: String(a.id),
    fecha: a.start_date_local ? a.start_date_local.slice(0, 10) : '',
    tipo: a.sport_type || a.type,
    nombre: a.name,
    minutos: Math.round((a.moving_time || 0) / 60),
    km: Math.round(((a.distance || 0) / 1000) * 100) / 100,
    fc_media: a.average_heartrate || '',
    calorias: a.calories || ''
  } });
}
return salida;
```

## El código del resumen (paso 10)
```
const filas = $input.all().map(i => i.json);
function rango(desde, hasta) { return filas.filter(f => f.fecha >= desde && f.fecha < hasta); }
const hoy = new Date();
const d = n => new Date(hoy.getTime() - n * 86400000).toLocaleDateString('sv-SE');
const est = r => ({ sesiones: r.length, min: r.reduce((s, x) => s + Number(x.minutos || 0), 0), km: Math.round(r.reduce((s, x) => s + Number(x.km || 0), 0) * 10) / 10 });
const a = est(rango(d(7), d(0))), b = est(rango(d(14), d(7)));
const pct = b.min ? Math.round(((a.min - b.min) / b.min) * 100) : 0;
const texto = `Semana: ${a.sesiones} sesiones, ${a.min} min, ${a.km} km.\nSemana anterior: ${b.sesiones} sesiones, ${b.min} min, ${b.km} km.\nVariación de minutos: ${pct}%.`;
return [{ json: { texto } }];
```

## Cómo probarla
- Ejecuta el paso 3 solo y comprueba que devuelve `access_token`. Si da 400, el refresh_token está mal copiado o le sobra un espacio.
- Sube una actividad manual en Strava con fecha de hoy y lanza el flujo: debe aparecer en la hoja.
- Ejecútalo dos veces seguidas: la fila no se duplica gracias al Append or Update.
- Para el resumen, mete filas a mano de hace 10 días y comprueba que el porcentaje cuadra.

## Qué puede salir mal
- **Se deja de autenticar a los pocos días**: es el refresh_token rotativo de Strava. El paso 4 es obligatorio, no lo saltes.
- **Límite de la API de Strava**: 100 peticiones cada 15 minutos y 1.000 al día. Con una ejecución nocturna vas sobrado; no pongas el cron cada 5 minutos.
- **Fitbit en vez de Strava**: mismo esquema pero la URL de token es `https://api.fitbit.com/oauth2/token` con Basic Auth de client_id:secret en base64, y los datos se piden a `https://api.fitbit.com/1/user/-/activities/date/YYYY-MM-DD.json`.
- **Google Fit**: la API REST antigua está en retirada; si usas Android, exporta a Health Connect y sube el CSV a Drive, y lee ese fichero con un nodo Google Drive en vez de la API.
- **Datos de salud son datos sensibles**: si guardas los de tus clientes, guárdalos en un Drive tuyo, con permisos cerrados, y ten firmado su consentimiento. Y nunca los uses para valorar nada clínico.

## Cuánto cuesta
- Strava API: gratis para uso personal. Fitbit API: gratis.
- Sheets, Gmail, n8n auto-alojado: 0 €.
- Coste real: cero. Lo que ahorras son las suscripciones premium de las apps.
