# Aviso de mantenimiento por horas reales de máquina…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Cuenta las horas que una máquina ha estado realmente funcionando (no las del calendario) y te avisa cuando toca el cambio de aceite, la limpieza o la revisión.

## Qué es y qué hace

Flujo de n8n que cada 5 minutos consulta la potencia que consume una máquina con un Shelly. Si supera tu umbral, suma 5 minutos al contador de horas guardado en Google Sheets y, al llegar al límite, avisa por Telegram y crea el aviso pendiente de mantenimiento. Entra el umbral en vatios y las horas límite; sale el contador y la alerta.

## Cómo usarla

1. Mide la máquina con un Shelly
2. Rellena la hoja Mantenimiento con umbral y horas límite
3. Crea el bot de Telegram
4. Ajusta el umbral observando la potencia una semana

## Cuándo usarla

Úsalo cuando tengas compresores, hornos, extractores, amasadoras o bombas cuyo mantenimiento va por horas de uso y siempre se te pasa.

## Cómo ganar dinero con ella

Una avería por mantenimiento olvidado son 500-2.000 € más los días parado. Esto lo convierte en un aviso que llega solo.

- Control de mantenimiento preventivo para talleres con compresores, hornos o extractores.
- Configuración de avisos de revisión para lavanderías e imprentas con maquinaria pesada.
- Implantación de un registro de horas de uso para pymes que deben cumplir revisiones periódicas.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada 5 minutos mira la potencia que consume la máquina. Si está por encima de un umbral, entiende que está trabajando y suma 5 minutos al contador de horas guardado en una hoja. Cuando pasa el límite que tú marcas, te avisa por Telegram y crea la línea de aviso pendiente.
Para talleres, obradores, imprentas, lavanderías y cualquier negocio con maquinaria que exige revisiones por horas de funcionamiento.
## Lo que necesitas antes
- Un Shelly Plus 1PM, Shelly Plus Plug S o Shelly Pro 1PM midiendo esa máquina.
- `auth_key`, servidor e ID del dispositivo.
- Hoja de Google «Mantenimiento» con la pestaña `maquinas` y columnas: nombre, device_id, umbral_w, horas_acumuladas, horas_limite, avisado, ultimo_mantenimiento.
- Rellena una fila por máquina. Ejemplo: `Compresor`, `a4cf...`, `300`, `0`, `500`, `no`, `2026-01-15`.
- Bot de Telegram.
## Los nodos, en orden
1. **Schedule Trigger** — Interval, cada 5 minutos.
2. **Google Sheets** — Get Row(s) de `maquinas`.
3. **Loop Over Items** — Batch Size 1.
4. **HTTP Request** — POST `https://shelly-53-eu.shelly.cloud/device/status`, Form Urlencoded con `id` = `{{ $json.device_id }}` y `auth_key`. Never Error activado.
5. **Code** «Sumar tiempo» — Run Once for Each Item:
```js
const fila = $('Loop Over Items').item.json;
const st = $json.data && $json.data.device_status ? $json.data.device_status : {};
const bloque = st['switch:0'] || st;
const w = bloque.apower !== undefined ? bloque.apower : (bloque.meters ? bloque.meters[0].power : 0);
const umbral = Number(fila.umbral_w) || 100;
const enMarcha = w >= umbral;
let horas = Number(fila.horas_acumuladas) || 0;
if (enMarcha) horas = horas + (5/60);
const limite = Number(fila.horas_limite) || 500;
const tocaAvisar = horas >= limite && String(fila.avisado).toLowerCase() !== 'si';
return { json: { nombre: fila.nombre, device_id: fila.device_id, umbral_w: fila.umbral_w, horas_acumuladas: Number(horas.toFixed(2)), horas_limite: limite, avisado: tocaAvisar ? 'si' : fila.avisado, ultimo_mantenimiento: fila.ultimo_mantenimiento, watios: w, enMarcha, tocaAvisar } };
```
6. **Google Sheets** — Operation: Update Row, hoja `maquinas`, Matching Column: `nombre`. Así reescribe las horas acumuladas y la marca de avisado.
7. **IF** — `{{ $json.tocaAvisar }}` is true.
8. Rama true > **Telegram** — `🔧 {{ $json.nombre }} ha llegado a {{ $json.horas_acumuladas }} horas de funcionamiento (límite {{ $json.horas_limite }}). Toca mantenimiento. Último: {{ $json.ultimo_mantenimiento }}.`
9. Conecta la salida final de vuelta al **Loop Over Items**.
## Cómo poner a cero tras el mantenimiento
Haz un segundo workflow con **Webhook** (Path `mantenimiento-hecho`, GET) que reciba `?maquina=Compresor`, un **Code** que ponga `horas_acumuladas` a 0, `avisado` a `no` y `ultimo_mantenimiento` a la fecha de hoy, y un **Google Sheets** Update Row. Guarda ese enlace en el móvil: lo abres cuando acabas la revisión y listo.
## Cómo probarla
Pon `horas_limite` a 0.1 y el `umbral_w` a 1 para una máquina de prueba (una lámpara vale). Ejecuta a mano dos veces: verás las horas subir en la hoja y llegará el Telegram. Comprueba que al segundo aviso ya no repite (columna avisado = si). Luego abre la URL de mantenimiento hecho y mira que se pone a cero. Restaura tus valores reales y activa.
## Qué puede salir mal
- **Umbral mal puesto**: mira en la app Shelly qué watios marca la máquina parada (standby) y en marcha, y pon el umbral en medio. Un compresor puede estar a 5 W parado y 1.200 W trabajando.
- **Cuenta horas de más**: si la máquina arranca justo entre dos muestreos, el error máximo es de 5 minutos por arranque. Suficiente para mantenimiento.
- **Choques al escribir en la hoja**: por eso usamos Loop Over Items con lotes de 1, no en paralelo.
- **La hoja no encuentra la fila**: la columna `nombre` tiene que coincidir exacta, sin espacios de más.
- **Muchas ejecuciones**: 8.640 al mes por flujo. Si te aprieta, baja a cada 10 minutos y cambia el `5/60` por `10/60`.
## Cuánto cuesta
Enchufe medidor 20-40 €. Sheets, Telegram y Shelly Cloud gratis. n8n autoalojado 4-6 €/mes. Con 3 o 4 máquinas ya te ahorra la libreta y las averías tontas.
