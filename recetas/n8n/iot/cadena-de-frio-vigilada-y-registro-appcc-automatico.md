# Cadena de frío vigilada y registro APPCC automático…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Vigila la temperatura de tus neveras y congeladores con sensores Zigbee baratos, avisa cuando se salen de rango y deja el registro diario firmado que te pide sanidad.

## Qué es y qué hace

Flujo de n8n que lee cada 5 minutos la temperatura de cada nevera desde sensores Zigbee a través de MQTT y la guarda en Google Sheets con fecha, hora y equipo. Si un equipo supera su rango más de 20 minutos seguidos, avisa por Telegram y el día 1 de cada mes envía por email el registro del mes anterior. Entra los sensores y el rango; sale el registro.

## Cómo usarla

1. Empareja un sensor Zigbee por equipo con Zigbee2MQTT
2. Crea la hoja de temperaturas por equipo
3. Define el rango y los 20 minutos de tolerancia
4. Que lo revise un profesional (seguridad alimentaria y APPCC)

## Cuándo usarla

Úsalo cuando tengas cámaras o neveras con producto perecedero y estés rellenando a mano la hoja de temperaturas del APPCC (o no rellenándola).

## Cómo ganar dinero con ella

Evita tirar una cámara entera de género (500-3000 € por incidente) y ahorra unos 20 minutos al día de apuntar temperaturas a mano.

- Registro APPCC automático para bares y restaurantes que hoy rellenan la hoja a mano.
- Instalación de sensores de frío y registros mensuales para carnicerías y fruterías.
- Mantenimiento de trazabilidad de temperaturas para cocinas centrales y obradores.

**Precio orientativo:** 350–700 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee cada 5 minutos la temperatura de cada nevera desde sensores Zigbee y la guarda en una hoja de cálculo con fecha, hora y equipo.
Si un equipo se pasa de su rango durante más de 20 minutos seguidos te avisa por Telegram, y el día 1 de cada mes te manda por email el registro del mes anterior listo para enseñar en una inspección.

## Lo que necesitas antes
- Un sensor de temperatura Zigbee por equipo. El Sonoff SNZB-02 o SNZB-02D cuesta 9-15 € y aguanta congelador si le pones pilas de litio.
- Un coordinador Zigbee USB (Sonoff ZBDongle-E, unos 25 €) enchufado a un mini PC, un Raspberry Pi o el mismo trasto donde corras n8n.
- Zigbee2MQTT y un broker MQTT (Mosquitto). Los dos gratis, se instalan con Docker en 20 minutos.
- n8n auto-alojado (Docker) o n8n Cloud.
- Cuenta de Google para Sheets y Gmail: en n8n se conectan con «Sign in with Google» desde Credentials, no hace falta clave de API.
- Un bot de Telegram: escribe a @BotFather, /newbot, te da un token. Escribe algo a tu bot y saca tu chat_id en https://api.telegram.org/bot<TOKEN>/getUpdates.

## Los nodos, en orden
1. **MQTT Trigger** — credencial: host de tu Mosquitto, puerto 1883, usuario y contraseña. Topic: `zigbee2mqtt/+/temperatura` si renombras los sensores, o simplemente `zigbee2mqtt/#` y filtras después. Marca «Parse JSON» = ON.
2. **Code** (modo «Run Once for All Items») — normaliza el mensaje y decide si está fuera de rango. Código completo más abajo.
3. **Google Sheets** — Operation «Append». Documento: una hoja llamada «Registro temperaturas». Columnas: fecha, hora, equipo, temperatura, humedad, bateria, estado. Mapea cada campo desde el nodo Code.
4. **IF** — condición: `{{ $json.fuera_de_rango }}` es igual a `true` (tipo Boolean). Rama true sigue; rama false termina.
5. **Redis** o, si no quieres montar Redis, **n8n Data Store / Google Sheets** con una hoja «Estado» de dos columnas (equipo, desde_cuando). Aquí guardas desde qué momento el equipo está fuera de rango, para no avisar por una lectura suelta.
6. **IF** «lleva más de 20 minutos» — condición numérica: `{{ $json.minutos_fuera }}` mayor que `20`.
7. **Telegram** — Operation «Send Message». Chat ID el tuyo. Texto: `🚨 {{ $json.equipo }} lleva {{ $json.minutos_fuera }} min a {{ $json.temperatura }} ºC (rango {{ $json.min }} a {{ $json.max }}). Revisa la puerta y el motor.`
8. En un segundo flujo, **Schedule Trigger** — «Cron», expresión `0 8 1 * *` (día 1 a las 8:00), zona horaria Europe/Madrid en Settings del workflow.
9. **Google Sheets** — Operation «Get Row(s)», con filtro por el mes anterior en la columna fecha.
10. **Convert to File** — Operation «Convert to CSV», nombre `registro-APPCC-{{ $now.minus(1,'month').format('yyyy-MM') }}.csv`.
11. **Gmail** — Operation «Send», a tu correo, asunto «Registro APPCC mes anterior», y en «Attachments» el binario del nodo anterior.

## El trozo de código (nodo Code, paso 2)
```javascript
const RANGOS = {
  'nevera-bar': { min: 0, max: 5 },
  'congelador': { min: -25, max: -16 },
  'camara-carne': { min: 0, max: 3 }
};
const salida = [];
for (const item of $input.all()) {
  const topic = item.json.topic || '';
  const equipo = topic.split('/')[1] || 'desconocido';
  const datos = item.json.message || item.json;
  const t = Number(datos.temperature);
  if (Number.isNaN(t)) continue;
  const rango = RANGOS[equipo] || { min: -50, max: 50 };
  salida.push({ json: {
    fecha: new Date().toLocaleDateString('es-ES'),
    hora: new Date().toLocaleTimeString('es-ES'),
    equipo,
    temperatura: t,
    humedad: datos.humidity ?? '',
    bateria: datos.battery ?? '',
    min: rango.min,
    max: rango.max,
    fuera_de_rango: t < rango.min || t > rango.max,
    estado: (t < rango.min || t > rango.max) ? 'FUERA DE RANGO' : 'OK'
  }});
}
return salida;
```

## Cómo probarla
- Saca un sensor de la nevera y déjalo en la encimera: en 10-15 minutos deberías ver la fila con estado FUERA DE RANGO en Sheets y, pasados los 20 minutos, el mensaje de Telegram.
- Cambia temporalmente el 20 por un 1 en el IF para no esperar tanto durante las pruebas.
- Ejecuta a mano el flujo mensual con el botón «Test workflow» y comprueba que el CSV llega con datos.

## Qué puede salir mal
- **Pilas alcalinas en congelador**: se mueren en dos semanas. Usa litio CR2032 de marca o sensores con pila AAA de litio.
- **Descarches**: toda nevera sube de temperatura al descarchar. Por eso el aviso solo salta a los 20 minutos seguidos; si te da falsos avisos, sube a 30.
- **Zona horaria**: pon Europe/Madrid en Settings del workflow o los registros saldrán en UTC y en verano irán dos horas atrasados.
- **Sensor que se cae de la red Zigbee**: añade un tercer flujo con Schedule Trigger cada hora que mire la última fila de cada equipo y avise si hace más de 90 minutos que no reporta.
- **Duplicados en Sheets**: si el sensor manda varias lecturas por minuto, pon en el Code un filtro para quedarte solo con una lectura cada 5 minutos.

## Cuánto cuesta
- Sensores: 9-15 € por equipo, una sola vez. Coordinador Zigbee: 25 €, una sola vez.
- Zigbee2MQTT, Mosquitto, n8n auto-alojado, Google Sheets, Gmail y Telegram: 0 €.
- Si no quieres montar servidor, n8n Cloud desde unos 20-24 €/mes; con MQTT necesitarás además exponer el broker, así que sale más a cuenta un mini PC de 100 € en casa.
- Alternativa Make: se puede, pero cada lectura consume una operación y con 3 sensores cada 5 minutos te comes las 1.000 gratuitas en dos días.
