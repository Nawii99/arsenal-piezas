# Control de ruido nocturno con registro de evidencias…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Mide el nivel de sonido de tu local y avisa al encargado antes de que un vecino llame a la policía, dejando además un registro horario que te sirve para defenderte.

## Qué es y qué hace

Flujo de n8n que recibe cada 10 segundos el nivel de sonido de un ESP32 con micrófono y calcula la media móvil de 5 minutos. En horario nocturno, si supera tu límite, avisa por Telegram al encargado con un mensaje escalado y guarda cada 5 minutos el nivel medio y máximo. Entra la lectura del sensor y el límite; sale la alerta y el histórico.

## Cómo usarla

1. Monta el ESP32 con micrófono INMP441
2. Calibra con un sonómetro clase 1 o 2
3. Define el límite nocturno y el aviso escalado
4. Que lo revise un profesional (normativa municipal de ruido)

## Cuándo usarla

Cuando tengas vecinos encima, un limitador que no te dice nada o quejas recurrentes por ruido en horario nocturno.

## Cómo ganar dinero con ella

Una sanción por ruido en un municipio medio va de 600 a 3.000 €. Evitar una al año ya paga el montaje mil veces.

- Control interno de ruido para bares, pubs y terrazas con vecinos cercanos.
- Instalación de medidores de nivel sonoro para locales de ocio que quieren evitar sanciones.
- Registro de ruido y evidencias para comunidades de vecinos con quejas recurrentes.

**Precio orientativo:** 250–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un micrófono con medida de nivel manda un valor cada 10 segundos. El flujo calcula la media móvil de 5 minutos y, cuando pasa de tu límite en horario nocturno, avisa por Telegram al encargado con un mensaje escalado.
Además guarda una fila por cada 5 minutos con el nivel medio y el máximo, para tener tu propio histórico si hay una denuncia.

## Lo que necesitas antes
- Un ESP32 con micrófono I2S (INMP441, 5 €) y firmware ESPHome con el componente de sonido, o un módulo de medida de sonido tipo Sound Level. Presupuesto total: 20-30 €.
- **Aviso importante**: esto no es un sonómetro homologado y no sirve como prueba pericial. Es tu sistema de alerta interno; el que vale ante la administración es un sonómetro clase 1 o 2 calibrado.
- Un sonómetro prestado o una app de móvil decente para calibrar tu sensor un rato al empezar.
- Mosquitto, n8n auto-alojado, Google Sheets, bot de Telegram con el grupo del turno de noche.

## Los nodos, en orden
1. **MQTT Trigger** — topic `local/sonido/db`. Parse JSON OFF si publicas un número suelto.
2. **Code** «buffer» — acumula lecturas en memoria estática y solo deja pasar una salida cada 5 minutos con media y máximo. Código abajo.
3. **Google Sheets** — «Append» en hoja «ruido»: fecha, hora, db_medio, db_max, franja.
4. **IF** «es horario nocturno» — expresión `{{ Number($now.format('HH')) >= 22 || Number($now.format('HH')) < 8 }}` igual a `true`.
5. **Switch** — sobre `{{ $json.db_medio }}` con tres salidas: menor de 65 (nada), entre 65 y 72 (aviso suave), mayor de 72 (aviso fuerte). Ajusta los números a la ordenanza de tu municipio, que suele estar entre 55 y 65 dBA en fachada de noche.
6. **Telegram** rama suave — `🔉 {{ $json.db_medio }} dB de media en los últimos 5 min. Baja un punto la música.`
7. **Telegram** rama fuerte — `📢 {{ $json.db_medio }} dB (pico {{ $json.db_max }}). Baja YA y cierra la puerta de la calle.` Marca «Disable Notification» en OFF para que suene.
8. Segundo flujo: **Schedule Trigger** Cron `0 10 * * *`.
9. **Google Sheets** — «Get Row(s)» de la noche anterior.
10. **Code** — resume: minutos por encima del límite, hora del peor pico, media de la noche.
11. **Gmail** — informe diario al dueño con ese resumen, para que vea si el problema es la música, la terraza o la puerta abierta.

## El trozo de código (nodo Code, paso 2)
```javascript
const VENTANA_MS = 5 * 60 * 1000;
const estado = $getWorkflowStaticData('global');
estado.buffer = estado.buffer || [];
estado.ultimo = estado.ultimo || 0;
const ahora = Date.now();
for (const item of $input.all()) {
  const valor = Number(item.json.message ?? item.json.data ?? item.json);
  if (!Number.isNaN(valor) && valor > 20 && valor < 130) estado.buffer.push({ t: ahora, v: valor });
}
estado.buffer = estado.buffer.filter(p => ahora - p.t < VENTANA_MS);
if (ahora - estado.ultimo < VENTANA_MS || estado.buffer.length < 5) return [];
estado.ultimo = ahora;
const valores = estado.buffer.map(p => p.v);
const media = valores.reduce((s,v) => s + v, 0) / valores.length;
const d = new Date();
return [{ json: {
  fecha: d.toLocaleDateString('es-ES'),
  hora: d.toLocaleTimeString('es-ES'),
  franja: d.getHours() >= 22 || d.getHours() < 8 ? 'nocturna' : 'diurna',
  db_medio: Number(media.toFixed(1)),
  db_max: Number(Math.max(...valores).toFixed(1)),
  muestras: valores.length
}}];
```

## Cómo probarla
- Con el local vacío, mide el ruido de fondo: debería rondar 35-45 dB. Si te da 70, el sensor está mal o hay un zumbido eléctrico.
- Pon música a un volumen que tú consideres el límite y anota el valor: ese es tu umbral real, mejor que un número teórico.
- Compara media hora con una app de sonómetro del móvil y aplica la corrección fija que haga falta en ESPHome (`filters: - offset: 4.5`).

## Qué puede salir mal
- **Colocación del micro**: si lo pones junto al altavoz mides el altavoz, no el local. Ponlo en el punto más cercano a los vecinos, típicamente cerca de la puerta o del techo.
- **Golpes puntuales**: un vaso roto dispara el pico. Por eso el aviso se basa en la media de 5 minutos, no en el pico.
- **Uso legal**: no publiques ni presentes estos datos como medición oficial. Sirven internamente y como indicio.
- **Personal que ignora los avisos**: manda el aviso al grupo del turno, no solo al dueño, y añade en la hoja quién estaba de turno.
- **Reinicios de n8n**: la memoria estática se pierde al reiniciar; no pasa nada, se rellena en 5 minutos.

## Cuánto cuesta
- ESP32 + micrófono I2S: 15-25 €. Un sonómetro homologado de verdad, si algún día lo necesitas: desde 400 €.
- ESPHome, Mosquitto, n8n auto-alojado, Sheets, Telegram, Gmail: 0 €.
- Con lecturas cada 10 segundos, olvídate de Make o Zapier: hace falta n8n auto-alojado.
