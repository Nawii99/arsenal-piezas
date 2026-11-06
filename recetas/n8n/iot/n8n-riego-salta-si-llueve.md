# Riego que se salta el día si va a llover (n8n + relé WiFi +…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Cada mañana n8n consulta lluvia, riega si es necesario, apaga la válvula automáticamente y te avisa por Telegram.

## Qué es y qué hace

Es una receta de n8n que cada mañana consulta la previsión de lluvia de tu ubicación, riega solo si hace falta encendiendo un relé WiFi durante los minutos elegidos y te avisa por Telegram. Si no llueve y el relé no responde, también avisa. Entra la previsión; sale el riego o el aviso.

## Cómo usarla

1. Configura ubicación, hora y minutos de riego
2. Conecta el relé WiFi
3. Prueba la válvula y el aviso en Telegram

## Cuándo usarla

Cuando ya tienes o vas a montar un riego con relé WiFi y quieres dejar de pensar en si regar o no. Vale para jardín, huerto urbano, macetas de terraza o el césped de un cliente.

## Cómo ganar dinero con ella

Automatización que puedes instalar y cobrar a comunidades, huertos y segundas residencias. El material es del cliente; tú cobras montaje, configuración y una cuota fija.

- Riego automático para huertos y jardines de comunidades pequeñas, por instalación…
- Mantenimiento mensual del riego y revisión de avisos, por mes…
- Adaptación a varias zonas de riego para una finca, por zona…

**Precio orientativo:** 120–300 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Riego que se salta el día si va a llover

Qué hace: todos los días a la hora que elijas, n8n consulta la previsión de lluvia de tu ubicación. Si va a llover lo suficiente, no riega y te lo dice. Si no, enciende la válvula durante los minutos que decidas y te confirma por Telegram. Si el relé no responde, te avisa también.

Tiempo que ahorra: dejar de regar a mano y dejar de mirar el tiempo cada mañana. Y no regar cuando ya llueve, que es agua y dinero tirados.

## Qué hace falta

- **n8n**: autoalojado (gratis, en un mini PC, Raspberry o NAS) o n8n Cloud (de pago, con prueba gratuita de días limitados; consulta el plan actual). Importante: si el relé se controla por su API local, n8n tiene que estar en la misma red WiFi que el relé. Si usas n8n Cloud, tendrás que usar la nube del fabricante del relé o una VPN casera tipo Tailscale (gratis para uso personal).
- **Relé WiFi con API local**, tipo Shelly Plus 1 o similar de segunda generación. Se controla con una simple dirección web. Precio `[a consultar]`.
- **Electroválvula de 24 V AC** con su transformador, o de 9 V a pilas con adaptador. Nunca de 230 V si no eres electricista.
- **Open-Meteo**: previsión meteorológica gratuita, sin registro ni clave, para uso no comercial. Si lo instalas cobrando a un cliente, revisa sus condiciones de uso comercial.
- **Telegram**: un bot creado con @BotFather. Gratis y sin límite práctico para este uso.

Antes de empezar apunta: la IP fija del relé en tu router (resérvala en el router para que no cambie), tu latitud y longitud (las sacas de Google Maps pulsando largo sobre tu casa), el token del bot y tu chat ID.

## Nodos, en orden

**1. Schedule Trigger (disparador)**
- Modo: Cron o intervalo diario.
- Hora: `[06:30]`. Regar temprano evita evaporación. Zona horaria: Europe/Madrid (compruébalo en los ajustes del flujo, n8n a veces arranca en UTC).

**2. HTTP Request: previsión de lluvia**
- Método: GET.
- URL: `https://api.open-meteo.com/v1/forecast?latitude=[TU_LATITUD]&longitude=[TU_LONGITUD]&daily=precipitation_sum,precipitation_probability_max&timezone=Europe%2FMadrid&forecast_days=1`
- Sin autenticación.
- Devuelve, entre otras cosas, `daily.precipitation_sum[0]` (milímetros previstos hoy) y `daily.precipitation_probability_max[0]` (probabilidad máxima en %).

**3. Edit Fields (Set): sacar los dos números**
- Campo `mm` (número): `{{ $json.daily.precipitation_sum[0] }}`
- Campo `prob` (número): `{{ $json.daily.precipitation_probability_max[0] }}`
- Campo `umbral_mm` (número): `[3]`. Orientativo: 3 mm ya mojan la tierra. Ajusta a tu planta y tu suelo.
- Campo `umbral_prob` (número): `[70]`.
- Campo `minutos_riego` (número): `[15]`.

**4. IF: ¿va a llover?**
- Condición 1: `{{ $json.mm }}` mayor o igual que `{{ $json.umbral_mm }}`.
- Condición 2: `{{ $json.prob }}` mayor o igual que `{{ $json.umbral_prob }}`.
- Combinar con OR: si se cumple cualquiera de las dos, no se riega.

**5a. Rama TRUE (llueve). Telegram: Send Message**
- Chat ID: el tuyo.
- Texto: `Hoy no riego. Previstos {{ $json.mm }} mm con {{ $json.prob }} % de probabilidad.`
- Fin de esta rama.

**5b. Rama FALSE (no llueve). HTTP Request: encender la válvula con apagado automático**
- Método: GET.
- URL: `http://[IP_DEL_RELE]/rpc/Switch.Set?id=0&on=true&toggle_after={{ $('Edit Fields').item.json.minutos_riego * 60 }}`
- Esto es la sintaxis de los Shelly de segunda generación: `toggle_after` es el número de segundos tras los cuales el propio relé se apaga solo, aunque n8n se caiga. Si tu relé es de otra marca, busca en su manual el equivalente de 'auto off' por API local.
- Opciones del nodo: timeout 10 segundos, 'Continue on fail' activado para que el error pase al siguiente nodo en vez de morir en silencio.

**6. IF: ¿ha respondido el relé?**
- Condición: `{{ $json.error }}` está vacío (o `{{ $json.was_on }}` existe, que es lo que devuelve el Shelly).

**7a. TRUE. Telegram: Send Message**
- Texto: `Riego lanzado {{ $('Edit Fields').item.json.minutos_riego }} min. Previstos {{ $('Edit Fields').item.json.mm }} mm.`

**7b. FALSE. Telegram: Send Message**
- Texto: `AVISO: el relé del riego no responde. Revisa WiFi o alimentación. No se ha regado.`

**8. Ajuste de seguridad fuera de n8n (obligatorio)**
- Entra en la app o web del relé y activa su temporizador 'Auto OFF' con el mismo valor de minutos más dos. Así tienes dos cortes: el de la orden y el del propio aparato. Si un día la válvula sigue abierta, el problema es la válvula, no el software.

## Cómo probarla sin liarla

1. Pon `minutos_riego` a un valor que equivalga a 10 segundos (cambia temporalmente la fórmula del nodo 5b a `toggle_after=10`) y ponte donde veas la salida de agua.
2. Pulsa 'Test workflow' en n8n. Debes recibir un Telegram y ver la válvula abrir y cerrar sola a los 10 segundos.
3. Fuerza la rama de lluvia: cambia `umbral_mm` a 0 y vuelve a probar. Debes recibir el mensaje de 'hoy no riego' y la válvula no debe moverse.
4. Fuerza el fallo: pon una IP falsa en el nodo 5b. Debes recibir el aviso de 'relé no responde'.
5. Devuelve todos los valores a los reales, activa el flujo y revisa al día siguiente que llegó el mensaje a la hora prevista.
6. Primera semana: mira la tierra a media mañana. Si está encharcada, baja minutos; si está seca, súbelos. El umbral de lluvia también se ajusta a ojo.

## Riesgos reales

- Válvula que se queda abierta por avería mecánica: el software no lo puede evitar. Revisa el contador de agua la primera semana y considera un contador de riego con corte por caudal si el jardín es grande.
- Corte de luz o de WiFi a la hora del riego: ese día no se riega. Si es un problema (huerto en verano), pon un segundo disparador a las `[20:00]` que compruebe si hoy ya se ha regado. Eso requiere guardar un dato entre ejecuciones (nodo de base de datos o un Google Sheet); es la siguiente mejora, no la primera versión.
- Open-Meteo es gratis para uso no comercial. Si esto va a un cliente que paga, revisa su licencia o usa la API de AEMET OpenData (gratuita con clave, datos oficiales de España, pero más engorrosa de leer).
- Si usas n8n en la nube y el relé por API local, no se van a ver. O n8n en casa, o VPN, o la API de nube del fabricante (requiere clave y cada marca la hace a su manera).
