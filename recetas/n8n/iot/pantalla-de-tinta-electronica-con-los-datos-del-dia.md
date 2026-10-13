# Pantalla de tinta electrónica con los datos del día…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Una pantalla e-ink colgada en la pared del obrador o la oficina muestra pedidos del día, temperatura, próximas citas y consumo, actualizada sola cada hora.

## Qué es y qué hace

Flujo de n8n que cada hora reúne en una URL sencilla los pedidos pendientes de una hoja de Google, las citas del día de un calendario y la temperatura de un sensor. Una pantalla e-ink con ESP32 pide esa URL, dibuja el texto y vuelve a dormir hasta la hora siguiente. Entra las hojas y el calendario; sale la pantalla actualizada.

## Cómo usarla

1. Monta la pantalla con ESP32 y el ejemplo de Arduino
2. Reúne pedidos, citas y temperatura en una URL
3. Ajusta la frecuencia a cada hora
4. Prueba la batería una semana

## Cuándo usarla

Úsalo cuando el equipo no mire el móvil ni el ordenador durante el turno y necesites que la información esté a la vista sin gastar luz ni molestar.

## Cómo ganar dinero con ella

Evita la reunión diaria de 10 minutos y las llamadas de «¿cuántos pedidos hay hoy?». Con 4 personas son 3 horas al mes recuperadas.

- Paneles informativos para obradores y talleres que quieren ver pedidos sin usar el móvil.
- Instalación de pantallas de citas para recepciones de clínicas y despachos pequeños.
- Panel de producción para cocinas y almacenes con actualización automática cada hora.

**Precio orientativo:** 250–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
n8n reúne cada hora los datos que te importan (pedidos pendientes de una hoja, las citas de hoy del calendario y la temperatura del sensor) y los deja publicados en una URL sencilla. Una pantalla de tinta electrónica con ESP32 se despierta cada hora, pide esa URL, la dibuja y se vuelve a dormir. Con una batería aguanta semanas.
Para obradores, talleres, recepciones, cocinas y almacenes.
## Lo que necesitas antes
- Una pantalla e-ink con ESP32 integrada: LilyGO T5 de 4,7 pulgadas o una Waveshare de 7,5" con su placa ESP32 (40-80 €). Vienen con ejemplos en Arduino para pedir una URL y pintar texto.
- n8n con URL https accesible desde el wifi del local.
- Hoja de Google «Panel» donde ya lleves tus pedidos, con columnas: pedido, cliente, estado, entrega.
- Un calendario de Google con las citas del día.
- Opcional: la temperatura del sensor de la receta del frigorífico, leyendo su última fila.
## Los nodos, en orden
1. **Webhook** — Method GET, Path `panel`, Respond: Using Respond to Webhook node. Esta es la URL que pedirá la pantalla.
2. **Google Sheets** — Get Row(s) de «Panel». En Options > Filters, filtra `estado` igual a `pendiente` (o hazlo en el Code, si tu versión no filtra).
3. **Google Calendar** — Resource: Event, Operation: Get Many, calendario el tuyo, Options: After `{{ $now.setZone('Europe/Madrid').startOf('day').toISO() }}` y Before `{{ $now.setZone('Europe/Madrid').endOf('day').toISO() }}`, Limit 10.
4. **Merge** — Mode: Combine, Combine By: Position, o simplemente conecta los dos al mismo **Code** usando referencias por nombre de nodo.
5. **Code** «Montar texto» — Run Once for All Items:
```js
const pedidos = $('Google Sheets').all().map(i => i.json).filter(p => String(p.estado).toLowerCase() === 'pendiente');
let citas = [];
try { citas = $('Google Calendar').all().map(i => i.json); } catch (e) { citas = []; }
const ahora = new Date().toLocaleString('es-ES', { timeZone: 'Europe/Madrid', hour: '2-digit', minute: '2-digit', day: '2-digit', month: '2-digit' });
const lineas = [];
lineas.push('ACTUALIZADO ' + ahora);
lineas.push('');
lineas.push('PEDIDOS PENDIENTES: ' + pedidos.length);
pedidos.slice(0, 8).forEach(p => lineas.push('  ' + p.pedido + '  ' + p.cliente + '  ' + p.entrega));
lineas.push('');
lineas.push('HOY EN LA AGENDA:');
if (!citas.length) lineas.push('  sin citas');
citas.slice(0, 5).forEach(c => { const h = c.start && c.start.dateTime ? c.start.dateTime.substring(11,16) : 'todo el dia'; lineas.push('  ' + h + '  ' + (c.summary || '')); });
return [{ json: { texto: lineas.join('\n') } }];
```
6. **Respond to Webhook** — Respond With: Text, Response Body: `{{ $json.texto }}`, y en Options añade la cabecera `Content-Type` con valor `text/plain; charset=utf-8`.
## El lado de la pantalla
En el ESP32, usa el ejemplo de tu pantalla y sustituye la parte de datos por: conectarse al wifi, hacer `http.begin("https://tu-n8n.com/webhook/panel")`, leer `http.getString()`, pintar el texto línea a línea con `display.println()`, y después `esp_deep_sleep(3600e6)` para dormir una hora. Mandamos texto plano a propósito: así el ESP32 no tiene que interpretar JSON ni HTML y el código cabe en 60 líneas.
## Cómo probarla
Abre la URL del webhook en el navegador del móvil: debes ver el texto tal cual, ordenado y sin caracteres raros. Comprueba las tildes: si salen mal, quítalas del Code (las pantallas e-ink baratas suelen no tener la fuente completa). Luego enciende la pantalla y comprueba que dibuja lo mismo.
## Qué puede salir mal
- **Tildes y eñes**: muchas fuentes de e-ink solo traen ASCII. Añade en el Code un reemplazo: `.replace(/[áàä]/g,'a').replace(/é/g,'e').replace(/í/g,'i').replace(/ó/g,'o').replace(/ú/g,'u').replace(/ñ/g,'n')` sobre el texto final.
- **Se queda congelada**: la e-ink mantiene la última imagen aunque se quede sin batería, así que puede estar mostrando datos de ayer sin que lo notes. Por eso la primera línea es la hora de actualización: si no cuadra, hay un problema.
- **La pantalla no llega al webhook**: comprueba que tu certificado https es válido y no autofirmado; muchos ESP32 no validan bien. Si te complica, expón el webhook por http solo dentro de la red local.
- **Demasiadas líneas**: la e-ink tiene un número fijo de líneas. Ajusta los `slice(0, 8)` a lo que te quepa.
- **Refresco y batería**: cada refresco completo gasta poco, pero despertar el wifi gasta bastante. Una hora está bien; cada 5 minutos te come la batería en días.
## Cuánto cuesta
Pantalla con ESP32, 40-80 € una vez. Sheets y Calendar gratis. n8n autoalojado 4-6 €/mes. Consumo eléctrico prácticamente cero: la tinta electrónica solo gasta al cambiar de imagen, así que puede vivir de una batería de 2.500 mAh durante meses.
