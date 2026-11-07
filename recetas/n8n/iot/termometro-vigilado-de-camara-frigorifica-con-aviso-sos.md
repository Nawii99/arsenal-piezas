# Termómetro vigilado de cámara frigorífica con aviso sos…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Registra la temperatura de tu cámara o nevera cada pocos minutos en una hoja y te avisa solo si se pasa del límite durante un rato, no por abrir la puerta.

## Qué es y qué hace

Flujo de n8n que recibe cada lectura de un sensor Shelly de temperatura y humedad y la guarda en Google Sheets con fecha, sensor, temperatura y batería. Si la temperatura supera tu límite tres lecturas seguidas, avisa por Telegram y avisa de nuevo al volver a rango. Entra el webhook del sensor y el límite; sale el histórico y las alertas.

## Cómo usarla

1. Coloca el sensor dentro de la cámara, lejos del evaporador y de la puerta
2. Define el límite y el tiempo sostenido
3. Expón n8n con una URL https
4. Que lo revise un profesional (seguridad alimentaria y APPCC)

## Cuándo usarla

Úsalo cuando guardes producto fresco o congelado y necesites tanto el aviso rápido como el histórico para enseñárselo a Sanidad o al seguro.

## Cómo ganar dinero con ella

Sustituye a los registradores de temperatura de 300-500 € con cuota, y te da el histórico que exige el control de APPCC sin apuntar nada a mano.

- Registro de temperaturas para hostelería y carnicerías que necesitan histórico para inspecciones.
- Instalación de sensores y alertas en cámaras frigoríficas para restaurantes y obradores.
- Mantenimiento mensual del registro de temperaturas para tiendas de alimentación pequeñas.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
El sensor manda su lectura a n8n cada vez que reporta. n8n la guarda en una hoja de Google y, si la temperatura se pasa del límite durante tres lecturas seguidas, te avisa por Telegram. Al volver a rango, avisa de la vuelta.
Para hostelería, fruterías, carnicerías, obradores, floristerías y cualquiera con producto sensible al calor.
## Lo que necesitas antes
- Un sensor Shelly Plus H&T (unos 35 €) o Shelly H&T Gen3, con pilas, dentro de la cámara pero no pegado al evaporador ni a la puerta.
- n8n accesible desde internet con una URL https (n8n Cloud, o autoalojado con un dominio y Cloudflare Tunnel). El sensor necesita poder llamarla.
- Una hoja de Google «Temperaturas» con columnas: fecha, sensor, temperatura, humedad, bateria.
- Bot de Telegram con su token y tu chat_id (@BotFather y `/getUpdates`, igual que en cualquier receta de avisos).
- Decidido el límite: nevera 8 °C, congelador -15 °C, obrador 22 °C… lo que aplique.
## Los nodos, en orden
1. **Webhook** — HTTP Method: GET, Path: `sensor-temp`, Respond: Immediately. Copia la URL de producción, algo como `https://tu-n8n.com/webhook/sensor-temp`. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
2. En el sensor: entra a su IP desde el navegador (o app Shelly > Ajustes > Acciones/Webhooks), crea una acción sobre el evento de reporte y pon como URL: `https://tu-n8n.com/webhook/sensor-temp?id=camara1&t=${status["temperature:0"].tC}&h=${status["humidity:0"].rh}&bat=${status["devicepower:0"].battery.percent}`. Esas llaves con `${}` son plantillas propias de Shelly, se copian tal cual.
3. **Code** (llámalo «Evaluar») — Run Once for All Items, código abajo. Ahí pones el límite.
4. **Google Sheets** — Operation: Append Row, hoja «Temperaturas». fecha `{{ $json.hora }}`, sensor `{{ $json.id }}`, temperatura `{{ $json.t }}`, humedad `{{ $json.h }}`, bateria `{{ $json.bat }}`.
5. **IF** — condición: `{{ $json.aviso }}` is not equal to `ninguno`.
6. Rama true > **Telegram** — Send Message. Text: `{{ $json.aviso === 'alarma' ? '🔴 ' + $json.id + ' a ' + $json.t + ' ºC (límite ' + $json.limite + '). Lleva 3 lecturas fuera de rango.' : '🟢 ' + $json.id + ' ha vuelto a ' + $json.t + ' ºC' }}`.
## El código del nodo Code
```js
const LIMITE = 8; // grados máximos permitidos
const q = $input.first().json.query || {};
const t = parseFloat(q.t);
const id = q.id || 'sensor';
const s = $getWorkflowStaticData('global');
if (!s[id]) s[id] = { fuera: 0, estado: 'ok' };
const st = s[id];
st.fuera = (isNaN(t) || t <= LIMITE) ? 0 : st.fuera + 1;
let aviso = 'ninguno';
if (st.fuera >= 3 && st.estado === 'ok') { st.estado = 'alarma'; aviso = 'alarma'; }
if (st.fuera === 0 && st.estado === 'alarma') { st.estado = 'ok'; aviso = 'vuelta'; }
const hora = new Date().toLocaleString('es-ES', { timeZone: 'Europe/Madrid' });
return [{ json: { id, t, h: parseFloat(q.h), bat: parseInt(q.bat), limite: LIMITE, aviso, hora } }];
```
## Cómo probarla
Pulsa «Listen for test event» en el Webhook y abre en tu navegador la URL con parámetros inventados: `...?id=camara1&t=12.5&h=60&bat=90`. Repítela tres veces cambiando decimales: a la tercera debe llegarte el Telegram rojo. Luego llama con `t=4` y llega el verde. Comprueba que las filas se apilan bien en la hoja y activa el workflow.
## Qué puede salir mal
- **Avisos por abrir la puerta**: es justo lo que evita el contador de 3 lecturas. Si sigue pasando, súbelo a 4 o sube el límite un grado.
- **El sensor reporta muy poco**: el Shelly H&T con pilas manda datos cada X minutos o al cambiar la temperatura. En Ajustes puedes bajar el umbral de cambio a 0,5 ºC, pero gastarás más pila.
- **Batería agotada sin que te enteres**: añade un segundo **IF** después del Sheets con `{{ $json.bat }}` **smaller** `15` y otro Telegram avisando de pilas.
- **La hoja crece sin parar**: crea una pestaña nueva cada año, o añade un **Schedule Trigger** mensual que copie y limpie.
- **n8n sin https**: muchos routers no dejan salir al sensor a puertos raros. Usa el 443 con certificado.
## Cuánto cuesta
Sensor 35 €. Telegram, Sheets y el webhook, gratis. El único gasto recurrente es el alojamiento de n8n (4-6 €/mes en VPS). Si añades más sensores, solo pagas el hardware: el mismo flujo aguanta todos los que quieras porque el código distingue por `id`.
