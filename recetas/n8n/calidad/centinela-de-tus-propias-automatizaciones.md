# Centinela de tus propias automatizaciones…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Un flujo que vigila a los demás: cuando cualquiera de tus automatizaciones falla, te avisa al momento con el nombre, el nodo y el error, y lo apunta en una hoja.

## Qué es y qué hace

Crea un flujo que se activa cuando otro flujo de n8n falla, mediante el nodo Error Trigger. Formatea el nombre del flujo, el nodo y el error, avisa por Telegram o correo y lo apunta en una hoja con el histórico de fallos. Entrada: ejecuciones con error; salida: aviso y registro. Se monta en n8n y sirve para cualquiera que tenga varios flujos activos.

## Cómo usarla

1. Crea el flujo vigilante con el nodo Error Trigger
2. Asígnalo como flujo de errores del resto
3. Conecta Telegram y la hoja de errores
4. Prueba forzando un fallo

## Cuándo usarla

Cuando ya tienes tres o cuatro automatizaciones funcionando y te aterra que una lleve semanas rota sin que te enteres.

## Cómo ganar dinero con ella

Una automatización rota en silencio es peor que no tenerla: crees que el trabajo está hecho. Esto convierte fallos invisibles en avisos de 10 segundos.

- Configuración de vigilancia de errores para un negocio que depende de cinco o más automatizaciones.
- Panel de fallos de automatización para una agencia que gestiona flujos de clientes.
- Mantenimiento mensual de flujos con informe de incidencias para un autónomo.

**Precio orientativo:** 80–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Aprovecha una pieza que casi nadie usa: el **Error Trigger** de n8n. Creas un único flujo «vigilante» y lo asignas como flujo de errores en todos los demás.
Cada vez que uno falle, este se dispara solo, te manda el aviso y guarda el histórico para que veas cuál falla más.

## Lo que necesitas antes
- n8n con al menos dos automatizaciones ya montadas.
- Bot de Telegram (@BotFather) o correo.
- Hoja de Google «Errores automatizaciones» con columnas: `fecha`, `flujo`, `nodo`, `error`, `enlace`.
- Para el resumen semanal: una clave de la API de n8n (*Settings > n8n API > Create an API key*). Solo disponible en n8n auto-alojado o en planes de pago.

## Los nodos, en orden (flujo A: el vigilante)
1. **Error Trigger** — no se configura nada, ese es todo el truco. Se dispara cuando otro flujo falla.
2. **Code** («Formatear error») — deja el mensaje legible.
3. **Telegram** — *Send Message*, Text `{{ $json.mensaje }}`.
4. **Google Sheets** — *Append Row* en «Errores automatizaciones».
5. Guarda el flujo con el nombre «⚠️ Vigilante de errores» y **actívalo**.
6. Ahora ve a cada uno de tus otros flujos: menú de tres puntos arriba a la derecha > *Settings* > *Error Workflow* > elige «⚠️ Vigilante de errores». Hazlo en todos, uno por uno.

## El código del nodo «Formatear error»
```javascript
const e = $json.execution || {};
const w = $json.workflow || {};
const err = e.error || {};
const mensaje = [
  '🔴 Automatización con error',
  'Flujo: ' + (w.name || 'desconocido'),
  'Nodo: ' + (e.lastNodeExecuted || err.node?.name || 'desconocido'),
  'Error: ' + (err.message || 'sin mensaje'),
  'Hora: ' + new Date().toLocaleString('es-ES', { timeZone: 'Europe/Madrid' }),
  e.url ? 'Ver: ' + e.url : ''
].filter(Boolean).join('\n');
return [{ json: {
  mensaje,
  fecha: new Date().toISOString(),
  flujo: w.name || '',
  nodo: e.lastNodeExecuted || '',
  error: err.message || '',
  enlace: e.url || ''
} }];
```

## Los nodos (flujo B: resumen semanal, opcional pero recomendable)
1. **Schedule Trigger** — Cron `0 9 * * 1`.
2. **HTTP Request** — GET `https://TU-N8N/api/v1/executions?status=error&limit=100`, *Header Auth* con `X-N8N-API-KEY: tu_clave`.
3. **Code** — cuenta errores por flujo y ordena de mayor a menor.
4. **Gmail** — te manda el ranking: «esta semana el flujo X ha fallado 12 veces».

## Cómo probarla
- Crea un flujo tonto de prueba: **Manual Trigger** + **HTTP Request** a `https://esto-no-existe-xyz.com` con *Never Error* **desactivado**.
- Asígnale el vigilante como Error Workflow y ejecútalo: debe fallar y llegarte el aviso en segundos.
- Importante: el Error Trigger solo salta si el flujo que falla está **activo y en producción**, o si lo ejecutas manualmente con el flujo guardado. Prueba también con una ejecución real programada.

## Qué puede salir mal
- **No llega nada**: casi siempre es porque no asignaste el Error Workflow en los ajustes del flujo que falla, o porque el vigilante no está activo.
- **Avalancha de avisos**: si un flujo se ejecuta cada 5 minutos y falla siempre, te llegan 288 mensajes al día. Añade tras el Code un **IF** con contador en `$getWorkflowStaticData('global')` que solo avise una vez por hora y por flujo.
- **Errores que no son errores**: si usas *Never Error* en los HTTP Request, esos fallos no disparan el Error Trigger. Es lo que quieres en un monitor de uptime, pero recuérdalo.
- **Un flujo que se queda parado sin fallar** (por ejemplo, un Wait que nunca resuelve) no genera error. Para eso, añade al final de cada flujo importante un nodo que escriba «última ejecución OK» con la fecha en una hoja, y otro flujo diario que compruebe que esas fechas son recientes.

## Cuánto cuesta
- Gratis en n8n auto-alojado, incluida la API.
- En n8n Cloud el Error Trigger está en todos los planes; la API de ejecuciones requiere plan de pago.
- Equivalente en Make: los escenarios tienen «manejo de errores» y avisos por email en el plan gratuito, pero menos detallado.
