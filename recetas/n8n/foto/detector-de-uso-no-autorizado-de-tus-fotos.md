# Detector de uso no autorizado de tus fotos…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Cada semana busca tus imágenes por internet con búsqueda inversa y te avisa por email si aparecen en webs que no son la tuya ni la de tus clientes.

## Qué es y qué hace

Toma una lista de URLs de tus fotos publicadas, hace una búsqueda inversa con Google Lens a través de SerpApi y compara los dominios donde aparecen con tu lista blanca de web, clientes y redes. Cada dominio no autorizado llega a un correo semanal con su enlace, para decidir si reclamas. Entran URLs de imágenes y salen avisos por dominio, con n8n, SerpApi y Google Sheets.

## Cómo usarla

1. Crea las pestañas de fotos, permitidos y hallazgos
2. Consigue la clave de SerpApi
3. Configura el correo semanal en n8n
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando publiques fotos en abierto (web, Instagram, portfolio) y sospeches que empresas las están usando sin pagar, o si vives de licencias de imagen.

## Cómo ganar dinero con ella

Una reclamación amistosa por uso indebido se cierra habitualmente entre 300 y 1.500 €. Encontrar dos al año paga el sistema mil veces.

- Vigilancia de uso no autorizado para fotógrafos que publican en abierto, cobrada por mes.
- Informe de hallazgos y primer borrador de reclamación para licencias de imagen, cobrado por caso.
- Plantilla de vigilancia vendida a ilustradores y creadores con un catálogo público grande.

**Precio orientativo:** 60–150 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Toma una lista de URLs de tus fotos publicadas, hace una búsqueda inversa de imagen en Google Lens a través de SerpApi y compara los dominios donde aparecen con tu lista blanca (tu web, tus clientes, tus redes).
Todo dominio que no esté en la lista blanca acaba en un email semanal con el enlace, para que decides si reclamas. Es para fotógrafos y creadores de imagen que licencian su trabajo.

## Lo que necesitas antes
- Cuenta en serpapi.com. El plan gratuito da 100 búsquedas al mes, suficiente para vigilar 25 fotos semanalmente. Copia tu API Key desde el panel «Your Account».
- Una hoja de Google Sheets con dos pestañas. Pestaña `fotos`: columnas `titulo` y `url_imagen` (la URL pública y directa del JPG, no la de la página). Pestaña `permitidos`: una columna `dominio` con tu web, tus perfiles y los dominios de clientes con licencia.
- Otra pestaña `hallazgos` con columnas `fecha`, `titulo`, `dominio`, `url_pagina` para no repetir avisos.
- Credencial de Gmail en n8n («Gmail OAuth2») y las de Google Sheets.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: `Weeks`, día `Monday`, hora `8`. Una vez por semana basta y no gastas la cuota gratuita.
2. **Google Sheets** (renómbralo «Leer fotos») — Operation: `Get Row(s)`, pestaña `fotos`.
3. **Google Sheets** (renómbralo «Leer permitidos») — Operation: `Get Row(s)`, pestaña `permitidos`. Conéctalo también desde el Schedule Trigger.
4. **Split In Batches** — Batch Size: `1`. Así vas foto a foto y controlas el gasto de la API.
5. **HTTP Request** — Method: `GET`, URL: `https://serpapi.com/search.json`. En Query Parameters añade: `engine` = `google_lens`, `url` = `{{ $json.url_imagen }}`, `api_key` = tu clave (mejor guárdala en Credentials tipo «Header Auth» o en una variable). En Options activa `Retry On Fail` con 3 intentos y espera de 5000 ms.
6. **Code** — Mode: `Run Once for Each Item`. Filtra los resultados contra la lista blanca (código abajo).
7. **IF** — condición Number: `{{ $json.sospechosos.length }}` mayor que `0`. La rama `true` va al siguiente nodo; la `false` vuelve al **Split In Batches**.
8. **Google Sheets** — Operation: `Append Row` en la pestaña `hallazgos`. Después conéctalo de vuelta al **Split In Batches** para que siga con la siguiente foto.
9. **Gmail** (colgando de la salida «done» del Split In Batches) — Operation: `Send`, To: tu correo, Subject: `Posibles usos sin permiso de tus fotos`, Message: el resumen que arma el nodo Code final.

## El código del nodo Code
```javascript
const permitidos = $('Leer permitidos').all().map(i => String(i.json.dominio || '').toLowerCase().trim()).filter(Boolean);
const resultados = $json.visual_matches || [];
const sospechosos = [];
for (const r of resultados) {
  let dominio = '';
  try { dominio = new URL(r.link).hostname.replace(/^www\./, '').toLowerCase(); } catch (e) { continue; }
  const esPermitido = permitidos.some(p => dominio === p || dominio.endsWith('.' + p));
  if (!esPermitido) sospechosos.push({ dominio, url_pagina: r.link, titulo_pagina: r.title || '' });
}
const vistos = new Set();
const unicos = sospechosos.filter(s => { if (vistos.has(s.dominio)) return false; vistos.add(s.dominio); return true; });
return { json: { titulo: $('Split In Batches').item.json.titulo, fecha: new Date().toISOString().slice(0, 10), sospechosos: unicos } };
```

## Cómo probarla
- Empieza con DOS fotos en la pestaña `fotos` y ejecuta a mano con «Test workflow».
- Prueba a propósito con una foto tuya que sí esté publicada en tu web: debe salir tu dominio y quedar filtrado por la lista blanca. Si aparece en `hallazgos`, es que escribiste mal el dominio (sin `https://`, sin `www.`, solo `miweb.com`).
- Comprueba que la URL de la imagen es directa: pégala en una pestaña del navegador y tiene que verse la foto sola, sin la web alrededor.

## Qué puede salir mal
- **Cuota agotada**: 100 búsquedas al mes en el plan gratis. Con 25 fotos semanales vas justo. Si necesitas más, el plan de pago arranca en unos 70 € al mes; alternativa: vigila solo tus 10 fotos más valiosas.
- **Falsos positivos**: agregadores, Pinterest y webs de recopilación aparecen siempre. Métete esos dominios en `permitidos` en cuanto los veas la primera semana.
- **Google Lens no encuentra nada**: normal si la foto está muy recortada o con filtro. La búsqueda inversa detecta copias razonablemente fieles, no reencuadres agresivos.
- **Avisos repetidos**: antes del `Append Row` puedes añadir un **Google Sheets** de lectura de `hallazgos` y un **IF** que descarte los dominios ya registrados.
- **Reintentos**: SerpApi devuelve error 429 si vas muy rápido. Con Batch Size 1 y el Retry activado no deberías verlo; si aparece, añade un nodo **Wait** de 2 segundos dentro del bucle.

## Cuánto cuesta
- SerpApi: gratis hasta 100 búsquedas al mes.
- Gmail y Sheets: gratis.
- n8n auto-alojado: gratis. Total: 0 € al mes en la versión de vigilancia básica.
