# Vigilante de automatizaciones rotas y parte semanal…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Detecta cuando cualquiera de tus automatizaciones falla, te avisa al instante con el motivo y cada viernes te manda el parte de cuáles fallan más.

## Qué es y qué hace

Se monta como un flujo de errores que n8n ejecuta cada vez que otro flujo falla. Registra el fallo en una hoja, te manda un mensaje de Telegram con el nodo exacto y el texto del error, y los viernes envía un resumen de los flujos que fallan más. Entrada: fallos de otros flujos; salida: registro, aviso y parte semanal. Se monta en n8n con Error Trigger, Sheets y Telegram, y en Make o Zapier hay un equivalente.

## Cómo usarla

1. Crear el flujo de error en n8n
2. Crear la hoja Errores automatizaciones
3. Forzar un fallo de prueba
4. Activar el parte del viernes

## Cuándo usarla

Úsalo en cuanto tengas tres o más automatizaciones funcionando: es la automatización que vigila a las demás y evita que dejes de fiarte de ellas.

## Cómo ganar dinero con ella

Una automatización rota en silencio te hace perder pedidos, avisos y horas de rehacer a mano. Con esto te enteras en minutos, no cuando revisas el mes.

- Vigilar automatizaciones de pymes que dependen de pedidos y avisos, cobrando configuración y soporte.
- Ofrecer revisiones mensuales de flujos rotos a agencias con varios clientes.
- Montar un tablero de fallos para un equipo que tiene cinco o más automatizaciones.

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Se monta como un workflow «de errores» que n8n ejecuta automáticamente cada vez que otro workflow falla. Registra el fallo en una hoja, te manda un Telegram con el nodo exacto y el mensaje, y los viernes envía un resumen: cuántos fallos, de qué flujos y cuáles llevan rotos más de un día.
Para cualquiera que ya tenga varias automatizaciones montadas.

## Lo que necesitas antes
- n8n (esta receta es específica de n8n; en Make el equivalente es activar «Enable data loss» + un escenario con Error Handler, y en Zapier el «Autoreplay» y los emails de tarea fallida).
- Bot de Telegram.
- Hoja «Errores automatizaciones» con columnas: fecha, workflow, nodo, mensaje, url_ejecucion.

## Los nodos, en orden
1. **Error Trigger** — no tiene configuración. Es el nodo que hace que n8n meta aquí cualquier fallo.
2. **Code** (nombre: «Formatear error»). Run Once for All Items.
```js
const e = $json.execution || {};
const w = $json.workflow || {};
return [{ json: {
  fecha: new Date().toISOString(),
  workflow: w.name || 'desconocido',
  nodo: e.lastNodeExecuted || '-',
  mensaje: (e.error?.message || 'sin mensaje').slice(0, 300),
  url: e.url || '',
  modo: e.mode || ''
} }];
```
3. **Google Sheets** — Append Row a «Errores automatizaciones».
4. **IF** — String: `={{ $json.mensaje }}` not contains `ECONNRESET` (para no avisarte por cortes de red pasajeros que el reintento ya resuelve). Añade más excepciones con Combine: AND.
5. **Telegram** — Text: `=⚠️ Falló «{{ $json.workflow }}» en el nodo {{ $json.nodo }}\n{{ $json.mensaje }}\n{{ $json.url }}`.
6. Guarda este workflow con el nombre «QA – Errores» y actívalo.

## Enchufarlo a los demás flujos
En CADA workflow que quieras vigilar: menú de tres puntos arriba a la derecha > Settings > **Error Workflow** > elige «QA – Errores». Y de paso, en Settings pon Timezone Europe/Madrid y en los nodos que llaman a APIs externas activa Settings > **Retry On Fail** (3 intentos, 5.000 ms) para que los fallos tontos se resuelvan solos y no te avisen.

## El parte semanal (segundo workflow)
1. **Schedule Trigger** — Days, Day of Week: Friday, Hour: 17.
2. **Google Sheets** — Get Rows de «Errores automatizaciones», Return All.
3. **Code** (nombre: «Resumen»). Run Once for All Items.
```js
const hace7 = Date.now() - 7*86400000;
const filas = $input.all().map(i => i.json).filter(f => new Date(f.fecha).getTime() > hace7);
const cuenta = {};
filas.forEach(f => { cuenta[f.workflow] = (cuenta[f.workflow] || 0) + 1; });
const orden = Object.entries(cuenta).sort((a,b) => b[1]-a[1]);
const texto = orden.length
  ? orden.map(([w,n]) => `- ${w}: ${n} fallos`).join('\n')
  : 'Semana limpia, ninguna automatización ha fallado.';
return [{ json: { texto, total: filas.length } }];
```
4. **Gmail** — Subject: `=Parte semanal de automatizaciones: {{ $json.total }} fallos`, Message: `={{ $json.texto }}`.

## Cómo probarla
Crea un workflow tonto con un **HTTP Request** a `https://httpstat.us/500` y Never Error desactivado, asígnale «QA – Errores» como Error Workflow y ejecútalo. Debe aparecer la fila en la hoja y llegarte el Telegram con el nombre del nodo.

## Qué puede salir mal
- **No salta nada**: el Error Workflow solo se dispara en ejecuciones de producción (activas o manuales que fallan), no en las pruebas parciales de un solo nodo. Y revisa que el workflow «QA – Errores» esté Activo.
- **Avalancha de avisos** si un flujo cada 5 minutos se rompe: añade antes del Telegram un **Google Sheets** que mire si ya hay un error de ese mismo workflow en la última hora y córtalo con un IF.
- **Fallos que no lanzan error**: si un nodo tiene Never Error activado, nunca «falla». Para esos, comprueba tú el resultado con un IF y usa un nodo **Stop and Error** con un mensaje claro cuando algo no cuadre.
- **Datos sensibles en el mensaje**: los errores pueden incluir trozos de la petición. No mandes esos avisos a un grupo compartido.

## Cuánto cuesta
Gratis. Es la mejor inversión de tiempo del catálogo: media hora de montaje que te ahorra descubrir tarde que llevas semanas sin recibir leads.
