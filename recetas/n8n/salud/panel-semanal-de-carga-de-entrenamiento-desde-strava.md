# Panel semanal de carga de entrenamiento desde Strava…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Recoge tus entrenamientos de Strava cada noche, los guarda en una hoja y te manda el domingo el total de horas, kilómetros y el reparto por deporte.

## Qué es y qué hace

Descarga cada noche las actividades de Strava mediante OAuth2, las guarda en Google Sheets sin duplicados y envía un resumen semanal con horas, kilómetros y reparto por deporte. Entrada: API de Strava; salida: hoja de entrenos y correo. Se monta en n8n con el nodo Strava y resulta útil para entrenadores de running o ciclismo.

## Cómo usarla

1. Crea la app en strava.com/settings/api
2. Conecta la credencial OAuth2 en n8n
3. Prepara la hoja Entrenos y el cron nocturno
4. Que lo revise un profesional

## Cuándo usarla

Cuando entrenas en serio o llevas a clientes de running, ciclismo o triatlón y quieres tener los números fuera de la app, en una hoja que puedas compartir y comentar.

## Cómo ganar dinero con ella

Te ahorra la suscripción de plataformas de análisis (de 10 a 20 euros al mes) y te permite llevar a 10 clientes con un panel por cliente sin pagar por licencia.

- Panel de carga de entrenamiento para un entrenador que lleva diez clientes de running.
- Informe semanal de volumen para triatletas amateurs en formato de hoja compartible.
- Configuración de seguimiento de actividad para un club deportivo pequeño.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Descarga las actividades de Strava de las últimas 24 horas, las apunta en una hoja sin duplicados y envía un resumen semanal con volumen por deporte y comparación con la semana anterior.
Es seguimiento de actividad, no valoración médica: solo suma lo que ya has registrado.

## Lo que necesitas antes
- n8n instalado.
- Cuenta de Strava. Entra en strava.com/settings/api, crea una aplicación (nombre, dominio localhost vale) y copia Client ID y Client Secret.
- En n8n crea una credencial «Strava OAuth2 API» con esos datos y pulsa conectar. Los scopes que necesitas son activity:read_all.
- Hoja «Entrenos» en Google Sheets: Id, Fecha, Tipo, Nombre, Distancia km, Duracion min, Desnivel, Frecuencia media.
- Gmail conectado en n8n (o Telegram si lo prefieres en el móvil).

## Los nodos, en orden
1. **Schedule Trigger**: Cron 0 23 * * * , zona Europe/Madrid.
2. **Strava** (resource Activity, operation Get Many): «Limit» 30, y en filtros «After» con la expresión {{ Math.floor(Date.now()/1000) - 86400 }}.
3. **Google Sheets** (Get Rows) sobre «Entrenos»: para tener los Id ya guardados.
4. **Code** (nombre: «Quitar duplicados y normalizar»): filtra los ya presentes y convierte metros a kilómetros y segundos a minutos. Código abajo.
5. **IF**: si no hay actividades nuevas, termina.
6. **Google Sheets** (Append Row): añade las filas nuevas.
7. Flujo semanal aparte: **Schedule Trigger** Cron 0 19 * * 0 (domingos a las 19:00).
8. **Google Sheets** (Get Rows) sobre «Entrenos».
9. **Code** (nombre: «Resumen»): agrupa por tipo de deporte las filas de los últimos 7 días y las de los 7 anteriores, y calcula la diferencia porcentual.
10. **Gmail** (Send Message): asunto «Tu semana de entrenamiento» y cuerpo en HTML con una tabla simple.

## El código del nodo Code
```javascript
const existentes = new Set($('Google Sheets').all().map(i => String(i.json.Id)));
const nuevas = [];
for (const item of $input.all()) {
  const a = item.json;
  if (existentes.has(String(a.id))) continue;
  nuevas.push({ json: {
    Id: a.id,
    Fecha: new Date(a.start_date_local).toLocaleDateString('sv-SE'),
    Tipo: a.type,
    Nombre: a.name,
    'Distancia km': Number((a.distance / 1000).toFixed(2)),
    'Duracion min': Math.round(a.moving_time / 60),
    Desnivel: Math.round(a.total_elevation_gain || 0),
    'Frecuencia media': a.average_heartrate ? Math.round(a.average_heartrate) : ''
  }});
}
return nuevas;
```

## Cómo probarla
- Sube o registra una actividad en Strava y ejecuta el flujo a mano. Debe aparecer una fila.
- Ejecútalo dos veces seguidas: la segunda no debe añadir nada. Si duplica, el filtro de Id no está leyendo bien la hoja.
- Para el resumen, ejecuta el flujo semanal aunque solo tengas dos entrenos; comprobarás el formato.

## Qué puede salir mal
- **Límite de la API de Strava**: 100 peticiones cada 15 minutos y 1.000 al día. Con una ejecución diaria vas sobradísimo.
- **Token caducado**: Strava expira el token cada 6 horas, pero la credencial OAuth2 de n8n lo renueva sola. Si falla, reconéctala.
- **Actividades privadas**: sin el scope activity:read_all no las verás.
- **Cambio de hora**: usa start_date_local, no start_date, o los entrenos de las 00:30 caerán en el día anterior.
- **No interpretes**: no escribas en el correo frases del tipo «estás sobreentrenado». Da números y deja la valoración a la persona o a su profesional.

## Cuánto cuesta
- Strava API y Google Sheets: gratis.
- n8n auto-alojado: 0 euros. Unas 37 ejecuciones al mes en cloud.
