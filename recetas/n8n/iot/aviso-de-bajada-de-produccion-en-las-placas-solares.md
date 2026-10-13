# Aviso de bajada de producción en las placas solares…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Compara cada noche lo que han producido tus placas con lo que deberían haber producido según el sol que hizo, y te avisa si algo va mal.

## Qué es y qué hace

Cada noche lee los kWh del inversor (API local de Fronius, SolarEdge o un Shelly EM) y los compara con la radiación prevista por Open-Meteo para tu tejado. Si la producción queda muy por debajo dos días seguidos, avisa por correo o Telegram. Entrada: datos del inversor y coordenadas; salida: alerta. Se monta en n8n.

## Cómo usarla

1. Localiza la API del inversor
2. Anota latitud, longitud y kWp
3. Define el umbral de caída
4. Programa el cron nocturno

## Cuándo usarla

Cuando tengas autoconsumo instalado y no quieras enterarte en la factura de que llevas dos meses con un string caído, un panel sucio o un optimizador roto.

## Cómo ganar dinero con ella

Un string caído sin detectar son 30-120 € al mes tirados. Detectarlo en 48 horas en vez de en tres meses recupera cientos de euros al año.

- Control de producción para una instalación de autoconsumo de un autónomo.
- Vigilancia de placas solares para una comunidad o nave con autoconsumo.
- Informe mensual de rendimiento solar para un negocio que quiere ver su ahorro.

**Precio orientativo:** 100–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Todas las noches lee los kWh producidos por tu inversor y los compara con la radiación solar real de ese día en tu ubicación; si la producción se queda muy por debajo de lo esperado dos días seguidos, te avisa. Para autónomos y particulares con autoconsumo de 3 a 30 kWp.

## Lo que necesitas antes
- Acceso a los datos del inversor. Tres caminos habituales: **Fronius/SMA/Huawei en red local** (tienen API local, por ejemplo Fronius en `http://IP/solar_api/v1/GetInverterRealtimeData.cgi?Scope=System&DataCollection=CumulationInverterData`), **SolarEdge** (clave de API gratuita desde el portal de monitorización, en *Admin > Site Access > API Access*), o un **medidor Shelly EM** en la línea del inversor si el fabricante no te da API.
- Las **coordenadas** de tu tejado y la **potencia pico instalada en kWp**.
- **Open-Meteo**, gratis y sin clave, para la radiación real del día.
- Una hoja de **Google Sheets** llamada `Solar` con `fecha`, `kwh_reales`, `kwh_esperados`, `ratio`, `aviso`.
- **n8n** y un bot de **Telegram**.

## Los nodos, en orden
1. **Schedule Trigger** — *Cron* `0 22 * * *` (22:00, ya de noche), zona `Europe/Madrid`.
2. **HTTP Request** (*Producción*) — la URL de tu inversor. Si es SolarEdge: `https://monitoringapi.solaredge.com/site/TU_ID/energy?timeUnit=DAY&startDate={{ $now.format('yyyy-MM-dd') }}&endDate={{ $now.format('yyyy-MM-dd') }}&api_key=TU_CLAVE`.
3. **HTTP Request** (*Radiación*) — GET a `https://api.open-meteo.com/v1/forecast?latitude=40.41&longitude=-3.70&daily=shortwave_radiation_sum&past_days=1&forecast_days=1&timezone=Europe%2FMadrid`.
4. **Merge** — modo *Combine > All Possible Combinations*, para tener los dos datos en el mismo ítem.
5. **Code** — calcula lo esperado y decide:
```js
const prod = $('Producción').first().json;
const kwh = prod.energy ? prod.energy.values[0].value / 1000 : Number(prod.Body.Data.DAY_ENERGY.Values['1']) / 1000;
const rad = $('Radiación').first().json.daily.shortwave_radiation_sum.slice(-1)[0]; // MJ/m2
const KWP = 5.5; // tu potencia pico instalada
const RENDIMIENTO = 0.78; // pérdidas típicas de inversor, cableado y temperatura
const esperados = (rad / 3.6) * KWP * RENDIMIENTO;
const ratio = esperados > 0 ? kwh / esperados : 1;
const st = $getWorkflowStaticData('global');
const malHoy = ratio < 0.7 && esperados > 3;
st.malAyer = st.malHoy === true;
st.malHoy = malHoy;
const avisar = malHoy && st.malAyer;
return [{ json: { fecha: new Date().toLocaleDateString('es-ES'), kwh_reales: Math.round(kwh * 100) / 100, kwh_esperados: Math.round(esperados * 100) / 100, ratio: Math.round(ratio * 100) / 100, avisar, aviso: avisar ? 'SI' : 'NO' } }];
```
6. **Google Sheets** — *Append Row* en `Solar`.
7. **IF** — `{{ $json.avisar }}` *is true*.
8. **Telegram** — `☀️ Ojo con las placas: ayer y hoy has producido solo el {{ $json.ratio * 100 }}% de lo esperado ({{ $json.kwh_reales }} kWh frente a {{ $json.kwh_esperados }} kWh). Mira si hay un string caído, paneles sucios o sombra nueva.`

## Cómo probarla
- Ejecuta a mano un día soleado y ajusta el `RENDIMIENTO` hasta que el `ratio` te dé cerca de 1,0. Ese es el calibrado: hazlo con 3-4 días buenos.
- Baja el umbral a `0.99` una vez para comprobar que el aviso llega, y devuélvelo a `0.7`.
- Tapa un panel con un cartón un día entero (si puedes hacerlo con seguridad) y mira si lo pilla.

## Qué puede salir mal
- **Falsas alarmas en invierno** o con nieblas. Por eso solo avisa si el día esperaba más de 3 kWh y falla dos días seguidos.
- **Sombras nuevas** (un árbol que ha crecido, un edificio) bajan el ratio de forma permanente. Recalibra el `RENDIMIENTO` una vez al año.
- **La API de SolarEdge limita a 300 peticiones al día** por sitio: una al día es nada.
- **El inversor local cambia de IP.** Reserva la IP en el router.
- **Se pierde el `staticData`** si reinicias n8n: como mucho pierdes un día de memoria.

## Cuánto cuesta
Todo el software es **gratis**: Open-Meteo, la API del inversor, Google Sheets, Telegram y n8n auto-alojado. Si no tienes API, un Shelly EM con pinza son unos 60 € una vez.
