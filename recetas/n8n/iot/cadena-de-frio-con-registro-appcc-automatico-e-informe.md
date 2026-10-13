# Cadena de frío con registro APPCC automático e informe…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Registra cada 10 minutos la temperatura de tus neveras y congeladores, avisa si se salen de rango de forma sostenida y genera el informe mensual en PDF que te pide Sanidad.

## Qué es y qué hace

Lee cada 10 minutos la temperatura de neveras y congeladores desde sondas DS18B20 conectadas a un ESP32 por MQTT. Entran lecturas de temperatura y salen un registro en hoja de cálculo, avisos por Telegram ante tres lecturas seguidas fuera de rango y un PDF mensual para el archivo de APPCC. Pensado para hostelería y obradores, con n8n y un broker Mosquitto o HiveMQ.

## Cómo usarla

1. Monta un ESP32 con ESPHome por equipo
2. Publica en MQTT y guarda en hoja en n8n
3. Configura los avisos de rango sostenido y el PDF mensual
4. Que lo revise un profesional

## Cuándo usarla

Cuando tengas hostelería, obrador, carnicería, farmacia o cualquier negocio obligado a llevar registros de temperatura y ahora los rellenéis a mano en una hoja.

## Cómo ganar dinero con ella

Ahorra 15-20 minutos diarios de anotaciones, evita perder género (una cámara parada un fin de semana son 300-2.000 €) y te quita las sanciones por registros incompletos.

- Instalación de sondas y registro de temperaturas para bares y restaurantes, con puesta en marcha y formación de una hora.
- Vigilancia mensual y generación del informe de temperaturas para obradores y tiendas de alimentación, por cuota.
- Kit de sondas y panel de avisos para carnicerías o farmacias que deben llevar registros de temperatura.

**Precio orientativo:** 400–900 € por local (instalación). *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un ESP32 con sondas de temperatura publica cada pocos minutos por MQTT la temperatura de cada equipo. n8n lo guarda en una hoja de cálculo, avisa por Telegram si un equipo lleva tres lecturas seguidas fuera de rango, y el día 1 de cada mes exporta la hoja del mes anterior en PDF y te la manda por correo lista para el archivo de APPCC.
Para bares, restaurantes, obradores y tiendas de alimentación.

## Lo que necesitas antes
- Un ESP32 (o varios) con sondas DS18B20 estancas, una por equipo (sonda 4-8 €). Mételas dentro de un bote pequeño con glicerina o agua: así miden la temperatura del producto y no los picos por abrir la puerta.
- ESPHome configurado con `mqtt:` apuntando a un broker. Broker gratis: Mosquitto en el mismo Raspberry Pi que n8n, o HiveMQ Cloud plan gratuito.
- Topics tipo `local/frio/camara1`, `local/frio/congelador`, publicando el valor en grados.
- n8n con credencial MQTT (host, puerto 1883, usuario y contraseña).
- Una hoja de Google Sheets «RegistroFrio» con columnas: fecha, hora, equipo, temperatura, rango, estado.
- Bot de Telegram con el grupo del personal, y credencial de Google Drive en n8n.

## Los nodos, en orden (workflow 1: registro y alarma)
1. **MQTT Trigger**: Topics `local/frio/#`, QoS 1.
2. **Code** «Normalizar»: saca el nombre del equipo del topic y decide el rango permitido.
3. **Google Sheets** (Append): añade la lectura a «RegistroFrio».
4. **IF**: `{{ $json.fuera }}` is true.
5. Rama true → **Google Sheets** (Read, hoja «RegistroFrio», Return All) → **Code** «Confirmar»: cuenta si las 3 últimas lecturas de ESE equipo están fuera de rango y si ya se avisó en la última hora.
6. → **IF** `{{ $json.avisar }}` is true → **Telegram**: `⚠️ {{ $json.equipo }} lleva 30 minutos a {{ $json.temperatura }} ºC (máximo {{ $json.max }} ºC). Revisa la puerta y el motor.`

## El trozo de código (nodo Code, «Normalizar»)
```js
const RANGOS = { camara1: { min: 0, max: 4 }, congelador: { min: -25, max: -18 }, expositor: { min: 0, max: 6 } };
const topic = $json.topic || '';
const equipo = topic.split('/').pop();
const temperatura = Number($json.message ?? $json.value);
const rango = RANGOS[equipo] || { min: -99, max: 99 };
const fuera = temperatura < rango.min || temperatura > rango.max;
const ahora = new Date().toLocaleString('es-ES', { timeZone: 'Europe/Madrid' });
return [{ json: { equipo, temperatura, min: rango.min, max: rango.max, fuera, fecha: ahora.split(',')[0], hora: ahora.split(',')[1].trim() } }];
```

## Workflow 2: informe mensual en PDF
1. **Schedule Trigger**: Cron `0 8 1 * *` (día 1 a las 8:00).
2. **HTTP Request** «Exportar PDF»: GET a `https://docs.google.com/spreadsheets/d/ID_DE_TU_HOJA/export?format=pdf&gid=0&portrait=false`, Authentication: Predefined Credential Type → Google Sheets OAuth2, Response Format: File.
3. **Google Drive** (Upload): guarda el archivo en una carpeta «APPCC» con nombre `Registro-{{ $now.minus(1, 'month').toFormat('yyyy-MM') }}.pdf`.
4. **Gmail** (Send): te lo manda a ti y al asesor con el PDF adjunto.

## Cómo probarla
- Saca una sonda de la nevera y déjala en la barra: a los 30 minutos debe llegarte el aviso de Telegram y no antes (así compruebas el antirrebote).
- Comprueba que abrir la puerta cinco minutos NO dispara la alarma. Si lo hace, sube el número de lecturas seguidas a 4 o mete la sonda en glicerina.
- Ejecuta el workflow 2 a mano y abre el PDF: tiene que ser legible y contener el mes entero.

## Qué puede salir mal
- **Congelación de la sonda o cable roto**: si un equipo deja de publicar, no salta ninguna alarma porque no llega nada. Añade un Schedule Trigger cada 2 horas que compruebe en Sheets que cada equipo ha reportado en la última hora, y avise si no.
- **Duplicados**: si el ESP32 se reinicia en bucle, puede llenar la hoja. Limita en ESPHome la frecuencia con `update_interval: 600s`.
- **Límite de Google Sheets**: 10 millones de celdas, pero por rendimiento crea una hoja nueva por año.
- **Valor legal**: un registro automático suele aceptarse, pero pregunta a tu asesor de APPCC si tu comunidad exige firma o verificación manual periódica; en ese caso añade una casilla de «verificado por» semanal.

## Cuánto cuesta
Software 0 €. Hardware: 25 € el ESP32 más 6-8 € por sonda; para 4 equipos, unos 55 €. Broker MQTT gratis autoalojado.
