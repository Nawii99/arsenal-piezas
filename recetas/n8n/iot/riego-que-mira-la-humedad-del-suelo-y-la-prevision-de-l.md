# Riego que mira la humedad del suelo y la previsión de l…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Cada mañana consulta la humedad real de la tierra y si va a llover; solo riega si hace falta y calcula los minutos exactos.

## Qué es y qué hace

A las 6:00 lee un sensor capacitivo de humedad del suelo y consulta en Open-Meteo la lluvia prevista y la temperatura máxima del día. Con esos datos decide si riega y cuántos minutos, abre la electroválvula mediante un relé Shelly, la cierra y registra la acción. Sirve para jardines, huertos y jardineras, con n8n y un ESP32 que publica la humedad en red local.

## Cómo usarla

1. Calibra el sensor en tierra seca y en agua
2. Pide las coordenadas de la parcela
3. Crea en n8n la regla de riego según humedad y lluvia
4. Revisa el registro durante dos semanas

## Cuándo usarla

Cuando riegues jardín, huerto, viñedo pequeño o las jardineras de la terraza del restaurante con un programador de horario fijo que riega igual con 40 ºC que en plena tormenta.

## Cómo ganar dinero con ella

Reduce entre un 30 % y un 50 % el agua de riego. En un jardín mediano son 150-400 € al año, y evita ahogar las plantas.

- Instalación de riego inteligente para jardines de comunidades o chalets, con sensor, válvula y configuración.
- Ajuste estacional de umbrales y mantenimiento para huertos urbanos o zonas verdes de pequeños negocios.
- Kit de riego con sensor para jardineras de terrazas de restaurantes, vendido con instalación y puesta a punto.

**Precio orientativo:** 150–400 € por huerto o jardín. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
A las 6:00 lee un sensor capacitivo de humedad del suelo, consulta a Open-Meteo la lluvia prevista y la temperatura máxima del día, y con eso decide si riega y cuántos minutos. Abre la electroválvula, espera y la cierra. Todo queda registrado.
Para negocios con zona verde, huertos y particulares mañosos.

## Lo que necesitas antes
- Sensor capacitivo de humedad de suelo v2.0 (no el resistivo, que se corroe en semanas): 5-8 €.
- ESP32 con ESPHome, alimentado o con panelito solar, publicando la humedad en `http://192.168.1.90/sensor/humedad_suelo` en porcentaje. Calíbralo: mete el sensor en tierra seca (0 %) y en un vaso de agua (100 %) y ajusta `calibrate_linear` en ESPHome.
- Electroválvula de 24 V AC o 12 V DC con su transformador, y un relé Shelly Plus 1 (192.168.1.91).
- Coordenadas de tu parcela (búscalas en Google Maps, botón derecho).
- n8n autoalojado, hoja «Riego» en Google Sheets.

## Los nodos, en orden
1. **Schedule Trigger**: Cron `0 6 * * *`, timezone Europe/Madrid.
2. **HTTP Request** «Humedad»: GET `http://192.168.1.90/sensor/humedad_suelo`.
3. **HTTP Request** «Tiempo»: GET `https://api.open-meteo.com/v1/forecast?latitude=40.41&longitude=-3.70&daily=precipitation_sum,temperature_2m_max&forecast_days=2&timezone=Europe%2FMadrid` (cambia las coordenadas).
4. **Code** «Calcular riego».
5. **IF**: `{{ $json.minutos }}` larger than 0.
6. Rama true → **HTTP Request** «Abrir»: `http://192.168.1.91/rpc/Switch.Set?id=0&on=true&toggle_after={{ $json.minutos * 60 }}`. El parámetro `toggle_after` del Shelly hace que se cierre solo aunque n8n se caiga.
7. → **Wait**: `{{ $json.minutos }}` minutes.
8. → **HTTP Request** «Cerrar»: `http://192.168.1.91/rpc/Switch.Set?id=0&on=false` (por si acaso).
9. Todas → **Google Sheets** (Append): fecha, humedad, lluvia prevista, temperatura máxima, minutos regados y motivo.

## El trozo de código (nodo Code, «Calcular riego»)
```js
const humedad = Number($('Humedad').first().json.value);
const t = $('Tiempo').first().json.daily;
const lluviaHoy = Number(t.precipitation_sum[0]);
const lluviaManana = Number(t.precipitation_sum[1]);
const tmax = Number(t.temperature_2m_max[0]);
let minutos = 0; let motivo = '';
if (lluviaHoy >= 4 || lluviaManana >= 8) { motivo = 'Va a llover, no riego'; }
else if (humedad >= 55) { motivo = `Tierra al ${humedad}%, no hace falta`; }
else { minutos = humedad < 30 ? 15 : 8; if (tmax > 32) minutos += 5; motivo = `Tierra al ${humedad}%, máxima ${tmax} ºC`; }
return [{ json: { minutos, motivo, humedad, lluviaHoy, lluviaManana, tmax } }];
```

## Cómo probarla
- Ejecuta a mano con el sensor al aire (humedad 0 %): debe salir el riego largo. Mételo en un vaso de agua: debe decidir no regar.
- Comprueba que `toggle_after` funciona: abre la válvula con `toggle_after=30` y verifica que se cierra sola a los 30 segundos. Este es el seguro que evita inundaciones.
- Los primeros días riega manualmente y compara con lo que habría decidido el sistema.

## Qué puede salir mal
- **Nunca dependas solo de n8n para cerrar**: si el servidor se cuelga con la válvula abierta, te vacía el depósito. Por eso el `toggle_after` del propio Shelly y, si el riego es grande, un temporizador mecánico en serie.
- **Sensor mal enterrado**: si queda en una bolsa de aire mide seco siempre y riega a diario. Entiérralo a la profundidad de las raíces y compacta la tierra alrededor.
- **Zona horaria**: Open-Meteo devuelve los días según el parámetro `timezone`; si lo omites te da UTC y el «hoy» puede desplazarse.
- **Sensor sin batería en invierno**: si el HTTP falla, la rama de error debe NO regar y mandarte un aviso, en vez de regar por defecto.
- **Heladas**: añade una condición que no riegue si la mínima prevista es inferior a 2 ºC.

## Cuánto cuesta
Open-Meteo es gratis sin clave para uso no comercial intensivo (una llamada al día es nada). n8n y Sheets, 0 €. Hardware: 50-70 € entre ESP32, sensor, válvula y Shelly.
