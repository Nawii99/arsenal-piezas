# Corte automático del agua ante una fuga…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Un sensor de agua en el suelo detecta una fuga, n8n cierra la llave motorizada en segundos y te llama al móvil aunque estés dormido o de viaje.

## Qué es y qué hace

Flujo de n8n que recibe la señal de un sensor de fuga Zigbee a través de MQTT y, al detectar agua, manda cerrar una válvula motorizada con un Shelly y te avisa por Telegram y con una llamada. Quince minutos después vuelve a comprobar el sensor y te informa si sigue mojado. Entra el broker MQTT y la IP de la válvula; sale el corte y la alerta.

## Cómo usarla

1. Monta el sensor con Zigbee2MQTT y el broker Mosquitto
2. Instala la válvula con un fontanero
3. Configura el Shelly de la válvula en n8n
4. Que lo revise un profesional (fontanería e instalación)

## Cuándo usarla

Úsalo cuando tengas riesgo real de inundación: bajo del fregadero, sala de calderas, lavadora industrial, local en sótano o piso que alquilas.

## Cómo ganar dinero con ella

Una inundación de una noche en un local cuesta entre 3.000 y 15.000 € y meses de peleas con el seguro. Esto lo corta en menos de un minuto.

- Protección contra fugas para sótanos, pisos de alquiler y restaurantes con mucha agua.
- Instalación de cierre automático de agua para comunidades con salas de calderas.
- Mantenimiento anual de sensores de fuga y válvulas para gestores de inmuebles.

**Precio orientativo:** 300–600 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
En cuanto el sensor detecta agua, n8n manda cerrar la válvula motorizada, te escribe por Telegram y te hace una llamada de teléfono real (que suena aunque tengas el móvil en silencio en muchos casos). Quince minutos después vuelve a comprobar y te dice si sigue mojado.
Para dueños de locales en sótano, pisos de alquiler, restaurantes y talleres.
## Lo que necesitas antes
- Sensor de fuga Zigbee (Sonoff SNZB-05, Aqara Water Leak: 10-20 €) y una pasarela Zigbee: un Sonoff Zigbee 3.0 USB Dongle Plus (25 €) pinchado en tu Raspberry o mini PC con **Zigbee2MQTT** instalado, que trae su propio broker MQTT (Mosquitto).
- Una válvula motorizada de 1/2" o 3/4" con actuador (35-70 €) más un Shelly Plus 1 para darle corriente. Que la instale un fontanero: se monta en la entrada general de agua.
- La IP y puerto de tu broker MQTT (normalmente `mqtt://192.168.1.50:1883`) y el usuario y contraseña si lo has puesto.
- Cuenta de Twilio para la llamada: te dan saldo de prueba, y un número español cuesta unos 1-2 €/mes más céntimos por llamada. Necesitas Account SID, Auth Token y el número comprado.
- Bot de Telegram con token y chat_id.
- Nombre del sensor en Zigbee2MQTT, por ejemplo `fuga_cocina`.
## Los nodos, en orden
1. **MQTT Trigger** — credencial con tu broker. Topics: `zigbee2mqtt/fuga_cocina` (puedes poner `zigbee2mqtt/fuga_+` para varios). Options > JSON Parse Body: activado.
2. **IF** — condición Boolean: `{{ $json.water_leak }}` **is true**.
3. Rama true > **HTTP Request** «Cerrar agua» — POST `https://shelly-53-eu.shelly.cloud/device/relay/control`, Form Urlencoded: `id`, `auth_key`, `channel` = `0`, `turn` = `on`. (Si tu válvula cierra al quitar corriente, pon `off`; pruébalo antes.) En Settings activa Retry On Fail con 3 intentos y 2000 ms de espera, esto es lo más importante del flujo.
4. **Telegram** — Send Message: `🚨 FUGA DE AGUA en {{ $('MQTT Trigger').item.json.device ? $('MQTT Trigger').item.json.device.friendlyName : 'sensor' }}. He cerrado la llave general.`
5. **HTTP Request** «Llamada Twilio» — POST `https://api.twilio.com/2010-04-01/Accounts/TU_ACCOUNT_SID/Calls.json`, Authentication: Generic > Basic Auth (usuario = Account SID, contraseña = Auth Token). Body Form Urlencoded: `To` = `+34TUMOVIL`, `From` = tu número Twilio, `Twiml` = `<Response><Say language="es-ES">Atención. Fuga de agua detectada. He cerrado la llave general.</Say></Response>`.
6. **Wait** — Resource: Time Interval, 15 minutos.
7. **Telegram** — Send Message: `Recordatorio: el agua sigue CERRADA desde hace 15 min. Ábrela a mano en la app Shelly cuando esté todo revisado.`
## Cómo probarla
Con el workflow en modo test, moja los dos contactos del sensor con un dedo húmedo o un vaso: en Zigbee2MQTT verás el mensaje y en n8n saltará el trigger. Comprueba en este orden: (1) la válvula cierra de verdad y no sale agua del grifo, (2) llega el Telegram, (3) suena el móvil. Después seca el sensor y abre la llave a mano. Repite la prueba una vez al trimestre: es un sistema que solo sirve si funciona el día que hace falta.
## Qué puede salir mal
- **Falso positivo por condensación**: coloca el sensor en el suelo, no pegado a una tubería fría. Si te pasa, exige dos lecturas seguidas con un contador en un **Code**.
- **Válvula al revés**: prueba antes de dejarlo. Anota en un papel pegado a la válvula qué posición es cerrado.
- **Se queda el agua cortada y no te enteras**: el aviso a los 15 minutos es para eso. Puedes añadir otro **Wait** de 12 horas con un segundo recordatorio.
- **Twilio rechaza el número**: en España hay que registrar el remitente para SMS; para llamadas suele bastar con el número comprado. Si te lía, usa solo Telegram más una llamada de CallMeBot.
- **Se cae el broker MQTT**: si tu Raspberry se apaga, no hay detección. Añade un latido: un **Schedule Trigger** diario que compruebe que el sensor ha reportado batería en las últimas 24 h.
## Cuánto cuesta
Sensor 15 €, dongle Zigbee 25 €, válvula motorizada 50 €, Shelly 18 €, más el fontanero. Zigbee2MQTT, MQTT y Telegram son gratis y funcionan en tu red. Twilio: número unos 1,5 €/mes y unos céntimos por llamada, y solo llamarás si hay fuga de verdad.
