# Informe semanal de tu competencia en Steam…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Cada lunes reúne datos públicos de tu juego y de 10 competidores (precio, descuentos, reseñas, etiquetas) y te manda un informe por correo.

## Qué es y qué hace

Flujo de n8n que cada lunes lee datos públicos de tu juego y de hasta 10 competidores desde las APIs de Steam y SteamSpy: precio, descuento, reseñas y porcentaje de positivas. Guarda cada semana una fila por juego en una hoja histórica y envía un correo con la tabla y los cambios. Entra una lista de AppIDs; sale un informe semanal. No requiere clave de pago y funciona en n8n Cloud o auto-alojado.

## Cómo usarla

1. 1. Crea la hoja con las pestañas competidores e historico
2. 2. Pon los AppIDs de tu juego y de tus rivales
3. 3. Lee el correo del lunes antes de fijar precio o rebajas

## Cuándo usarla

Úsalo cuando estás decidiendo precio, fecha de lanzamiento o rebajas y necesitas saber qué hacen los juegos parecidos al tuyo sin dedicar media mañana a mirar fichas.

## Cómo ganar dinero con ella

Sustituye 2-3 horas semanales de mirar fichas de Steam a mano y te avisa de las rebajas de la competencia antes de fijar la tuya.

- Estudio de precios para desarrolladores indies que van a lanzar y quieren ver qué cobran juegos parecidos.
- Seguimiento de rebajas de la competencia para estudios que preparan su campaña de rebajas en Steam.
- Informe comparativo para consultoras de marketing de videojuegos que atienden a varios estudios.

**Precio orientativo:** 100–250 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Todos los lunes por la mañana recorre una lista de AppIDs (el tuyo y los de tu competencia), saca de las APIs públicas de Steam y de SteamSpy el precio actual, el descuento, el número de reseñas y el porcentaje de positivas, lo guarda con fecha en una hoja y te envía un correo con la tabla y los cambios respecto a la semana anterior.
Para estudios indie que van a poner precio, entrar en un festival o preparar unas rebajas y quieren datos en vez de intuición.

## Lo que necesitas antes
- n8n autoalojado (gratuito, Community Edition) o n8n Cloud (prueba gratuita temporal y después planes de pago).
- Una hoja de Google con dos pestañas: «competidores» (columnas: appid, nombre) y «historico» (columnas: fecha, appid, nombre, precio_eur, descuento, resenas_totales, pct_positivas).
- Credencial OAuth de Google para Sheets y Gmail (mismo proyecto de Google Cloud; habilita «Google Sheets API» y «Gmail API»).
- Ninguna clave de pago: la API de la tienda de Steam y la de SteamSpy son públicas.
- Los AppIDs de tus competidores: los sacas de la URL de cada ficha de Steam.

## Los nodos, en orden
1. **Schedule Trigger** — Modo «Cron», expresión `0 8 * * 1` (lunes a las 8:00). Ajusta la zona horaria del workflow a Europe/Madrid.
2. **Google Sheets** («Get Row(s)», pestaña «competidores») — Devuelve un item por competidor.
3. **Loop Over Items** (antes «Split In Batches») — Tamaño de lote 1. Así consultas los juegos de uno en uno y no te bloquean.
4. **HTTP Request** «Precio» — GET `https://store.steampowered.com/api/appdetails?appids={{ $json.appid }}&cc=es&l=spanish&filters=price_overview,basic`.
5. **HTTP Request** «SteamSpy» — GET `https://steamspy.com/api.php?request=appdetails&appid={{ $('Loop Over Items').item.json.appid }}`. SteamSpy pide máximo 1 petición por segundo.
6. **Wait** — 1,5 segundos, dentro del bucle, antes de volver al Loop. Es lo que evita que te corten.
7. **Code** — Junta las dos respuestas y arma la fila limpia (código abajo).
8. **Google Sheets** («Append Row», pestaña «historico») — Guarda la foto de esta semana.
9. **Code** «Comparador» — Al salir del bucle, compara con las filas de la semana pasada y monta una tabla HTML con flechas de subida/bajada.
10. **Gmail** («Send») — Asunto: `Radar Steam semana {{ $now.format('W') }}`. Cuerpo: HTML del nodo anterior.

## El nodo Code que arma la fila
```javascript
const appid = String($('Loop Over Items').item.json.appid);
const tienda = $('Precio').first().json[appid]?.data || {};
const spy = $('SteamSpy').first().json || {};
const precio = tienda.price_overview;
const pos = Number(spy.positive || 0);
const neg = Number(spy.negative || 0);
return [{ json: {
  fecha: new Date().toISOString().slice(0, 10),
  appid,
  nombre: tienda.name || spy.name || appid,
  precio_eur: precio ? (precio.final / 100).toFixed(2) : '0.00',
  descuento: precio ? precio.discount_percent : 0,
  resenas_totales: pos + neg,
  pct_positivas: (pos + neg) ? Math.round((pos * 100) / (pos + neg)) : 0
}}];
```

## Cómo probarla
- Empieza con 3 competidores para no esperar. Ejecuta a mano y mira que la pestaña «historico» recibe 3 filas con precio distinto de 0.
- Un juego gratuito o no publicado devuelve `success: false`: comprueba que tu Code no revienta con eso (por eso están los `?.` y los valores por defecto).
- Lanza dos veces el flujo cambiando la fecha a mano en una fila para ver que el comparador detecta la variación.

## Qué puede salir mal
- **SteamSpy vacío**: sus datos se refrescan cada varias horas y a veces devuelve `{}`. El código ya lo tolera; la fila saldrá con 0 reseñas y esa semana la ignoras.
- **Precios por país**: si quitas `cc=es` te devolverá dólares. Déjalo puesto para trabajar siempre en euros.
- **Peticiones seguidas**: sin el nodo Wait, con 15 competidores Steam empieza a devolver `null`. 1,5 s por juego es el punto seguro.
- **Hoja que crece**: una fila por competidor y semana. Con 15 competidores son 780 filas al año, no hay problema.

## Cuánto cuesta
0 €. Ambas APIs son públicas y gratuitas, Google Sheets y Gmail entran en la cuenta gratuita, y una ejecución semanal cabe en cualquier plan de n8n.
