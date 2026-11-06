# Riego que calcula el agua según el tiempo real, no segú…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Cruza la previsión y los datos de AEMET con la humedad medida en el suelo para decidir cada día cuántos minutos regar, o si no regar nada. Para viveros, huertos y jardines de comunidades.

## Qué es y qué hace

Flujo de n8n que cada mañana consulta en AEMET la previsión de tu municipio (temperatura máxima, humedad y probabilidad de lluvia) y lee la humedad del suelo de tus sensores capacitivos. Calcula los minutos de riego de la tarde, o ninguno si llueve o el suelo está saturado, y abre la electroválvula. Entra la clave de AEMET y el código INE; sale el riego y el registro.

## Cómo usarla

1. Pide la clave de AEMET OpenData y el código INE de tu municipio
2. Instala sensores de humedad capacitivos
3. Define los minutos por tramo de humedad
4. Revisa el riego una semana antes de dejarlo automático

## Cuándo usarla

Cuando riegues con programador de reloj y sigas regando el día que llueve o te quedes corto en una ola de calor.

## Cómo ganar dinero con ella

Baja el consumo de agua entre un 25 y un 40% frente a un programador fijo, y evita perder plantel por exceso o falta de riego.

- Riego inteligente para viveros y huertos que quieren gastar menos agua sin perder plantas.
- Instalación de sensores de humedad para jardines de comunidades con riego programado.
- Mantenimiento mensual del sistema de riego para campos de golf pequeños o zonas verdes municipales.

**Precio orientativo:** 300–550 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada mañana consulta la previsión de tu municipio en AEMET (temperatura máxima, humedad, probabilidad de lluvia) y lee la humedad del suelo de tus sensores.
Con eso calcula los minutos de riego de la tarde, abre la electroválvula el tiempo justo y apunta lo que ha regado. Si llueve o el suelo está saturado, no riega.

## Lo que necesitas antes
- Clave de AEMET OpenData: pídela gratis en `https://opendata.aemet.es/centrodedescargas/altaUsuario`, te llega por email en minutos.
- El código INE de tu municipio (5 dígitos), lo buscas en la web del INE o en la propia documentación de AEMET.
- Un sensor de humedad de suelo capacitivo (no resistivo, se corroen) conectado a un ESP32 con ESPHome, 12-20 € por punto.
- Una electroválvula de 24 V o 12 V con su transformador y un relé: Shelly Plus 1 (20 €) o el propio ESP32 con módulo relé.
- n8n auto-alojado en la red del riego y un bot de Telegram.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 8 * * *`, zona Europe/Madrid.
2. **HTTP Request** «AEMET paso 1» — GET a `https://opendata.aemet.es/opendata/api/prediccion/especifica/municipio/diaria/28079`, con Header `api_key` y tu clave. Devuelve un JSON con un campo `datos` que es otra URL.
3. **HTTP Request** «AEMET paso 2» — GET a `{{ $json.datos }}`. Aquí sí vienen los datos. Es una API en dos pasos, no te la saltes.
4. **HTTP Request** «humedad suelo» — GET a `http://192.168.1.90/sensor/humedad_suelo` (ESPHome web server) o al endpoint que expongas.
5. **Code** — calcula los minutos de riego. Código abajo.
6. **IF** — `{{ $json.minutos }}` mayor que `0`.
7. **HTTP Request** «abrir» — GET `http://192.168.1.91/rpc/Switch.Set?id=0&on=true`.
8. **Wait** — Resume «After Time Interval», `{{ $json.minutos }}` Minutes.
9. **HTTP Request** «cerrar» — la misma URL con `on=false`.
10. **HTTP Request** «verificar» — GET `http://192.168.1.91/rpc/Switch.GetStatus?id=0` y un **IF** que compruebe que `output` es `false`; si sigue abierta, Telegram de emergencia.
11. **Google Sheets** — «Append» en hoja «riegos»: fecha, minutos, litros_estimados, tmax, lluvia_pct, humedad_suelo, motivo.
12. **Telegram** — `🌱 Hoy riego {{ $json.minutos }} min ({{ $json.motivo }}). Máxima prevista {{ $json.tmax }} ºC, lluvia {{ $json.lluvia_pct }}%.`

## El trozo de código (nodo Code, paso 5)
```javascript
const BASE_MIN = 12;        // minutos en un día normal de 22 ºC
const MAX_MIN = 35;
const prevision = $('AEMET paso 2').first().json[0].prediccion.dia[0];
const tmax = Number(prevision.temperatura.maxima);
const humedadAire = Number(prevision.humedadRelativa?.maxima ?? 60);
const lluvia = Math.max(...(prevision.probPrecipitacion || []).map(p => Number(p.value) || 0), 0);
const suelo = Number($('humedad suelo').first().json.value ?? 50); // 0 seco, 100 empapado
let minutos = BASE_MIN;
let motivo = 'riego normal';
minutos = minutos * (1 + (tmax - 22) * 0.045);
minutos = minutos * (1 + (60 - humedadAire) * 0.004);
if (suelo > 65) { minutos = 0; motivo = 'suelo aún húmedo'; }
else if (suelo > 50) { minutos = minutos * 0.5; motivo = 'suelo medio, media dosis'; }
if (lluvia >= 60) { minutos = 0; motivo = 'lluvia probable (' + lluvia + '%)'; }
else if (lluvia >= 30) { minutos = minutos * 0.5; motivo = 'lluvia posible, media dosis'; }
minutos = Math.round(Math.min(Math.max(minutos, 0), MAX_MIN));
return [{ json: {
  minutos,
  motivo,
  tmax,
  humedad_aire: humedadAire,
  lluvia_pct: lluvia,
  humedad_suelo: suelo,
  litros_estimados: minutos * 8   // ajusta 8 al caudal real de tu línea en L/min
}}];
```

## Cómo probarla
- Prueba primero los nodos 2 y 3 sueltos: si el paso 2 devuelve un 401, la clave va mal en el header; si devuelve 429, has llamado demasiadas veces.
- Cierra la llave de paso general y ejecuta el flujo entero: debes oír el clic de la válvula y ver el cierre a los X minutos.
- Mete a mano el sensor en un vaso de agua y comprueba que el flujo decide no regar.
- Mide el caudal real llenando un cubo de 10 litros y cronometrando, y corrige el 8 del código.

## Qué puede salir mal
- **Válvula que se queda abierta**: es el fallo caro. Por eso el paso 10 verifica el cierre; añade además un segundo Schedule cada hora que fuerce el cierre si detecta la válvula abierta fuera del horario de riego.
- **AEMET caída o lenta**: activa «Retry on Fail» (3 intentos) y, si aun así falla, riega los minutos base en vez de no regar. Un fallo de API no debe secarte el plantel.
- **Sensor de suelo mal calibrado**: cada sensor da valores distintos. Anota el valor en seco y en empapado y mapea a 0-100 en ESPHome con `calibrate_linear`.
- **Cortes de luz**: si el ESP32 pierde corriente con la válvula abierta, la válvula normalmente cierra sola (son normalmente cerradas). Comprueba que la tuya lo es.
- **Riego a mediodía**: no riegues entre las 12 y las 18 en verano. Mueve el Schedule a las 20:00 y usa la previsión del día siguiente.

## Cuánto cuesta
- Sensor de humedad + ESP32: 15-25 €. Shelly + electroválvula: 35-60 €. Todo una sola vez.
- AEMET OpenData: gratis, con un límite razonable de peticiones al día (una consulta diaria no lo roza).
- n8n auto-alojado, Sheets y Telegram: 0 €. En Make también entra en el plan gratuito, pero el Wait largo se lleva peor.
