# Control de CO2 y ventilación con informe semanal…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Mide el CO2 de tu local o aula, avisa cuando hay que ventilar y te deja un informe semanal con las horas en las que el aire estaba peor. Para academias, gimnasios y salas de reuniones.

## Qué es y qué hace

Flujo de n8n que recibe por MQTT cada minuto la medida de un sensor de CO2 NDIR y avisa por Telegram cuando supera 900 ppm para ventilar y, si pasa de 1.400 ppm, insiste cada 10 minutos. Cada lunes envía un informe con la media por franja, los minutos sobre umbral y los peores días. Entra el topic MQTT y los umbrales; sale el aviso y el informe.

## Cómo usarla

1. Flashea el sensor con ESPHome
2. Configura el topic MQTT en el flujo
3. Define los umbrales de 900 y 1.400 ppm
4. Que lo revise un profesional (salud laboral y ventilación)

## Cuándo usarla

Cuando trabajes con gente dentro de un espacio cerrado y quieras demostrar (a clientes o a una inspección) que ventilas de verdad.

## Cómo ganar dinero con ella

Ventilar solo cuando hace falta, en vez de tener ventanas abiertas todo el día, baja la factura de calefacción o aire un 10-20% en invierno.

- Monitorización de calidad del aire para academias y salas de reuniones con mucha gente.
- Instalación de sensores de CO2 para gimnastios, peluquerías y talleres con personal fijo.
- Informe mensual de ventilación para empresas que quieren justificar el control del aire interior.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un sensor de CO2 publica una medida cada minuto. Cuando pasa de 900 ppm avisa al encargado por Telegram para que ventile, y si pasa de 1.400 ppm insiste cada 10 minutos.
Cada lunes te manda un informe con la media por franja horaria, cuántos minutos se superó el umbral y qué días fueron peores.

## Lo que necesitas antes
- Un sensor de CO2 de verdad (NDIR), no de los baratos que estiman por VOC. Opciones: Sensirion SCD40/SCD41 con un ESP32 (unos 30 € en total, montado con ESPHome sin soldar casi nada) o un Aqara/Qingping CO2 comercial (60-90 €).
- ESPHome (gratis) para flashear el ESP32 desde el navegador en web.esphome.io, y su integración por API o MQTT.
- Mosquitto (broker MQTT) y n8n auto-alojado.
- Google Sheets y un bot de Telegram, con el chat del grupo del equipo.

## Los nodos, en orden
1. **MQTT Trigger** — topic `casa/salon/co2/state` (el que configures en ESPHome). Parse JSON según cómo publiques; con ESPHome lo normal es un número en texto plano, así que deja Parse JSON en OFF.
2. **Code** «normalizar» — convierte a número, añade timestamp y clasifica: bueno (<800), regular (800-1200), malo (>1200).
3. **Google Sheets** — «Append» en hoja «co2»: fecha, hora, ppm, nivel.
4. **IF** — `{{ $json.ppm }}` mayor que `900`.
5. **Google Sheets** — «Lookup» en hoja «estado» fila «ultimo_aviso», para saber cuándo avisaste por última vez.
6. **IF** — han pasado más de 10 minutos desde el último aviso: `{{ $now.diff($json.ultimo_aviso, 'minutes') }}` mayor que `10`.
7. **Telegram** — `🪟 CO2 en {{ $json.sala }}: {{ $json.ppm }} ppm. Abre ventanas 5 minutos.` Si supera 1400 usa un **Switch** previo para mandar otro texto más contundente.
8. **Google Sheets** — «Update Row» de estado con la hora del aviso.
9. Segundo flujo: **Schedule Trigger** — Cron `0 8 * * 1`.
10. **Google Sheets** — «Get Row(s)» de la hoja «co2» de los últimos 7 días.
11. **Code** «informe» — agrupa por franja horaria y por día. Código abajo.
12. **Gmail** — «Send» con el texto del informe en HTML.

## El trozo de código (nodo Code, paso 11)
```javascript
const UMBRAL = 900;
const filas = $input.all().map(i => i.json).filter(f => f.ppm);
const franjas = {};
const dias = {};
let minutosMalos = 0;
for (const f of filas) {
  const ppm = Number(f.ppm);
  const h = Number(String(f.hora).slice(0,2));
  franjas[h] = franjas[h] || { suma: 0, n: 0 };
  franjas[h].suma += ppm;
  franjas[h].n++;
  dias[f.fecha] = dias[f.fecha] || { max: 0, malos: 0 };
  if (ppm > dias[f.fecha].max) dias[f.fecha].max = ppm;
  if (ppm > UMBRAL) { dias[f.fecha].malos++; minutosMalos++; }
}
const porFranja = Object.entries(franjas).map(([h,v]) => ({ hora: h + ':00', media: Math.round(v.suma / v.n) })).sort((a,b) => b.media - a.media);
const porDia = Object.entries(dias).map(([d,v]) => ({ dia: d, maximo: v.max, minutos_malos: v.malos })).sort((a,b) => b.maximo - a.maximo);
const html = '<h3>Calidad del aire, última semana</h3>' +
  '<p>Minutos por encima de ' + UMBRAL + ' ppm: <b>' + minutosMalos + '</b></p>' +
  '<p>Peor franja horaria: <b>' + porFranja[0].hora + '</b> con ' + porFranja[0].media + ' ppm de media</p>' +
  '<p>Peor día: <b>' + porDia[0].dia + '</b> con pico de ' + porDia[0].maximo + ' ppm</p>' +
  '<ul>' + porFranja.slice(0,5).map(f => '<li>' + f.hora + ': ' + f.media + ' ppm</li>').join('') + '</ul>';
return [{ json: { minutos_malos: minutosMalos, html, peor_dia: porDia[0].dia } }];
```

## Cómo probarla
- Echa el aliento cerca del sensor 30 segundos: verás subir el valor por encima de 2.000 ppm y saltar el aviso.
- Deja el sensor en la calle una mañana: debe marcar entre 400 y 450 ppm. Si marca 800 en la calle, está descalibrado; los SCD4x se autocalibran solos si los dejas ventilados unos días.
- Lanza el informe a mano con «Test workflow» aunque solo tengas dos días de datos.

## Qué puede salir mal
- **Sensores de VOC vendidos como CO2**: los de menos de 20 € no miden CO2, lo estiman. No los uses si el dato tiene que servirte ante nadie.
- **Aviso pesado**: sin el control de los 10 minutos el grupo de Telegram se llena. Empieza en 15 minutos y baja si hace falta.
- **Sensor mal colocado**: ni al lado de la puerta ni encima de una cabeza. A 1,2-1,5 m de altura, lejos de corrientes.
- **Horario de cierre**: filtra en el Code las horas en las que el local está vacío, o el informe saldrá diluido.

## Cuánto cuesta
- ESP32 + SCD41: 25-35 €. Comercial Zigbee/wifi: 60-90 €.
- ESPHome, Mosquitto, n8n auto-alojado, Sheets, Gmail, Telegram: 0 €.
- En Make, una lectura por minuto se sale del plan gratis; publica cada 5 minutos o solo cuando cambie más de 50 ppm.
