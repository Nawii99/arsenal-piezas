# Aviso de fin y de fallo en impresora 3D o CNC…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Te avisa con foto cuando termina una pieza, cuando falla la impresión o cuando la máquina lleva parada más de la cuenta con trabajo pendiente.

## Qué es y qué hace

Consulta cada dos minutos el estado de la impresora a través de OctoPrint o Moonraker y envía a Telegram una foto de la webcam cuando termina una pieza, cuando el trabajo falla o cuando la máquina lleva parada demasiado tiempo con material cargado. Entrada: API de OctoPrint y snapshot de la webcam; salida: aviso con foto. Se monta en n8n.

## Cómo usarla

1. Crea la Application Key en OctoPrint
2. Anota la URL de la webcam
3. Prepara la hoja Produccion
4. Programa el cron de 2 minutos

## Cuándo usarla

Cuando produzcas piezas con impresora 3D, láser o CNC y pierdas horas por descubrir tarde que la pieza se despegó o que la máquina terminó hace rato.

## Cómo ganar dinero con ella

Cada fallo pillado a tiempo son 3-8 horas de máquina y 5-20 € de material. Con 3 fallos al mes, 200-400 € al año más el tiempo de la persona.

- Monitor de impresoras 3D para un taller que vende piezas por encargo.
- Aviso de trabajos terminados para un fabricante pequeño que no está junto a la máquina.
- Registro de producción y fallos para una tienda de rotulación con CNC.

**Precio orientativo:** 150–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila el estado de la máquina cada 2 minutos y te manda a Telegram una foto de la cámara cuando la pieza termina, cuando el trabajo se cancela o falla, y cuando la máquina se ha quedado parada con material cargado. Para talleres de fabricación, tiendas de rotulación y makers que venden piezas.

## Lo que necesitas antes
- **OctoPrint** (gratis) en un Raspberry Pi conectado a la impresora, o **Klipper con Moonraker**, o **Bambu/Prusa Connect** si tu máquina lo trae de fábrica.
- La **clave de API de OctoPrint**: dentro de OctoPrint, *Settings > API*, o crea una *Application Key* en tu usuario.
- La **URL de la webcam** de OctoPrint: normalmente `http://IP-OCTOPRINT/webcam/?action=snapshot`.
- **n8n**, bot de **Telegram**, y una hoja de **Google Sheets** llamada `Produccion` con `fecha`, `trabajo`, `resultado`, `minutos`, `gramos`.

## Los nodos, en orden
1. **Schedule Trigger** — cada **2** minutos.
2. **HTTP Request** — GET a `http://IP-OCTOPRINT/api/job`. En *Options > Headers* añade `X-Api-Key` desde una credencial de n8n (Generic Credential Type > Header Auth, Name `X-Api-Key`, Value tu clave; no la escribas en el nodo: un flujo exportado se la llevaría).
3. **Code** — detecta el cambio de estado (que es la clave: no queremos avisar 30 veces del mismo estado):
```js
const j = $json;
const estado = j.state; // Printing, Operational, Cancelling, Error, Offline
const nombre = (j.job && j.job.file && j.job.file.name) || 'sin trabajo';
const pct = j.progress && j.progress.completion ? Math.round(j.progress.completion) : 0;
const minutos = j.progress && j.progress.printTime ? Math.round(j.progress.printTime / 60) : 0;
const gramos = j.job && j.job.filament && j.job.filament.tool0 ? Math.round(j.job.filament.tool0.length / 330) : 0;
const st = $getWorkflowStaticData('global');
const anterior = st.estado || 'desconocido';
st.estado = estado;
let evento = null;
if (anterior === 'Printing' && estado === 'Operational' && pct >= 99) evento = '✅ TERMINADA';
if (anterior === 'Printing' && (estado === 'Cancelling' || estado === 'Error' || estado === 'Offline')) evento = '❌ FALLO O CANCELADA';
if (anterior === 'Printing' && estado === 'Operational' && pct < 99) evento = '⚠️ PARADA A MEDIAS (' + pct + '%)';
return evento ? [{ json: { evento, nombre, pct, minutos, gramos, estado, fecha: new Date().toLocaleString('es-ES', { timeZone: 'Europe/Madrid' }) } }] : [];
```
4. **HTTP Request** (*Foto*) — GET a la URL de la webcam, con *Response Format = File* y campo binario `data`.
5. **Telegram** — *Send Photo*, binario `data`, *Caption*: `{{ $('Code').item.json.evento }} — {{ $('Code').item.json.nombre }} · {{ $('Code').item.json.minutos }} min · ~{{ $('Code').item.json.gramos }} g · {{ $('Code').item.json.fecha }}`.
6. **Google Sheets** — *Append Row* en `Produccion` con `resultado` = el evento. Así tienes al final de mes cuántas horas de máquina y cuántos gramos has gastado, que es justo lo que necesitas para poner precio a las piezas.

## Cómo probarla
- Lanza una pieza de 5 minutos (un cubo de calibración pequeño) y comprueba que llega el aviso de terminada con foto.
- Cancela una impresión a mano desde OctoPrint: debe llegar el de fallo.
- Apaga la impresora a mitad: debe llegar el de parada a medias u offline.

## Qué puede salir mal
- **Avisos repetidos** si n8n se reinicia y pierde el `staticData`. Como mucho te llega uno de más.
- **La foto sale negra** porque la máquina está en un armario sin luz. Pon una tira LED encendida o quita el nodo de foto y manda solo texto.
- **Falsos "terminada"** en impresoras que se quedan en `Operational` con el 100% durante rato: el filtro de `pct >= 99` lo resuelve.
- **OctoPrint no responde** mientras imprime a mucha velocidad (el Pi va justo). Activa *Retry On Fail* y no bajes el intervalo por debajo de 2 minutos.
- **Los gramos son aproximados** (asumen PLA de 1,75 mm). Ajusta el divisor 330 si usas otro material.

## Cuánto cuesta
OctoPrint es gratis; el Raspberry Pi con cámara, 60-90 € una vez si no lo tienes. Telegram, Google Sheets y n8n auto-alojado, **0 €/mes**. Cada 2 minutos son 21.600 ejecuciones al mes: eso en Zapier o Make es impagable, así que aquí n8n auto-alojado es obligatorio.
