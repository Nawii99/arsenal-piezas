# Contador de visitas a tu tienda con informe diario…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Cuenta cada entrada de cliente con un sensor de puerta y te manda por email un resumen diario con las horas punta y la comparación con la semana anterior.

## Qué es y qué hace

Flujo de n8n que cuenta cada entrada de cliente que detecta un sensor Shelly de paso y la apunta en Google Sheets con su hora. A las 22:00 agrupa el día por franjas horarias y envía por email un resumen con la comparación con el mismo día de la semana anterior. Entra los avisos del sensor; sale el informe diario.

## Cómo usarla

1. Instala el sensor de paso en la puerta
2. Conecta n8n y la hoja de registro
3. Configura el informe diario de las 22:00
4. Compara una semana antes de cambiar turnos

## Cuándo usarla

Úsalo cuando quieras saber a qué horas entra gente de verdad en tu tienda, para ajustar turnos, horario de apertura o cuándo poner la oferta en el escaparate.

## Cómo ganar dinero con ella

Ajustar un turno de dependiente a la franja real de visitas ahorra fácilmente 200-400 € al mes en horas mal colocadas.

- Informes de afluencia para tiendas de barrio que quieren ajustar turnos y horarios.
- Instalación de contadores de visitas para farmacias o peluquerías con varios empleados.
- Análisis mensual de afluencia para locales comerciales que negocian alquiler o promociones.

**Precio orientativo:** 200–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un sensor barato en la puerta llama a n8n cada vez que alguien entra. n8n apunta la hora en una hoja. A las 22:00 lee el día, cuenta por franjas horarias y te manda un email con la tabla y el total, comparado con el mismo día de la semana pasada.
Para tiendas de barrio, peluquerías, farmacias, gimnasios pequeños y cualquiera que abre a puerta de calle.
## Lo que necesitas antes
- Un sensor de paso: lo más sencillo es un **Shelly Plus i4** (unos 25 €) conectado a una barrera infrarroja o a un sensor de puerta de contacto. Alternativa DIY: un ESP32 con un sensor PIR o una barrera de 5 € que haga una petición HTTP.
- n8n accesible por https desde el local.
- Hoja de Google «Visitas» con dos pestañas: `registro` (columnas: fecha, hora, franja) y nada más.
- Cuenta de Gmail conectada en n8n (credencial Gmail OAuth2, se hace desde Google Cloud Console con el asistente de n8n; también vale el nodo **Send Email** con SMTP si prefieres no pelearte con Google).
## Los nodos, flujo 1: contar
1. **Webhook** — Method GET, Path `entrada`, Respond Immediately.
2. En el sensor: Shelly i4 > Ajustes > Acciones > sobre el evento de pulsación/cierre pon la URL `https://tu-n8n.com/webhook/entrada?puerta=principal`. Si usas ESP32, que haga un `HTTP GET` a esa misma URL.
3. **Code** (llámalo «Marcar hora») — Run Once for All Items:
```js
const ahora = new Date().toLocaleString('sv-SE', { timeZone: 'Europe/Madrid' });
const fecha = ahora.substring(0, 10);
const hora = ahora.substring(11, 16);
const franja = ahora.substring(11, 13) + ':00';
return [{ json: { fecha, hora, franja } }];
```
4. **Google Sheets** — Append Row en la pestaña `registro`: fecha, hora, franja.
## Los nodos, flujo 2: informe diario
1. **Schedule Trigger** — Cron `0 22 * * *`, con Settings > Timezone Europe/Madrid.
2. **Google Sheets** — Operation: Get Row(s), pestaña `registro`, sin filtro (o con filtro por fecha si la hoja es grande).
3. **Code** (llámalo «Resumir») — Run Once for All Items:
```js
const filas = $input.all().map(i => i.json);
const hoy = new Date().toLocaleString('sv-SE', { timeZone: 'Europe/Madrid' }).substring(0, 10);
const d = new Date(); d.setDate(d.getDate() - 7);
const haceSemana = d.toLocaleString('sv-SE', { timeZone: 'Europe/Madrid' }).substring(0, 10);
const deHoy = filas.filter(f => f.fecha === hoy);
const deAntes = filas.filter(f => f.fecha === haceSemana);
const porFranja = {};
deHoy.forEach(f => { porFranja[f.franja] = (porFranja[f.franja] || 0) + 1; });
const orden = Object.keys(porFranja).sort();
const tabla = orden.map(k => '<tr><td>' + k + '</td><td>' + porFranja[k] + '</td></tr>').join('');
const html = '<h3>Visitas del ' + hoy + '</h3><p>Total: <b>' + deHoy.length + '</b> (hace 7 días: ' + deAntes.length + ')</p><table border=1 cellpadding=6><tr><th>Franja</th><th>Entradas</th></tr>' + tabla + '</table>';
return [{ json: { html, total: deHoy.length, hoy } }];
```
4. **Gmail** — Operation: Send, To tu correo, Subject `Visitas del {{ $json.hoy }}: {{ $json.total }}`, Message `{{ $json.html }}`, Options > Email Type: HTML.
## Cómo probarla
Con el Webhook en modo test, abre la URL en el móvil cinco veces: deben aparecer cinco filas en la hoja. Después ejecuta a mano el flujo 2 y mira que el email llega con la tabla. Activa los dos workflows.
## Qué puede salir mal
- **Cuenta doble por una sola persona**: el sensor rebota. Añade tras el Webhook un **Code** que ignore eventos a menos de 3 segundos del anterior usando `$getWorkflowStaticData('global').ultimo`.
- **Cuenta salidas además de entradas**: con un solo sensor no distingues. Divide el total entre dos, o pon dos barreras y compara el orden.
- **La hoja se hace enorme**: a partir de un año, crea una pestaña por año y cambia el nodo Sheets.
- **Se cae el wifi de la tienda y pierdes eventos**: el Shelly no reintenta. Si es crítico, usa un ESP32 que guarde en memoria y reenvíe.
- **Protección de datos**: contar personas anónimamente no es dato personal. No metas cámaras de reconocimiento sin cartel y sin asesorarte.
## Cuánto cuesta
Hardware 15-30 €. Sheets y Gmail gratis. n8n autoalojado 4-6 €/mes. Si tu tienda tiene 300 entradas al día son 9.000 ejecuciones al mes: en n8n Cloud eso sale caro, así que este es de los que conviene autoalojar sí o sí.
