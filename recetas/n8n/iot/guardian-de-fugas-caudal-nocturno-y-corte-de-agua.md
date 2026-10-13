# Guardián de fugas: caudal nocturno y corte de agua…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Vigila el contador de agua y, si detecta consumo continuo de madrugada (una fuga), te avisa y cierra la llave general con una electroválvula.

## Qué es y qué hace

Un contador de agua con pulsos conectado a un ESP32 con ESPHome expone los litros acumulados. n8n lee cada media hora ese total; si entre las 02:00 y las 05:00 sigue entrando agua varias veces seguidas, interpreta fuga, avisa y cierra una electroválvula de la llave general. Entrada: litros acumulados; salida: aviso y corte. Se monta en n8n.

## Cómo usarla

1. Instala el sensor de caudal en la acometida
2. Configura ESPHome con pulse_meter y la API web
3. Define la ventana de 02:00 a 05:00
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tengas un local, nave, vivienda alquilada o segunda residencia y una fuga silenciosa te pueda costar cientos de euros y un siniestro.

## Cómo ganar dinero con ella

Una fuga en un inodoro gotea 200-400 litros al día. Detectarla en horas en vez de en el recibo trimestral evita 150-600 € de agua y daños por humedad.

- Detección de fugas nocturnas para un local, nave o piso alquilado.
- Control de consumo de agua para una segunda residencia sin vigilancia.
- Instalación de corte automático de agua para una comunidad con contador general.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee cada media hora el contador de litros de tu instalación y calcula cuánta agua ha pasado desde la lectura anterior. Si entre las 02:00 y las 05:00 sigue pasando agua varias veces seguidas, entiende que hay una fuga, te manda un aviso y cierra la electroválvula de la llave general.
Pensado para autónomos con local, nave o pisos alquilados, donde nadie está por la noche para oír el goteo.

## Lo que necesitas antes
- Un contador de agua con salida de pulsos (reed switch) o un sensor de caudal YF-S201 en la acometida (15-25 €).
- Un ESP32 o ESP8266 con ESPHome o Tasmota, en la misma red wifi, con IP fija en el router. Anota su IP, por ejemplo 192.168.1.50.
- En ESPHome, un sensor de tipo pulse_meter con `total:` que exponga los litros acumulados, y la API web activada (`web_server: port: 80`). Comprueba en el navegador que `http://192.168.1.50/sensor/agua_total` devuelve un JSON con el valor.
- Una electroválvula normalmente abierta de 3/4" (30-50 €) y un relé Shelly Plus 1 alimentado a 230 V para abrirla y cerrarla. Fontanero para montarla: la parte de fontanería no es de aficionado.
- Cuenta de Google (Google Sheets) y un bot de Telegram: escribe a @BotFather, `/newbot`, copia el token y escribe a @userinfobot para tu chat ID.
- n8n gratis, autoalojado en un Raspberry Pi o mini PC de la propia red, o n8n Cloud (entonces necesitas acceso remoto al ESP32; en ese caso mejor autoalojado).

## Los nodos, en orden
1. **Schedule Trigger**: modo Interval, cada 30 minutes. En Settings del workflow pon Timezone Europe/Madrid.
2. **HTTP Request** (nómbralo «Leer contador»): GET a `http://192.168.1.50/sensor/agua_total`, Response Format JSON, Timeout 5000 ms. En Settings del nodo activa Retry On Fail, 3 intentos, 5000 ms de espera, y On Error «Continue (using error output)».
3. **Google Sheets** (Operation: Append or Update no; usa **Read** primero): hoja «AguaLog», lee la última fila para obtener la lectura anterior. Truco práctico: usa la operación Get Row(s) con Return All desactivado y Limit 1, ordenando por fecha descendente no es posible directamente, así que lee toda la hoja y quédate con la última fila en el nodo Code.
4. **Code** (Run Once for All Items), «Detectar fuga»: calcula el consumo del intervalo y decide.
5. **IF**: condición Boolean, `{{ $json.fuga }}` is true.
6. Rama true → **HTTP Request** «Cerrar agua»: GET a `http://192.168.1.60/rpc/Switch.Set?id=0&on=true` (Shelly Gen2; en Gen1 sería `http://192.168.1.60/relay/0?turn=on`).
7. → **Telegram**: Operation Send Message, tu chat ID, texto `🚨 POSIBLE FUGA. Han pasado {{ $json.litros }} litros en la última media hora de madrugada. He cerrado la llave general. Revisa antes de reabrir.`
8. Ambas ramas → **Google Sheets** (Append): guarda fecha, lectura total, litros del intervalo y si se ha disparado la alarma.

## El trozo de código (nodo Code, «Detectar fuga»)
```js
const filas = $('Google Sheets').all();
const anterior = filas.length ? Number(filas[filas.length - 1].json.total) : null;
const total = Number($('Leer contador').first().json.value);
const litros = anterior === null ? 0 : Math.max(0, total - anterior);
const hora = new Date().toLocaleString('es-ES', { timeZone: 'Europe/Madrid', hour: '2-digit', hour12: false });
const esNoche = Number(hora) >= 2 && Number(hora) < 5;
const fuga = esNoche && litros > 5;
return [{ json: { total, litros, fuga, hora: Number(hora) } }];
```
Ajusta el umbral de 5 litros: si tienes riego automático o una máquina de hielo por la noche, súbelo a lo que gaste esa máquina más un margen.

## Cómo probarla
- Ejecuta el workflow a mano con «Test workflow» y comprueba que el nodo HTTP Request devuelve un número creciente cuando abres un grifo.
- Fuerza la alarma temporalmente cambiando `esNoche` por `true` y abriendo un grifo dos minutos: debe cerrarse la válvula y llegarte el Telegram. Deshaz el cambio después.
- Déjalo una semana solo en modo aviso (desconecta el nodo que cierra el agua) para ver cuántos falsos positivos salen.

## Qué puede salir mal
- **El ESP32 no responde**: el nodo lo reintenta 3 veces; si sigue fallando, la rama de error puede mandarte un Telegram distinto («sensor caído») en vez de cerrar el agua. Nunca cierres el agua por un fallo de lectura.
- **Zona horaria**: si n8n corre en un servidor en UTC, la franja nocturna se te va dos horas. Por eso el código usa `timeZone: 'Europe/Madrid'` y no la hora del sistema.
- **Reinicios del ESP32**: al reiniciarse, el contador acumulado vuelve a 0 y el cálculo daría negativo. El `Math.max(0, ...)` lo evita.
- **Válvula**: usa una normalmente abierta, así un corte de luz deja el agua pasando y no te quedas sin suministro por un apagón.

## Cuánto cuesta
n8n autoalojado, Google Sheets y Telegram: 0 €. Hardware: 60-110 € entre ESP32, sensor, electroválvula y Shelly, más la mano de obra del fontanero. Si usas n8n Cloud, el plan gratuito cubre de sobra las 48 ejecuciones diarias.
