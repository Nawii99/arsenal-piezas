# Contador de horas de máquina y aviso de mantenimiento…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Mide el consumo del enchufe inteligente de una máquina, suma las horas que ha estado trabajando de verdad y te avisa cuando toca el mantenimiento.

## Qué es y qué hace

Cada 15 minutos consulta el consumo en vatios de un enchufe Shelly; si supera un umbral, suma esos minutos como horas de trabajo en la hoja Maquinas. Al llegar a las horas de mantenimiento envía un correo. Entrada: potencia del Shelly por Cloud; salida: horas acumuladas y aviso. Se monta en n8n.

## Cómo usarla

1. Crea la hoja Maquinas con horas y umbrales
2. Conecta el enchufe con la auth key
3. Calibra el umbral de vatios
4. Programa el cron de 15 minutos

## Cuándo usarla

Cuando tengas compresores, hornos, cafeteras, cortadoras, impresoras 3D o cualquier máquina con mantenimiento cada X horas y lo lleves a ojo o en un cuaderno.

## Cómo ganar dinero con ella

Un mantenimiento pasado de vueltas se convierte en avería: entre 200 y 3.000 € y días parado. Además ves qué máquina te está inflando la factura de la luz.

- Control de horas de máquina para un taller con mantenimiento por horas.
- Seguimiento de consumo y uso para un obrador o bar con cafetera profesional.
- Aviso de mantenimiento para un fabricante pequeño con impresoras 3D.

**Precio orientativo:** 120–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada 15 minutos pregunta al enchufe inteligente cuántos vatios está gastando la máquina; si supera un umbral, cuenta esos 15 minutos como tiempo de trabajo y lo acumula en una hoja de cálculo. Cuando llega a las horas de mantenimiento te manda un correo. Para talleres, obradores, bares y pequeños fabricantes.

## Lo que necesitas antes
- Un **Shelly Plug S Gen3** (12-18 €) para máquinas de enchufe hasta 2.500 W, o un **Shelly Pro 1PM / 3EM** en el cuadro para máquinas cableadas o trifásicas (esto último lo instala un electricista).
- La **auth key** y el **servidor** de Shelly Cloud, más el **ID del dispositivo** (los sacas igual que en la receta de la nevera).
- Una hoja de **Google Sheets** llamada `Maquinas` con las columnas: `maquina`, `horas_acumuladas`, `horas_mantenimiento`, `ultimo_aviso`, `kwh_mes`. Rellena una fila por máquina.
- Cuenta de **Gmail** conectada en n8n (credencial OAuth2 de Google; se hace desde Google Cloud Console creando un proyecto y activando la API de Gmail y la de Sheets).

## Los nodos, en orden
1. **Schedule Trigger** — cada **15** minutos.
2. **Google Sheets** — operación *Get Row(s)*, hoja `Maquinas`. Devuelve una fila por máquina.
3. **Split In Batches** — tamaño de lote **1**, para tratar las máquinas una a una y no pasarte del límite de la API de Shelly.
4. **HTTP Request** — POST a `https://TU-SERVIDOR.shelly.cloud/device/status`, *Form Urlencoded*, `id` = `{{ $json.device_id }}` (añade esa columna a la hoja) y `auth_key`. La `auth_key` no la escribas en el nodo ni la guardes en la hoja: ponla en una credencial de n8n (Authentication: Generic Credential Type > Custom Auth, con el JSON `{"body": {"auth_key": "tu clave"}}`); un flujo exportado se la llevaría.
5. **Code**:
```js
const est = $json.data.device_status;
const w = est['switch:0'] ? est['switch:0'].apower : est.meters[0].power;
const fila = $('Split In Batches').item.json;
const UMBRAL = 40; // vatios por encima de los cuales consideramos que está trabajando
const trabajando = w > UMBRAL;
const horas = Number(fila.horas_acumuladas || 0) + (trabajando ? 0.25 : 0);
const objetivo = Number(fila.horas_mantenimiento || 250);
const tocaMantenimiento = horas >= objetivo;
const kwh = Number(fila.kwh_mes || 0) + (trabajando ? (w * 0.25) / 1000 : 0);
return [{ json: { maquina: fila.maquina, w, trabajando, horas: Math.round(horas * 100) / 100, objetivo, tocaMantenimiento, kwh_mes: Math.round(kwh * 1000) / 1000, row_number: fila.row_number } }];
```
6. **Google Sheets** — operación *Update Row*, buscando por `row_number`, escribe `horas_acumuladas` y `kwh_mes`.
7. **IF** — `{{ $json.tocaMantenimiento }}` *is true*.
8. **Gmail** — *Send*, asunto `🔧 Mantenimiento pendiente: {{ $json.maquina }}`, cuerpo con las horas y el objetivo. Después de mandarlo, otro **Google Sheets** *Update Row* que ponga `horas_acumuladas` a `0` y `ultimo_aviso` a la fecha de hoy, para empezar el ciclo nuevo.
9. Conecta la salida del IF de vuelta al **Split In Batches** para que siga con la siguiente máquina.

## Cómo probarla
- Enchufa la máquina, ejecuta a mano y comprueba que el campo `w` trae vatios reales (enciéndela y apágala para ver la diferencia).
- Ajusta el `UMBRAL`: mira cuántos vatios gasta la máquina apagada pero enchufada (el *standby*, suele ser 1-5 W) y pon el umbral bien por encima.
- Pon `horas_mantenimiento` a `0.2` en una fila de prueba y espera dos ciclos: debe llegarte el correo y ponerse el contador a cero.

## Qué puede salir mal
- **Máquinas con ciclos cortos.** Si tu máquina trabaja 3 minutos y para, muestrear cada 15 minutos se te escapa. Baja a cada 2 minutos o, mejor, usa el contador de energía total del Shelly (`aenergy.total`, en vatios-hora) y calcula la diferencia entre lecturas: es exacto y no depende del muestreo.
- **Se cae n8n unas horas** y pierdes ese tiempo. Es un contador aproximado, sirve para mantenimiento, no para facturar.
- **Límite de Shelly Cloud: 1 petición por segundo.** Por eso va el Split In Batches; si tienes más de 20 máquinas, mete un **Wait** de 1 segundo dentro del bucle.
- **Google Sheets se lía si dos ejecuciones coinciden.** En *Settings* del workflow, pon *Execution Order: v1* y limita la concurrencia a 1.

## Cuánto cuesta
Enchufe Shelly 12-18 € por máquina. Google Sheets, Gmail, Shelly Cloud y n8n auto-alojado: **0 €**. Si lo montas en Zapier, cada 15 minutos son 2.880 tareas al mes: te iría al plan de 50-70 €/mes, así que aquí n8n gana de calle.
