# CO2 y ventilación: avisa al personal antes de que el ai…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Vigila el CO2 del local y, cuando sube, enciende el extractor y manda un aviso al grupo del personal para que abran; al final del día te pasa la gráfica.

## Qué es y qué hace

Un sensor SCD40 o SCD41 sobre un ESP32 publica el CO2 cada minuto por MQTT. n8n enciende el extractor cuando supera 1.000 ppm durante cinco minutos, lo apaga por debajo de 800 ppm y avisa al grupo del personal para ventilar. Al final del día genera una gráfica con las horas peores. Pensado para aulas, gimnasios, peluquerías y restaurantes pequeños.

## Cómo usarla

1. Monta el sensor a 1,5 m, lejos de la puerta
2. Publica el CO2 en MQTT desde ESPHome
3. Define en n8n los umbrales de encendido y apagado
4. Activa el aviso y la gráfica diaria

## Cuándo usarla

Cuando tengas un local con gente dentro: consulta, aula, gimnasio, sala de reuniones, peluquería o restaurante pequeño donde el aire se carga y no te enteras.

## Cómo ganar dinero con ella

Un local con 1.500 ppm de CO2 baja la concentración y el humor del cliente.

- Instalación de medición de CO2 y control de extractor para gimnasios, aulas o peluquerías, con puesta en marcha.
- Informe semanal de calidad del aire por local para cadenas pequeñas o coworkings, por cuota.
- Kit de sensor y relé para vender a reformistas que equipan locales de cara al público.

**Precio orientativo:** 200–400 € por local. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un sensor SCD40 o MH-Z19 publica el CO2 cada minuto. n8n vigila: al pasar de 1.000 ppm durante 5 minutos seguidos, enciende el extractor y avisa al grupo del personal. Al bajar de 800 ppm lo apaga. A las 22:00 manda una gráfica del día con las horas peores.
Para negocios de cara al público en locales pequeños.

## Lo que necesitas antes
- Sensor SCD40 o SCD41 (25-35 €, mide CO2 de verdad; huye de los sensores «de calidad de aire» que estiman el CO2 y no valen nada) sobre un ESP32 con ESPHome.
- En ESPHome, bloque `mqtt:` publicando en `local/aire/co2`. Coloca el sensor a 1,5 m de altura, lejos de la puerta y de donde la gente respire directamente.
- Broker MQTT: Mosquitto en el mismo equipo que n8n, o HiveMQ Cloud gratuito.
- Shelly Plus 1 conectado al extractor (192.168.1.95). Si el extractor va a 230 V y más de 10 A, usa contactor.
- Bot de Telegram con un grupo donde esté el personal, y una hoja «Aire» en Google Sheets.

## Los nodos, en orden (workflow 1: control)
1. **MQTT Trigger**: topic `local/aire/co2`, QoS 0.
2. **Google Sheets** (Append): guarda hora y ppm en la hoja «Aire».
3. **Google Sheets** (Read, 1 fila, hoja «EstadoAire»): trae `contador_alto`, `contador_bajo`, `extractor`.
4. **Code** «Histéresis CO2».
5. **IF**: `{{ $json.accion }}` is not equal to `nada`.
6. → **Switch** (Rules sobre `{{ $json.accion }}`): salida `ventilar` y salida `parar`.
7. Salida ventilar → **HTTP Request** ON al Shelly → **Telegram**: `💨 CO2 a {{ $json.ppm }} ppm. Abrid la puerta o una ventana cinco minutos, por favor.`
8. Salida parar → **HTTP Request** OFF al Shelly.
9. Ambas → **Google Sheets** (Update, hoja «EstadoAire»).

## El trozo de código (nodo Code, «Histéresis CO2»)
```js
const ALTO = 1000; const BAJO = 800; const CICLOS = 5;
const ppm = Number($('MQTT Trigger').first().json.message);
const e = $('Google Sheets1').first().json;
let alto = Number(e.contador_alto || 0); let bajo = Number(e.contador_bajo || 0);
const on = String(e.extractor) === 'true';
alto = ppm > ALTO ? alto + 1 : 0;
bajo = ppm < BAJO ? bajo + 1 : 0;
let accion = 'nada'; let nuevo = on;
if (!on && alto >= CICLOS) { accion = 'ventilar'; nuevo = true; alto = 0; }
if (on && bajo >= CICLOS) { accion = 'parar'; nuevo = false; bajo = 0; }
return [{ json: { ppm, accion, contador_alto: alto, contador_bajo: bajo, extractor: nuevo } }];
```

## Workflow 2: gráfica diaria
1. **Schedule Trigger**: Cron `0 22 * * *`.
2. **Google Sheets** (Read, filtrando el día de hoy).
3. **Code**: monta la URL de QuickChart, por ejemplo `https://quickchart.io/chart?c={type:'line',data:{labels:[...],datasets:[{label:'CO2',data:[...]}]}}` con los valores codificados con `encodeURIComponent`.
4. **HTTP Request** con Response Format: File.
5. **Telegram** (Operation: Send Photo) con la imagen.

## Cómo probarla
- Sopla cerca del sensor un minuto: el CO2 sube a 2.000 ppm en segundos. A los 5 minutos con el valor alto debe encenderse el extractor.
- Sal de la sala y espera: al bajar de 800 debe apagarse.
- Si el sensor marca 400-420 ppm al aire libre, está bien calibrado. Si marca 700 en la calle, actívale la autocalibración (`automatic_self_calibration: true`) y déjalo una semana.

## Qué puede salir mal
- **Avisos a deshora**: añade un nodo IF que descarte mensajes fuera del horario del local (por ejemplo, solo entre 9:00 y 21:00). El extractor puede seguir funcionando sin avisar.
- **Sensor recién estrenado**: los SCD4x necesitan unos días para calibrarse. No te fíes de la primera semana.
- **Corrientes de aire**: si lo pones junto a la puerta, siempre marcará 450 ppm y no te enterarás de nada.
- **MQTT desconectado**: el MQTT Trigger de n8n a veces no reconecta solo tras un reinicio del broker. Añade un Schedule Trigger cada hora que compruebe en Sheets que ha entrado algún dato en los últimos 15 minutos.

## Cuánto cuesta
Software y QuickChart (uso básico) gratis. Sensor y ESP32: 45-60 €. Shelly 25 €. Extractor, si no lo tienes, 60-150 €.
