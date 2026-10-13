# Vigilante de sensores mudos: te avisa del que dejó de r…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Comprueba cada media hora que todos tus sensores y aparatos siguen mandando datos y te avisa en un solo mensaje de los que llevan horas callados.

## Qué es y qué hace

Flujo de n8n que cada 30 minutos mira en Google Sheets cuándo fue el último latido de cada sensor y aparato. Si alguno supera su tiempo máximo, envía un único mensaje por Telegram con la lista y no repite el aviso hasta que el equipo vuelve. Entra la hoja Latidos con una fila por dispositivo; sale el mensaje de alerta.

## Cómo usarla

1. Crea la hoja Latidos con una fila por aparato
2. Añade el paso de latido en cada flujo existente
3. Define el máximo de minutos por equipo
4. Activa el aviso en Telegram

## Cuándo usarla

Úsalo cuando ya tengas tres o más sensores montados: el fallo más peligroso no es la alarma que salta, es el sensor que se quedó sin pila y nadie lo notó.

## Cómo ganar dinero con ella

Evita el falso «todo va bien» que cuesta un género perdido o una inundación. Descubrir una pila muerta a tiempo vale más que el propio sensor.

- Monitorización de sensores para negocios con varias automatizaciones de frío, fugas o accesos.
- Configuración de vigilancia de dispositivos para pisos turísticos y alquiler de trasteros.
- Revisión mensual de sensores para naves y locales con equipos críticos sin supervisión.

**Precio orientativo:** 120–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Todos tus flujos de IoT escriben un «latido» en una hoja cada vez que reciben datos de un aparato. Este flujo mira esa hoja cada 30 minutos, calcula cuánto hace que se calló cada uno y, si alguno pasa de su tiempo máximo, te manda un único mensaje con la lista. No repite el aviso hasta que el aparato vuelve.
Para cualquiera que ya tenga montadas dos o tres automatizaciones de las otras recetas y quiera dormir tranquilo.
## Lo que necesitas antes
- Hoja de Google «Latidos» con pestaña `estado` y columnas: dispositivo, ultimo_latido, max_minutos, estado.
- Una fila por aparato. Ejemplos: `camara_frigo`, vacío, `90`, `ok`. `sensor_fuga`, vacío, `1500`, `ok`. `contador_puerta`, vacío, `720`, `ok`. El `max_minutos` es lo que como mucho puede tardar ese aparato en dar señales de vida.
- Bot de Telegram con token y chat_id.
- Un pequeño añadido en cada flujo existente: al final, un nodo **Google Sheets** con Operation Update Row sobre `estado`, Matching Column `dispositivo`, que escriba `ultimo_latido` = `{{ $now.setZone('Europe/Madrid').toISO() }}`. Son 30 segundos por flujo.
## Los nodos, en orden
1. **Schedule Trigger** — Interval, cada 30 minutos.
2. **Google Sheets** — Get Row(s) de la pestaña `estado`.
3. **Code** «Quién falta» — Run Once for All Items:
```js
const filas = $input.all().map(i => i.json);
const ahora = Date.now();
const caidos = [];
const vueltos = [];
const cambios = [];
for (const f of filas) {
  const t = f.ultimo_latido ? Date.parse(f.ultimo_latido) : 0;
  const minutos = t ? Math.round((ahora - t) / 60000) : 99999;
  const max = Number(f.max_minutos) || 120;
  const estadoActual = String(f.estado || 'ok').toLowerCase();
  let nuevo = estadoActual;
  if (minutos > max && estadoActual !== 'mudo') { nuevo = 'mudo'; caidos.push(f.dispositivo + ' (' + minutos + ' min sin dar señal)'); }
  if (minutos <= max && estadoActual === 'mudo') { nuevo = 'ok'; vueltos.push(f.dispositivo); }
  if (nuevo !== estadoActual) cambios.push({ dispositivo: f.dispositivo, ultimo_latido: f.ultimo_latido, max_minutos: f.max_minutos, estado: nuevo });
}
let texto = '';
if (caidos.length) texto += '🔇 Sin señal: ' + caidos.join(' | ') + '\n';
if (vueltos.length) texto += '✅ Han vuelto: ' + vueltos.join(', ');
return [{ json: { hayAvisos: texto.length > 0, texto, cambios } }];
```
4. **IF** — `{{ $json.hayAvisos }}` is true.
5. Rama true > **Telegram** — Send Message: `{{ $json.texto }}`.
6. Detrás > **Code** «Separar cambios» — Run Once for All Items: `return $input.first().json.cambios.map(c => ({ json: c }));`
7. **Google Sheets** — Update Row sobre `estado`, Matching Column `dispositivo`, para guardar el nuevo estado y no repetir el aviso.
## Cómo probarla
Rellena a mano la columna `ultimo_latido` de un aparato con una fecha ISO de hace tres días (por ejemplo `2026-09-05T10:00:00+02:00`) y ejecuta a mano: debe llegarte el mensaje de sin señal y la columna estado debe pasar a `mudo`. Ejecuta otra vez: NO debe repetir el mensaje. Ahora pon la fecha de ahora mismo y ejecuta: llega el «ha vuelto» y el estado vuelve a `ok`.
## Qué puede salir mal
- **Fecha en formato raro**: escribe siempre el latido con `$now.setZone('Europe/Madrid').toISO()`. Si escribes «08/09/2026 10:00», el `Date.parse` se lía.
- **Spam de mensajes**: la columna estado es justo lo que lo evita. Si te llegan repetidos, es que el nodo de Update Row no está guardando; comprueba que la columna de emparejamiento es exactamente `dispositivo`.
- **Aparatos que reportan poco por diseño**: un sensor de fuga con pilas puede tardar 24 horas en decir algo. Pon su `max_minutos` en 1500, no en 90.
- **El propio n8n se cae**: este flujo no se vigila a sí mismo. Regístralo gratis en un servicio de heartbeat externo (por ejemplo un ping de Healthchecks.io desde un **HTTP Request** al final del flujo) para que te avise si n8n deja de ejecutar.
- **Hoja con filas vacías**: filtra en el Sheets o añade `if (!f.dispositivo) continue;` al principio del bucle.
## Cuánto cuesta
Cero de hardware: es puro software sobre lo que ya tienes. Sheets y Telegram gratis. 1.440 ejecuciones al mes, que caben incluso en planes pequeños de n8n Cloud. Es la receta más barata del lote y probablemente la que más disgustos te evita.
