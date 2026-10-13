# Enciende las cargas gordas en las horas baratas de luz…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Consulta el precio real de la luz PVPC de mañana, elige las horas más baratas y enciende solo entonces el acumulador, la bomba de calor o el cargador del coche.

## Qué es y qué hace

Cada tarde descarga de la API pública de Red Eléctrica los precios horarios de la luz para el día siguiente, elige las horas más baratas y guarda la decisión en Google Sheets. Cada hora enciende o apaga un Shelly según toque. Entrada: precios PVPC; salida: orden de encendido. Se monta en n8n.

## Cómo usarla

1. Crea la hoja Luz
2. Instala el Shelly en la carga
3. Que lo revise un profesional

## Cuándo usarla

Cuando tengas tarifa regulada PVPC o indexada y cargas que puedas mover de hora: termo eléctrico, cargador de coche, bomba de piscina, deshumidificador o lavavajillas.

## Cómo ganar dinero con ella

Mover 3-6 kWh al día de la hora cara a la barata son 15-45 €/mes de ahorro en un hogar y bastante más en un local con termo grande.

- Programación de carga de coche eléctrico según tarifa PVPC para un particular.
- Termo eléctrico en horas baratas para un local con agua caliente.
- Gestión de consumos para un autónomo con cargas que se pueden desplazar.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada tarde descarga los precios horarios oficiales de la luz para el día siguiente, calcula las horas más baratas y las guarda; luego, cada hora en punto, enciende o apaga el enchufe según toque. Para cualquiera con PVPC y un aparato que le dé igual funcionar a las 3 de la mañana.

## Lo que necesitas antes
- La **API de Red Eléctrica (apidatos.ree.es)**: pública, **gratuita y sin clave**. También sirve la de esios con token gratuito, pero esta es más sencilla.
- Un **Shelly Plus Plug S** o **Shelly Pro 1PM** para la carga que quieras mover. Para termo eléctrico o cargador de coche, que lo monte un electricista en el cuadro.
- Una hoja de **Google Sheets** llamada `Luz` con columnas `fecha`, `hora`, `precio`, `encender`.
- **n8n**.

## Los nodos, en orden (workflow A: descargar precios)
1. **Schedule Trigger** — *Cron* `30 20 * * *` (20:30, cuando ya están publicados los precios de mañana), zona `Europe/Madrid`.
2. **Code** — construye la URL con las fechas de mañana:
```js
const m = new Date(Date.now() + 86400000);
const y = m.getFullYear(), mo = String(m.getMonth() + 1).padStart(2, '0'), d = String(m.getDate()).padStart(2, '0');
const base = 'https://apidatos.ree.es/es/datos/mercados/precios-mercados-tiempo-real';
const url = base + '?start_date=' + y + '-' + mo + '-' + d + 'T00:00&end_date=' + y + '-' + mo + '-' + d + 'T23:59&time_trunc=hour';
return [{ json: { url, dia: y + '-' + mo + '-' + d } }];
```
3. **HTTP Request** — GET a `{{ $json.url }}`. Activa *Retry On Fail* (3 intentos, 60000 ms): a veces REE tarda en publicar.
4. **Code** — elige las N horas más baratas:
```js
const serie = $json.included[0].attributes.values;
const HORAS_QUE_NECESITO = 4;
const filas = serie.map(v => ({ hora: new Date(v.datetime).getHours(), precio: Math.round(v.value * 100) / 100 }));
const baratas = [...filas].sort((a, b) => a.precio - b.precio).slice(0, HORAS_QUE_NECESITO).map(f => f.hora);
const dia = $('Code').first().json.dia;
return filas.map(f => ({ json: { fecha: dia, hora: f.hora, precio: f.precio, encender: baratas.includes(f.hora) ? 'SI' : 'NO' } }));
```
5. **Google Sheets** — *Append or Update Row*, hoja `Luz`, clave de coincidencia `fecha` + `hora`.

## Los nodos (workflow B: ejecutar cada hora)
6. **Schedule Trigger** — *Cron* `2 * * * *` (cada hora, al minuto 2).
7. **Google Sheets** — *Get Row(s)* con filtro `fecha` = `{{ $now.format('yyyy-MM-dd') }}` y `hora` = `{{ $now.hour }}`.
8. **IF** — `{{ $json.encender }}` *equals* `SI`.
9. **HTTP Request** (rama true) — `http://192.168.1.70/rpc/Switch.Set?id=0&on=true`; rama false, el mismo nodo con `on=false`.

## Cómo probarla
- Lanza el workflow A a mano y mira la hoja: deben salir 24 filas con precios coherentes (entre 0,02 y 0,35 €/kWh normalmente) y exactamente 4 con `SI`.
- Lanza el workflow B a mano en una hora marcada `SI` y comprueba que el enchufe se enciende.
- Deja pasar un día entero y revisa la hoja: no debe haber huecos.

## Qué puede salir mal
- **REE no ha publicado los precios a las 20:30** (pasa algunos días). Añade un segundo **Schedule Trigger** a las 21:30 al mismo workflow; el *Append or Update* evita duplicados.
- **Los precios de apidatos no incluyen peajes ni impuestos**, así que el número absoluto no es tu factura, pero el *orden* de las horas baratas sí es correcto, que es lo que usamos.
- **Horario de verano**: el día del cambio hay 23 o 25 horas. Como buscamos por número de hora en la hoja, no se rompe, solo puede faltar o sobrar una fila.
- **La carga se queda encendida** si falla el workflow B. Añade un **Schedule Trigger** de seguridad a las 7:00 que fuerce `on=false`.
- **Termo eléctrico y legionela**: no lo dejes por debajo de 60 ºC ni lo apagues días enteros.

## Cuánto cuesta
API de REE, Google Sheets y n8n auto-alojado: **0 €**. El enchufe Shelly 15-25 €; el contactor y la mano de obra para un termo, 80-150 €. Se paga solo en el primer trimestre.
