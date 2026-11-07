# Detector de copias piratas de tus assets 3D…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Busca cada semana el nombre de tus modelos y de tu marca por internet, descarta tus propias tiendas y te avisa si aparecen en sitios de descarga gratuita.

## Qué es y qué hace

Flujo de n8n que busca cada semana, con la API de Custom Search de Google, los nombres exactos de tus modelos y de tu marca. Descarta tus propias tiendas, guarda los resultados nuevos en una hoja y te los envía por correo con una plantilla de reclamación. Entran la lista de productos y tu buscador personalizado; sale un registro de posibles copias. Requiere una clave de Google y un buscador configurado para toda la web.

## Cómo usarla

1. 1. Crea la clave de Custom Search y tu buscador (cx)
2. 2. Escribe los nombres exactos de tus productos
3. 3. Revisa los hallazgos y reclama si procede
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando vendes modelos o packs 3D y sospechas que circulan por webs de descargas, foros o canales de Telegram sin que te enteres.

## Cómo ganar dinero con ella

Cada retirada por copyright recupera ventas que estabas perdiendo; encontrarlo tú a mano es imposible y contratar un servicio cuesta cientos al mes.

- Vigilancia de copias para artistas 3D que venden packs en tienda propia y en marketplaces.
- Búsqueda semanal de uso no autorizado para estudios que licencian props a otros juegos.
- Plantillas de reclamación por copyright para creadores que quieren defender su catálogo sin abogado en cada caso.

**Precio orientativo:** 100–250 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Toma la lista de nombres de tus productos, los busca con la API de búsqueda de Google, filtra los resultados que ya conoces (tus tiendas) y te manda los sospechosos con una plantilla de reclamación lista.
Para el artista 3D o el estudio que vende packs y quiere defender su trabajo sin dedicarle una tarde a la semana.

## Lo que necesitas antes
Una clave de la API de Google Custom Search: en `console.cloud.google.com` activa `Custom Search API` y crea una clave.
Un buscador personalizado: en `programmablesearchengine.google.com` crea uno con la opción «buscar en toda la web» activada y copia el ID (`cx`).
Credenciales de Google Sheets OAuth2 y Gmail OAuth2 en n8n.
Una hoja con dos pestañas. `productos`: columna `nombre` con el título exacto de cada modelo o pack y una columna `activo`. `hallazgos`: `fecha`, `producto`, `titulo`, `url`, `dominio`, `estado`.
Una lista blanca con tus dominios legítimos: tu web, `fab.com`, `cgtrader.com`, `sketchfab.com`, `artstation.com`, `gumroad.com`.

## Los nodos, en orden
1) **Schedule Trigger** — `0 7 * * 1` (lunes a las 7:00).
2) **Google Sheets** (`Get Row(s)`) — pestaña `productos`, filtrando `activo` igual a `si`.
3) **Split In Batches** — tamaño 1, para respetar la cuota de la API.
4) **HTTP Request** — GET a `https://www.googleapis.com/customsearch/v1?cx=TU_CX&num=10&q="{{ $json.nombre }}" (free OR download OR torrent OR gratis)`. Autenticación con Authentication: Generic > Query Auth con una credencial de n8n (Name `key`, Value tu clave). Activa `Never Error` en Options. No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él.
5) **Wait** — 2 segundos, para no saturar la cuota.
6) **Google Sheets** (`Get Row(s)`) — pestaña `hallazgos`, para no repetir avisos.
7) **Code** — filtra la lista blanca y los duplicados.
8) **Google Sheets** (`Append Row`) — guarda los hallazgos nuevos.
9) **IF** — comprueba que hay algo nuevo.
10) **Gmail** (`Send`) — resumen con enlaces y la plantilla de reclamación.
11) Conecta de vuelta al **Split In Batches**.

## El trozo de código (nodo Code)
```javascript
const blanca = ['tuweb.com', 'fab.com', 'cgtrader.com', 'sketchfab.com', 'artstation.com', 'gumroad.com', 'unity.com', 'youtube.com'];
const sospechosas = ['free', 'download', 'torrent', 'gratis', 'crack', 'nulled', 'descargar', 'mega.nz', 'telegram'];
const vistos = new Set($('Google Sheets1').all().map(i => String(i.json.url)));
const producto = $('Split In Batches').first().json.nombre;
const items = $('HTTP Request').first().json.items || [];
const salida = [];
for (const r of items) {
  let dominio = '';
  try { dominio = new URL(r.link).hostname.replace(/^www\./, ''); } catch (e) { continue; }
  if (blanca.some(b => dominio.endsWith(b))) continue;
  if (vistos.has(r.link)) continue;
  const texto = ((r.title || '') + ' ' + (r.snippet || '') + ' ' + r.link).toLowerCase();
  if (!sospechosas.some(s => texto.includes(s))) continue;
  salida.push({ json: {
    fecha: new Date().toISOString().slice(0, 10),
    producto,
    titulo: (r.title || '').slice(0, 200),
    url: r.link,
    dominio,
    estado: 'por revisar'
  }});
}
return salida;
```

## Cómo probarla
Añade a la hoja el nombre de un pack conocido de otro autor que sepas que circula pirateado: si el flujo lo encuentra, funciona.
Comprueba que tu propia ficha en Fab o CGTrader NO aparece en los hallazgos: si aparece, te falta ese dominio en la lista blanca.
Ejecuta dos lunes seguidos y verifica que no te repite las mismas URL.

## Qué puede salir mal
La API de búsqueda de Google da 100 consultas gratis al día y luego cobra unos 5 dólares por cada 1.000. Con 20 productos semanales ni te acercas al límite.
Muchos falsos positivos si tus modelos tienen nombres genéricos tipo «silla de madera»: usa nombres de producto únicos y ponlos entre comillas, como ya hace la consulta.
No todo lo que encuentres es ilegal: puede ser una reseña, un vídeo o una mención legítima. Por eso el estado es `por revisar` y decides tú.
Antes de mandar una reclamación por copyright, ten claro que tienes los derechos y no uses plantillas agresivas: una reclamación falsa puede volverse contra ti.
La retirada se pide al hosting o a Google (`google.com/webmasters/tools/legal-removal-request`), no al que sube el archivo.

## Cuánto cuesta
n8n autoalojado (Community Edition), Sheets y Gmail: gratis; n8n Cloud tiene una prueba gratuita temporal y después planes de pago.
Google Custom Search: gratis hasta 100 consultas al día. Un catálogo de 50 productos revisado semanalmente sale a coste cero.
