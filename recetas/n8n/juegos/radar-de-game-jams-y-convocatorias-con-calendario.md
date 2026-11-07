# Radar de game jams y convocatorias con calendario…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Rastrea a diario las jams y convocatorias nuevas, se queda solo con las que encajan contigo por tema y fechas, y te las mete en el calendario con recordatorio.

## Qué es y qué hace

Flujo de n8n que lee cada día el feed público de jams de itch.io y otras convocatorias, filtra por palabras clave y descarta las que tienen palabras de exclusión o el plazo cerrado. Entra la lista de palabras y los feeds; sale una hoja con cada convocatoria nueva y un evento en Google Calendar dos días antes del cierre. Requiere Google Calendar y Google Sheets conectados en n8n.

## Cómo usarla

1. 1. Define tus palabras clave y de descarte
2. 2. Conecta Google Calendar y Google Sheets
3. 3. Revisa la hoja cada semana y marca lo visto

## Cuándo usarla

Úsalo cuando te enteras de las jams buenas cuando ya han cerrado, o cuando quieres ir a por becas y convocatorias de indies y siempre llegas tarde al plazo.

## Cómo ganar dinero con ella

Una jam o convocatoria acertada al año puede traerte visibilidad o una beca de miles de euros; perder el plazo cuesta exactamente eso.

- Calendario de convocatorias para estudios indie que quieren ir a por becas y jams sin perder ningún plazo.
- Alerta diaria de jams filtradas por tecnología para desarrolladores que buscan visibilidad en su portfolio.
- Panel de convocatorias para asociaciones de videojuegos que reparten avisos a sus socios.

**Precio orientativo:** 80–200 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee las fuentes públicas de jams, filtra por tus palabras clave y por si el plazo aún está abierto, evita repetir avisos y crea un evento en tu calendario dos días antes del cierre.
Para el desarrollador indie que usa las jams como motor de ideas o de portfolio y no quiere vivir pendiente de Twitter.

## Lo que necesitas antes
Cuenta de n8n y credenciales de Google Calendar OAuth2 y Google Sheets OAuth2.
Las fuentes: `https://itch.io/jams.xml` (feed de jams de itch.io) y, si te interesa, el feed de tu asociación local o de la web de convocatorias que sigas.
Una hoja `jams` con columnas: `id`, `titulo`, `enlace`, `cierre`, `motivo`, `visto`.
Decide tus palabras clave: por ejemplo `pixel`, `narrative`, `horror`, `godot`, `spanish`, `3d`, `low poly`. Y tus palabras de descarte: `nsfw`, `crypto`, `nft`.

## Los nodos, en orden
1) **Schedule Trigger** — `0 8 * * *`, todos los días a las 8:00, zona horaria `Europe/Madrid`.
2) **RSS Read** — URL `https://itch.io/jams.xml`. Añade un segundo nodo RSS Read si sigues otra fuente y únelos con un **Merge** en modo `Append`.
3) **Google Sheets** (`Get Row(s)`) — pestaña `jams`, con `Return All` activo, para saber qué ya has visto.
4) **Code** — filtra por palabras clave, descarta lo ya visto y calcula la fecha de aviso.
5) **Google Sheets** (`Append Row`) — guarda las jams nuevas.
6) **Google Calendar** (`Create Event`) — evento de día completo con título `Cierra: {{ $json.titulo }}`, descripción con el enlace, y en Options añade un recordatorio de `2880` minutos (2 días).
7) **Gmail** (`Send`) — resumen con las jams nuevas de hoy. Si no hay ninguna, el Code no devuelve nada y no se manda correo.

## El trozo de código (nodo Code)
```javascript
const clave = ['pixel', 'narrative', 'horror', 'godot', 'spanish', '3d', 'low poly', 'jam de'];
const veto = ['nsfw', 'crypto', 'nft', 'ai only'];
const vistos = new Set($('Google Sheets').all().map(i => String(i.json.id)));
const salida = [];
for (const it of $('RSS Read').all()) {
  const j = it.json;
  const id = j.guid || j.link;
  if (!id || vistos.has(String(id))) continue;
  const texto = ((j.title || '') + ' ' + (j.contentSnippet || j.content || '')).toLowerCase();
  if (veto.some(v => texto.includes(v))) continue;
  const motivos = clave.filter(k => texto.includes(k));
  if (!motivos.length) continue;
  const m = texto.match(/(\d{4}-\d{2}-\d{2})/);
  const cierre = m ? m[1] : new Date(Date.now() + 14 * 86400000).toISOString().slice(0, 10);
  if (new Date(cierre) < new Date()) continue;
  salida.push({ json: { id, titulo: j.title, enlace: j.link, cierre, motivo: motivos.join(', '), visto: new Date().toISOString().slice(0, 10) } });
}
return salida;
```

## Cómo probarla
Ejecuta el flujo a mano. La primera vez te meterá varias jams de golpe: revisa que ninguna esté ya cerrada.
Añade una palabra clave rarísima que no salga nunca y comprueba que el flujo no devuelve nada y no crea eventos.
Mira en tu calendario que el evento tiene el recordatorio de 2 días y no de 10 minutos.

## Qué puede salir mal
Los feeds no siempre traen la fecha de cierre en un formato reconocible: por eso el código pone 14 días por defecto. Repasa esa fecha antes de comprometerte.
Zona horaria: los cierres de las jams suelen ir en UTC y a menudo a medianoche. Cuenta con un margen de un día por si acaso.
Si la fuente cambia la URL del feed, el nodo RSS falla en silencio. Activa en Settings del flujo la opción de que te envíe un correo si una ejecución da error.
Demasiadas palabras clave y te llegará ruido; empieza con cuatro o cinco muy tuyas.

## Cuánto cuesta
Gratis entero: RSS, Calendar, Sheets y Gmail no cuestan nada y n8n es gratis autoalojado (Community Edition); n8n Cloud solo tiene prueba gratuita temporal y después es de pago.
