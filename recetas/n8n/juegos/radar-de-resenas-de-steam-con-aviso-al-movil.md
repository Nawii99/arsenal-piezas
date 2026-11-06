# Radar de reseñas de Steam con aviso al móvil…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Vigila cada hora las reseñas nuevas de tu juego en Steam, las guarda en una hoja y te avisa por Telegram cuando entra una negativa. Pensado para estudios indie.

## Qué es y qué hace

Receta de n8n que cada hora consulta la API pública de reseñas de Steam de tu juego, guarda las nuevas en una hoja de Google Sheets y envía a Telegram las negativas. Entrada: el AppID del juego, que aparece en la URL de la ficha de Steam; no necesita clave. Salida: registro de reseñas y avisos de negativas para reaccionar a bugs en horas. Pensado para estudios indie con el juego ya publicado.

## Cómo usarla

1. Anota el AppID de tu juego
2. Conecta Sheets y el bot de Telegram
3. Activa el flujo y revisa las negativas cada día

## Cuándo usarla

Úsalo cuando ya tengas el juego publicado en Steam y quieras enterarte el mismo día de las quejas, en vez de revisar la pestaña de reseñas a mano.

## Cómo ganar dinero con ella

Sustituye la revisión manual diaria (unos 20-30 min/día) y te permite reaccionar a un bug en horas en vez de días, que es lo que salva la nota del juego.

- Vigilancia de reseñas para un estudio indie con un juego de lanzamiento…
- Respuesta rápida a bugs para un juego con comunidad activa…
- Informe semanal de reseñas para el community manager de un juego…

**Precio orientativo:** 120–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada hora consulta la API pública de reseñas de Steam de tu juego, guarda las nuevas en una Google Sheet y te manda un mensaje de Telegram con las negativas. Es para el desarrollador o el community manager de un juego ya publicado que necesita reaccionar rápido a quejas repetidas.

## Lo que necesitas antes
- Cuenta de n8n (nube gratuita o auto-alojado con Docker).
- El **AppID** de tu juego: es el número que aparece en la URL de tu ficha de Steam, `store.steampowered.com/app/**1234560**/`. No hace falta clave de API: el endpoint de reseñas es público.
- Cuenta de Google para Sheets: en n8n, Credentials > Google Sheets OAuth2, y autorizas con tu cuenta.
- Un bot de Telegram: escribe a `@BotFather`, comando `/newbot`, te da un token. Luego escribe algo a tu bot y abre `https://api.telegram.org/bot<TOKEN>/getUpdates` para sacar tu `chat_id`.
- Una hoja de cálculo nueva con las columnas: `recommendationid`, `fecha`, `voted_up`, `horas_jugadas`, `idioma`, `texto`, `url`.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: `Hours`, Hours Between Triggers: `1`.
2. **HTTP Request** (llamado `Traer reseñas`) — Method: `GET`. URL: `https://store.steampowered.com/appreviews/1234560?json=1&filter=recent&language=all&num_per_page=100&purchase_type=all&review_type=all&day_range=30` (cambia el número por tu AppID). Response > Format: `JSON`. Activa Options > Response > Never Error para que un 429 no te tire el flujo.
3. **Code** (llamado `Aplanar reseñas`) — Mode: `Run Once for All Items`. Convierte el array `reviews` en un item por reseña y calcula la URL. Código completo abajo.
4. **Google Sheets** (llamado `Leer ya guardadas`) — Resource: `Sheet Within Document`, Operation: `Get Row(s)`. Document: tu hoja. Sheet: `Hoja 1`. Sin filtros: trae todas.
5. **Merge** — Mode: `Combine`, Combine By: `Matching Fields`, Input 1 Field: `recommendationid`, Input 2 Field: `recommendationid`, Output Type: `Keep Non-Matches`, y marca Input 1 como el que conserva. Así solo pasan las reseñas que aún no están en la hoja.
6. **Google Sheets** (llamado `Guardar nuevas`) — Operation: `Append Row`. Mapping Column Mode: `Map Each Column Manually` y enlaza cada campo del item con su columna.
7. **IF** (llamado `¿Es negativa?`) — Condition: Boolean, valor izquierdo `{{ $json.voted_up }}`, operación `is false`.
8. **Telegram** (rama true) — Operation: `Send Message`. Chat ID: el tuyo. Text: `⚠️ Reseña NEGATIVA en Steam\n\n{{ $json.texto.slice(0,600) }}\n\nHoras jugadas: {{ $json.horas_jugadas }}\nIdioma: {{ $json.idioma }}\n{{ $json.url }}`.

## El código del nodo Code
```javascript
const salida = [];
const datos = $input.first().json;
const reseñas = datos.reviews || [];
for (const r of reseñas) {
  salida.push({
    json: {
      recommendationid: r.recommendationid,
      fecha: new Date(r.timestamp_created * 1000).toISOString().slice(0, 19).replace('T', ' '),
      voted_up: r.voted_up,
      horas_jugadas: Math.round((r.author?.playtime_forever || 0) / 60),
      idioma: r.language,
      texto: (r.review || '').replace(/\s+/g, ' ').trim(),
      url: 'https://steamcommunity.com/profiles/' + r.author.steamid + '/recommended/' + datos.query_summary?.review_score_desc
    }
  });
}
return salida;
```

## Cómo probarla
- Pulsa **Execute Workflow** con el Schedule desconectado y mira que el HTTP Request devuelve `success: 1` y un array `reviews` con contenido.
- La primera ejecución te meterá hasta 100 reseñas de golpe en la hoja: es normal, es la carga inicial. Desactiva temporalmente el nodo de Telegram para no recibir 40 avisos.
- Vuelve a ejecutar a mano: la segunda vez no debe añadir ninguna fila. Si añade duplicados, revisa el Merge.

## Qué puede salir mal
- **Duplicados**: casi siempre es que el `recommendationid` se guarda como número en un sitio y como texto en otro. En el nodo Code fuerza `String(r.recommendationid)` y formatea la columna de la hoja como Texto sin formato.
- **Límite de Steam**: la API pública tolera bien una llamada por hora; si pones cada 5 minutos te devolverá 429. Con una vez por hora vas sobrado.
- **Hoja enorme**: cuando pases de 5.000 filas, el nodo `Leer ya guardadas` se vuelve lento. Cambia a leer solo las últimas 300 filas usando el rango `Hoja 1!A2:G300` ordenado por fecha descendente, o pásate a Airtable/Postgres.
- **Zona horaria**: Steam devuelve tiempo Unix UTC. Si quieres hora española, añade `+ 2*3600*1000` en verano; mejor aún, guarda en UTC y no te compliques.

## Cuánto cuesta
- La API de reseñas de Steam: **gratis** y sin clave.
- Telegram: **gratis**.
- Google Sheets: **gratis** con cuenta personal.
- n8n: gratis si lo auto-alojas (un VPS de 5 €/mes te sobra) o con el plan gratuito de prueba de n8n Cloud; su plan de pago empieza sobre 20-24 €/mes si prefieres no mantener servidor. Con una ejecución por hora son ~720 ejecuciones al mes.
