# Monitorización de sensores de clientes con avisos (n8n)

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Recibe lecturas de sensores, guárdalas, avisa al cliente si se sale de rango y te avisa a ti si un sensor deja de responder.

## Qué es y qué hace

Son dos flujos de n8n que reciben lecturas de sensores de un cliente, las guardan, avisan al cliente si salen de rango y te avisan a ti si un dispositivo deja de enviar datos. Entra la lectura y el umbral; sale un registro y los avisos. Cuidado si hay datos personales en las lecturas.

## Cómo usarla

1. Conecta el sensor con el webhook de n8n
2. Define umbrales y tiempo de silencio
3. Prueba la alerta de cliente y la tuya
4. Que lo revise un profesional

## Cuándo usarla

Ya tienes un sensor instalado en casa de un cliente que puede enviar datos por HTTP, y quieres avisarle cuando algo se sale de lo normal y enterarte tú si el aparato deja de dar señal.

## Cómo ganar dinero con ella

Véndelo como servicio de vigilancia mensual a clientes de riego, alarma o estación meteo, con una cuota de [TU PRECIO] por los avisos y por comprobar que los dispositivos siguen conectados. Aclara que es un aviso y no un servicio de emergencias.

- Monitorización de riego o temperatura para clientes con avisos, por instalación…
- Cuota mensual de vigilancia de dispositivos, por mes…
- Panel de lecturas para un cliente con varios sensores, por proyecto…

**Precio orientativo:** 150–400 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Monitorización de sensores de clientes con avisos

## Qué consigues

Dos flujos en n8n. El primero recibe cada lectura de un sensor, la guarda y avisa al cliente si se sale del umbral. El segundo revisa cada hora si algún dispositivo lleva demasiado tiempo sin enviar nada y te avisa a ti. Con esto vendes tranquilidad, no aparatos: 'si tu riego se queda sin señal, yo me entero antes que tú'.

## Cuentas que necesitas

- n8n: instalado en tu propio servidor o Raspberry es gratis. n8n Cloud tiene periodo de prueba y luego es de pago; [consulta el precio actual].
- Google: una cuenta normal. Google Sheets es gratis.
- Telegram: gratis. Creas un bot con @BotFather en un minuto y te da un token. Cada cliente tiene que escribir al bot una vez para que puedas obtener su chat_id.
- El dispositivo del cliente tiene que poder hacer una petición HTTP POST. Lo hacen de serie Shelly, ESPHome, Tasmota y Home Assistant. Si el sensor solo habla con la app de su fabricante y no permite webhooks, esta receta no sirve para ese sensor.

## Hoja de Google Sheets (prepárala antes)

Pestaña 'clientes': columnas cliente_id, nombre, chat_id_telegram, tipo (riego/alarma/meteo/camara), umbral_min, umbral_max, horas_sin_senal_aviso.
Pestaña 'lecturas': columnas fecha_hora, cliente_id, valor, bateria, origen.

## Flujo 1: recibir lectura y avisar al cliente

1. Webhook. Método POST, ruta por ejemplo /lectura. Autenticación: Header Auth con una clave que tú inventes; esa misma clave la pones en el dispositivo. Sin clave, cualquiera podría meterte datos falsos. El cuerpo que esperas: cliente_id, valor, bateria.
2. Set (Edit Fields). Añade fecha_hora con la expresión {{ $now.toISO() }} y copia cliente_id, valor y bateria del webhook. Aquí también pones origen = 'webhook'.
3. Google Sheets, operación Append. Documento: tu hoja. Pestaña: lecturas. Mapea las columnas con los campos del paso anterior.
4. Google Sheets, operación Get Row(s) con filtro cliente_id igual al recibido, en la pestaña clientes. Devuelve el chat_id y los umbrales de ese cliente.
5. IF. Condición: valor menor que umbral_min O valor mayor que umbral_max O bateria menor que 20. Si es un sensor de puerta de alarma, el 'valor' es 1 cuando se abre y el umbral_max será 0.
6. Telegram, rama verdadera, operación Send Message. Chat ID: el del cliente que sacaste en el paso 4. Texto sin tecnicismos: 'Hola [NOMBRE], el sensor de [TIPO] ha marcado [VALOR]. Si no lo esperabas, responde a este mensaje y lo miro.' Cambia el texto según tipo de proyecto.
7. Rama falsa: nada. No mandes mensajes 'todo bien' cada 10 minutos; el cliente silencia el bot y pierdes el canal.

## Flujo 2: detectar dispositivos mudos y avisarte a ti

1. Schedule Trigger. Cada hora.
2. Google Sheets, Get Row(s), pestaña clientes, sin filtro. Saca todos los clientes.
3. Loop Over Items (Split in Batches) para recorrer cliente a cliente.
4. Google Sheets, Get Row(s), pestaña lecturas, filtro cliente_id igual al actual. Ordena por fecha_hora descendente o coge la última fila. Si tu hoja crece mucho, cambia esto por una pestaña 'ultima_lectura' que sobrescribes en el flujo 1 con la operación Update.
5. IF. Condición: la diferencia entre ahora y fecha_hora de la última lectura, en horas, es mayor que horas_sin_senal_aviso de ese cliente. Expresión: {{ $now.diff(DateTime.fromISO($json.fecha_hora), 'hours').hours }}.
6. Telegram, rama verdadera, mensaje a TU chat_id: 'Cliente [NOMBRE] ([TIPO]) sin señal desde [FECHA]. Revisar wifi, pila o corriente.' Esto no se lo mandes al cliente todavía: primero comprueba tú si es un corte de su router o un fallo real.
7. Opcional: un tercer nodo Telegram que avise al cliente solo si lleva más de 24 horas mudo, con texto tipo 'Tu sensor lleva un día sin conectar. ¿Sigue enchufado y con wifi? Si quieres, paso a revisarlo.' Ese 'paso a revisarlo' es una visita facturable si está fuera de la cuota.

## Cómo probarlo sin liarla

1. Crea un cliente de prueba en la pestaña clientes con tu propio chat_id y umbrales absurdos (por ejemplo umbral_min 90) para forzar un aviso.
2. En el nodo Webhook pulsa 'Listen for test event'. Desde otro flujo de n8n con un nodo HTTP Request, o desde el móvil con cualquier app de peticiones HTTP, manda un POST a la URL de test con cliente_id de prueba, valor 10, bateria 50 y tu cabecera de clave.
3. Comprueba que aparece la fila en lecturas y que te llega el Telegram. Si llega la fila pero no el mensaje, el fallo está en el paso 4 (no encuentra el cliente) o en el chat_id.
4. Para el flujo 2, cambia la fecha_hora de la última lectura del cliente de prueba a hace dos días y ejecuta el flujo a mano. Debe avisarte. Devuelve la fecha a su valor.
5. Solo cuando ambos funcionen con el cliente de prueba, activa los flujos y cambia la URL de test por la URL de producción en el dispositivo del cliente.
6. Borra el cliente de prueba o ponle horas_sin_senal_aviso muy alto, o te avisará cada hora para siempre.

## Riesgos y límites, dilos al cliente

- Si el cliente se queda sin internet, el sistema no puede avisar de nada. La detección de 'sin señal' te avisa a ti, pero no le llegará a él si es su red la que ha caído. Ofrece SMS solo si tienes proveedor de pago; no lo prometas gratis.
- Tú estás guardando datos de sensores de la casa de otra persona en tu Google Sheets. Son datos personales (hábitos, presencia). Ponlo por escrito en el contrato de servicio y borra lecturas antiguas cada cierto tiempo.
- Para alarma, esto es un aviso al propietario. No es una alarma conectada a central ni a policía; eso requiere empresa de seguridad autorizada.
- Con muchos clientes, Google Sheets se hace lento y la API tiene cuotas. A partir de unas decenas de dispositivos que envíen cada pocos minutos, cambia Sheets por una base de datos (n8n trae Postgres si lo autohospedas).
