# Parte de luz y hora dorada para tus sesiones…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Cada tarde mira tus sesiones de mañana en el calendario y te manda las horas exactas de salida, hora dorada, hora azul y ocaso en el sitio del rodaje.

## Qué es y qué hace

Cada tarde lee los eventos de mañana de Google Calendar cuyo título empieza por SESION, convierte la ubicación en coordenadas y consulta las horas solares y la previsión de nubes. Envía por Telegram un parte con hora azul, dorada y ocaso en el sitio del rodaje. Entran eventos de calendario y salen partes de luz. Para fotógrafos que trabajan en exteriores, con n8n, Google Calendar y un bot de Telegram.

## Cómo usarla

1. Crea el bot de Telegram con BotFather
2. Escribe los eventos con SESION y una ubicación real
3. Conecta Calendar y Telegram en n8n
4. Revisa el parte del primer encargo

## Cuándo usarla

Úsalo cuando hagas exteriores (retrato, boda, arquitectura, producto en natural) y te toque calcular a mano cuándo cae la luz buena en cada localización.

## Cómo ganar dinero con ella

Una hora dorada mal calculada te cuesta repetir la sesión: 300-800 € entre desplazamiento y jornada. Y ahorra 10 minutos de cálculos por cada encargo.

- Partes de luz para fotógrafos de bodas y retrato que trabajan al aire libre, cobrados por encargo.
- Suscripción mensual con alertas de hora dorada para fotógrafos de arquitectura o producto natural.
- Plantilla de planificación de luz vendida a organizadores de sesiones y estudios.

**Precio orientativo:** 15–30 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Todos los días a las 18:00 lee los eventos de mañana de tu Google Calendar cuyo título empiece por `SESION`, saca la localización, la convierte en coordenadas y consulta las horas solares y la previsión de nubes.
Te lo manda por Telegram como un parte: hora azul de la mañana, dorada de la mañana, dorada de la tarde, azul de la tarde, ocaso y el porcentaje de nubes. Es para fotógrafos de exteriores.

## Lo que necesitas antes
- Google Calendar con tus sesiones. La clave está en cómo escribes el evento: título `SESION Boda Ana y Luis` y en el campo «Ubicación» una dirección real («Playa de la Concha, San Sebastián»).
- Credencial «Google Calendar OAuth2 API» en n8n.
- Un bot de Telegram: escribe a @BotFather, `/newbot`, te da un token. Luego escribe algo a tu bot y busca tu `chat_id` en `https://api.telegram.org/bot<TOKEN>/getUpdates`. Credencial «Telegram API» en n8n.
- Nada de pago: las APIs de Open-Meteo (geocodificación y previsión) son gratuitas y sin clave para uso no comercial moderado.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: `Days`, hora `18`, minuto `0`. En Settings del workflow pon Timezone: `Europe/Madrid`.
2. **Google Calendar** — Resource: `Event`, Operation: `Get Many`, tu calendario. After: `{{ $now.plus(1, 'days').startOf('day').toISO() }}`, Before: `{{ $now.plus(1, 'days').endOf('day').toISO() }}`, Return All activado.
3. **Filter** — String `{{ $json.summary }}` empieza por `SESION`.
4. **IF** — comprueba que `{{ $json.location }}` no está vacío. Si lo está, manda un Telegram avisándote de que falta la localización (eso ya es útil de por sí).
5. **HTTP Request** (renómbralo «Coordenadas») — GET a `https://geocoding-api.open-meteo.com/v1/search` con parámetros `name` = `{{ $json.location }}`, `count` = `1`, `language` = `es`, `format` = `json`.
6. **HTTP Request** (renómbralo «Sol y nubes») — GET a `https://api.open-meteo.com/v1/forecast` con parámetros: `latitude` = `{{ $json.results[0].latitude }}`, `longitude` = `{{ $json.results[0].longitude }}`, `daily` = `sunrise,sunset,cloud_cover_mean,precipitation_probability_max`, `timezone` = `Europe/Madrid`, `forecast_days` = `2`.
7. **Code** — calcula las ventanas de luz a partir del orto y el ocaso (código abajo).
8. **Telegram** — Operation: `Send Message`, Chat ID: el tuyo, Text: `{{ $json.parte }}`.

## El código del nodo Code
```javascript
const d = $json.daily;
const i = 1; // mañana
const evento = $('Filter').item.json;
const salida = new Date(d.sunrise[i]);
const puesta = new Date(d.sunset[i]);
const min = (fecha, m) => new Date(fecha.getTime() + m * 60000);
const hh = f => f.toISOString().slice(11, 16); // la API ya devuelve hora local
const parte = [
  '📸 ' + evento.summary,
  '📍 ' + evento.location,
  '',
  '🔵 Hora azul mañana: ' + hh(min(salida, -35)) + ' – ' + hh(min(salida, -5)),
  '🌅 Salida del sol: ' + hh(salida),
  '🟡 Hora dorada mañana: ' + hh(salida) + ' – ' + hh(min(salida, 60)),
  '🟡 Hora dorada tarde: ' + hh(min(puesta, -60)) + ' – ' + hh(puesta),
  '🌇 Ocaso: ' + hh(puesta),
  '🔵 Hora azul tarde: ' + hh(min(puesta, 5)) + ' – ' + hh(min(puesta, 35)),
  '',
  '☁️ Nubosidad media: ' + d.cloud_cover_mean[i] + '%',
  '🌧️ Prob. lluvia: ' + d.precipitation_probability_max[i] + '%',
  '',
  d.cloud_cover_mean[i] > 70 ? 'Cielo cubierto: luz suave y plana, buena para retrato, mala para contraluces.' : d.cloud_cover_mean[i] < 20 ? 'Cielo despejado: sombras duras al mediodía, lleva difusor o reflector.' : 'Nubes parciales: la mejor luz, pero cambiante. Ve con margen.'
].join('\n');
return { json: { parte } };
```

## Cómo probarla
- Crea un evento de prueba para mañana con título `SESION Prueba` y ubicación `Plaza Mayor, Madrid`. Ejecuta a mano y comprueba que las horas cuadran con cualquier app de efemérides.
- Prueba con una ubicación ambigua tipo «el parque»: verás que la geocodificación falla o acierta en otro país. Por eso conviene poner ciudad siempre.
- Cambia la fecha a un día de invierno para ver que las ventanas se estrechan; en junio en el norte la hora azul dura más.

## Qué puede salir mal
- **La hora dorada no dura exactamente 60 minutos**: depende de latitud y época. La fórmula de ±60 minutos es una aproximación buena para España peninsular; en el norte en verano alárgala a 90.
- **Zona horaria**: si no fijas `timezone=Europe/Madrid` en la petición, Open-Meteo devuelve UTC y llegarás dos horas tarde en verano. Es el error clásico.
- **Ubicación vacía o rara**: el nodo 5 devolverá una lista sin resultados y el 6 fallará. El IF del paso 4 y un segundo IF sobre `results` lo evitan.
- **Límite de la API**: Open-Meteo permite unas 10.000 peticiones diarias gratis para uso no comercial; con dos sesiones al día ni te acercas.
- **Previsión a 24 horas**: la nubosidad a un día vista es fiable, pero no es garantía. Añade una segunda ejecución a las 7:00 del mismo día si trabajas con equipos grandes.

## Cuánto cuesta
- Open-Meteo: gratis. Telegram: gratis. Google Calendar: gratis.
- n8n auto-alojado: gratis. Total: 0 € al mes.
