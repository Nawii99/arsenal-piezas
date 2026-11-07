# Vigilante de posiciones ASO en la App Store…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Cada día busca tus palabras clave en la App Store española y anota en qué puesto sale tu app; te avisa si caes varias posiciones de golpe.

## Qué es y qué hace

Receta de n8n que cada día consulta el buscador público de la App Store española para tus palabras clave y anota en qué posición sale tu app en una hoja de Google Sheets. Si pierdes cinco puestos o más en un día, avisa por Telegram. Entrada: ID numérico de la app y lista de palabras clave. Salida: histórico diario de posiciones y alertas. No necesita claves de Apple, porque la búsqueda es pública.

## Cómo usarla

1. Anota el ID de la app y las palabras clave
2. Conecta Sheets y Telegram
3. Activa el flujo y revisa el histórico una semana

## Cuándo usarla

Cuando dependes de las búsquedas de la tienda para conseguir instalaciones y quieres saber si un cambio de título o un competidor nuevo te ha hundido, sin pagar una herramienta ASO.

## Cómo ganar dinero con ella

Sustituye una suscripción ASO de 40-80 € al mes para lo básico. Detectar una caída el mismo día evita semanas de instalaciones perdidas.

- Seguimiento de búsquedas en App Store para una app de un comercio local…
- Control de posiciones tras cambiar el título de una app…
- Servicio mensual de ASO básico para desarrolladores pequeños…

**Precio orientativo:** 120–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Todos los días consulta el buscador público de la App Store para una lista de palabras clave tuyas y apunta en qué posición aparece tu app, guardando el histórico en una hoja. Si pierdes 5 puestos o más en un día, te avisa por Telegram; para quien vive de la descarga orgánica y no quiere pagar herramientas ASO caras.

## Lo que necesitas antes
- El **ID numérico de tu app** en la App Store: está en la URL de la ficha, `apps.apple.com/es/app/nombre/id1234567890` → 1234567890.
- Una hoja de Google Sheets con dos pestañas: `keywords` (columna A: la palabra clave) e `historico` (fecha, keyword, posicion).
- Credencial de Google Sheets en n8n (OAuth2 desde Google Cloud, o la más rápida: Service Account y compartir la hoja con su correo).
- Bot de Telegram con su token y tu chat_id.
- No hace falta ninguna clave de Apple: la API de búsqueda de iTunes es pública.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Days, Trigger at Hour: 7. Una vez al día basta, y a esa hora la tienda está tranquila.
2. **Google Sheets** — Operation: Get Row(s), Sheet: `keywords`. Te devuelve una fila por palabra clave.
3. **Split In Batches** (en versiones nuevas «Loop Over Items») — Batch Size: 1. Importante: la API pública corta si le metes prisa.
4. **Wait** — Amount: 2, Unit: Seconds. Dentro del bucle, para no comerte un bloqueo por exceso de peticiones.
5. **HTTP Request** — Method: GET, URL: `https://itunes.apple.com/search`. Query Parameters: `term` = `{{ $json.keyword }}`, `country` = `es`, `entity` = `software`, `limit` = `200`, `lang` = `es_es`. Options → Response → Never Error: activado, para que un fallo puntual no tumbe el flujo.
6. **Code** (nombre: Buscar mi posición) — código completo abajo. Devuelve la posición o 0 si no apareces en los 200 primeros.
7. **Google Sheets** — Operation: Append Row en `historico`: fecha `{{ $now.format('yyyy-MM-dd') }}`, keyword y posicion.
8. **Google Sheets** — Operation: Get Row(s) sobre `historico` con Filter: keyword igual a la actual, para recuperar el dato de ayer.
9. **IF** — Conditions (AND): Number `{{ $json.posicion_ayer }}` «is larger than» 0 Y Number `{{ $json.posicion - $json.posicion_ayer }}` «is larger than» 4.
10. **Telegram** — Send Message: `📉 «{{$json.keyword}}»: has pasado del puesto {{$json.posicion_ayer}} al {{$json.posicion}}.`

## El trozo de código (nodo Code «Buscar mi posición»)
```javascript
const MI_APP_ID = 1234567890; // cambia esto por el ID de tu app
const keyword = $('Split In Batches').item.json.keyword;
const resultados = $input.first().json.results || [];
let posicion = 0;
let competidorTop = '';
for (let i = 0; i < resultados.length; i++) {
  if (i === 0) competidorTop = resultados[0].trackName;
  if (resultados[i].trackId === MI_APP_ID) { posicion = i + 1; break; }
}
return [{ json: { keyword, posicion, competidorTop, total: resultados.length } }];
```

## Cómo probarla
- Mete solo 3 keywords en la hoja y ejecuta a mano con «Execute Workflow».
- Contrasta el resultado buscando esa misma palabra en la App Store del iPhone: debe coincidir con un margen de una o dos posiciones (Apple personaliza algo por usuario).
- Prueba a poner en el Code un ID de app que no exista para ver que devuelve 0 y no revienta.

## Qué puede salir mal
- **Bloqueo temporal de la API** (respuesta vacía o error 403): es la causa número uno. Sube el Wait a 4 segundos y no pases de 100 keywords por día.
- **La API de búsqueda no es exactamente el buscador de la tienda**: sirve para ver tendencias, no como verdad absoluta. Mide el cambio, no el número exacto.
- **Cambio de país**: `country=es` es España. Si vendes en México, duplica el flujo con `mx` y guarda el país en la hoja.
- **Duplicados en el histórico** si ejecutas dos veces el mismo día: filtra en Sheets por fecha+keyword antes del Append, o revisa a mano.
- **Zona horaria**: pon `Europe/Madrid` en Settings del workflow para que la fecha del día cuadre.

## Cuánto cuesta
Todo gratis: la API de búsqueda de Apple es pública, Sheets y Telegram no cobran. Solo pagas el sitio donde corre n8n: gratis en local con la Community Edition auto-alojada (n8n Cloud solo ofrece una prueba gratuita temporal y luego es de pago), unos 5 €/mes en un VPS pequeño si lo quieres siempre encendido.
