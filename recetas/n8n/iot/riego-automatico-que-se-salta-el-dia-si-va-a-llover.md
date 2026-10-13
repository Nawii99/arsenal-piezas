# Riego automático que se salta el día si va a llover…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Cada mañana mira la previsión de lluvia y la de los últimos días y decide si riega, cuántos minutos y a qué hora, abriendo y cerrando la electroválvula sola.

## Qué es y qué hace

Cada mañana consulta la previsión y la lluvia caída en Open-Meteo para tu parcela y calcula si toca regar y cuántos minutos. Abre la electroválvula conectada a un Shelly Plus 1 y la cierra al terminar. Entrada: coordenadas y previsión; salida: orden de riego y registro. Se monta en n8n sin claves de API.

## Cómo usarla

1. Instala la electroválvula y el Shelly con IP fija
2. Anota las coordenadas de la parcela
3. Define el cálculo de minutos
4. Programa el cron de las 6:00

## Cuándo usarla

Cuando tengas jardín, terraza con plantas, huerto o zonas verdes de una comunidad y estés regando con programador de reloj que riega igual llueva o truene.

## Cómo ganar dinero con ella

Recorta entre un 20% y un 40% del agua de riego. En una comunidad o un vivero pequeño son 300-900 € al año, y las plantas se pudren menos.

- Riego inteligente para una comunidad de vecinos con zonas verdes.
- Automatización de riego para un vivero o huerto pequeño que quiere ahorrar agua.
- Instalación de riego con avisos para una terraza con plantas o un jardín de empresa.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Todos los días a las 6:00 consulta la previsión y la lluvia caída, calcula si toca regar y cuántos minutos, abre la electroválvula, espera y la cierra. Para cualquiera que riegue con programador tonto y quiera dejar de tirar agua.

## Lo que necesitas antes
- Una **electroválvula de 24 V o 230 V** ya instalada y un **Shelly Plus 1** (o Shelly 1 Mini, unos 15 €) que la conmute. Ojo: la instalación eléctrica que la monte un electricista si es de 230 V.
- El Shelly con **IP fija** en tu router (reserva DHCP) y accesible desde donde corra n8n. Si n8n está fuera de casa, usa la API de Shelly Cloud igual que en la receta de la nevera.
- **Open-Meteo**: API meteorológica gratuita y **sin clave ni registro**. Necesitas la latitud y longitud de tu parcela (las sacas de Google Maps haciendo clic derecho sobre el punto).
- **n8n** y, si quieres aviso, un bot de **Telegram**.

## Los nodos, en orden
1. **Schedule Trigger** — *Cron*, expresión `0 6 * * *` (6:00), zona horaria `Europe/Madrid`.
2. **HTTP Request** — GET a `https://api.open-meteo.com/v1/forecast?latitude=40.41&longitude=-3.70&daily=precipitation_sum,et0_fao_evapotranspiration,temperature_2m_max&past_days=3&forecast_days=2&timezone=Europe%2FMadrid`. Cambia latitud y longitud por las tuyas.
3. **Code** — decide minutos de riego:
```js
const d = $json.daily;
const lluviaPasada = d.precipitation_sum[0] + d.precipitation_sum[1] + d.precipitation_sum[2];
const lluviaHoy = d.precipitation_sum[3];
const lluviaManana = d.precipitation_sum[4] || 0;
const et0 = d.et0_fao_evapotranspiration[3] || 3;
const tmax = d.temperature_2m_max[3];
let minutos = Math.round(et0 * 4);
if (lluviaPasada > 10) minutos = 0;
if (lluviaHoy > 4 || lluviaManana > 8) minutos = 0;
if (tmax > 34) minutos = Math.round(minutos * 1.25);
minutos = Math.min(minutos, 25);
const motivo = minutos === 0 ? 'No riego: ha llovido ' + lluviaPasada.toFixed(1) + ' mm o se espera lluvia' : 'Riego ' + minutos + ' min (ET0 ' + et0 + ', Tmax ' + tmax + ')';
return [{ json: { minutos, motivo, regar: minutos > 0, segundos: minutos * 60 } }];
```
4. **IF** — `{{ $json.regar }}` *is true*.
5. **HTTP Request** (rama true, llámalo *Abrir válvula*) — GET a `http://192.168.1.50/relay/0?turn=on&timer={{ $json.segundos }}`. El parámetro `timer` hace que el propio Shelly se apague solo pasados esos segundos: aunque n8n se caiga a mitad, la válvula cierra. Para un Shelly Gen2/Plus la URL es `http://192.168.1.50/rpc/Switch.Set?id=0&on=true&toggle_after={{ $json.segundos }}`.
6. **Telegram** — *Send Message*: `💧 Riego de hoy: {{ $json.motivo }}`.
7. Rama *false* del IF: otro **Telegram** con el mismo texto, para que sepas por qué no ha regado.

## Cómo probarla
- Ejecuta el HTTP de Open-Meteo solo y mira que `daily.precipitation_sum` trae 5 valores (3 días pasados + hoy + mañana).
- Pon `minutos = 1` a mano en el Code y ejecuta el workflow entero: la válvula debe abrir y cerrarse sola en 60 segundos. Ve a verlo, no te fíes.
- Fuerza el caso de lluvia poniendo unas coordenadas de Galicia en noviembre y comprueba que sale `regar: false`.

## Qué puede salir mal
- **La válvula se queda abierta.** Por eso se usa `timer`/`toggle_after` en el propio Shelly y no un nodo **Wait** de n8n. Añade además un **Schedule Trigger** a las 7:30 que lance `?turn=off` como red de seguridad.
- **La IP del Shelly cambia.** Reserva la IP en el router por MAC.
- **Open-Meteo no responde.** En el nodo HTTP activa *Settings > Retry On Fail*, 3 intentos, 5000 ms de espera.
- **Riegas al mediodía en agosto.** Riega de madrugada: cambia el cron a `0 4 * * *`.
- **Varias zonas de riego.** Duplica el HTTP con `id=1`, `id=2`, o mete las zonas en un array y usa **Split In Batches** con un **Wait** entre zonas para no bajar la presión del agua.

## Cuánto cuesta
Shelly 1 Mini 13-18 €, electroválvula 15-30 €. Open-Meteo es gratis para uso no comercial (hasta 10.000 llamadas al día). n8n auto-alojado y Telegram, 0 €. Coste mensual real: **0 €**.
