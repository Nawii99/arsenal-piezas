# Alarma de temperatura en nevera y congelador…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Vigila cada 10 minutos la temperatura de tus cámaras de frío y te avisa al móvil en cuanto se sale de rango, con registro diario para el control sanitario.

## Qué es y qué hace

Consulta cada 10 minutos la sonda de temperatura de tu nevera o congelador a través de la API de Shelly Cloud y, si se sale del rango que fijas, envía un aviso por Telegram y lo registra en una hoja. Entrada: auth key y ID del dispositivo Shelly; salida: aviso y registro diario. Se monta en n8n.

## Cómo usarla

1. Saca la auth key y el servidor de Shelly Cloud
2. Anota el ID del dispositivo
3. Define el umbral de temperatura
4. Prueba con una subida a propósito

## Cuándo usarla

Úsalo cuando tengas producto perecedero (hostelería, tienda de alimentación, farmacia, laboratorio) y una avería nocturna del frío te pueda arruinar el género.

## Cómo ganar dinero con ella

Un congelador estropeado de noche son 400-2.000 € de género tirado. El aviso llega en 10 minutos en vez de a la mañana siguiente.

- Monitor de frío para un bar o restaurante con género perecedero.
- Vigilancia de temperatura para una frutería o carnicería con registro diario.
- Control de cámaras frigoríficas para una farmacia o un laboratorio pequeño.

**Precio orientativo:** 150–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Consulta cada 10 minutos la sonda de temperatura de tu nevera o congelador y, si se pasa del umbral que tú marques, te manda un aviso a Telegram y lo apunta en una hoja de cálculo. Está pensado para bares, restaurantes, fruterías, carnicerías y farmacias que no pueden permitirse enterarse tarde.

## Lo que necesitas antes
- Un sensor **Shelly H&T Gen3** (unos 25 €) o un **Shelly Plus Add-On con sonda DS18B20** metida dentro de la cámara. La sonda con cable es la buena para congeladores: el sensor entero dentro se queda sin cobertura wifi.
- Cuenta gratuita en **Shelly Cloud**. Entra en control.shelly.cloud, arriba a la derecha en tu usuario tienes **Configuración de usuario > Autorización para la nube**: ahí sacas la *auth key* y el *servidor* (por ejemplo `shelly-53-eu.shelly.cloud`).
- El **ID del dispositivo**: en la app Shelly, dentro del aparato, *Ajustes > Información del dispositivo*.
- Un bot de **Telegram**: escribe a @BotFather, `/newbot`, te da un token. Luego escríbele tú al bot y entra en `https://api.telegram.org/bot<TOKEN>/getUpdates` para ver tu `chat_id`.
- **n8n** gratis: autoalojado (Community Edition) en tu ordenador o en un Raspberry Pi con Docker. n8n Cloud solo tiene prueba gratuita temporal y después es de pago.
- Una hoja de **Google Sheets** llamada `Frio` con las columnas: `fecha`, `equipo`, `temperatura`, `humedad`, `estado`.

## Los nodos, en orden
1. **Schedule Trigger** — modo *Interval*, cada **10** minutos. En *Settings* del workflow pon la zona horaria `Europe/Madrid`.
2. **HTTP Request** — método **POST**, URL `https://TU-SERVIDOR.shelly.cloud/device/status`. En *Body Content Type* elige **Form Urlencoded** y añade dos campos: `id` con el ID del dispositivo y `auth_key` desde una credencial de n8n en lugar de escrito en el nodo (Authentication: Generic Credential Type > Custom Auth, con el JSON `{"body": {"auth_key": "tu clave"}}`): un flujo exportado se llevaría la clave.
3. **Code** — modo *Run Once for All Items*. Saca la temperatura, decide si está fuera de rango y evita que te bombardee con 6 mensajes por hora.
```js
const d = $json.data.device_status;
const temp = d['temperature:0'] ? d['temperature:0'].tC : d.tmp.value;
const hum = d['humidity:0'] ? d['humidity:0'].rh : (d.hum ? d.hum.value : null);
const MAX = -15; // congelador. Para nevera pon 8
const st = $getWorkflowStaticData('global');
const fuera = temp > MAX;
const yaAvisado = st.avisado === true;
st.avisado = fuera;
const estado = fuera ? 'ALARMA' : 'OK';
const fecha = new Date().toLocaleString('es-ES', { timeZone: 'Europe/Madrid' });
return [{ json: { temp, hum, estado, MAX, fecha, equipo: 'Congelador cocina', avisar: fuera && !yaAvisado, recuperado: !fuera && yaAvisado } }];
```
4. **Google Sheets** — operación *Append Row*, hoja `Frio`, mapea `fecha`, `equipo`, `temperatura` = `{{ $json.temp }}`, `humedad`, `estado`.
5. **IF** — condición *Boolean > is true* sobre `{{ $json.avisar || $json.recuperado }}`.
6. **Telegram** — rama *true*, operación *Send Message*, con tu `chat_id` y el texto: `{{ $json.avisar ? '🚨 ALARMA FRÍO' : '✅ Recuperado' }} — {{ $json.equipo }}: {{ $json.temp }} ºC (límite {{ $json.MAX }} ºC) a las {{ $json.fecha }}`.

## Cómo probarla
- Pulsa *Execute Workflow* y mira que el nodo HTTP devuelve `isok: true`. Si devuelve `Not authorized`, la auth key o el servidor están mal.
- Cambia temporalmente `MAX` a un número imposible (por ejemplo `-40`) y ejecuta: debe llegarte el mensaje de alarma. Vuelve a ejecutar y NO debe llegar el segundo (eso demuestra que el antirrepetición funciona). Devuelve el valor bueno.
- Prueba de verdad: saca la sonda de la cámara 15 minutos y espera el aviso.

## Qué puede salir mal
- **La sonda pierde el wifi dentro del congelador.** Usa la versión con cable y deja el módulo fuera. Si aun así se cae, añade un segundo **IF** que avise cuando la última lectura tenga más de 30 minutos (`d.tmp.is_valid === false`).
- **Te llueven mensajes.** Ya lo resuelve el `staticData`, pero si reinicias n8n se pierde ese estado y te llegará un aviso extra. Es aceptable.
- **Falsos positivos al abrir la puerta.** Un congelador sube 3-4 ºC al cargarlo. Pon el umbral con margen (-15 en vez de -18) o exige dos lecturas seguidas fuera de rango guardando un contador en `st.fallos`.
- **Horario de verano.** Fija `Europe/Madrid` en los ajustes del workflow, no uses la hora del servidor.
- **Límite de la API de Shelly Cloud:** 1 petición por segundo. Cada 10 minutos vas sobradísimo.

## Cuánto cuesta
El sensor Shelly, 20-35 € una vez. Shelly Cloud, Telegram, Google Sheets y n8n auto-alojado: **0 €**. Si prefieres no montar servidor, n8n Cloud (de pago tras la prueba gratuita) son unos 20 €/mes; en Make esto son unas 4.300 operaciones al mes, o sea plan de 9 €/mes.
