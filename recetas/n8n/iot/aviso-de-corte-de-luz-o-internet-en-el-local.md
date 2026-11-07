# Aviso de corte de luz o internet en el local…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Vigila desde fuera si tu local sigue con corriente e internet y te manda un aviso a Telegram en menos de cinco minutos cuando algo se cae.

## Qué es y qué hace

Flujo de n8n que cada 5 minutos pregunta a la nube de Shelly si un enchufe inteligente del local sigue conectado. Si deja de responder dos veces seguidas, te envía un aviso a Telegram y otro cuando vuelve, y lo apunta en una hoja de cálculo. Entra la auth_key de la nube y el ID del dispositivo; sale el aviso y el registro de caídas. Útil en locales sin personal por la noche.

## Cómo usarla

1. Vincula el enchufe Shelly y copia la auth_key y el servidor
2. Rellena el ID del dispositivo en el flujo
3. Crea el bot de Telegram
4. Prueba desconectando el enchufe un minuto

## Cuándo usarla

Úsalo cuando tengas un local desatendido por la noche o en fines de semana con neveras, cámaras o servidores que no pueden quedarse parados sin que te enteres.

## Cómo ganar dinero con ella

Un corte nocturno en una cámara frigorífica se lleva cientos de euros de género. Enterarte a los 5 minutos en vez de a las 8 horas evita esa pérdida.

- Vigilancia de locales desatendidos para bares, obradores o tiendas que dejan equipos encendidos.
- Instalación y configuración de avisos de corte para pequeños negocios con neveras o cámaras.
- Servicio mensual de monitorización de conectividad para comunidades y naves con equipos críticos.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada 5 minutos pregunta a la nube de Shelly si el enchufe inteligente que tienes en el local sigue conectado. Si deja de responder dos veces seguidas te manda un mensaje a Telegram, y otro cuando vuelve, y apunta todo en una hoja de cálculo.
Pensado para bares, obradores, tiendas y talleres pequeños que dejan equipos funcionando solos fuera del horario.
## Lo que necesitas antes
- Un enchufe Shelly Plus Plug S (unos 20 €) enchufado en el local y vinculado a la app Shelly (cuenta gratis). Da igual lo que enchufes: lo que vigilamos es que él esté vivo.
- La clave de la nube: app Shelly > Ajustes de usuario > Autorización nube de control > Obtener clave. Te da un `auth_key` larguísimo y un servidor tipo `shelly-53-eu.shelly.cloud`. Copia los dos.
- El ID del dispositivo: app Shelly > el enchufe > Ajustes > Información del dispositivo. Es algo como `a4cf12ab34cd`.
- Un bot de Telegram: escribe a @BotFather, comando `/newbot`, te da un token. Después escríbele algo a tu bot y abre en el navegador `https://api.telegram.org/bot<TOKEN>/getUpdates` para ver tu `chat_id`.
- Una hoja de Google llamada «Cortes» con las columnas: fecha, evento, detalle.
- MUY IMPORTANTE: n8n tiene que estar FUERA del local. n8n Cloud o un VPS de 5 €/mes. Si lo pones en el mismo local, se cae con la luz y no te avisa nadie.
## Los nodos, en orden
1. **Schedule Trigger** — modo Interval, cada 5 minutos.
2. **HTTP Request** (llámalo «Estado Shelly») — Method POST, URL `https://shelly-53-eu.shelly.cloud/device/status` (pon tu servidor). Body Content Type: Form Urlencoded. Parámetros: `id` = tu ID de dispositivo, `auth_key` desde una credencial de n8n en lugar de escrito en el nodo (Authentication: Generic Credential Type > Custom Auth, con el JSON `{"body": {"auth_key": "tu clave"}}`: un flujo exportado se llevaría la clave). En Settings marca «Always Output Data» y en Options > Response activa «Never Error», para que un fallo de red no rompa el flujo sino que lo interpretemos como caída.
3. **Code** (llámalo «Decidir») — modo Run Once for All Items, con el código de abajo.
4. **IF** — condición: `{{ $json.aviso }}` **is not equal to** `ninguno` (tipo String).
5. Rama true > **Telegram** — Resource: Message, Operation: Send Message, Chat ID el tuyo, Text: `{{ $json.aviso === 'caida' ? '🔴 El local NO responde desde las ' + $json.hora + '. Revisa luz o router.' : '🟢 Todo ha vuelto a la normalidad a las ' + $json.hora }}`.
6. Detrás del Telegram > **Google Sheets** — Operation: Append Row, hoja «Cortes», columnas: fecha `{{ $json.hora }}`, evento `{{ $json.aviso }}`, detalle `fallos seguidos: {{ $json.fallos }}`.
## El código del nodo Code
```js
const r = $input.first().json;
const online = r.isok === true && r.data && r.data.online === true;
const s = $getWorkflowStaticData('global');
if (s.fallos === undefined) s.fallos = 0;
if (s.estado === undefined) s.estado = 'ok';
s.fallos = online ? 0 : s.fallos + 1;
let aviso = 'ninguno';
if (!online && s.fallos >= 2 && s.estado === 'ok') { s.estado = 'caido'; aviso = 'caida'; }
if (online && s.estado === 'caido') { s.estado = 'ok'; aviso = 'vuelta'; }
const hora = new Date().toLocaleString('es-ES', { timeZone: 'Europe/Madrid' });
return [{ json: { online, fallos: s.fallos, aviso, hora } }];
```
## Cómo probarla
Pulsa «Execute Workflow» con todo enchufado: el IF debe irse por la rama false y no mandar nada. Después desenchufa el Shelly de la pared y ejecuta a mano dos veces seguidas: en la segunda te llega el mensaje rojo. Vuelve a enchufarlo, espera un minuto a que arranque el wifi y ejecuta otra vez: llega el verde. Cuando funcione, activa el workflow con el interruptor de arriba a la derecha.
## Qué puede salir mal
- **Falsas alarmas por microcortes de wifi**: por eso exigimos 2 fallos seguidos (10 minutos). Si tu wifi es malo, sube a 3 en el código.
- **La clave de la nube caduca si cambias la contraseña de Shelly**: si empiezas a recibir caídas constantes, vuelve a generar el `auth_key`.
- **Servidor equivocado**: si el HTTP Request devuelve `isok: false` con «wrong server», copia exactamente el servidor que te muestra la app Shelly.
- **Hora rara en los mensajes**: el `toLocaleString` con `Europe/Madrid` ya corrige el cambio de hora, no toques la zona del servidor.
- **Se te acaba la batería del móvil o silencias Telegram**: crea un grupo con tu socio o encargado y mete ahí al bot, así lo ven dos personas.
## Cuánto cuesta
El enchufe Shelly son unos 20 € una vez. La nube de Shelly, Telegram y Google Sheets son gratis. n8n autoalojado en un VPS son 4-6 €/mes; n8n Cloud parte de unos 20 €/mes. Este flujo consume unas 8.600 ejecuciones al mes, así que si vas a usar n8n Cloud sube el intervalo a 10 minutos o autoalójalo.
