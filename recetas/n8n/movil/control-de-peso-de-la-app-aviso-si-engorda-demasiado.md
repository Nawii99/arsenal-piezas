# Control de peso de la app: aviso si engorda demasiado…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Mide cada semana cuánto ocupa tu app en la tienda y te avisa si ha crecido más de un 10 %, que es cuando la gente deja de descargarla con datos.

## Qué es y qué hace

Flujo de n8n que cada lunes consulta el tamaño de tu app en la App Store mediante la API de búsqueda de iTunes, lo compara con la medición anterior guardada en Google Sheets y te avisa si ha crecido más de un 10 %. Entra el ID de la app; sale una fila con megas, versión y variación, y un aviso si hace falta. Es gratis con APIs públicas y solo necesita n8n y una cuenta de Google.

## Cómo usarla

1. 1. Apunta el ID numérico de tu app
2. 2. Crea la hoja Peso con sus columnas
3. 3. Compara el aviso con cada versión que lances

## Cuándo usarla

Úsalo cuando lances versiones a menudo y quieras que nadie meta una librería de 40 MB sin que te enteres.

## Cómo ganar dinero con ella

Cada 10 MB de más bajan la conversión de descarga. Detectarlo a tiempo evita perder instalaciones que ya has pagado en publicidad.

- Control de tamaño de app para equipos que añaden SDKs sin medir el efecto en la descarga.
- Vigilancia de peso para agencias que entregan apps a clientes con límites de tamaño de descarga.
- Medición semanal de paquetes para apps que compiten por instalaciones con datos móviles limitados.

**Precio orientativo:** 60–150 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Consulta el tamaño oficial del paquete de tu app en la App Store, lo apunta en una hoja con la fecha y la versión, y te avisa si pega un salto.
Para equipos pequeños que van metiendo SDKs (analítica, publicidad, chat) sin medir el efecto en el tamaño de descarga.

## Lo que necesitas antes
n8n, una cuenta de Google (Sheets) y un bot de Telegram.
El id numérico de tu app en la App Store.
Hoja `Peso` con columnas: fecha, version, megas, megas_anterior, variacion_pct.

## Los nodos, en orden
1. **Schedule Trigger**: Cron `0 8 * * 1` (lunes a las 8).
2. **HTTP Request**: GET `https://itunes.apple.com/lookup?id=TU_APP_ID&country=es`.
3. **Google Sheets** (Get Row(s)): hoja `Peso`, en Options activa «Return All» y ordena luego en el Code; o más simple, lee todo y quédate con la última fila.
4. **Code**: calcula megas y variación. Código abajo.
5. **Google Sheets** (Append): añade la fila nueva.
6. **IF**: Number, `{{ $json.variacion_pct }}` «larger or equal» que `10`.
7. **Telegram** (rama true): «La app ha pasado de {{ $json.megas_anterior }} MB a {{ $json.megas }} MB en la versión {{ $json.version }}».

## El nodo Code
```javascript
const r = ($('HTTP Request').first().json.results || [])[0];
const megas = Math.round((Number(r.fileSizeBytes || 0) / 1048576) * 10) / 10;
const filas = $('Google Sheets').all().map(i => i.json);
const ultima = filas.length ? filas[filas.length - 1] : null;
const megas_anterior = ultima ? Number(ultima.megas || 0) : megas;
const variacion_pct = megas_anterior > 0 ? Math.round(((megas - megas_anterior) / megas_anterior) * 1000) / 10 : 0;
return [{ json: {
  fecha: new Date().toISOString().slice(0, 10),
  version: r.version,
  megas,
  megas_anterior,
  variacion_pct
}}];
```

## Cómo probarla
Ejecuta a mano: debe escribir una fila con el tamaño real (compáralo con el que sale en la ficha de la App Store, en «Tamaño»).
Edita a mano la última fila de la hoja poniendo un valor pequeño (por ejemplo 10 MB) y vuelve a ejecutar: tiene que saltar el aviso de Telegram.

## Qué puede salir mal
El tamaño que da Apple es el del paquete universal y varía según el modelo de iPhone: te sirve para comparar contigo mismo, no para presumir en absoluto.
Si el `results` viene vacío, revisa el país: una app no publicada en España no aparece en `country=es`.
Para Android no hay dato público fiable; si te hace falta, mide el tamaño del AAB en tu proceso de compilación y mándalo a un **Webhook** de este flujo.

## Cuánto cuesta
Gratis del todo. Una ejecución a la semana no gasta prácticamente nada ni siquiera en n8n Cloud.
