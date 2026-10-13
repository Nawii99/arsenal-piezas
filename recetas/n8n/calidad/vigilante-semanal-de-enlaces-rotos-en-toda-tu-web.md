# Vigilante semanal de enlaces rotos en toda tu web…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Recorre el sitemap de tu web cada semana, entra en cada página, prueba todos sus enlaces y te manda por email la lista de los que dan error.

## Qué es y qué hace

Flujo de n8n que cada semana descarga el sitemap de tu web, visita cada página, extrae todos sus enlaces y comprueba si responden. Entra la URL del sitemap y una hoja de Google Sheets llamada Enlaces rotos; sale una lista de enlaces con error por página de origen, enviada por email. Útil en webs o blogs con muchas páginas, productos retirados o contenido antiguo.

## Cómo usarla

1. Comprueba que el sitemap carga y muestra las etiquetas loc
2. Crea la hoja Enlaces rotos
3. Limita la velocidad de las peticiones
4. Prueba con 20 páginas antes de activarlo

## Cuándo usarla

Úsalo cuando tengas una web o blog con más de 20 páginas y sospeches que hay enlaces caídos, productos retirados o páginas antiguas que están tirando ventas y posiciones a la basura.

## Cómo ganar dinero con ella

Evita perder clientes y posiciones en Google por páginas muertas. Sustituye una auditoría SEO de 150-300 € y las horas de ir clicando enlace a enlace.

- Auditoría semanal de enlaces rotos para tiendas online con cientos de fichas de producto.
- Mantenimiento técnico mensual de webs corporativas, con informe de páginas caídas a corregir.
- Revisión de enlaces de un blog antes de una campaña de SEO, entregada como lista de arreglos.

**Precio orientativo:** 120–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**: cada lunes por la mañana descarga tu sitemap, visita cada página, saca todos los enlaces y comprueba uno a uno si responden bien. Es para cualquiera con web propia, blog o tienda que no quiera pagar auditorías periódicas.
**Para quién no es**: si tu web tiene 5 páginas, lo compruebas antes a mano.

### Lo que necesitas antes
- **n8n**: plan gratuito en n8n.cloud (te da unas 2.500 ejecuciones al mes en la prueba) o auto-alojado con Docker en tu ordenador o en un VPS de 5 €/mes (Hetzner, Contabo). Gratis para siempre si te lo auto-alojas.
- **La URL de tu sitemap**: normalmente `tudominio.com/sitemap.xml` o `sitemap_index.xml`. Ábrela en el navegador antes de empezar y confirma que carga y que ves etiquetas `<loc>`.
- **Google Sheets**: crea una hoja llamada «Enlaces rotos» con la pestaña `registro` y las columnas en la fila 1: `fecha`, `pagina_origen`, `enlace_roto`, `codigo`.
- **Credenciales en n8n**: Credentials > New > «Google Sheets OAuth2 API» y «Gmail OAuth2 API». n8n te lleva paso a paso a la pantalla de Google; autorizas con tu propia cuenta. No cuesta nada.

### Los nodos, en orden
**1. Schedule Trigger** — Trigger Rules: Weeks, Weeks Between Triggers 1, Trigger on Weekdays: Monday, Trigger at Hour: 6, Minute: 0. Importante: entra en Workflow Settings (arriba a la derecha, los tres puntos) y pon Timezone: `Europe/Madrid`, si no te disparará una hora tarde en verano.
**2. HTTP Request** (renómbralo «Bajar sitemap») — Method: GET. URL: `https://tudominio.com/sitemap.xml`. Options > Response > Response Format: `Text`.
**3. XML** — Mode: `XML to JSON`. Property Name: `data`.
**4. Code** (llámalo «Sacar URLs») — Mode: `Run Once for All Items`. Pega esto:
```js
const raiz = $input.first().json.data;
const nodos = raiz.urlset && raiz.urlset.url ? raiz.urlset.url : [];
const lista = Array.isArray(nodos) ? nodos : [nodos];
const salida = [];
for (const n of lista) {
  const url = typeof n.loc === 'string' ? n.loc : (n.loc && n.loc._);
  if (url) salida.push({ json: { url } });
}
return salida.slice(0, 150);
```
**5. Loop Over Items** (el nodo que antes se llamaba «Split In Batches») — Batch Size: `3`. Así no machacas tu propio servidor ni te banea tu hosting.
**6. HTTP Request** («Bajar página»), colgando de la salida `loop` — Method: GET. URL: `{{ $json.url }}`. Options > Response > Response Format: `Text`, Never Error: activado, Timeout: `15000`. En la pestaña Settings del nodo marca «Always Output Data».
**7. Code** («Extraer enlaces») — Mode: `Run Once for All Items`:
```js
const html = $json.data || '';
const origen = $('Loop Over Items').first().json.url;
const base = new URL(origen);
const brutos = [...html.matchAll(/href="([^"#]+)"/g)].map(m => m[1]);
const salida = [];
for (const href of brutos) {
  if (/^(mailto:|tel:|javascript:|#)/i.test(href)) continue;
  try { salida.push({ json: { origen, enlace: new URL(href, base).toString() } }); } catch (e) {}
}
return salida;
```
**8. Remove Duplicates** — Operation: `Remove Items Repeated Within Current Input`, Compare: `Selected Fields`, Fields To Compare: `enlace`.
**9. HTTP Request** («Probar enlace») — Method: `HEAD`. URL: `{{ $json.enlace }}`. Options: Never Error activado, Full Response activado, Redirects > Follow Redirects activado, Timeout `10000`. En Settings del nodo: Retry On Fail activado, Max Tries `2`, Wait Between Tries `3000`.
**10. IF** — Condition tipo Number: valor izquierdo `{{ $json.statusCode }}`, operación `is greater than or equal`, valor derecho `400`. Por la rama `true` van los rotos.
**11. Google Sheets** (rama true) — Resource: Sheet Within Document, Operation: `Append Row`. Document: tu hoja «Enlaces rotos», Sheet: `registro`. Mapping Column Mode: Map Each Column Manually. `fecha`: `{{ $now.format('dd/MM/yyyy') }}`, `pagina_origen`: `{{ $('Extraer enlaces').item.json.origen }}`, `enlace_roto`: `{{ $('Extraer enlaces').item.json.enlace }}`, `codigo`: `{{ $json.statusCode }}`.
**12. Conecta la salida del nodo 11 de vuelta a la entrada del Loop Over Items** para que siga con la página siguiente. De la salida `done` del Loop cuelga el último nodo.
**13. Gmail** («Aviso») colgando de `done` — Operation: `Send`. To: tu correo. Subject: `Enlaces rotos - {{ $now.format('dd/MM/yyyy') }}`. Email Type: Text. Message: `Revisión terminada. Mira la hoja Enlaces rotos: https://docs.google.com/... (pega tu enlace)`.

### Cómo probarla antes de dejarla suelta
- Cambia el `slice(0, 150)` por `slice(0, 3)` en el nodo Code y dale a «Test workflow». Debe tardar menos de un minuto.
- Crea a propósito una página de prueba con un enlace a `https://tudominio.com/esto-no-existe-123` y comprueba que aparece en la hoja con código 404.
- Mira la salida del nodo XML: si ves `sitemapindex` en vez de `urlset`, tu sitemap es un índice de sitemaps; apunta el nodo 2 al sitemap hijo (por ejemplo `post-sitemap.xml`) o duplica los pasos 2-4 para bajar primero el índice.

### Qué puede salir mal
- **Te bloquea tu propio hosting o Cloudflare** por hacer muchas peticiones: baja Batch Size a 1 y añade un nodo **Wait** de 2 segundos dentro del bucle.
- **Falsos positivos con 403 o 405**: hay webs (Amazon, LinkedIn, Facebook) que rechazan peticiones HEAD automáticas. Añade en el IF una segunda condición que descarte esos dominios, o filtra por `{{ $json.statusCode }}` distinto de 403 y 405.
- **Enlaces duplicados repetidos cada semana**: el mismo roto saldrá cada lunes hasta que lo arregles. Es lo correcto, pero si te molesta añade un **Remove Duplicates** en modo `Remove Items Seen In Previous Executions` con la clave `enlace`.
- **Timeouts en n8n cloud**: si tienes más de 150 páginas, parte el trabajo en dos workflows (uno para el blog, otro para el catálogo) en días distintos.

### Cuánto cuesta
- n8n auto-alojado: **0 €** (más los 5 €/mes del VPS si no lo dejas en tu ordenador). n8n cloud: gratis en la prueba, luego desde unos 20 €/mes.
- Google Sheets y Gmail: **0 €** con cuenta normal.
- Total realista: **0 €/mes** auto-alojado.
