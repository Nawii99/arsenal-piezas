# Rastreador semanal de enlaces rotos…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Recorre todas las páginas de tu web siguiendo tu sitemap, prueba cada enlace y te deja en una hoja de cálculo los que dan error 404 o 500.

## Qué es y qué hace

Cada domingo lee tu sitemap.xml, descarga cada página, extrae todos los enlaces sin duplicados y los comprueba uno a uno. Los que responden 404 o 500 se apuntan en Google Sheets con la página donde aparecen. Entrada: URL del sitemap; salida: hoja de enlaces rotos. Se monta en n8n con nodos HTTP Request y Code.

## Cómo usarla

1. Localiza el sitemap de tu web
2. Crea la hoja Enlaces rotos
3. Configura el cron de los lunes a las 3:00
4. Revisa el primer informe a mano

## Cuándo usarla

Cuando llevas tiempo publicando, has cambiado URLs o borrado productos, y sospechas que hay enlaces muertos que no encuentras a mano.

## Cómo ganar dinero con ella

Cada enlace roto es una visita perdida y una penalización en Google. Revisar 200 páginas a mano son 4 horas; esto lo hace cada domingo por la noche.

- Auditoría de enlaces rotos para una web de servicios con más de cien páginas.
- Revisión semanal de enlaces para una tienda online tras cambios de catálogo.
- Mantenimiento técnico mensual de webs de autónomos con informe de errores.

**Precio orientativo:** 80–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee tu sitemap.xml, descarga cada página, saca todos los enlaces, quita duplicados y comprueba uno a uno si responden.
Los rotos se apuntan en una hoja de Google con la página donde estaban, para que sepas dónde ir a arreglarlo.

## Lo que necesitas antes
- La URL de tu sitemap, casi siempre `https://tunegocio.es/sitemap.xml` o `/sitemap_index.xml` (WordPress con Yoast o Rank Math lo genera solo).
- Una hoja de Google nueva llamada «Enlaces rotos» con las columnas: `fecha`, `pagina_origen`, `enlace_roto`, `codigo`.
- Credencial de Google Sheets en n8n: en *Credentials > New > Google Sheets OAuth2*, sigue el asistente y da permiso con tu cuenta de Google.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 3 * * 1` (los lunes a las 3 de la mañana). En *Settings* del workflow pon `Timezone` = `Europe/Madrid`.
2. **HTTP Request** (nómbralo «Bajar sitemap») — GET a tu sitemap. En *Options > Response > Response Format* elige `Text`.
3. **Code** («Sacar URLs») — extrae las URLs del XML.
4. **Split In Batches** — *Batch Size* = 1. Este nodo va sirviendo las páginas de una en una para no reventar tu servidor.
5. **HTTP Request** («Bajar página») — GET a `{{ $json.url }}`, *Response Format* `Text`, *Never Error* ON, *Timeout* 15000.
6. **Code** («Sacar enlaces») — saca los href de esa página.
7. **HTTP Request** («Probar enlace») — GET a `{{ $json.enlace }}`, *Never Error* ON, *Include Response Status Code* ON, *Timeout* 10000. En *Settings* del nodo activa *Always Output Data* y pon *Retry On Fail* = ON con 2 intentos.
8. **IF** — *Number*: `{{ $json.statusCode }}` **larger or equal** `400`.
9. **Google Sheets** (rama true) — operación *Append Row*, tu hoja «Enlaces rotos», columnas mapeadas a los campos.
10. Conecta la salida del nodo 9 (y la rama false del IF) de vuelta a **Split In Batches** para que siga con la página siguiente.
11. **Gmail** — al terminar el bucle (salida *done* del Split In Batches), *Send Message* a tu correo con el asunto «Enlaces rotos de la semana» y el enlace a la hoja.

## El código del nodo «Sacar URLs»
```javascript
const xml = $input.first().json.data || $input.first().json.body || '';
const urls = [...xml.matchAll(/<loc>(.*?)<\/loc>/g)].map(m => m[1].trim());
const unicas = [...new Set(urls)].filter(u => !u.endsWith('.xml'));
return unicas.slice(0, 200).map(url => ({ json: { url } }));
```

## El código del nodo «Sacar enlaces»
```javascript
const html = $json.data || $json.body || '';
const origen = $('Split In Batches').first().json.url;
const dominio = new URL(origen).origin;
const hrefs = [...html.matchAll(/href=["']([^"'#]+)["']/g)].map(m => m[1]);
const limpios = [...new Set(hrefs)]
  .filter(h => !h.startsWith('mailto:') && !h.startsWith('tel:') && !h.startsWith('javascript:'))
  .map(h => h.startsWith('http') ? h : dominio + (h.startsWith('/') ? h : '/' + h));
return limpios.map(enlace => ({ json: { enlace, pagina_origen: origen, fecha: new Date().toISOString().slice(0,10) } }));
```

## Cómo probarla
- Primero limita el sitemap a 3 páginas: cambia `.slice(0, 200)` por `.slice(0, 3)` y ejecuta con *Test workflow*.
- Mete a propósito un enlace inventado en una de tus páginas, tipo `/esto-no-existe`, y comprueba que aparece en la hoja con código 404.
- Cuando funcione, sube el slice otra vez a 200 y activa el workflow.

## Qué puede salir mal
- **Tarda muchísimo**: es normal, una web de 100 páginas con 30 enlaces cada una son 3.000 peticiones. Por eso va de madrugada y con Split In Batches. Si se corta, baja el slice a 50 páginas y haz dos ejecuciones semanales.
- **Falsos positivos con 403**: LinkedIn, Amazon o Instagram bloquean a los bots y devuelven 403 o 429 aunque el enlace esté bien. Filtra en el IF solo `404` y `500` si te molesta el ruido.
- **Duplicados en la hoja**: cada semana se vuelve a apuntar todo. Añade la fecha (ya está) y filtra en la hoja por la última fecha, o borra el contenido cada lunes con un nodo Google Sheets *Clear* antes de empezar.
- **Tu propio hosting te corta** por exceso de peticiones: añade un nodo **Wait** de 1 segundo dentro del bucle.

## Cuánto cuesta
- Gratis entero: n8n auto-alojado, Google Sheets y Gmail están en el plan gratuito de Google.
- Google Sheets tiene un límite generoso (300 peticiones por minuto por usuario) que no vas a tocar con una ejecución semanal.
- En Make o Zapier esta receta gastaría miles de operaciones por ejecución: no es viable en sus planes gratuitos.
