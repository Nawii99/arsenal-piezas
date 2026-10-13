# Cazador de convocatorias, jams y festivales indie…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Rastrea las convocatorias de jams, festivales y ayudas para videojuegos, se queda con las que encajan contigo y te las mete en el calendario con aviso antes de que cierre el plazo.

## Qué es y qué hace

Cada día consulta feeds de jams de itch.io, RSS de la industria y las páginas de ayudas que indiques, filtra por tus palabras clave y guarda las convocatorias nuevas en una hoja. Crea eventos en Google Calendar el día de cierre con un aviso siete días antes y te envía un resumen semanal. Entrada: fuentes y palabras clave; salida: calendario y resumen. Se monta en n8n con Sheets, Calendar y Gmail.

## Cómo usarla

1. Crear la hoja Convocatorias con sus fuentes
2. Añadir tus palabras clave
3. Probar con el feed de jams
4. Activar el calendario y el resumen semanal

## Cuándo usarla

Cuando quieras presentar tu juego a festivales, jams o ayudas públicas y siempre te enteres cuando el plazo ya se ha cerrado.

## Cómo ganar dinero con ella

Una sola ayuda o selección en festival vale entre 2.000 y 20.000 € en dinero o visibilidad; llegar a plazo es la mitad del trabajo.

- Gestionar la búsqueda de jams y festivales para estudios indie que quieren presentar sus juegos.
- Ofrecer a agencias de prensa de videojuegos un calendario de convocatorias por cliente.
- Montar el sistema para un colectivo de desarrolladores que comparte plazos.

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada día consulta varias fuentes de convocatorias: el feed de jams de itch.io, los feeds RSS de webs de la industria y las páginas de ayudas que le indiques. Filtra por tus palabras clave y por presupuesto o temática, descarta las que ya te enseñó y las apunta en una hoja.
De las que superan el filtro, crea un evento en Google Calendar el día del cierre y otro aviso 7 días antes, y te manda un resumen semanal con lo nuevo. Para desarrolladores indie españoles que quieren presentarse a jams, festivales y subvenciones.

## Lo que necesitas antes
Cuenta de Google con Sheets, Calendar y Gmail conectados en n8n.
Una hoja «Convocatorias» con dos pestañas: «fuentes» (columnas: nombre, url, tipo, activo) y «encontradas» (columnas: fecha_deteccion, titulo, fuente, url, cierre, encaje, estado).
En «fuentes» empieza con: el RSS de jams de itch.io (`https://itch.io/jams.xml`), el feed de tu asociación autonómica de videojuegos, el de DEV (Desarrollo Español de Videojuegos) y el del ICEX o tu comunidad si publican ayudas por RSS.
Tus palabras clave de encaje: género, plataforma, si tu juego es en español, si eres autónomo o SL, si estás en fase de prototipo o de producción.

## Los nodos, en orden
**Schedule Trigger** — Cron: `0 7 * * *` (diario a las 7:00, Timezone Europe/Madrid).
**Google Sheets** — Get Row(s) de la pestaña «fuentes», Return All.
**Filter** — `{{$json.activo}}` igual a `si`.
**Split In Batches** — Batch Size: 1.
**Switch** — sobre `{{$json.tipo}}`: salida `rss` y salida `web`.
**RSS Read** (salida rss) — URL: `{{$json.url}}`. En Settings activa «Continue On Fail» para que una fuente caída no tumbe el flujo.
**HTTP Request** (salida web) — GET a `{{$json.url}}`, Response Format: Text, seguido de un nodo **HTML** con Operation: Extract HTML Content y selectores CSS de los títulos y enlaces (mira el código de la página con clic derecho → Inspeccionar).
**Code** — normaliza, puntúa el encaje y busca la fecha de cierre (abajo).
**Filter** — `{{$json.encaje}}` mayor o igual a 2.
**Remove Duplicates** — Operation: Remove Items Seen In Previous Executions, Value to Dedupe On: `{{$json.url}}`.
**Google Sheets** — Append Row en «encontradas».
**IF** — `{{$json.cierre}}` no está vacío.
**Google Calendar** — Create Event, Start: `{{$json.cierre}}`, All Day activado, Summary: `⏳ CIERRA: {{$json.titulo}}`, Description: la URL. En Options → Reminders añade uno de 10.080 minutos (7 días).
**Schedule Trigger** aparte (viernes 17:00) + **Google Sheets** Get Row(s) + **Code** + **Gmail** — resumen semanal de lo detectado con estado pendiente.

## El nodo Code
```javascript
const claves = { alta: ['subvención','ayuda','grant','funding','beca','publisher','pitch'], media: ['festival','showcase','indie','jam','award','premio','convocatoria'] };
const descartar = ['nsfw','crypto','nft','hentai'];
const salida = [];
for (const item of $input.all()) {
  const d = item.json;
  const titulo = (d.title || d.titulo || '').trim();
  const texto = (titulo + ' ' + (d.contentSnippet || d.content || '')).toLowerCase();
  if (descartar.some(p => texto.includes(p))) continue;
  let encaje = 0;
  for (const p of claves.alta) if (texto.includes(p)) encaje += 2;
  for (const p of claves.media) if (texto.includes(p)) encaje += 1;
  const m = texto.match(/(\d{1,2})[\/\- ](\d{1,2})[\/\- ](20\d{2})/) || texto.match(/(20\d{2})-(\d{2})-(\d{2})/);
  let cierre = '';
  if (m) { cierre = m[0].includes('-') && m[1].length === 4 ? m[0] : `${m[3]}-${String(m[2]).padStart(2,'0')}-${String(m[1]).padStart(2,'0')}`; }
  salida.push({ json: { fecha_deteccion: new Date().toISOString().slice(0,10), titulo, fuente: $('Split In Batches').item.json.nombre, url: d.link || d.url || '', cierre, encaje, estado: 'pendiente' } });
}
return salida;
```

## Cómo probarla
Empieza con una sola fuente RSS (la de jams de itch.io) y ejecuta a mano: deberías ver decenas de items. Ajusta las palabras clave hasta que el filtro deje pasar 5-10 al día, no 200.
Comprueba que los eventos que crea en Calendar tienen la fecha correcta: la detección de fechas en texto libre falla a menudo, por eso el campo puede quedar vacío y entonces no se crea evento (mejor eso que un evento con fecha inventada).
Deja correr una semana antes de fiarte y revisa a mano lo que descartó, por si el filtro es demasiado duro.

## Qué puede salir mal
Muchas webs de ayudas públicas no tienen RSS y cambian el HTML: los selectores del nodo HTML se rompen. Revísalos cada pocos meses y mantén siempre una fuente manual: mira tú una vez al mes la web de tu comunidad autónoma.
Fechas en texto: «hasta el 15 de marzo» no la pilla la expresión regular. Si te importa mucho una fuente, añade un caso específico o apunta la fecha a mano en la hoja.
No hagas peticiones agresivas a webs pequeñas: una vez al día es más que suficiente y respeta su robots.txt.
La deduplicación por URL falla si la web cambia el enlace: complementa comparando también el título con **Remove Duplicates** sobre `{{$json.titulo}}`.
Zonas horarias: pon Europe/Madrid en los ajustes del workflow, o los eventos de todo el día aparecerán un día antes.

## Cuánto cuesta
Todo gratis: RSS, Sheets, Calendar, Gmail y n8n auto-alojado. Solo el servidor si no lo tienes.
En Make cabe en el plan gratuito con 4-5 fuentes diarias; con más te quedarías corto de operaciones.
