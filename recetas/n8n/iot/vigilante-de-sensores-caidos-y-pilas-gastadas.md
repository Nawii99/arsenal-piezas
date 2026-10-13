# Vigilante de sensores caídos y pilas gastadas…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Cada mañana revisa todos tus dispositivos domóticos y te manda una lista de los que llevan horas sin dar señal o tienen la pila por debajo del 20%.

## Qué es y qué hace

Cada mañana pregunta a Home Assistant por el estado de todas las entidades, detecta las que no tienen disponibilidad, las que llevan más de 24 horas sin reportar y las pilas por debajo del 20 %, y envía un resumen por correo o Telegram. Entrada: API de Home Assistant con token; salida: lista de incidencias. Se monta en n8n.

## Cómo usarla

1. Crea el token de larga duración en Home Assistant
2. Anota la URL del servidor
3. Define el umbral de pila del 20 %
4. Programa el resumen a las 8:00

## Cuándo usarla

Cuando ya tengas más de 8 o 10 aparatos conectados y te hayas dado cuenta de que una alarma solo sirve si el sensor está vivo, cosa que nadie comprueba.

## Cómo ganar dinero con ella

Evita el fallo silencioso: el sensor de la nevera con la pila muerta que descubres cuando ya has perdido el género. Y te ahorra la ronda manual mensual.

- Monitor de sensores para un negocio con más de diez aparatos domóticos.
- Mantenimiento de instalaciones domóticas para una casa rural o apartamentos turísticos.
- Informe mensual de baterías y dispositivos para un local con alarmas conectadas.

**Precio orientativo:** 100–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Pregunta a Home Assistant el estado de todas las entidades, se queda con las que están `unavailable` o con la batería baja o llevan más de 24 horas sin reportar, y te manda un resumen de una sola pieza. Para cualquiera que ya tenga una instalación domótica con más de ocho cacharros.

## Lo que necesitas antes
- **Home Assistant** funcionando (gratis, en un Raspberry Pi o mini PC). Si usas Zigbee2MQTT o la app de Shelly, Home Assistant los integra a todos y te da una única API.
- Un **token de larga duración** de Home Assistant: entra con tu usuario, abajo a la izquierda tu perfil, pestaña *Seguridad*, abajo del todo **Crear token**. Cópialo, solo se ve una vez.
- La **URL de Home Assistant** (por ejemplo `http://192.168.1.20:8123`).
- **n8n** y una cuenta de **Gmail** o un bot de **Telegram**.

## Los nodos, en orden
1. **Schedule Trigger** — *Cron* `0 8 * * *` (todas las mañanas a las 8), zona `Europe/Madrid`.
2. **HTTP Request** — GET a `http://192.168.1.20:8123/api/states`. En *Authentication* elige *Generic > Header Auth* y crea una credencial con nombre `Authorization` y valor `Bearer TU_TOKEN`. En *Options > Response* marca *Never Error* desactivado.
3. **Code** — filtra los problemas:
```js
const estados = $input.first().json;
const ahora = Date.now();
const problemas = [];
for (const e of estados) {
  const id = e.entity_id;
  const nombre = (e.attributes && e.attributes.friendly_name) || id;
  const horas = (ahora - new Date(e.last_updated).getTime()) / 3600000;
  if (e.state === 'unavailable' || e.state === 'unknown') { problemas.push('🔴 SIN SEÑAL: ' + nombre); continue; }
  if (id.includes('battery') && !isNaN(Number(e.state)) && Number(e.state) < 20) { problemas.push('🔋 PILA ' + e.state + '%: ' + nombre); continue; }
  const bat = e.attributes && e.attributes.battery_level;
  if (bat !== undefined && Number(bat) < 20) { problemas.push('🔋 PILA ' + bat + '%: ' + nombre); continue; }
  if ((id.startsWith('sensor.') || id.startsWith('binary_sensor.')) && horas > 24) { problemas.push('⏰ ' + Math.round(horas) + ' h sin reportar: ' + nombre); }
}
const hay = problemas.length > 0;
return [{ json: { hay, total: estados.length, cuantos: problemas.length, texto: hay ? problemas.join('\n') : 'Todo correcto', fecha: new Date().toLocaleDateString('es-ES') } }];
```
4. **IF** — `{{ $json.hay }}` *is true*. Así solo te escribe cuando hay algo que hacer y no te acostumbras a ignorarlo.
5. **Telegram** — *Send Message*: `🛠️ Revisión domótica {{ $json.fecha }} — {{ $json.cuantos }} de {{ $json.total }} con problema:` y debajo `{{ $json.texto }}`.
6. Opcional: **Gmail** — el mismo contenido por correo los lunes, añadiendo un **IF** con `{{ new Date().getDay() === 1 }}`.

## Cómo probarla
- Ejecuta el HTTP solo: debe devolver un array largo (100-400 entidades es normal). Si da 401, el token está mal copiado; si da *ECONNREFUSED*, n8n no ve a Home Assistant en la red.
- Quítale la pila a un sensor cualquiera y espera 24 horas: debe aparecer en la lista del día siguiente.
- Baja el umbral de horas a `0.1` una vez para ver que el filtro de tiempo funciona, y vuelve a dejarlo en 24.

## Qué puede salir mal
- **Te salen 60 falsos positivos** de entidades que solo se actualizan cuando pasa algo (un botón que llevas semanas sin pulsar). Añade una lista blanca al principio del Code: `const ignorar = ['sensor.x', 'binary_sensor.y']; if (ignorar.includes(id)) continue;`
- **Respuesta enorme** que ralentiza n8n. Puedes filtrar por dominio pidiendo `/api/states` y quedándote solo con `sensor.`, `binary_sensor.` y `switch.`, que es lo que hace el código.
- **Home Assistant se reinicia** y todo aparece `unavailable` durante un minuto. Ejecuta a las 8:00, no justo después de un reinicio programado.
- **No usas Home Assistant.** Se puede hacer igual contra la API de Shelly Cloud (`/device/all_status`) mirando el campo `online` y `battery.value`.

## Cuánto cuesta
Home Assistant es gratis y de código abierto; el hardware, un Raspberry Pi 4 o un mini PC de segunda mano (60-120 € una vez). n8n auto-alojado, Telegram y Gmail: **0 €/mes**.
