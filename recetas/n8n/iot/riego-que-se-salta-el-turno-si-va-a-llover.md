# Riego que se salta el turno si va a llover…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Antes de cada riego mira la lluvia caída y la prevista en tu ubicación y decide si riega, riega menos o no riega, abriendo la electroválvula justo los minutos necesarios.

## Qué es y qué hace

Flujo de n8n que a la hora fijada consulta la lluvia de los dos últimos días y la prevista para hoy y mañana en tus coordenadas, con Open-Meteo. Según eso calcula cero, la mitad o el turno completo de minutos y abre la electroválvula con un Shelly. Entra las coordenadas y la auth_key; sale el riego ajustado y un aviso por Telegram.

## Cómo usarla

1. Conecta un Shelly a la electroválvula de 24 V
2. Pon coordenadas, auth_key y el ID del dispositivo
3. Define los tramos de minutos según la lluvia
4. Prueba con un turno manual antes de dejarlo solo

## Cuándo usarla

Úsalo cuando riegues jardín de un chalet, terraza de restaurante, vivero, huerto o zonas verdes de una comunidad y estés tirando agua cuando no hace falta.

## Cómo ganar dinero con ella

Ahorra entre un 20 y un 40 % de la factura de agua de riego y evita ahogar plantas que luego hay que reponer.

- Sistemas de riego inteligente para chalets y terrazas de restaurantes que pagan mucha agua.
- Instalación y ajuste de riego para comunidades de vecinos con zonas verdes comunes.
- Configuración de riego para viveros pequeños con seguimiento del consumo mensual.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
A la hora que digas consulta la lluvia de los dos días pasados y la prevista para hoy y mañana. Con eso calcula minutos de riego: cero si ha llovido o va a llover fuerte, la mitad si ha caído algo, el turno completo si está seco. Abre la válvula con temporizador y te lo cuenta por Telegram.
Para dueños de chalet, restaurantes con terraza ajardinada, viveros pequeños y administradores de comunidades.
## Lo que necesitas antes
- Un Shelly Plus 1 (unos 18 €) conectado a la electroválvula de 24 V del programador de riego, o un Shelly Plus Plug S si tu bomba va a enchufe. Instalación eléctrica: si dudas, que la haga un electricista.
- `auth_key`, servidor e ID del dispositivo de la nube Shelly.
- Tus coordenadas: abre Google Maps, pulsa largo sobre tu parcela y copia los dos números (por ejemplo 39.4699 y -0.3763).
- Nada de claves para el tiempo: Open-Meteo es gratis para uso pequeño y sin registro.
- Bot de Telegram con token y chat_id.
## Los nodos, en orden
1. **Schedule Trigger** — Cron Expression `0 6 * * *` (las 6 de la mañana, hora del servidor; si tu n8n va en UTC, pon `0 4 * * *` en verano y ajusta, o mejor configura la zona horaria del workflow en Settings > Timezone: Europe/Madrid).
2. **HTTP Request** — GET a `https://api.open-meteo.com/v1/forecast?latitude=39.4699&longitude=-0.3763&daily=precipitation_sum,temperature_2m_max&past_days=2&forecast_days=2&timezone=Europe%2FMadrid`. Cambia las coordenadas por las tuyas.
3. **Code** (llámalo «Cuántos minutos») — Run Once for All Items, código abajo.
4. **IF** — condición: `{{ $json.minutos }}` **larger** `0` (tipo Number).
5. Rama true > **HTTP Request** «Abrir válvula» — POST `https://shelly-53-eu.shelly.cloud/device/relay/control`, Form Urlencoded: `id`, `auth_key`, `channel` = `0`, `turn` = `on`, `timer` = `{{ $json.minutos * 60 }}`. El parámetro `timer` hace que el propio Shelly se apague solo pasados esos segundos, así que aunque n8n se caiga no se inunda el jardín.
6. Detrás > **Telegram** — Send Message: `💧 Riego de hoy: {{ $json.minutos }} min. Lluvia últimos 2 días: {{ $json.pasada }} mm. Prevista hoy+mañana: {{ $json.futura }} mm.`
7. Rama false del IF > **Telegram** — `🚫 Hoy no riego. Lluvia prevista: {{ $json.futura }} mm.`
## El código del nodo Code
```js
const MINUTOS_BASE = 20;
const d = $input.first().json.daily;
const pasada = (d.precipitation_sum[0] || 0) + (d.precipitation_sum[1] || 0);
const futura = (d.precipitation_sum[2] || 0) + (d.precipitation_sum[3] || 0);
const calor = d.temperature_2m_max[2] || 20;
let minutos = MINUTOS_BASE;
if (futura >= 5 || pasada >= 10) minutos = 0;
else if (futura >= 2 || pasada >= 4) minutos = Math.round(MINUTOS_BASE / 2);
if (minutos > 0 && calor >= 33) minutos = Math.round(minutos * 1.3);
return [{ json: { minutos, pasada: pasada.toFixed(1), futura: futura.toFixed(1), calor } }];
```
## Cómo probarla
Ejecuta a mano y mira la salida del Code antes de conectar la válvula: cambia a mano los umbrales para ver que devuelve 0, la mitad y el completo. Después conecta la válvula y prueba con `MINUTOS_BASE = 1` para ver abrir y cerrar de verdad. Comprueba con un cubo que sale agua y que se corta sola. Luego pon tus minutos reales y activa.
## Qué puede salir mal
- **Riega de noche a la hora equivocada**: configúrale al workflow Settings > Timezone `Europe/Madrid` y así el cron es hora española todo el año.
- **Se queda el agua abierta**: nunca uses `turn=on` sin `timer`. Además, en la app Shelly activa «Auto OFF» con un tiempo máximo de seguridad, por si el flujo falla.
- **Open-Meteo te bloquea**: es gratis hasta unas 10.000 llamadas al día, con una al día vas sobradísimo. Si empiezas a recibir 429, es que has dejado el Schedule cada minuto por error.
- **Previsión que falla**: el sistema es conservador con la lluvia futura; si vives en zona de tormentas que no cuajan, sube el umbral de 5 mm a 8 mm.
- **Corte de luz mientras riega**: el Shelly, al volver, arranca según su ajuste «Power On Default». Ponlo en OFF.
## Cuánto cuesta
Open-Meteo gratis, Shelly Cloud gratis, Telegram gratis. Hardware 18-30 €. Alojamiento de n8n, 4-6 €/mes. Una ejecución al día: cabe en cualquier plan, incluso en los gratuitos de prueba.
