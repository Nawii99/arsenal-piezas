# Fallos reportados en Discord al tablero, sin duplicados…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Recoge lo que la gente escribe en tu canal de fallos, lo compara con lo ya reportado y, si es lo mismo, suma un voto en vez de crear otra ficha.

## Qué es y qué hace

Flujo de n8n con un bot de Discord que recoge los mensajes del canal de fallos, los compara con los ya registrados usando parecido de texto y, si coinciden, suma un voto en lugar de crear otra ficha. Entran los mensajes del canal; sale una hoja de fallos ordenada por número de afectados. Sirve para comunidades de juegos con muchos reportes repetidos, sin pagar un gestor de incidencias.

## Cómo usarla

1. 1. Crea el bot en el portal de Discord y activa Message Content
2. 2. Prepara la hoja fallos
3. 3. Revisa cada lunes la lista ordenada por votos

## Cuándo usarla

Úsalo cuando tienes una comunidad en Discord que reporta fallos a montones y el mismo problema aparece cuarenta veces mientras los raros se pierden en el ruido.

## Cómo ganar dinero con ella

Te da la lista real de fallos ordenada por cuánta gente los sufre, para arreglar primero lo que más duele en vez de lo último que has leído.

- Clasificador de reportes de bugs para estudios con comunidad activa que reciben cientos de mensajes al día.
- Lista priorizada de fallos para desarrolladores que quieren arreglar primero lo que más jugadores sufren.
- Configuración de bot de Discord para moderadores de comunidades de juegos que llevan la cuenta a mano.

**Precio orientativo:** 120–300 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada mensaje del canal de fallos llega al flujo, se limpia y se compara con los fallos ya abiertos usando parecido de texto. Si se parece mucho, suma un voto; si no, crea una ficha nueva.
Para el estudio con comunidad activa que no quiere pagar un gestor de incidencias ni leer 300 mensajes al día.

## Lo que necesitas antes
Un servidor de Discord con un canal `#fallos` y permisos de administrador en él.
Una aplicación de Discord con bot: entra en `discord.com/developers/applications`, crea la app, pestaña Bot, copia el token y activa el intent `Message Content`. Invítalo al servidor con permiso de leer y escribir mensajes.
En n8n, la credencial `Discord Bot API` con ese token. Si te resulta pesado, alternativa más simple: usa el nodo **Webhook** de n8n y una automatización de Discord que reenvíe los mensajes.
Credenciales de Google Sheets OAuth2.
Una hoja `fallos` con columnas: `id`, `fecha`, `texto`, `autor`, `votos`, `estado`, `enlace`.

## Los nodos, en orden
1) **Discord Trigger** — evento `Message Created`, limitado al canal `#fallos`.
2) **IF** — descarta mensajes de menos de 15 caracteres y los del propio bot: `{{ $json.content.length }}` mayor que `15`.
3) **Google Sheets** (`Get Row(s)`) — pestaña `fallos`, `Return All` activado, filtrando `estado` distinto de `cerrado`.
4) **Code** — normaliza y busca parecidos (ver abajo).
5) **IF** — `{{ $json.duplicado }}` es igual a `true`.
6a) Rama verdadera: **Google Sheets** (`Update Row`) buscando por `id` y subiendo `votos` en uno. Luego **Discord** (`Send Message`) respondiendo: `Ya lo tenemos apuntado ({{ $json.votos }} personas). ¡Gracias!`.
6b) Rama falsa: **Google Sheets** (`Append Row`) con la ficha nueva, y **Discord** respondiendo `Apuntado como #{{ $json.id }}, gracias por avisar.`
7) **Schedule Trigger** aparte, semanal, que lea la hoja y te mande por **Gmail** el top 10 por votos.

## El trozo de código (nodo Code)
```javascript
function normaliza(t) {
  return (t || '').toLowerCase()
    .normalize('NFD').replace(/[̀-ͯ]/g, '')
    .replace(/https?:\/\/\S+/g, ' ')
    .replace(/[^a-z0-9ñ ]/g, ' ')
    .split(/\s+/).filter(p => p.length > 3);
}
function parecido(a, b) {
  const A = new Set(a), B = new Set(b);
  if (!A.size || !B.size) return 0;
  let comunes = 0;
  for (const p of A) if (B.has(p)) comunes++;
  return comunes / (A.size + B.size - comunes);
}
const msg = $('Discord Trigger').first().json;
const nuevo = normaliza(msg.content);
let mejor = null, mejorPunt = 0;
for (const f of $('Google Sheets').all()) {
  const p = parecido(nuevo, normaliza(f.json.texto));
  if (p > mejorPunt) { mejorPunt = p; mejor = f.json; }
}
if (mejorPunt >= 0.45 && mejor) {
  return [{ json: { duplicado: true, id: mejor.id, votos: (Number(mejor.votos) || 1) + 1, texto: mejor.texto } }];
}
return [{ json: {
  duplicado: false,
  id: 'F' + Date.now().toString().slice(-6),
  fecha: new Date().toISOString().slice(0, 10),
  texto: (msg.content || '').slice(0, 500),
  autor: msg.author?.username || 'anónimo',
  votos: 1,
  estado: 'abierto',
  enlace: 'https://discord.com/channels/' + msg.guild_id + '/' + msg.channel_id + '/' + msg.id
} }];
```

## Cómo probarla
Escribe en el canal: «el juego se cierra al entrar al nivel 3». Debe crear ficha nueva.
Escribe después: «se me cierra el juego cuando entro en el nivel tres». Debe detectarlo como duplicado y sumar voto.
Escribe algo distinto («no se oye la música») y comprueba que crea otra ficha, no la suma a la anterior.
Si te agrupa cosas que no van juntas, sube el umbral de `0.45` a `0.6`. Si no agrupa nada, bájalo a `0.35`.

## Qué puede salir mal
Mensajes en varios idiomas no se parecen entre sí aunque describan lo mismo: si tu comunidad es internacional, pon el umbral bajo y revisa a mano una vez por semana.
Si la hoja pasa de unos miles de filas la comparación se hace lenta: filtra por `estado` abierto, que es lo que ya hace el paso 3.
Las capturas de pantalla no se leen: guarda el enlace al mensaje (ya lo hace el código) para poder ir a verlas.
El intent `Message Content` de Discord hay que activarlo a mano en el panel de desarrollador o el bot recibirá mensajes vacíos.

## Cuánto cuesta
Gratis: Discord, Sheets, Gmail y n8n auto-alojado.
El único gasto sería n8n Cloud si no te montas servidor, y aun así este flujo consume poquísimas ejecuciones salvo comunidad muy grande.
