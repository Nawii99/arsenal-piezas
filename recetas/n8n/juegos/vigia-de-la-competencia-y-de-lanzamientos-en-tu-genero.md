# Vigía de la competencia y de lanzamientos en tu género…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Cada lunes recibes un correo con los juegos de tu género que se han anunciado o han salido, los cambios de precio de tus competidores y los assets gratuitos de la semana.

## Qué es y qué hace

Combina feeds RSS y la API pública de Steam para vigilar precios de juegos competidores, detectar lanzamientos en tu género y recoger los assets gratuitos de la semana, y envía un resumen por correo los lunes. Entrada: lista de appids y feeds; salida: correo semanal y hoja de precios. Se monta en n8n con Google Sheets y Gmail, sin claves de pago.

## Cómo usarla

1. Crear la hoja vigilancia con competidores y fuentes
2. Añadir los RSS que quieras seguir
3. Probar la ejecución manual
4. Activar el envío del lunes

## Cuándo usarla

Cuando quieres elegir fecha de lanzamiento, vigilar precios de juegos parecidos al tuyo o no perderte los assets gratis de Fab y Unity.

## Cómo ganar dinero con ella

Ahorra la hora semanal de rastreo manual y, sobre todo, evita el error caro de lanzar la misma semana que un competidor directo.

- Montar inteligencia de mercado semanal para estudios que eligen fecha de lanzamiento.
- Vender el resumen de competencia a publishers pequeños con una cuota mensual.
- Preparar el seguimiento de precios para el equipo de producto de un estudio.

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Combina varias fuentes RSS y la API de tienda de Steam para vigilar precios de una lista de juegos competidores, detectar próximos lanzamientos en tu género y recoger los assets gratuitos de la semana, y lo manda todo en un correo los lunes. Para directores de estudio y responsables de producto.

## Lo que necesitas antes
- Una Google Sheet `vigilancia` con dos pestañas: `competidores` (columnas `appid`, `nombre`, `precio_actual`, `precio_anterior`, `descuento`, `reseñas`) y `fuentes` (columna `url` con los RSS que quieras seguir).
- Fuentes RSS útiles y gratuitas: `https://store.steampowered.com/feeds/news/app/TUAPPID/` para tus propias noticias, `https://www.gamedeveloper.com/rss.xml`, el RSS de la categoría que te interese en `itch.io/games/new.xml`, y el feed de tu subreddit de género: `https://www.reddit.com/r/IndieGaming/new/.rss`.
- No necesitas ninguna clave de API: `store.steampowered.com/api/appdetails` es público.
- Credenciales de Google Sheets y Gmail en n8n.

## Los nodos, en orden
1. **Schedule Trigger** — Cron: `0 8 * * 1` (lunes a las 8:00 hora del servidor; si tu n8n está en UTC, pon `0 6 * * 1` para que te llegue a las 8 en España en verano).
2. **Google Sheets** (`Leer competidores`) — Get Row(s) de la pestaña `competidores`, Return All.
3. **Loop Over Items** — Batch Size: `1`, con **Wait** de 1 segundo dentro del bucle para no machacar la API de Steam.
4. **HTTP Request** (`Precio Steam`) — GET `https://store.steampowered.com/api/appdetails?appids={{ $json.appid }}&cc=es&l=spanish&filters=price_overview,basic`. Activa Never Error.
5. **Code** (`Leer precio`) — extrae precio, descuento y detecta si ha cambiado respecto a lo guardado. Código abajo.
6. **Google Sheets** (`Actualizar precios`) — Update Row por `appid`.
7. **RSS Read** — un nodo por fuente, o mejor: **Google Sheets** lee la pestaña `fuentes` y un **Loop Over Items** con un **RSS Read** dentro cuya URL sea `{{ $json.url }}`.
8. **Filter** — condición: `{{ new Date($json.pubDate) > new Date($now.minus(7,'days')) }}` es true, para quedarte solo con lo de la última semana.
9. **Code** (`Puntuar relevancia`) — marca las noticias que contengan las palabras clave de tu género (`roguelike`, `metroidvania`, `city builder`, lo que sea) y descarta el resto.
10. **Code** (`Montar email`) — arma el HTML con tres bloques: cambios de precio, lanzamientos y noticias.
11. **Gmail** — Send, Subject: `Vigilancia semanal: {{ $json.n_cambios }} cambios de precio, {{ $json.n_noticias }} noticias`, Message en HTML.

## El código de `Leer precio`
```javascript
const appid = $('Loop Over Items').item.json.appid;
const guardado = $('Loop Over Items').item.json;
const datos = $input.first().json[appid];
if (!datos || !datos.success || !datos.data) {
  return [{ json: { appid: appid, nombre: guardado.nombre, error: 'sin datos', cambio: false } }];
}
const p = datos.data.price_overview;
const precio = p ? p.final / 100 : 0;
const descuento = p ? p.discount_percent : 0;
const anterior = Number(guardado.precio_actual) || 0;
return [{ json: {
  appid: appid,
  nombre: datos.data.name,
  precio_actual: precio,
  precio_anterior: anterior,
  descuento: descuento,
  cambio: anterior > 0 && Math.abs(precio - anterior) > 0.01,
  texto: datos.data.name + ': ' + precio.toFixed(2) + ' €' + (descuento ? ' (-' + descuento + ' %)' : '') + (anterior > 0 && precio < anterior ? ' ⬇ antes ' + anterior.toFixed(2) + ' €' : '')
} }];
```

## Cómo probarla
- Ejecuta a mano un miércoles con tres competidores en la hoja. Comprueba que los precios que salen coinciden con lo que ves en Steam con la tienda en español (el parámetro `cc=es` es lo que hace que sean euros).
- Pon a propósito un precio anterior distinto en la hoja para forzar que detecte un cambio y veas cómo queda el email.
- Revisa que los RSS devuelven items: algunos feeds de Reddit bloquean peticiones sin User-Agent; si te da 429, añade en Options > Headers un `User-Agent: n8n-vigilancia/1.0`.

## Qué puede salir mal
- **Steam limita las llamadas**: unas 200 por 5 minutos por IP. Con el Wait de 1 segundo y 30 competidores no hay problema; no quites el Wait.
- **`appdetails` devuelve `success: false`** para juegos sin publicar o restringidos por región. El código ya lo controla.
- **Juegos gratuitos**: no traen `price_overview`, y el precio sale 0. Normal.
- **RSS que desaparecen**: si una fuente muere, el nodo falla y tumba el flujo. Activa Continue On Fail en el RSS Read.
- **Hora del cron**: n8n usa la zona horaria del servidor salvo que la cambies en Settings > Timezone. Ponla en `Europe/Madrid` y olvídate de sumar horas.

## Cuánto cuesta
- APIs de Steam y feeds RSS: **gratis**.
- Gmail y Sheets: gratis. n8n auto-alojado: gratis.
- Si algún día quieres datos históricos serios de precios y wishlists, SteamDB tiene planes de pago para empresas, pero para esto no hace falta.
