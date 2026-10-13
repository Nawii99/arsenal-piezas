# Termostato que se adelanta al tiempo y a tu horario…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Ajusta solo la calefacción o el aire según la temperatura que hará mañana y las horas en que el local está ocupado, y te manda el ahorro cada mes.

## Qué es y qué hace

Cada noche lee la previsión de temperatura de Open-Meteo y tu calendario de reservas, y programa la consigna del termostato hora a hora en Home Assistant: precalienta antes de abrir, baja cuando no hay nadie y no actúa si el día es templado. Entrada: previsión y calendario; salida: consignas del termostato. Se monta en n8n.

## Cómo usarla

1. Conecta el termostato a Home Assistant
2. Crea el token de larga duración
3. Anota el horario de apertura
4. Programa el cálculo nocturno

## Cuándo usarla

Cuando pagues la climatización de un local, oficina o casa rural y el termostato esté a una temperatura fija todo el día, incluso con el sitio vacío.

## Cómo ganar dinero con ella

Bajar 2 ºC en las horas vacías y precalentar solo lo justo recorta entre un 15% y un 30% de la factura de climatización: 40-200 €/mes en un local.

- Programación de climatización para un local con horario fijo y reservas.
- Control de calefacción para una casa rural o un apartamento turístico.
- Ajuste de termostato para una oficina pequeña que quiere recortar la factura.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada noche mira la previsión de temperatura del día siguiente y tu calendario de reservas u horario, y programa la consigna del termostato hora a hora: precalienta antes de abrir, afloja cuando no hay nadie y no toca nada si el día va a ser templado. Para locales, oficinas pequeñas, casas rurales y apartamentos turísticos.

## Lo que necesitas antes
- Un **termostato controlable**: Shelly TRV en radiadores, un Shelly Plus 1 en el hilo de la caldera, o cualquier termostato integrado en **Home Assistant** (Daikin, Tado, Netatmo, Nest, Zigbee).
- **Home Assistant** con su **token de larga duración** (perfil > Seguridad > Crear token).
- **Open-Meteo**, gratis y sin clave.
- Un **Google Calendar** donde marques las reservas o el horario de apertura (si tu horario es siempre igual, sáltate el calendario y ponlo en el código).
- **n8n**.

## Los nodos, en orden
1. **Schedule Trigger** — *Cron* `0 23 * * *`, zona `Europe/Madrid`.
2. **HTTP Request** — GET a `https://api.open-meteo.com/v1/forecast?latitude=40.41&longitude=-3.70&hourly=temperature_2m&forecast_days=2&timezone=Europe%2FMadrid`.
3. **Google Calendar** — operación *Get Many Events*, del calendario de reservas, entre `{{ $now.plus(1,'days').startOf('day') }}` y `{{ $now.plus(1,'days').endOf('day') }}`.
4. **Code** — construye el plan del día siguiente:
```js
const horas = $('HTTP Request').first().json.hourly;
const eventos = $('Google Calendar').all().map(i => i.json);
const manana = new Date(Date.now() + 86400000);
const ocupadas = new Set();
for (const ev of eventos) {
  const ini = new Date(ev.start.dateTime || ev.start.date).getHours();
  const fin = new Date(ev.end.dateTime || ev.end.date).getHours();
  for (let h = ini; h < fin; h++) ocupadas.add(h);
}
const plan = [];
for (let h = 0; h < 24; h++) {
  const idx = 24 + h; // las 24 primeras posiciones son de hoy
  const text = horas.temperature_2m[idx];
  let consigna = 16; // modo ausente
  if (ocupadas.has(h)) consigna = 21;
  if (ocupadas.has(h + 1) && !ocupadas.has(h)) consigna = text < 5 ? 20 : 18; // precalentar la hora previa, más si hace mucho frío
  if (text > 19) consigna = 16; // si fuera hace bueno, no calientes
  plan.push({ hora: h, consigna, text });
}
return plan.map(p => ({ json: p }));
```
5. **Google Sheets** (o el nodo **Edit Fields (Set)** guardando en una hoja `Termostato`) — *Append or Update Row* con `fecha`, `hora`, `consigna`. Guardar el plan permite que un segundo workflow lo ejecute.
6. Segundo workflow: **Schedule Trigger** `5 * * * *` (cada hora al minuto 5), **Google Sheets** *Get Row(s)* filtrando por fecha y hora actual.
7. **HTTP Request** — POST a `http://192.168.1.20:8123/api/services/climate/set_temperature`, cabecera `Authorization: Bearer TU_TOKEN`, cuerpo JSON: `{ "entity_id": "climate.local", "temperature": {{ $json.consigna }} }`.
8. Opcional: un tercer **Schedule Trigger** mensual que lea el consumo del Shelly EM de la climatización y te mande por Telegram la comparación con el mes anterior.

## Cómo probarla
- Ejecuta el primer workflow a mano y revisa la hoja: 24 filas con consignas que tengan sentido (16 de madrugada, 18-21 en horas ocupadas).
- Lanza el segundo a mano y mira en Home Assistant que la consigna del termostato cambia de verdad.
- Deja pasar dos días y comprueba por la mañana que el local está a temperatura cuando abres. Si llegas y hace frío, sube la anticipación a dos horas.

## Qué puede salir mal
- **La inercia térmica**. Un local grande de piedra necesita 2-3 horas de precalentamiento, no una. Ajusta el bucle para marcar `h+1` y `h+2`.
- **Alguien toca el termostato a mano** y el workflow se lo pisa a la hora siguiente. Añade una entidad `input_boolean.manual` en Home Assistant y un **IF** que se salte todo si está activada.
- **Bombas de calor y ciclos cortos**: no cambies la consigna más de una vez por hora ni hagas saltos de más de 3 ºC, que se disparan las descongelaciones.
- **El índice del array meteorológico**: `forecast_days=2` da 48 horas; las 24 primeras son hoy. Si cambias el parámetro, cambia el `24 + h`.
- **Zona horaria**: pide siempre `timezone=Europe/Madrid` a Open-Meteo para que las horas casen.

## Cuánto cuesta
Open-Meteo, Google Calendar, Home Assistant y n8n auto-alojado: **0 €/mes**. Un Shelly TRV por radiador son 50-60 €; un Shelly Plus 1 para la caldera, 15 € más el electricista. Con 40 €/mes de ahorro se paga en un invierno.
