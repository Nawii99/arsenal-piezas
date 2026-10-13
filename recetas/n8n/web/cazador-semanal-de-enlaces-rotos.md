# Cazador semanal de enlaces rotos…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Rastrea tu web cada lunes, comprueba todos los enlaces internos y externos y te manda por email solo los que devuelven error, con la página donde están.

## Qué es y qué hace

Cada lunes a las 8:00 lee tu sitemap.xml, entra en cada página, saca todos los enlaces y comprueba si responden bien. Te envía un solo correo con los enlaces rotos y la página donde está cada uno, y no escribe si no hay ninguno. Para freelances o agencias pequeñas que mantienen entre 1 y 10 webs.

## Cómo usarla

1. Comprobar que existe el sitemap
2. Crear la credencial Gmail OAuth2 en n8n
3. Montar el flujo semanal
4. Opcional: hoja Enlaces rotos para histórico

## Cuándo usarla

Úsalo cuando mantienes webs (propias o de clientes) con muchas páginas y blog, y no quieres enterarte de un 404 porque te lo diga un cliente enfadado.

## Cómo ganar dinero con ella

Sustituye una revisión manual de 2 h al mes por web y evita perder posiciones en Google por enlaces muertos. Coste 0 € si autoalojas n8n.

- Revisión semanal de enlaces para agencias que gestionan varias webs de clientes.
- Control de enlaces rotos para blogs que publican a menudo.
- Servicio de mantenimiento con informe semanal de errores de enlace.

**Precio orientativo:** 60–150 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién.** Cada lunes a las 8:00 lee tu `sitemap.xml`, entra en cada página, saca todos los enlaces y comprueba uno a uno si responden bien. Te llega un solo email con la lista de enlaces rotos y en qué página está cada uno; si no hay ninguno, no te molesta.
Pensado para freelance o agencia pequeña que mantiene entre 1 y 10 webs y quiere enterarse antes que el cliente.

**Lo que necesitas antes**
- n8n instalado (Docker en tu ordenador o un VPS de 5 €/mes) o la nube de n8n. No hace falta programar.
- Que tu web tenga sitemap: prueba `https://tudominio.com/sitemap.xml` en el navegador. Con WordPress y Yoast o RankMath ya lo tienes.
- Una cuenta de Gmail conectada en n8n: Credentials > New > Gmail OAuth2, siguiendo el asistente de Google Cloud (gratis).
- Opcional: una hoja de Google Sheets llamada `Enlaces rotos` con columnas `fecha`, `pagina`, `enlace`, `codigo`.

**Los nodos, en orden**
1. **Schedule Trigger** — Trigger Interval: Weeks, Weeks Between Triggers 1, Trigger on Weekdays: Monday, Trigger at Hour 8, Minute 0. En Settings del workflow pon Timezone `Europe/Madrid`.
2. **HTTP Request** (llámalo `Bajar sitemap`) — Method GET, URL `https://tudominio.com/sitemap.xml`, Response > Format: `Text`, Put Output in Field: `data`.
3. **Code** (`Sacar URLs`) — Mode: Run Once for All Items. Código abajo. Devuelve una fila por página.
4. **Split In Batches** (`Lotes`) — Batch Size 5. Sirve para no bombardear tu servidor.
5. **HTTP Request** (`Bajar pagina`) — Method GET, URL: expresión `{{ $json.url }}`, Response Format `Text`, campo `data`. En Settings del nodo: On Error `Continue (using error output)` y Retry On Fail activado, Max Tries 3, Wait Between Tries 2000.
6. **Code** (`Sacar enlaces`) — Mode: Run Once for All Items. Código abajo. Devuelve enlace + página de origen, sin duplicados.
7. **HTTP Request** (`Comprobar enlace`) — Method HEAD, URL `{{ $json.enlace }}`, Options > Response > Include Response Status Code: activado, Never Error: activado, Full Response: activado. Timeout 10000 ms.
8. **IF** (`Esta roto?`) — Condition: Number, valor 1 `{{ $json.statusCode }}`, operación `larger or equal`, valor 2 `400`. Rama true sigue.
9. **Google Sheets** (`Registrar`) — Operation: Append Row. Mapea `fecha` = `{{ $now.format('yyyy-LL-dd') }}`, `pagina` = `{{ $json.origen }}`, `enlace` = `{{ $json.enlace }}`, `codigo` = `{{ $json.statusCode }}`.
10. **Code** (`Montar email`) — junta todo en una tabla HTML (código abajo).
11. **IF** (`Hay algo?`) — String: `{{ $json.total }}` `is not equal to` `0`.
12. **Gmail** — Resource Message, Operation Send. To: tu correo. Subject `Enlaces rotos en tudominio.com ({{ $json.total }})`. Message: `{{ $json.html }}`, Options > Email Type: HTML.

**El código del nodo `Sacar URLs`**
```js
const xml = $input.first().json.data || '';
const urls = [...xml.matchAll(/<loc>(.*?)<\/loc>/g)].map(m => m[1].trim());
const unicas = [...new Set(urls)].filter(u => !u.endsWith('.xml'));
return unicas.slice(0, 100).map(u => ({ json: { url: u } }));
```

**El código del nodo `Sacar enlaces`**
```js
const salida = [];
const vistos = new Set();
for (const item of $input.all()) {
  const html = item.json.data || '';
  const base = item.json.url || $('Bajar pagina').first().json.url;
  for (const m of html.matchAll(/href="([^"]+)"/g)) {
    let h = m[1].split('#')[0].trim();
    if (!h || h.startsWith('mailto:') || h.startsWith('tel:') || h.startsWith('javascript:')) continue;
    try { h = new URL(h, base).href; } catch (e) { continue; }
    if (!h.startsWith('http')) continue;
    if (vistos.has(h)) continue;
    vistos.add(h);
    salida.push({ json: { enlace: h, origen: base } });
  }
}
return salida;
```

**El código del nodo `Montar email`**
```js
const filas = $input.all().map(i => i.json);
const html = filas.length === 0 ? '' : '<table border=1 cellpadding=6><tr><th>Enlace roto</th><th>Codigo</th><th>Esta en</th></tr>' + filas.map(f => `<tr><td>${f.enlace}</td><td>${f.statusCode}</td><td>${f.origen}</td></tr>`).join('') + '</table>';
return [{ json: { total: filas.length, html } }];
```

**Cómo probarla**
- Pulsa `Execute Workflow` a mano y mira la salida del nodo `Sacar URLs`: si sale vacío, tu sitemap es un índice de sitemaps y tienes que apuntar al hijo, por ejemplo `post-sitemap.xml`.
- Crea en un borrador de tu web un enlace inventado a `https://tudominio.com/pagina-que-no-existe` y comprueba que aparece en el email.
- Deja el Schedule Trigger desactivado hasta que dos ejecuciones manuales seguidas te den el mismo resultado.

**Qué puede salir mal**
- Muchas webs bloquean el método HEAD y devuelven 405. Si te salen muchos 405 falsos, cambia el método a GET y en Options activa Response > Never Error igualmente.
- Enlaces a LinkedIn, Amazon o Instagram devuelven 403 aunque funcionen: añade en el nodo IF una segunda condición `{{ $json.enlace }}` `does not contain` `linkedin.com` o filtra esos dominios en el Code.
- Si tu hosting es compartido, bajar 100 páginas seguidas puede tumbarte la web. Sube el Batch Size a 3 y añade un nodo **Wait** de 2 segundos dentro del bucle.
- Zona horaria: si el email llega a las 10:00 en vez de a las 8:00, no has puesto `Europe/Madrid` en Settings del workflow.

**Cuánto cuesta**
- n8n autoalojado: gratis (te vale un VPS de 5 €/mes que además usarás para las demás recetas).
- Gmail y Google Sheets: gratis con tu cuenta normal.
- n8n Cloud: desde unos 20 €/mes; esta receta consume 1 ejecución por semana y web.
