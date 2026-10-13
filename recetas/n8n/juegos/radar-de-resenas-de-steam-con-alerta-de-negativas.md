# Radar de reseñas de Steam con alerta de negativas…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Cada 30 minutos lee las reseñas nuevas de tu juego en Steam, las apunta en una hoja y te avisa en Discord cuando entra una negativa.

## Qué es y qué hace

Flujo de n8n que cada 30 minutos consulta la API pública de reseñas de Steam, guarda las nuevas en Google Sheets y envía un aviso a Discord cuando entra una negativa o un jugador con muchas horas. Entran el AppID del juego y las credenciales de Google; sale una fila por reseña y un mensaje en el canal. No necesita clave de Steam y funciona en n8n Cloud o auto-alojado.

## Cómo usarla

1. 1. Pon el AppID de tu juego
2. 2. Conecta Google Sheets y el webhook de Discord
3. 3. Responde a las negativas el mismo día desde la hoja

## Cuándo usarla

Úsalo cuando ya tienes el juego publicado (o en Acceso Anticipado) en Steam y quieres enterarte de las quejas en minutos en vez de días, sin vivir pegado a la página de la tienda.

## Cómo ganar dinero con ella

Te ahorra entrar 10 veces al día a mirar reseñas (unas 3 h al mes) y te deja responder a una negativa el mismo día, cuando todavía sirve de algo.

- Alerta de reseñas negativas para estudios recién publicados que necesitan reaccionar a fallos en minutos.
- Seguimiento de reseñas en acceso anticipado para desarrolladores que quieren responder y mejorar la nota.
- Configuración de alertas de Steam para publishers pequeños con varios juegos en la tienda.

**Precio orientativo:** 120–300 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Consulta la API pública de reseñas de Steam cada 30 minutos, guarda cada reseña nueva en una hoja de cálculo y manda un aviso a tu Discord si la reseña es negativa o si el jugador tiene muchas horas jugadas.
Pensado para desarrolladores solitarios y estudios de 2-5 personas que acaban de publicar y necesitan reaccionar rápido a los fallos que reporta la gente.

## Lo que necesitas antes
- Una cuenta de n8n: el plan gratuito de n8n Cloud o, mejor, n8n auto-alojado con Docker en tu propio ordenador o en un VPS de 5 €/mes.
- El AppID de tu juego: es el número de la URL de tu ficha, por ejemplo store.steampowered.com/app/**1234560**/ → el AppID es 1234560.
- Una cuenta de Google para Google Sheets. La credencial se crea en console.cloud.google.com: proyecto nuevo → APIs y servicios → Habilitar «Google Sheets API» → Credenciales → ID de cliente OAuth → pegas el «OAuth Redirect URL» que te da n8n.
- Un webhook de Discord: en tu servidor, Ajustes del canal → Integraciones → Webhooks → Nuevo webhook → Copiar URL.
- La API de reseñas de Steam es pública y gratuita: no necesitas clave de API ni permiso de Valve.

## Los nodos, en orden
1. **Schedule Trigger** — Modo «Interval», cada 30 minutos. No lo pongas cada minuto: no aporta nada y te comes peticiones.
2. **Google Sheets** (operación «Get Row(s)») — Lee la hoja «reseñas» para saber cuáles ya tienes. Columnas: fecha, recommendationid, autor, horas_jugadas, positiva, idioma, texto.
3. **HTTP Request** — Method GET, URL: `https://store.steampowered.com/appreviews/1234560?json=1&filter=recent&language=all&num_per_page=100&purchase_type=all`. En «Options» activa «Response → Never Error» para que un fallo puntual no rompa el flujo.
4. **Code** — Compara las reseñas que llegan con las que ya están en la hoja y deja pasar solo las nuevas (código completo abajo).
5. **IF** — Condición: `{{ $json.positiva }}` es igual a `false`. Rama true → aviso urgente; rama false → solo se guarda.
6. **Discord** (rama true) — Nodo Discord con la URL del webhook. Mensaje: `⚠️ Reseña NEGATIVA de {{ $json.autor }} ({{ $json.horas_jugadas }} h jugadas)` y debajo `{{ $json.texto }}`.
7. **Google Sheets** (operación «Append Row») — Las dos ramas terminan aquí y añaden la fila a la hoja «reseñas».

## El nodo Code
```javascript
const existentes = new Set(
  $('Google Sheets').all().map(i => String(i.json.recommendationid))
);
const datos = $input.first().json;
const salida = [];
for (const r of (datos.reviews || [])) {
  if (existentes.has(String(r.recommendationid))) continue;
  salida.push({ json: {
    recommendationid: r.recommendationid,
    fecha: new Date(r.timestamp_created * 1000).toISOString(),
    autor: r.author.steamid,
    horas_jugadas: Math.round((r.author.playtime_forever || 0) / 60),
    positiva: r.voted_up,
    idioma: r.language,
    texto: (r.review || '').slice(0, 900)
  }});
}
return salida;
```

## Cómo probarla
- Crea la hoja con la fila de cabeceras ANTES de ejecutar nada, o el nodo Sheets fallará.
- Pulsa «Execute Workflow» a mano: la primera vez volcará hasta 100 reseñas de golpe. Es normal; deja que se guarden y a partir de ahí solo entrarán las nuevas.
- Para probar la alerta sin esperar a una negativa real, cambia temporalmente el IF a `positiva` igual a `true` y comprueba que llega el mensaje a Discord.

## Qué puede salir mal
- **Duplicados**: si la hoja se queda vacía o cambias de hoja, volverá a volcar todo. El campo `recommendationid` es el que evita repetir; no lo borres.
- **Hoja enorme**: cuando pases de unas 5.000 filas, el nodo «Get Row(s)» se vuelve lento. Usa la opción de leer solo la columna `recommendationid` o parte la hoja por año.
- **Zona horaria**: Steam devuelve tiempo Unix en UTC. En Ajustes del workflow pon «Europe/Madrid» para que las horas cuadren con las tuyas.
- **Steam te corta**: si consultas muy seguido puede devolver vacío un rato. Con 30 minutos no pasa nunca; y con «Never Error» activado el flujo simplemente no añade nada esa vez.

## Cuánto cuesta
Gratis de principio a fin: API de Steam pública, Google Sheets gratis, Discord gratis. n8n auto-alojado es 0 € (más el VPS si lo pones fuera de tu equipo). En n8n Cloud gratuito, 48 ejecuciones al día caben de sobra en el límite mensual.
