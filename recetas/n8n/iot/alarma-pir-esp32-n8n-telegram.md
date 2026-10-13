# Alarma de presencia: PIR + ESP32 avisa por Telegram con n8n…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

El sensor detecta movimiento, n8n comprueba el horario de la alarma y te avisa por Telegram con la hora y el sensor.

## Qué es y qué hace

Es una receta de n8n junto a un sensor PIR y un ESP32: cuando detecta movimiento avisa por webhook, n8n comprueba el horario de la alarma y manda un mensaje por Telegram con la hora y el sensor, con foto si hay ESP32-CAM. No sustituye a una central receptora.

## Cómo usarla

1. Conecta el sensor PIR con la ESP32
2. Configura el horario en n8n
3. Prueba el aviso en Telegram
4. Que lo revise un profesional

## Cuándo usarla

Quieres que el móvil te avise cuando salte el sensor de movimiento del trastero, el garaje o una casa vacía, solo en las horas en que la alarma está armada.

## Cómo ganar dinero con ella

Instálalo como aviso casero a particulares y pequeños locales que no quieren una alarma con central, y cobra la instalación más una cuota mensual de [TU PRECIO]. Deja por escrito que no sustituye a una alarma con central receptora.

- Avisos de presencia para locales pequeños sin alarma profesional, por instalación…
- Mantenimiento mensual de avisos y sensores, por mes…
- Ampliación con foto para viviendas que lo piden, por instalación…

**Precio orientativo:** 100–250 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Alarma de presencia: sensor PIR + ESP32 → n8n → aviso en Telegram

## Qué hace
Cuando el sensor detecta movimiento, la ESP32 avisa a n8n por webhook. n8n mira si la alarma está armada (por horario) y, si lo está, te manda un mensaje a Telegram con la hora y el sensor. Si tienes cámara ESP32-CAM, puede adjuntar una foto. No sustituye a una alarma con central receptora: te avisa a ti y nadie más va a hacer nada.

## Qué necesitas
- ESP32 con sensor PIR HC-SR501 (3 cables: VCC a VIN/5V, GND a GND, OUT a GPIO 27). Precio: [consultar].
- n8n. Gratis si lo instalas tú (Docker en un PC, mini-PC o Raspberry Pi que esté siempre encendido). n8n Cloud tiene prueba gratuita de [X días] y luego es de pago. Si n8n corre en tu casa, la ESP32 le llega por IP local sin abrir nada a internet; es lo recomendable.
- Cuenta de Telegram y un bot creado con @BotFather (gratis, sin límite práctico para esto). Guarda el token.
- Tu chat_id de Telegram: escribe algo a tu bot y abre en el navegador `https://api.telegram.org/bot<TOKEN>/getUpdates`; el número que aparece en `chat.id` es el tuyo.

## Lado ESP32 (antes de n8n)
Pide a Claude Code un sketch que conecte al WiFi, lea el pin del PIR y, cuando pase de 0 a 1, haga un HTTP POST a la URL del webhook con el JSON `{"sensor":"salon","evento":"movimiento","clave":"[PALABRA_LARGA]"}`. Dos reglas dentro del sketch: no enviar más de un aviso por minuto (el PIR dispara varias veces seguidas) y esperar 60 segundos tras encender antes de leer (el PIR da falsos positivos al arrancar).

## Nodos, en orden

### 1. Webhook (disparador)
- HTTP Method: POST. Path: `alarma`.
- Respond: Immediately. La ESP32 no debe quedarse esperando.
- Copia la Production URL: es la que va en el sketch.

### 2. IF — "¿Clave correcta?"
- Condición (String): `{{ $json.body.clave }}` is equal to `[PALABRA_LARGA]`.
- Salida false: no conectes nada. Así una URL filtrada no te llena el móvil de falsas alarmas.

### 3. Set — "Datos limpios"
- `sensor` = `{{ $json.body.sensor }}`
- `hora` = `{{ $now.setZone('Europe/Madrid').toFormat('HH:mm:ss') }}`
- `fecha` = `{{ $now.setZone('Europe/Madrid').toFormat('dd/MM/yyyy') }}`

### 4. IF — "¿Está armada?"
Versión básica: armada por horario nocturno. Dos condiciones (Number) unidas con OR:
- `{{ $now.setZone('Europe/Madrid').hour }}` is greater than or equal to `[HORA_INICIO, p. ej. 23]`
- `{{ $now.setZone('Europe/Madrid').hour }}` is less than `[HORA_FIN, p. ej. 7]`
Salida true: sigue. Salida false: sin conectar; el flujo muere en silencio.
Cuando quieras armar y desarmar desde el móvil, cambia este IF por una lectura de una celda de Google Sheets ("ARMADA"/"DESARMADA") que modificas con otro flujo de Telegram Trigger. Empieza por el horario; es lo que menos falla.

### 5. Telegram — "Enviar aviso"
- Credencial: el token del bot. Operation: Send Message.
- Chat ID: el tuyo.
- Text: `Movimiento en {{ $json.sensor }} a las {{ $json.hora }} del {{ $json.fecha }}`
- Disable Notification: desactivado. Quieres que suene.

### 6. (Opcional) HTTP Request + Telegram — "Foto"
Solo si tienes la ESP32-CAM montada. HTTP Request: GET a `http://[IP_CAMARA]/capture`, Response Format: File. Después, otro nodo Telegram con Operation: Send Photo y el campo binario. Va después del aviso de texto y no antes: si la cámara tarda o falla, el aviso ya ha salido.

## Cómo probarla sin liarla
1. Con el flujo abierto, pulsa "Listen for test event" en el Webhook y copia la Test URL.
2. Desde Claude Code o una terminal: `curl -X POST [TEST_URL] -H "Content-Type: application/json" -d '{"sensor":"prueba","evento":"movimiento","clave":"[PALABRA_LARGA]"}'`. Debe llegarte el Telegram si estás dentro del horario. Si no lo estás, cambia temporalmente el IF de horario para que siempre pase y déjalo bien al terminar.
3. Repite el curl con una clave equivocada: no debe llegar nada.
4. Activa el flujo (interruptor arriba a la derecha). A partir de aquí solo funciona la Production URL.
5. Pon la Production URL en el sketch, súbelo y pasa la mano por delante del PIR. El aviso debería tardar un par de segundos.
6. Déjalo armado una noche con Disable Notification activado (para no despertarte) y mira por la mañana cuántos avisos hay. Si son muchos sin que haya pasado nadie: baja la sensibilidad con el potenciómetro del PIR, aléjalo de radiadores y ventanas con sol y ponlo donde no pasen las mascotas. Después vuelve a activar el sonido.

## Riesgos y límites
- Si se va la luz o el WiFi, no hay aviso y nada te lo dice. Si quieres saberlo, añade otro flujo con Schedule Trigger cada 10 minutos que compruebe un "latido" de la ESP32 y te avise si no ha llegado.
- Si n8n está en la nube, la URL del webhook es pública. Por eso existe el nodo 2. No lo quites.
- Esto no es una alarma homologada: ningún seguro lo va a considerar como tal, y nadie va a ir a tu casa cuando suene.
