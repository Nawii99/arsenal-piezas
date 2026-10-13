# Radar de endpoints lentos con alerta por umbral…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Mide cada hora la latencia real de tu API por ruta desde los datos de Cloudflare, la guarda en una hoja y te avisa solo si una ruta se degrada.

## Qué es y qué hace

Cada hora consulta la analítica de Cloudflare, calcula la latencia media y los errores 5xx de cada ruta de tu API y guarda los datos en una hoja. Avisa por Slack o correo solo cuando una ruta se degrada respecto a su media. Entran el token de lectura de Cloudflare y el Zone ID; sale una tabla de latencias por ruta y alertas. Para webs y APIs ya detrás de Cloudflare.

## Cómo usarla

1. Crea un token de Cloudflare con la plantilla de lectura de analítica
2. Localiza el Zone ID del dominio
3. Crea la hoja latencias
4. Define el umbral de aviso y prueba con una ruta lenta

## Cuándo usarla

Úsalo cuando tu web o API ya está en producción y te enteras de que va lenta porque te lo dice un cliente, no tus herramientas.

## Cómo ganar dinero con ella

Detectas la degradación en la hora en que ocurre, no a la semana. Evitas pagar más servidor cuando el problema es una sola consulta.

- Monitorización de rendimiento por ruta para APIs de clientes con alerta temprana…
- Informe mensual de latencia para tiendas online con recomendaciones de optimización…
- Configuración de alertas de rendimiento para agencias con webs en Cloudflare…

**Precio orientativo:** 60–200 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada hora consulta la analítica de Cloudflare y saca la latencia media y el número de errores 5xx de cada ruta de tu API.
Es para el que ya tiene la web o el backend detrás de Cloudflare y quiere enterarse de una caída de rendimiento antes que sus clientes.

## Lo que necesitas antes
- Tu dominio con el DNS en Cloudflare (el plan gratuito sirve; la analítica por ruta viene de los `httpRequestsAdaptiveGroups`).
- Un token de API de Cloudflare: panel de Cloudflare > Mi perfil > Tokens de API > Crear token > plantilla «Read analytics and logs». Copia el token, solo se enseña una vez.
- El Zone ID, en la pantalla de Resumen de tu dominio, columna derecha.
- Una hoja de Google Sheets llamada `latencias` con columnas: fecha, ruta, peticiones, ms_medios, errores_5xx.
- Un canal de Slack (o Gmail, si prefieres correo).

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Hours, Hours Between Triggers: 1.
2. **HTTP Request** — Method POST, URL `https://api.cloudflare.com/client/v4/graphql`. En Headers: `Authorization` = `Bearer TU_TOKEN` y `Content-Type` = `application/json`. En Body (JSON) manda la consulta GraphQL con tu zoneTag y el rango de la última hora.
3. **Code** — aplana la respuesta de GraphQL y calcula los milisegundos por ruta.
4. **Google Sheets** — Operation: Append, hoja `latencias`, mapeo automático de columnas.
5. **IF** — condición numérica: `ms_medios` mayor que 800 O `errores_5xx` mayor que 5.
6. **Slack** — Operation: Send Message, con el texto `Ruta {{$json.ruta}}: {{$json.ms_medios}} ms y {{$json.errores_5xx}} errores en la última hora`.

## El código del nodo Code
```js
const zonas = $input.first().json.data.viewer.zones[0];
const filas = zonas.httpRequestsAdaptiveGroups.map(g => ({
  fecha: new Date().toISOString(),
  ruta: g.dimensions.clientRequestPath || '/',
  peticiones: g.count,
  ms_medios: Math.round((g.avg.originResponseDurationMs || 0)),
  errores_5xx: g.sum.responseStatusMap ? 0 : 0
}));
return filas.filter(f => f.peticiones > 20).map(json => ({ json }));
```

## Cómo probarla
- Ejecuta el flujo a mano con «Test workflow» y mira la salida del HTTP Request: si ves `errors` en el JSON, el token o el Zone ID están mal.
- Baja el umbral del IF a 1 ms para forzar la alerta y comprobar que Slack recibe el mensaje. Luego súbelo a 800.

## Qué puede salir mal
- **La analítica gratuita solo guarda unas horas.** Si el flujo está parado un día, pierdes esos datos: no es un histórico, es un vigilante.
- **Zonas horarias.** Cloudflare devuelve UTC. Si vives en España, resta o suma la hora al escribir en la hoja o te descuadrarán los informes.
- **Alertas en cascada.** Añade después del IF un nodo Code que guarde en `$getWorkflowStaticData('global')` la última hora en que avisaste de esa ruta y no repitas antes de 3 horas.
- **Límite de API.** Cloudflare GraphQL permite 300 consultas por cada 5 minutos: una por hora no te acerca ni de lejos.

## Cuánto cuesta
- Cloudflare: gratis en el plan Free.
- n8n auto-alojado: gratis. En n8n Cloud son 24 ejecuciones al día, dentro del plan de arranque.
- Google Sheets y Slack: gratis.
