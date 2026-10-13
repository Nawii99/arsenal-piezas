# Termómetro de reseñas de Steam por temas…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Descarga cada día las reseñas nuevas de tu juego en Steam, las clasifica por tema (fallos, rendimiento, precio, traducción) y te avisa al momento si aparecen cuelgues.

## Qué es y qué hace

Flujo de n8n que lee cada día las reseñas nuevas de tu juego desde la API pública de Steam, las guarda en Google Sheets y asigna a cada una un tema (fallos, rendimiento, precio, traducción) según las palabras del texto. Entra el AppID del juego; sale una hoja con cada reseña clasificada y un aviso en Discord si aparecen cuelgues repetidos. Funciona en n8n Cloud o auto-alojado y no necesita clave de API.

## Cómo usarla

1. 1. Importa el flujo y pon el AppID de tu juego
2. 2. Conecta Google Sheets y el webhook de Discord
3. 3. Revisa una vez por semana las palabras clave de cada tema

## Cuándo usarla

Úsalo cuando ya tienes el juego publicado o en acceso anticipado y no te da la vida para leer todas las reseñas, pero necesitas enterarte el mismo día de un fallo que se repite.

## Cómo ganar dinero con ella

Te ahorra una hora diaria de leer reseñas y detecta un fallo grave en horas en vez de en semanas, cuando la nota media ya ha caído.

- Alerta temprana de reseñas para estudios indie que ya han publicado y quieren detectar fallos antes de que baje la nota.
- Informe semanal de temas de reseñas para desarrolladores que preparan un parche y necesitan priorizar las quejas.
- Configuración del flujo para estudios pequeños con varios juegos en Steam, uno por cada AppID.

**Precio orientativo:** 150–400 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Consulta la API pública de reseñas de Steam, guarda cada reseña nueva en una hoja de cálculo y le pone una etiqueta de tema según las palabras que aparecen en el texto.
Es para el estudio pequeño o el desarrollador en solitario que ya tiene el juego en tienda y quiere un sistema de alerta temprana sin contratar herramientas de escucha.

## Lo que necesitas antes
Una cuenta de n8n (el plan gratuito de n8n Cloud o auto-alojado con Docker en tu PC).
El AppID de tu juego: es el número que sale en la URL de la ficha de Steam, `store.steampowered.com/app/1234567/`.
Una cuenta de Google para Google Sheets y las credenciales OAuth de Google en n8n (Settings > Credentials > Google Sheets OAuth2).
Un webhook de Discord: en tu servidor, Ajustes del canal > Integraciones > Webhooks > Nuevo webhook > Copiar URL.
La API de reseñas de Steam es pública y NO necesita clave.
Crea una hoja llamada `resenas` con estas columnas en la fila 1: `id`, `fecha`, `idioma`, `positiva`, `horas`, `tema`, `texto`, `url`.

## Los nodos, en orden
1) **Schedule Trigger** — modo `Every Day`, hora 9:00. En Settings del flujo pon la zona horaria `Europe/Madrid` para que no se te dispare a las 11.
2) **Google Sheets** (operación `Get Row(s)`) — documento tu hoja, pestaña `resenas`. Devuelve lo ya guardado para no duplicar.
3) **HTTP Request** — método GET, URL: `https://store.steampowered.com/appreviews/TU_APPID?json=1&filter=recent&language=all&num_per_page=100&purchase_type=all&day_range=30`. En Options activa `Response > Never Error` para que un 429 no te tumbe el flujo.
4) **Code** — modo `Run Once for All Items`. Filtra las reseñas nuevas y les pone tema.
5) **Google Sheets** (operación `Append Row`) — pestaña `resenas`, mapea las columnas con los campos que devuelve el Code.
6) **IF** — condición: `{{ $json.positiva }}` es igual a `false` **Y** `{{ $json.tema }}` contiene `cuelgue`.
7) **Discord** (o **HTTP Request** POST al webhook) — mensaje: `🔴 Reseña negativa por cuelgues ({{ $json.horas }}h jugadas): {{ $json.texto }} — {{ $json.url }}`.

## El trozo de código (nodo Code)
```javascript
const vistos = new Set($('Google Sheets').all().map(i => String(i.json.id)));
const datos = $('HTTP Request').first().json;
const temas = {
  cuelgue: ['crash', 'cuelga', 'se cierra', 'crashea', 'freeze', 'congela'],
  rendimiento: ['fps', 'lag', 'tirones', 'optimiz', 'stutter', 'rendimiento'],
  precio: ['caro', 'precio', 'vale la pena', 'overpriced', 'rebaja'],
  idioma: ['traduc', 'spanish', 'idioma', 'subtitul', 'localiz'],
  control: ['mando', 'gamepad', 'controles', 'teclas', 'rebind'],
  contenido: ['corto', 'aburrid', 'repetitiv', 'contenido', 'horas']
};
const salida = [];
for (const r of (datos.reviews || [])) {
  if (vistos.has(String(r.recommendationid))) continue;
  const texto = (r.review || '').toLowerCase();
  const encontrados = Object.keys(temas).filter(t => temas[t].some(p => texto.includes(p)));
  salida.push({ json: {
    id: r.recommendationid,
    fecha: new Date(r.timestamp_created * 1000).toISOString().slice(0, 10),
    idioma: r.language,
    positiva: r.voted_up,
    horas: Math.round((r.author?.playtime_forever || 0) / 60),
    tema: encontrados.length ? encontrados.join(', ') : 'sin clasificar',
    texto: (r.review || '').slice(0, 900),
    url: 'https://steamcommunity.com/profiles/' + r.author.steamid + '/recommended/'
  }});
}
return salida;
```

## Cómo probarla
Ejecuta el flujo a mano con el botón `Test workflow` y mira que el HTTP Request devuelva `success: 1` y un array `reviews`.
La primera vez te meterá hasta 100 filas de golpe: es normal, es la carga inicial. Vuelve a ejecutarlo y debe añadir cero filas.
Escribe tú mismo la palabra `crashea` en una fila de prueba y comprueba que el IF y el Discord se disparan.

## Qué puede salir mal
Steam limita las peticiones: si pides muchas veces seguidas te devuelve vacío. Con una ejecución al día no lo notas.
Los duplicados salen si la hoja crece mucho y el nodo Sheets no devuelve todas las filas: en el nodo Sheets pon `Return All` activado.
Las fechas de Steam vienen en formato Unix y en UTC. El código ya las convierte, pero si comparas con horas locales resta o suma según sea invierno o verano.
Si el juego tiene pocas reseñas puede que `reviews` venga vacío: el código lo aguanta y devuelve una lista vacía sin romper nada.

## Cuánto cuesta
La API de Steam es gratis. Google Sheets es gratis. Discord es gratis.
n8n auto-alojado es gratis; su plan cloud de inicio ronda los 20 € al mes si no quieres montar servidor.
Con una ejecución diaria cabes de sobra en cualquier plan gratuito.
